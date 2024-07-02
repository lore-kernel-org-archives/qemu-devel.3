Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E655C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAX-00022T-5M; Tue, 02 Jul 2024 10:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAV-00021w-MR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAU-0007wr-0e
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=E3ZltpBwmRhpyJ7Bd3sL44DKhgPvIkC7kU6lT/7gAhG9ayXnAKo1jJ0Taxb8UkiumuiNjq
 yEumasd3ObXLmuFJwOzvslNE83djmK/X8cv9O5vlx+TCW4o+4+fnQLqSQ0mrjouTLCiL3R
 vreEVhceIwKhJ1E1555hSHSPt2ZqLD0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-2lL6FM1NOiSRhrU9_utX3w-1; Tue, 02 Jul 2024 10:07:32 -0400
X-MC-Unique: 2lL6FM1NOiSRhrU9_utX3w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee46230987so41678891fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929250; x=1720534050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=vCgeAQPAksoNtMoSCWOSOno9wgH0ABdW/TQUYAuLPIitu6dFjGq6h1iBy7SF4f6lhw
 ctQxys3C8gcLBJO4q8Kq7s5uxBUj8+Hrx+kMVgipf5RtqL+/O+rAIGdlylCDOiN5uC3P
 J5rsjMa60ylLSzVfIz6ZBJ9Q7j7oEaG3JbV1DDSTNFnW6hJ8eVaV5Y6TDP7SITED+Y67
 ajoXSZgd2dRL2zwDUO3+y0Xpc5cxpHF2ANlql0e5XFBLAs50mD/SWAH/6LvzLFr+3koj
 HwqkbR+c3bM9Gr76QH0WLmxddrYahooChtYLSnj7fawae9Ch6/CwUf/CyfAFxSAVvD7Z
 OAcA==
X-Gm-Message-State: AOJu0Yx+/NwyYmyEw7yVa5dC9XCy3HPd2N9Zfc3NEP2xVPkD7mYit9rc
 VAUco7J5WaDbUw82GisDKdGh+jdRjE/pXkY0TD/c8ZCtXFpIWO1QGjtbiArY/0jqd/DbElAUejH
 P3ejyfvkXnEbQVhLdyfVpvYGKPhix5Nwx0rNrp1KtdxcNtAMpxhEhkDWf0kTEM5iIvNZ7CAP77Y
 qMsJebZdfclCglIgfrqrhtJzO7B0M3Vg==
X-Received: by 2002:a2e:9b50:0:b0:2ee:7a71:6e3b with SMTP id
 38308e7fff4ca-2ee7a716f9emr3447831fa.27.1719929250046; 
 Tue, 02 Jul 2024 07:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM4iaAns7GOUfPGDVgEjQvEsH9+N2jBuvo+MiRqMKh7kkmQ29004uZ8ga71QcoruhGaU43zQ==
X-Received: by 2002:a2e:9b50:0:b0:2ee:7a71:6e3b with SMTP id
 38308e7fff4ca-2ee7a716f9emr3447661fa.27.1719929249451; 
 Tue, 02 Jul 2024 07:07:29 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e169dsm13248917f8f.65.2024.07.02.07.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:29 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL 10/91] vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits
Message-ID: <a0eebd790ca4f90fc1e3662cb38542ccc21963bf.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


