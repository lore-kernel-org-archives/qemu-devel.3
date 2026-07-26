Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05066C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Pd-0007TY-0L; Sun, 26 Jul 2026 17:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pc-0007TO-7P
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pa-0004GQ-O5
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31blUpc4DKfolAZMDK1he1ArsMFEAu/hDo7YUtnhzUs=;
 b=iNIEtEU6fdWYugxrVzgleQiroh7nC3xBeomjVOktkvShISujH2wsYddyXJKw0QMe2S94Mo
 0bsCnrUHw+xo3wMuIEKNGv8iaX6SPVI9Js7x3KOo2ar2iyVwb5/v5QBq2uhHAQvIkDIwdC
 hKwvqZSnGyf7QL9JmYtNQO9vhrEY5J4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-s_p4_FpBOQua-OmrR2vavA-1; Sun, 26 Jul 2026 17:29:28 -0400
X-MC-Unique: s_p4_FpBOQua-OmrR2vavA-1
X-Mimecast-MFC-AGG-ID: s_p4_FpBOQua-OmrR2vavA_1785101367
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495495ad5ddso11499015e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101367; x=1785706167; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=31blUpc4DKfolAZMDK1he1ArsMFEAu/hDo7YUtnhzUs=;
 b=WlEJ65EE49qKegBJeSD6OlGbASd07VzTT6R8S7dKTawLdJBVf3ZVz5geH6rlr1vads
 rpnhbjl9dFetnvXzmUbt+qMgUIdeOfB4FVsP4gKNS9LDfW5fhO0C3ZBl4neRlto8bWV3
 9HzgN5pLGyO+xQDc4M1hxRTvVjyFz+CsXV1rZpa+Sj1q/yyLRmexNLYkUg1Y3/U9U2vL
 WSJLXA6+6Teus4W2BuShhyfcQd4+uHbuAmHa5r0jlXNPX9mzBEZ+kLd1K/1+vuew5lZl
 YCXiwepwebqAy3ORY0ny2UrWaOwOgZYxWM/xQPpppjxZOb9vqhXg+btx3zvAGEuqlwmT
 +h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101367; x=1785706167;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=31blUpc4DKfolAZMDK1he1ArsMFEAu/hDo7YUtnhzUs=;
 b=D29RxewinT8vL1r6vX7yt+fwguDv6RO+nNirLOimxQcdzf/ZXvVg63URYuzr7fKCgQ
 ZBx2iPgMrC72NtM3hiIagZx+SVj65tWI5TUbxyuuYhyXShMSftPeyf69bfxLoC+OhMXr
 DIzcCS49hO86tAjB4OV5J1DcEDkdNFKx9nH0wk9A3UACDHhKJNssK00eB8Qorhtr6TCp
 ssO1hd+GvhiieVqs1LuVovE5Y3yz4t2QpLL7BQiFOhgVgvwmdwcFq0q06q4IQpo9ddtx
 q27k3K1COxlBU8OLnCJab0hjYv5V+CGpmAV80Lr9KEWoY7SFVqTSbnW1B0aKkbavzWG1
 wVdg==
X-Gm-Message-State: AOJu0YyiIXvNN/yRojtFAvAo746KjT84OrvfaDfvdcroKjHNMKGx0di6
 ZRR4ELNkaEIltkhLJZeaoV3d/mU8lnvbsA9VgoyXgMbgzFHPJ+yEwdjw4fFmC8Bd2wqjfhwRKWU
 k9Hb4p3AFpIGjUn+M/1FcqR2NJpJSwp54ql/0MKF3TCNSKJ2HJFLW13SNAUfsc3NYGN2SoOt5JA
 OmaF2OEzgLP4aiprQ97HXk2fhPrZsmm7Z/6g==
X-Gm-Gg: AR+sD11cmrvs3hkBepEgLYfh+XdOZShBPK0XMm6cL6vEnKNDvbBmlCqk32SHotMhm/L
 uMXaIUMHe+5Onm+aIq0aOiO5gpMyChEyN02h5qkxS+Qv5G68Hksu7QSVmeE/f69EztO2GJuz76A
 UP3i7ABUFnNF1+tqp4MRhB6zvj5wyOLbEU3RK0MzpbDfbfIQ1ygaBqkBseSHNlHFKhEEIAfPz+W
 XeWGbi2jSkfUYZ8soK7CF2GS4Dk5OzplpUGhEPWdQoZ82ISGa20J0vBAtgCK445e7HDBNfwFEvE
 UmbyODgx0KoMTNUG71iMFA0SgWc03VkLUvq93fGfr2WoE6HJpRAwDiu/awandZtcmjHo53s02Ln
 Q4Af7den4CuM+ZZgzTQGtyg==
X-Received: by 2002:a05:600c:354f:b0:495:5062:17f9 with SMTP id
 5b1f17b1804b1-496b5702398mr94969005e9.30.1785101367020; 
 Sun, 26 Jul 2026 14:29:27 -0700 (PDT)
X-Received: by 2002:a05:600c:354f:b0:495:5062:17f9 with SMTP id
 5b1f17b1804b1-496b5702398mr94968775e9.30.1785101366507; 
 Sun, 26 Jul 2026 14:29:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bfc2ff2sm181311165e9.4.2026.07.26.14.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:25 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/30] virtio: fix queue size validation against allocated
 maximum
Message-ID: <871260c82406c56cafa575ade77e952560f94d3f.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

virtio_add_queue() allocates used_elems for num_default entries, but
virtio_queue_set_num() accepts larger guest-supplied queue sizes up to
VIRTQUEUE_MAX_SIZE. With VIRTIO_F_IN_ORDER, this lets the guest drive
used_elems accesses past the allocation and cause out-of-bounds reads
and writes.

Reject queue sizes larger than num_default in virtio_queue_set_num()
and mark the device broken.

Fixes: e63c0ba1bc ("virtio: Add support for guest setting of queue size")
Fixes: CVE-2026-50626
Cc: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3921
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3923
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3613
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <eb7cc3672a20db392f577edbece2300aa6754dd3.1784898967.git.mst@redhat.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cdc8ba76f1..4a6430c31c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2418,6 +2418,11 @@ void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
         num < 0) {
         return;
     }
+    if (num > vdev->vq[n].vring.num_default) {
+        virtio_error(vdev, "virtio: queue %d size %d exceeds max size %u",
+                     n, num, vdev->vq[n].vring.num_default);
+        return;
+    }
     vdev->vq[n].vring.num = num;
 }
 
-- 
MST


