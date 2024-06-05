Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3E8C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0AL-0002yU-Sh; Wed, 05 Jun 2024 19:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0AK-0002yE-Ri
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0AJ-0005Nm-Cl
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=IelX3q5Lk9b0PiUZp5TOltXoGgGXO3V4YT5654vOUsB+Aai18ujSj3Hq8oQSJkxJ18O65N
 hTfA9tO9H3NCthhYzuNJsO6nbGh5nPLB+oJ7pYCqVr0UWuilus9A3cC5nO41L/JeV89+mH
 N0/hQ9LzpOxTkaxkB3z9JsZZpx8Ij2k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-vPn30kxJML-YYc-TwNqcfw-1; Wed, 05 Jun 2024 19:35:33 -0400
X-MC-Unique: vPn30kxJML-YYc-TwNqcfw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68b4937c43so16645466b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630531; x=1718235331;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=JRcj22oYwxAxCpP0BfBqxyhyXh5HY3RNEDP2R0EAcTqUmTMAOYGW+hG7mWXuWMLxgF
 XF/SlCGAjqEuRVRm5e/amvGWZegghYHXUxlw/aszRo7mVJzI+dlLUjcodD+kfsAnSfOp
 G37a4a5Ymm8TPe685ABvKdEmubH/JBohpQobHcUyw7cLdDlHhlcehzlw15zKOpYHgNC0
 XNfK+Ufcr3DQP+akYq2X9ppL+5fsxWT2+AECT/eICbXHsW062KzX0xCWznxQOlK3C2AX
 BJMdycy0UXQHnHLNcFLBFejDUtfSSzuzCDrOMKnzfza6YWoI7x/Fy2KGv+qSX5eOqKo0
 MK3w==
X-Gm-Message-State: AOJu0YwDW2Uw1YlEeZvloZbMmNAW/rU1e83w7Nh3epJwwDeijMlygFC1
 9jz2iN3L+qfdMVaLVFT+GhHZuUQYSUbgmkE//jn9H0H0RXDWalbqmIVI/H3AtgO42KR2uVWNOZa
 zMlzpSigQem5rG+y5JLVz+mZB13VlwNb6ajabOrZZkltDMPRBWPq5F6FtMoGTLEPvrTjfMvTM7L
 1Vqk/FcnOF5qybmKCwmdvMH6yhnzza5g==
X-Received: by 2002:a17:906:119b:b0:a55:b272:ea02 with SMTP id
 a640c23a62f3a-a699fdff2d1mr244371866b.75.1717630531216; 
 Wed, 05 Jun 2024 16:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHddrL6oLM79FgOu7BK2ubtdDcRV/cRfGgj1FDVEQ8et82fG1Up603+4dabJJXn6hyFwqDmJw==
X-Received: by 2002:a17:906:119b:b0:a55:b272:ea02 with SMTP id
 a640c23a62f3a-a699fdff2d1mr244370866b.75.1717630530734; 
 Wed, 05 Jun 2024 16:35:30 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80728893sm6269166b.191.2024.06.05.16.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:30 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 13/41] vhost-user-gpu: fix import of DMABUF
Message-ID: <61d2299cc7baaa007120f6e1ce1db9d4af0a7ade.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
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


