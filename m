Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF138C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp6P-0000Q0-Ly; Tue, 25 Aug 2026 07:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6O-0000PP-9N; Tue, 25 Aug 2026 07:14:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6M-0008DZ-GQ; Tue, 25 Aug 2026 07:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=lwjuQx3EXI/g13Td3L9R+9Xx4ZUuCRX8Ufdv6wujEms=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AarzaRsWxPhc4Braw8HzNi5qamkX4mFs3S0qIBmxl83RZ92AiIObV6rOfuwsxV+MH
 T4XPJs8552ogeqef5vxRQ3kMGvJCKmC+TdGGNa5FjrF2s7cckmEemDlZQt9f70+HYY
 k/9f29ihq2oFJ+nJRtdmOJSWPnVbB+hC/8lwRcGgbyAACee0uFQOsRqXqcAdK8LClL
 1cqPEFwKEinNfOGRbf2jVZsoksRwYPyeMaV2uuE96t/sUX684RRnJ21aOUCieYqLFH
 er83MZbVKSg7pOUYII04cwVyZfBMMibRrdjaHBkaa4VouP38fj1qePzCiU2npQrytC
 ZhPpHIPIzZSmw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D52B1CE4A6;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 254A9416272;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 696203258F; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 138/166] target/i386: Clear OF, SF,
 and AF for fcomi/fucomi
Date: Tue, 25 Aug 2026 14:11:34 +0300
Message-ID: <20260825111206.482723-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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

From: Simon Scherer <scherer.simon89@gmail.com>

helper_fcomi_ST0_FT0() and helper_fucomi_ST0_FT0() only cleared
CC_Z, CC_P, and CC_C before merging in the comparison result,
leaving CC_O, CC_S, and CC_A untouched from whatever they were
set to beforehand.

The Intel SDM documents FCOMI/FCOMIP/FUCOMI/FUCOMIP as setting OF,
SF, and AF to 0 unconditionally. The AMD manual doesn't mention them
at all. However, testing on multiple real Intel and AMD systems confirms
all three are unconditionally cleared regardless of the comparison
result or their prior value.

Since fcomi_ccval[] only ever contains CC_C, CC_Z, 0, or CC_Z|CC_P|CC_C,
and CC_O|CC_S|CC_Z|CC_A|CC_P|CC_C already covers every flag bit, CC_SRC
can be assigned from fcomi_ccval[ret + 1] directly instead of ORing it
into a masked cpu_cc_compute_all() result.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4133
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260807062831.19618-1-scherer.simon89@gmail.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0924d9d3db3617f49ba9282acc6d85b349404ce6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 56d456860fc..128f16dc951 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -550,12 +550,11 @@ static const int fcomi_ccval[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 void helper_fcomi_ST0_FT0(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
-    int eflags;
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
-    CC_SRC = eflags | fcomi_ccval[ret + 1];
+    /* OF, SF, and AF are unconditionally cleared to 0 */
+    CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
 }
@@ -563,12 +562,11 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
 void helper_fucomi_ST0_FT0(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
-    int eflags;
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
-    CC_SRC = eflags | fcomi_ccval[ret + 1];
+    /* OF, SF, and AF are unconditionally cleared to 0 */
+    CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
 }
-- 
2.47.3


