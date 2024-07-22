Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACDFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgm0-0005VY-AR; Sun, 21 Jul 2024 20:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglC-0001j2-AQ
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgl9-0005v0-EW
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69G17GN4Uq3+tY5aOWicSxywkAKy5R3rr33OsIJt9PA=;
 b=Vd5ZhJtZXfsuRIUE5FopWGRCGwo3TT5mXWrTj9V1+rq8wp1ZjDpM2/0k3k6jupE82Yk826
 1t6Kk2eopl+pPjQwPHgai3IE7rJrxT+RiigqgDe8l82Ve1ozCU4rrUqMnM18z3UoO2P3S8
 ou3MsxSPVsejNsrGwGE/rBhwmQmumZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-2RU-yBHBMEWqrAr0GUvn2w-1; Sun, 21 Jul 2024 20:18:32 -0400
X-MC-Unique: 2RU-yBHBMEWqrAr0GUvn2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427b7a2052bso37781595e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607511; x=1722212311;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=69G17GN4Uq3+tY5aOWicSxywkAKy5R3rr33OsIJt9PA=;
 b=SpA7XgfdEI73tyLJmTTHgL/n1JF8IC0hGs4tiCqF/tp7D/2GLsavtGNY43dhowqoFa
 m8115dKVwxPxSzFnqPX62ZiOgo1BbLAH5np0+p2fuQKdl3Ad1Dj1fMvbDGv2bI4xEHA6
 mEp2sXfCvsqnrs7h+bgnP98jhv5BNt1/Zwu6IjEt4x8w0TCcFlNvJ6RCyWKFThef65ae
 v+bL1c0HrstfDn6/k5Td0cN7Pm/yHUwPVRH09VwZZvABkYheH6rnUV0jcVSbhOsryqMF
 f/yZrmuUfRwtiO8g1OTulD0L7jpyeKnLm52X0kUhO6AEteOKmLNYoxI85XoK5/GQ5BZk
 OIsw==
X-Gm-Message-State: AOJu0YxXWp2dtMCHgCCAP7CRafp0eOKS0fJolbFp3mPReOmUyMzEFzW+
 brMvzkD02E2bo87CDurqUAuy3TzDqlksEUtL/tXKHFzgaAyTtctezPZSkOXPMCRqvQYQwRM83wg
 kSZTGNeyRnv9U8/fZYwWlhpKUBw7TBjKX+2wgwVGJsRtikdShF06Ls3ZfNRGjD9IgPhYKgEprs4
 ntm//Abpwj6rDkAp8cG8p6lOfFRFVqwA==
X-Received: by 2002:a05:600c:1c2a:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-427dc515beemr42567885e9.4.1721607511022; 
 Sun, 21 Jul 2024 17:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAQaOVzbbduw1T5NliFk1+46Rn/a2bF5urrIUlnBbkMdCQWOyPCx6DN2WFQABVTpb5nUm1SQ==
X-Received: by 2002:a05:600c:1c2a:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-427dc515beemr42567755e9.4.1721607510416; 
 Sun, 21 Jul 2024 17:18:30 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8d8f9sm133844425e9.37.2024.07.21.17.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:29 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 46/63] virtio-iommu: Remove probe_done
Message-ID: <e8f087887de28cf8e7949e78e3074366bcee5ee4.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Now we have switched to PCIIOMMUOps to convey host IOMMU information,
the host reserved regions are transmitted when the PCIe topology is
built. This happens way before the virtio-iommu driver calls the probe
request. So let's remove the probe_done flag that allowed to check
the probe was not done before the IOMMU MR got enabled. Besides this
probe_done flag had a flaw wrt migration since it was not saved/restored.

The only case at risk is if 2 devices were plugged to a
PCIe to PCI bridge and thus aliased. First of all we
discovered in the past this case was not properly supported for
neither SMMU nor virtio-iommu on guest kernel side: see

[RFC] virtio-iommu: Take into account possible aliasing in virtio_iommu_mr()
https://lore.kernel.org/all/20230116124709.793084-1-eric.auger@redhat.com/

If this were supported by the guest kernel, it is unclear what the call
sequence would be from a virtio-iommu driver point of view.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-3-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-iommu.h | 1 -
 hw/virtio/virtio-iommu.c         | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index bdb3da72d0..7db4210b16 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -43,7 +43,6 @@ typedef struct IOMMUDevice {
     MemoryRegion bypass_mr;     /* The alias of shared memory MR */
     GList *resv_regions;
     GList *host_resv_ranges;
-    bool probe_done;
 } IOMMUDevice;
 
 typedef struct IOMMUPciBus {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4e34dacd6e..2c54c0d976 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -555,8 +555,6 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
 
     current_ranges = sdev->host_resv_ranges;
 
-    g_assert(!sdev->probe_done);
-
     /* check that each new resv region is included in an existing one */
     if (sdev->host_resv_ranges) {
         range_inverse_array(iova_ranges,
@@ -956,7 +954,6 @@ static int virtio_iommu_probe(VirtIOIOMMU *s,
     }
     buf += count;
     free -= count;
-    sdev->probe_done = true;
 
     return VIRTIO_IOMMU_S_OK;
 }
-- 
MST


