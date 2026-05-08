Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F642CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMta-0002p7-3S; Fri, 08 May 2026 11:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtI-0002hV-Jf
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:26 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtG-0001lH-3l
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:23 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1780342fac.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253201; x=1778858001; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8jAWn0Lv+jpcaH7C8oHJxREunpOusfqCStSsitWznJI=;
 b=oHiyyhN9AaDjQFkx5svMFZgJO6FCivZj8895tlkHFwqxLqPyebSlaC9h+jb3MmLgpP
 DCu7mHyJh0b/3S0dH1qTZXoiScP4EnVl3zfJCu3xKMYLCbYC8FDmZp5upGzTa7F86Eq3
 UTU56HYu9bXdYgJVSblfD9DIx0TCavZwbCDhv9lYjHVCKtfUBmeelCPabfzh+qPKoG1z
 z8W0GDrTQghGqhkgtLOZejhH+KLc68e8zYpNZqUp26DS201rAnF0RFg6hOX+jT5nQfTO
 8i3p6RgjZ2KQtcOLmlonooKQ9PoqZDA+BGb+abxpmOHrSyanFtlqPGY7ZqTbLiBhN1Gg
 oTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253201; x=1778858001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8jAWn0Lv+jpcaH7C8oHJxREunpOusfqCStSsitWznJI=;
 b=K60U8ERoD4PiLZS/Qepp8aYxLzdfr15B85LH+pJRovxE8St1dSTtJo0V5C+jkWkuE5
 hzpvaz5+9TEcN4le4cSuZmbx+iXSCblkFpf58Bxg3nsUdORJF0eUeAVJkDFcbjOEL0CT
 vzwJHG6cqSswAEPcC0NviStGV3phzz1iTxXCjEh9CkN+4otXe5x44nIJdDqTUYfs7nNV
 ItSOmSbA6htHI5ipljpm1rHmGtRKhhyY70zrxA/d0LRyAm2uzmaU5QZ6OIZcRVKxVN/E
 HNPMkDbrEGedeY7wcmVJzfI44UHTm2DGteIqCpQ0sFcKEll9Pa0Ydn2SqUDSNd/xsmh/
 ERYw==
X-Gm-Message-State: AOJu0YxD8Q2e9xbuZWV4bHT97I5NIQ5o3yCK2eDADt9l5LY37FkA2zQS
 2LgGIOW7KZTl2IRMczanA+hwjNlwWj4dbpRPKA0Fmz6bYuly+xHltl6Ol8h+zg==
X-Gm-Gg: AeBDieuvhUv+xcgqLhNUk4FB9tI4KsHfpFmL+1+uo6rZSkRAIIYFxjaJO4r4wRAgcKr
 pc0HOWPGLZdkSowT4M720zl9Qlgn6ghu+Jk3F8/ZVGoCj3Utt4q2Q1auh8MSa3cKFoXD5oxV8oC
 BMqiotsvHIXqVZs/G5AnN90ov1IPtjAygq0yYAUoj7IwoYvzS1DeltJ3H1aSIySfawXvTV30UVO
 qf2tZ+M6+vhGtM8KuxZS/UVCjdjaTpoLyBhQubPtYclKyvSj187NWEo3IMg1aN5gwgrTMGTYeqQ
 japXCML+xNHfwpsMJMNiQpl/V+jb0i52fM90oehB8bdNaAmQsDRJOFOTf1rmF5PCaQiaFdx/Udw
 e8+FIqBSa4e5vb62aVniVLMDT+0FLHYDqJ6CLQj121opedDSdAmcF9/u305I8WTT+B0khk5ZzDn
 NQvgQ2JABX4aUrZ9cHTrB2322hjV8Hjg+qRVq6O5DDXabZ1bTrDBlfJfrlrOyU4qs2iq/PLT+2C
 AGXxmJunwispwaA4tYF2sVPVv+/o8KRUP9peDVJM6HHHJMOeP8ZZ8dgMB/9u9dvbf5HWHE7GIBu
 OcwLvxCW2cq3bm5+z6qanqS4IruQ5MlKzvIyP5ujUNqs4THZUunSouEfBi7bsxMerIeEvOyEFNv
 /6I8plg==
X-Received: by 2002:a05:6871:655:b0:435:318b:1d32 with SMTP id
 586e51a60fabf-435318b494fmr2455176fac.0.1778253200604; 
 Fri, 08 May 2026 08:13:20 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:23 -0600
Subject: [PATCH v3 23/32] target/mips: add Octeon V3MULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-23-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x33.google.com
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

V3MULU extends VMULU across all three multiplier operand pairs, adding rt
and the six partial-product limbs.

Return the low result while shifting the remaining accumulated limbs back
into P[0] through P[5].

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split V3MULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
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
index 8a909ffcee..54ca92a654 100644
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
index c1dd03debd..fe1ddeb973 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -314,3 +314,4 @@ TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
 TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
 TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
+TRANS(V3MULU, trans_vmul, gen_helper_octeon_v3mulu);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index a1465068af..e4107a304c 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -192,6 +192,52 @@ uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
     return lo;
 }
 
+uint64_t helper_octeon_v3mulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo, hi;
+    uint64_t sum[7] = {};
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[0], rs);
+    sum[0] = lo;
+    sum[1] = hi;
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[1], rs);
+    octeon_add_limb(sum, 7, lo, 1);
+    octeon_add_limb(sum, 7, hi, 2);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[2], rs);
+    octeon_add_limb(sum, 7, lo, 2);
+    octeon_add_limb(sum, 7, hi, 3);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[3], rs);
+    octeon_add_limb(sum, 7, lo, 3);
+    octeon_add_limb(sum, 7, hi, 4);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[4], rs);
+    octeon_add_limb(sum, 7, lo, 4);
+    octeon_add_limb(sum, 7, hi, 5);
+
+    mulu64(&lo, &hi, env->active_tc.octeon.MPL[5], rs);
+    octeon_add_limb(sum, 7, lo, 5);
+    octeon_add_limb(sum, 7, hi, 6);
+
+    octeon_add_limb(sum, 7, rt, 0);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[0], 0);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[1], 1);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[2], 2);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[3], 3);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[4], 4);
+    octeon_add_limb(sum, 7, env->active_tc.octeon.P[5], 5);
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


