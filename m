Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93930C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDCo-0008IA-UG; Wed, 14 Feb 2024 06:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCm-0008Hy-60
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCi-0006gy-8g
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVJ2xCGDmS5//nzvgjYPTRhJxVogUUB55jW/DQR2itg=;
 b=eCjy6GWjb5jsOrkQvVy6iyplyw5OG6m463Gkb4ei2hEuBO+yM9QBpNc10l9lwZnKn8nhLC
 +D9yXk63vocD9AEfzY1UOE9KwRfd+KMIODXyA3HW/TamZeaqj0x9T++ce+MIc6e5xcnVkj
 sVLYAaVm9H/zoV5FJM2FP+UdG2K31fI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-F6d-m2mXPTCLQd8Mmrgs7A-1; Wed, 14 Feb 2024 06:13:24 -0500
X-MC-Unique: F6d-m2mXPTCLQd8Mmrgs7A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2f71c83b7eso154150766b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909202; x=1708514002;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YVJ2xCGDmS5//nzvgjYPTRhJxVogUUB55jW/DQR2itg=;
 b=NzdtSqxgjzvFFPSO6u3X7xMtTyTDYliD6KnEouLnlzyMfSLNQuseLpFqMT6Bdm8XqL
 EYzJxKmYoVRTkZUmGomVrXADMmCFK47IjNVS7iVHfGzXaeYshhuDp+QaoyQYxuAl5s3p
 ptX8pAXr73V7NnFsNtLRFkSjTri7CVGhumMY/ZJOFBUrqx6RO4asr+Rcd3ltJr887pYg
 bma3UA6hJjNc5SzIFuQvqvI0uzB0lDscRX0ZZRqS5Da3OAeDG9LFsngNPkheIFZDiTuE
 Dns8C8muDWhgF4l1/H4baPzKKUydZvvEB+mzeULcx0Pn9NQ4ARByzcKH5648XbkvLMAB
 EcFw==
X-Gm-Message-State: AOJu0YxpNJlv/5fGMzF3y3SVegpDlI+elwsYsRYyncYb15QK5evdHDhi
 3yHxXzF7q3Gu6/N9v3uESRdbN6cqX1n6v3nVxo2IFXX4jsTH7YEcRAbOkxPmKsz0DXV6etzytsn
 jSCGf4484WuImzy/99HOoz/vjWMF884g+A8FTIrscBIIXbj5HB3aOqS/xczrm3yWR8TZpQ1MzpR
 VeRxBxZpPAId0in9Ihktb0qcKvwAbX6w==
X-Received: by 2002:a17:906:134c:b0:a3c:cd77:87f9 with SMTP id
 x12-20020a170906134c00b00a3ccd7787f9mr1630862ejb.58.1707909202628; 
 Wed, 14 Feb 2024 03:13:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/IvSL0WABmOl0nXkIHWAqBTJNqOkoVMQvo1899o7iw2e2j4vP7/Af7A3d+KiojeqEzcyZmg==
X-Received: by 2002:a17:906:134c:b0:a3c:cd77:87f9 with SMTP id
 x12-20020a170906134c00b00a3ccd7787f9mr1630853ejb.58.1707909202323; 
 Wed, 14 Feb 2024 03:13:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXRv6+nEZO1qiCqKKYqkkipb+MpIyOHp5HSDxMz2Wy1XloRTD3il9kxiv33PpN7+BDa3zCqIfT/VsBf6UmrYMvGMzjL9iLc
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 tb20-20020a1709078b9400b00a3cf436af4fsm1741603ejc.3.2024.02.14.03.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:21 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/60] hw/virtio: convert vhost-user-base to async shutdown
Message-ID: <64a312a2737e3aab97f103b76f8e76a97770e670.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Alex Bennée <alex.bennee@linaro.org>

We are about to convert at least one stubs which was using the async
teardown so lets use it for all the cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240104210945.1223134-3-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-base.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 620fa5cb4a..78cfa9a5bb 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -201,6 +201,8 @@ static int vub_connect(DeviceState *dev)
     return 0;
 }
 
+static void vub_event(void *opaque, QEMUChrEvent event);
+
 static void vub_disconnect(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -211,9 +213,13 @@ static void vub_disconnect(DeviceState *dev)
     }
     vub->connected = false;
 
-    if (vhost_dev_is_started(&vub->vhost_dev)) {
-        vub_stop(vdev);
-    }
+    vub_stop(vdev);
+    vhost_dev_cleanup(&vub->vhost_dev);
+
+    /* Re-instate the event handler for new connections */
+    qemu_chr_fe_set_handlers(&vub->chardev,
+                             NULL, NULL, vub_event,
+                             NULL, dev, NULL, true);
 }
 
 static void vub_event(void *opaque, QEMUChrEvent event)
@@ -230,7 +236,9 @@ static void vub_event(void *opaque, QEMUChrEvent event)
         }
         break;
     case CHR_EVENT_CLOSED:
-        vub_disconnect(dev);
+        /* defer close until later to avoid circular close */
+        vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
+                               vub_disconnect, vub_event);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
-- 
MST


