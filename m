Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A4AC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilhD-00043A-Gt; Sun, 12 Jul 2026 00:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilh9-0003iy-IA; Sun, 12 Jul 2026 00:21:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilh7-0007BM-FK; Sun, 12 Jul 2026 00:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=sYKxVmO4YQTW0XtW00B+Xbv/33ZASvJMvAu41p8l4W4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AghFx8MG7E5q/g89epeRgoUjhOzNbpRUw2i4KqOtaZxdNoZn4o4pFy1jcZ56WAXz/
 zFGv22tkYNgTZVu2TySuOybV/CIJPIzs4LLIqs+fotCmZxdjNlfu97Tw70dQq4Rvg7
 fDqT5shcE8wA0mPk8+950AqDoh3UeXYbEAPxOBd0kLZ3Y/bPkv8LgZi1L4Ac+tyj9y
 VHoKk6vuX2WpQqujXHd6cxvj+BFoxEJA5YWar62f7LaQ3yCXzEv7Eil9EdnUeixm/7
 oiKzNieMlLrhRyTezrmoL7ML10OUeM2bRynqaNVrhcRUonc31gmDv5aaI0DCMjM+CL
 SnrQRikpvXvqw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F7C11C0C13;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 41DBD3EB973;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9978A13429; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 56/75] tcg/loongarch64: Improve constraints for
 TCG_CT_CONST_VCMP
Date: Sun, 12 Jul 2026 07:15:14 +0300
Message-ID: <20260712041539.108341-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Use the TCGCond given to tcg_target_const_match to exactly match
the supported constant.  Adjust the code generation to assume this
has been done -- recall that encode_*_insn contain assertions that
the constants are valid.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 911f7328e9e9de80bf6b1a4697ecf83cc3661f5f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 740b7c264d6..879f66f2555 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -213,8 +213,18 @@ static bool tcg_target_const_match(int64_t val, int ct,
     }
     if (ct & (TCG_CT_CONST_VCMP | TCG_CT_CONST_VADD)) {
         int64_t vec_val = sextract64(val, 0, 8 << vece);
-        if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
-            return true;
+        if (ct & TCG_CT_CONST_VCMP) {
+            switch (cond) {
+            case TCG_COND_EQ:
+            case TCG_COND_LE:
+            case TCG_COND_LT:
+                return -0x10 <= vec_val && vec_val <= 0x0f;
+            case TCG_COND_LEU:
+            case TCG_COND_LTU:
+                return 0x00 <= vec_val && vec_val <= 0x1f;
+            default:
+                return false;
+            }
         }
         if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
             return true;
@@ -2029,28 +2039,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                  * Try vseqi/vslei/vslti
                  */
                 int64_t value = sextract64(a2, 0, 8 << vece);
-                if ((cond == TCG_COND_EQ ||
-                     cond == TCG_COND_LE ||
-                     cond == TCG_COND_LT) &&
-                    (-0x10 <= value && value <= 0x0f)) {
+                switch (cond) {
+                case TCG_COND_EQ:
+                case TCG_COND_LE:
+                case TCG_COND_LT:
                     insn = cmp_vec_imm_insn[cond][lasx][vece];
                     tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
                     break;
-                } else if ((cond == TCG_COND_LEU ||
-                            cond == TCG_COND_LTU) &&
-                           (0x00 <= value && value <= 0x1f)) {
+                case TCG_COND_LEU:
+                case TCG_COND_LTU:
                     insn = cmp_vec_imm_insn[cond][lasx][vece];
                     tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
                     break;
+                default:
+                    g_assert_not_reached();
                 }
-
-                /*
-                 * Fallback to:
-                 * dupi_vec temp, a2
-                 * cmp_vec a0, a1, temp, cond
-                 */
-                tcg_out_dupi_vec(s, type, vece, TCG_VEC_TMP0, a2);
-                a2 = TCG_VEC_TMP0;
+                break;
             }
 
             insn = cmp_vec_insn[cond][lasx][vece];
-- 
2.47.3


