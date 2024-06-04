Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F334C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUP-0005oz-Gl; Tue, 04 Jun 2024 15:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUK-0005j7-UR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUJ-0000jz-C4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=hE6FYKzDC667y/6z06qVEU4c2Lc4Xmn5Cczhjdz6cdWzgyKWLrik37jnZndMidQHPsaTeM
 pZaCYgG7QCcO7uRnDUIA18Qtt/1I0Rt5WbUQnDqhuV6MgFrscoB8NqzI/qxTlJUQE3Lyru
 LoFJ0qS3nsT4LOXO/NxLTT6Hx0G2oQ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-umM9Qt1dMomw87cg1k3CTA-1; Tue, 04 Jun 2024 15:06:23 -0400
X-MC-Unique: umM9Qt1dMomw87cg1k3CTA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42135f6012fso26193965e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527982; x=1718132782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czI6QAqPz2gxBOi54M6w2CiDVJgkcwfGVW3OGis4Be4=;
 b=WpnhbJOvEyq3MB35dUSz+0e0qejBjQE8NPPzCODhqdQeB+hPTYxIrR05VuQi5RD4qQ
 EYhSprtvIU3Vo3RmgiNnzLrcyxSw8v0pqjmzyE1lVUrRoHuCbkNwiF8l8pi/Ocsec/P4
 81UFvLa0wVr0OtieoMEYkz2rRxDXRYN6yCMm2fpT35oonOyrKmzW1qApP6UVWH4cATAC
 Iw0eEOj6hcg4ck6d0TOjBrOPpqVn0vTRIq2fONKpc7QjgZDKt3uwutVj6qwWiWG3gZoB
 ZXbRY904csxIVYF3F5XSNFY746wWd8rMpw5nQBGH9CWKPYaOEZYP94jNtWFAI1tPOqW4
 wWlA==
X-Gm-Message-State: AOJu0YyI2YQ9YbSp5aa4nTvbuPFceRLEnexe8CuqovyefY9Tp2de0AMn
 8ueJuhMLdSnCOZGaYk4hzPOQ3Or5kqDVbNm9iNh22xGSVPsnszBtGETYkFRU9y10LVwrK0UU2Sk
 GHY/9tLF4xBiH0QoC9MP0tMbKFWCX/6mfAP6/b094VExR+Q9hCbtcmlJwATmYOp9xjIPioskyoR
 A6zWU591Y9ayLl59CUsFBuNKW/hNITjw==
X-Received: by 2002:a05:600c:4503:b0:421:1e47:f80a with SMTP id
 5b1f17b1804b1-4215635c0a1mr3063715e9.41.1717527981746; 
 Tue, 04 Jun 2024 12:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB886PrhILTURkp9QKh0LH8D3iJNhV0Pb0rydXzO/KNMcw+3s+1DZnhJHdghmNemRMjZo5Ng==
X-Received: by 2002:a05:600c:4503:b0:421:1e47:f80a with SMTP id
 5b1f17b1804b1-4215635c0a1mr3063525e9.41.1717527981187; 
 Tue, 04 Jun 2024 12:06:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213cd1c075sm87369035e9.0.2024.06.04.12.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:20 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: [PULL 06/46] virtio: Prevent creation of device using
 notification-data with ioeventfd
Message-ID: <1c854365ece00579e5bfe19c1ce04e80a76f4a0b.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Prevent the realization of a virtio device that attempts to use the
VIRTIO_F_NOTIFICATION_DATA transport feature without disabling
ioeventfd.

Due to ioeventfd not being able to carry the extra data associated with
this feature, having both enabled is a functional mismatch and therefore
Qemu should not continue the device's realization process.

Although the device does not yet know if the feature will be
successfully negotiated, many devices using this feature wont actually
work without this extra data and would fail FEATURES_OK anyway.

If ioeventfd is able to work with the extra notification data in the
future, this compatibility check can be removed.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-3-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f7c99e3a96..28cd406e16 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2980,6 +2980,20 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     return ret;
 }
 
+static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
+                                                           Error **errp)
+{
+    VirtioBusState *bus = VIRTIO_BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(bus);
+    DeviceState *proxy = DEVICE(BUS(bus)->parent);
+
+    if (virtio_host_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA) &&
+        k->ioeventfd_enabled(proxy)) {
+        error_setg(errp,
+                   "notification_data=on without ioeventfd=off is not supported");
+    }
+}
+
 size_t virtio_get_config_size(const VirtIOConfigSizeParams *params,
                               uint64_t host_features)
 {
@@ -3740,6 +3754,14 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* Devices should not use both ioeventfd and notification data feature */
+    virtio_device_check_notification_compatibility(vdev, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        vdc->unrealize(dev);
+        return;
+    }
+
     virtio_bus_device_plugged(vdev, &err);
     if (err != NULL) {
         error_propagate(errp, err);
-- 
MST


