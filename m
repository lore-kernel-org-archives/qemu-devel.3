Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536A4CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHo-000066-H3; Tue, 21 Oct 2025 16:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHm-0008MM-PW
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHf-0001AM-HF
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso49330595e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079712; x=1761684512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pei0AdkMqlz6V/L6oMzpf8FvPBD/sRAI8O8+4qZkUW8=;
 b=qiiMEh4/jc+jC0lgk3hj596oDw/5/k34C2CdOZTlWV6IsiT6f6HNAfePI/PCQoVj8Y
 btfncNyP8QpnudN6SjyYgZbuDGGVlZ8QTmGpGhKfA7UBF82IbUb0+7YiSUklYKB+YOLd
 Vi+NbTkZJsJB64Z0NBPSTxt8RCKtFtf4aT7/HGBvElyzZ8S1fVNmxO2Xzz4jdXxouJru
 2MfwRhVXO6K3xA4g9P8J1P67ev/wFMcDOCNqFAjTTsvBvHx4PaHJmDTWqCGXYwx4voma
 3bwDnjPFXGBOpQ/5OEswCxS11sh2xXUYN7Y4JYuCLbEqzeMwE+lgAIfKbovR8pxjauXr
 WBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079712; x=1761684512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pei0AdkMqlz6V/L6oMzpf8FvPBD/sRAI8O8+4qZkUW8=;
 b=CzLOG5RrL0jgIWcNX+yyAqf8W4y50EjCg5yZZFklNO0MgZ/lD2XlLoOGUhMuI3o/D1
 0JIwTDtdrmudeLGlKjrs52F+Ty7qtL85YVYq6nx8pYEY+M3abXZPSipT8B62HBaI2qal
 6QFtZ3uidxm8VpkHBd07CMOxZ4JLORhM8VMzak+k7yG493oyR7+wx8e9br6NE8LVz8DP
 cRU+5MSqMZ8Fu09t2W6XXSs3uQm8Wo5DvfQtJp/uc9jiM9HI7ASNTBQwmfdLCjTJMGWJ
 JFDJNEnAHf2wmE9PvhaOJEEbZ9IyXI3HCHmw+DK1gemyyN3aG9BR/FikZ9YWIDIjffwW
 /lIw==
X-Gm-Message-State: AOJu0Yw5OzAD++srY5tHvMrIlX3rJibhs7q7zcA0tNuxmiNxEIG3/orK
 BzKb+TDQCjVxhSwlnV3vkESB6BAuXKrrY6XKVeJkmlyUSK/6WDIh1s3Gu/1w2aUbBG5g/NF0bXC
 VBcr4YsY=
X-Gm-Gg: ASbGncuuCgtG0Kl7DFSs3q6iDoWnaME1WveXs5hlc90rEbAnWQZOLytZl0RJKaTRVN1
 ahEWXFoSmzHSexlDjbdbTfJQZ0VJWWsOsR8tO4XOO0Z3tkLFAzQbodHyx0Sh1ADM6Ycj0pBqr1N
 eCdkK+l8GXq5TMZhjA54ijP1G084SLqx7HugGFKvRi3v/JJL5zgvfCk+0c9Mp5iqjuYCoz4Urkt
 V1acqZt5ks1XsolfkY5cEz7XbsRyjocLehwhiF4sXbqIiPMJpjnMdQjEYyyl/DrdVxkoD7wqZcL
 3eLWb30N/Gp4GGQc+y3PejVnhIPpR8Dhb+mNuoQVnNmYW2fb0kzPIryNoDcoYFzUnHXIpr5rZO8
 D7+h3RrobS8kb48WHe8KvffpG+JJCxrkY7LI0ACYzxi1gUE7iwtbpxZXZWBMCtDBf9ROkBRDta0
 HlN3ii4u362gbw2Vce5QMYFWEQX06rpulh9win4O5WuqEuCLg9ig==
X-Google-Smtp-Source: AGHT+IHuwOWcJFZkWWTKV3RGK4+mLSBbXoeQsLIDXhvbLPv6GINQYv7MAY6ql2HK2qzEx5orV3g7eg==
X-Received: by 2002:a05:600c:4e11:b0:471:c72:c807 with SMTP id
 5b1f17b1804b1-471179079c7mr151247325e9.22.1761079712462; 
 Tue, 21 Oct 2025 13:48:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4378cbesm9195005e9.16.2025.10.21.13.48.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/45] hw/core/register: remove the calls to
 `register_finalize_block'
Date: Tue, 21 Oct 2025 22:46:33 +0200
Message-ID: <20251021204700.56072-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Luc Michel <luc.michel@amd.com>

This function is now a no-op. The register array is parented to the
device and get finalized when the device is.

Drop all the calls to `register_finalize_block'. Drop the
RegisterInfoArray reference when it is not used elsewhere in the device.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
Message-ID: <20251017161809.235740-4-luc.michel@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/xlnx-versal-crl.h      |  1 -
 include/hw/misc/xlnx-versal-xramc.h    |  1 -
 include/hw/misc/xlnx-zynqmp-apu-ctrl.h |  1 -
 include/hw/misc/xlnx-zynqmp-crf.h      |  1 -
 include/hw/nvram/xlnx-bbram.h          |  1 -
 hw/misc/xlnx-versal-crl.c              | 38 +++++++++++---------------
 hw/misc/xlnx-versal-trng.c             |  1 -
 hw/misc/xlnx-versal-xramc.c            | 12 ++------
 hw/misc/xlnx-zynqmp-apu-ctrl.c         | 12 ++------
 hw/misc/xlnx-zynqmp-crf.c              | 12 ++------
 hw/nvram/xlnx-bbram.c                  | 13 ++-------
 hw/nvram/xlnx-versal-efuse-ctrl.c      |  1 -
 hw/nvram/xlnx-zynqmp-efuse.c           |  8 ------
 13 files changed, 28 insertions(+), 74 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index f6b8694ebea..49ed500acde 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -533,7 +533,6 @@ REG32(VERSAL2_RST_OCM, 0x3d8)
 struct XlnxVersalCRLBase {
     SysBusDevice parent_obj;
 
-    RegisterInfoArray *reg_array;
     uint32_t *regs;
 };
 
diff --git a/include/hw/misc/xlnx-versal-xramc.h b/include/hw/misc/xlnx-versal-xramc.h
index d3d1862676f..35e4e8b91dd 100644
--- a/include/hw/misc/xlnx-versal-xramc.h
+++ b/include/hw/misc/xlnx-versal-xramc.h
@@ -90,7 +90,6 @@ typedef struct XlnxXramCtrl {
         unsigned int encoded_size;
     } cfg;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[XRAM_CTRL_R_MAX];
     RegisterInfo regs_info[XRAM_CTRL_R_MAX];
 } XlnxXramCtrl;
diff --git a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
index c3bf3c1583b..fbfe34aa7e5 100644
--- a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
+++ b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
@@ -85,7 +85,6 @@ struct XlnxZynqMPAPUCtrl {
     uint8_t cpu_pwrdwn_req;
     uint8_t cpu_in_wfi;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[APU_R_MAX];
     RegisterInfo regs_info[APU_R_MAX];
 };
diff --git a/include/hw/misc/xlnx-zynqmp-crf.h b/include/hw/misc/xlnx-zynqmp-crf.h
index 02ef0bdeeee..c746ae10397 100644
--- a/include/hw/misc/xlnx-zynqmp-crf.h
+++ b/include/hw/misc/xlnx-zynqmp-crf.h
@@ -203,7 +203,6 @@ struct XlnxZynqMPCRF {
     MemoryRegion iomem;
     qemu_irq irq_ir;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[CRF_R_MAX];
     RegisterInfo regs_info[CRF_R_MAX];
 };
diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index 58acbe9f51b..af90900bfc6 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -47,7 +47,6 @@ struct XlnxBBRam {
     bool bbram8_wo;
     bool blk_ro;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[RMAX_XLNX_BBRAM];
     RegisterInfo regs_info[RMAX_XLNX_BBRAM];
 };
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 10e6af002ba..5987f32c716 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -634,17 +634,17 @@ static void versal_crl_init(Object *obj)
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
     XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
     int i;
 
-    xvcb->reg_array =
-        register_init_block32(DEVICE(obj), crl_regs_info,
-                              ARRAY_SIZE(crl_regs_info),
-                              s->regs_info, s->regs,
-                              &crl_ops,
-                              XLNX_VERSAL_CRL_ERR_DEBUG,
-                              CRL_R_MAX * 4);
+    reg_array = register_init_block32(DEVICE(obj), crl_regs_info,
+                                      ARRAY_SIZE(crl_regs_info),
+                                      s->regs_info, s->regs,
+                                      &crl_ops,
+                                      XLNX_VERSAL_CRL_ERR_DEBUG,
+                                      CRL_R_MAX * 4);
     xvcb->regs = s->regs;
-    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 
     for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
@@ -688,17 +688,18 @@ static void versal2_crl_init(Object *obj)
     XlnxVersal2CRL *s = XLNX_VERSAL2_CRL(obj);
     XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
     size_t i;
 
-    xvcb->reg_array = register_init_block32(DEVICE(obj), versal2_crl_regs_info,
-                                            ARRAY_SIZE(versal2_crl_regs_info),
-                                            s->regs_info, s->regs,
-                                            &crl_ops,
-                                            XLNX_VERSAL_CRL_ERR_DEBUG,
-                                            VERSAL2_CRL_R_MAX * 4);
+    reg_array = register_init_block32(DEVICE(obj), versal2_crl_regs_info,
+                                      ARRAY_SIZE(versal2_crl_regs_info),
+                                      s->regs_info, s->regs,
+                                      &crl_ops,
+                                      XLNX_VERSAL_CRL_ERR_DEBUG,
+                                      VERSAL2_CRL_R_MAX * 4);
     xvcb->regs = s->regs;
 
-    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
 
     for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
         object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
@@ -750,12 +751,6 @@ static void versal2_crl_init(Object *obj)
     }
 }
 
-static void crl_finalize(Object *obj)
-{
-    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_versal_crl = {
     .name = TYPE_XLNX_VERSAL_CRL,
     .version_id = 1,
@@ -804,7 +799,6 @@ static const TypeInfo crl_base_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XlnxVersalCRLBase),
     .class_size    = sizeof(XlnxVersalCRLBaseClass),
-    .instance_finalize = crl_finalize,
     .abstract      = true,
 };
 
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index f34dd3ef352..2b573a45bdb 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -627,7 +627,6 @@ static void trng_finalize(Object *obj)
 {
     XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
 
-    register_finalize_block(s->reg_array);
     g_rand_free(s->prng);
     s->prng = NULL;
 }
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index 07370b80c0d..d90f3e87c74 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -190,24 +190,19 @@ static void xram_ctrl_init(Object *obj)
 {
     XlnxXramCtrl *s = XLNX_XRAM_CTRL(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
 
-    s->reg_array =
+    reg_array =
         register_init_block32(DEVICE(obj), xram_ctrl_regs_info,
                               ARRAY_SIZE(xram_ctrl_regs_info),
                               s->regs_info, s->regs,
                               &xram_ctrl_ops,
                               XLNX_XRAM_CTRL_ERR_DEBUG,
                               XRAM_CTRL_R_MAX * 4);
-    sysbus_init_mmio(sbd, &s->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 }
 
-static void xram_ctrl_finalize(Object *obj)
-{
-    XlnxXramCtrl *s = XLNX_XRAM_CTRL(obj);
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_xram_ctrl = {
     .name = TYPE_XLNX_XRAM_CTRL,
     .version_id = 1,
@@ -241,7 +236,6 @@ static const TypeInfo xram_ctrl_info = {
     .instance_size     = sizeof(XlnxXramCtrl),
     .class_init        = xram_ctrl_class_init,
     .instance_init     = xram_ctrl_init,
-    .instance_finalize = xram_ctrl_finalize,
 };
 
 static void xram_ctrl_register_types(void)
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index e85da32d99c..08777496d56 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -179,16 +179,17 @@ static void zynqmp_apu_handle_wfi(void *opaque, int irq, int level)
 static void zynqmp_apu_init(Object *obj)
 {
     XlnxZynqMPAPUCtrl *s = XLNX_ZYNQMP_APU_CTRL(obj);
+    RegisterInfoArray *reg_array;
     int i;
 
-    s->reg_array =
+    reg_array =
         register_init_block32(DEVICE(obj), zynqmp_apu_regs_info,
                               ARRAY_SIZE(zynqmp_apu_regs_info),
                               s->regs_info, s->regs,
                               &zynqmp_apu_ops,
                               XILINX_ZYNQMP_APU_ERR_DEBUG,
                               APU_R_MAX * 4);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->reg_array->mem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq_imr);
 
     for (i = 0; i < APU_MAX_CPU; ++i) {
@@ -208,12 +209,6 @@ static void zynqmp_apu_init(Object *obj)
     qdev_init_gpio_in_named(DEVICE(obj), zynqmp_apu_handle_wfi, "wfi_in", 4);
 }
 
-static void zynqmp_apu_finalize(Object *obj)
-{
-    XlnxZynqMPAPUCtrl *s = XLNX_ZYNQMP_APU_CTRL(obj);
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_zynqmp_apu = {
     .name = TYPE_XLNX_ZYNQMP_APU_CTRL,
     .version_id = 1,
@@ -241,7 +236,6 @@ static const TypeInfo zynqmp_apu_info = {
     .instance_size     = sizeof(XlnxZynqMPAPUCtrl),
     .class_init        = zynqmp_apu_class_init,
     .instance_init     = zynqmp_apu_init,
-    .instance_finalize = zynqmp_apu_finalize,
 };
 
 static void zynqmp_apu_register_types(void)
diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
index cccca0e814e..d9c1bd50e4f 100644
--- a/hw/misc/xlnx-zynqmp-crf.c
+++ b/hw/misc/xlnx-zynqmp-crf.c
@@ -211,24 +211,19 @@ static void crf_init(Object *obj)
 {
     XlnxZynqMPCRF *s = XLNX_ZYNQMP_CRF(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
 
-    s->reg_array =
+    reg_array =
         register_init_block32(DEVICE(obj), crf_regs_info,
                               ARRAY_SIZE(crf_regs_info),
                               s->regs_info, s->regs,
                               &crf_ops,
                               XLNX_ZYNQMP_CRF_ERR_DEBUG,
                               CRF_R_MAX * 4);
-    sysbus_init_mmio(sbd, &s->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
     sysbus_init_irq(sbd, &s->irq_ir);
 }
 
-static void crf_finalize(Object *obj)
-{
-    XlnxZynqMPCRF *s = XLNX_ZYNQMP_CRF(obj);
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_crf = {
     .name = TYPE_XLNX_ZYNQMP_CRF,
     .version_id = 1,
@@ -255,7 +250,6 @@ static const TypeInfo crf_info = {
     .instance_size     = sizeof(XlnxZynqMPCRF),
     .class_init        = crf_class_init,
     .instance_init     = crf_init,
-    .instance_finalize = crf_finalize,
 };
 
 static void crf_register_types(void)
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 5702bb3f310..22aefbc240d 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -456,8 +456,9 @@ static void bbram_ctrl_init(Object *obj)
 {
     XlnxBBRam *s = XLNX_BBRAM(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
 
-    s->reg_array =
+    reg_array =
         register_init_block32(DEVICE(obj), bbram_ctrl_regs_info,
                               ARRAY_SIZE(bbram_ctrl_regs_info),
                               s->regs_info, s->regs,
@@ -465,17 +466,10 @@ static void bbram_ctrl_init(Object *obj)
                               XLNX_BBRAM_ERR_DEBUG,
                               R_MAX * 4);
 
-    sysbus_init_mmio(sbd, &s->reg_array->mem);
+    sysbus_init_mmio(sbd, &reg_array->mem);
     sysbus_init_irq(sbd, &s->irq_bbram);
 }
 
-static void bbram_ctrl_finalize(Object *obj)
-{
-    XlnxBBRam *s = XLNX_BBRAM(obj);
-
-    register_finalize_block(s->reg_array);
-}
-
 static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
@@ -542,7 +536,6 @@ static const TypeInfo bbram_ctrl_info = {
     .instance_size = sizeof(XlnxBBRam),
     .class_init    = bbram_ctrl_class_init,
     .instance_init = bbram_ctrl_init,
-    .instance_finalize = bbram_ctrl_finalize,
 };
 
 static void bbram_ctrl_register_types(void)
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 90962198008..6f17f32a0c3 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -728,7 +728,6 @@ static void efuse_ctrl_finalize(Object *obj)
 {
     XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
 
-    register_finalize_block(s->reg_array);
     g_free(s->extra_pg0_lock_spec);
 }
 
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 5a218c32e84..ce35bb0cc1f 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -816,13 +816,6 @@ static void zynqmp_efuse_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq);
 }
 
-static void zynqmp_efuse_finalize(Object *obj)
-{
-    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
-
-    register_finalize_block(s->reg_array);
-}
-
 static const VMStateDescription vmstate_efuse = {
     .name = TYPE_XLNX_ZYNQMP_EFUSE,
     .version_id = 1,
@@ -857,7 +850,6 @@ static const TypeInfo efuse_info = {
     .instance_size = sizeof(XlnxZynqMPEFuse),
     .class_init    = zynqmp_efuse_class_init,
     .instance_init = zynqmp_efuse_init,
-    .instance_finalize = zynqmp_efuse_finalize,
 };
 
 static void efuse_register_types(void)
-- 
2.51.0


