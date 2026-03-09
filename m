Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AF5F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbyb-00060z-Sm; Mon, 09 Mar 2026 10:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbxC-0004Ml-GG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbx9-0005mG-Pc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso18591655e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067886; x=1773672686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFBD0qDRhedXBZOSg9THzlFQsk+WFfdCetsuF6KGnOc=;
 b=AEg37BPFT/x1MbsaFLJcwmiTDCnQfa7dgdAJqjtGUnAWC0clok+AVZs5dHaNIbdeGr
 t/Bwe8p5nB+v5YLNTrYXrtWGcBPsel0YDC04k0ZHu5QCXOwpovvsvXkwEo1LDUC5vGEA
 hPPHnqrXVtiUyNih+dBflfQGlP49afXYJblrXRL9gONqjKYZ1ZANqTzsTLO3GuDhzrFz
 G6at3TLbDpCpY8JIND2R2Ux5nhYR+Oq2NFSetXbBTIwsqDdD9fQcPs95fYiZD+stUJ5A
 l1Ah/JKMKxSoNK0JRAnS/8uaq94yMy9wzNAJmVGOjShDnC/kEx/7D4xSeyAZg3RKT0uo
 IaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067886; x=1773672686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nFBD0qDRhedXBZOSg9THzlFQsk+WFfdCetsuF6KGnOc=;
 b=O7mekDvIvtwrNN1yT1Rp6fQnx/6ym488Ljlio99+dS8eTx0e0PkmXxXgbW1wpJJoWq
 1flnbKzwaOVSuN0synQSUjwbY3iDJ6JYb/Q2NHecXjfe9HgzgBYJK4KB75s+mbChieIk
 +CJN+iz0EwpJIBPRfmbAMfcUXNFB5+VjMfOItWYF0AiD0M89T/8uItzkt6DvABYxTs2Y
 u/vQ1CVlpQeA7R/FOxsSTprbZP8M3WQfUVnV2ldksii43szAL0pvBRBtjILJyXAbGL0j
 31p5xL0XBknOxehYMp8FUFLTJXEhT7EZZz3oYSsbbC2q9jtJkRTjhJOk500xkY5DciiP
 1dag==
X-Gm-Message-State: AOJu0Yy/gZClWQ1RByWF5Y4OrKIYDGbk7+I396Yg/w5+sdpGCvSSo0Vs
 aSO9wv1eulbdzEc4pbIYB/INxJ00ThPIGUhkGAf9VzPzw+XMOOqbN3w2RhNqJCx9fY6IW7eKcOB
 +xpxt+rQ=
X-Gm-Gg: ATEYQzyc8Mx/wmrcXbaK8TVcX86QK4oBPS1VyEs+HNgUw91GRCtBWFDhxGi5PoGAiYB
 giXL6pUzjI3VV2UsX5epRxtok8+05AlNOZ/0+QifEGrbpxA0q0s8+5ljIjclzxO9lSFGwyvX1Jc
 6UelnEyFyDdgeCr+wdI+3uXNHAPmXEtjBs1LkmprPdq+83erBbpL91k6P7cXVabeN/8WyB+XfXa
 wGhLyNE74eorkqwGg7eSsubcnfLe4vK7yPLpyQdoBQlO4/7Ech2kmwZ1Ox2mGFSeQJlWqyf61Ye
 eiboKT+zZci3Wl6OKMa3bEf4UG6xXgN9+T8DNjGkzKUV+vFDhfRiwARJ/Mrt6JwOKj6aH46wbYY
 1MlQSm5sjS2ymPS+IQQZTKc4USpXh03Ws0oNVrdvXb3gtdSkZHxOnJEeTzfowdVoTKIbH2g2MV4
 zYqoWnBnlDnnSvN182naJnQEYYVI8cwskozS9D8oz4d2ijFDjRsEbhIrkdnWBiDqff21ujcrGvJ
 3lGaA==
X-Received: by 2002:a05:600c:350e:b0:485:17a7:ba0d with SMTP id
 5b1f17b1804b1-485269785bamr190793715e9.32.1773067885916; 
 Mon, 09 Mar 2026 07:51:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm265186225e9.5.2026.03.09.07.51.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:51:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 10/10] hw/tpm: Remove CRBState::ppi_enabled field
Date: Mon,  9 Mar 2026 15:50:12 +0100
Message-ID: <20260309145013.44327-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The CRBState::ppi_enabled boolean was only set in the
hw_compat_3_1[] array, via the 'ppi=false' property.
We removed all machines using that array, lets remove
that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-11-philmd@linaro.org>
---
 hw/tpm/tpm_tis.h        |  1 -
 hw/acpi/tpm.c           |  4 ----
 hw/i386/acpi-build.c    |  2 +-
 hw/tpm/tpm_crb.c        | 12 +++---------
 hw/tpm/tpm_tis_common.c |  4 +---
 hw/tpm/tpm_tis_isa.c    |  7 ++-----
 6 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 184632ff66b..0df45f0c716 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -75,7 +75,6 @@ typedef struct TPMState {
 
     size_t be_buffer_size;
 
-    bool ppi_enabled;
     TPMPPI ppi;
 } TPMState;
 
diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index cdc02275365..922030a29bf 100644
--- a/hw/acpi/tpm.c
+++ b/hw/acpi/tpm.c
@@ -25,10 +25,6 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
     Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
         *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
 
-    if (!object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
-        return;
-    }
-
     zero = aml_int(0);
     one = aml_int(1);
     func_mask = aml_int(TPM_PPI_FUNC_MASK);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f622b91b76a..6b7cd00c5db 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2218,7 +2218,7 @@ void acpi_setup(void)
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
     tpm = tpm_find();
-    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
+    if (tpm) {
         tpm_config = (FwCfgTPMConfig) {
             .tpmppi_address = cpu_to_le32(TPM_PPI_ADDR_BASE),
             .tpm_version = tpm_get_version(tpm),
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8723536f931..40ffc7b006b 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -43,7 +43,6 @@ struct CRBState {
 
     size_t be_buffer_size;
 
-    bool ppi_enabled;
     TPMPPI ppi;
 };
 typedef struct CRBState CRBState;
@@ -228,16 +227,13 @@ static const VMStateDescription vmstate_tpm_crb = {
 
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
-    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
 };
 
 static void tpm_crb_reset(void *dev)
 {
     CRBState *s = CRB(dev);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_reset(&s->ppi);
-    }
+    tpm_ppi_reset(&s->ppi);
     tpm_backend_reset(s->tpmbe);
 
     memset(s->regs, 0, sizeof(s->regs));
@@ -303,10 +299,8 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, get_system_memory(),
-                     TPM_PPI_ADDR_BASE, OBJECT(s));
-    }
+    tpm_ppi_init(&s->ppi, get_system_memory(),
+                 TPM_PPI_ADDR_BASE, OBJECT(s));
 
     if (xen_enabled()) {
         tpm_crb_reset(dev);
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index f594b15b8ab..712d64b60f1 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -821,9 +821,7 @@ void tpm_tis_reset(TPMState *s)
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
                             TPM_TIS_BUFFER_MAX);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_reset(&s->ppi);
-    }
+    tpm_ppi_reset(&s->ppi);
     tpm_backend_reset(s->be_driver);
 
     s->active_locty = TPM_TIS_NO_LOCALITY;
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 61e95434f5b..aadca4ed79b 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -94,7 +94,6 @@ static void tpm_tis_isa_reset(DeviceState *dev)
 static const Property tpm_tis_isa_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
-    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
 };
 
 static void tpm_tis_isa_initfn(Object *obj)
@@ -132,10 +131,8 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
-                     TPM_PPI_ADDR_BASE, OBJECT(dev));
-    }
+    tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
+                 TPM_PPI_ADDR_BASE, OBJECT(dev));
 }
 
 static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
-- 
2.53.0


