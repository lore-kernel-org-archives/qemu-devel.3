Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7450ECD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgY-0006Dy-M1; Sat, 09 May 2026 22:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgS-0006CB-RQ
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:21 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgQ-00030o-1J
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:20 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6966d0665baso2117810eaf.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379256; x=1778984056; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LoNmYG1cQkrp/9whUGZf4X5/VvPiiEWcf17xdy+REgs=;
 b=Hf0mZXL/9YFqG3wDNAltZ1N8pCSYGlmxBhkqJCWVaRnOYzbWKRk54+QpXOWYfRxXK6
 GZoMfIanqOKXRtB3w2NgLQmmU4PgTCDu1M0w7yNzBs6Ht8i5D90CjJD03vSvB2VTAjCX
 r5Nifcq2IpFfv7sHCZbg28svk9KRq/z2PRyTP/fW1OdBvpO5cgDWRaK5NxQndj6qehKW
 /JBGLgMMyzTPqtOU8+HWy7VCl+YkMrnoV8vZAQguGfUPKSSbK1qVi0O20EeIbTFzanTK
 ni9Hq8rutIK/jJ2psl/Dr6eB3nqINCzthONcu321wItclF73UXBK0wqkxhgiolT05qmh
 Kr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379256; x=1778984056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LoNmYG1cQkrp/9whUGZf4X5/VvPiiEWcf17xdy+REgs=;
 b=UKxhMF5DbGRiTlvgT0OyLS2dviaojei6XZe8RubQPPLUn0s/gxUZZOYOvDySXYSTCO
 io3TA02SuYqpSOJ9Ul6sB6YdrzF4MqNIWx4hzxkuCwkmSQul7QTI7+hPyr2Oce/X+Gio
 Es5bw141Wh0RRMtvXbljme1bT9flCJyu/wiS+1Ud78LTHqZZfv346UDW9AUluFHrVXw9
 84y5WyMQfPq5wF5ctNcBsdDM7ggO9RcWxsPLk3yL2AXtK6j9JlxrgbXVx3GMccbaxkC+
 iNpM8VeZ67TnNytvNQg0+SmbheMAh0/HS3Bn9YAye0dmv3wAJWcB/PTaaHcKQy0qkeip
 V9DA==
X-Gm-Message-State: AOJu0YyIz2TCXb68QyhB4KJn7lpo4cx+9+SiRUDX9bPY8Fb04H0aqqbT
 LulG1iH2Xs4DTdQ5pieg0c5tzE8tPZ2LMQHr78ErnCb+8Wgrh5nYprmxgim9Z9dZ
X-Gm-Gg: Acq92OH4gUyYTTXKZMDrpSX7prTDpPxI6j0UfuCNOi9ttlgZy61YP49jPHg6ZUis3zc
 uhoXooq8R8sC0SzTYQaGygYcstXDmyMgwC7I3d5OdsXnUZa1IONycCYwlJ03QGeD7GVxMNqBU6h
 BA5zOJCbWcuMGRki7NkdfbxTjfC1bLR2R29b3z0Yuzg+XK9OI/2K439LQ7CG9OoqKoCAQc/+MQp
 ofbTH9mUBJ37pTsYLkVMa0vRdbhC9qSRidNv9wGyUZp55RObiEWztFHrp0pPvEsJnRglSzsF4OW
 niBweFN5kpRdPhri4kKKyLdKSr4oEi67sWH5Y2xmhzu4mvQwya3v8vm/teRcBHDdBOO641sXbrD
 lwpg3+TOoNgGROt39eAoIXp2DOQZhhEHDjTRmiSG2bDwIhqjyQ4neVT5II2+nOSE7l9wyWUNl7h
 FnJVpXdcl/I4kW4qtvccGbvuRzspSiMVRDkTwex1Q1Migd62DJ+JZMJ2ydVQ4DAzB2jOamYR0e5
 5WHs9teIbFLrjiPoan2sma4Oh+WQNg6/b0nrHTfmUT3acr/3W6OFEFkgFDv0AYcTpN+
X-Received: by 2002:a05:6820:3082:b0:696:3196:59bf with SMTP id
 006d021491bc7-69998cbdb66mr10818118eaf.22.1778379255912; 
 Sat, 09 May 2026 19:14:15 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:44 -0600
Subject: [PATCH v4 21/32] target/mips: add Octeon VMULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-21-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2c.google.com
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
index 7de2a8f6ec..1c3dbb4a33 100644
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
index 366b70548c..6c2edc2d47 100644
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
@@ -275,6 +277,20 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
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
@@ -290,3 +306,4 @@ TRANS(MTM2, trans_mtm, 2);
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


