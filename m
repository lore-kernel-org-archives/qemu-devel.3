Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AC0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUe-0006DF-Ka; Tue, 04 Jun 2024 15:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUc-000679-2B
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUa-0000ol-F3
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=PhDMsLucHuY5Lkub302iKa0Rg9mkPyVNysxC8MDCHkYkzsXYmpEyDqCvzSyr9JtDjtTvSV
 uf6cHTtdDK2KbjSblQWhQuH4PqCN6HCgy9gfW9tIXy3pVel47ICLmnTIOO3wEg3EWcJgQt
 V8dKK+QG7cJLHCV/H5ZICCXnBqJNumI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-6f1MFBaeMfiBqbAXGXYvcg-1; Tue, 04 Jun 2024 15:06:42 -0400
X-MC-Unique: 6f1MFBaeMfiBqbAXGXYvcg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35dc02b991eso3395561f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528000; x=1718132800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=pYdhMTBhdmRVQBKgvLKKT1M/R7m0LuAu8xhufBcFlkFGvSzHPUMV25A1qvToy2fXis
 1TZ1U6OGrnmvSSRLUVHKJrcT0vYud2zNaNJ1BrpBtMJpgtpr2iJOsbTlV+xG11jcRdff
 NNbRe69tKi8kKzUOroxCa7yMMl5qy9ugbGHSUFSlAUW70YwbFWt4x3uzKCfRwszhibDD
 6PXsMWCkQFmWq2Nlyke7a1JPurGWX0BMKidH72Iu/kZm75KTf8K3LPhvD/bowEoChCp+
 cjlCDVuXS5nOBAYlQO8DYeKUnu2KJ1WNAjZUZbGyn9d0qMeg1a7qnuvcGvRIbmXEs2v6
 WCGg==
X-Gm-Message-State: AOJu0YwGKvhvQxjQxow8CsHm22FoBiq+ROkggOyAbyGvAoJ0nINZMQk9
 0ZAW0s0zxZfeOsERoekxlM/j9TWmfSgI12SxblacVOgm9U2mKPTtcD3rYz0jZeD5ncLbth3tVfa
 0dbXmtT6v2iLXLoU+Ix8bO16SniyZ7ysNDVu753RcaGIsri71ivvOSa+KYkvQlRg7fFC2b5WHR5
 kYOd4ewv8Bgmadkhh4+PlHA0vIsYTT1Q==
X-Received: by 2002:adf:f9d0:0:b0:357:e5a0:fbf9 with SMTP id
 ffacd0b85a97d-35e84070d90mr225318f8f.19.1717528000507; 
 Tue, 04 Jun 2024 12:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn3X4+EEySlXq6LaHpFrWsVF6Yl15lAKC2UfAU4GM0ENPXcl7wCuTQkL947OmO5Lbq6ZGEhw==
X-Received: by 2002:adf:f9d0:0:b0:357:e5a0:fbf9 with SMTP id
 ffacd0b85a97d-35e84070d90mr225301f8f.19.1717528000030; 
 Tue, 04 Jun 2024 12:06:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c4388sm12550573f8f.14.2024.06.04.12.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:39 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL 11/46] vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits
Message-ID: <1c4b7415ec4136a090973ff4a457474de1576753.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


