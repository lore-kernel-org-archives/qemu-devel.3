Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DEBCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru63t-0003x1-Ae; Tue, 09 Apr 2024 03:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru63r-0003wt-Lg
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru63p-0002lX-Rm
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712648309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+PBU8FJD1KavZSixahSE19h37gczE5W26EChIaJ/bY=;
 b=GONpPoDufyyy5/f5fJv7AqRdcyVRHB1xwL7WrSQyT4xlFG3mh3fvdCD+qF9qfHcfxKeCy5
 +iAYjNaYAPR5VbZJMh1dc/+nutfYjdDIwrvYpannOYnls+QR5R6ExdyYMRo4MKEhRC17Wy
 wbGHh3Y/DpxE+jT3Phx24JBoJKjORMw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-t1n1LgohMe-RJMPW63uR2A-1; Tue, 09 Apr 2024 03:38:27 -0400
X-MC-Unique: t1n1LgohMe-RJMPW63uR2A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d85b4ca694so41433381fa.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712648305; x=1713253105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+PBU8FJD1KavZSixahSE19h37gczE5W26EChIaJ/bY=;
 b=oobGv/IkPS/jtaA6xKnIR50XiWrZ24cJ9Dh1gaEuMpuiukt5vera3abnCc7hmr+gnL
 Bcyyw04O+Zg694ihL2EsCJzqc+21blBWNtrqG8ydNWMnPwcrRXtAtxRstmBvpIiLwQbl
 MocfbI5p78rOTN3ee78akYAGX3uDR7dterFKa/HQ3WjeFwBFaCBMfmUMs9am+cxLFWD6
 hmkxAr6x0usxRBNrMVLqGhFskMyhUnYHwsY31zLBR+ZFHIVgT4wnKyLIhF++C/1xXFV4
 iHeXN3llK6V/Mhq2E1ig3853kwgBbDRi3dhjgBaZoiBWbm+IUGRkZQ8PZY4N/ymtueXd
 Cvbw==
X-Gm-Message-State: AOJu0Yzs6ofBYF4JrPHMXHr9HuBIYUAC4P4jlQG56D5LWbsp/CSbrk7D
 L5+SjOJxLrladZxN6q4m+JpHYPTowqGqUnJXEJUxGxvyYWDX8x4Szw1CSQiJYAHt63lYPnFmh0p
 zxISoALPOsORspFFGxtB4U+0MlohpHgGRuwlY6xSk7ToIgUXqwQCHKST++3kRBUf6l3PvXykx9Y
 kQYuYIQ0IL1P4Mezh7LeaaVtK6PHRHAg==
X-Received: by 2002:a2e:a306:0:b0:2d8:52b2:2002 with SMTP id
 l6-20020a2ea306000000b002d852b22002mr8073647lje.47.1712648304680; 
 Tue, 09 Apr 2024 00:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXXDfbE4JnVQpsEyVRsjA0X7rBrJmVg7ldtlU+/qygahVV9t0aHOX2zG+KcXx3AHcsGXayhA==
X-Received: by 2002:a17:906:235b:b0:a46:6fe4:af27 with SMTP id
 m27-20020a170906235b00b00a466fe4af27mr7504136eja.24.1712647952949; 
 Tue, 09 Apr 2024 00:32:32 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 xb8-20020a170907070800b00a4e07760215sm5328761ejb.69.2024.04.09.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 00:32:32 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:32:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 6/7] vhost-user-blk: simplify and fix
 vhost_user_blk_handle_config_change
Message-ID: <f67d296b6ea0e946e4ca13a39c699ca13bd977b6.1712647890.git.mst@redhat.com>
References: <cover.1712647890.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712647890.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Let's not care about what was changed and update the whole config,
reasons:

1. config->geometry should be updated together with capacity, so we fix
   a bug.

2. Vhost-user protocol doesn't say anything about config change
   limitation. Silent ignore of changes doesn't seem to be correct.

3. vhost-user-vsock reads the whole config

4. on realize we don't do any checks on retrieved config, so no reason
   to care here

Comment "valid for resize only" exists since introduction the whole
hw/block/vhost-user-blk.c in commit
   00343e4b54ba0685e9ebe928ec5713b0cf7f1d1c
    "vhost-user-blk: introduce a new vhost-user-blk host device",
seems it was just an extra limitation.

Also, let's notify guest unconditionally:

1. So does vhost-user-vsock

2. We are going to reuse the functionality in new cases when we do want
   to notify the guest unconditionally. So, no reason to create extra
   branches in the logic.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20240329183758.3360733-2-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 6a856ad51a..9e6bbc6950 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -91,7 +91,6 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
 static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
 {
     int ret;
-    struct virtio_blk_config blkcfg;
     VirtIODevice *vdev = dev->vdev;
     VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
     Error *local_err = NULL;
@@ -100,19 +99,15 @@ static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
         return 0;
     }
 
-    ret = vhost_dev_get_config(dev, (uint8_t *)&blkcfg,
+    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
                                vdev->config_len, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
     }
 
-    /* valid for resize only */
-    if (blkcfg.capacity != s->blkcfg.capacity) {
-        s->blkcfg.capacity = blkcfg.capacity;
-        memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
-        virtio_notify_config(dev->vdev);
-    }
+    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
+    virtio_notify_config(dev->vdev);
 
     return 0;
 }
-- 
MST


