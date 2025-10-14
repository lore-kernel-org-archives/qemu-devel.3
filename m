Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F897CCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lKN-0002xU-39; Tue, 14 Oct 2025 16:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lKG-0002ud-M3
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJC-0005QB-KZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:52 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so5302101b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472462; x=1761077262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWJnN+jorW56pvFL9FAVrG2EIYVvPCJhKpvjGKjU+iQ=;
 b=ekPPNwKhBhPkyFaL8ZnomrYE3MtQIj8+b/ZAvNzqNAEx2Dzq4+JFOIaicI6BKM8eEX
 yo/UbKIHPkHydstKY9TuM3W+vkFoG/3Q+r5xXv3vQ9zfz98PK56JLWwdgHChZCsjdfly
 mUgaLYKOkPoCeEuJF5ok13F0ZynS/ixJjpAgmKrQUcZtPqkledrxczYOuwBF++32XWH4
 AueJbZNI0g9nVxNm/SeER/Xed0AkK6AaJlrfYWEvutfjyuBGOVUAELFV6SzsK9zWgsxh
 tZ046mgrc0hg6kaZibkjkOFZjt1sRnp6onYIGCPuvH4b3vtonst48bfzuWWPTNRufjtr
 tjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472462; x=1761077262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWJnN+jorW56pvFL9FAVrG2EIYVvPCJhKpvjGKjU+iQ=;
 b=L1pzluRbOCxj+WrnQcXS8QtOt00jH5r8/mgmatXRTDUF55VtscbeKuAlapmQTkLqSd
 0yLWVIRk6LVRE0INl9MDfTc6rfsBxT5UGSJ4HbYrzoK1ywGMzm+WjeYNKu3kDgSLxACj
 On4GG4ztJG8iozOe5VK07G30MpWIJ7wN6RiXyVwde6cwGRqEOse0rjt4G+KCBIwF9J+e
 7RM5os03Zf20558W+5Ptpl/kJByILqr2mp6DxZKNkNKwOGebUd6swjHOj2o6BTHAHLvq
 quEgJSh3njTZk7KLE34YGcntEOUOpWFQT9mh13dQT43t8D+98bizUlTsBNaDLG0GNUMq
 jetA==
X-Gm-Message-State: AOJu0YzsY8LQW1Xv3FNkeMcKr68yIjeX0JTeGgw9jEVFbzFy7Mi0n9Ex
 lbiw6GwVd8O6Wjdz8ZmgxVkuHEVBRLpyQy1Dj0Lh9/yYOSQ1gHWZ1WjXXWFPmZxx2u/58to0Mo9
 4k5p5QSQ=
X-Gm-Gg: ASbGncsk9EsrX9t0XRK8B5QDJ0nkrHWaV9OgdvkosxTpAg564aVwhICn9+Y95uGbCe1
 oyPSCI6ITBCn8HvbOSjcg1Olx0g5b/axIINmkfP0dGInuFp5ERTTLOsEo29ADH0bvmRteB1Am8m
 zwp2NnAZaVuV9N8KU64n3vcYGFpS7VVTAvzO87BFpqa9ReE7AT4D0QAlAvJB8kluK1rtkJdpzJP
 yjLtayTpYhWrn5DrnsW0AozMVqVUebIj08bFGcN/ORrnLWqZLpCO9oiMWsdVogZ94wHev5DSzG7
 169DNHzbhfqQknpRDYMBrQsANipMj552i4OWvELJU9cIEAiHW+hHjQcraJYNcGRdiTRsdH779xl
 eQRXuEugAU0rDTN8LimyTPJFVCCki9dsbvClGqAzWSDiKx8GExJ+KIPCwTXUaEytAyRua+D+6
X-Google-Smtp-Source: AGHT+IFq97UG9+sL7j4M2hfXITnr0GH7kt7/wHD2SpfE6Oa4FHCh0lU++4BGh0iPbvZo/s70fVcbVA==
X-Received: by 2002:a17:902:e888:b0:267:ba92:4d19 with SMTP id
 d9443c01a7336-29027119eb1mr364968405ad.0.1760472462091; 
 Tue, 14 Oct 2025 13:07:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 32/37] target/arm: Implement TLBIP VA{L}E1{IS,OS}
Date: Tue, 14 Oct 2025 13:07:13 -0700
Message-ID: <20251014200718.422022-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/arm/tcg/tlb-insns.c | 96 ++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index c7583957b0..beacb92f32 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -442,6 +442,17 @@ static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
 }
 
+static void tlbi_aa64_vae1is_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      uint64_t vallo, uint64_t valhi)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
+    uint64_t pageaddr = sextract64(valhi << 12, 0, 56);
+    int bits = vae1_tlbbits(env, pageaddr);
+
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
+}
+
 static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -463,6 +474,21 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void tlbi_aa64_vae1_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t vallo, uint64_t valhi)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
+    uint64_t pageaddr = sextract64(valhi << 12, 0, 56);
+    int bits = vae1_tlbbits(env, pageaddr);
+
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
+    } else {
+        tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
+    }
+}
+
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
@@ -664,10 +690,11 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlbis,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlbis, .access128fn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVAE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
+      .writefn = tlbi_aa64_vae1is_write,
+      .write128fn = tlbi_aa64_vae1is_write128 },
     { .name = "TLBI_ASIDE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
       .access = PL1_W, .accessfn = access_ttlbis,
@@ -676,10 +703,11 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbis,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlbis, .access128fn = access_ttlbis,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVAAE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
+      .writefn = tlbi_aa64_vae1is_write,
+      .write128fn = tlbi_aa64_vae1is_write128 },
     { .name = "TLBI_VALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
       .access = PL1_W, .accessfn = access_ttlbis,
@@ -700,10 +728,11 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_vmalle1_write },
     { .name = "TLBI_VAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlb,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlb, .access128fn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVAE1,
-      .writefn = tlbi_aa64_vae1_write },
+      .writefn = tlbi_aa64_vae1_write,
+      .write128fn = tlbi_aa64_vae1_write128 },
     { .name = "TLBI_ASIDE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
       .access = PL1_W, .accessfn = access_ttlb,
@@ -712,22 +741,25 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_vmalle1_write },
     { .name = "TLBI_VAAE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlb,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlb, .access128fn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVAAE1,
-      .writefn = tlbi_aa64_vae1_write },
+      .writefn = tlbi_aa64_vae1_write,
+      .write128fn = tlbi_aa64_vae1_write128 },
     { .name = "TLBI_VALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlb,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlb, .access128fn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVALE1,
-      .writefn = tlbi_aa64_vae1_write },
+      .writefn = tlbi_aa64_vae1_write,
+      .write128fn = tlbi_aa64_vae1_write128 },
     { .name = "TLBI_VAALE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlb,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlb, .access128fn = access_ttlb,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVAALE1,
-      .writefn = tlbi_aa64_vae1_write },
+      .writefn = tlbi_aa64_vae1_write,
+      .write128fn = tlbi_aa64_vae1_write128 },
     { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
       .access = PL2_W,
@@ -1324,9 +1356,10 @@ static const ARMCPRegInfo tlbios_reginfo[] = {
     { .name = "TLBI_VAE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 1,
       .fgt = FGT_TLBIVAE1OS,
-      .access = PL1_W, .accessfn = access_ttlbos,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-      .writefn = tlbi_aa64_vae1is_write },
+      .access = PL1_W, .accessfn = access_ttlbos, .access128fn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_vae1is_write,
+      .write128fn = tlbi_aa64_vae1is_write128 },
     { .name = "TLBI_ASIDE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 2,
       .access = PL1_W, .accessfn = access_ttlbos,
@@ -1335,22 +1368,25 @@ static const ARMCPRegInfo tlbios_reginfo[] = {
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAAE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbos,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlbos, .access128fn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVAAE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
+      .writefn = tlbi_aa64_vae1is_write,
+      .write128fn = tlbi_aa64_vae1is_write128 },
     { .name = "TLBI_VALE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbos,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlbos, .access128fn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVALE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
+      .writefn = tlbi_aa64_vae1is_write,
+      .write128fn = tlbi_aa64_vae1is_write128 },
     { .name = "TLBI_VAALE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbos,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
+      .access = PL1_W, .accessfn = access_ttlbos, .access128fn = access_ttlbos,
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_128BIT,
       .fgt = FGT_TLBIVAALE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
+      .writefn = tlbi_aa64_vae1is_write,
+      .write128fn = tlbi_aa64_vae1is_write128 },
     { .name = "TLBI_ALLE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 0,
       .access = PL2_W,
-- 
2.43.0


