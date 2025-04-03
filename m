Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6988CC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 21:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RwB-0007FE-2J; Thu, 03 Apr 2025 17:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0Rw8-0007Em-Dd
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0Rw6-0003Xq-LF
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743715038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLE/rOljhYcKkee5KfpUVAXzzbJsE070XYVR86PaEbw=;
 b=PQe4aSgMyFbxSC73o6cSKVO87kGdSxnTSDuPEJQnqc1BHlUKD4C5hIA5a3sJXBLEMpR8B+
 1wweIiGXrCncQdqyPAwzv3NH6jaav39/RlrX08dWc37a1tjiJcC6+IxHlW1hE8yg2har3U
 pza9VJ7S8fzELw3Ia6S6j0pMZqvVTPA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-eapQg3TmNha7deCH6SAvOA-1; Thu, 03 Apr 2025 17:17:16 -0400
X-MC-Unique: eapQg3TmNha7deCH6SAvOA-1
X-Mimecast-MFC-AGG-ID: eapQg3TmNha7deCH6SAvOA_1743715036
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39abdadb0f0so794628f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 14:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743715035; x=1744319835;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLE/rOljhYcKkee5KfpUVAXzzbJsE070XYVR86PaEbw=;
 b=e4utJpUje1QVaeeYOtDW4IS8KrXv2NzfN6PQOwhyDbriyErPCfb1mFROb8hTO3h2sT
 R0fbfuoShKCgKAW3fNMr/gD1J5pKfYUw/iFMyA33B0cFyyQZC2qBOA1qMlpDZUzZFlED
 jh2uarO0aOxg2UckxdqwHLpCyRaiQpgyPZwRuhtKOlf5SMRMM2lYiPJ38FlPuDvveP9H
 5WFMS7hWvEtfqjPoectzZFXcE6sxNkK74wz9/7v8/P4beDeswpdnvGkujA+JfgSW0xtE
 hTuWf2ZdKe4p/vi5L61wOmkMZv5ZI0XJLCR+U3p7dlJnwSUWj2ZG4HdsbPHlkJUtnJqU
 Bf4A==
X-Gm-Message-State: AOJu0YwG/7AC6lqOjx6rp8gDL+7y2X4CU94icN+VVIX127QDmIxD3rBx
 Y3DczDYp6tIKLSYfK7KVsaz3fJ2leVEHkwUCsNJdrEtf4RfTQRQxeHYfMSddpZyqV1NVSrjszCl
 CHb9fZXUXIJfxEceTZfhvnLWyUNomQfohBkmVaFHUtugRk9Ib2C0jCq3fJbKqJ1JEynfXrm4Fjh
 m7zGeVmbZq2hrV1Kurxenv25YqU/dDBg==
X-Gm-Gg: ASbGnct8ku3105wPlSHCAxcH+HWTwKAo06h+F41JvoyJ2rbr4rkurAPA/cNoCsoMqmd
 rM2lTt8uk/dP/krRilC0I7n5cUkLnJG4akpITcWxMx0kQ9q6fkmFs42bSFHyA4FGKDo2skqVPL6
 ai9VxcAcAe/SELB1/0lg9m95/VKsUVFn5bnCaCiw2tbbpHqdDkTr5fK99pIDxp3fB+M1TM9m8gG
 ZOrHn03Pmb43M4FvChuT5X2Qb20nF2eAFn6aQrAS+JdctOfgHDXOwkg63VuNh/VXqFsEVZV0KBG
 rF74vo5Obg==
X-Received: by 2002:a05:6000:4284:b0:39b:ede7:8906 with SMTP id
 ffacd0b85a97d-39cb359572bmr692277f8f.19.1743715035044; 
 Thu, 03 Apr 2025 14:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAE5MciQRbH9GYgGD8Vmmt42G3z0anH2luj4MxhpsfTwoIeCcxT4oJ1ZhIKzSENk0JBMTrDA==
X-Received: by 2002:a05:6000:4284:b0:39b:ede7:8906 with SMTP id
 ffacd0b85a97d-39cb359572bmr692255f8f.19.1743715034615; 
 Thu, 03 Apr 2025 14:17:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3009674bsm2728931f8f.3.2025.04.03.14.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:17:13 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:17:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 2/2] hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD IOMMU
 device
Message-ID: <719255486df2fcbe1b8599786b37f4bb80272f1a.1743715021.git.mst@redhat.com>
References: <cover.1743715021.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1743715021.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Currently, the QEMU-emulated AMD IOMMU device use PCI vendor id 0x1022
(AMD) with device id zero (undefined). Eventhough this does not cause any
functional issue for AMD IOMMU driver since it normally uses information
in the ACPI IVRS table to probe and initialize the device per
recommendation in the AMD IOMMU specification, the device id zero causes
the Windows Device Manager utility to show the device as an unknown device.

Since Windows only recognizes AMD IOMMU device with device id 0x1419 as
listed in the machine.inf file, modify the QEMU AMD IOMMU model to use
the id 0x1419 to avoid the issue. This advertise the IOMMU as the AMD
IOMMU device for Family 15h (Models 10h-1fh).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-Id: <20250325021140.5676-1-suravee.suthikulpanit@amd.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5b21cf134a..5f9b952799 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1706,6 +1706,7 @@ static void amdvi_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->vendor_id = PCI_VENDOR_ID_AMD;
+    k->device_id = 0x1419;
     k->class_id = 0x0806;
     k->realize = amdvi_pci_realize;
 
-- 
MST


