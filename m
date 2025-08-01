Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59972C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnS-0006iI-NN; Fri, 01 Aug 2025 10:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhi-0005nd-LX
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhe-0002sS-JN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGbO7vd636Hu1LhHD46O82pGLm04aUgQk2cK4yysdEk=;
 b=XBw4PrWAKx+osTq3jm+kLiH3p1C1BZrrEGCbvvxVYjh+l3JP+S8V9ri0NYrVtcSfaNgGE7
 Q2Y3LHMDQtEfG6+SaPV11bUvuTrlkMncXzNrYNnEyETg34NpILE+6nXmlh/2Yb7yvh9/5I
 /DeeuSSclebxiXeFCofI5Ta25lSgB/U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-x7koJ-GgOe2MQ0tETarNJA-1; Fri, 01 Aug 2025 10:25:44 -0400
X-MC-Unique: x7koJ-GgOe2MQ0tETarNJA-1
X-Mimecast-MFC-AGG-ID: x7koJ-GgOe2MQ0tETarNJA_1754058343
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b7825a2ca5so1586772f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058342; x=1754663142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGbO7vd636Hu1LhHD46O82pGLm04aUgQk2cK4yysdEk=;
 b=nBmv3MXjg3QNSSLQwQeCPFi7iZM3Zzilxt5bnvvh+1bSpX0UKaShI8OF128lPIYTO6
 Hx0qeK1tu/yJ7BV82ldaktA7jWnjd5WwZKo2diU9XuFNIHVGeQe3tQWya49k0sbpbaUR
 TJi8fh8N4k8r4rlUBxk4SGqz5ZJmGITgRW/fVSSfwnTVR24Jk00i/PM7bzCax4tRew8O
 g4gc+5/Xzx7dqvEP3S+9kvxYtlL3X4a8rVY5UxWMaOQHoXF2HcsdK4qJNhp9q29pK8mG
 R9WQBFHPkuB2TDbszf+TyydqMIDOZdJlMr3LVgh8xJzxX5MkcCMrCUGcHyzXWgboMX3z
 EIKQ==
X-Gm-Message-State: AOJu0Yw4y60aP3yHT9y2XkUDYt95QafGYO4sOMti2qndJQQLOYffKt16
 EQmEJFuqPV5oVl2MV31vI1eaMrTUePUb1rir3T3yBp1pZG2O7KZ0sS8H1d8IB20aZ6/MhoraxUl
 3kcfmkBHcO/jywbaHNZJCdBVh1PriOvQcZEBPkC6QFICquObCnBVui07ZJFwRXbwtdiUPr01E1D
 8FGr1rJMGzOrS0PGgAOasYahHA9HMXfWlfNg==
X-Gm-Gg: ASbGnctGUXBNgHnqEbqhplPKUazUYYm7UlNudL/OpsY/fbyrfvfGwaPGikmBZgVipap
 HMwncvmJSwTphzpkvoWJjyMzFUbtgQwU6Kdl0vqKGRdA827tzmwlEJepi0wrS8KKzqCvl/cw9yk
 R7RPJEeaatPRcEPj1TF3hcebH0K8oWVdOVrkpuYi28McQpuHqmp6jp5yKugqVz7EpuANYhSIFJ6
 TH9cvq8Kque9PJMKyDAtCHA+4Fq+GZAQsqA6LX83aETRP1SqzJThHos6nyu4lcCOlwQ2OdupAli
 kNCztP6c6NsrymFYA+Ni8Uonnt0D9fs5
X-Received: by 2002:a05:6000:430b:b0:3b4:9ade:4e8a with SMTP id
 ffacd0b85a97d-3b79d4e0b4bmr5800464f8f.21.1754058342389; 
 Fri, 01 Aug 2025 07:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl0is/rcqzTgv6qbWMWQ2gfImg3xA4GSo3aSk4vVpb8eS24zyZ7S2sUmRqUIE5D10RcbTsuQ==
X-Received: by 2002:a05:6000:430b:b0:3b4:9ade:4e8a with SMTP id
 ffacd0b85a97d-3b79d4e0b4bmr5800435f8f.21.1754058341889; 
 Fri, 01 Aug 2025 07:25:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abec8sm6360138f8f.8.2025.08.01.07.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:41 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 17/17] net/vdpa: fix potential fd leak in net_init_vhost_vdpa()
Message-ID: <4caf74916d09019e61c91f8cb1166510836d35e8.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

Coverity reported a file descriptor leak (CID 1490785) that happens if
`vhost_vdpa_get_max_queue_pairs()` returns 0, since in that case
net_host_vdpa_init(), which should take ownership of the fd, is never
called.

vhost_vdpa_get_max_queue_pairs() returns 1 if VIRTIO_NET_F_MQ is not
negotiated, or a negative error if the ioctl() fails, or the maximum
number of queue pairs exposed by the device in the config space in the
`max_virtqueue_pairs` field. In the VIRTIO spec we have:
     The device MUST set max_virtqueue_pairs to between 1 and 0x8000
     inclusive, if it offers VIRTIO_NET_F_MQ.

So, if `vhost_vdpa_get_max_queue_pairs()` returns 0, it's really an
error since the device is violating the VIRTIO spec.

Treat also `queue_pairs == 0` as an error, and jump to the `err` label,
to return a negative value to the caller in any case.

Coverity: CID 1490785
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20250714101156.30024-1-sgarzare@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-vdpa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 6a30a44d2b..74d26a9497 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1840,9 +1840,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
 
     queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
                                                  &has_cvq, errp);
-    if (queue_pairs < 0) {
-        qemu_close(vdpa_device_fd);
-        return queue_pairs;
+    if (queue_pairs <= 0) {
+        goto err;
     }
 
     r = vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
-- 
MST


