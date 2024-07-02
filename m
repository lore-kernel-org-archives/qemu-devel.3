Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21427C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwT-0000Pv-6D; Tue, 02 Jul 2024 16:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjv6-00066Q-Dv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjv4-0008BJ-NO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=Q0dJoepNHVDDTx3kBAsFNERF4wdWv1HpdRr1sT8LtYbQ7fi8b3NlJ4UDPyaCH1tmVAYp8/
 A/OhWW7ieOrjFzVtFxj/QRtHcBeiu2E+Eu+KZPm6gN4WQhBz4e0VLnNS1Pj5A/9zTHNCA6
 CT4MOd6OCI2svvGT2eWHcRowydbCHYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-p0NdaJGnNzaceNDtKi2M4Q-1; Tue, 02 Jul 2024 16:16:03 -0400
X-MC-Unique: p0NdaJGnNzaceNDtKi2M4Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3625bef4461so2283516f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951361; x=1720556161;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bV+n5a+n2PubUhTQh2qtot7neovPmYiRH9+8WKEDSw=;
 b=CvYGBzUVwqGDAzU1OgJGyIsBWJof+0VlBsb8bwKE9SBC1lGKR2RhxCxNDMFmyRRCwS
 kqXxZ7JUmsqQ6ghl0emStJflPy8OuxrsDNEPNWX8NXy7atMGfVPWIudKPt2Ff6rrjIep
 XclkaoowgK9MdrnESndtzRn9jDpBN74n3Oz25ExKGKS8Vgw3kz/JMCwAojyS0/hzzGjh
 xeEG4E4teXB5Aj6UYi0DVpRa3Mt8EwRlagWWFJ1318RhyMzc6mjhKW7QEeNcTnbztg5E
 TzfoTXw9MLC1v2TQbg6AkubsaJ7JaGArtNyPIvKRfFwPrVKwTr1R8s+gtRBQCTm8Cetg
 Oolg==
X-Gm-Message-State: AOJu0YywjUijbkAs2nfOsSddiFkyZh3oqiLnhYKypDkkFIls4rgWOAlq
 +UiN/MnxBJAI2KkqD8QyK0EjBzXAl0nzoi2OcniGHA0FMX8flnjyRMEa2Y+LZnokt3vR6nH62Zm
 GjHqGHudabHsPx5Dhvs1r2BR0i1RdKrsBGexygfmfoy+WdG2W1NQxjIZtBO5kzILJlOCzCyd8v7
 1nSoqkSHqDX3nCHIckJdJ//XAz/wzjzg==
X-Received: by 2002:adf:f1d0:0:b0:367:8f89:f7c9 with SMTP id
 ffacd0b85a97d-3678f89f8e9mr815074f8f.33.1719951360800; 
 Tue, 02 Jul 2024 13:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHte1jELuz+wmc959kT/fd5U3ljwpfAWJ0xpSEobuL7wKSz3zoBMcvTn60ekgjFUdIwvJA2fg==
X-Received: by 2002:adf:f1d0:0:b0:367:8f89:f7c9 with SMTP id
 ffacd0b85a97d-3678f89f8e9mr815049f8f.33.1719951360020; 
 Tue, 02 Jul 2024 13:16:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8cd8sm14088635f8f.27.2024.07.02.13.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:15:59 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:15:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL v2 13/88] vhost-user-gpu: fix import of DMABUF
Message-ID: <80c8a26de5f1b7d67d4594957c0d82a0c47626be.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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


