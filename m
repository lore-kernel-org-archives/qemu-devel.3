Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBD3C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkW-0006AL-1a; Sun, 21 Jul 2024 20:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkQ-0005XK-H7
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkN-0005nR-GY
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qR3YDVYd2Wg1NGSld2m3zgomMPSJCBgN770Yvk3JKto=;
 b=jLd9vTxsDfy3/5krU7qmKxO01yA1Rgkr1d3Gddv9E+EaOlVxuNeM7wkHODrscPAbevElsE
 ieZvwtoBePzrhSeaD/3rZ12zacBYEZ6YXovtLlz67lDzgsHvII5xk/MYonUaupg1DgZTuR
 gae5yKpW44hHT0TYJOa8nRbUobi5s28=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-s0_JJ5xfPiuPJ8_vON2Phw-1; Sun, 21 Jul 2024 20:17:44 -0400
X-MC-Unique: s0_JJ5xfPiuPJ8_vON2Phw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42725ef39e2so26912025e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607460; x=1722212260;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qR3YDVYd2Wg1NGSld2m3zgomMPSJCBgN770Yvk3JKto=;
 b=Tx2Lo0VpfVXPYcR6uRuCT4WP20j4+9FKD59rLC16BCDg52gp85qQb0J8JNeSDM2BnA
 wFcYxfpqo0QREoDAHunJ1P+GewEQ45LtDRdDslP8yvSqtArVYl4JNciyp8biUXbkRPef
 OwKXgS5uP1Ocdpr0MH71nUe5YyO0s9skdpPr4HRquMk7JF1GfoLDZvCV8tot+K679/nr
 zpgAXi4G40u3vjyBSuNWTS1wJwh1Y9Dcx+Cu8d8CHFJhr2Vlpilgdb4HwjQMHPVkKCcU
 3QVrjDJch5edKHOyusL1D7qbC0xOBs1JiinzyK8oeXAJ1ImYuju91eGeoY72tGXEUCZ3
 E6HQ==
X-Gm-Message-State: AOJu0Ywl1z/+VCY4ySlw1rz0wMh7z08oHU4Rfk8nYLibkW+akt3bBGRu
 hP/kzyE6hob3Mc9PchD+ujMad10H2D/DYf23uTbNALj598kEfs1tEf0U5dZqfn+Iu7IonJjO/Se
 dIxkwrQf1WgsVsbhmmwjzPXezcoWLaweloakGcYQbZhcqG+uIm1lLRRbnfnkooe2DdSnsb/T7wn
 EeP1oAgoio40m0b4xVPT+dp/uOZIBtDA==
X-Received: by 2002:a05:600c:1547:b0:425:5ec3:570b with SMTP id
 5b1f17b1804b1-427dc578efdmr28707605e9.35.1721607460207; 
 Sun, 21 Jul 2024 17:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEje2D6euFaTQKRQVbBqxfL0t+RH1yWtfKfyi7Q4xwxL40Wm8Gat+um29Oj2O0ti0ja3MpU3g==
X-Received: by 2002:a05:600c:1547:b0:425:5ec3:570b with SMTP id
 5b1f17b1804b1-427dc578efdmr28707485e9.35.1721607459701; 
 Sun, 21 Jul 2024 17:17:39 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6934ec6sm106843415e9.41.2024.07.21.17.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:39 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 23/63] virtio: virtqueue_pop - VIRTIO_F_IN_ORDER support
Message-ID: <2256e8482b2bba88abcc734dbc6951b825773f0b.1721607331.git.mst@redhat.com>
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


