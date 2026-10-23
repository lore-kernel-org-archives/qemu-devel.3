Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9D606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=GcfInH3R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKMTi-0001lM-4O; Fri, 23 Oct 2026 17:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xKMTb-0001kF-Gp
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:06:59 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xKMTZ-0003Pk-Df
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=wfdgcXniOOeOX/QNNozczV49d4rhtIRJnBnMkD5f2Xk=; b=GcfInH3RZL2xCXvwIJGr6ve2zT
 eDmlM0a/GLuIS1ZTP9GCJpv/NmDHKiM9goFJDjTDQnYqdNh0xJ3nIR964jwf7epB7c2z3OnsLZShH
 2eiFqG9f6aHzx+8xz2XK3CU3vxibVlHh4btdPpBfPOn8G00fWWlzHLP/S9Ma8Uqe/O6aDq0gnodmh
 ZmnvyD6op5HB7+hqzObErEG4yiHZbnIjDnJGqLIWVPzg1mZDRidmjcwb3OHBhYT6i5mqW12VAXTE/
 rfea6pcrNPlOAYt2GEdsBGU1f7TZSyskgiJ+PyK6A5T/1uBUHD64zCJKC8uGU1sJCdYDJtCKAMKKz
 E4RieghHZqm32w6IMuAf2KKIoa0l/MenZuiVV2kj3nVOBkQ2WsIwmF5BM+u2DlNyVfDUjFCJgvAZi
 CMgww09eqKCNyt3hDmGq+NAh0gt8emUqtGIiM8oiYUGfJ8OAxjbER+oPI5JG1tSPULEt9Tfwf7bBB
 XCnTdApXu5C3UPteuyOYNnN7eQ3qsSrF+Fx9mTBiA2/dVOcBfcEov7ZqpqWuszg9BrNnrU17l6SIT
 ZrdpI1AVqu+ptKDd2+LoMbwOIrDWFJCJd1gxz+JgHl+LG4nIrlA/dWONU/fm/SCqBJ+X5aGPcxvSX
 0s4ev/a2MVLum0wNslEfIq9BvxRQhmmU4pE+ckIBg=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xKMSr-003QXg-7t
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:06:13 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Fri, 23 Oct 2026 22:06:34 +0100
Message-ID: <20261023210650.559141-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
References: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 4/6] target/sparc: Add the AES key expansion instructions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stian Halseth <stian@itx.no>

Implement the AES key expansion instructions according to
OSA (Oracle SPARC Architecture) 2011 sections 7.3 and 7.4
and set the AES bit in the CFR.

4-operand form (7.3):
- AES_KEXPAND1

3-operand form (7.4):
- AES_KEXPAND0
- AES_KEXPAND2

Like the AES round instructions, they are gated behind the
crypto CPU feature and disabled for sparc32.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261022070059.3861291-5-stian@itx.no>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/crypto_helper.c | 58 ++++++++++++++++++++++++++++++++++++
 target/sparc/helper.h        |  3 ++
 target/sparc/insns.decode    |  7 +++++
 target/sparc/translate.c     | 30 ++++++++++++++++++-
 4 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/target/sparc/crypto_helper.c b/target/sparc/crypto_helper.c
index 7dd4dd51446..f04bd3569dd 100644
--- a/target/sparc/crypto_helper.c
+++ b/target/sparc/crypto_helper.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes-round.h"
+#include "crypto/aes.h"
 
 /*
  * SPARC four-operand AES round (Section 7.3).
@@ -87,3 +88,60 @@ uint64_t helper_aes_dround23_l(uint64_t key, uint64_t s2, uint64_t s3)
 {
     return aes_round(key, s2, s3, 1, true, true);
 }
+
+/* Combine the transformed word with the two words in rs1. */
+static uint64_t aes_kexpand(uint64_t rs1, uint32_t t)
+{
+    uint32_t hi = (rs1 >> 32) ^ t;
+    uint32_t lo = (uint32_t)rs1 ^ hi;
+
+    return deposit64(lo, 32, 32, hi);
+}
+
+/* Apply the AES S-box to each byte, preserving byte positions. */
+static uint32_t aes_subword(uint32_t x)
+{
+    return ((uint32_t)AES_sbox[x >> 24] << 24) |
+           ((uint32_t)AES_sbox[(x >> 16) & 0xff] << 16) |
+           ((uint32_t)AES_sbox[(x >> 8) & 0xff] << 8) |
+           (uint32_t)AES_sbox[x & 0xff];
+}
+
+/*
+ * AES Cryptographic Operations 4-operand (Section 7.3)
+ * AES key expansion with RotWord, SubWord, and RCON.
+ */
+uint64_t helper_aes_kexpand1(uint64_t rs1, uint64_t rs2, uint32_t imm)
+{
+    static const uint8_t rcon[10] = {
+        0x01, 0x02, 0x04, 0x08, 0x10,
+        0x20, 0x40, 0x80, 0x1b, 0x36,
+    };
+    uint32_t t = rol32((uint32_t)rs2, 8);
+
+    t = aes_subword(t);
+
+    if (imm < ARRAY_SIZE(rcon)) {
+        t ^= (uint32_t)rcon[imm] << 24;
+    }
+
+    return aes_kexpand(rs1, t);
+}
+
+/*
+ * AES Cryptographic Operations 3-operand (Section 7.4)
+ * AES key expansion with SubWord, without RotWord or RCON.
+ */
+uint64_t helper_aes_kexpand0(uint64_t rs1, uint64_t rs2)
+{
+    return aes_kexpand(rs1, aes_subword(rs2));
+}
+
+/*
+ * AES Cryptographic Operations 3-operand (Section 7.4)
+ * AES key expansion without SubWord, RotWord, or RCON.
+ */
+uint64_t helper_aes_kexpand2(uint64_t rs1, uint64_t rs2)
+{
+    return aes_kexpand(rs1, (uint32_t)rs2);
+}
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 9bfd643b09c..685b89d9c5e 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -130,6 +130,9 @@ DEF_HELPER_FLAGS_3(aes_eround01_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_3(aes_eround23_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_3(aes_dround01_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_3(aes_dround23_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
+DEF_HELPER_FLAGS_2(aes_kexpand0, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_3(aes_kexpand1, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
+DEF_HELPER_FLAGS_2(aes_kexpand2, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                  \
     DEF_HELPER_FLAGS_2(f##name##8, TCG_CALL_NO_RWG_SE,       \
                        i64, i64, i64)                        \
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 99c9147e7d9..96791c76584 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -86,6 +86,10 @@ CALL    01 i:s30
 @d_d_d_d    .. ..... ...... ..... ..... .... .....         \
             &r_r_r_r rd=%dfp_rd rs1=%dfp_rs1 rs2=%dfp_rs2 rs3=%dfp_rs3
 
+&r_r_i_r    rd rs1 imm rs2
+@d_d_i_d    .. ..... ...... ..... imm:5 .... .....         \
+            &r_r_i_r rd=%dfp_rd rs1=%dfp_rs1 rs2=%dfp_rs2
+
 {
   [
     STBAR_v9        10 00000 101000 01111 0 0000000000000
@@ -571,6 +575,8 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPMAXU8     10 ..... 110110 ..... 1 0101 1101 .....    @d_d_d
     FPMAXU16    10 ..... 110110 ..... 1 0101 1110 .....    @d_d_d
     FPMAXU32    10 ..... 110110 ..... 1 0101 1111 .....    @d_d_d
+    AES_KEXPAND0 10 ..... 110110 ..... 1 0011 0000 .....   @d_d_d
+    AES_KEXPAND2 10 ..... 110110 ..... 1 0011 0001 .....   @d_d_d
 
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
@@ -604,6 +610,7 @@ AES_EROUND01_L  10 ..... 011001 ..... ..... 0100 .....     @d_d_d_d
 AES_EROUND23_L  10 ..... 011001 ..... ..... 0101 .....     @d_d_d_d
 AES_DROUND01_L  10 ..... 011001 ..... ..... 0110 .....     @d_d_d_d
 AES_DROUND23_L  10 ..... 011001 ..... ..... 0111 .....     @d_d_d_d
+AES_KEXPAND1    10 ..... 011001 ..... ..... 1000 .....     @d_d_i_d
 
 ##
 ## Major Opcode 11 -- load and store instructions
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 16907b10850..5541305c6fc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -109,6 +109,8 @@
 # define gen_helper_aes_eround23_l       ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_aes_dround01_l       ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_aes_dround23_l       ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_kexpand0         ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_aes_kexpand2         ({ qemu_build_not_reached(); NULL; })
 #endif
 
 #define DISAS_EXIT  DISAS_TARGET_0
@@ -3039,7 +3041,7 @@ TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
 
 static TCGv do_rdcfr(DisasContext *dc, TCGv dst)
 {
-    return tcg_constant_tl(0);
+    return tcg_constant_tl(CFR_AES);
 }
 
 TRANS(RDCFR, CRYPTO, do_rd_special, true, a->rd, do_rdcfr)
@@ -5434,6 +5436,32 @@ TRANS(AES_EROUND01_L, CRYPTO, do_dddd, a, gen_helper_aes_eround01_l)
 TRANS(AES_EROUND23_L, CRYPTO, do_dddd, a, gen_helper_aes_eround23_l)
 TRANS(AES_DROUND01_L, CRYPTO, do_dddd, a, gen_helper_aes_dround01_l)
 TRANS(AES_DROUND23_L, CRYPTO, do_dddd, a, gen_helper_aes_dround23_l)
+TRANS(AES_KEXPAND0, CRYPTO, do_ddd, a, gen_helper_aes_kexpand0)
+TRANS(AES_KEXPAND2, CRYPTO, do_ddd, a, gen_helper_aes_kexpand2)
+
+/* AES key expansion with RCON selected by the 5-bit immediate in imm */
+static bool trans_AES_KEXPAND1(DisasContext *dc, arg_r_r_i_r *a)
+{
+#ifdef TARGET_SPARC64
+    TCGv_i64 dst, src1, src2;
+
+    if (!avail_CRYPTO(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = tcg_temp_new_i64();
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    gen_helper_aes_kexpand1(dst, src1, src2, tcg_constant_i32(a->imm));
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+#else
+    return false;
+#endif
+}
 
 static bool trans_FALIGNDATAi(DisasContext *dc, arg_r_r_r *a)
 {
-- 
2.47.3


