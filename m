Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F016C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDFd-0004px-EU; Tue, 23 Jul 2024 07:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFZ-0004Wg-OH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFW-0002i2-Jg
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69G17GN4Uq3+tY5aOWicSxywkAKy5R3rr33OsIJt9PA=;
 b=E+jNNbPz35RAf1J88zZ8LBs10MaOWfGVxn2CxdP3p8iV1nEYCEk3bVFmubhvD2lV81injZ
 Sse7jnUYt+V33AFP+f5CjgC7Zv2rHofpwDKYCaLtsb7kPh0tx8NUPZIUJDvKUMlf9Gf1DT
 9jImuYwud7HxxtgLodIhGkU3Knywzo4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-hEIhuPr3OG-Aqi8TmJWyLw-1; Tue, 23 Jul 2024 07:00:03 -0400
X-MC-Unique: hEIhuPr3OG-Aqi8TmJWyLw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426703ac975so24145875e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732401; x=1722337201;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=69G17GN4Uq3+tY5aOWicSxywkAKy5R3rr33OsIJt9PA=;
 b=qMVWQmK6oTyDH9/Mgrw7Kl9B0KIv748XdNUimDJCESPzzoNgR/ymLQMXfUK0wtBpPL
 MsnZyzsLfS/CtxLrwiPDqya7sxCTHCHSuybGsDU//pvFRKIbtQPeuho3yNxHA4r74SrL
 B0SZItxr5uThUzSqCwJCvrkfitJydPoeTrVnpFGZh1cuWFSvNUj5h33I1RRgGsE20i4N
 xTpLA92EoGdJU9P7t39vJZ/o2ULApTQJv208eR0P63YqJVAo4c27lki9sBo6ICauQhzh
 Wr6Sl+nxQqTYSu2ZMRdrgrH17lKMOx9Fxy+Qdo0ZF63oS7gRjYI9yQzVCyP4YZ0JsFNd
 bAMg==
X-Gm-Message-State: AOJu0YwgtI9nycNGjHuOo+3JTzK8yDlP1wWUIVYZvB0ltInb5OchyprE
 cxaf59D+hu3nicS2QeIBhqzC6wOVCfEtcRjSiQECCufJZHo/yujJo7UMkeCHl3JtJnFT+yUIA00
 v4HF/c4VSLGEncJN3MeotphxSEMwNvygODgernd9QswcOItbGHMclbwO4ul4N49/dlhQyhN7xVv
 7yXD/y9gP3f6qh81MdI0DGY8Mir0TQnQ==
X-Received: by 2002:a05:600c:4451:b0:426:65b0:3035 with SMTP id
 5b1f17b1804b1-427ef3b6278mr12057205e9.15.1721732401695; 
 Tue, 23 Jul 2024 04:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0zdZsfiKSFMmQvEeoFmScvb/ZeaA3Kanjiif1CQiLfWsajwyEszs2WSl8si8hMQkPkDxihw==
X-Received: by 2002:a05:600c:4451:b0:426:65b0:3035 with SMTP id
 5b1f17b1804b1-427ef3b6278mr12057005e9.15.1721732401158; 
 Tue, 23 Jul 2024 04:00:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d8fbacc8sm154791575e9.28.2024.07.23.03.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:00 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:59:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL v2 45/61] virtio-iommu: Remove probe_done
Message-ID: <3745768918c2528f2b00b63bb3a764c458364f70.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


