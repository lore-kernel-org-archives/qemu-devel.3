Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A0C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwJ-0007ey-9Q; Tue, 02 Jul 2024 16:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjug-0005Zj-U4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjue-00084c-DF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8epoI+2XR2IZhKNbWvFqqmIBG6jX2/y5dIWNKzyj2M=;
 b=OODe6RHSWySVHiHkbBGNE7gYI1cYxbT9vfHe0r80yCnZvFqBE+9CvRqbbsRGAjibWRETNv
 Uf2onUsyFmMLauWvUVeseVFE87p2foBTlmta5D6SeprYChtrICWce/a0XpKh+U0j4uZuQJ
 lzlNXnMblglF7WxdW39I5j87qylKeZQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Ark1eFbwNPmpLTmKfyTngA-1; Tue, 02 Jul 2024 16:15:38 -0400
X-MC-Unique: Ark1eFbwNPmpLTmKfyTngA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-44659591ce2so59021111cf.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951337; x=1720556137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8epoI+2XR2IZhKNbWvFqqmIBG6jX2/y5dIWNKzyj2M=;
 b=ZWZtdTgNnb0CYdXmOV8L+dEcFgHjJnMufZFhJZ45DkBGIe70Xrg35DTVOyW+o9hKeM
 yhMLWOVe1iAlAGDP5VRKuBqqy/3JDK5L/AUKeV8EnQ+U36OnTboanj+gwtQ1RWkGeDV0
 YoroFeVKqJRDdFF0TsLTdDKc0f7r4GnPbupqQv7V2YRnA8VXeNU72DwRP/zLSpTuxKVH
 tjLavVuPw7mjGTrO/jqX2E6mjCOiEkC5pbq5nSmvy65LqGtn/R4ASyMM78d7xbykUQh7
 Pz8ayEHvjxeupsYNvWJRg/gg1N0g+lW5TEAE0cpf6c0httaqGnlDVH9FoR+fWxqMQnVv
 DyYA==
X-Gm-Message-State: AOJu0YxI0mOqgEMpABr//danQJaDHHZoN/H4h6RWAw2A0sgFpWwwu7sH
 bbijytjoNemO+BM3UW/68lLdQhyMYO7Ibytsp/OCOGiyCq1AiTsISy0U100atSPJFPSVygG0i1V
 mLkydOoNPbUpyC1XBKSCIwixHA3xGfDJhqdMpsMENkgr+ne0CTaJ1jiEr93qA9a2com5iEAme8u
 metMOTm4fVVnV7kqbGLXFYc47kAilFbA==
X-Received: by 2002:a05:622a:1988:b0:444:fd74:5a87 with SMTP id
 d75a77b69052e-44662e413damr131964321cf.53.1719951337143; 
 Tue, 02 Jul 2024 13:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuKYVFyBp6l3p2OhoLuocUf0sYfMXxdAooZF919jOXTWNdNqTviuGLfipn+sSKqXTemuXUNw==
X-Received: by 2002:a05:622a:1988:b0:444:fd74:5a87 with SMTP id
 d75a77b69052e-44662e413damr131963911cf.53.1719951336608; 
 Tue, 02 Jul 2024 13:15:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b6169sm44137591cf.91.2024.07.02.13.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:15:36 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:15:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PULL v2 07/88] virtio-ccw: Handle extra notification data
Message-ID: <594b543a4a75d08f47e5ea92c96a89502a3eab72.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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
index cd063f8b64..8cd912f20e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -126,9 +126,11 @@ static void subsystem_reset(void)
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
@@ -137,12 +139,19 @@ static int virtio_ccw_hcall_notify(const uint64_t *args)
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


