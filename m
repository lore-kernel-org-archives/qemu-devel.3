Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34450CCD196
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lKI-0002ur-Cz; Tue, 14 Oct 2025 16:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lKA-0002nV-Aw
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJA-0005Pw-N4
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:45 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-781010ff051so4152090b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472461; x=1761077261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1HXAga8NsrRrTAL1Ri+/I+45ifsoA4Nqr/eKxaAD+I=;
 b=pjQLYvDQ1yhr2SrN4XYYEbnLAqjramv6IkkXLFNqersxRpQeOeqPkYexdlvDujLQ7o
 xHWKYmEmr+HYETzS6KHvpAZVMle/YXCkDJV8hqebDelD7O8mu6F2ylX3Sb98/KNHp5+c
 vIY1ik80Z+tvOtdMD0GPqdfSdcCFGKxiX0F0tsmHKE+fIeuTf0aOckY8aXfzLPfAyfQ/
 2JDHK44MmWuaue23UMk5YT/5OjlBtvtiDIF3BKVOpv2/hch7ANWXTiIGIqa3G/GNWfg0
 cRfXAOjnoJomQKAfLozW/IoM68fuTigdKbgFp/5mUZlx9PQhB0qap2LNkcHixMdwv+LL
 h9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472461; x=1761077261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1HXAga8NsrRrTAL1Ri+/I+45ifsoA4Nqr/eKxaAD+I=;
 b=Go2r1/hPuL2lwJdS7rQgp+1Cc/Q4hqW4sFFQvuByyXZxNo9TqRKfKa7GduhibJHNva
 tbYWxU59n6g8g8Y5P7XApN8ftwMxmtrnrymPOPLnSDaWhIPGZBfduftk+xBrIFWGVX66
 fbDUDVtxJkPrBQ5St1ZY2fS5qxha0Bc6nMd/OUG56GR+2HtMY9j6IXG79xlDqYoV5Yi5
 BwsZEmYMZf2JZ98UfNV1u3oEyUbjs/KXGHKFb8CSICfX7whBzBJFaCbzORoIet4rPpX8
 SgkCbRqyXmgw+UMJE+rRChMrOYbSFlux6T5uOp9ilm2CwHmGP8qroWddOQ+WnXGrileu
 Momg==
X-Gm-Message-State: AOJu0YwmG23f2hdbfVRDDkyYRN23pDGYBOCnK4m5Zxwn6ksos7eE0/fG
 Vs0pbXLrMEsuNmpjwFEbgw+R2cj3BB1fgZACVjLn6K0v07oWs/xTqkJ+pu/LQNm0JD+soh05bXw
 mNDksK6I=
X-Gm-Gg: ASbGnct+v6EFeCHqUECx90OAzUb6tOyMTSeSSmCyS473gNo1itBdGOfYM97WDWk3XiX
 sizxUskdoeBW3+He3qp3tKIKk9oEqWVIKXNv3bog15roPLa02dk0vRF8rdE1brkszvRjb68PHfN
 tJvoSJRC3weDw862OVOp5cjHnFFa89evbcXnnQ0bOjpCCQTt5HOse3Co7tOE7CgC4BPp8cwP1vl
 oDqY/GHnoI2O3nysxvJOuDx7X+ehdz+SYQN/sPNx6TuSjBfKYAF4iWmtGwruLELQsJb2FaHZWfm
 kIYmDwo3oldFm1OqAjhO5zf1q8w/ys6ZYkjOgiIB037uHerEBCB+iC6c35kLZ1EONAv/8rNEuJx
 fFSrR2/9S8sl2zAvBqNeQjU/ACiC78qChWDFSKDech1gCb8JQxM9KRFpp5k4ovnNqsgW9ZMIR
X-Google-Smtp-Source: AGHT+IHBjaP8HBExhWP/blRTgUr5bperyPim6I27GBqc2LHTrZPDvG5Ws6Aub0uJ8VlToFZSZncu8g==
X-Received: by 2002:a17:903:2409:b0:290:52aa:7291 with SMTP id
 d9443c01a7336-29052aa8299mr171944845ad.53.1760472461456; 
 Tue, 14 Oct 2025 13:07:41 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 31/37] target/arm: Implement TLBIP RVA{L}E3{IS,OS}
Date: Tue, 14 Oct 2025 13:07:12 -0700
Message-ID: <20251014200718.422022-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 53 ++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index cbab7f81f9..c7583957b0 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -1073,10 +1073,17 @@ static void tlbi_aa64_rvae3_write(CPUARMState *env,
      * since we don't support flush-for-specific-ASID-only or
      * flush-last-level-only.
      */
-
     do_rvae_write(env, value, vae3_tlbmask(), tlb_force_broadcast(env));
 }
 
+static void tlbi_aa64_rvae3_write128(CPUARMState *env,
+                                     const ARMCPRegInfo *ri,
+                                     uint64_t vallo, uint64_t valhi)
+{
+    do_rvae_write128(env, vallo, valhi, vae3_tlbmask(),
+                     tlb_force_broadcast(env));
+}
+
 static void tlbi_aa64_rvae3is_write(CPUARMState *env,
                                     const ARMCPRegInfo *ri,
                                     uint64_t value)
@@ -1087,10 +1094,16 @@ static void tlbi_aa64_rvae3is_write(CPUARMState *env,
      * since we don't support flush-for-specific-ASID-only,
      * flush-last-level-only or inner/outer specific flushes.
      */
-
     do_rvae_write(env, value, vae3_tlbmask(), true);
 }
 
+static void tlbi_aa64_rvae3is_write128(CPUARMState *env,
+                                       const ARMCPRegInfo *ri,
+                                       uint64_t vallo, uint64_t valhi)
+{
+    do_rvae_write128(env, vallo, valhi, vae3_tlbmask(), true);
+}
+
 static void tlbi_aa64_ripas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                      uint64_t value)
 {
@@ -1265,28 +1278,40 @@ static const ARMCPRegInfo tlbirange_reginfo[] = {
       .write128fn = tlbi_aa64_rvae2_write128 },
    { .name = "TLBI_RVAE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_rvae3is_write },
+      .access = PL3_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_rvae3is_write,
+      .write128fn = tlbi_aa64_rvae3is_write128 },
    { .name = "TLBI_RVALE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_rvae3is_write },
+      .access = PL3_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_rvae3is_write,
+      .write128fn = tlbi_aa64_rvae3is_write128 },
    { .name = "TLBI_RVAE3OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_rvae3is_write },
+      .access = PL3_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_rvae3is_write,
+      .write128fn = tlbi_aa64_rvae3is_write128 },
    { .name = "TLBI_RVALE3OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_rvae3is_write },
+      .access = PL3_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_rvae3is_write,
+      .write128fn = tlbi_aa64_rvae3is_write128 },
    { .name = "TLBI_RVAE3", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_rvae3_write },
+      .access = PL3_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_rvae3_write,
+      .write128fn = tlbi_aa64_rvae3_write128 },
    { .name = "TLBI_RVALE3", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_rvae3_write },
+      .access = PL3_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_rvae3_write,
+      .write128fn = tlbi_aa64_rvae3_write128 },
 };
 
 static const ARMCPRegInfo tlbios_reginfo[] = {
-- 
2.43.0


