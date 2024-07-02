Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40551C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAe-00025B-W2; Tue, 02 Jul 2024 10:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAd-000246-1Y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAY-0007xF-IT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=boPF/u9hUk9B4ILn3LqZIY5n4i768QjdIqffYrFGvAj4lRgnz30zgx+NrCGBNKXqzMjJla
 um/WBZf40KPsN/BvYVzIHczBD3D4k35bqB2n+ylilophKMTj3eXzJbEQxSqY7S1rG80VM9
 kV1qEBSKsBSK5gde40jspZmdujVt2aM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-nXCjM2ZFPVeASiLr9XDgLA-1; Tue, 02 Jul 2024 10:07:40 -0400
X-MC-Unique: nXCjM2ZFPVeASiLr9XDgLA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-424a5a5f024so27779055e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929259; x=1720534059;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=l/xIVxQrdQJvtc2/12YIYfEt7h1m+swn3NSkgx4UV2c0pktW73ss6vNbhSda8oRtRR
 YRBynekPcGClAA9PxUqmQGemyXkh7obNt1OhGmE0t9TAOUJrDuDY5Nwt4aDjhTO5NEgI
 Jp+3mM5vEbxfFQ2hYaM6gZoSOXa5Ix5OW2nD7HaXaOan74tI4gBQ26D8Hy0AT6S1IDGV
 R6Edfcad5DBatcOPiceWUCpPPESWOGuPsXU0/H+20si+qAxNRWjn6FO5KEzJlWv48Nvd
 YrGCBkazOXM0eB5I9h4Bu922n3kEIxTWmpX78heFOOZU/0W3Jhx0HGTREE3FgwU2rLZr
 brzg==
X-Gm-Message-State: AOJu0Yxg3VqJ5Jd9pL+2y+SI+hKzW2TCS/cuBl8/P79xSKPDl1kDl6kR
 HNaK2lx4ZskrjytiYjEAcYNs8ML+RO9TMVZga8QmzTmXunt5O1Q+KkL2RA1Lz59tXs83pHGb6LX
 G8MD3q0h/e+j0zXY7VbRjOuw+z4wdJ16teiK2v2s+W+U1aO++Pr7sTacLc2J9O5JZkkNlYIJfLF
 +ZChl/+pDtTCMn5uJUJPz8yAzU1mO2iw==
X-Received: by 2002:a5d:6dca:0:b0:365:f52f:cd44 with SMTP id
 ffacd0b85a97d-36775728576mr5520127f8f.57.1719929259039; 
 Tue, 02 Jul 2024 07:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIM1ZP+vmzsGsnx8o0JIoLbeSKLtZCenEwfTtlsov0wC79ovdtgvVToKBXbl5jQI3eO0sAow==
X-Received: by 2002:a5d:6dca:0:b0:365:f52f:cd44 with SMTP id
 ffacd0b85a97d-36775728576mr5520110f8f.57.1719929258548; 
 Tue, 02 Jul 2024 07:07:38 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10307bsm13318067f8f.94.2024.07.02.07.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:38 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 13/91] vhost-user-gpu: fix import of DMABUF
Message-ID: <80c8a26de5f1b7d67d4594957c0d82a0c47626be.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When using vhost-user-gpu with GL, qemu -display gtk doesn't show output
and prints: qemu: eglCreateImageKHR failed

Since commit 9ac06df8b ("virtio-gpu-udmabuf: correct naming of
QemuDmaBuf size properties"), egl_dmabuf_import_texture() uses
backing_{width,height} for the texture dimension.

Fixes: 9ac06df8b ("virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240515105237.1074116-1-marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/vhost-user-gpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index e4b398d26c..63c64ddde6 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -281,8 +281,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
             modifier = m2->modifier;
         }
 
-        dmabuf = qemu_dmabuf_new(m->fd_width, m->fd_height,
-                                 m->fd_stride, 0, 0, 0, 0,
+        dmabuf = qemu_dmabuf_new(m->width, m->height,
+                                 m->fd_stride, 0, 0,
+                                 m->fd_width, m->fd_height,
                                  m->fd_drm_fourcc, modifier,
                                  fd, false, m->fd_flags &
                                  VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
-- 
MST


