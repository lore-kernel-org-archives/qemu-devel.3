Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C422FC3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmM-0006eQ-9o; Sun, 21 Jul 2024 20:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgl9-0001XI-Ki
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgl7-0005ui-Ij
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i33/3Qja9OS3einDB0z9RqroZS7tFHAamIIdFj14KsM=;
 b=d0nV8Wlc0OUj3yQhDqMallwbjzC4qO96TRsZOuCTEafOD1mzCrDGzyNa6rFx/zrdLoi6qj
 4cwjIJ3zVyWMBnXkZiHY3ORDtGTFOe8jwcgnZYJZgnMImHBIrFLJlfgBmg5SWegUB/KW0k
 5XLNPwwxMps+G0y+UTHNYYDxazgkV5M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-lY0ZXDZPPsGhfpG9ve1Thw-1; Sun, 21 Jul 2024 20:18:30 -0400
X-MC-Unique: lY0ZXDZPPsGhfpG9ve1Thw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36848f30d39so2010723f8f.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607509; x=1722212309;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i33/3Qja9OS3einDB0z9RqroZS7tFHAamIIdFj14KsM=;
 b=b8LDZqN3PxzCcstYb+JwuaEcKr+c0A2T+ILsCHbPORmaiY+Jxc/Kv/HOiQaThNnj5d
 fQ+CwiwDclY3sP6biXTm/VvcNdH4fl06Kob9nQYZx//SbOk4yNc0jwtRDD5ULeGJrh8m
 zYB1tOXIUD6n0Kzp/omdPy7C+Y/Tp4QzrSv0RTTKgU04L2/Zh2SSA4WlwgbaoLkAvLTv
 Jgm4dKyc0qmRJxd/KBx7+nVVqhl/NAgc6hSOh8sQzAGmr+q+3UvMlFUEU6x5oNhIKBiN
 NcFluJ4RxOmqa69rEp7G8EAKp2eVYhw3KPOMCLeRul95XXNEm1HuXX/Cw14Nb2SSnlyp
 UBUg==
X-Gm-Message-State: AOJu0Ywupw2nq58MOsdoRRDop6Sq1KWrH2KpX92I4TCBdzF3ozGVaavk
 Ns47/0ozZevK+Jjcw2N1BuVaYcNIkZ/LOLyZ6fWq6RfFk2/PBT3CQLG3+Kd/VYZIluMtn+a+Jq6
 NWTuNlQbJuYXsVy7wuI92eb4rLMPUdE1VYslTTRvh4kbklzLg0wlnE+jnwdc9cDGjxVtghvF6P1
 wOViojFQVZOUtOKEufggMhZtUojB9BOQ==
X-Received: by 2002:a5d:64ca:0:b0:362:5816:f134 with SMTP id
 ffacd0b85a97d-369bbbb300cmr3923863f8f.13.1721607509022; 
 Sun, 21 Jul 2024 17:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK22AR+7mZMrfsh53tjz4BVVg7AMhBn1TC2xLGdIkNhQvuRomZWJOGRQSGkGxDSVHhpmBb/g==
X-Received: by 2002:a5d:64ca:0:b0:362:5816:f134 with SMTP id
 ffacd0b85a97d-369bbbb300cmr3923850f8f.13.1721607508443; 
 Sun, 21 Jul 2024 17:18:28 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bc21sm6983773f8f.39.2024.07.21.17.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:27 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 45/63] Revert "virtio-iommu: Clear IOMMUDevice when VFIO
 device is unplugged"
Message-ID: <df1b69e1b439065b45dadec94676b40b48a603e1.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This reverts commit 1b889d6e39c32d709f1114699a014b381bcf1cb1.
There are different problems with that tentative fix:
- Some resources are left dangling (resv_regions,
  host_resv_ranges) and memory subregions are left attached to
  the root MR although freed as embedded in the sdev IOMMUDevice.
  Finally the sdev->as is not destroyed and associated listeners
  are left.
- Even when fixing the above we observe a memory corruption
  associated with the deallocation of the IOMMUDevice. This can
  be observed when a VFIO device is hotplugged, hot-unplugged
  and a system reset is issued. At this stage we have not been
  able to identify the root cause (IOMMU MR or as structs beeing
  overwritten and used later on?).
- Another issue is HostIOMMUDevice are indexed by non aliased
  BDF whereas the IOMMUDevice is indexed by aliased BDF - yes the
  current naming is really misleading -. Given the state of the
  code I don't think the virtio-iommu device works in non
  singleton group case though.

So let's revert the patch for now. This means the IOMMU MR/as survive
the hotunplug. This is what is done in the intel_iommu for instance.
It does not sound very logical to keep those but currently there is
no symetric function to pci_device_iommu_address_space().

probe_done issue will be handled in a subsequent patch. Also
resv_regions and host_resv_regions will be deallocated separately.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-2-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 33ae61c4a6..4e34dacd6e 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -467,26 +467,6 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
     return &sdev->as;
 }
 
-static void virtio_iommu_device_clear(VirtIOIOMMU *s, PCIBus *bus, int devfn)
-{
-    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
-    IOMMUDevice *sdev;
-
-    if (!sbus) {
-        return;
-    }
-
-    sdev = sbus->pbdev[devfn];
-    if (!sdev) {
-        return;
-    }
-
-    g_list_free_full(sdev->resv_regions, g_free);
-    sdev->resv_regions = NULL;
-    g_free(sdev);
-    sbus->pbdev[devfn] = NULL;
-}
-
 static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
 {
     const struct hiod_key *key1 = v1;
@@ -728,7 +708,6 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     }
 
     g_hash_table_remove(viommu->host_iommu_devices, &key);
-    virtio_iommu_device_clear(viommu, bus, devfn);
 }
 
 static const PCIIOMMUOps virtio_iommu_ops = {
-- 
MST


