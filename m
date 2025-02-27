Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78336C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnesC-0007BQ-9n; Thu, 27 Feb 2025 09:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnern-0005aM-Kx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:28:00 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnerj-0004v6-Rx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:27:59 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so10717655e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740666470; x=1741271270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qe4aJgheLC+WLLda+xlMEOvgcnf2Z7Yw6J5SwaqcyMo=;
 b=CGLwn7x8yw+yL6mTLa1jg4a3zaxYhlHdWUFv6MC4K/YJ6evKK8X7edUSPmISQdCgvg
 vNj2yu/WUTtaye+yitDW7j8Axd90OBL1ZNMGvzgzZapD6vPjdiROQO9+DMPHHWdlA53C
 MjptXRI/7uzmIkaKs0+mV+UFaBNDupD3v7WvMRntfzWoXdDZnjxLbdP/bGv5DuzvtOGU
 s76HL5GHvMO1rsIkFAPifv+IcIBW4JL3eXkLrdgGqpctgrprSTsTv/6Bb2Z/0H+pawFl
 SFOeYgdYrD4zUbwPIZGfrUs6v8ZOiu1RpxRbKk2g6y0AGhbDNhpCDrAnFw6TssjVKg6F
 xe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666470; x=1741271270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qe4aJgheLC+WLLda+xlMEOvgcnf2Z7Yw6J5SwaqcyMo=;
 b=i8ltbFRu+ig7J1FBnNook/3TVywfXPibIoxQnIIfR5YBJJkGGnbJcKITMLRGvn0OiA
 FEAVPWzbljeeKojJp9G4heFpvk6KRYJ7K7r9/oYyEyGe7zkkO8VKO/Ruemp1lwucJDPa
 nBhps+ubxqxDWvPIzp0+WK5NNsk7I5bTyZSxzt6Mq+snmPIYV9qRevP/7O5s4v0KLEpG
 IR/W8sKMD/gtnb7yeICx5e47RdqW22yJdEMQNyIZrrD3la442hX6wSAdv1ESsNIL4iPB
 lUaClH3L0v/lv+sYDIy57lzU8FpH6k7gLEGq3Az8QuyhwouNpLnhNoYNrJy1VpeXbcVB
 roYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5RbhDdII4/NHwc/yiBrhA+DNMe2n//zWtDsZvaPul0SEYnPCHY3I1j/mMwJayaPvdZziY8MVB2awW@nongnu.org
X-Gm-Message-State: AOJu0Ywh57uEnRwgDs44hpWU91K4Qi4j4WlEyXdAkTCvM70Ywm6+XRil
 f3IbsGA0g1AASNwfudqHc4A6w3myXOESf/IP7S1eCjzVbICr9vCiIn1Met3FYO8=
X-Gm-Gg: ASbGncv81KPGT7r3Kw5kymaspL1uHCHtrEoKu9G3TAmUqp+I02kxzqLXEuAUxACwjY2
 1csQkVsPQbo7jXiLv+GfFP4q6Hdi640oQF3TYsp/PGNMLp8c+Pfeic+8mvLIY6Vg4r0U3VRiaC6
 N2q7WT2o8v328+QWvZLDbYMSjnAARosTAtad1Aq0MNitgEB8xaqsYp/DX1KWDyTGqinK64EI4jx
 CVdeg7EQ2MNZbkKTUZiFL3uQF3tOWGvg+uHJTvNBNbxKOcfnt+SMJQnCHldAIQweUtTcYyaDBo3
 KfyV/TRgHIlzVnovJ1OIXbPZrbxRm3CM
X-Google-Smtp-Source: AGHT+IGrwyync3NgMser08FgjGaCoYCZ7pdwQubFTuUt3KuoUKEYGIRTn2JptuI0nzgaPodEJy0A2A==
X-Received: by 2002:a05:600c:5252:b0:439:88bb:d025 with SMTP id
 5b1f17b1804b1-43ab0f26e5fmr110547285e9.1.1740666470162; 
 Thu, 27 Feb 2025 06:27:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532b8dsm55968335e9.14.2025.02.27.06.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:27:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/arm: Correct STRD atomicity
Date: Thu, 27 Feb 2025 14:27:45 +0000
Message-ID: <20250227142746.1698904-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227142746.1698904-1-peter.maydell@linaro.org>
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Our STRD implementation doesn't correctly implement the requirement:
 * if the address is 8-aligned the access must be a 64-bit
   single-copy atomic access, not two 32-bit accesses

Rewrite the handling of STRD to use a single tcg_gen_qemu_st_i64()
of a value produced by concatenating the two 32 bit source registers.
This allows us to get the atomicity right.

As with the LDRD change, now that we don't update 'addr' in the
course of performing the store we need to adjust the offset
we pass to op_addr_ri_post() and op_addr_rr_post().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 55 ++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index e10a1240c17..2020d18f019 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5057,10 +5057,38 @@ static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
     return true;
 }
 
+static void do_strd_store(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
+{
+    /*
+     * STRD is required to be an atomic 64-bit access if the
+     * address is 8-aligned, two atomic 32-bit accesses if
+     * it's only 4-aligned, and to give an alignemnt fault
+     * if it's not 4-aligned.
+     * Rt is always the word from the lower address, and Rt2 the
+     * data from the higher address, regardless of endianness.
+     * So (like gen_store_exclusive) we avoid gen_aa32_ld_i64()
+     * so we don't get its SCTLR_B check, and instead do a 64-bit access
+     * using MO_BE if appropriate, using a value constructed
+     * by putting the two halves together in the right order.
+     */
+    int mem_idx = get_mem_index(s);
+    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
+    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_i32 t1 = load_reg(s, rt);
+    TCGv_i32 t2 = load_reg(s, rt2);
+    TCGv_i64 t64 = tcg_temp_new_i64();
+
+    if (s->be_data == MO_BE) {
+        tcg_gen_concat_i32_i64(t64, t2, t1);
+    } else {
+        tcg_gen_concat_i32_i64(t64, t1, t2);
+    }
+    tcg_gen_qemu_st_i64(t64, taddr, mem_idx, opc);
+}
+
 static bool trans_STRD_rr(DisasContext *s, arg_ldst_rr *a)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     if (!ENABLE_ARCH_5TE) {
         return false;
@@ -5071,15 +5099,9 @@ static bool trans_STRD_rr(DisasContext *s, arg_ldst_rr *a)
     }
     addr = op_addr_rr_pre(s, a);
 
-    tmp = load_reg(s, a->rt);
-    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
+    do_strd_store(s, addr, a->rt, a->rt + 1);
 
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = load_reg(s, a->rt + 1);
-    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-
-    op_addr_rr_post(s, a, addr, -4);
+    op_addr_rr_post(s, a, addr, 0);
     return true;
 }
 
@@ -5207,20 +5229,13 @@ static bool trans_LDRD_ri_t32(DisasContext *s, arg_ldst_ri2 *a)
 
 static bool op_strd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     addr = op_addr_ri_pre(s, a);
 
-    tmp = load_reg(s, a->rt);
-    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
+    do_strd_store(s, addr, a->rt, rt2);
 
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = load_reg(s, rt2);
-    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-
-    op_addr_ri_post(s, a, addr, -4);
+    op_addr_ri_post(s, a, addr, 0);
     return true;
 }
 
-- 
2.43.0


