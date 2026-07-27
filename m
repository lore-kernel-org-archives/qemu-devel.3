Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE5CC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQrt-00009t-BF; Mon, 27 Jul 2026 15:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrs-00009f-61
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrq-0000N6-DV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ztveMvOf8dhfMuHF5jnMCpMJC+TJBMbMVVTXwok/3LQ=;
 b=Sl/0h0AO2J2So7YZ7GGZlv2mi8pO1kNkmx28r7jakHuFs3duA0ejArYip2qUFRs2bT1qYh
 IEDja5oVSqmxSxvo5IRUS6Z0EDsjb0BYEXummJvDtvbAQwGW6RitKv8gP33qDHOquD7I5M
 kfXsnZrKN6CQR8DGccpVUD/c4m5Sv9g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-PErsgzd4MDGw7jDveE4F9w-1; Mon, 27 Jul 2026 15:20:00 -0400
X-MC-Unique: PErsgzd4MDGw7jDveE4F9w-1
X-Mimecast-MFC-AGG-ID: PErsgzd4MDGw7jDveE4F9w_1785179999
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f7700ffdeso1224830f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179999; x=1785784799; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ztveMvOf8dhfMuHF5jnMCpMJC+TJBMbMVVTXwok/3LQ=;
 b=RTi0AJSSXqwsBHbbLYszVkqZxwQT+h95qWVJ+zCCZag+7TBkzpv9WX79F6vj6ZTTqB
 xZJmFzvQaS7SGjHBWoQ/pcEkOPykH0/TQeMSn5gkrg5wCpi0AOkOMBsu/pbopEXSykoI
 uWZ56e7/cnYTVJR5RZRywZLumIPZK9vBBC8EG6jkna+hYYbspzb35bheMxF7GYCtBoGT
 UaGmVl3e0JxKwUWybDjF0p2pk+SwQvtFJGWN05E8TBPJy7urIWlucey5x/9qbfFDk4d8
 pHNsYpRTlCgrU6dNbR2SwWliLhWf9DIRsfZ4NY9qgg/PFXD9EFc+Zq4i97ZVVx8OiZZo
 quhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179999; x=1785784799;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ztveMvOf8dhfMuHF5jnMCpMJC+TJBMbMVVTXwok/3LQ=;
 b=cKDrmkf54F45ixfTEay34GvgHT3aJQkugrABsRPh23MCN3SKWzYvGtB7Z2K7rPAih0
 GO2T1HNF/zwwfNuSyDI7Wc3gH8Y3rg49tUCEYV8CrZt6g3cpg4+KYGxPEehWvhxUMqP7
 XGDz8Z8eyAo/IlBvTvQNsc6vcSh3umKxuosp615kfomOQWcrcsVGJxsNgI3Y3yUYsYv9
 WcfuSMSaByz6PW+HnEL71m9IN56G8u9J5Iz5ExIEkSAe5C4v2ZMX7FFT0oxjq4vsOiXX
 I8QgfNybL2FpkWBghMpDPZZ5QAcvtZ5e9JatT/wCDmVor+HQZWIt4XBIn4xuXcU4+gJI
 dE9Q==
X-Gm-Message-State: AOJu0Yy+Eg+kpYBiUv0fiI7NJB6ptJwvpqgBr/W11PxUzP0lCXCfMSqH
 LeHPtM5lHQuQXCR+FnSUoSCALuuxiak8pVPj6YfIGMzgZmmfDYHqRudAYVyaTmbG7TWWc0/3yCy
 XVzSgWQkYvavcfAuV+8VzYdWmXfAhi9thjBLT33gmhZzSwICAJT3nWbThbIJ+6zJOJHnL5Gj2OJ
 zyeM57H0R4S4Mb5ILuUtNEKjNqfss8oceLHQ==
X-Gm-Gg: AR+sD12d7NgN4HxRUuJRp/Mkfd9vsGlyfwKKH9RBXE3gm6YF3+WiAwe6fC2emuR2P2d
 Pf7IqL33xS1XKDOiCoCe3B7OQcHAkyobYp0QF3FQjrbdnsGrCZHX/09DZjgwBjWtMk4dm05RNoH
 q3ReAFX6F4MXuG77bf63bL7wVMgAspuVM+KZNTAJS+zX7ohrj4HqIXEYei5Pep2S5Hk28USUgZ1
 oeIGvsOZ4ls0vQjqeYtv1GDy0Ti3X19mjnooOEIZtmmpedG/17V55+9G9syEyjM58A9QMaSaioL
 DAr6ZLfexnkBo7N++VSZO/QUaBrRJlpuC3/bM3JbzdLQY3YGZ6TLJj8tEEu4gm2qa2RxprSUkOo
 L9+HV7FHP+f8jYBCZ4MYIQg==
X-Received: by 2002:a5d:584c:0:b0:47f:8866:bd6a with SMTP id
 ffacd0b85a97d-47f9fc9255bmr12593714f8f.19.1785179998720; 
 Mon, 27 Jul 2026 12:19:58 -0700 (PDT)
X-Received: by 2002:a5d:584c:0:b0:47f:8866:bd6a with SMTP id
 ffacd0b85a97d-47f9fc9255bmr12593682f8f.19.1785179998106; 
 Mon, 27 Jul 2026 12:19:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96b9abc0sm30687523f8f.32.2026.07.27.12.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:57 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL v2 09/30] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <a5cff318f06cd06b37224e15ee74d64d1df8b12b.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
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

virtio-mmio reports VIRTQUEUE_MAX_SIZE (1024) as QUEUE_NUM_MAX for every
queue, regardless of the size the device passes to virtio_add_queue().

This works by accident because QEMU mostly does not care about the ring
size - the guest is the one allocating memory here.  But this changes
with in-order vqs where qemu is the one allocating resources.
Now, specifying a larger vq than allocated causes an OOB memory access.

To fix:
- for new machine types, report the actual max queue size to guest
- for old machine types, use a compat property to allocate 1k sized
  queues

Fixes: 525d82e323 ("virtio: fix queue size validation against allocated maximum")
Fixes: CVE-2026-50626
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <8715acbb9516e67e2a776cda6f9edf105343f788.1784930765.git.mst@redhat.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reported-by: Miku Hatsune <anznu1l@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-bus.h  |  1 +
 include/hw/virtio/virtio-mmio.h |  1 +
 hw/core/machine.c               |  1 +
 hw/virtio/virtio-mmio.c         |  7 +++----
 hw/virtio/virtio.c              | 11 +++++++++++
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 1a2d396156..f80fd71424 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -30,6 +30,7 @@
 #include "qom/object.h"
 
 #define TYPE_VIRTIO_BUS "virtio-bus"
+#define VIRTIO_QUEUE_SIZE_OVERRIDE "x-override-queue-size"
 typedef struct VirtioBusClass VirtioBusClass;
 typedef struct VirtioBusState VirtioBusState;
 DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index 1644d09810..0a9069868c 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -69,6 +69,7 @@ struct VirtIOMMIOProxy {
     /* Fields only used for non-legacy (v2) devices */
     uint32_t guest_features[2];
     VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
+    uint16_t override_queue_size;
 };
 
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 805148678d..73b4d82b4a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 #include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_0[] = {
+    { "virtio-mmio", VIRTIO_QUEUE_SIZE_OVERRIDE, "1024" },
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 58c6d46aab..55ceaeef5f 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -172,10 +172,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
                 >> (32 * proxy->host_features_sel);
         }
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
-        if (!virtio_queue_get_num(vdev, vdev->queue_sel)) {
-            return 0;
-        }
-        return VIRTQUEUE_MAX_SIZE;
+        return virtio_queue_get_max_num(vdev, vdev->queue_sel);
     case VIRTIO_MMIO_QUEUE_PFN:
         if (!proxy->legacy) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -738,6 +735,8 @@ static const Property virtio_mmio_properties[] = {
     DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
     DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
                     VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT16(VIRTIO_QUEUE_SIZE_OVERRIDE, VirtIOMMIOProxy,
+                       override_queue_size, 0),
 };
 
 static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2d33622daf..cdc8ba76f1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2568,6 +2568,17 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
         abort();
 
+    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
+    if (qbus && qbus->parent &&
+        object_property_find(OBJECT(qbus->parent), VIRTIO_QUEUE_SIZE_OVERRIDE)) {
+        int override = object_property_get_int(OBJECT(qbus->parent),
+                                               VIRTIO_QUEUE_SIZE_OVERRIDE,
+                                               &error_abort);
+        if (override) {
+            queue_size = override;
+        }
+    }
+
     vdev->vq[i].vring.num = queue_size;
     vdev->vq[i].vring.num_default = queue_size;
     vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
-- 
MST


