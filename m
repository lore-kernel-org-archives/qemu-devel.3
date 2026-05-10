Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3B7CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx6-0005AW-7R; Sun, 10 May 2026 16:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAww-00058E-O9
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:32 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwv-00044y-2w
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:30 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479d68a9063so1308853b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445627; x=1779050427; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uCf8aBPivyQ3mrfdlj8fPxnf79ijvyOfLBE8cCRj050=;
 b=PC9nluJNYbVh2qresZPg8vYAlTQ7ryq8zJa0jjNVakgpH7IJ2yeqjrIhjuJT+ebFQ7
 huu13uOtX/rQI+tCr0UMUBtdcyj2ndIQgMBF/673JSe3XnFnVxaCGqk3vuIzK9qR2Foj
 Jwath06uLoL8UHgHY8ifu9U7S2rvIXuTITG9JC7FGBERC2ikRrqmGuDJRg7kw33xRa20
 CctTmpnCcnFT5v3430EnpJAiy7fU39DKfdoYkBuOaRf6x4KoXqbKwrg2j5qFrRv+0ktG
 BtCZeyJsAICybQAEVZoKdPNa8GvyQ1ukY9NRxVJB8BbKrFLtQkm4TWRdQmLJJCoLOBwy
 16ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445627; x=1779050427;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uCf8aBPivyQ3mrfdlj8fPxnf79ijvyOfLBE8cCRj050=;
 b=q2MjpE1iiFE7qy6qhuXvKNyfeei0ChcAAg94JxvgxUj6CCxLOukwgw1swEYePNi7fL
 OlT6tFfbHwBQ20pnvKdDW9EDddrA0ASbKiJSyiQ9Azhp7GZhd5MvUG3zPHCLXBIY2flr
 Zv7YgEAjee1EJCRLSZfSmW8V3nhTQS4NiPojmhscgWufabyy3GUlV+ciXtJYsOM48YDh
 ETvrnZNj1DW/BML8caFhTxhUk4p1ygYZErbEuKYVGBRmX2rqwONOQNek7f/Kd+i4kefs
 A4t+OkATmJH6UPSVWz8dSFaIp1L/SKScd70/GrnnqXwckvGnT2HOlMXTI0w7coL+JpXM
 70qQ==
X-Gm-Message-State: AOJu0YxOvTg+i55MBTn1iM26kWhhxAJiObF/Gyr9E4aLNiSMTu0mGd68
 BgGEPZP2Maw5HSPFfCVO/razeaOzeVMuNq7zxtqkT0qcXHbmDx1UhB992CfZu0Z9
X-Gm-Gg: Acq92OGul06JRQSMLedtFaUseMzELWluFLE/FnbiWy92Dfr1etB4fDcebElkdxbOmQ9
 g3vf1lzd4JBjrS1iQpf4nEIOMeb/gvROxP799HlGzCtsq+FFc9hzPlgfyRJg6xeU98mvbQJUnnf
 g+TBu+6mrPMddr/7ozCSrNTugQqyLHivbNGmgRosdV7U0ifjubJMuqLscus1Fihdc5WRo5hN/G8
 PVTl0w+Yox9nsZeLts/0l2A4QHlvq0CHnDbyCOuQ+vgTsnrHoRHAc0fOxgVE2fm+iHAHGH79yzm
 sh2EKbhOuHYR1ep1im4e8GQQETZrvUMe19VNVShoIHLRmFTi3L3n9T3TxDt+kNnG4ZEHbPNRSM4
 IQ51bFyVhfRcbkQVdNrmXPdO+S+LFq8KVVyM/7GFc3G+IupImvRoaCkfYxGXrmtLSX9Y7QJPY7U
 Jbyx2LM3DZIVnTAqeOYPFHUDjSzKBrqPOSZcFqSIqKV5/XehxSqPZgNxWgqEua6FZqrZmlxpg6h
 Qa/zCueFCyTEDBPF7M0slC0dfEurD9U8bHix7Jo46My/7HTg+P+zQ==
X-Received: by 2002:a05:6808:150f:b0:479:ac7d:6d91 with SMTP id
 5614622812f47-4824aac6facmr4102899b6e.39.1778445627445; 
 Sun, 10 May 2026 13:40:27 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:52 -0600
Subject: [PATCH v5 22/32] target/mips: add Octeon VMM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-22-d5d2668d15ab@gmail.com>
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

VMM0 performs the VMULU accumulation, returns the low result, then feeds
that result back into the MTM0 multiplier state with a zero high operand
and clears partial products.

Add helper and translator support for this multiplier chain-update
operation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split VMM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 MTM0-style high-lane update and set MPL[3] to zero
    when feeding the low result back.
---
 target/mips/helper.h               |  1 +
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c |  1 +
 target/mips/tcg/op_helper.c        | 16 ++++++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index f1e78ae329..46ccad95c3 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -25,6 +25,7 @@ DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 DEF_HELPER_3(octeon_vmulu, i64, env, i64, i64)
+DEF_HELPER_3(octeon_vmm0, i64, env, i64, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 75834afc6c..c60af2d39a 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,7 @@ MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index d39f904e73..63e2719b1f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -297,3 +297,4 @@ TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
 TRANS(VMULU, trans_vmul, gen_helper_octeon_vmulu);
+TRANS(VMM0, trans_vmul, gen_helper_octeon_vmm0);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index ab3fb06a16..124855d4dc 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -176,6 +176,22 @@ uint64_t helper_octeon_vmulu(CPUMIPSState *env, uint64_t rs, uint64_t rt)
     return sum[0];
 }
 
+uint64_t helper_octeon_vmm0(CPUMIPSState *env, uint64_t rs, uint64_t rt)
+{
+    uint64_t lo = helper_octeon_vmulu(env, rs, rt);
+
+    /*
+     * Complete the VMULU accumulation, then apply the MTM0-style state
+     * update with the low result and a zero high operand.
+     */
+    env->active_tc.octeon.MPL[0] = lo;
+    env->active_tc.octeon.MPL[3] = 0;
+    for (int i = 0; i < ARRAY_SIZE(env->active_tc.octeon.P); i++) {
+        env->active_tc.octeon.P[i] = 0;
+    }
+    return lo;
+}
+
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
 target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
 {

-- 
2.54.0


