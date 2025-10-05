Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C4DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UF8-0000ee-FH; Sun, 05 Oct 2025 15:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEF-0007kg-Jv
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UED-0006Si-Lq
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2yaew7sPmdwqoSuzt/4g3R5wabDe7Wq8iiNEDRaEec=;
 b=DsHqXmwoN072gRqrDEdjk799vG2EZD1kzna2KsfDvW7jirBL2HPwVwA1Y0qgSbgmoY+cnQ
 7ZQPOOokniFAo4RLhuuXXLuFGKlHR8qYHhoKzzLVBzWnQUKZcW+VHGI1GkSKO/KJISIWNp
 1nev0SSrEfk2OXVyRovvg/I0LjXFH24=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-gvtimDmOMraJr1sO78NKTQ-1; Sun, 05 Oct 2025 15:17:03 -0400
X-MC-Unique: gvtimDmOMraJr1sO78NKTQ-1
X-Mimecast-MFC-AGG-ID: gvtimDmOMraJr1sO78NKTQ_1759691822
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-40fd1b17d2bso1774071f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691822; x=1760296622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2yaew7sPmdwqoSuzt/4g3R5wabDe7Wq8iiNEDRaEec=;
 b=d/DKA8JkNqUqm73MU2p1hBWuBCVUUyilxTORcDurfvT8Mejo7Eon1jmqtVJoYNiXwH
 1P2dbr0kCkxSPcDc77qWFJbOzRCMsl2d+TvjKoQY82gYAX1g/9BDnEtwyYM/QZDy4liV
 hqlYZYpqFcPb9CZclU2dCwTyK0IpFLq8Ky52QUhTLBNDsn6EEGFgo7uUPVbS4luB70iX
 R+VyEaFJzrFDQdtjcEIur3do7HGESLS9DhU63e0tG7Mj7wbR1WtoAr6YqTSq0XcRzX74
 r+oPZxsKCEpgWxQShFaHvT5XAOapG2ccnDAZ1aWdIEp/TocEXtL8wNxLDUn7ruEmwNDE
 UMug==
X-Gm-Message-State: AOJu0YylMYtzPCaVirHUQl5+ybQoU+j8yqHqytWVs+G2X+cZz8Bh3+fJ
 DTpbwrpQzQoVJo5y5Oi3zE9Ji3jSiqp8DxvmwiBj1sb1m636ItF77LTPOjonbp2U3e5OgTQXEO7
 MbpHkfVjlt7azBpRslDRcYxnUSDdOZ6AVg+ymw4PGfPzaO9h4flXvF3b1fTnyXHRstjQfELjF9N
 DpohxAuGFy37rTgPte+IanTKqvpY68p5vHZg==
X-Gm-Gg: ASbGncsenLiffXFZw+SdufaOIrVohWSrYChH4STU8qStLmrTprHMNLIGEOYJR/Gs+5b
 OdgpKj9lWO+6IktCVfwbDRFSCDZOasFHV6Ga45ysHbUQPrzCQPSIC2PgINP948ATYl5rLw0A1On
 yARJXnZnrn7jKDBrA7GvSQyzAB2R1lquxURG1sqDQMTwym9qbWiW3HvLq+H9J0jGiZb6Cz4nogu
 JDqtOZ5QG26VJa5FZnC+bPXMrtZPe9G1otw0BNEBO0UKRUdR3Cp+Rnr0IL2A5GEuw0VZntf36gW
 vtNf5pLgFWikb9oFqyu93Hhl+mWyWoapuxKP38w=
X-Received: by 2002:a05:6000:3105:b0:3e5:47a9:1c7f with SMTP id
 ffacd0b85a97d-425671b2410mr6544790f8f.47.1759691821770; 
 Sun, 05 Oct 2025 12:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRURCRu0Nwht+Dp8zRejMGpCvhKOig5UJaICV2rwPLpdKx7n6ZmoTroR9mTPUTjNIxeRzv/Q==
X-Received: by 2002:a05:6000:3105:b0:3e5:47a9:1c7f with SMTP id
 ffacd0b85a97d-425671b2410mr6544769f8f.47.1759691821273; 
 Sun, 05 Oct 2025 12:17:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9719sm17755739f8f.31.2025.10.05.12.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:00 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 26/75] arm/virt: Wire up a GED error device for ACPI / GHES
Message-ID: <d352e33e1f92e60e12a00be1ea80f47b4e024c88.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Adds support to ARM virtualization to allow handling
generic error ACPI Event via GED & error source device.

It is aligned with Linux Kernel patch:
https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/

Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <3237a76b1469d669436399495825348bf34122cd.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            | 12 +++++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ea2cff05b0..e14ea0f9d4 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -174,6 +174,7 @@ struct VirtMachineState {
     DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
+    Notifier generic_error_notifier;
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ff3b7a794b..2b63008df0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1066,6 +1066,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_dsdt_add_power_button(scope);
+    aml_append(scope, aml_error_device());
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(scope, vms);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02209fadcf..6960f6113f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -693,7 +693,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     MachineState *ms = MACHINE(vms);
     SysBusDevice *sbdev;
     int irq = vms->irqmap[VIRT_ACPI_GED];
-    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
     bool acpi_pcihp;
 
     if (ms->ram_slots) {
@@ -1050,6 +1050,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     }
 }
 
+static void virt_generic_error_req(Notifier *n, void *opaque)
+{
+    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
+
+    acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
+}
+
 static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
                              uint32_t phandle)
 {
@@ -2500,6 +2507,9 @@ static void machvirt_init(MachineState *machine)
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
+        vms->generic_error_notifier.notify = virt_generic_error_req;
+        notifier_list_add(&acpi_generic_error_notifiers,
+                          &vms->generic_error_notifier);
     } else {
         create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
-- 
MST


