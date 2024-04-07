Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488F1CD128A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 08:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtO1K-0006NN-M8; Sun, 07 Apr 2024 04:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1rtO1C-0006Mk-1Y
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 04:36:53 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1rtO18-0004xO-Ri
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 04:36:49 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXH0cXWxJmXvRPEQ--.49163S2;
 Sun, 07 Apr 2024 16:36:39 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwB3r9QMWxJmQu8BAA--.2488S4;
 Sun, 07 Apr 2024 16:36:34 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: peter.maydell@linaro.org,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, chenbaozi@phytium.com.cn,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] qemu-options.hx: Fix typo for interleave-granularity of
 CFMW
Date: Sun,  7 Apr 2024 16:35:39 +0800
Message-Id: <20240407083539.1488172-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407083539.1488172-1-wangyuquan1236@phytium.com.cn>
References: <20240407083539.1488172-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3r9QMWxJmQu8BAA--.2488S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWYRo98FIgAAsk
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKw45Kw1xWF4rtr48tF4UXFb_yoWkGFg_WF
 95JwsYqrWxZa4UG3WIvanrJr98X34rGwn7Wa1jqayqkr4rXw45JryvgFyxWrnxWa18Ar1S
 krnrXwn5C34xZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This patch fixes the unit typo of interleave-granularity of
CXL Fixed Memory Window in qemu-option.hx.

Signed-off-by: Yuquan Wang wangyuquan1236@phytium.com.cn
---
 qemu-options.hx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7fd1713fa8..e1b272d51a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -151,14 +151,14 @@ SRST
         platform and configuration dependent.
 
         ``interleave-granularity=granularity`` sets the granularity of
-        interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
-        4096KiB, 8192KiB and 16384KiB granularities supported.
+        interleave. Default 256(bytes). Only 256, 512, 1k, 2k
+        4k, 8k and 16k granularities supported.
 
         Example:
 
         ::
 
-            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512k
+            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.34.1


