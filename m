Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA56BC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5y6-0006tw-FD; Tue, 09 Apr 2024 03:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5y4-0006rO-Tf
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5y3-0001dG-7w
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712647950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAP4+njt1pIwAfQTze1NdkgjAQFF4DuHgSbUxqb26Ps=;
 b=GuwXt5lXXgyOXNsiTSF1ocpNH38oA9jbm7z901ZtQA0li47avqH2B/wwF+0UeAfZ6Zqbd1
 cPccVyho5a7PXhRfbJj/Jkg3b59Jjl0XBPS5fqHfuIu0LXYsLbqZnilFK+1/w2Ply9D5ii
 XJUA5catIlld2cnJ1mX68VsaIer3kbU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-NIN-NNbXPZKoaSfZ9U_d6Q-1; Tue, 09 Apr 2024 03:32:29 -0400
X-MC-Unique: NIN-NNbXPZKoaSfZ9U_d6Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4e9ac44d37so322820566b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712647947; x=1713252747;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SAP4+njt1pIwAfQTze1NdkgjAQFF4DuHgSbUxqb26Ps=;
 b=j6cYMv94r2HXkD0uIR0CPL8hF8kvScoZpJFBHTUPYN9U5SnZGpXPc1dvmlG0pVq25N
 B7wqdafkFyUbaiKsYpNupm+O63UATM8I/A+6m3U2AnawqV0DIT7fr6i8tdN4UiZRfIQ8
 b9/ssV2gzxh3kPHS8XVrxDVvu2PBqI9GVRCaR0h1SXJ/yBV/3OMdz3C631iT81jJg71A
 xiclmlx3AojIbiBBimgS+Q9G75b8snFh8W8SD6NMUj/VYJq00IZ/fIdQT+2LqBaVwAro
 6XshC3uTK3CzJ//7L6Z1Ix6x0mrJytUfbEX9iyunkoFM/1/XYKUssEZONe0wZbP3OryS
 PUVg==
X-Gm-Message-State: AOJu0YwKZoGFaHzwZrQpa83AjuTovb6rxxo7FEDiKKw9QcqgpHeP1RKU
 zlgLdrIpHfhFyYG3Eq2VrXl2W7197AlxVxxWo9kXtltQj90eEOEwkO/KUjPUBeDu1QQsw4tlDYe
 Ld32y4cZgumHdHuawD02r/25d5R1r4EgbXByJn79B7V1sMitbi3eIP+zEQ/1NwIoQZhWsJkAOgp
 B5WtrRuLflUO/TifisiXD5PezY7ekfXA==
X-Received: by 2002:a17:907:5c1:b0:a51:ce66:cf12 with SMTP id
 wg1-20020a17090705c100b00a51ce66cf12mr4481929ejb.35.1712647947367; 
 Tue, 09 Apr 2024 00:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX+/QWPXxLBP0Thn2cYzJlES9HupbUQf0gFgQztgqNYiXItXGpewIPScieYwI5v6meEx/0JA==
X-Received: by 2002:a17:907:5c1:b0:a51:ce66:cf12 with SMTP id
 wg1-20020a17090705c100b00a51ce66cf12mr4481907ejb.35.1712647946825; 
 Tue, 09 Apr 2024 00:32:26 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 dr19-20020a170907721300b00a4a33cfe593sm5318274ejc.39.2024.04.09.00.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 00:32:26 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:32:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wafer <wafer@jaguarmicro.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 4/7] hw/virtio: Fix packed virtqueue flush used_idx
Message-ID: <2d9a31b3c27311eca1682cb2c076d7a300441960.1712647890.git.mst@redhat.com>
References: <cover.1712647890.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1712647890.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

From: Wafer <wafer@jaguarmicro.com>

In the event of writing many chains of descriptors, the device must
write just the id of the last buffer in the descriptor chain, skip
forward the number of descriptors in the chain, and then repeat the
operations for the rest of chains.

Current QEMU code writes all the buffer ids consecutively, and then
skips all the buffers altogether. This is a bug, and can be reproduced
with a VirtIONet device with _F_MRG_RXBUB and without
_F_INDIRECT_DESC:

If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
but not the VIRTIO_RING_F_INDIRECT_DESC feature,
'VirtIONetQueue->rx_vq' will use the merge feature
to store data in multiple 'elems'.
The 'num_buffers' in the virtio header indicates how many elements are merged.
If the value of 'num_buffers' is greater than 1,
all the merged elements will be filled into the descriptor ring.
The 'idx' of the elements should be the value of 'vq->used_idx' plus 'ndescs'.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Wafer <wafer@jaguarmicro.com>
Message-Id: <20240407015451.5228-2-wafer@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d229755eae..c5bedca848 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -957,12 +957,20 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
+    /*
+     * For indirect element's 'ndescs' is 1.
+     * For all other elemment's 'ndescs' is the
+     * number of descriptors chained by NEXT (as set in virtqueue_packed_pop).
+     * So When the 'elem' be filled into the descriptor ring,
+     * The 'idx' of this 'elem' shall be
+     * the value of 'vq->used_idx' plus the 'ndescs'.
+     */
+    ndescs += vq->used_elems[0].ndescs;
     for (i = 1; i < count; i++) {
-        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
         ndescs += vq->used_elems[i].ndescs;
     }
     virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
-    ndescs += vq->used_elems[0].ndescs;
 
     vq->inuse -= ndescs;
     vq->used_idx += ndescs;
-- 
MST


