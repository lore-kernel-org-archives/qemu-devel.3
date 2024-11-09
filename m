Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192F4D5C0C7
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 05:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9dZl-0006Nj-Ey; Fri, 08 Nov 2024 23:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9dZj-0006NB-It
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 23:59:55 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t9dZh-0000fL-W8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 23:59:55 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so2489947b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 20:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1731128392; x=1731733192;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pe8SBHoLAZphIXqOGJa/qUqOysZpgdOltfKYUVIh7vA=;
 b=mi4rh9b1A0EaYEidZw+/gVjtd8bCYvvBLngH1Z0ton6mUTDGKqreUqy2NFGI/NPpzd
 mausE8xtDvLS7I6pJe4afXS72Yz3cF4guia5CCmeolcZWOueY/mZM4MXFCvzJfVeFDa+
 cyoenFbaBrtTAYcK+ST6T/ecrWgmg1ImcrKQOKfsePXhf68QQGA5e4Firh6DNGTmkWV0
 h+ww4gTWXdzouJPgiJkUcad/fxcvUYWYwwB9LaUh4Gp0XHN1Mfr92wyTa23F5ODa+uIR
 RMN4Ax3mXQyvDWP0HY5x4nMpgNsm4/SaOh4WnkzJeT2zWibM34Mzc3DtqFqoCZkGatZS
 f8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731128392; x=1731733192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pe8SBHoLAZphIXqOGJa/qUqOysZpgdOltfKYUVIh7vA=;
 b=F6zPqeG0ypk9YHq6HzZV+ZcUZiZ2bmlm3ErRdAVj+ZHqfMINrs/GBmGFFXI6XJK6U0
 q+mG3FG1lbfoD2h+vcJEZ2QRtliFk9DW/AccV9lMAABYBUzHGYv0Y51uL9suPK0EaLoB
 uarrOW8nIvJv4nlCFHleFvOCQxKiP25fFiOYxklkJOSGACjqEBtuFcYjxPQ60lDjec/d
 ssTgIFPOGPpKIFD2qlaqtwIwNpUDac5BoZpTKFZAUv2734zrVHBYET6HkS+cLoLw5+C2
 13vRHKRrq69wuFPAwjjGWoreG3QcmscpSdeV7jiXUNFoV7yPqIdngDG3IpiVyd76h5rX
 qOCA==
X-Gm-Message-State: AOJu0YwpQj6xVqloSImSRoRmv76KLBpRolOi5dgorRb+jGGZNBzXbB5o
 oRWi0z+hTERe1TKI/QnZhFkDP5qn2NTqPNRXgkW5ySk6ks6vg86AJIcfugFSKTPSBHk1i6OCoIw
 kiOhoUg==
X-Google-Smtp-Source: AGHT+IH/ANoqO6TccTq1Rf0TFJt6/rfvYZpMFW6aa9hhhY1MLru+b8FZD280aWa38aayNYJz6tENzQ==
X-Received: by 2002:a05:6a00:3c95:b0:71d:f15e:d023 with SMTP id
 d2e1a72fcca58-724132c7aeemr7007968b3a.11.1731128391786; 
 Fri, 08 Nov 2024 20:59:51 -0800 (PST)
Received: from localhost.localdomain ([118.114.63.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9ac8sm4718365b3a.79.2024.11.08.20.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 20:59:51 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Wei Wang <wei.w.wang@intel.com>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v1 1/2] virtio-balloon: Enable free page hinting during
 PRECOPY_NOTIFY_SETUP
Date: Sat,  9 Nov 2024 12:59:41 +0800
Message-Id: <c799b1f96e55c5eb9c07e5a70a51b8ba67e7bcc9.1731128180.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1731128180.git.yong.huang@smartx.com>
References: <cover.1731128180.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PRECOPY_NOTIFY_AFTER_BITMAP_SYNC was interpreted by free page hinting
optimization as an indication to begin freeing pages. But there's no
assurance that a sync is required when beginning a migration. Therefore,
during PRECOPY_NOTIFY_SETUP, as well as PRECOPY_NOTIFY_AFTER_BITMAP_SYNC,
enable free page hinting.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/virtio/virtio-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 609e39a821..2f1e086cd8 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -663,6 +663,7 @@ virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data,
     case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
         virtio_balloon_free_page_stop(dev);
         break;
+    case PRECOPY_NOTIFY_SETUP:
     case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
         if (vdev->vm_running) {
             virtio_balloon_free_page_start(dev);
@@ -679,7 +680,6 @@ virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data,
          */
         virtio_balloon_free_page_done(dev);
         break;
-    case PRECOPY_NOTIFY_SETUP:
     case PRECOPY_NOTIFY_COMPLETE:
         break;
     default:
-- 
2.39.1


