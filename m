Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F36CCD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI7-0005R4-Vs; Mon, 11 May 2026 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHh-0004px-85
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:17 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHe-0002tw-8K
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:16 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso4309101a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523793; x=1779128593; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rzcDF6ALX3wfuQ7nDVF3UwT8SdERlMMcisvRM0tvWNA=;
 b=s/+Yf+gmW/GpZ3YnW/ncu7d8Yt7zk7M89W4ddoJT/KniXMuHKyvs+tOTJ2hXBNhuL0
 7vqEg3SvGFB1mV6c/R5VfqGTk9q/YqvxeQjpf6hkN7tESrYThgcVjYTR2qheUYBAuqqR
 6PpsNnEhP0KxFE/+/io6KE0zbqLujmwg5PnY+uk0aqEcE1eeSxs687WAf2yTlw5nGXpI
 GV3xJBX1T5H9cPvXDnFc275qZSE9RfcB9vxW9kB6HcjnpwJ2bhx6U8PHHpQQn6h7JXFY
 7teYo1shA8KYpWhKLF/fg7MCLTTBZWUnB0a5CzNYZWAfWY+NUBto98MbKzdLADTwbTPU
 KIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523793; x=1779128593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rzcDF6ALX3wfuQ7nDVF3UwT8SdERlMMcisvRM0tvWNA=;
 b=puBRuvtQY9rd+Ync9hP+s21DwREB/9NHVzefx1QAF+KsyQ/PPlS7AqXD5naoNolXNq
 h0ClU0UD0UR5jW/Kbc+7EyhuSwLmqjSllZ8Qiu+odb+878VI7lbqL9POGcifcnCCVOzO
 ZFl9m/+/c4PKCu/08oU/1KClavonzncTUeinw2wGZfrQQzB0jC2AipNm51FdcSIKQ5vs
 hkG0yPrExv+Q4IVXVR19P6LjdLmo60zrMLPDvfXLBjG+6bLV17CT1Hmwg5IcgJBkBaYI
 v6rU1FWvBonBjq1mRIwu3yaEht3D/N25rrpVF33xLtgHQOA2LRINXTKI2E4WS6eFVpjD
 Vr0g==
X-Gm-Message-State: AOJu0Yy/ud6mELVrhcST57Kk6Px8HJtVi8Qxjsz4DXoXcc6VwIej4CuM
 n+bt2agDBGRtCBJ436/oxyhM1Gye00ko0R3jdSaqSX5VL7NDUlbhJ10P
X-Gm-Gg: Acq92OGnRjsu54yN/qgQJ/wCOnozRUsDijJV4sSBCsCPMvCW/e43u7fFa+553nvGTm3
 YmMFygvUVamCUlPgnUU9j4feSxRPlRf/yIRkVRn/EV5DyfoL1szVcKAFBgvGjETanaFTnn3vn5r
 wxaegOpHIWLpicJ3/fjpqEviMN4kw1RsfVs1XLN6dmEB5cpcOKeTGr28vvyQjn7R9LdU09baptZ
 nVqY2ShGM0Rsw6hW09z/ZVa321ctfG4JEU8tEoaU6Um/j528fbUXwSsYzAIOAS4sdZJYDfruojU
 FjWu3xt/CrmleRu8+exA683xPIopNN6Fz8rMnRj4Q/WgcE7vRPdF2Hgd/43uNLnbSRIDM1rQAcl
 WaNFbU0h7jY83mq1ftAcvOu1qg6FAgFko/8ZxdiJam45i0fOdyoIqnr27MvD+5jf1eVN4xXj9qt
 iG2f8e5Mzr9QMH9ncPrsVe2thGpzg4/h+EAKdrUhsHyyqD+ipkWzIb6kBGdNWand3l9OQMRppEV
 WwCWgD2ZOB81AKVfID38NKVbjXZLgpUSyespVqM+3ka4wsM7I/0bKMUhH4jB79zltXj
X-Received: by 2002:a05:6830:6b05:b0:7d7:4002:1f21 with SMTP id
 46e09a7af769-7e1df197a04mr14135336a34.20.1778523792895; 
 Mon, 11 May 2026 11:23:12 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:54 -0600
Subject: [PATCH v6 23/35] target/mips: add Octeon V3MULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-23-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32e.google.com
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

V3MULU extends VMULU across the full Octeon3 multiplier state, adding rt
and queued partial products.

Return the low result while shifting the remaining accumulated limbs back
into P[0] through P[5].

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split V3MULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 MPL3-MPL5/P3-P5 high lanes used by the two-source
    MTM/MTP forms and Cavium SDK/runtime code.
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c |  1 +
 target/mips/tcg/op_helper.c        | 46 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 46ccad95c3..08fda55ae1 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -26,6 +26,7 @@ DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
 DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
+DEF_HELPER_3(octeon_v3mulu, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index c60af2d39a..9c1fe8f4f1 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -52,6 +52,7 @@ MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
 VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 75ab1daa70..2d836afddb 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -314,3 +314,4 @@ TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
 TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
 TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
+TRANS(V3MULU, trans_vmul, gen_helper_octeon_v3mulu);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 45e208ca43..740c181d27 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -196,6 +196,52 @@ uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
     return lo;
 }
 
+uint64_t helper_octeon_v3mulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo, hi;
+    uint64_t sum[OCTEON_MULTIPLIER_REGS + 1] = {};
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[0], rs);
+    sum[0] = lo;
+    sum[1] = hi;
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[1], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 1);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 2);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[2], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 2);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 3);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[3], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 3);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 4);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[4], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 4);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 5);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[5], rs);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), lo, 5);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), hi, 6);
+
+    octeon_add_limb(sum, ARRAY_SIZE(sum), rt, 0);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[0], 0);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[1], 1);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[2], 2);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[3], 3);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[4], 4);
+    octeon_add_limb(sum, ARRAY_SIZE(sum), env->active_tc.octeon.P[5], 5);
+
+    env->active_tc.octeon.P[0] = sum[1];
+    env->active_tc.octeon.P[1] = sum[2];
+    env->active_tc.octeon.P[2] = sum[3];
+    env->active_tc.octeon.P[3] = sum[4];
+    env->active_tc.octeon.P[4] = sum[5];
+    env->active_tc.octeon.P[5] = sum[6];
+    return sum[0];
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


