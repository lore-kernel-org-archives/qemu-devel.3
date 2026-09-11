Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE07C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAt-0005hP-M2; Fri, 11 Sep 2026 05:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAE-00049x-IJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAC-0008Hg-SF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Moug1WmXO2CB2DYm8PmKZYdWRJM7GGO9/h6JXojQGEQ=;
 b=C7Ug589ABENeDLY602ihwO8CCG2bjtl/9tFleuVCPSx+HaivoYBYUxYnlYRuy5JVC9vz/U
 14hQR0XRg/0waAAH5ZGswfy7d/eDO2r34qBoQxT6VPDzbd3+kahnpJ3dl+ib7fbzy7bhGL
 EmGZnZ1HA3YTH2WJjndnuYkEEibZM2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-KlY7Ve_JMpa1YDEI3BxlVA-1; Fri, 11 Sep 2026 05:03:14 -0400
X-MC-Unique: KlY7Ve_JMpa1YDEI3BxlVA-1
X-Mimecast-MFC-AGG-ID: KlY7Ve_JMpa1YDEI3BxlVA_1789117393
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so4482475e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117393; x=1789722193; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Moug1WmXO2CB2DYm8PmKZYdWRJM7GGO9/h6JXojQGEQ=;
 b=YT5L48t+DXawpf/tzLLA/Cx+1hl6rLxEaJ8xLYSNTOgR7NK8f1N6Rrybn3OxPk8aTX
 34hFlqFQnVItwczMnGHz8D758vNliGz6uUbdI2CltAkvSFLDPiu+zBKejxeWFQaAWWlG
 ICKDv7bhS9SyYyI6PNyyqffubJNagrOlIbvKvYAx4P3voEI34iVbMUaDGndqNNHhYnTq
 OvPuP6bmH7WkTfx+37XZr4pPljSEEmB9bRpMsiuLbsjb2hoav0enbBrMAhxyE0hDPX8p
 AT51PAhqXQNSrTYJrIXS+jRTNzxEnz+DiQtqbQ+iuJhWqfkLfj6mECcxoBfp1k21tNtt
 FyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117393; x=1789722193;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Moug1WmXO2CB2DYm8PmKZYdWRJM7GGO9/h6JXojQGEQ=;
 b=LfzZ86wJkbs0NJIn76WYBGvP16xkuSohXo3rjsrFZulCfz4pOWFVvsMe5iIi8D84/i
 ho5zlj09dD1PqRzuqi7FWx4voc8a3IM/gY+vzeJnDuhZzeTr2X+U+kmCj6SAR0VQFtmG
 XwTPLG66lnlkrZDmRoY9v+Y2vGKC8FqFhWUKa838TL2eaYiy6X7YjCq7a7WuSQzl6cuR
 2WiNe4qsNHEomO8QCjRamjgekuUFhUmWhDtDb/C3J7z0GTf0B2xgiyzXhCJDFGBllrdb
 9o44EMuOYhbKiLvvMP32eCBuqPFSXi09gi7BRlhvX9ooXGomhI3fcJIXkzocMqaeeOt/
 Hhqw==
X-Gm-Message-State: AFuF++leZc2YE0G6Bs8Mi7fLQ7agvc4oBsz/8HeculIOyimCAyTbdIIi
 Ve37dJCysR2RwtylNzHNp057IiERGeuVhOCtHcDMrtPmkriiWOGUyS5d6fsLdphLUSnpNaDsBCG
 a+SfC1rWHfEu5cS4Xe4aCEyOP72FmLF4xllYqUWFdKfDnHq/Pqm6mu91TSG2+5jlHRQmLjBKeD9
 7z7bU1ewfZrI5eEz1MjhX5GTVvRvqmuRynOw==
X-Gm-Gg: AYBFou2gsAMI2+y9rypJWwiBksVVZCbNO62Gf2oQ0rARuLgpXB+52Nyand2BGDobd81
 l6l0h1DJ/aZckrKjusH5adM5vsVA/UpPjWQbTYZRDIlkV1OruWNHBPAKrLret3M+M5ILR2NbuFD
 SGSm9ySO0RJ+MtLNdaeN2dGEaon057Ly9n+MKRH9Dy+IzKxi2bhJ05UjuBOMqV4b8EZ9X1TdUcW
 G5KoofbcViTonB8xRtGTNy1SPretzrGscDU63eH89Uhw6zmGLAs52q0kzN8Y7L7z/LwmH/c+wQI
 IOv0RRk/8td0cD2Z5viEpho4KMQahkMv+UxARCb1zbmmYWWtSgC6Xc9R0QBTW5KWwd37LYK6g+a
 PGJC6djEuqTBjTj6Z3BbaW8c=
X-Received: by 2002:a05:600d:6501:20b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-49e61988e73mr24438595e9.11.1789117392817; 
 Fri, 11 Sep 2026 02:03:12 -0700 (PDT)
X-Received: by 2002:a05:600d:6501:20b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-49e61988e73mr24437855e9.11.1789117392136; 
 Fri, 11 Sep 2026 02:03:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2a419sm152277935e9.7.2026.09.11.02.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:11 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 47/75] acpi_build: Use IOMMU pci device to build IOMMU
 DeviceID
Message-ID: <e97792e397bfd70e7c503fe3ce006bf119afc2dd.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Currently, build_amd_iommu() uses "addr" property to build the DeviceID for
IOMMU device and advertise it through IVRS. But this property does not encode
IOMMU bus number, only the device and function number. This creates an
incorrect DeviceID when the IOMMU is attached to a bus other than the
default one with bus number 0.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-5-sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 05b68d05a8..a28bb2ec63 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1851,6 +1851,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
     uint64_t feature_report;
+    uint16_t iommu_devid = pci_get_bdf(&s->pci->dev);
 
     acpi_table_begin(&table, table_data);
     /* IVinfo - IO virtualization information common to all
@@ -1913,9 +1914,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* IVHD length */
     build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
     /* DeviceID */
-    build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(s->pci), "addr",
-                                                      &error_abort), 2);
+    build_append_int_noprefix(table_data, iommu_devid, 2);
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
@@ -1947,10 +1946,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
 
     /* IVHD length */
     build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
+
     /* DeviceID */
-    build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(s->pci), "addr",
-                                                      &error_abort), 2);
+    build_append_int_noprefix(table_data, iommu_devid, 2);
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
-- 
MST


