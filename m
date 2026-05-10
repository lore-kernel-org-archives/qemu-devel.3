Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29659CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx5-0005AE-2g; Sun, 10 May 2026 16:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwv-00058A-9h
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:32 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwt-00044o-BL
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:28 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47c35be031dso2333646b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445626; x=1779050426; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fO0FDPBJB1Jh2cEADUb4xFvCLeub6Hg4Rz6YWAQW5kc=;
 b=jw8vcLDkom3faPE1HWFZVjvs6IQkU1gjvSw7Yr+MiuC398eyDIRujkRSrOHGKWtAYZ
 slxwEaV2dXVPfhz38Ppjf65sbdksaABJuslv4jBvnamNsAP/TaL3+lSXG4/DjCSpA9jV
 iNE/qRMgJw3u7TNVA8EV82vm4xdFi8ZNJlQfYupsOCm5VBpoavrRaV+Urnhz1tSEGLET
 h7GvJW0j1XQsNJV1xs06W8VItTCwOaoXGfu+NapRgraD6zpzkFwu7kIYGw+dYzOc7lma
 h+vsAKAFVnytrg0BaNcPJaphF9W9vJ7vHToqNF1Byfd6maFydDLC8D6RT5MzF2mBfmKS
 fU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445626; x=1779050426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fO0FDPBJB1Jh2cEADUb4xFvCLeub6Hg4Rz6YWAQW5kc=;
 b=KDKMizjSyKWgRpUW7DhQlDp9F7rXNoEKAlJZ+XwM9xQLiMMlp7JXx1F2ftIyHocQAg
 sVjP/L4PpEau97rPTJyF8YQbUcpq3u0iSHVojcSi/ZupLdNf7M1/XC0HXC7reXEwsu08
 sbibbP5RUb35rrZaRstowObnafeMB89FoNFqxAWta8J/LJR8VEVVP5tzNgQ12sMtIluz
 KtJnu0yUsy/pPNT7czl5dEjJIRipbMelJ/1q9EMMelXCXT2nTGfP7tzXNO0sMcrrrOpR
 F9nGfdUnhL6JLridizLKhegAvaop5C4OxNLrL74McC0pUtQvZQ/O4ivc8qIOyftLSkzV
 dZTg==
X-Gm-Message-State: AOJu0Yw92iyqevZD1qFfUeb5ZpoSd7MZsmjW4rZ6Z4sBeqeXV8D3M88y
 59WQ+yz+f1MKoCPNh2t/rG6l/CiL30IOeTLz9GTFnnRVflHYzOG8ROQh
X-Gm-Gg: Acq92OEm2iNyklBqlXCm7NNTMeQQg4gaziZmJ0C7LkikPi30bA6xEe3YJnFHemDW7O8
 ebGED3BFp940thlo+4iW9fTw0yUWKi5VbqNEUdepl0oD93MQPV26zY4DK2++Mpjb6ZkNOBdHP9Q
 sY6FSZEM/T8djz9JctlQPf2KIc6E1nAgyxrtsf6aAhWM+7JCXu/SvgJGe46JfLiGuI5WamE69zY
 wMijLJXNaKCCD/SWjh3cZo9Qa6WxY0dPGG6KffhSDMTt95dkkcR0+nPJc72ZDSk2lH4CU6kSPen
 yuwpQUd1710fVm6BwFMluUreTl3akyJDzQROjToFR+w46U8ucUmUPH0ZaTYzGED9+/L6QGNoVAU
 z1gTz7loSeEzZCdSly6x6gSevtHadE3CjOjADukEYgqO5noZLdA7gFnIVeBTdNpp2UToP/YcgFb
 QbxzaRS6A2CBHMcqVgVLfsffThIzW2HcNN3ySVmnmwVPii+jTiP9+NG9+CYdpnoXPQgRosyWxNw
 QE8KHXKMylgL95GdmAx9tT+XfJn20qpGoP2PwKl1e0=
X-Received: by 2002:a05:6808:2291:b0:479:da60:7dcc with SMTP id
 5614622812f47-4807fda5a68mr7158821b6e.35.1778445626199; 
 Sun, 10 May 2026 13:40:26 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:51 -0600
Subject: [PATCH v5 21/32] target/mips: add Octeon VMULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-21-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
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
index 682473b011..75834afc6c 100644
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
index fc0131ccc5..d39f904e73 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,8 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+typedef void gen_helper_lmi(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;
@@ -265,6 +267,20 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
     return true;
 }
 
+static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
+                       gen_helper_lmi *helper)
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
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -280,3 +296,4 @@ TRANS(MTM2, trans_mtm, 2);
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


