Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC74C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAdB-0004xH-BG; Tue, 12 Mar 2024 18:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAc6-0002pk-J8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbw-0004ai-D7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7lDoWlZCcLIPjIofqG1lsxz2N/rHF6vbYam4xDSG+ms=;
 b=ILHs0oc0mWI2IuW0l8sBZ2ZRbIXY/IEJ+UyWd0eyLPHvg+ktwnzc/rICneYJZbTA4pJt85
 MXSHB08sYifmp0azv/+O7tlmgtNjjDWrtR/Y+UOD8JuHVAdIuSaeheT3JiacumnwIvniC9
 kPFwgIMa41sA1ofl8W2+u/VkFqOmE9c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-vc8x0h2pMVSBFhPNMFg5SA-1; Tue, 12 Mar 2024 18:28:38 -0400
X-MC-Unique: vc8x0h2pMVSBFhPNMFg5SA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-513b3ca9650so1713532e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282517; x=1710887317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lDoWlZCcLIPjIofqG1lsxz2N/rHF6vbYam4xDSG+ms=;
 b=nPMyqQF4i3ANFBlyvZPyMJcqa38+jjTpVlN1ps2KdGT65QXcr3Dq7beGJ2s0SsyxW+
 QwCMPLTcDx6kG0RxIHSuV5ELxkd1TyVT+2HfTLRB1VMKnKt/knW9nUpeOiHKocXQmhcH
 rAxHPUNpuhwuZ6ZyDyq3zFXF4ymxpY53Xr5tcngg+6vwyzF8y7sBaAAIJZd0/1+JKBSq
 wJQXjaM1rooM8VSU6Xlh0g8ANjrPaeqMURySvwuNOYMofEJiGgXyz9QA0Wcr04LdQGSv
 kpcbwprNA3+0IHqoIPSDhoau6aU08/ezOSPqWbAoKPJj4WDHIGxTfLrLiULsEQkfJiCO
 +/lQ==
X-Gm-Message-State: AOJu0YwiGmGGMsXq7zWkt4389M/q/wvY97qNaBmXD5mkQUCApEhi0be5
 fFzTajEwOuGADZg4u3FSdMFo+4cDCPK8iJ9HMHCrrp1UeTI4u1ITwjP7TwUzlmr/zKbAG2qrStr
 axRa6s4WdyoNZ6P0rfqE5RQ36D5qclrHO56RKLIyaiHnaYemLMgGSqNzkdmuY+ctSmVVBWasykk
 o6DlqGu+UIqyEffYmknTi21mkT0pigtQ14
X-Received: by 2002:a05:6512:3c86:b0:513:b18a:f207 with SMTP id
 h6-20020a0565123c8600b00513b18af207mr5102661lfv.51.1710282516754; 
 Tue, 12 Mar 2024 15:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjJRCeEnD+IZCxNVFAo1p3/DyYoT1Hgicy9EADwv7IZaBtOi/HinFFX6woqkaBzOjFH66H8g==
X-Received: by 2002:a05:6512:3c86:b0:513:b18a:f207 with SMTP id
 h6-20020a0565123c8600b00513b18af207mr5102644lfv.51.1710282516241; 
 Tue, 12 Mar 2024 15:28:36 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 l26-20020a1709061c5a00b00a463d1d017esm1203169ejg.1.2024.03.12.15.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:35 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 56/68] hw/i386/acpi-build: Add support for SRAT Generic
 Initiator structures
Message-ID: <5deced6a13de9409fd9114432b25072189a68942.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ankit Agrawal <ankita@nvidia.com>

The acpi-generic-initiator object is added to allow a host device
to be linked with a NUMA node. Qemu use it to build the SRAT
Generic Initiator Affinity structure [1]. Add support for i386.

[1] ACPI Spec 6.3, Section 5.2.16.6

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Message-Id: <20240308145525.10886-4-ankita@nvidia.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/i386/acpi-build.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 15242b9096..53f804ac16 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -68,6 +68,7 @@
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/acpi_generic_initiator.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
@@ -2046,6 +2047,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         build_srat_memory(table_data, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
     }
 
+    build_srat_generic_pci_initiator(table_data);
+
     /*
      * Entry is required for Windows to enable memory hotplug in OS
      * and for Linux to enable SWIOTLB when booted with less than
-- 
MST


