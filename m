Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A647ED1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84HJ-00046E-7w; Mon, 04 Nov 2024 16:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HG-00040T-S0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HF-0005J9-BX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qdo9pEk4CelGXaMondgwabGTs+HLMaG1XM8q352Z8M=;
 b=TX7JAYm/S8EtknVPnLT7v4yi/Ne4unqNAr+78XUvAcB5S1OpQ53Yfu0kwy9yVt5+aLAcrG
 7ryf9gRmVCde7epfFkqnveQ6c03MaIOIJSxh9+4BdoDMTbVUBMPw0lwfHWVPZgnvZZsXxo
 mKVk3Yz2DvWv6YI3koA6tW4+l2vAj8E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-HUGFVHsKOlWW4v7ZCeY4CQ-1; Mon, 04 Nov 2024 16:06:18 -0500
X-MC-Unique: HUGFVHsKOlWW4v7ZCeY4CQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539fb5677c9so4678468e87.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754377; x=1731359177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qdo9pEk4CelGXaMondgwabGTs+HLMaG1XM8q352Z8M=;
 b=OBRQ+XuVdVX18TFNpDjYAk/25RaPqRsjHF9cnBvVo3Qor5/neYtyuoMBMRqrENvc2W
 uwpDmvp5Ff8jdHSmseQMfurEuXRrP3W+9FUfoKvdj4oNKjD17j3AwB6sykcGIyYPeSNk
 uiT1ozgRCA/DJW7fGW519ArHcysW607U9Jb7AAGSjsAPuZe8sWJQ6OHtneAp0ofjyDf4
 MiWKfuO93ylmr9Z6Hu94iVreojlz5a63H/0SNmzVBsBSm4EXpzJvQ22Ke+F/nFaXJe2H
 GJYZMAULlF6jAPSGpUMbgWAD04DOChOpIAXGtqRMBpnLKo1hI1SmU9vOFWKU6BXRKj3W
 qykg==
X-Gm-Message-State: AOJu0YweMOrCnCBLpL+uEH6p3H70t7te7HeTNJtAFh6ggChRfcXhPDq2
 krjAQcuj0c1aQFORc2HjbcIRIZBt2BnSe1kvnfF8mkM4MNAjm/vwLEKYsALamtA3/ZV3ZBxrukc
 g3T/zil7SHxcP/ZeKsi+OAr/v7mcRtMuNRxtl2E86fhdPAWD2+2vKpBMW99mCyCd72STUQFBxLT
 jN30on5xbX67hVNO6IsrYTzgLAPF1JPg==
X-Received: by 2002:a05:6512:1314:b0:534:3cdc:dbef with SMTP id
 2adb3069b0e04-53b3491cd2amr19144354e87.43.1730754376618; 
 Mon, 04 Nov 2024 13:06:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoMq+F5bWqwsmmF4Sec9XjkQEEzI85UK78KqhmTuRS7jnHG3c9C4eQxvXbvVuGQFZ5szhV5A==
X-Received: by 2002:a05:6512:1314:b0:534:3cdc:dbef with SMTP id
 2adb3069b0e04-53b3491cd2amr19144322e87.43.1730754376098; 
 Mon, 04 Nov 2024 13:06:16 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9403bfsm194347725e9.21.2024.11.04.13.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:15 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 11/65] hw/pci-host/gpex-acpi: Use acpi_uid property.
Message-ID: <43eb5e1f73f1b943d952d9776681a51f05ca7aa8.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reduce the direct use of PCI internals inside ACPI table creation.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916171017.1841767-10-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/gpex-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 391fabb8a8..e8b4c64c5f 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -141,6 +141,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            uint32_t uid;
             bool is_cxl = pci_bus_is_cxl(bus);
 
             if (!pci_bus_is_root(bus)) {
@@ -156,6 +157,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 nr_pcie_buses = bus_num;
             }
 
+            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
+                                           &error_fatal);
             dev = aml_device("PC%.02X", bus_num);
             if (is_cxl) {
                 struct Aml *pkg = aml_package(2);
@@ -168,7 +171,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
             }
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
-            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
             aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Device")));
             aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
             if (numa_node != NUMA_NODE_UNASSIGNED) {
-- 
MST


