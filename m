Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD91C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 03:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOqq0-0001TT-1B; Tue, 02 Jul 2024 23:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongzhihai@eswincomputing.com>)
 id 1sOqpw-0001Sc-Pn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 23:39:16 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dongzhihai@eswincomputing.com>) id 1sOqpu-0001QW-D7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 23:39:16 -0400
Received: from E0005117DT.eswin.cn (unknown [10.64.112.170])
 by app2 (Coremail) with SMTP id TQJkCgAXKbvVx4RmaHkTAA--.49688S4;
 Wed, 03 Jul 2024 11:39:03 +0800 (CST)
From: Zhihai Dong <dongzhihai@eswincomputing.com>
To: qemu-devel@nongnu.org
Cc: dongzhihai@eswincomputing.com
Subject: [PATCH] README.rst: add the missing punctuations
Date: Wed,  3 Jul 2024 11:39:01 +0800
Message-Id: <20240703033901.1017-1-dongzhihai@eswincomputing.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: TQJkCgAXKbvVx4RmaHkTAA--.49688S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrXr4fGrW7tFyxXr1DWrg_yoW8Jr1kpr
 Zxu345u3s2vF13J3yrWa1UZw1FgrZ5XF42qw12gw47JF1Sv3Z2g3ZYyr42ya4UXa9a9rW5
 JF10vr1vqa4UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk214x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: pgrqw65klktx46hv4xpqfrz1xxwl0woofrz/
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=dongzhihai@eswincomputing.com;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make the README more clearly.

Signed-off-by: Zhihai Dong <dongzhihai@eswincomputing.com>
---
 README.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.rst b/README.rst
index 21df79ef43..b120a1f69e 100644
--- a/README.rst
+++ b/README.rst
@@ -82,7 +82,7 @@ guidelines set out in the `style section
 the Developers Guide.
 
 Additional information on submitting patches can be found online via
-the QEMU website
+the QEMU website:
 
 * `<https://wiki.qemu.org/Contribute/SubmitAPatch>`_
 * `<https://wiki.qemu.org/Contribute/TrivialPatches>`_
@@ -102,7 +102,7 @@ requires a working 'git send-email' setup, and by default doesn't
 automate everything, so you may want to go through the above steps
 manually for once.
 
-For installation instructions, please go to
+For installation instructions, please go to:
 
 *  `<https://github.com/stefanha/git-publish>`_
 
@@ -159,7 +159,7 @@ Contact
 =======
 
 The QEMU community can be contacted in a number of ways, with the two
-main methods being email and IRC
+main methods being email and IRC:
 
 * `<mailto:qemu-devel@nongnu.org>`_
 * `<https://lists.nongnu.org/mailman/listinfo/qemu-devel>`_
-- 
2.34.1


