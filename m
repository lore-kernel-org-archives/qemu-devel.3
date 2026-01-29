Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F91D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUau-0000xH-V8; Thu, 29 Jan 2026 11:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUag-0000KI-9M
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:55 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUad-0006gr-51
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:53 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so1044055f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702987; x=1770307787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P1FHnLGv0F1KpDJLLP83IUidm8bElFCZsHk7cWMFi/Q=;
 b=gFbqZsPnlaG1pcG5Vrn6euayd/GMXxvyOg6f25ynz3s8xq3z+FrGk2wMjOYbbWg7ya
 xqmfRH3Zi18qyyFneZsOdlrwL3LdkFOYSBOUJadFD/staWutcJWkHRXhCFqGQVMvUg0O
 NgzNmKEfM3QdSHdsBuf7eYai6XKgJF29y7WQDpm4CEfaB2phgLG4WEIYtNQg3bt+8NDs
 9o+ZCnhIUXzO/thdCxu9YY9hmVnIg5LhxnCrMgykdxj65gYI2gQlT0fSs7nnnPbwWksg
 r+rG1k6f0l8GqAh9Qu3a8LHAjAxHJhrlzxZ/XN/DwyTBWu3EHyDj8BrGPxvESGoDkDdr
 Fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702987; x=1770307787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P1FHnLGv0F1KpDJLLP83IUidm8bElFCZsHk7cWMFi/Q=;
 b=aLYB0504wdFryBzg7c5dCWL14OPRw16gtmLfRjbuNmUoficT15TNgTVuUnTLbQ/rpi
 fOGTVK1o7TMvI5ynTH7QmlRlfgdveg33hSVZQdO7jJn85xa6BgUdOEei3veuoZWDLuow
 dFB7AYTpcNm5vpZCn0EoTjr/rGouEKJnE38F7mfyij8KWtcVKcLU+M20BZ45Ekiyp+06
 zDO1yf/GnCAxR6gMZUqlBZokzT8PKLt8i+VAjTGeOHZKMJvhxsxa4pzGLGdA9RJPT6Uc
 EF/u2Ar1LWERsgYp+BN7gUcDNZZnTU1WKq+PamlMrIRM7svwENAWIfDIZTZIMLzSIdYM
 g1OQ==
X-Gm-Message-State: AOJu0YxGLnPK0ygtN0d9VhhATN6z0NiV9Evx5/5lQiTUO1lMBIk0mFhJ
 1BQsy2N8lZ6Yo9jRqLH7pzov1yeoqmkzKvGStOznxw3EnCApuHDTGZSx+hNM38jIss2T4ObYgor
 WhU3j6JU=
X-Gm-Gg: AZuq6aIbz4r5UA42FrwPdOW26aRJjUX6mO8ia+1da52fmiIDLbn79o0onJeAQeo6BzQ
 9mMTk4TYuc+MTTSV09zGANK7hBlZN9vQ692YI8M7slAoL3A7+KrK2hnPAggnRRNy1q3W9rhOMn8
 A9wqghDeOdT0lF2Qu83yv5yyF0M5eRuYMVsItR8zOODhHhoZvRCvGoVW+Znc+Cjr3TDi9SNcy8n
 D7jdSJyLrfFwm7lgN3XlY44Scy6kPgOGnZVhUzjhxQIgVmv2mSRqhU5fGfIW6VrhKa0VYfjTnmt
 QzaRHN817U83vOVUem0n+i6FIitNnl5wS08Owaz3hUPew3ji/5lxMjn/eHHPAIE4zEMlEeM9jUP
 +ycYirg0ca+e81DhxNdcFmchkoOQQQ2/MrYBC2bfboQ2tBm5E8vRfSa8jQbY/AOo1L5baqzhalh
 T4gi9sl8QVOUyTll8zlLAHtJhcLVJ6nw==
X-Received: by 2002:a5d:5f94:0:b0:432:e00b:8687 with SMTP id
 ffacd0b85a97d-435f3aa7957mr159981f8f.31.1769702987178; 
 Thu, 29 Jan 2026 08:09:47 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/43] hw/arm/virt: Set PCI preserve_config for accel SMMUv3
Date: Thu, 29 Jan 2026 16:08:57 +0000
Message-ID: <20260129160917.1415092-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Introduce a new pci_preserve_config field in virt machine state which
allows the generation of DSM #5. This field is only set if accel SMMU
is instantiated.

In a subsequent patch, SMMUv3 accel mode will make use of IORT RMR nodes
to enable nested translation of MSI doorbell addresses. IORT RMR requires
_DSM #5 to be set for the PCI host bridge so that the Guest kernel
preserves the PCI boot configuration.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-24-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 8 ++++++++
 hw/arm/virt.c            | 1 +
 include/hw/arm/virt.h    | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 03b4342574..9032a5df1c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -164,6 +164,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         .pci_native_hotplug = !acpi_pcihp,
     };
 
+    /*
+     * Accel SMMU requires RMRs for MSI 1-1 mapping, which require _DSM
+     * function 5 (_DSM for Preserving PCI Boot Configurations).
+     */
+    if (vms->pci_preserve_config) {
+        cfg.preserve_config = true;
+    }
+
     if (vms->highmem_mmio) {
         cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 91fec582ed..899b02e1f7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3080,6 +3080,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             }
             object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
                                      &error_abort);
+            vms->pci_preserve_config = true;
         }
     }
 }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5907d41dbb..3b382bdf49 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -182,6 +182,7 @@ struct VirtMachineState {
     bool legacy_smmuv3_present;
     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem;
+    bool pci_preserve_config;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.43.0


