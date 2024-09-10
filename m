Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624E8EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 04:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snsM5-0006Gl-1T; Tue, 10 Sep 2024 00:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1snsM3-0006GB-RM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 00:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1snsM2-0008Cq-5R
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 00:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725941988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4qUmWSa6b5VQp+2FGujuogOvk9JroMLFbD1cgl37dRY=;
 b=RVXIV3Z/IuwBwFibOkVPOXZggaePV0xE8ebKs/Nu3my1pCgausAGTVqzRreQUZFBWYcOk9
 +zIcdsEdua8e0FGIQZbVXxSmUn4EVvhkVaO+yIIU7DwSiXlfhJdpfUnp4QudHILfD/OYWD
 yvzVCoPAT5JAuZLjCHw3WStkVfZo57A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-9G4d3EJuOYqxRuSv4iu4Jg-1; Tue, 10 Sep 2024 00:19:46 -0400
X-MC-Unique: 9G4d3EJuOYqxRuSv4iu4Jg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1fc6db23c74so67279795ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 21:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725941985; x=1726546785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4qUmWSa6b5VQp+2FGujuogOvk9JroMLFbD1cgl37dRY=;
 b=Vjo7GpXcSsWEtNB2uOWZhNjhrc1Nk2uFL4YssWqFxtGlzKgT/r7FHPX1apE8TF27tG
 Qbv11n71DIlHknqO223ZhkngLFkfI8n458vWaXDJJZfIZLzE20jinv/L8cpnn2G+y8qJ
 h7fPNU8m86NEL8kEuIkXcF0Vp2Z5xQWZ/Ncsu2jDGVnrIS1wa8RiYjxCgCQ16xqs7bMd
 +FkNzWjXJoa5sRBXdC6VB1KJNKW6LgzEFWOr4UxReUkeUaQHik2l0PD2uLGyy3a3u9GT
 1Rmwzg2gnL80/wRUAgacXlHGESO/CSz1Fwwzglvuuod5dlNLSe62p23LLLmWSURzU+iv
 kjBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX96iJeA/C5GrluaF+lMfYa0mEmoimAeN/bwmSp3MX2p/wKdj66d4wOUDcHOOSLa5cOcsZsSyn/0NwP@nongnu.org
X-Gm-Message-State: AOJu0Yyns0hfBZefQeIak+S3jFifxM5T72eSD0XLTUiJSxjxk4Mwdiou
 gZRr+s5Vk/luFDuKz7gHQpVb6kp2WopS6tbV0pfImuUfeHo7ep/X5IdZbDUVlrurXUTe6oFg1Ok
 Zq+4XjPScvIMkI+TF3UCLCRDNf5l+ASJpLOyw31gKktUMI4w6JTP/
X-Received: by 2002:a17:903:24f:b0:207:182c:8a52 with SMTP id
 d9443c01a7336-207182c8abemr78837285ad.58.1725941984974; 
 Mon, 09 Sep 2024 21:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuSAnUUZyd0l0+6YKxlaUchBXjLgONWzFzhkET7PqBPyCXWRlybcmvGa5iN5OeUL/VRSK0hA==
X-Received: by 2002:a17:903:24f:b0:207:182c:8a52 with SMTP id
 d9443c01a7336-207182c8abemr78836935ad.58.1725941984402; 
 Mon, 09 Sep 2024 21:19:44 -0700 (PDT)
Received: from localhost.localdomain ([115.96.78.44])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-20710eea8d8sm40611025ad.165.2024.09.09.21.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 21:19:43 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] memory: notify hypervisor of all eventfds during listener
 (de)registration
Date: Tue, 10 Sep 2024 09:49:36 +0530
Message-ID: <20240910041936.5142-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a new listener for an address space is registered, the hypervisor must be
informed of all existing eventfds for that address space by calling
eventfd_add() for that listener. Similarly, when a listener is de-registered
from an address space, the hypervisor must be informed of all existing eventfds
for that address space with a call to eventfd_del().

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/memory.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index 5e6eb459d5..ac1b809491 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -941,6 +941,41 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
     }
 }
 
+static void
+flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
+                                                MemoryListener *listener,
+                                                AddressSpace *as, bool add)
+{
+   CoalescedMemoryRange *cmr;
+   MemoryRegion *mr = fr->mr;
+   FlatView *fw = address_space_to_flatview(as);
+
+   QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
+       AddrRange tmp;
+       MemoryRegionSection mrs = section_from_flat_range(fr, fw);
+
+       tmp = addrrange_shift(cmr->addr,
+                             int128_sub(fr->addr.start,
+                                        int128_make64(fr->offset_in_region)));
+
+       if (!addrrange_intersects(tmp, fr->addr)) {
+           return;
+       }
+       tmp = addrrange_intersection(tmp, fr->addr);
+
+       if (add) {
+           listener->coalesced_io_add(listener, &mrs,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+       } else {
+           listener->coalesced_io_del(listener, &mrs,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+       }
+   }
+}
+
+
 static void address_space_update_topology_pass(AddressSpace *as,
                                                const FlatView *old_view,
                                                const FlatView *new_view,
@@ -3015,8 +3050,10 @@ void memory_global_dirty_log_stop(unsigned int flags)
 static void listener_add_address_space(MemoryListener *listener,
                                        AddressSpace *as)
 {
+    unsigned i;
     FlatView *view;
     FlatRange *fr;
+    MemoryRegionIoeventfd *fd;
 
     if (listener->begin) {
         listener->begin(listener);
@@ -3041,10 +3078,27 @@ static void listener_add_address_space(MemoryListener *listener,
         if (listener->region_add) {
             listener->region_add(listener, &section);
         }
+        flat_range_coalesced_io_notify_listener_add_del(fr, listener, as, true);
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
+            .fv = address_space_to_flatview(as),
+            .offset_within_address_space = int128_get64(fd->addr.start),
+            .size = fd->addr.size,
+        };
+        listener->eventfd_add(listener, &section,
+                              fd->match_data, fd->data, fd->e);
+    }
+
     if (listener->commit) {
         listener->commit(listener);
     }
@@ -3054,8 +3108,10 @@ static void listener_add_address_space(MemoryListener *listener,
 static void listener_del_address_space(MemoryListener *listener,
                                        AddressSpace *as)
 {
+    unsigned i;
     FlatView *view;
     FlatRange *fr;
+    MemoryRegionIoeventfd *fd;
 
     if (listener->begin) {
         listener->begin(listener);
@@ -3067,10 +3123,28 @@ static void listener_del_address_space(MemoryListener *listener,
         if (fr->dirty_log_mask && listener->log_stop) {
             listener->log_stop(listener, &section, fr->dirty_log_mask, 0);
         }
+        flat_range_coalesced_io_notify_listener_add_del(fr, listener,
+                                                        as, false);
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
+            .fv = address_space_to_flatview(as),
+            .offset_within_address_space = int128_get64(fd->addr.start),
+            .size = fd->addr.size,
+        };
+        listener->eventfd_del(listener, &section,
+                              fd->match_data, fd->data, fd->e);
+    }
+
     if (listener->commit) {
         listener->commit(listener);
     }
-- 
2.42.0


