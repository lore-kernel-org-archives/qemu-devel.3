Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C31CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11x-0005PR-GG; Thu, 07 May 2026 11:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11t-0005Ak-L5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11r-00040c-Uu
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so12902015e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169166; x=1778773966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6KpHX1ryLYosOGLgFW7TiOUDrkT4gCAlAvCWeyLY/oI=;
 b=xmdVPEHw+tyEfx0VZ157s8dWnNBl6O+2F+KgwX2DukkFJ7vZXNKs5Opxqz6/jdssar
 3l9YpwUlOapEl6MJgLDEkHlWBEN8EGaEA/3hpDkfy6TaGwjbInvQiVrLGhoKjF9axpaG
 1mpTBru+l1mEtO6AiJ5FMXGjl4Z5LZOAyR/J28lfirk1V622Do5fzAGSMnOYaOsViG2p
 MXQ2QvJvXbMi2rBfbygkzW1XmShxEC2eC+wysobrvaqph6aVIerhV0AbhcrKijoPZX9B
 Q276IOdhPStnObVEn6IqDuFFX0oEJaoPBsvsPxHFLZtlmQbunxVdMUslCIRcSpkEC9Av
 UUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169166; x=1778773966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6KpHX1ryLYosOGLgFW7TiOUDrkT4gCAlAvCWeyLY/oI=;
 b=VrDRmFHQ3vzYTPg8UrOYhStvSDHFkdTuG5qCRcmJTSF01zBKg93m+9pEpMOh3zN2Ue
 sHoc8OdeapJkddwE0/w0tvCH9GWUk0EkbwrBuHdy3yO7QiHbzdO5uIr0pTlc+0VMw1GP
 IRIV0M0BCBaFZIRs4gJDO6kynWTWP8dEqcvX7sylgW1FrT270jMto0JFnm0B5Luoz5oy
 oVMtKYWa1Uh+eK+mhSWRPOSxAy/S3FA9/K82TUaNyisiah+HrlHZAxI4oGPFytq1BdLX
 XLRyO8p4sWYK1n4obwUXLfNQqybrA+UJ68YvoVKDNGmiiHPczlxyKIsTOR+8OrKLcjZH
 A/2Q==
X-Gm-Message-State: AOJu0YyxrZANJA6z9U4X/GB27FatAiPb+D76fLG7KFseNqKrZb4Bcy6y
 prNpTdQmZ96C7uAmY/qr0LbaeKvJspXJLAnHoa9flKT843XTeYCBMenZgJr/23PL1ZgKHdaLi2P
 lJ63O
X-Gm-Gg: AeBDievqUJb0OZWvd18edZ2cT62gnISUpxNEhLbMwUJtlfMmWz+Pa480mvByB/q4anv
 sdxq99uKEUMGIkuWlq7RJCL1H/zCnMzLDq2qVQtEbkQlXW0f96kUNAXsBUYZ2WVWwIsJWegY8hp
 C41Pr8WKJb1bRDnojpBDMpvkZKKbGRNA48zQHioxJaJxBnZU09tLM9mLyhn6lNsVhs6lA9HoJPu
 4WKV/8iiJwlj1bt5ynkVjl1ly9V7gQegricX2n/TqNBjZ4tkbTUuzfwUh7AAV6mZEaYy11pMvuU
 /au/bk4u32TdHWAj9HHUAVm1uDeKQfZKiPabpJ7eUMwqqP2Wr8Q7BvTD3rP2IS8qKs/cbVfAM3b
 mr8sAZA7l0Bj9HaaPUgNPg/kquB5xWqa/mbkxGzMTagR7sfiUrKoWKdk8Q5jXuBBNzl3PdDdu8l
 MHOemziznvpPKuSfKtU+rWL5V+rCLhKD9ATz0Vx2FjQFVzdlVTCjIjVwkTFNVahtAn65OlR7esD
 3W5WsUX7Qrz5KoqtvkFhP2xcKEapocR3hXKugo6Wg==
X-Received: by 2002:a05:600c:47d3:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-48e51f37358mr86818975e9.16.1778169166123; 
 Thu, 07 May 2026 08:52:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/67] target/arm: GICv5 cpuif: Implement GIC CDDI
Date: Thu,  7 May 2026 16:51:38 +0100
Message-ID: <20260507155154.1886557-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Implement the GIC CDDI system instruction, which deactivates the
specified interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-52-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 49 ++++++++++++++++++++++++++++++++++++
 target/arm/tcg/trace-events  |  1 +
 2 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 5e613362bc..9dc754ff3a 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -17,6 +17,9 @@ FIELD(GIC_CDPRI, ID, 0, 24)
 FIELD(GIC_CDPRI, TYPE, 29, 3)
 FIELD(GIC_CDPRI, PRIORITY, 35, 5)
 
+FIELD(GIC_CDDI, ID, 0, 24)
+FIELD(GIC_CDDI, TYPE, 29, 3)
+
 FIELD(GIC_CDDIS, ID, 0, 24)
 FIELD(GIC_CDDIS, TYPE, 29, 3)
 
@@ -570,6 +573,47 @@ static void gic_cdeoi_write(CPUARMState *env, const ARMCPRegInfo *ri,
     *apr &= *apr - 1;
 }
 
+static void gic_cddi_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    /*
+     * Clear the Active state of the specified interrupt in the
+     * current interrupt domain.
+     */
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDDI, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDDI, ID);
+    bool virtual = false;
+
+    trace_gicv5_cddi(domain, value);
+
+    switch (type) {
+    case GICV5_PPI:
+    {
+        uint32_t ppireg, ppibit;
+
+        if (id >= GICV5_NUM_PPIS) {
+            break;
+        }
+
+        ppireg = id / 64;
+        ppibit = 1 << (id % 64);
+
+        env->gicv5_cpuif.ppi_active[ppireg] &= ~ppibit;
+        gic_recalc_ppi_hppi(env);
+        break;
+    }
+    case GICV5_LPI:
+    case GICV5_SPI:
+        /* Tell the IRS to deactivate this interrupt */
+        gicv5_deactivate(gic, id, domain, type, virtual);
+        break;
+    default:
+        break;
+    }
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -627,6 +671,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdeoi_write,
     },
+    {   .name = "GIC_CDDI", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 2, .opc2 = 0,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cddi_write,
+    },
     {   .name = "GIC_CDHM", .state = ARM_CP_STATE_AA64,
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 2, .opc2 = 1,
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index fcb3106a96..c60ce6834e 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -6,3 +6,4 @@ gicv5_recalc_ppi_hppi(int domain, uint32_t id, uint8_t prio) "domain %d new PPI
 gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt failed: %s"
 gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
+gicv5_cddi(int domain, uint32_t id) "domain %d CDDI deactivating interrupt ID 0x%x"
-- 
2.43.0


