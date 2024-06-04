Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17688C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUS-0005tj-Py; Tue, 04 Jun 2024 15:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUQ-0005ro-7v
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUO-0000mf-M7
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfEypfhhzAT3jaOXKR+DgWb6iflUNTeNRcp9m8ElhrQ=;
 b=AHYfmk514QjuTsSRBvrQrWE+5Ca+GGviDFFGz6IGeOSS8JDlULJr8M1VcnnLkvU7awSkTt
 8ASDLO9cHJi7TQRnQEWR8YFcWxYKPC5qeDYIqPYhk21JO+SASdV+h1RVNKeeVEJnb47tt2
 3cqQ/nQEh/hXw1U6XhMsYKcwekwTeuw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-m8VLoBvxP-6FfGnFpeAAMQ-1; Tue, 04 Jun 2024 15:06:30 -0400
X-MC-Unique: m8VLoBvxP-6FfGnFpeAAMQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42133ebdf24so30279775e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527989; x=1718132789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfEypfhhzAT3jaOXKR+DgWb6iflUNTeNRcp9m8ElhrQ=;
 b=h7gApYspqSQhbqwBjtIaE3yB8u6CUnbkMIiryCJVzwqdZLHMICsOqvAAVtlUS+ELGn
 R08bytiF5vnpVG7vUQTmrZ/fdBGGIWJBPwO2e64X2j+QVMnQFhvVNvhBmGm8adyW3sr/
 qB1+Cm2ymtbxl3syzmtHo9uLOjQln5qID27UZ4numi/iIAhAazIeW4z8ebvHY93ns7eJ
 EKxoUwdg2e/tP0F/J6OcfoOAWuRCl3+pBR2TT9VE03yfHn+1XdaSumgJR5/tYUHW2ir1
 LP9G+JHMnJg+T+DW0/lcwNRb5RlpnPHynrxZp+qP33Iw6itdvKY+nZtf5zY5jbDcKzlJ
 YbRw==
X-Gm-Message-State: AOJu0Yz4A+KeAGKaMSJI4AN1wuapwbWbp9ArwomMr7DdlKP0FYhM3SKZ
 E21bL3VCv4zhfgpxPqfHAXv1AXup5zQY7ycbjQrQgOxKKChTvzFHR0N2mWaup3Y6ZfbA+VZe2JH
 dfG9N4GLLnGFTSVdrWxrscV5lRkkUlVbwYrlOSwx2UkjPkCUW90wxb9by2YHJTt6wdzkGghpfhC
 u5NMVpPlfsOZ4WwSNZpDHjRiPKEbs/HQ==
X-Received: by 2002:a05:600c:1e02:b0:421:2abe:54e3 with SMTP id
 5b1f17b1804b1-421562cf532mr3657555e9.2.1717527989143; 
 Tue, 04 Jun 2024 12:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrYtXW3SXZZutia2Gnd2Ndi0MgR6E3ecaxE7N4GvQ7ruxjGS26hHcLdNrdpEuDz5DUekK6tw==
X-Received: by 2002:a05:600c:1e02:b0:421:2abe:54e3 with SMTP id
 5b1f17b1804b1-421562cf532mr3657345e9.2.1717527988678; 
 Tue, 04 Jun 2024 12:06:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b2bc975sm167129025e9.29.2024.06.04.12.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:28 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PULL 08/46] virtio-ccw: Handle extra notification data
Message-ID: <4a42e11bc57832000fb4da43347a4419e07ea583.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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

Add support to virtio-ccw devices for handling the extra data sent from
the driver to the device when the VIRTIO_F_NOTIFICATION_DATA transport
feature has been negotiated.

The extra data that's passed to the virtio-ccw device when this feature
is enabled varies depending on the device's virtqueue layout.

That data passed to the virtio-ccw device is in the same format as the
data passed to virtio-pci devices.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-5-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3d0bc3e7f2..956ef7b98d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -125,9 +125,11 @@ static void subsystem_reset(void)
 static int virtio_ccw_hcall_notify(const uint64_t *args)
 {
     uint64_t subch_id = args[0];
-    uint64_t queue = args[1];
+    uint64_t data = args[1];
     SubchDev *sch;
+    VirtIODevice *vdev;
     int cssid, ssid, schid, m;
+    uint16_t vq_idx = data;
 
     if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
         return -EINVAL;
@@ -136,12 +138,19 @@ static int virtio_ccw_hcall_notify(const uint64_t *args)
     if (!sch || !css_subch_visible(sch)) {
         return -EINVAL;
     }
-    if (queue >= VIRTIO_QUEUE_MAX) {
+
+    vdev = virtio_ccw_get_vdev(sch);
+    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {
         return -EINVAL;
     }
-    virtio_queue_notify(virtio_ccw_get_vdev(sch), queue);
-    return 0;
 
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
+        virtio_queue_set_shadow_avail_idx(virtio_get_queue(vdev, vq_idx),
+                                          (data >> 16) & 0xFFFF);
+    }
+
+    virtio_queue_notify(vdev, vq_idx);
+    return 0;
 }
 
 static int virtio_ccw_hcall_early_printk(const uint64_t *args)
-- 
MST


