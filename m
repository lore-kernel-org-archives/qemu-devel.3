Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915BFC54E6E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZf-0004Yh-Am; Tue, 12 Mar 2024 18:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZa-0004Wk-Kv
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZX-0004F6-UJ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyYIKMrI3SRF/ysRxD0KwjA2vDDvjUVwVWXBG4PxT30=;
 b=SjFXPfEcL/QvRCW90UOzsGbJ9UkXsO68DQw5G7PAujz0+ZpzUYMphTFaOFThUnvZilo/gr
 QF2T+Rodtm/mS97veBO8Sc3JcqT0/ts+W8b/9aCB1Yh0Wb/39SZKatKkYL7uKiGdKiVHuq
 v8mRQt0s7nCzB/Cl4uWzJdq1CM7psPo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-PCvCupVZMhiV2L9ewoJ-5Q-1; Tue, 12 Mar 2024 18:26:09 -0400
X-MC-Unique: PCvCupVZMhiV2L9ewoJ-5Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56844c6a2cbso2298288a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282368; x=1710887168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyYIKMrI3SRF/ysRxD0KwjA2vDDvjUVwVWXBG4PxT30=;
 b=uo7ZWRoh9jSDUmFkKLRF+sCuHi3az57m8WmrmG/HCGQaJF0Rq19StMGyCjCiCvS/Zp
 PCbpbXW16gi5/SMC6I3ryyr9TIrS8ZuwMyS2PcQQevG9sOFFDEQ2s42YOhAXF0x6zcoD
 aJ2wbtrUK7V0PRXdjznk/SiTKx66UrsTkOG8AClFg+LIy88WeovbvBMj+udZQm5ayGuo
 AUcOaJjW52TxLjTfRvlfIxP9Gr9wBcEPFROJBT/q73z0z185mI07JmTFE5p4DuIMO22d
 OegnEqnBPyKmWahArWr6tv4XSAfjfCPu8VLz9ann2fG1cvfdnOHE/pCOTIL/NDFSbfAW
 MOtg==
X-Gm-Message-State: AOJu0Yxrj4XlsCnOLzAdF0+4W7t9Lly/Z4Hy8gZotZ6yKWBXb1c022rn
 PMgQ6Ryz66w5E40qBITkOSfcrBukA3isYb/JX9wy1NLGrYP3j6QbZ7K29roiISyrF5lmFRn4zgP
 M/NSe2JBfuW/dv7gktJgmMK5ehmRwb6Tf2WlM0EoSBIUwk3zJjQ9GqKyW2i/ZjPEqHAzyBwXZFQ
 8W53N7OEIZCiGhcMLCiK44VbUD4+qbbKhz
X-Received: by 2002:a17:907:1688:b0:a46:13f3:eb84 with SMTP id
 cx8-20020a170907168800b00a4613f3eb84mr1254240ejd.0.1710282367955; 
 Tue, 12 Mar 2024 15:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGewxjL+ux1V0g6HyHL9tz9M5FkwSzKmuAHQY+jVmJejvtwGqAjEYY1tixuvxc3snwC69XBNQ==
X-Received: by 2002:a17:907:1688:b0:a46:13f3:eb84 with SMTP id
 cx8-20020a170907168800b00a4613f3eb84mr1254227ejd.0.1710282367404; 
 Tue, 12 Mar 2024 15:26:07 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 be10-20020a1709070a4a00b00a461d2a3374sm2892729ejc.47.2024.03.12.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:06 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 12/68] libvhost-user: Dynamically allocate memory for memory
 slots
Message-ID: <d884e2727849fc95d337262ec91be60165473c4a.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: David Hildenbrand <david@redhat.com>

Let's prepare for increasing VHOST_USER_MAX_RAM_SLOTS by dynamically
allocating dev->regions. We don't have any ABI guarantees (not
dynamically linked), so we can simply change the layout of VuDev.

Let's zero out the memory, just as we used to do.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-2-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 subprojects/libvhost-user/libvhost-user.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index c2352904f0..c882b4e3a2 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -398,7 +398,7 @@ typedef struct VuDevInflightInfo {
 struct VuDev {
     int sock;
     uint32_t nregions;
-    VuDevRegion regions[VHOST_USER_MAX_RAM_SLOTS];
+    VuDevRegion *regions;
     VuVirtq *vq;
     VuDevInflightInfo inflight_info;
     int log_call_fd;
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a3b158c671..360c5366d6 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -2171,6 +2171,8 @@ vu_deinit(VuDev *dev)
 
     free(dev->vq);
     dev->vq = NULL;
+    free(dev->regions);
+    dev->regions = NULL;
 }
 
 bool
@@ -2205,9 +2207,18 @@ vu_init(VuDev *dev,
     dev->backend_fd = -1;
     dev->max_queues = max_queues;
 
+    dev->regions = malloc(VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
+    if (!dev->regions) {
+        DPRINT("%s: failed to malloc mem regions\n", __func__);
+        return false;
+    }
+    memset(dev->regions, 0, VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
+
     dev->vq = malloc(max_queues * sizeof(dev->vq[0]));
     if (!dev->vq) {
         DPRINT("%s: failed to malloc virtqueues\n", __func__);
+        free(dev->regions);
+        dev->regions = NULL;
         return false;
     }
 
-- 
MST


