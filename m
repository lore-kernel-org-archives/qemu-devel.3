Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BEBC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPU34-00011m-AX; Thu, 04 Jul 2024 17:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPU2y-00011O-4r
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPU2t-00051n-Vi
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 17:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720128668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=tsurKY2WPn/lQGfrMjeEmTrK7/AhmaC+b02rRqumbTE=;
 b=X7FrziJ9vjbrH8lgizu11H/uDQbG14tuZ9MODmHeWvnusnnVXU54RE3T0GCaTbJiAlJGLD
 LwUTQPSqzhNpSXdAAcjoGQilu02ImE0tXdCczvGUUygRYhPXFXrZuKYImBq1x1UnBQaNt4
 CokCrbNANTnARI2CU4EOVPc8GN3wglQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-4fmRX0iTP-KgfDtlnl6y4Q-1; Thu, 04 Jul 2024 17:31:07 -0400
X-MC-Unique: 4fmRX0iTP-KgfDtlnl6y4Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52e993e31a9so913938e87.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 14:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720128665; x=1720733465;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tsurKY2WPn/lQGfrMjeEmTrK7/AhmaC+b02rRqumbTE=;
 b=weEVNST2GNg8DG0t7SZODXBOsLM9I4FTLpzjss0HsFnZLvapI/6Jo796rFfdibuFfc
 XFuJlVD2EX9brWAhCkVhEDc0wl5koy1VkIxWt5/kN1vGKPKGqRwqfuHU1Q1nluKLTWq7
 iPi9GnPn4B4wmwY0X4glUKGuIfymjH7JC91YvPlrew4hx7HiFBZBEUPH+g0+JAc4qtH7
 awD8Dlw8DHGgViwa4YKngO0bPATXotSKZ8FLoi4NWSkppviq28ex7a3zplU0xUPlE5Qs
 gL5RwXiz+cxEPHjt2wk7NipjXFNMBoEaPd3+GR2nQBRa+mHxGljlOWBvwAL1cZi0z8WJ
 w5aQ==
X-Gm-Message-State: AOJu0Yw3dq5QqECKhg3PJt7e8P77YYvUcf56GQD1ysr/RS6pQPG3hq8T
 b3JQFptK+HTXwoN+7fJGnf+AXf8fwSAUtSqN6zzS4owo4U9LHCnD4+brAW8p9XPIGuYxJKy68lJ
 /x6o9GquLmJ3rLDd8m4FEgqpKDsw0QpBmSyr0wfj5AjctwD/L/E7G/rFWJDoE5og0HDn46D2RaE
 An/kwpqnUfE9IGJyDlMl2/osLvpbj2dA==
X-Received: by 2002:ac2:51aa:0:b0:52c:dcea:86e2 with SMTP id
 2adb3069b0e04-52ea061f5a3mr1944271e87.1.1720128664758; 
 Thu, 04 Jul 2024 14:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgB3gCd5LDXfezd5AIqwdzMlwkRjbCZ3Rnaulcaq+AEY/SnvLIv46cynQ1fkFv4/iv0LElzQ==
X-Received: by 2002:ac2:51aa:0:b0:52c:dcea:86e2 with SMTP id
 2adb3069b0e04-52ea061f5a3mr1944243e87.1.1720128663997; 
 Thu, 04 Jul 2024 14:31:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b889dsm634547666b.225.2024.07.04.14.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 14:31:03 -0700 (PDT)
Date: Thu, 4 Jul 2024 17:30:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC] virtio-balloon: make it spec compliant
Message-ID: <8de2d4a6407d796d4d793975fc88e2f929f6025d.1720128585.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Currently, if VIRTIO_BALLOON_F_FREE_PAGE_HINT is off but
VIRTIO_BALLOON_F_REPORTING is on, then the reporting vq
gets number 3 while spec says it's number 4.
It happens to work because the linux virtio pci driver
is *also* out of spec.

To fix:
1. add vq4 as per spec
2. to help out the buggy Linux driver, in the above configuration,
   also create vq3, and handle it exactly as we do vq4.

I think that some clever hack is doable to address the issue
for existing machine types (which would get it in user's hands
sooner), but I'm not 100% sure what, exactly.

This is a simpler, straight-forward approach.

Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I don't think I'll stop here, I want to fix exiting machine types,
but sending this here for comparison.
I'll send a Linux patch later.


 include/hw/virtio/virtio-balloon.h | 1 +
 hw/core/machine.c                  | 1 +
 hw/virtio/virtio-balloon.c         | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 5139cf8ab6..d4426404ed 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,6 +70,7 @@ struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+    bool reporting_vq_is_vq3;
     uint32_t poison_val;
 };
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f4cba6496c..353a143b2b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
     { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
+    { "virtio-balloon-device", "x-reporting-vq-is-vq3", "true" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 50da34d6cc..4712bee521 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -892,7 +892,8 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
 
     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
         /* Work around Linux driver which is buggy in this configuration */
-        if (!virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        if (!s->reporting_vq_is_vq3 &&
+            !virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
             s->free_page_vq = virtio_add_queue(vdev, 32,
                                                virtio_balloon_handle_report);
         }
@@ -1021,6 +1022,8 @@ static Property virtio_balloon_properties[] = {
      */
     DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
                      qemu_4_0_config_size, false),
+    DEFINE_PROP_BOOL("x-reporting-vq-is-vq3", VirtIOBalloon,
+                     reporting_vq_is_vq3, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
     DEFINE_PROP_END_OF_LIST(),
-- 
MST


