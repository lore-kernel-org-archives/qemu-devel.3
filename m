Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6978ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzZ1-00048z-Kd; Tue, 10 Sep 2024 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1snzYk-00033t-Nl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1snzYj-0008BH-1X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725969683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mJ+nu4OBRWNA66awMDjqGlw+Jxra9J0zh8CjtX6F30A=;
 b=eTkbe/vvUx+dnh6fSh34x3+VqwCBeegmyP8v/ahtE5jM+6fqQP9fB74UjOPq4BhuZlfzRO
 SBwSEtHleiHSxggqlu6DI/tY5oXDjvi9ZqKaQWUglxuCoZYYJQyBWGW7UNViVhvjD8KHF6
 sv/XARygkeZuuPpG4apnbS6iRSzdk0E=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-qsoj8XfGOLaU7bAnHvavwA-1; Tue, 10 Sep 2024 08:01:21 -0400
X-MC-Unique: qsoj8XfGOLaU7bAnHvavwA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-277e6462843so6440022fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969681; x=1726574481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mJ+nu4OBRWNA66awMDjqGlw+Jxra9J0zh8CjtX6F30A=;
 b=aAEj5jjbvgF/o98wwwIzcSY4BF5b2R5EUoAvfvbOnFsE/uweYWKQcOL196aBrWEg4B
 PMdveO3kGJfrJ1fvzmCauL2d9pPk7wNhK59fZtxAtfTd/04tX8a3AVpc/4eSGVurowEE
 YRfeMAWsCME8jzrJZt8sLyLmkOoNtQQaiGa30QbV6JyWhxq3yNTOIdxkIFHZsVxzUjze
 6/ztYEl4TxOZdTdrz5b04xKphmkP27XYKl+WcQ52qwgxiyEYftCqE/QZMGV0n2mqQXt/
 IHVRkMWm780y9uzshI5uwHJocoEvzY43gtaY010rKAc77Y9KXzafFWUYGzFrZcfzlm5w
 jTgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSgErQPAhsDsbXsFsD1ce+uiD5bX4llWRZq3ir0WWsnLVof0GcoQUkuwNkCh0RTkk7A/F+a/KxyHl1@nongnu.org
X-Gm-Message-State: AOJu0YySSQCrAb/YioCHtmqlAq38BPZYePRTjUaICwEt+YaETSEMrB4n
 abHUkRhF5IKnOQlwA9d9WSsS76LmIdwX36qlIxhwRp57x0NWo5IkMD1VzJqFFmfZtpp+hGXKdsL
 B3zxGlpQlLIHqbQriWUFHE5/wcskLKZXj/9+F6DzKsc4QxTNisp6V
X-Received: by 2002:a05:6870:420b:b0:27b:71ec:1463 with SMTP id
 586e51a60fabf-27b9d80424bmr6022327fac.14.1725969680768; 
 Tue, 10 Sep 2024 05:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKNM1RIEOPmWgPTNkRCyIY9guWZduAmShOA8KD9AwMiHIEz69RwSIK+/aLznVnMpZVYwwnKw==
X-Received: by 2002:a05:6870:420b:b0:27b:71ec:1463 with SMTP id
 586e51a60fabf-27b9d80424bmr6022290fac.14.1725969680252; 
 Tue, 10 Sep 2024 05:01:20 -0700 (PDT)
Received: from localhost.localdomain ([115.96.78.44])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-7d8259bd054sm4722766a12.77.2024.09.10.05.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 05:01:19 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] memory: notify hypervisor of all eventfds during listener
 (de)registration
Date: Tue, 10 Sep 2024 17:31:00 +0530
Message-ID: <20240910120100.9460-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Same is also true for coalesced io. Send coalesced io add/del listener
notifications if any flatrage for the address space registered with the
listener intersects with any coalesced io range.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/memory.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

changelog:
v2: tags added, indentation fixed, commit log fixed, code cleanup.

diff --git a/system/memory.c b/system/memory.c
index 5e6eb459d5..8379e086fb 100644
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
+        if (add) {
+            listener->coalesced_io_add(listener, mrs,
+                                       int128_get64(tmp.start),
+                                       int128_get64(tmp.size));
+        } else {
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
@@ -3041,10 +3075,31 @@ static void listener_add_address_space(MemoryListener *listener,
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
@@ -3054,8 +3109,10 @@ static void listener_add_address_space(MemoryListener *listener,
 static void listener_del_address_space(MemoryListener *listener,
                                        AddressSpace *as)
 {
+    unsigned i;
     FlatView *view;
     FlatRange *fr;
+    MemoryRegionIoeventfd *fd;
 
     if (listener->begin) {
         listener->begin(listener);
@@ -3067,10 +3124,30 @@ static void listener_del_address_space(MemoryListener *listener,
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


