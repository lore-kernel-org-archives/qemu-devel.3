Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DD4C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjtb-00025H-Oc; Tue, 02 Jul 2024 16:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtZ-0001tA-DK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtU-0007b0-0L
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=HiFcG30i85QeS34IFZ9b1wSVqJjsvZZP4euZrmHu37gCPoUu0nRxqCHDHbwvrP8ycxjdym
 HhF3uuaNIuWBOpOr4PoeKuFQSG2Mtyf1CY9aSEOChTqGTogBJyhJeNWWetLs5PSDxgQFN/
 akH5qkxmvIQdGpX6mxwTi9ljuaN7hwA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-sKm0d7GDPIeUXF1adMMCbg-1; Tue, 02 Jul 2024 16:14:26 -0400
X-MC-Unique: sKm0d7GDPIeUXF1adMMCbg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-424fb2df2bdso42113815e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951264; x=1720556064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=kpapXCNK/SaphJvdGVtlL0CVLuOOVFvjpwImoRVWYAnCrs6a7JcyHaEzMSYwDE8M0/
 ANYhcRK4HHMudFUd/FUJvVtFlFUCzhmaldI0qmbW3wnxIO74Hz3U+6PecEjeLVWUJVhL
 2c/Nll8yFsjLxRPG/7LJlbjB2HR4dztdgnt6jpjd+Pfx6qV7wYxPI17URVN3rBaFJaA9
 CZ/La95TH03GwOFWuyY7jt7Hmk9UcAdWh4DyApC3JCxUtMSU14KP7wGlMItfVwYYi2OO
 prXAsWexvcLNfkoCwdghNXrgcjmaSQg2984c8LrMcrYLX4rfScPWLNeCKFzfZ7JeWmaA
 PxtQ==
X-Gm-Message-State: AOJu0Yxfj0mwNuRkGU2Tq8UO61WophOx6PfQieNJdncu0L/mfpvNTj2L
 MeSf/iwCFlSuS4GNfGvn+s0jF3el8ohzIu06g4j1fQI3iD07YZjCheDY/0YDR4yjNNkhphvuNWS
 9WFmN2TUtt3NSR0PtFN98M+IEQrq81MmlX904b7ApS5Fz/2pyP4twsEPjbGCQ3Fp6TwvTAFG28i
 ueRPfl2QgAdIPzwWM1/jKfYqoMiakL5w==
X-Received: by 2002:a05:600c:548a:b0:424:a5ee:a81e with SMTP id
 5b1f17b1804b1-4257a026e43mr93757175e9.34.1719951264383; 
 Tue, 02 Jul 2024 13:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKcbjd5SZh940w7ul4ULyWfXuDikAfKr0RLrvARZ0rrVRW2t1qJ9BCMiAGw1tpw7cbrq2poA==
X-Received: by 2002:a05:600c:548a:b0:424:a5ee:a81e with SMTP id
 5b1f17b1804b1-4257a026e43mr93756865e9.34.1719951263319; 
 Tue, 02 Jul 2024 13:14:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257fb4fabdsm117869255e9.46.2024.07.02.13.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:22 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL v2 10/91] vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits
Message-ID: <a0eebd790ca4f90fc1e3662cb38542ccc21963bf.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Halil Pasic <pasic@linux.ibm.com>

Not having VIRTIO_F_RING_PACKED in feature_bits[] is a problem when the
vhost-vsock device does not offer the feature bit VIRTIO_F_RING_PACKED
but the in QEMU device is configured to try to use the packed layout
(the virtio property "packed" is on).

As of today, the  Linux kernel vhost-vsock device does not support the
packed queue layout (as vhost does not support packed), and does not
offer VIRTIO_F_RING_PACKED. Thus when for example a vhost-vsock-ccw is
used with packed=on, VIRTIO_F_RING_PACKED ends up being negotiated,
despite the fact that the device does not actually support it, and
one gets to keep the pieces.

Fixes: 74b3e46630 ("virtio: add property to enable packed virtqueue")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20240429113334.2454197-1-pasic@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vsock-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index 12ea87d7a7..fd88df2560 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -22,6 +22,7 @@
 const int feature_bits[] = {
     VIRTIO_VSOCK_F_SEQPACKET,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_RING_PACKED,
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
MST


