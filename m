Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178C1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDD0-0000pK-UA; Tue, 23 Jul 2024 06:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCt-00080R-0V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCr-0001qK-A0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qR3YDVYd2Wg1NGSld2m3zgomMPSJCBgN770Yvk3JKto=;
 b=Q4EOPnsRjhpPojfIM4x6YUP7NYaoph/fok9p6Av2+4z5b96lNZbzB1y+2GAr65eyNkgct9
 LpXmGoQ1/U/SKSadJwYxuEws/P23qw2nBmQIve0ir3HXXD/JsIrT2NmcSRLakWlQqnsylX
 2egmNsR5Y8t2NftgI7b3DxzAxzWPBe8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-FM7KPkqYNHe0zXPYMzAYdQ-1; Tue, 23 Jul 2024 06:57:19 -0400
X-MC-Unique: FM7KPkqYNHe0zXPYMzAYdQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7aa5885be3so3308666b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732237; x=1722337037;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qR3YDVYd2Wg1NGSld2m3zgomMPSJCBgN770Yvk3JKto=;
 b=xDfk9K9OpgkAHM7Ug28qPo63lKLrQrt5g/oKSLemHQhrmCyK73I2KTitmYSqOXGSLl
 a9/OSFmzzYUZWptLTtEvlsl21N5hOq6fpprvIHhdmuz9/c2ZTh6expE09ZpirYzKtnyf
 cg+9AGOCL1miZVWE4ZkQkdG4SX6EAwoWnYdRtUH/YxOlYF3olEQGDDXidCiItu9RAZpJ
 kmykyoWRh6UwuOBAso//tjOU/Gy3LIWwM1oOgxCV52j3Sky13a336R3KjD13jtPRzsf8
 nbsFi3eWYupSePTXeuMvatMIqsOLI1PUyMCs3v9jlgzby1yQpAyxSi/y4q+YcG5Cmmif
 CVlg==
X-Gm-Message-State: AOJu0YxRXCOu9xYM059C2y6xTBmj9BeXL4+n3UcvyiYEH+7hJLoOFBr5
 WDu58kRvAAbiirvh5KHI2XVdu6Te7ICcsawWJBvkhzoMHuUQUlniPIK4hgOGVbrLq4Y+rj7/kX5
 kKal3kks0GgFwq4w5ASHr37/U4BApaa/28zf90A56L7aVLfUF+A1/EpQWiQkyrVv0Jja6/LRnyv
 6Zdstbs3+iQYPfAGqMwF2oUBI7edYH6w==
X-Received: by 2002:a17:907:7244:b0:a7a:9d70:82ba with SMTP id
 a640c23a62f3a-a7a9d708385mr87936166b.16.1721732237566; 
 Tue, 23 Jul 2024 03:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6VnwoambekezAkLISItS3GlqwHu9fF82uSeCq6y9O3BBfcgtJOi+FnmHXe43ZAjxqNUQq0w==
X-Received: by 2002:a17:907:7244:b0:a7a:9d70:82ba with SMTP id
 a640c23a62f3a-a7a9d708385mr87932766b.16.1721732236822; 
 Tue, 23 Jul 2024 03:57:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a81ba1eeesm119402066b.71.2024.07.23.03.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:16 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v2 23/61] virtio: virtqueue_pop - VIRTIO_F_IN_ORDER support
Message-ID: <2256e8482b2bba88abcc734dbc6951b825773f0b.1721731723.git.mst@redhat.com>
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add VIRTIO_F_IN_ORDER feature support in virtqueue_split_pop and
virtqueue_packed_pop.

VirtQueueElements popped from the available/descritpor ring are added to
the VirtQueue's used_elems array in-order and in the same fashion as
they would be added the used and descriptor rings, respectively.

This will allow us to keep track of the current order, what elements
have been written, as well as an element's essential data after being
processed.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240710125522.4168043-3-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 583a224163..98eb601b09 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1505,7 +1505,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
 
 static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
 {
-    unsigned int i, head, max;
+    unsigned int i, head, max, idx;
     VRingMemoryRegionCaches *caches;
     MemoryRegionCache indirect_desc_cache;
     MemoryRegionCache *desc_cache;
@@ -1629,6 +1629,13 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
         elem->in_sg[i] = iov[out_num + i];
     }
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        idx = (vq->last_avail_idx - 1) % vq->vring.num;
+        vq->used_elems[idx].index = elem->index;
+        vq->used_elems[idx].len = elem->len;
+        vq->used_elems[idx].ndescs = elem->ndescs;
+    }
+
     vq->inuse++;
 
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
@@ -1762,6 +1769,13 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
 
     elem->index = id;
     elem->ndescs = (desc_cache == &indirect_desc_cache) ? 1 : elem_entries;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
+        vq->used_elems[vq->last_avail_idx].index = elem->index;
+        vq->used_elems[vq->last_avail_idx].len = elem->len;
+        vq->used_elems[vq->last_avail_idx].ndescs = elem->ndescs;
+    }
+
     vq->last_avail_idx += elem->ndescs;
     vq->inuse += elem->ndescs;
 
-- 
MST


