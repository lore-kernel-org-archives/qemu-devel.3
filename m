Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A63C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZc-0004Xe-2q; Tue, 12 Mar 2024 18:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZI-0004Q2-PW
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZG-0004Db-Un
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJIP+mB13E58BkNpHusyPXxmrUBHtsi0jjjQcT0sAlM=;
 b=U4UTsKf84WWKljM4LFNn8TuPYBCdxGw9AQrYH/NedOiod33sQegOTw4zDv/WNpUhj85RfB
 N5RYupBiYzthFxYte+783wZ9+p9j6fScnD5xGCiznkFeBwrqRwVnotZmgCgLYqYlaPOaTT
 pMdxrAL7VqCIhhKmdr9GRLnMYNx+s18=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-5b6rj8n4Pq-H_-OO4i8aBA-1; Tue, 12 Mar 2024 18:25:52 -0400
X-MC-Unique: 5b6rj8n4Pq-H_-OO4i8aBA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a44143c8908so27787166b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282351; x=1710887151;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJIP+mB13E58BkNpHusyPXxmrUBHtsi0jjjQcT0sAlM=;
 b=PhRLLR+1kDdRf3SPazv07vkQ7yqKSsf00NJSFtIsi+/+DXPRDS6UX8wEPXGFZxL402
 7rXvNoNpDxUBeit9GgqFYsFFab786SZR6PoyDGqdch+74DI8XqXvXpantI9wLLyIRlDF
 OaQ6eAy+k4aREaAtPavcAADhBuyYnktFRMVeagtgQI3yWoOL8rBSIeQ3gCcgyKE+1VXD
 s65gwKN2B2Q40gnoPbJpkyhZwDg89LpRbDWVEfKuMebaLbfHNxXRnGou/MxgRW6iULRj
 49hrhhoJL5YvnfMDCpOAkaVAMpGCLAZ6e1O5g6T/zx5ESvTr0+EoP5hwWFOveUbHIljL
 rxcw==
X-Gm-Message-State: AOJu0YzOoNudehGTMhb1GuQv3GqIELR3EHdnrhnfiDVyIRqzGep6x0PG
 zFGk5teXcNRXy/rdw2EeDewdxzD1jdOYc+YD3ZexNmcAv/bcdb+Pn+TvP0uhpGPXPRlVG1mDue8
 hzXiGFB9yXo3NXbNzDFDazDV4N8FlF0Q/2FHPzgH8LfxCvMfYHy5oy9nnyHlyjtfVeX0AG4Eh20
 OBncxHU+SFFFh7Obbb1N1LR0boHU7VHL+V
X-Received: by 2002:a17:907:1b0e:b0:a46:4ea8:9df5 with SMTP id
 mp14-20020a1709071b0e00b00a464ea89df5mr1010792ejc.5.1710282351064; 
 Tue, 12 Mar 2024 15:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzPloPYs+h7K6vPtgWVfpz0mMmWbvHAanSG3iRRGLaGPPKaLQTLd3hVZpqL+8xMzTra38J1w==
X-Received: by 2002:a17:907:1b0e:b0:a46:4ea8:9df5 with SMTP id
 mp14-20020a1709071b0e00b00a464ea89df5mr1010768ejc.5.1710282350442; 
 Tue, 12 Mar 2024 15:25:50 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 bn23-20020a170906c0d700b00a462e4d7216sm2028670ejb.76.2024.03.12.15.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:49 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 06/68] vdpa: add vhost_vdpa_set_dev_vring_base trace for svq
 mode
Message-ID: <19a060bce17316d9ff7d8b3637fb391010be8144.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

For better debuggability and observability.

Message-Id: <1707910082-10243-8-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 5 ++++-
 hw/virtio/trace-events | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index c7271093dd..fc84cf6ec6 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -970,7 +970,10 @@ static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
 static int vhost_vdpa_set_dev_vring_base(struct vhost_dev *dev,
                                          struct vhost_vring_state *ring)
 {
-    trace_vhost_vdpa_set_vring_base(dev, ring->index, ring->num);
+    struct vhost_vdpa *v = dev->opaque;
+
+    trace_vhost_vdpa_set_dev_vring_base(dev, ring->index, ring->num,
+                                        v->shadow_vqs_enabled);
     return vhost_vdpa_call(dev, VHOST_SET_VRING_BASE, ring);
 }
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 28d6d78380..20577aa584 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -57,7 +57,7 @@ vhost_vdpa_dev_start(void *dev, bool started) "dev: %p started: %d"
 vhost_vdpa_set_log_base(void *dev, uint64_t base, unsigned long long size, int refcnt, int fd, void *log) "dev: %p base: 0x%"PRIx64" size: %llu refcnt: %d fd: %d log: %p"
 vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int flags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t avail_user_addr, uint64_t log_guest_addr) "dev: %p index: %u flags: 0x%x desc_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" log_guest_addr: 0x%"PRIx64
 vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
-vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
+vhost_vdpa_set_dev_vring_base(void *dev, unsigned int index, unsigned int num, bool svq) "dev: %p index: %u num: %u svq: %d"
 vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int num, bool svq) "dev: %p index: %u num: %u svq: %d"
 vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
 vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
-- 
MST


