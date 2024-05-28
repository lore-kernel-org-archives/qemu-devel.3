Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D9CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3U0-0003LX-7F; Tue, 28 May 2024 16:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Tf-00034s-6f
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:24 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TQ-0003ih-R5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:22 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f6911d16b4so1078585b3a.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928266; x=1717533066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrONSqgx4zxoEQQCzSdQWDr8PF7f3aaT8NZI2DUfvUQ=;
 b=KL9EFpommUZik266QP3OMS1ZjIC7ufrga+/+hjZTY1lwV5B5Fae8vnH8y1U1eErfGi
 qipevplP/GGsNiZQ04qwBs5GqWChICkqIN/ZlBJxw2yKK0iva5vOvnbnRhhEWkISUSE0
 Tcv4Buw+eL72naW2NnUDWiZtO6dnvZcIgoDZ+hGCPVorpb0unLr9S5NQ9WnwPhDZ4PQF
 rdHfy7W0FnQnmK9rhfLRnjk84uzpi3EZqDXo5vWmT3+P6PTrXa451B88Q7kRXZu7Vmje
 gXuDK2W4X+7+205rxyIi0bX37ev/RWktLixXn4J4wZXTxDCTjzDpnANAXI/R2LIrtYf9
 mAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928266; x=1717533066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrONSqgx4zxoEQQCzSdQWDr8PF7f3aaT8NZI2DUfvUQ=;
 b=SBEKGpes2ttdVsI0/PhLfL7zlSSpG87ABOFaYJqyDrpbHxWYGxvEv5rVD491KoclTv
 O+xtif94Z4qlEU/WiKYQunE7rPQqQjvs0OEQb2UHAVcxCoAlqNhv7iPtMt14feLxvLCE
 NP7LsIoiLoWZejnQpj984lnMzwtdnHelMdtHcucsquFKFVYdyFPfFXjs4/YEBMhtT9Nb
 Og8KolUyE+sz2A1JIXRgHfGmOEfsgO8eLuZvss+mtCDnn+5CpFAWU4ux0Q9KXKULzDeQ
 +7O4rsNZSxzajBXTvxcZPwhUjB6xUL05Fk90gPmXsGLz5peyBDRnAj0CY+qciaIDuBWL
 iCEg==
X-Gm-Message-State: AOJu0YwZb8zeHGxbhksDR4m/p327NyxL9fFcz2ArNl0+Vv9PjMfvUWDE
 eDCBQY07IkXDjnbHFBUUxXBHwV2MnYS8dkTh0dAzSHJgAQ9NtUbVeASH9rJ5h5DhWTlLnp96TIl
 y
X-Google-Smtp-Source: AGHT+IGpLAM/clfoDuJP/24kncY/vB5e9ZnpcLaZFZoxofJO9cmVs78RdcofFc214qbk3HqSrWnezA==
X-Received: by 2002:a05:6a00:90a9:b0:6f3:ee60:54bd with SMTP id
 d2e1a72fcca58-6f8f30847d3mr13018042b3a.8.1716928266381; 
 Tue, 28 May 2024 13:31:06 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 23/33] target/arm: Convert SHSUB, UHSUB to decodetree
Date: Tue, 28 May 2024 13:30:34 -0700
Message-Id: <20240528203044.612851-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e33d91fd0a..b1bbcb144e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -914,6 +914,8 @@ CMTST_v         0.00 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 CMEQ_v          0.10 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
+SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
+UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 63f7a59f94..6571b999f4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5456,6 +5456,8 @@ TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
 TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
 TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
 TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
+TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
+TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10923,7 +10925,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         }
         /* fall through */
     case 0x2: /* SRHADD, URHADD */
-    case 0x4: /* SHSUB, UHSUB */
     case 0xc: /* SMAX, UMAX */
     case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
@@ -10949,6 +10950,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
+    case 0x04: /* SHSUB, UHSUB */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
     case 0x07: /* CMGE, CMHS */
@@ -10967,13 +10969,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x04: /* SHSUB, UHSUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhsub, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shsub, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


