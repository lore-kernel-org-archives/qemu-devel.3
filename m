Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E380CEDD93
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1k-0004iW-7R; Wed, 09 Oct 2024 08:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1h-0004ho-SK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1g-0005Qv-2f
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQt31NpoPy1kBmextgAReCNHDW1SSJ1uheANHNAwqA8=;
 b=a5Mgr6hna2dB/llbKsX+6O8qlrCwwmLrF/NyPWhXSk9dPO8H8JUo0nr4Ax+uQJdaNaqHut
 QQuirSKXdVOjmcLdUjGPdC2spEPEjzZQhF/WMhtMYWzNhRHEAai31xOLBZ2gr5RNgZIATS
 /VVrClXtdIc1rFzxE0azubqHkgoWKMw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-EDqaR26GMfuZOmhGzLohXA-1; Wed, 09 Oct 2024 08:42:44 -0400
X-MC-Unique: EDqaR26GMfuZOmhGzLohXA-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-82cd83f0b2eso712611939f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477763; x=1729082563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQt31NpoPy1kBmextgAReCNHDW1SSJ1uheANHNAwqA8=;
 b=w2KXdjJ4npJYn6bpBxNEvLLM6GRJPBMvRau/ygXi3/2oZenL9/Z/yxtJcqF5YSllmi
 n+SwVs8Ya2YQ3sLOb61MMyeP8sftyuBSj1zqHcbUUb4QcO3d/yAqqyuBavErNKXpfCqD
 3dRXKerX5XRWxmD2wtZ/vasuPSNIAodD7xyVK/wLGfUCH4i8OsJk/mYsbEQLDgOedy3c
 n3wVPuf/d0UbIoGIPY3qDeOR3q9f/jKDlZwbioZXPLazMDpkY9CwllGCS3bvdDTAO/Yt
 un2o11S5zQHdNO1X3crM/Zx5o7BzPrIDbNZef3CNJJVZHYeNgFUABfiTh6QoS3Lf44dA
 3zww==
X-Gm-Message-State: AOJu0YzVv9bLr8PiCwVmZzX1LkSUJqYKcusuRtrAIHIoF4p6qsg6K3g6
 uMD41YtdTCW+dc48G6PEzHaY0RSDqqBwM3HM82/zQwuTBHFuUYgT2fIsCDBXvcfpalKV9wQ+cEj
 +aUOn1opRpyVrCFiAMAJGSUXMi1iMJSUEPye/vgoGJaxqRFXsrCzdqQMEosPkpe5VqHKSOj5GM/
 pM+2WUfn7g/IRVme5u2D6fmYr5VPJ4eDATug==
X-Received: by 2002:a05:6602:634c:b0:835:444b:6195 with SMTP id
 ca18e2360f4ac-835444b6394mr116201839f.14.1728477763149; 
 Wed, 09 Oct 2024 05:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMSa2FsTMWN2FK2YGvoOW+MMGKxTusV922goBugNpfYw+prMZ0kJvuRsgvymmt7QWIiva++Q==
X-Received: by 2002:a05:6602:634c:b0:835:444b:6195 with SMTP id
 ca18e2360f4ac-835444b6394mr116199039f.14.1728477762748; 
 Wed, 09 Oct 2024 05:42:42 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/12] memory: notify hypervisor of all eventfds during
 listener (de)registration
Date: Wed,  9 Oct 2024 08:42:27 -0400
Message-ID: <20241009124238.371084-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

When a new listener for an address space is registered, the hypervisor must be
informed of all existing eventfds for that address space by calling
eventfd_add() for that listener. Similarly, when a listener is de-registered
from an address space, the hypervisor must be informed of all existing eventfds
for that address space with a call to eventfd_del().

Same is also true for coalesced io. Send coalesced io add/del listener
notifications if any flatrage for the address space registered with the
listener intersects with any coalesced io range.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20240918064853.30678-1-anisinha@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index f6f6fee6d8..85f6834cb3 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -941,6 +941,38 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
     }
 }
 
+static void
+flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
+                                                MemoryRegionSection *mrs,
+                                                MemoryListener *listener,
+                                                AddressSpace *as, bool add)
+{
+    CoalescedMemoryRange *cmr;
+    MemoryRegion *mr = fr->mr;
+    AddrRange tmp;
+
+    QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
+        tmp = addrrange_shift(cmr->addr,
+                              int128_sub(fr->addr.start,
+                                         int128_make64(fr->offset_in_region)));
+
+        if (!addrrange_intersects(tmp, fr->addr)) {
+            return;
+        }
+        tmp = addrrange_intersection(tmp, fr->addr);
+
+        if (add && listener->coalesced_io_add) {
+            listener->coalesced_io_add(listener, mrs,
+                                       int128_get64(tmp.start),
+                                       int128_get64(tmp.size));
+        } else if (!add && listener->coalesced_io_del) {
+            listener->coalesced_io_del(listener, mrs,
+                                       int128_get64(tmp.start),
+                                       int128_get64(tmp.size));
+        }
+    }
+}
+
 static void address_space_update_topology_pass(AddressSpace *as,
                                                const FlatView *old_view,
                                                const FlatView *new_view,
@@ -3015,8 +3047,10 @@ void memory_global_dirty_log_stop(unsigned int flags)
 static void listener_add_address_space(MemoryListener *listener,
                                        AddressSpace *as)
 {
+    unsigned i;
     FlatView *view;
     FlatRange *fr;
+    MemoryRegionIoeventfd *fd;
 
     if (listener->begin) {
         listener->begin(listener);
@@ -3041,10 +3075,34 @@ static void listener_add_address_space(MemoryListener *listener,
         if (listener->region_add) {
             listener->region_add(listener, &section);
         }
+
+        /* send coalesced io add notifications */
+        flat_range_coalesced_io_notify_listener_add_del(fr, &section,
+                                                        listener, as, true);
+
         if (fr->dirty_log_mask && listener->log_start) {
             listener->log_start(listener, &section, 0, fr->dirty_log_mask);
         }
     }
+
+    /*
+     * register all eventfds for this address space for the newly registered
+     * listener.
+     */
+    for (i = 0; i < as->ioeventfd_nb; i++) {
+        fd = &as->ioeventfds[i];
+        MemoryRegionSection section = (MemoryRegionSection) {
+            .fv = view,
+            .offset_within_address_space = int128_get64(fd->addr.start),
+            .size = fd->addr.size,
+        };
+
+        if (listener->eventfd_add) {
+            listener->eventfd_add(listener, &section,
+                                  fd->match_data, fd->data, fd->e);
+        }
+    }
+
     if (listener->commit) {
         listener->commit(listener);
     }
@@ -3054,8 +3112,10 @@ static void listener_add_address_space(MemoryListener *listener,
 static void listener_del_address_space(MemoryListener *listener,
                                        AddressSpace *as)
 {
+    unsigned i;
     FlatView *view;
     FlatRange *fr;
+    MemoryRegionIoeventfd *fd;
 
     if (listener->begin) {
         listener->begin(listener);
@@ -3067,10 +3127,33 @@ static void listener_del_address_space(MemoryListener *listener,
         if (fr->dirty_log_mask && listener->log_stop) {
             listener->log_stop(listener, &section, fr->dirty_log_mask, 0);
         }
+
+        /* send coalesced io del notifications */
+        flat_range_coalesced_io_notify_listener_add_del(fr, &section,
+                                                        listener, as, false);
         if (listener->region_del) {
             listener->region_del(listener, &section);
         }
     }
+
+    /*
+     * de-register all eventfds for this address space for the current
+     * listener.
+     */
+    for (i = 0; i < as->ioeventfd_nb; i++) {
+        fd = &as->ioeventfds[i];
+        MemoryRegionSection section = (MemoryRegionSection) {
+            .fv = view,
+            .offset_within_address_space = int128_get64(fd->addr.start),
+            .size = fd->addr.size,
+        };
+
+        if (listener->eventfd_del) {
+            listener->eventfd_del(listener, &section,
+                                  fd->match_data, fd->data, fd->e);
+        }
+    }
+
     if (listener->commit) {
         listener->commit(listener);
     }
-- 
2.45.0


