Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84751606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nxw/TEhH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iv/YIiOf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hp-0004ry-15; Wed, 28 Oct 2026 13:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fy-0007pC-2n
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fw-0003qr-AU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5BCBX9J9Piq9aCKwLW85ix0SaNwSjXUe/ieIjQDH6oo=;
 b=Nxw/TEhHfJ33x9ohYkTXCWHva0A12WnzvViOf7lNMYHEfjCn3tuK0wDB4v2XiSZUySwgAN
 YCglqa4C5ibd726EDpnxSBzDpo24T+FXZrmI0WUNmQ8GeygR4rBDkxUnHBiJit8SKbdLeL
 x4Oc+9BtuoTKzxE8DOtf1voYJ3AwVoM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-hfOAlA2ANjuYYfAo6J5_FQ-1; Wed, 28 Oct 2026 13:16:05 -0400
X-MC-Unique: hfOAlA2ANjuYYfAo6J5_FQ-1
X-Mimecast-MFC-AGG-ID: hfOAlA2ANjuYYfAo6J5_FQ_1793207764
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso7350025e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207764; x=1793812564; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5BCBX9J9Piq9aCKwLW85ix0SaNwSjXUe/ieIjQDH6oo=;
 b=iv/YIiOfp1F9iWvUM4jSrETxloaL5ruBn420XclGtU3jp7mV7RSbauK6hiP32rcg4f
 FtN0sdcUakuihm7X/sodYAjn7ZD1R/Oo7kBN2I0oB4k5NyPWEndu1NbSxgnLW32s5/Bx
 QW9uTegaYOS41XEdWayHumBGs3HKKDcNm2KIdScb8Lnd7F9SoeTbXe2aNK102Z+WWdSR
 +cReKV0vFkcPFd6WLWAPFfZ2N/wkBiMq8RXwn2QzS4Fgu9+ilvDPk7KBKoWIB8oRMHjL
 82G2yxvmOhzOp6naLf7pioTpPT7OnYQTIERcdi42eu3Kx1/3Y8vC/Hu+eoDiGfEEyt1n
 4mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207764; x=1793812564;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5BCBX9J9Piq9aCKwLW85ix0SaNwSjXUe/ieIjQDH6oo=;
 b=vJf+e/lucp/cipWuZ50JG2BTT9Tl57XOoFeUNWwupAw5UYcttYtLSK9lXJZrBvUnkF
 1b0IG6fyA+t1gJY1RtA1Bc/oqAycdGAJsJMGjIk9RjX8cFeQiJH9+Yj8XCP7ohrMno7g
 NmVh1I9dq5XC+h5wgwYvFt+RNK5zPgGkK4ZTDBFofyt3lxPh0wQRqRUcGqmPO7v9ICH2
 t9iJuO3nwkTTb11I07phj6Hwf/Oo3BaZU2quFKONni+YTFFMLNWpof8j3gIMbZpD3STf
 JlpGN0B07m4c3O55qEYRJKKKoBqcAnigLJCS1N9oJbrcwJ2mI1cCSJCTdqWraP3Eygaa
 SvZw==
X-Gm-Message-State: AFq9FYKhEQ4Qw1XqY4HGRBD6lECTs364+y/Gq0lbSAmdGyYDjo0PK/MA
 /qbcjBYY9kl+1Mag/1wmIrfA1O6ig4W1qyqsdyc3BE9QET2HBp2dRoKXfYciTMZzmq7Cb687n7g
 OkEdjjymE5lIoH/pd+QflAOHtz+8yZhdmiOLOAu5r2OJP41xRu0IkBrJUA9E6ebHlhFdpDUcqIy
 Xe7HDWRANx4GJtsi8m34VLRAHlBcuA6JqpxA==
X-Gm-Gg: AYBFou1XHCjwaEpx8+b7jp7MBnxQw3j+ESFFl8hhNGMrT5m1Jqyr7XW2FtKDAjqxdC4
 dr3NOLriH/FNXNMs0gtMycAsCe7/2d6G2rKKMOeMlyIvc2c/FAJ361mi8SQ02gR21G57qznZbdM
 ePHYOVPISVd6w+5vvoT/kG5+NtvfhdLTaE/snoeLEIPZHdoruXltc2qyq5Iz8KJ/KtywTHL4tnC
 IjPaaZpuUNnIcdF2+ygtIzhcN8WzB7ebjsFAybOAyf+h0GpavM960sYPUks1RVHP644ZffpqMkX
 UdL26v6P/2yB0CcsK6qu4wJ81PB6MHjyR0OvP3boMocYHp8o/o9ze0waHD2mRuFbaPn/ictMs5M
 wm/mATH2Sn/HBh+lI3KxQhZNZMwC3pNjfuXp6QiMr
X-Received: by 2002:a05:600c:6387:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4a9660b626fmr66797425e9.5.1793207764145; 
 Wed, 28 Oct 2026 10:16:04 -0700 (PDT)
X-Received: by 2002:a05:600c:6387:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4a9660b626fmr66796465e9.5.1793207763562; 
 Wed, 28 Oct 2026 10:16:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896fesm6161715e9.10.2026.10.28.10.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:02 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li RongQing <lirongqing@baidu.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 47/78] vhost: fix off-by-one in vhost_svq_next_desc with
 IN_ORDER
Message-ID: <e3b0a9e63b954a09e4673d2f42f715ae2040b140.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Li RongQing <lirongqing@baidu.com>

vhost_svq_next_desc checks id against vring.num before incrementing,
so when id == vring.num - 1 the function returns vring.num instead of
0.  This causes vhost_svq_vring_write_descs to write descs[num-1].next
= num (an invalid descriptor index) and, on the next iteration, to
access descs[num] — which lies past the descriptor ring and into the
avail ring, corrupting it.

The bug triggers whenever an IN_ORDER descriptor chain wraps around the
end of the SVQ ring.

Fix by incrementing id first, then checking for wrap-around.

Fixes: 485c9e69ef6e ("vhost: add in_order feature to shadow virtqueue")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260911081635.1872-1-lirongqing@baidu.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index c8831d52be..0fae35ba1a 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -161,7 +161,7 @@ static uint16_t vhost_svq_next_desc(const VhostShadowVirtqueue *svq,
                                     uint16_t id)
 {
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
-        return (id == svq->vring.num) ? 0 : ++id;
+        return (++id == svq->vring.num) ? 0 : id;
     } else {
         return svq->desc_state[id].next;
     }
-- 
MST


