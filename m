Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0D9C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAq-0005N8-Vr; Fri, 11 Sep 2026 05:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9x-0003lo-E9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9v-0008Fu-Ku
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tjmu0XflcFt7hcajhQyvOAGpQgP0KwuZU8Bcnz844UE=;
 b=N2o2fFHcGcuV4pFi/eUilu7W1JW0MEZ5IqxtBVOzVauFTer9X6dsXaqtP20s24avlVQ4M8
 WjztPiRZ1Fu9w98khoJf//x080VF1cGyX2VnZcELYvxnRmLwUiz+VlFs7GupRBX51Oz6D6
 85X3fEjQMLinzSQf3VL6exRq+lHAQmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-9l-LcIr0OYa7FSundF2HdQ-1; Fri, 11 Sep 2026 05:02:57 -0400
X-MC-Unique: 9l-LcIr0OYa7FSundF2HdQ-1
X-Mimecast-MFC-AGG-ID: 9l-LcIr0OYa7FSundF2HdQ_1789117376
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso4208695e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117376; x=1789722176; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tjmu0XflcFt7hcajhQyvOAGpQgP0KwuZU8Bcnz844UE=;
 b=WyjzAvfgaOVjAwEbPcHJDLBZ1OqFGr72d4+p8tWvMwsGXo4JlM+aqmxNSQLuOSaMTE
 hCnFUJNdHbKg1WyUfajchboAJhIeFvfkcnUfRvQhe4XwiYDq8C4VbMCNXFWVYWqEsXok
 drEo6/ur7hKTxhaeiWceeH0p7MqZ627F+Afz54UdmsYlwDh2f0a8bnFL92eZUNRUqI2t
 NglW20+aodLetRAmYZw2oIsINuFWWKzYz8O2mSndHBAgmeggJGcpm2yf8pq2AZ7oaQQJ
 9TBGAErSMGY6oMoqYbLO59KiWwnQhHrfV8LG/xgSkOgpooXI24mOo0AyeL7/185KViKY
 xDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117376; x=1789722176;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tjmu0XflcFt7hcajhQyvOAGpQgP0KwuZU8Bcnz844UE=;
 b=ZK9trvOoq4co8rtcxN+vsxTu8dAhdYkpvbzPFaKYMZHENFpW53/dAvMAzJ//KR1lDN
 iONqCQFQFz8yd591xp1J4frIYGleecO/3JDJBipKDWdvSk9jI4HYxVQWTBuEL1Dj8NcA
 FH7nB1+PKFVNU6idKi0oYRVrFDXfw3g0/bXlEDmAuwr1kYTOjCsF93iS2aLNchFPZfQp
 fnqIIPFFdla3a+Tae6dgnII2SpUBx516rtcF+8gjruaatkWfhZb0u+izNOpAWJEvlJU/
 e+VadjQTroyQXU0q0WER2KgKz9OEetXfczj/DLZ61lKjQNKRhjqva5H3OQ4m0jabSFP2
 0A8A==
X-Gm-Message-State: AFuF++lMH//WtFyYAhSKYzcWOK5220ZwayKsmW+P4bzPWirgkTN6UwEc
 c0FS+uzh8o+/iNNEEzUi1ZRk0NwfkNxd/OF+vzMhApnRfKROPFUq8N9yVA9LqDaShfXRYsPKWkT
 6UkLwGxsaLVR4ddRvQ/+DKtmuEpAzexjzUxPQbzGQxvTDRzpiDVVgmnZ2+7Fj5m8zpYCC1J0IkF
 aQwCTEllL4i6V9MvZq/j5OxGbTrbR23AiD7Q==
X-Gm-Gg: AYBFou1bDa+rMfP27PQNVDlFXl7svjxgEdyb3VB2xuYPZ/PSvCgQSrVYl7DbhdghC1q
 YtlbdFRvjtVC7VzUHWZlo5VAcF2lE0bLDPAfpESKU981HPjDzK7zUNjEkmwFYypcqGpWL13rT/M
 zZ59F5f+IgHspDoPvBVY3q2304z3dzr3bxezZJBq29xrthcx1CZYeW397SjPkm2OPP26LLVQWQ3
 T4NJjxcUABNU5P9OJdH4xdwr8deJX+NZpggjwPrOY3tEucq3vvi+NM+pEFzMWGjfCsu613c9HWo
 zKbZNxdfE/swi4Zfbic656hPdaEE7qSzRqXV2Pu5o5QdTOZXNtEXQ1UikNszN5am7KaYUnwGOZu
 O2Be96EpF7PQjgqEdIsgIUKo=
X-Received: by 2002:a05:600c:3515:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49e61a7425cmr32653305e9.9.1789117376424; 
 Fri, 11 Sep 2026 02:02:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3515:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49e61a7425cmr32652605e9.9.1789117375824; 
 Fri, 11 Sep 2026 02:02:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm69486125e9.0.2026.09.11.02.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:55 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jia Jia <physicalmtea@gmail.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL v2 40/75] hw/virtio: reject inverted virtio-iommu IOVA ranges
Message-ID: <0c3d950c27cb052b1bf14ec084d723d92ab1726a.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Jia Jia <physicalmtea@gmail.com>

Guest MAP and UNMAP requests can set virt_end below virt_start. Since
virt_end is inclusive, this is not a valid interval. MAP nevertheless
stores it in domain->mappings, but interval_cmp() assumes low <= high.
For an inverted key, interval_cmp(key, key) returns -1. A covering UNMAP
can therefore find the key but fail to remove it and repeat forever while
holding s->mutex.

Reject inverted request ranges with VIRTIO_IOMMU_S_INVAL and make the
notifier range decomposition skip invalid ranges. Keep the existing
notifier-before-remove ordering, but return VIRTIO_IOMMU_S_DEVERR if
g_tree_remove() fails.

Fixes: fe2cacae2438 ("virtio-iommu: Implement map/unmap")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4104
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729131953.1720567-1-physicalmtea@gmail.com>
---
 hw/virtio/virtio-iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 533bd5073f..208815096f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -212,6 +212,10 @@ static void virtio_iommu_notify_map_unmap(IOMMUMemoryRegion *mr,
 {
     uint64_t delta = virt_end - virt_start;
 
+    if (virt_end < virt_start) {
+        return;
+    }
+
     event->entry.iova = virt_start;
     event->entry.addr_mask = delta;
 
@@ -807,6 +811,10 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
         return VIRTIO_IOMMU_S_INVAL;
     }
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -857,6 +865,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
 
     trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
 
+    if (virt_end < virt_start) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
     domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
     if (!domain) {
         return VIRTIO_IOMMU_S_NOENT;
@@ -879,7 +891,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
                 virtio_iommu_notify_unmap(ep->iommu_mr, current_low,
                                           current_high);
             }
-            g_tree_remove(domain->mappings, iter_key);
+            if (!g_tree_remove(domain->mappings, iter_key)) {
+                ret = VIRTIO_IOMMU_S_DEVERR;
+                break;
+            }
             trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
         } else {
             ret = VIRTIO_IOMMU_S_RANGE;
-- 
MST


