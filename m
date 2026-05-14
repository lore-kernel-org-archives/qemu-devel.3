Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3151CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa1T-0000vX-VV; Thu, 14 May 2026 13:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0x-0000qL-Ru
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:29 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0q-00043k-NN
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:23 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e4de538f83so70495a34.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780295; x=1779385095; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pc1Mn3o1jlOZY11iHx/ZhNEk+WZuH54xOhmJWC41Wdg=;
 b=lpGKi5jFng/sXVD138M7u80ulOOx15DKUN8Z7CYV0yINZRudu5OS8Ssmga9phVNW8t
 zvJCbI5ZY0lhlZqEjGSjTmVzQ+HnWDi8OnOzeslnATj1hypLaxIRT+epTlOhYl2qxx+9
 u5sCeWU6Ftn+dxju3QtcbGGjnGSLyZ5Nj27pJwEzVwCAlz5ULLn6mtai96cucgF6VE5f
 Q1NqeJSEPHj8GxolTTzV8qxAMXviIkG/2hw+w2TiNP4G+qRGnbBj8L+6q3LHVhSvZFk4
 7+R8dIMF//WW8xKzKVSlOm5HR0A6xi0sOvrbrKfAnMYTi0Hf2QTmfG+M7673MHHWkoQi
 9STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780295; x=1779385095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pc1Mn3o1jlOZY11iHx/ZhNEk+WZuH54xOhmJWC41Wdg=;
 b=Zwm6n2/vUAbATqxIhkMmSGSECQi39kxjZdD8T0hDCo8pKsLgpDQRv369VyzhpafgHH
 cPjWLej8M19g9aj601oF4SE4UhgLssLD6rxPq4+dnHrQZyDy4CmlS9ETaUjKOXVnk3I3
 yGeVQOB/A7m14cMNZ7n23foJ6y/ywUsK4ldOAKAuQg5YDFIyM9ARYiKZzmiQ80KO7cVH
 kpWTHg8HW1HGvtTMcHv7NVcbo1GpQP2mHrUVKjSLo8+uOtJlKyygftYfMApwFWg7I5P0
 Nm6PYIcahHELIOznOzTz0wX4E9dtM+ClEZa8mkKtQtgPV+2QrpwyJYd2bHArXY5OHqyT
 NbFQ==
X-Gm-Message-State: AOJu0YxW5NyL32L/zp8FC36e59tBk/Tsn0ad6Qvb8HG5pU+Zc/AqrBBf
 FPQXzlGtttFgeGv/ZkqUiYUEoWOCNo1G1Ue1TtZUrl2vfm8VH3uoTUNa
X-Gm-Gg: Acq92OFLmlCROoTudpGAWWjF0qGiGX9ZHxlEG52oRnaY10i7Kr8Nyaz7HYSB+9QfHWw
 Z8SlDKKGKDGPsEIni2pegWLc+VCaP1+1IDgJnPNVOZeEGkpU/Czbjyirtr5ojc1sKUypfSbwmFr
 4qz9A4W23Xpogg0C9uUwvSyJ9tjSpk4bwfs15RGmC5wyW9J0rUvDeFK2t4yP4PXOYSIgk3apigZ
 YSGuwhqLxk/3lEnnGd72BX6i30rAfvLPgpqxxdSfMMD12FqnvjZbHbcPI4zGK1Pc76YEVzNHXLF
 GYaBQaMMPAWxWoeAwawbpBvUSGPI6ebr5OHwD1d2k2IOPMjcBqlUMuKKth+nTINlfZTv3yQwkba
 V0DR7A7h77MR/NiLpRWl7RdB0Th+c4DCO/lMleAePcOozOTuViXJ4s58CHvSCwW1qIYmXnYsQBq
 bKdORYRmjinBS/UCLMpUloFO2a7cDPZlW17C+oQ7HcEGecdXVi/R3SN8+dI+ssB9BMX3TZFyolO
 5tVdXjaIwEMWlAi8RsxYfeUq0uWsfPrl3Q4lVXQLEtvbWSvpcy+Ze4inoRuddUKtloxPmKQt1nP
 bBk=
X-Received: by 2002:a05:6820:16a6:b0:69b:544f:c172 with SMTP id
 006d021491bc7-69c943714e6mr275077eaf.25.1778780294675; 
 Thu, 14 May 2026 10:38:14 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:10 -0600
Subject: [PATCH v7 21/35] target/mips: add Octeon VMULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-21-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

VMULU multiplies the active Octeon multiplier state by rs, adds rt and
queued partial products, returns the low result, and advances P[0]/P[1]
with carry limbs.

Add helper and translator support for the two-limb accumulator operation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split VMULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
  - Use uadd64_overflow() for multiplier limb carry accumulation.
    (suggested by Richard Henderson)

Changes v5 -> v6:
  - Rename the translator helper callback typedef for clarity.
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 17 +++++++++++++++++
 target/mips/tcg/op_helper.c        | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e2b83a1d19..f1e78ae329 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -24,6 +24,7 @@ DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
+DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2279bf3eb5..74d24c18de 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,6 +50,7 @@ MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
+VMULU        011100 ..... ..... ..... 00000 001111 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 365079cfb9..62cbbd3c82 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,8 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+typedef void gen_helper_octeon_vmul(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;
@@ -287,6 +289,20 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
     return true;
 }
 
+static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
+                       gen_helper_octeon_vmul *helper)
+{
+    TCGv_i64 rs = tcg_temp_new_i64();
+    TCGv_i64 rt = tcg_temp_new_i64();
+    TCGv_i64 rd = tcg_temp_new_i64();
+
+    gen_load_gpr(rs, a->rs);
+    gen_load_gpr(rt, a->rt);
+    helper(rd, tcg_env, rs, rt);
+    gen_store_gpr(rd, a->rd);
+    return true;
+}
+
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
@@ -300,3 +316,4 @@ TRANS(MTM2, trans_mtm, 2);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
+TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 4502ae2b5b..ab3fb06a16 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -144,6 +144,38 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
 
+static void octeon_add_limb(uint64_t *sum, int limb_count,
+                            uint64_t value, int limb)
+{
+    while (limb < limb_count &&
+           uadd64_overflow(sum[limb], value, &sum[limb])) {
+        value = 1;
+        limb++;
+    }
+}
+
+uint64_t helper_octeon_vmulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo, hi;
+    uint64_t sum[3] = {};
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[0], rs);
+    sum[0] = lo;
+    sum[1] = hi;
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[1], rs);
+    octeon_add_limb(sum, 3, lo, 1);
+    octeon_add_limb(sum, 3, hi, 2);
+
+    octeon_add_limb(sum, 3, rt, 0);
+    octeon_add_limb(sum, 3, env->active_tc.octeon.P[0], 0);
+    octeon_add_limb(sum, 3, env->active_tc.octeon.P[1], 1);
+
+    env->active_tc.octeon.P[0] = sum[1];
+    env->active_tc.octeon.P[1] = sum[2];
+    return sum[0];
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


