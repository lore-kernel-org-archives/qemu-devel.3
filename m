Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56C1C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKp-0008B4-Ks; Mon, 14 Jul 2025 19:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIt-0004nW-Am
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIq-0005vM-SA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7vjM29loqh3qj497TGPCCyUnVFVvjEr4KsZrS7AgqPw=;
 b=DvK1+kd0dqguCVSC6CPWxezRLFBVp8ZhLcwPfpFdcwbypN6fy4uce2OqeoyC4y5JAy0OBF
 cse9qZ3dJUEz5Rm1Hx4uaUS+AMqwNwhtSzxLnhoEvyzvQ4psWel8h320IzB1btH+Ji3Y3P
 3yF3jiMHYGJj1wgwNHyvOoXCwKaKGV8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-_knP4bjBOGSEryKo52cTBw-1; Mon, 14 Jul 2025 19:09:40 -0400
X-MC-Unique: _knP4bjBOGSEryKo52cTBw-1
X-Mimecast-MFC-AGG-ID: _knP4bjBOGSEryKo52cTBw_1752534579
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so27426135e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534579; x=1753139379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vjM29loqh3qj497TGPCCyUnVFVvjEr4KsZrS7AgqPw=;
 b=jJIEMGlNhXBMlgiChYhEOM1WpLve9qXI6rRh0vbizdMX6kLboF3dJaaGDG5ffORQ/O
 WCAlbQHKslu54nAEia6N734uUJ1s7/nJJyKrIq4gTB0XvRlkRv8pmX/j9jt1OJ9QJ+2D
 hVQjpv1t5pElGr4BEvhLBOv2vAzH/QvF7ljdYGiWF6ya//Kkje5nMyBvnleRLcwE9bH8
 hUtQkdh5eJNmmBOnC/3Hf/g+fRpByB8r1M+aLkpXGhRCdZD8buKB+LER4frRHtA0O7KP
 +TJ9IG7q6OwUs3ZB3jBlnEDra1HZGlG18C/vWMZ87LsPZ4bL5aVqABd6fQWPpitLlVkc
 jdRA==
X-Gm-Message-State: AOJu0YzRvzcTGzu0EsroxaZe7cbQ4c1m+3kooQzCnqoLq7ZhP/zBqtr+
 RWaDRIcNu3AMXa/qWi+lb2vzUlMpGri42ZPZSBPVrEGr9wtACB59HAuM9z0FmFp4tKsOOa3OsNX
 kfje8ZWCJsTh4zoLhf74UIE96U5qOvA5j6CEsKf2145vImhhmdBFr3mPZ6foMoUqidK/XKRbyrK
 qYuJcw2zlJSazB/ctM0UaVBjdaazlbBQIISw==
X-Gm-Gg: ASbGncs/1OQYR4XAnhlE1evQMiewiaiCrddAwUg3TavODV6WS7nBMJPB+Ndw968CPAB
 8ZDz4quHwH1CfmtECrHtscZ+17uusfHIgJuaPTl9bd56i35Cof52OAx9hX/xCJiVjf3aYo8PPio
 csXfIST9uH60RUaHdD5VDQQUQiMhT7Kpn9X4BjcUZAlceXcGZGmCcxV4rnKZ6e8wzQSlV0xQuL7
 5kXnBIH6USrWoOw+8ewt84p00W9fMVRNNx357rIXmhQO1kpSaLVLzIGm3I3zUvSVRE65HsATTaG
 s1Y0mtpe5kz00LC68OJxmgdnCx2ai33I
X-Received: by 2002:a05:600c:4e12:b0:456:21d2:c6f7 with SMTP id
 5b1f17b1804b1-45621d2ca13mr31083655e9.23.1752534578824; 
 Mon, 14 Jul 2025 16:09:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc6PyhwOgHRGXBSHK7aRyngXPVE3CMkGLbC8HVHMAt/Zojj/QvxJ3/qGbeeIPuTSdbA3/m2Q==
X-Received: by 2002:a05:600c:4e12:b0:456:21d2:c6f7 with SMTP id
 5b1f17b1804b1-45621d2ca13mr31083475e9.23.1752534578424; 
 Mon, 14 Jul 2025 16:09:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45611a518c2sm63682025e9.31.2025.07.14.16.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:37 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 77/97] hw/arm/virt: Minor code reshuffling in create_acpi_ged
Message-ID: <1fb3e6a87bb1ff9d6a637297e6106e86eff038c4.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Use a local SysBusDevice handle. Also use the newly introduced
sysbus_mmio_map_name which brings better readability about the region
being mapped. GED device has regions which exist depending on some
external properties and it becomes difficult to guess the index of
a region. Better refer to a region by its name.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-32-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/generic_event_device.h |  1 +
 hw/arm/virt.c                          | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d56adaa626..2c5b055327 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -111,6 +111,7 @@ typedef struct GEDState {
 } GEDState;
 
 #define ACPI_PCIHP_REGION_NAME "pcihp container"
+#define ACPI_MEMHP_REGION_NAME "memhp container"
 
 struct AcpiGedState {
     SysBusDevice parent_obj;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 41b5086b55..f127a668ef 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -688,6 +688,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 {
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
+    SysBusDevice *sbdev;
     int irq = vms->irqmap[VIRT_ACPI_GED];
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
 
@@ -702,11 +703,13 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
     object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sbdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbdev, &error_fatal);
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
+    sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
+                         vms->memmap[VIRT_PCDIMM_ACPI].base);
+    sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
 
     return dev;
 }
-- 
MST


