Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCDBC27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF09y-0002ue-DH; Wed, 05 Jun 2024 19:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF09x-0002u9-5M
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF09v-00053k-Je
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfEypfhhzAT3jaOXKR+DgWb6iflUNTeNRcp9m8ElhrQ=;
 b=INBZyVSy2RYwjiUjy+Ap4nfyJLXLB9IpfPXzk7APCzL2Vx/6I6wGUDkUhTaViDYsqUqlXX
 wpiRLh5pRzj9vWdar/CVDWFUEpoZQAO3BbCvngD/AU96phAno+xeZ85H0zPEX1Mpy2vXbk
 83erGHwKuQZlVwVkXzJ13j3zmFLQwYk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-d5Mk8XcsMKm5VfyumiqzrQ-1; Wed, 05 Jun 2024 19:35:09 -0400
X-MC-Unique: d5Mk8XcsMKm5VfyumiqzrQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so27557766b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630508; x=1718235308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfEypfhhzAT3jaOXKR+DgWb6iflUNTeNRcp9m8ElhrQ=;
 b=OHy34unNJ5bxM/8ZuiFb4z86xYxxTrWbBIQ/zsfDeh/pdlSXY6dSsYALJlLhxUkCjk
 mdwQH2aoTISoQVNDMHmKvNBdzdC/rvlADBlX+U/0VcjKAxDpgu7qclgwaXlErtN8asDt
 ZFsxv4pWf00UJ6fmx5IbyUAj753BJ6uRimsVAqU84O7y9wXX/Kt/4PvrA7oamYF3seeC
 z4OOndMMDro7o2+VFuPIqI3VpwRrecvDLQHEPPiDtqvLflnz6XQD030wiATB2csbT9RJ
 kNg4gp10qKAEPObMZ6wPAOIcfw5jmArX7FnIyO6qJ3iyJP9cbiaR2/bEI3gXSmI50pTE
 1Xaw==
X-Gm-Message-State: AOJu0YxXv24NQL0ZG20BUaw5UF+d7OZsQ/QPd3UK22QN4Dsxt7QFQr50
 wF/N/OpBp6NAZyXJujFc9bPgoPI/PmS/JnvBI2TKtFAxffKx9IKps4lH9fMwUp9o/LnmqFZ1NX2
 J7CFIv6qWye33ZZ7AVJzriE2eSuxFwu97Y35tK2sGSih5RWtDC4C4dh4eGhJkMyCXOdHL4qInxA
 V0Bh23iTpiuKIhveWgeAVnvFHzH59hTA==
X-Received: by 2002:a17:906:add8:b0:a68:be46:742f with SMTP id
 a640c23a62f3a-a6c75f8edefmr88843366b.3.1717630507856; 
 Wed, 05 Jun 2024 16:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8qjlS+udktv58GsuPwqZCLE2JugkraGrX6J5bR8VSSWhHp3rKl68z+JOewWk/FnZQ8pmpBQ==
X-Received: by 2002:a17:906:add8:b0:a68:be46:742f with SMTP id
 a640c23a62f3a-a6c75f8edefmr88841266b.3.1717630507462; 
 Wed, 05 Jun 2024 16:35:07 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80582841sm7079666b.42.2024.06.05.16.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:06 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PULL v3 07/41] virtio-ccw: Handle extra notification data
Message-ID: <da5a4f61c4df4ab86beff9c5ee1cf75e948768d8.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
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


