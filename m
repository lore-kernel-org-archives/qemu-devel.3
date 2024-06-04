Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801ECC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUn-0006av-E6; Tue, 04 Jun 2024 15:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUl-0006U8-EM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUj-0000q6-7P
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=TsXVfhysq+J67o2n0dgYnsoSdSErj170YsCPpC6D2v7HppSGGYkae4c4iGu+7tsJ5kqQ4G
 MMlgYqA5w8Zu7FzBHxyaxsVLnpBozadGuzetPr5wJ6Gn2nTl6ST+VHYnZVAb6Tig5gcY9w
 PU4AVBZNMIgAZ90ReSdea/A06B6P1pc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-29FyxhtWOf2qHUudYCMSiQ-1; Tue, 04 Jun 2024 15:06:51 -0400
X-MC-Unique: 29FyxhtWOf2qHUudYCMSiQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212e3418b1so28890145e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528009; x=1718132809;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=gYfd7HIiL5OvulClhJCIDPR5O1Q/bUrUJkbm9IuUYdgRqE069EYb1R49gQZz3aJUN1
 Ok684aohqtmKLyunstJIhpaFkaqIt3YzkvorfNTuVvc7zSiM8MgPj95qDgssP9NzG/Fv
 AhvMk2KK3AdS+cY+nqBAvdsr302dpgbGh35fVLb4HNus+ouHAQc4w44boPHl+wCv1mpE
 C/WCxIe7Rx3RQqkUvi4/2i1vnbsaHNR0GsS8WkoYT1AVGePgL+bXRMjh8NuS1wMPju3q
 nthoZAuYg+6J/1RNSdNAKH7aaqGVMjXhpDG5sxz3WQFDmUk4eaePnDgPq0peamuNOhld
 GKMg==
X-Gm-Message-State: AOJu0Yxva+R3r1lD56P8ppGD+vddzrdmu5/1T2fUJspVhOt5KNqjniHb
 5qJCvkz4goyJwXb8YSPR1yK+ckdxrMs6qimuP+TPQrG3eepjf18JQEOp0rwNsLxp0M9mpds2NIL
 iXnrv+4X3C6i3Aga9l7o66I1uZwfDGbF+XeFVvxuoyTyuoWVeoRARkApqGekcaE3HyTTF/ZaYpj
 Msh1mCZjhmlyrhV8TZm2qy/coFEXR65Q==
X-Received: by 2002:a05:600c:468a:b0:420:2cbe:7efc with SMTP id
 5b1f17b1804b1-42156338119mr3821995e9.30.1717528009489; 
 Tue, 04 Jun 2024 12:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF8nIjvxzqDzX68xtPyayDg2GMCvXfhLLLwu7DRDdP2kNBvtKw7BjaOhA681ygADbLyAXhDA==
X-Received: by 2002:a05:600c:468a:b0:420:2cbe:7efc with SMTP id
 5b1f17b1804b1-42156338119mr3821795e9.30.1717528009043; 
 Tue, 04 Jun 2024 12:06:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062fe96sm12348566f8f.67.2024.06.04.12.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:48 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 14/46] vhost-user-gpu: fix import of DMABUF
Message-ID: <f08920e742aedb11438c07fa9f0040ad010915ae.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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


