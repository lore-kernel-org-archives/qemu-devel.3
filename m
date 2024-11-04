Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F96D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84HG-0003zI-HG; Mon, 04 Nov 2024 16:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HB-0003ns-Pk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84HA-0005Iv-9A
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3wqy1laOvYaRTXIjGpIu1PJBysiXZhRmeHUFm2/bAI=;
 b=U83kTbrpz1EwgPPdBGnJ6X/rrQt//Pzft+vyprzwhRFEYDfH1qpR+vF3HcLdAo8ivFCJHB
 fgVc2HFvQ+RSOvTvFgABnbHhtixBQY6sSdn5vd3ILrX3u8QQA5C+WxU8EbSys9VCatXdxP
 Ih1aGUHvOoejYlJ4T94bLm3GBUM9gdk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-TJYuk4i_PKyfpRLfbfq5jQ-1; Mon, 04 Nov 2024 16:06:13 -0500
X-MC-Unique: TJYuk4i_PKyfpRLfbfq5jQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539e5f9df25so2787908e87.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754371; x=1731359171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3wqy1laOvYaRTXIjGpIu1PJBysiXZhRmeHUFm2/bAI=;
 b=Li4JTDOta8KQ6Yim3QYDjcjXhFhEx77mN4ZR4JnagLT6Dt3DcL0KE6z68obY4Wtdeg
 Pc5pgg2xNAL0dOtvMPJgfR4McpgGCzq7FsWjQQJC+gMWKPeSxu/idIiUJA3Vo4Z5b4Bk
 DqPq+hHQCrDgnYntEMFTxxLdtZVJkBgpRUcib0yxt26VZT9UnMWVqFHIZ2UjtswC0r6h
 l3YlEhJaa30C8nqSw+J5CSfRBBRK3VJt0czKYq3a57tVhWLEpbvt3JC8udHVD7kZ7QS4
 1vSdpOBhuGhsaIcF2gR6+fTlCrx5GjQT0ggG8236b4d4aa7X0MfQQZF+jEwG07Tm0L8a
 QZSw==
X-Gm-Message-State: AOJu0Yw49k/BEVNZJ9gEVQt+Y/iHP6jUWoYxQZZu+RKO9in6ntqZrXh9
 xyklAAWN7vzuqNgHvnm7AFUY2o2cvsKsMxEkhPuV8Vd5kvDCaOkmSUIGiQaGkia7msqKRKDN0nt
 hrW916IXDszIdnoZE7ULSUrXjSzBcBS8G2Bh14L57ZvL9VAuS+n/mMQi/7/cGOp59J2NOw7pjQH
 Wcw1v/307SpSfe1DMOeXrVjBRktpiXNg==
X-Received: by 2002:a05:6512:e98:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-53b348d0d3emr17331355e87.13.1730754371545; 
 Mon, 04 Nov 2024 13:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP7970synxMt3POaa+uRKLERHLgm2zCMyXwZvmPOKdkSaL1Gx8xe0NbiHTZdZmW+xZJ17cxA==
X-Received: by 2002:a05:6512:e98:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-53b348d0d3emr17331324e87.13.1730754371031; 
 Mon, 04 Nov 2024 13:06:11 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a26a7508sm907965e9.0.2024.11.04.13.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:09 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 10/65] hw/i386/acpi: Use TYPE_PXB_BUS property acpi_uid for DSDT
Message-ID: <dc907b5cac14ef06f59963d697e81ff2516b9b3f.1730754238.git.mst@redhat.com>
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

Rather than relying on PCI internals, use the new acpi_property
to obtain the ACPI _UID values.  These are still the same
as the PCI Bus numbers so no functional change.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916171017.1841767-9-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index afb2fa2edc..88227e343e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1475,6 +1475,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            uint32_t uid;
 
             /* look only for expander root buses */
             if (!pci_bus_is_root(bus)) {
@@ -1485,6 +1486,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 root_bus_limit = bus_num - 1;
             }
 
+            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
+                                           &error_fatal);
             scope = aml_scope("\\_SB");
 
             if (pci_bus_is_cxl(bus)) {
@@ -1492,7 +1495,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             } else {
                 dev = aml_device("PC%.02X", bus_num);
             }
-            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_cxl(bus)) {
                 struct Aml *aml_pkg = aml_package(2);
-- 
MST


