import numpy as np


class TreeNode(object):

    def __init__(self, prior_prob, parent=None):
        self.parent = parent
        self.children = {}  # key=action, value=TreeNode
        self.reward = 0  # 该节点的奖励。 Total simulation reward of the node.
        self.visited_times = 0  # 该节点访问的次数。 Total number of visits of the node.
        self.prior_prob = prior_prob  # 父节点选到此节点的概率。 prior probability of the move.

    def is_root(self):
        """
        节点是否根节点。
        Whether the node is the root node.
        :return: <Bool>
        """
        return self.parent is None

    def expand(self, action, probability):
        """
        扩展节点。
        Expand node.
        :param action: 选择的扩展动作。 Selected extended action.
        :param probability: 父节点选到此动作的概率。 prior probability of the move.
        :return: <TreeNode> 扩展出的节点
        """
        # 如果已经扩展过了（一般不可能）。 If it has been extended (generally impossible).
        if action in self.children:
            return self.children[action]

        child_node = TreeNode(prior_prob=probability,
                              parent=self)
        self.children[action] = child_node

        return child_node

    def UCT_function(self, c=5.0):
        greedy = c * self.prior_prob * np.sqrt(self.parent.visited_times) / (1 + self.visited_times)
        if self.visited_times == 0:
            return greedy
        return self.reward / self.visited_times + greedy

    def choose_best_child(self, c=5.0):
        """
        依据 UCT 函数，选择一个最佳的子节点。
        According to the UCT function, select an optimal child node.
        :param c: 贪婪值。 greedy value.
        :return: <(action(x_axis, y_axis), TreeNode)> 最佳的子节点。 An optimal child node.
        """
        return max(self.children.items(), key=lambda child_node: child_node[1].UCT_function(c))

    def backpropagate(self, value):
        """
        反向传输，将结果返回父节点。
        Backpropagate, passing the result to the parent node.
        :param value: 反向传输的值。 The value to be backpropagated.
        """
        self.visited_times += 1
        self.reward += value

        if not self.is_root():
            self.parent.backpropagate(-value)
