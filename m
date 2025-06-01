Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18289C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkgd-0008Qc-Pr; Sun, 01 Jun 2025 11:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkgW-000871-SE
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkgT-0005IP-0E
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKEH6Z9JCQimLJL8lPwV9KIkJSWOuDTn31SzP3o0in0=;
 b=IuiN1C5mtirBpKPX3XSApJCHwwEdCsupLD1NVa9Mi01o9G2JUIFnJV32oY4zMLLk98khdL
 LKXphcnaIKtos8E61q12pa7+CQopobLdUfJLHAYMl0Bm5/jN/yBkFehMdR5mKzUXby0ATS
 QGtm2PF1ZvwyHiHBxkrsQl73BssdNnM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-jwGibX3HPnOXehCICnd4SA-1; Sun, 01 Jun 2025 11:25:07 -0400
X-MC-Unique: jwGibX3HPnOXehCICnd4SA-1
X-Mimecast-MFC-AGG-ID: jwGibX3HPnOXehCICnd4SA_1748791488
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450cb902173so16115115e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791488; x=1749396288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKEH6Z9JCQimLJL8lPwV9KIkJSWOuDTn31SzP3o0in0=;
 b=JlTRdQ9AwGdfCcCCEdZPDY4qAGPCyajuWbrEp5vFK2unRsZixwz5BY82p7w1csGuXU
 9asEc9rYqcHlUVd+7Zf3jNiJmMHlbc4aVrLO61eqA/T+2jOoxCy5+Op46X2TY5AHBfjU
 DsPq2pFnbDq7EyF8hd25/fAYNlK0RiEI5HhPRBEdWfGGDUWyhC6BRXnGg7u47AmFa11U
 FzBQBLdme4ZE14l6BSuX4ftzcY6Dcgq6fyGHXvRq/UK8zGDlnfXcw7mO8TsaTdmK/U4c
 ZT1u8oEbkXfWXqyfiQMp2YczcNrsEjsQxhZSKBYNUqlHY9bnKLTSlJiSf9+Wl2hHIIYI
 I+KQ==
X-Gm-Message-State: AOJu0Yx2jJNgnUCgb6OVPKZz39rAAcQJHlGDBBvih++w5D2+t9gfB4kE
 BXoxB3R5pcx2wd0t1l8xTPgS6ycJuBM+DNNqWLxG2fsn4eKzQYl8RuA+VZokdxe8hsHdLOL6BfT
 4nSoOOmSBC4dgf4WANytZR7LEWs6cZ355K9EFTijRtKpYB6iytprxVCzQdYR000HD/RPnyVOqYw
 646CNvvWF5qHb2MCrHcozqrjIhM3z/dqFrew==
X-Gm-Gg: ASbGnctmvqdHZa3DknHDn92KYlVW+dkn6Yh1svOOHr4QB4AXWFEwMCLje/gXt2PivtZ
 jvNf/LjnABhrN22DR9kfrEDr9EAiYL8hWCBRnbpMXQVsVFezFVQn+H9TQdJ9eV5MMEpKnhmYWTf
 AwUl1DpKyVZSDSDtziKRlYhQRvqrOtm42XEWLBlFhIGVE4cvt/BdNiwXcua5esbwjNITHYCym/s
 UnIbcQv1KZLLQucR72ZXP9i2btK3a/a/cOp3XKyAiP29MsdsfKIOy0N9Y9/0eOEewV/1ZB5/HPP
 nO1xZ9qPhUrUf9kl
X-Received: by 2002:a05:600c:3f92:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-450d6b5999bmr95833935e9.6.1748791487749; 
 Sun, 01 Jun 2025 08:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmKWDFQhl1SCz6HHk2dYVS/WFA74r7SfcWFfZWGmgNxihnFEFlOEzISUoCOe0f5IwNy5AWvw==
X-Received: by 2002:a05:600c:3f92:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-450d6b5999bmr95833705e9.6.1748791487265; 
 Sun, 01 Jun 2025 08:24:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b89dsm11909055f8f.19.2025.06.01.08.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:24:46 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:24:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PULL 01/31] virtio: check for validity of indirect descriptors
Message-ID: <ac8fc4ccacd8a77d8d56dc3990bfb221c1f48fcd.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Yuri Benditovich <yuri.benditovich@daynix.com>

virtio processes indirect descriptors even if the respected
feature VIRTIO_RING_F_INDIRECT_DESC was not negotiated.
If qemu is used with reduced set of features to emulate the
hardware device that does not support indirect descriptors,
the will probably trigger problematic flows on the hardware
setup but do not reveal the  mistake on qemu.
Add LOG_GUEST_ERROR for such case. This will issue logs with
'-d guest_errors' in the command line

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20250515063237.808293-1-yuri.benditovich@daynix.com>
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/virtio/virtio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2e98cecf64..5534251e01 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -205,6 +205,15 @@ static const char *virtio_id_to_name(uint16_t device_id)
     return name;
 }
 
+static void virtio_check_indirect_feature(VirtIODevice *vdev)
+{
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Device %s: indirect_desc was not negotiated!\n",
+                      vdev->name);
+    }
+}
+
 /* Called within call_rcu().  */
 static void virtio_free_region_cache(VRingMemoryRegionCaches *caches)
 {
@@ -1733,6 +1742,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
+        virtio_check_indirect_feature(vdev);
 
         /* loop over the indirect descriptor table */
         len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
@@ -1870,6 +1880,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
+        virtio_check_indirect_feature(vdev);
 
         /* loop over the indirect descriptor table */
         len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
-- 
MST


