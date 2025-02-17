Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F9FC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0vs-00062k-S4; Mon, 17 Feb 2025 08:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tk0vp-000623-7P
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:13:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tk0vn-00062C-2a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739797980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DlqQ3uBHgTWfPPrHtLWbuiQ4oCE7jE+CS/eG0yKen/M=;
 b=E0BtbtzJ51MihBgmvwxbcpi4z8/c/dXoy7tykxmWk4bTlrt0ZXvKLwjSpkyJ98tUEE7fFd
 JnzzLPgchNxQA3UHhpfD2FFiq8tX+2mo8YpC35/LdjNv31FUyEoN60b3VN0Wah8QioVRwj
 PE3u26YTNje7NoOIogkrLr6QA5Y/hvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-11ykxxSmPLCiOvlwazp6fA-1; Mon, 17 Feb 2025 08:12:58 -0500
X-MC-Unique: 11ykxxSmPLCiOvlwazp6fA-1
X-Mimecast-MFC-AGG-ID: 11ykxxSmPLCiOvlwazp6fA_1739797978
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43935bcec0aso35161235e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797977; x=1740402777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlqQ3uBHgTWfPPrHtLWbuiQ4oCE7jE+CS/eG0yKen/M=;
 b=u8ESJAJTBzbfXGMk4MOHu07MVrTdkbsDaSr5r0LSrZtIRt5P271D7aWEmO95+HXCSJ
 +jLuSlAUwQ48TOlJL/m0orfEMuG0WTVO02/OundIwY7gXxvoFcKIpixSWMFxvhG2+AWw
 r1VlF3guGFTHUqdpefEqbWWVWNGm5e/IgiJ+TmIxS8AENytmKU8ARbI0QGYwsBaV4Yd4
 VZC+l1RBlGEhkqyI7W00Nk9IexYG63L2M5P2YYj0bzCKP85Ff3y6w/pVLNWQIabwYUJE
 czN78UsFOh70/i70Bh4Y30zRu76L8DiAZMMT6LTX1f3Yhj8nVhDAQPzRYTpF1UXO360a
 gn4w==
X-Gm-Message-State: AOJu0YyNrKpleG45X6zjUizeXLL0Li+2LHWxjjly1mLpBz9bT3UinvOH
 Hd57ORLUgxY1+jdmB7eGI8Fh6bBf7V6aLvoMhC4OUYr3WNzVvze/HH/BmmhDGE8V6FdEwGMkp3b
 PxpSAEIQX/JxXkVIRbL4UkXkNRiWDN/PexBOayZTI3WOmaCuo08wICZLCY2Iqtrc65pwPl9aOIR
 UNKYV1wEKoU41XtKg35Hzz0XA1KwCuCMbfdiqa
X-Gm-Gg: ASbGncuzFgMB11yfIapXL8e5SoflSwLA6XQ+8aVZEIwXDiP+XrOQWAcP4kFovq0Uadr
 GO3TyT55h32Zjjguqtkoje2eMvUiTHbLTYgMgTC6kUpa9PS3EV8kUNlqIW+q1Jy2XJ2YUoZ5F5y
 KuaESQllkohlaGCe9N0y2iJwc5e1O01Rl4TLYWCSZS1c1Rcky0SIgdhGw+9tGah4Q9HJTtpE0K7
 X6MgIRnIPg3QD1Stc3ywI862MaXejk6qKjUiy3ilSfVNzENyy7hUkqOinXma7TtgVY2iu8JHZZh
 kzjgpkzr
X-Received: by 2002:a5d:5f4a:0:b0:38f:4244:68cb with SMTP id
 ffacd0b85a97d-38f42446bfbmr3931378f8f.12.1739797976818; 
 Mon, 17 Feb 2025 05:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP8+aGi0L6I+IR6Yutrd+OtI/EySe+9HZGMNtU34qhBiVC/oWP4OBchWXWZhRI6vT0O+zOgw==
X-Received: by 2002:a5d:5f4a:0:b0:38f:4244:68cb with SMTP id
 ffacd0b85a97d-38f42446bfbmr3931328f8f.12.1739797976379; 
 Mon, 17 Feb 2025 05:12:56 -0800 (PST)
Received: from localhost ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44b2sm12070898f8f.20.2025.02.17.05.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 05:12:56 -0800 (PST)
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] vhost-user-snd: correct the calculation of config_size
Date: Mon, 17 Feb 2025 14:12:55 +0100
Message-ID: <20250217131255.829892-1-mvaralar@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use virtio_get_config_size() rather than sizeof(struct
virtio_snd_config) for the config_size in the vhost-user-snd frontend.
The frontend shall rely on device features for the size of the device
configuration space. The presence of `controls` in the config space
depends on VIRTIO_SND_F_CTLS according to the specification (v1.3):
`
5.14.4 Device Configuration Layout
...

controls
(driver-read-only) indicates a total number of all available control
elements if VIRTIO_SND_F_CTLS has been negotiated.
`
This fixes an issue introduced by commit ab0c7fb2 ("linux-headers:
update to current kvm/next") in which the optional field `controls` is
added to the virtio_snd_config structure. This breaks vhost-user-device
backends that do not implement the `controls` field.

Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
---
Changes in v2: 
 - Addressed comments from Stefano Garzarella about commit msg and the
   property name. 
---
 hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
index 8610370af8..b414c75c06 100644
--- a/hw/virtio/vhost-user-snd.c
+++ b/hw/virtio/vhost-user-snd.c
@@ -16,6 +16,18 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_snd.h"
 
+static const VirtIOFeature feature_sizes[] = {
+    {.flags = 1ULL << VIRTIO_SND_F_CTLS,
+    .end = endof(struct virtio_snd_config, controls)},
+    {}
+};
+
+static const VirtIOConfigSizeParams cfg_size_params = {
+    .min_size = endof(struct virtio_snd_config, chmaps),
+    .max_size = sizeof(struct virtio_snd_config),
+    .feature_sizes = feature_sizes
+};
+
 static const VMStateDescription vu_snd_vmstate = {
     .name = "vhost-user-snd",
     .unmigratable = 1,
@@ -23,16 +35,20 @@ static const VMStateDescription vu_snd_vmstate = {
 
 static const Property vsnd_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_BIT64("controls", VHostUserBase,
+                      parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
 };
 
 static void vu_snd_base_realize(DeviceState *dev, Error **errp)
 {
     VHostUserBase *vub = VHOST_USER_BASE(dev);
     VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+    VirtIODevice *vdev = &vub->parent_obj;
 
     vub->virtio_id = VIRTIO_ID_SOUND;
     vub->num_vqs = 4;
-    vub->config_size = sizeof(struct virtio_snd_config);
+    vub->config_size = virtio_get_config_size(&cfg_size_params,
+                                              vdev->host_features);
     vub->vq_size = 64;
 
     vubs->parent_realize(dev, errp);
-- 
2.42.0


