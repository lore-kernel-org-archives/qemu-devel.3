Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371EDC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSK9-0006RM-2V; Mon, 14 Jul 2025 19:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSI7-0002Kn-Uo
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSI6-0005nD-AZ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2/RU4fBClmDZksI0BLHkAVpRgw7V4hSQeqiSZKZskI=;
 b=gylU1A5BjSzYMAr1hbJdtIDPnMvzXxMFf0JDHKfJS4SXbkJA80S3RCqWA/CMJWKdiHP8nC
 CJpURsSfFdK2paxhnUJOISo9z9ObRhNPvZmpEin8f9LCSC/WJMuP7Y1at/mrbnpBx66+Pz
 aBQkYKtEVEKP3qnXMF+uhFuhtJOlHQo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Ius2eIjcMjekE_x6j0HSCw-1; Mon, 14 Jul 2025 19:08:56 -0400
X-MC-Unique: Ius2eIjcMjekE_x6j0HSCw-1
X-Mimecast-MFC-AGG-ID: Ius2eIjcMjekE_x6j0HSCw_1752534535
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45526e19f43so12573015e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534535; x=1753139335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2/RU4fBClmDZksI0BLHkAVpRgw7V4hSQeqiSZKZskI=;
 b=Wz4RYFzZniAFMPdTJX+aLj8naQmnHWUTzBpv3vWwRm9TpCmjrZ4RzVzwpDV1OTzThf
 78RcdJ7qg30/NFWoseHiR5iS3aTz2c0xYhzqvBB7hFL527c4VFQQxqRQY81/5MxvBxaM
 KKZwmuHQBQN35l7RGsRbXzNj3c3ZE4KxGmuLOw1FtVmjgGxABbKIpdMu3ufDWcTjOljA
 H+7Kkzh3atfWzh28/xD1DiUk4B12kFOW+brVqyKV+Abb8gGB2QpDzkNAO0w4UeaC6/3z
 je+vojhhAA0budDsJy2cic2CGU5dQaqrY5rTKde3HAHmbRBi5iRqoxl3IcDQ38x6XEf6
 fIJQ==
X-Gm-Message-State: AOJu0Yy6/+T6685I/YwK+w6cxq0hTDAMds2jsSVp2kVmkNHqPjmK4NVa
 tddGIfjs0uGGw+m06aiLuxX2769+2akwUDBzKGxhyt9B+eY5j87EcVXUbzql4p7/JSypNYLYmYD
 lgpcjyZYWXWmb5Hg2eICVx0K6OAlvyFr2ye6JbzDyMA2p5SeuSbsUN0lCKa1To5s0h+ZMEa+Fps
 /tsqJXKUsORRBODWZVbbt5fyQlymRYSqVYUA==
X-Gm-Gg: ASbGnctyaIlGtuAJRt/IhA/DN3Jb6m/tkL+m3k3ZaoSzGA+5n1dR/EgsLZnz+crdi8z
 q+mZ2NBdaf8wlGckY2hthstgVGPtGqF2+fwWLhkDznrkhxCrozMbUsdzWHGJ/5jkyChMZq1kWQ2
 dZVK2OjfbyDIDAdhg1RCl/AHNNoc0JY1kFYjL57Qf9WVkOrjkQ+f9179YIuUAHvi0cHvXhaTN+w
 F9TqVX0BDUIdxKPqDGvdv0XHrVB64O1U07YBZlPYioaXv2Pl1/aXED4FTGn2Nx72hhUCrZRPtw5
 lbzumwTDTia/074f/2kk3jbbpL2x6WPi
X-Received: by 2002:a5d:5f09:0:b0:3a4:d274:1d9b with SMTP id
 ffacd0b85a97d-3b5f18922bbmr12252968f8f.25.1752534535224; 
 Mon, 14 Jul 2025 16:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGITCH4fHn+3HpV4LbGWtcqE4C7ouV+p6FyJhmq5sQQfR9QhPkr7xtl8gGcgTSq3L+QOOnl8w==
X-Received: by 2002:a5d:5f09:0:b0:3a4:d274:1d9b with SMTP id
 ffacd0b85a97d-3b5f18922bbmr12252946f8f.25.1752534534771; 
 Mon, 14 Jul 2025 16:08:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1f70sm13409581f8f.27.2025.07.14.16.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:53 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 61/97] hw/i386/acpi-build: Use AcpiPciHpState::root in
 acpi_set_pci_info
Message-ID: <37419d72af412c3bf32f22dbe7a048789ab8f62b.1752534227.git.mst@redhat.com>
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

pcihp acpi_set_pci_info() generic code currently uses
acpi_get_i386_pci_host() to retrieve the pci host bridge.

To make it work also on ARM we get rid of that call and
directly use AcpiPciHpState::root.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-Id: <20250714080639.2525563-16-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pcihp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2c76edeb15..2db2f16940 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -99,10 +99,10 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     return info;
 }
 
-static void acpi_set_pci_info(bool has_bridge_hotplug)
+static void acpi_set_pci_info(AcpiPciHpState *s)
 {
     static bool bsel_is_set;
-    Object *host = acpi_get_i386_pci_host();
+    bool has_bridge_hotplug = s->use_acpi_hotplug_bridge;
     PCIBus *bus;
     BSELInfo info = { .bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT,
                       .has_bridge_hotplug = has_bridge_hotplug };
@@ -112,11 +112,8 @@ static void acpi_set_pci_info(bool has_bridge_hotplug)
     }
     bsel_is_set = true;
 
-    if (!host) {
-        return;
-    }
 
-    bus = PCI_HOST_BRIDGE(host)->bus;
+    bus = s->root;
     if (bus) {
         /* Scan all PCI buses. Set property to enable acpi based hotplug. */
         pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &info);
@@ -266,7 +263,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
 
 void acpi_pcihp_reset(AcpiPciHpState *s)
 {
-    acpi_set_pci_info(s->use_acpi_hotplug_bridge);
+    acpi_set_pci_info(s);
     acpi_pcihp_update(s);
 }
 
-- 
MST


