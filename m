Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEE4C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7s9-0006Oh-QZ; Wed, 15 Jan 2025 13:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7r9-0000x9-4K
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7r7-00078O-4l
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1Q6ecuMvkKdBN1XJ6lghkDja+Y8Z2DVDPha29KkwYw=;
 b=V7XUigFwNJb1voOUQ1XlNTPD/7M8WOxDQDFITYEtIFS+0h6ka9vFS1SrI++QTNxm3dfIAB
 Pnj22CCzqmjYXK1VZt+3vjcdgKhM0JxvjBskJknopPJ5ig0VPCUdotxaA7yAxKPRoHmXX7
 a31rxYNC6IX53oM34/jgQ5xHecrxrFA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Qzu4RRtUOWSo7jaRzdPUew-1; Wed, 15 Jan 2025 13:11:03 -0500
X-MC-Unique: Qzu4RRtUOWSo7jaRzdPUew-1
X-Mimecast-MFC-AGG-ID: Qzu4RRtUOWSo7jaRzdPUew
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so52986f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964661; x=1737569461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1Q6ecuMvkKdBN1XJ6lghkDja+Y8Z2DVDPha29KkwYw=;
 b=jEph52BVeCjYespOhF0aBi2H+OYt1b4xqiOYky+BBA4FtDCVwVZbSSDF7EWpVL/YiG
 C0MkbvbUJlh31nJA2Nk6UvX5kWUUjq8l3uw9jr18twoW6OQBa9oBXgaygBeOARHWjiTR
 r+ev/B4jkTKqvEBoIGbSw3CpANDrEZNPI8h+QtYsYUxmyMNU4wpp0EYUt+tXLqzT5kV4
 s32rFH3UdmkF4+F3ISaJsfeZ/SRHG7xQH/vvgynKmhZzfLzvAxe8lnxqRz+JegVesDTJ
 qKRmZNYdT2qwxbcS2nmZ6vaGFyhlmNgHZ34xoK0yxrCSTTnQnuse1FK1fIhdPz4VOouJ
 40tQ==
X-Gm-Message-State: AOJu0Yy29rwKN+p3XbqyhU1nAaKJ6/br7tLnomRz76qCbez313LthYWd
 DajHUOwnQkLP/hBRtlrRZRfDhNhRg5Y97/fZPi3aiv1gLX7Y5Onl13nctOb0rBTehISOnIgXgba
 oxKa5MyngAPTriq9uxu5XXOvld5AP2bpj3Fe/Qiz/cppqqOT2lZLdWQEeebXGVlQI1chu5ACyu7
 /GljKok5sRSKoKbgnV3imDr1q+ORgNZg==
X-Gm-Gg: ASbGncuuDxZynMKda9I8m5tBecbtxrqlKYJ35nJsO/Z52NPd50HU/Fx+IqMDh9EFAHW
 AKzDZR1j69WoF6RRlesu+9cyOD66LvkfVVIg2wC93GcyR6/n6/dmOxjy08uiP7o8Zvt7+NPClMf
 djXz1fKxc2HAa7pvWkbj9fZoWuXFGB+QWralrjzO3RT/HtQXuNcFpo4QJcIAt7ZfrD5R9vakMDl
 bdzi+KPmI7+Xt7wRaBXSLJ+OznKuFoszomf7vZse3DVf8bgc5ef
X-Received: by 2002:a5d:598d:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38a8733a3ecmr25541576f8f.55.1736964661560; 
 Wed, 15 Jan 2025 10:11:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUKM3Qq74VPjvClTWSW0xtGkd/Kupo29cYE32UuFQwfVMQdyPwk8ZEp2D+CUizXZ1xzzR3VA==
X-Received: by 2002:a5d:598d:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38a8733a3ecmr25541540f8f.55.1736964661098; 
 Wed, 15 Jan 2025 10:11:01 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c75290a2sm32182865e9.29.2025.01.15.10.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:11:00 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 47/48] vhost: Add stubs for the migration state transfer
 interface
Message-ID: <3f65357313e0f928e0bd3ff868b705855d0405bc.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

From: Laurent Vivier <lvivier@redhat.com>

Migration state transfer interface is only used by vhost-user-fs,
so the interface needs to be defined only when vhost is built.

But I need to use this interface with virtio-net and vhost is not always
enabled, and to avoid undefined reference error during build, define stub
functions for vhost_supports_device_state(), vhost_save_backend_state() and
vhost_load_backend_state().

Cc: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20250115135044.799698-2-lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 461c168c37..a9469d50bc 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -365,7 +365,14 @@ static inline int vhost_reset_device(struct vhost_dev *hdev)
  * Returns true if the device supports these commands, and false if it
  * does not.
  */
+#ifdef CONFIG_VHOST
 bool vhost_supports_device_state(struct vhost_dev *dev);
+#else
+static inline bool vhost_supports_device_state(struct vhost_dev *dev)
+{
+    return false;
+}
+#endif
 
 /**
  * vhost_set_device_state_fd(): Begin transfer of internal state from/to
@@ -448,7 +455,15 @@ int vhost_check_device_state(struct vhost_dev *dev, Error **errp);
  *
  * Returns 0 on success, and -errno otherwise.
  */
+#ifdef CONFIG_VHOST
 int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
+#else
+static inline int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f,
+                                           Error **errp)
+{
+    return -ENOSYS;
+}
+#endif
 
 /**
  * vhost_load_backend_state(): High-level function to load a vhost
@@ -465,6 +480,14 @@ int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
  *
  * Returns 0 on success, and -errno otherwise.
  */
+#ifdef CONFIG_VHOST
 int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
+#else
+static inline int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f,
+                                           Error **errp)
+{
+    return -ENOSYS;
+}
+#endif
 
 #endif
-- 
MST


