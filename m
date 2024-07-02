Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0536BC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjti-0002jn-Ow; Tue, 02 Jul 2024 16:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtf-0002Xk-4A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtd-0007by-IZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=D7aPZxj9ITWoEWRoO0H1Okx4b4bBZpQ2eZ50eb0cYLDVLzXFgoHjW7GzCv++ROMYivPsyj
 9y+EpHYJGsQZcwxn7MV/YZbvbYNiab8OOBZboc4y6tfCpoIYqnIooCRNlN2AfqaYDQ5FT4
 eVMb2Sb1XmNbgzAu8meiynac3vGIlwo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-yqeaZFxoPJW9H7sahcvl8w-1; Tue, 02 Jul 2024 16:14:35 -0400
X-MC-Unique: yqeaZFxoPJW9H7sahcvl8w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678e549a1eso364935f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951274; x=1720556074;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=hpqZr0+QA0k+SJu64KZHZyU8z8gm/vVAriPneu6Fi5urF/gk2o0ki0a0YAxnpwpaXk
 RU+khECpcLzE28oL+eaBoh6Q1dShYLSdAuidd51Iy8lZsPSWasr8MhWQG7M66CTi8a2i
 hjOzpkBZfR0GBTwgrAVlhbvliXKeB237b+cTxypo3Dj5tr2jaqQ1rrtXWjlwOfTMQSv/
 pqLazSLlL2wYGrN0T+UGTg/31IPmnxFZziBVrBM/F3veHrMXSmwxOFbaqW0xLJtvdXZG
 doyDspFmKQtFY6Zwr0qCdDWm+xyqs0BniLAe0case84qlCf3iMWNHnNfnc8+Q30TKKXX
 MO7g==
X-Gm-Message-State: AOJu0Ywl2NGrvpzvHQ9H21R/59d45jrHx1Lk6C2R1O5KliBMTzF7Jtyr
 OEZnDXsRcQAA4Xr2XGkOzIyeJOI4NOmfqG2lqAchz70jPzwdLBYq8zPiRenHanm9YuiuQejrdXz
 cw9cHKQebgFlJ4NirUhneLd1Z0M5/VSJizndXxOz50FkZUH0cKE28GrDWyXdjnInZtnUCKxGZqy
 847B1IMaGSBR4gRu2E8STXSeGRcE8OIg==
X-Received: by 2002:a05:6000:1fa5:b0:363:b3ea:7290 with SMTP id
 ffacd0b85a97d-36760a7c1d3mr11939434f8f.20.1719951274203; 
 Tue, 02 Jul 2024 13:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLecyn7ZBvvspbnxBGcKjPpo9PrK6dn9JMj/R7pdyrcuMSsk78qZbxGXrravxG2IEFAL1GkA==
X-Received: by 2002:a05:6000:1fa5:b0:363:b3ea:7290 with SMTP id
 ffacd0b85a97d-36760a7c1d3mr11939407f8f.20.1719951273639; 
 Tue, 02 Jul 2024 13:14:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257a2f7451sm154403165e9.0.2024.07.02.13.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:33 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL v2 13/91] vhost-user-gpu: fix import of DMABUF
Message-ID: <80c8a26de5f1b7d67d4594957c0d82a0c47626be.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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


