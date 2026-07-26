Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC97CC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PR-0007Q4-M5; Sun, 26 Jul 2026 17:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PQ-0007P4-Ad
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PO-0004EP-Hu
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWDhTvp+NZCs7WT4ZbRIuRmxoFHhanESiW2Frsm5Zp4=;
 b=Cx1jfBMIa0Rm0Vd5vV926CQNvVKMiO0ZUKxmdDSWndrgu/mEvYaL1MtI396GC7c+PDetX0
 ZxkiRN1LmDNVd54CSXkJbkx57OTufSVVmeaCnrnOj+Mc4xPgxZpgePhzII8QWcVZnBQ0rg
 m878kSFAJcgnS7MS/IMnMX4fLbT62ME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-fgH9cjVAPiq-DX91UAtP5A-1; Sun, 26 Jul 2026 17:29:16 -0400
X-MC-Unique: fgH9cjVAPiq-DX91UAtP5A-1
X-Mimecast-MFC-AGG-ID: fgH9cjVAPiq-DX91UAtP5A_1785101355
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f7039fa59so1786885f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101355; x=1785706155; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FWDhTvp+NZCs7WT4ZbRIuRmxoFHhanESiW2Frsm5Zp4=;
 b=Os5AX/m8HBi+r9nrVscwcK7/8Jw2DixMMimjN9a08bON+ikeeEtj7GQJR+OzIr7tjW
 OC1T0CAKyagxgldaaAEgFgbrZL+XrM2BjYhs1MHBa0JDvrNk+EpXp3xerIlg/HBaOg+6
 5up/8AgWtH0YV4hUWBzF4qsu0IR6ueUhOE/Y4sOwi8/RTCQXQaMbCsHJa7g9onOaxsdY
 tTC9E47kV+nOITHm43570yOutuIEUxkDHdW0hw/PVpof2lkbcFgbgoSRgG2n/9Ppn0Jb
 6H3qSzljrZIr9X2v190VlrAdwLNBCrMGHtJyxfHo7dQnsr8BQtzwbdgkxfj8yitwnax3
 dr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101355; x=1785706155;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FWDhTvp+NZCs7WT4ZbRIuRmxoFHhanESiW2Frsm5Zp4=;
 b=k8dC9Zx/dOmCnjjPmj9siQe4VdEPFccQuTAwwRhUP80mpyrrfFjNk4iEwN7h2/KZ5I
 BggL55MGAH04KjmGkA1yYFdV3jzKwuw5F3CXF6ClWV2CMeMvaeBZP1r9MmzcXVACwlDM
 0ZCThiZOr4dOTx87cfsbwfQumKxu8RAXJY/8nSa8ZSUlcCw6EEpRqtepmtfJMiYeBJdc
 jL5Pmc7vnZhYfNy8RUvxwngo2TpACZpWus84qQh5g1XvS/LRnirNuG+hbXYifylpeJhs
 OnE+XrjVo0NYt5P6olHIhcoFcMfZYVEP0bHV1iUltQjrMQemiu2Lb5MddeVZm9b+lTpF
 YGig==
X-Gm-Message-State: AOJu0YxlBgM3QdMZ4wkcvELZX/RGEX7lYP+d/UWS6CCNcNmyYY5NlHg3
 9HBUmvVj+/ouwAo3Wq2X5YM9nTH7quroo3ZiLngduaBhBrqYUjO1FuQK6neJpDHdJnQrqkipN8N
 CGBFsBfByKaVbXN2Qt4P1OM8SbxydvMNAfkQztw3JW/JFQDjbdQlJ2Rv23aRL7jJlRYdxmZPv/u
 0RVRGtHyyU6ssZ1pfmnz1SC4oxtNOp9WeoWg==
X-Gm-Gg: AR+sD11Ttym2MdqrmEHKilkO5hsQKSA74kpggZBMQRze7yao+ryjxdbeRZ5fvMrO2Q/
 b2R37+UBM61lsWCHPe9patzyNe47Huvrtfw9ToE/TNs1br5z1RYbTx4RP3Uqu19iwOBQaaR7WMQ
 sqzHsHxPDL4ItNQd4HnAcpWwJIB5lJ7jMUyEvThuu+EfNoZptXJTD4L3jxEcrrXfyuxTPdUOX67
 UJ9U24xdns59tTCkuUxcZb032anSajOUmYaz9U9eCGZVqZb9GfDC90zrcybOS3aNk73iO31YO8t
 eVEhmZaR2BIJWxV9bj/p2O+/GIQF/zJYg3CkIew20SXB93zzbt7I8+EyjqTHxnvAXMq4xpnLoMs
 JcWu1k0I1ezqmt3D1fRHutA==
X-Received: by 2002:a05:6000:144c:b0:47f:7261:3a58 with SMTP id
 ffacd0b85a97d-47f9fc8a4fbmr8230492f8f.1.1785101354633; 
 Sun, 26 Jul 2026 14:29:14 -0700 (PDT)
X-Received: by 2002:a05:6000:144c:b0:47f:7261:3a58 with SMTP id
 ffacd0b85a97d-47f9fc8a4fbmr8230470f8f.1.1785101354102; 
 Sun, 26 Jul 2026 14:29:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm45416279f8f.3.2026.07.26.14.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:13 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 05/30] libvhost-user: protect against OOB vring queue access
Message-ID: <0fe21ad9e0afff7c7f73c2d65443cdab7ad13292.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SET_VRING_NUM, SET_VRING_ADDR, SET_VRING_BASE, and GET_VRING_BASE
handlers all use the queue index from the message to access dev->vq[]
without checking that it is below dev->max_queues, so a malformed
message causes an out-of-bounds heap access.

Frontend is trusted so not a security problem, but
an OOB access is not a nice way to handle errors.
Check, and panic.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3741
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <dbba777b25f86587c8d131891a2b4b2be97e5c5b.1784899069.git.mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 28 ++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8208265588..42a5e2f1f5 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1200,6 +1200,12 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("State.index: %u\n", index);
     DPRINT("State.num:   %u\n", num);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_num index: %u", index);
+        return false;
+    }
+
     dev->vq[index].vring.num = num;
 
     return false;
@@ -1210,7 +1216,7 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     struct vhost_vring_addr addr = vmsg->payload.addr, *vra = &addr;
     unsigned int index = vra->index;
-    VuVirtq *vq = &dev->vq[index];
+    VuVirtq *vq;
 
     DPRINT("vhost_vring_addr:\n");
     DPRINT("    index:  %d\n", vra->index);
@@ -1220,6 +1226,12 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", (uint64_t)vra->avail_user_addr);
     DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->log_guest_addr);
 
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_addr index: %u", index);
+        return false;
+    }
+
+    vq = &dev->vq[index];
     vq->vra = *vra;
     vq->vring.flags = vra->flags;
     vq->vring.log_guest_addr = vra->log_guest_addr;
@@ -1256,6 +1268,12 @@ vu_set_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("State.index: %u\n", index);
     DPRINT("State.num:   %u\n", num);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_base index: %u", index);
+        return false;
+    }
+
     dev->vq[index].shadow_avail_idx = dev->vq[index].last_avail_idx = num;
 
     return false;
@@ -1267,6 +1285,14 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     unsigned int index = vmsg->payload.state.index;
 
     DPRINT("State.index: %u\n", index);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_base index: %u", index);
+        vmsg->payload.state.num = 0;
+        vmsg->size = sizeof(vmsg->payload.state);
+        return true;
+    }
+
     vmsg->payload.state.num = dev->vq[index].last_avail_idx;
     vmsg->size = sizeof(vmsg->payload.state);
 
-- 
MST


