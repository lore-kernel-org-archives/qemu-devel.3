Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB3FC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5P-00028U-HE; Fri, 21 Feb 2025 07:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5F-0001F2-4W
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5C-0007EU-Bj
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+Y5g8wbgtarePqnIrjsvz5QinXPsEQErGBVpb/bDhs=;
 b=DaBHADIoPOLrGSjn5LmbojwpDnaw6sGtjRb6iH1edK0war9917uoImgYphiQFtwMBFg2U5
 /7IY1WDKt0uzm1aa8p1oQVoNLw98joieGP3EoUVm75V5AnbcTK0oC5itVcChlBQhPFw4rz
 mQwnj85FvOsM7m+gdfRqe3sz4Gy9GJg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-I-tzmKEfOlK_MT18FABBQQ-1; Fri, 21 Feb 2025 07:24:40 -0500
X-MC-Unique: I-tzmKEfOlK_MT18FABBQQ-1
X-Mimecast-MFC-AGG-ID: I-tzmKEfOlK_MT18FABBQQ_1740140679
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4399d2a1331so10852675e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140679; x=1740745479;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+Y5g8wbgtarePqnIrjsvz5QinXPsEQErGBVpb/bDhs=;
 b=Q8IWcMzrk1OXKcXQSB67SFNdstZlFvjGYf7xjrB2jiJHlVaZ7Y90g/Ghocdo36x4Vd
 74ZQvB9hNZYs9MJKp4HIbvK/rd8dSbHnqkE0O5lxeFAXIEzd+mY2us9jwqsFyfa31dVw
 LAfcYEyRIyKZKW0PMg9dlChvjhkswCQJdmcrxbORPcs7aRLbMtSbrzsAzStWbC5yY1K2
 0osVsSyGmMbica1XxHszol71t3clfJPnSoAu6gJxuMC4tRnCeqL4QSyLU1B5vwNssk31
 LnNFlKmUlvtninzmJ/MIobORMLs5OmZ6T/8vjJDIU9BjgEK0ptDv2E0vWThDaNTtAO3n
 CWcg==
X-Gm-Message-State: AOJu0Yy3YUK6zZOF/VO1Rp7uQi4Lq7bNUUY9kLlYJAyxHWLOU0Nk2K0p
 JlwHFAmQRy8S23hnT3JGQFqlD0Vm9yshn4GXe3pfu3XxWiwbtpDi82MZK9PUuUYn6tAgzNvCk9K
 xCo7qYfcS/CEYo6xQu9juy1Rw1BmbjMxPWhuWltsXTab7XGaa8D0RlEpOUM0OuvBF4Wh0BYnRKo
 dUWreYaXGjtw3Esp/hBPHWhR4Z2df2Eg==
X-Gm-Gg: ASbGnctmpgl/C9ZFvbFwx4djGFVY+hMibFfvridBJ42qshT77FOhjQ7YsEju7TaB5bB
 PPO7fqDzUOZ2brp9nbWW5j3+WSfe9gm6eFLbUTQEg/V+MXnB/H6OeZ51lPtiUC3JOI05AZNZVAC
 zUbET6rP6MQ3JithQA1kyDZ4mdG2qoZTe8Ew84hl+k68D+XE7B1OQp5MYFiUGgg2GQeYwGN8Mvc
 PA3lFFlYn1OUqbckbkzaeEn2TfOToXPV/tUc/hfWCr5NVkc3OtVpHo2y1FFNwUoInYDFcFPkHgC
 t0jcKA==
X-Received: by 2002:a05:600c:6b66:b0:439:96a4:d2a8 with SMTP id
 5b1f17b1804b1-439a2fb2c41mr56334785e9.5.1740140678858; 
 Fri, 21 Feb 2025 04:24:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBIYq7g/aIhnFqWv6GdVkr3BQpXbN/J9tjIC8IdZtcPFONd6G8oGq4LP5nOL6C9aWpvPQl+A==
X-Received: by 2002:a05:600c:6b66:b0:439:96a4:d2a8 with SMTP id
 5b1f17b1804b1-439a2fb2c41mr56334425e9.5.1740140678405; 
 Fri, 21 Feb 2025 04:24:38 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b6f8b1fesm1528215e9.32.2025.02.21.04.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:37 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Dorinda Bassey <dbassey@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 36/41] vhost-user-snd: correct the calculation of config_size
Message-ID: <e87b6efb11be9f5ff213461f5ecdbae47d9402b9.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>

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
Message-Id: <20250217131255.829892-1-mvaralar@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Dorinda Bassey <dbassey@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


