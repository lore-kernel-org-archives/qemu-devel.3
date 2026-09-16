Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3DEC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lfj-0002ky-DA; Wed, 16 Sep 2026 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lfL-0000s7-RO; Wed, 16 Sep 2026 05:10:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lfJ-0007u6-1A; Wed, 16 Sep 2026 05:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=1OHi5JHGPl6L8But0CcScGVN40eJ8Dt16F5RHdPWv7w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JymQ7urCXYQ6+0xMEvYIaHvEIZ5PP5ot5hwQ9FPQIdJA7QoT7UCSg4/0eBz77Jf9V
 kCD5pHYhTUBpf4DMq+J5zrCzq5FNmYSCAR85qkOa+8bE5taKAYsoNAkYUtSh9yoKuY
 n25fl0NxClKxyxJAh9uLmbPE+d9EpWSJG8XKrYmEFKnwFxlDZPIsQKd+X7K6FqYnuE
 KxIu9+T69qfnZSUZbvgzqsWk/pZZIhJwPNzV7e4y49uYHogxA22BDaTSDfc+8azsnB
 yM5UEFKVx7ku0qmpRrsbSz/89emIhKeoIDgJKwMKBSOyyUF0VfYqJGUEQdCaPYllz/
 XZ93eDaSPw13A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 733561D56ED;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1D7BC429E4C;
 Wed, 16 Sep 2026 12:06:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F182C5A7C9; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Doug Cook <dcook@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 56/57] target/arm/whpx: incorrect ENCODE_AA64_CP_REG
 parameter order
Date: Wed, 16 Sep 2026 12:04:20 +0300
Message-ID: <20260916090516.677749-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Doug Cook <dcook@microsoft.com>

ENCODE_AA64_CP_REG expects parameters (op0, op1, crn, crm, op2) but whpx
was using parameter order (crn, crm, op0, op1, op2). As a result, every
call to get_arm_cp_reginfo() returned NULL, cp_idx was -1, and both
whpx_get_registers() and whpx_set_registers() were no-ops.

In addition, several encodings were paired with the wrong WHV register
tag. These are inert while the encodings do not resolve, but would sync
the wrong register once they do:

- the series 1 debug register encodings used series 0 tags,
- the SP_EL0 encoding was tagged WHvArm64RegisterSpEl1, which would
  clobber SP_EL0 with SP_EL1 on get and never write SP_EL0 on set,
- the ID_AA64PFR0_EL1 encoding was tagged WHvArm64RegisterIdPfr0El1.

Fix parameter order (using a regular expression). Fix tags.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 518f45b32d04d3c5e8d67a41cdf5a00f12957981)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index d72523e646c..6aa5e2cfd25 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -135,145 +135,145 @@ struct whpx_sreg_match {
 };
 
 static struct whpx_sreg_match whpx_sreg_match[] = {
-    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 4) },
+    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 5) },
+    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 6) },
+    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 4) },
+    { WHvArm64RegisterDbgbcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 5) },
+    { WHvArm64RegisterDbgwvr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 6) },
+    { WHvArm64RegisterDbgwcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 7) },
+
+    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 4) },
+    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 5) },
+    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 6) },
+    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 7) },
+
+    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 4) },
+    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 5) },
+    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 6) },
+    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 7) },
+
+    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 4) },
+    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 5) },
+    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 6) },
+    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 7) },
+
+    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 4) },
+    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 5) },
+    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 6) },
+    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 7) },
+
+    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 4) },
+    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 5) },
+    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 6) },
+    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 7) },
+
+    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 4) },
+    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 5) },
+    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 6) },
+    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 7) },
+
+    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 4) },
+    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 5) },
+    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 6) },
+    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 7) },
+
+    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 4) },
+    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 5) },
+    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 6) },
+    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 7) },
+
+    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 4) },
+    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 5) },
+    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 6) },
+    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 7) },
+
+    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 4) },
+    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 5) },
+    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 6) },
+    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 7) },
+
+    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 4) },
+    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 5) },
+    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 6) },
+    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 7) },
+
+    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 4) },
+    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 5) },
+    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 6) },
+    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 7) },
+
+    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 4) },
+    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 5) },
+    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 6) },
+    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 7) },
+
+    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 4) },
+    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 5) },
+    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 6) },
+    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 7) },
 #ifdef SYNC_NO_RAW_REGS
     /*
      * The registers below are manually synced on init because they are
      * marked as NO_RAW. We still list them to make number space sync easier.
      */
-    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
-    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
-    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
+    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, 0, 0) },
+    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, 0, 5) },
+    { WHvArm64RegisterIdAa64Pfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, 0) },
 #endif
 #ifdef SYNC_CONST_ID_REGS
     /* ID registers are ARM_CP_CONST (writes ignored).  */
-    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), true },
-    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true },
-    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true },
-    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 0), true },
-    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 1), true },
+    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, 1), true },
+    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, 0), true },
+    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, 1), true },
+    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, 0), true },
+    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, 1), true },
 #ifdef SYNC_NO_MMFR0
     /* We keep the hardware MMFR0 around. HW limits are there anyway */
-    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 0) },
+    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 0) },
 #endif
-    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true },
-    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true },
-    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true },
+    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 1), true },
+    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 2), true },
+    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 3), true },
 #endif
 
-    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
-    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
-    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
-    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
-    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
-    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
-
-    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) },
-    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) },
-    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 2) },
-    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) },
-    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) },
-    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 1) },
-    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) },
-    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) },
-    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 0) },
-    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) },
-
-    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
-    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
-    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
-    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
-    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
-    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
-    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
-    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
-    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 1) },
-    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },
-    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) },
-    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },
-    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },
-    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) },
-    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) },
-    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) },
-    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
+    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 2) },
+    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 0) },
+    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 2) },
+    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 0) },
+    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 1) },
+    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 2) },
+
+    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 0) },
+    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 1) },
+    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 2) },
+    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 3) },
+    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 0) },
+    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 1) },
+    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 2) },
+    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 3) },
+    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 3, 0) },
+    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 3, 1) },
+
+    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 0) },
+    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 1) },
+    { WHvArm64RegisterSpEl0, ENCODE_AA64_CP_REG(3, 0, 4, 1, 0) },
+    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(3, 0, 5, 2, 0) },
+    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(3, 0, 6, 0, 0) },
+    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(3, 0, 7, 4, 0) },
+    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(3, 0, 10, 2, 0) },
+    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(3, 0, 12, 0, 0) },
+    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, 1) },
+    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, 4) },
+    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(3, 0, 14, 1, 0) },
+    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(3, 2, 0, 0, 0) },
+    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 2) },
+    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 3) },
+    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 1) },
+    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 2) },
+    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(3, 4, 4, 1, 0) },
 };
 
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
-- 
2.47.3


