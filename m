Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEEDC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCO-0007wM-Ug; Tue, 02 Jul 2024 10:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCG-0006ke-Dw
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeC1-0008JS-Ib
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6iaejVuyK6cotgddPWIYQA8dIBm4KoXB6zsOD2vQwU=;
 b=J+S7SgmtQJWd4qMHFANjrby1/ALwbuShzvktBStCBoW/I76WtJ6GzBtxylvZv/wJb1nHiO
 J1LlY93Vfeecx54YrgmrrmFgDEkAcDVMRTgy6eK++1tW/bNGdogGWxQeamwhdFRUHGEc08
 IlzUvnT+LfxsuW5Hh9jm0CWlVnF6sR0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-R-0IazY5MgKuPUr-5o8noA-1; Tue, 02 Jul 2024 10:09:11 -0400
X-MC-Unique: R-0IazY5MgKuPUr-5o8noA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-425897358f0so6717715e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929350; x=1720534150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6iaejVuyK6cotgddPWIYQA8dIBm4KoXB6zsOD2vQwU=;
 b=m2reEi/bB47PRfjlZbM/XwLuvLLNiPH8cbS8eqdpuCiO3OSTYjRkBqGnpgjK5SG4HY
 sGIQ4tualRZXXAqkNkiA+eJcf38Xfbi+fliiHNSzuqZYk9weLUaRYBa/iDkBXObVxAqP
 wp+8QRFTdzcb7Qym68J736QkHJKJuz5jRISP+bA9TjkdOMLQiJak2l+NQKG7FpKh7V93
 htCI64Pa1OOB+2MsqANS34EO899D6n1Bq2Rt6NS/RFK/QhghQ/C2/XOFyUZ7TGlf/m8C
 pr3yHAtUf6lgXTgA33y+90xm6AJkXMGGx3SwSTrydviIz3Jtc/J1eL3ua6/t5rFdYbwD
 FS0g==
X-Gm-Message-State: AOJu0YymPGLe9b8mneGJ9yRDN7XPYS60tpyUuZckyY+c2osEh4MO5617
 t+Wd/O9K6cGStvjcflPbxrApRdMNS0SwbViM4Kv8SmqIkLZsKR+p1KTv2LYo6kJ0zs8rtBs4Db5
 L/OhBkEQrVaizBsawI7c1yaD8wJ4zklS90IuNVU2fmt9H3CB1AVjBCV8rRE2G/GfrlCyHe9ylyo
 agrFuQ/YsqoUnXbOhvpDsYV09dznUEAw==
X-Received: by 2002:adf:ea84:0:b0:356:48f5:4383 with SMTP id
 ffacd0b85a97d-3677572979bmr5367434f8f.61.1719929350138; 
 Tue, 02 Jul 2024 07:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpzMafSGeFZz/jd4b6+Erq9rMCn23IsDQ8j+ILYv5DxSJc8Ds1N2V1VBKsaRZbIz64oLf3Bg==
X-Received: by 2002:adf:ea84:0:b0:356:48f5:4383 with SMTP id
 ffacd0b85a97d-3677572979bmr5367410f8f.61.1719929349536; 
 Tue, 02 Jul 2024 07:09:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367892a4817sm1766231f8f.10.2024.07.02.07.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 42/91] hw/virtio: Free vqs after vhost_dev_cleanup()
Message-ID: <577682151b14ae79560eb709ba06f1bbb7c4a414.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-san-v2-7-750bb0946dbd@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 11e72b1e3b..2bc3423326 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -223,6 +223,7 @@ static void vub_disconnect(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
 
     if (!vub->connected) {
         goto done;
@@ -231,6 +232,7 @@ static void vub_disconnect(DeviceState *dev)
 
     vub_stop(vdev);
     vhost_dev_cleanup(&vub->vhost_dev);
+    g_free(vhost_vqs);
 
 done:
     /* Re-instate the event handler for new connections */
-- 
MST


