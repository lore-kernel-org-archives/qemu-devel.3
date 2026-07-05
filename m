Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D5AC44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwo-0005xv-E5; Sun, 05 Jul 2026 10:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwm-0005su-6o
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwk-0001Ru-Lb
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S/TONRYQ3N3aydVgfUlml6h82IkxOyVKOC3903eRb38=;
 b=XoB3CUgs8WEMeDK52rPscy2QMMZHbKC5zGmkYwdsMiO/ZSHuF/dlvmQNGx4S0pe4/uF+6a
 pFPAuRNv+tT74DaUx+6z/Tx1nuPNSvc60ByTOKkRkuJSjj1aggX6ASSZ80EWg5cNugMl3N
 x/OkSFyzVeb1603zhI8iXr+0aTAdyOU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-FLLKoaEDMLOTjPizFybO8w-1; Sun, 05 Jul 2026 10:35:48 -0400
X-MC-Unique: FLLKoaEDMLOTjPizFybO8w-1
X-Mimecast-MFC-AGG-ID: FLLKoaEDMLOTjPizFybO8w_1783262148
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493caa3c54eso18814385e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262147; x=1783866947; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S/TONRYQ3N3aydVgfUlml6h82IkxOyVKOC3903eRb38=;
 b=aNaYzvSClOVuB7Hg/O8IsBkVFf6Q2bvoqOp2iRUDEoW4FkDNYgHG2bkSBb7P6CrBBc
 DJjIRN8rRDEOnU5hA5hbGxUSmMupJM5l7Sh/d5mgYPDBil42oVfGB8GEEmGiKf9q6NTx
 /GmsskM63nAnn7SkUeM94Yf6ZB2JlzO4aZkhwPj+GgXu5b9VKe/lJzO0qxxTx06VhTWC
 eHXOyou8sQt12a1F10cGjBvQIvRYTfcb8i9vO9e2UvKVGRZj0qUoYyqYcsCx2M1UOSKj
 OtrqZYDdsqqLsAbXJOI1SApQruXk0fg6sxnT6sGWPxVz01oMykfLLPjiShbh9Eq8cExQ
 JyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262147; x=1783866947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/TONRYQ3N3aydVgfUlml6h82IkxOyVKOC3903eRb38=;
 b=WeTOQJfNcrvdTqICs6GkcViyWz153G0e525jwVpP7yuyxeq6/ZZJqdWF/kRWc1Bibp
 +2LHrKBBZHNZZtB5jwtpG9iZk4xHVvnNPNoZ52m1idJtVGbDzJ1YXBOQ1y/gUddc40PV
 qs2T2Mg3rNsIfmN3J0MgMLaf5WVNyNuDk0hGti7GbBVFQjZ1iHn7polhaUjvQaoMRXQC
 t8RV27FtOZBEV7bG6ucFZZWE5J4xxL8G2pNanvzQsjFvfx5mjxieuRq8/9Gj/bzGinXW
 B2KLWi89s3plUFCMScg/JEN+0vEGQwRgtkqu45BK6oREAKCVYY2/1cBj5A1BBOxhV+43
 f+1g==
X-Gm-Message-State: AOJu0Yw8hBV8U6dO4tgxt1G/M63w5CwAFsfhq+58nAMCx7m7HvUbz8vw
 IP6rKic4BY+hKjQIlNT7nBbDNnIch9irW9mRAv5ounkOWsA6TbitoqgM2qRXvsXoDre36on3wZY
 uwyjNtUs+wDvgRV8rfmZ9bBpwFlDZBPyoLTm60mHS5hrHJTLo1X084wPeTgVzfaY1TBu44S2FJQ
 Vd8L5ccD1MGd0vp7N7BszbpEusc0xa0VfJbw==
X-Gm-Gg: AfdE7cnVnCNK3gHQbjgEkV0351f3ihGiwFTp2euO+Fi1qR1tqkONA0EfKztAJ6JGSa1
 eBFrWZeAdJ6MI2NgKbYT4Ux80sghirhvGxFruWQG8x0FkGHJ49W8ljQ2hCGS0ThKnuhduWEdzH2
 c59/lpouq8ux8kluNraXNpPN13Wjk6q77GMBGixvfFnoDx2I0Ts76fkFNpR5fkpjKHJTR6/GH77
 NnKTXWEMesqLfGspwxqBXuJpg0BXIGj/AfoKVW+GGXE//h9fefamKbWY7LK6FvI3wOVfaKIto0b
 eut7CEfArrJRy/Z1FQeqKNeQFZnO4AYlDbOzG4cpmWpj0wMki5PT8fmnSGLrI12sa7GsL8XBsM5
 1RtrhSC/Bgj04SBN4MWzMXiLt5lON/lm1
X-Received: by 2002:a05:600c:5897:b0:492:4cce:53e2 with SMTP id
 5b1f17b1804b1-493d11d0775mr52669955e9.3.1783262147470; 
 Sun, 05 Jul 2026 07:35:47 -0700 (PDT)
X-Received: by 2002:a05:600c:5897:b0:492:4cce:53e2 with SMTP id
 5b1f17b1804b1-493d11d0775mr52669555e9.3.1783262146820; 
 Sun, 05 Jul 2026 07:35:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab3a8sm231828705e9.6.2026.07.05.07.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:46 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 lizhaoxin04 <lizhaoxin04@baidu.com>, Miao Kezhan <miaokezhan@baidu.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 26/44] vdpa: fix use-after-free of vqs in
 vhost_vdpa_device_unrealize
Message-ID: <e03463812e74d1befc8d7f6f158eca531e2d6406.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: lizhaoxin04 <lizhaoxin04@baidu.com>

vhost_vdpa_device_unrealize() frees s->dev.vqs before
vhost_dev_cleanup(), but vhost_dev_cleanup() still accesses hdev->vqs
while tearing down virtqueues. This leads to a use-after-free and may
crash QEMU with SIGSEGV during vDPA hot-unplug.

Save the vqs pointer in a local variable, call vhost_dev_cleanup(),
and free it afterward. This matches the cleanup pattern used by
vhost-scsi.

Fixes: b430a2bd23 ("vdpa: add vdpa-dev support")
Co-developed-by: Miao Kezhan <miaokezhan@baidu.com>
Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260622100145.18924-1-lizhaoxin04@baidu.com>
---
 hw/virtio/vdpa-dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 94188d37bb..089a77f4d0 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -172,6 +172,7 @@ static void vhost_vdpa_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+    struct vhost_virtqueue *vqs = s->dev.vqs;
     int i;
 
     virtio_set_status(vdev, 0);
@@ -183,8 +184,8 @@ static void vhost_vdpa_device_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 
     g_free(s->config);
-    g_free(s->dev.vqs);
     vhost_dev_cleanup(&s->dev);
+    g_free(vqs);
     g_free(s->vdpa.shared);
     qemu_close(s->vhostfd);
     s->vhostfd = -1;
-- 
MST


