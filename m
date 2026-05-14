Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88B6CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa22-0001pw-2I; Thu, 14 May 2026 13:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa1A-0000tl-TF
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:45 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa11-00044H-UG
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:38 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso7374143a34.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780296; x=1779385096; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J0TVz6tP6rUprn0I+4uUdka/a4mu3oszNDiguZvi2rI=;
 b=SqT6CzAGZxarzcTPVFopOPt2QdDQkCX2JUPcAO/CKtPBa0JKDHHpsdAX2TfxrtPLJK
 qjvfY3sxCzJT0HgvgFzUnL2dk9G0+eAL27s5duGqYKSoapjJXkjqKT1tk/5n84veF9yz
 m3sCKb1Grb196uGM3WWvnI9dyaFFT6e4Cda/m7M+Z972Rpu9DZRH/nlmyxANVS7tFrfx
 52xvjzmnAvyruFeD8TLbmjlMSvHi+3vvdSusLlEKxJdROH/WEDYGMnn310OP35/ksjla
 CIHq2SDhuSEBVUY+cbXBQjbIRBjYacuUvLAs4ml1AionQ0SSqPwpCfSOWyZdrjx3mdsE
 ZeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780296; x=1779385096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J0TVz6tP6rUprn0I+4uUdka/a4mu3oszNDiguZvi2rI=;
 b=cklPU0EENaCSlHZMTpcvhcsCxWZAXL93W93yBzV83ZJwI5dtKoz54SrSezL1lUFk+6
 Hr+On/7xKz60ao7GTupyPl8UdTOt9Q4PP69zB7nsUFG8OKS37lEL+1g3Oo0XURdBROIT
 fa7RqRCj3n9tgr8YzWvwoRIn4Zug4XZovP1VPpVSkVHsVUMAz+s9Y/Y0xaJESeTEJ3Z4
 WgJvdcSh9Trq+6UVeOxYwJirFcSswDblXvorN6Y7ZTeRkRgMjV3elzOu0HUoG9ZsfqLz
 6A+Vd7gMCx2z1D+n/vybGjrWanoOP7liY9wbkwnL/DL4KuaW8nVaVvmEoVGLj5k33Gmf
 2fxA==
X-Gm-Message-State: AOJu0YzLcVZn+NK9kgFPhPs1d0gFhga8Q6EVeH9K2ZQ+ddTkN65G79TP
 me+uQIDbmSm3iu/S04UYGDbRIFDbi6VhRiAkddWW/riqY4wcsUEOLghn
X-Gm-Gg: Acq92OH92yUp1ZlZWtqui1nb5k74UlLThuejcKs0lewZLjP52NAmsCaTPgjwhcS4Mls
 RHK/BHbgGkaW73BrPKvmzrmx2qrrGzxQnmgsgTl2p5yEchVOm9BDzqeT2ju7hukLU8CGBUn5bBz
 soEr+6N003MimC/LtRakKORg7Uky04Z+1E46LOUQGiY9B/DIhG6tTCdy25WI5vdbvOzoxpUqYgS
 0XQgIp2V8u4ZOysxE4YNxeOMhEVEsqbYmsVHcCEZk7ju7iEl9xFNUU01VRWwKKjNVAi+iec/9qo
 7J40STOi0UoYLFyy9kksr16BXc9h+EPIfNjS7o35LzMzO2S4VwKcBmxJ+8qWDZIfN4kEVwkk82K
 ADxw6d2Zv972Evm6T5JggaBujJwj0Rywx8oUOtgPorG2TOjL2l5CAOuFrSbQSbCCQI1B+/U9mkt
 MyTKCnQRAm5RadQJzO/FlCPRy2SVYPR27JFj7Rj4WSLb+FgeGbsv7PN7xrOjr/OUgPYaj/vhiib
 Jih0xbISsvRLPEWN3RnqQYo06/x5gnywqAaKZWSKkNBt7tT+Wjodj0wdmyMER5kEKAQ1UT6p94C
 PAo=
X-Received: by 2002:a05:6820:6ae3:b0:69b:b52c:c9b8 with SMTP id
 006d021491bc7-69c9bfaf1bdmr232273eaf.47.1778780296385; 
 Thu, 14 May 2026 10:38:16 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:12 -0600
Subject: [PATCH v7 23/35] target/mips: add Octeon V3MULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-23-226686be4ce1@gmail.com>
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
index c1c3506d20..2cdb7e4e76 100644
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
index 304aa58065..775f758369 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -318,3 +318,4 @@ TRANS(MTP1, trans_mtp, 1);
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


