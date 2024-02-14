Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B5CC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDE0-0002np-5Z; Wed, 14 Feb 2024 06:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDx-0002OS-TL
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDw-0006tr-1U
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smiDBzm8jjockK0zGaO+moTUtAPPy/TrghQrFfeHPcQ=;
 b=LkRJGF//g278S5E2UIu4bDdcsy0BsuV/4XnBm90KFzjY849+819q5FXzy/df0T+md/uZum
 46aNik42fxXzX4326jn6zIQK48kYS6JBkRA7MWC0mlNl+P4OGy8xVJdp6+4rsqYsb8PAOf
 1+WYED8TsYPq28tVGhvfbOX7OGhv700=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-13pTl0a-PhaJpbtcXOvQZw-1; Wed, 14 Feb 2024 06:14:41 -0500
X-MC-Unique: 13pTl0a-PhaJpbtcXOvQZw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2bc664528fso403710166b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909280; x=1708514080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smiDBzm8jjockK0zGaO+moTUtAPPy/TrghQrFfeHPcQ=;
 b=XSeXYFu5xQkob/sERN6faHhKHwQqKqWf2Z1K1cF6dF4BCUZ3uHuBzMERIi2MTPn0Oz
 ee8i6pjBCP5xMS1yOyBCRsgA/PDj0MpL321Lt2zLJbNYut/Z5PP2z6fk1X/rgFueAGbC
 pjW2e85wOWuTWvpU4OBG08+x8MiZGFROiYidQBLcJYHVWZg+35KDBKQlaJAj6QQjnFsw
 mb5bMputZeT5OmZBBCjkxEz5LbWRlXr1hmNwumb0icU1soxfFGIX3npwh7vgkbOM+oTR
 zqly+Uh4YK4yRWLhItaep069zLkGCpoZPpl5FbCLuX7UkWB7EzJloMJrGVvRyV9699cf
 dXFw==
X-Gm-Message-State: AOJu0Yy06N1RpQ5KIPm2qURhgNe/uAFZ+wKVgehRVe80hEwkFItKHbC6
 bJgq+lnxbwWDeThlwcuUHii7TqLSbaKmTNKTIZC1PE3TckckTBtkbhf23ykVlftiyIjw+Opqt0q
 lNkrKPmAYDpA2AMIDV5avpO+y4NoHT056qlk0Gw1Xc0rSSlvNIVSWSzmYOCQTKNg66pa3+wCHSA
 SDZp63Yors8cr/nrhaEkk+p+7hBnSzCg==
X-Received: by 2002:a17:906:6809:b0:a3d:6160:fcca with SMTP id
 k9-20020a170906680900b00a3d6160fccamr463631ejr.69.1707909280212; 
 Wed, 14 Feb 2024 03:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZjsSdR+l4A/AMEj2g0dxGAt+tfDD2oxNPbfCTsR93ojeJ4kt5Ig95/isB/NwkQ7W8CWZU/g==
X-Received: by 2002:a17:906:6809:b0:a3d:6160:fcca with SMTP id
 k9-20020a170906680900b00a3d6160fccamr463612ejr.69.1707909279962; 
 Wed, 14 Feb 2024 03:14:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVCcIux88zS8EZnjkSw4acOkpebnVTw0Tj1c2ALNA6K7LQXu4YZMmsMvHVsxcQOFK9PqHMc9PFk64IYNLdrXvxN7IrTCcrcVHw+xZybfhiZdpL4luJyy77i+CLdCwY8zGdL3DUO5R2EMG5ZQNKIpL1vBLgjVOS5XZhBTMWWqiIjuKPyZEd+WzIyn+EAc+63
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 x16-20020a170906441000b00a3d44571dd9sm504245ejo.136.2024.02.14.03.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:39 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/60] exec/ioport: Add portio_list_set_address()
Message-ID: <ad2b652341f4257e2fb7ebf3834724f91173a07a.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Bernhard Beschow <shentey@gmail.com>

Some SuperI/O devices such as the VIA south bridges or the PC87312 controller
are able to relocate their SuperI/O functions. Add a convenience function for
implementing this in the VIA south bridges.

This convenience function relies on previous simplifications in exec/ioport
which avoids some duplicate synchronization of I/O port base addresses. The
naming of the function is inspired by its memory_region_set_address() pendant.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240114123911.4877-6-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/ioport.h         |  2 ++
 system/ioport.c               | 19 +++++++++++++++++++
 docs/devel/migration/main.rst |  5 +++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 95f1dc30d0..96858e5ac3 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -54,6 +54,7 @@ typedef struct PortioList {
     const struct MemoryRegionPortio *ports;
     Object *owner;
     struct MemoryRegion *address_space;
+    uint32_t addr;
     unsigned nr;
     struct MemoryRegion **regions;
     void *opaque;
@@ -70,5 +71,6 @@ void portio_list_add(PortioList *piolist,
                      struct MemoryRegion *address_space,
                      uint32_t addr);
 void portio_list_del(PortioList *piolist);
+void portio_list_set_address(PortioList *piolist, uint32_t addr);
 
 #endif /* IOPORT_H */
diff --git a/system/ioport.c b/system/ioport.c
index a59e58b716..000e0ee1af 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -133,6 +133,7 @@ void portio_list_init(PortioList *piolist,
     piolist->nr = 0;
     piolist->regions = g_new0(MemoryRegion *, n);
     piolist->address_space = NULL;
+    piolist->addr = 0;
     piolist->opaque = opaque;
     piolist->owner = owner;
     piolist->name = name;
@@ -282,6 +283,7 @@ void portio_list_add(PortioList *piolist,
     unsigned int off_low, off_high, off_last, count;
 
     piolist->address_space = address_space;
+    piolist->addr = start;
 
     /* Handle the first entry specially.  */
     off_last = off_low = pio_start->offset;
@@ -322,6 +324,23 @@ void portio_list_del(PortioList *piolist)
     }
 }
 
+void portio_list_set_address(PortioList *piolist, uint32_t addr)
+{
+    MemoryRegionPortioList *mrpio;
+    unsigned i, j;
+
+    for (i = 0; i < piolist->nr; ++i) {
+        mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
+        memory_region_set_address(&mrpio->mr,
+                                  mrpio->mr.addr - piolist->addr + addr);
+        for (j = 0; mrpio->ports[j].size; ++j) {
+            mrpio->ports[j].offset += addr - piolist->addr;
+        }
+    }
+
+    piolist->addr = addr;
+}
+
 static void memory_region_portio_list_finalize(Object *obj)
 {
     MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 00b9c3d32f..9439adcf66 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -431,10 +431,10 @@ data doesn't match the stored device data well; it allows an
 intermediate temporary structure to be populated with migration
 data and then transferred to the main structure.
 
-If you use memory API functions that update memory layout outside
+If you use memory or portio_list API functions that update memory layout outside
 initialization (i.e., in response to a guest action), this is a strong
 indication that you need to call these functions in a ``post_load`` callback.
-Examples of such memory API functions are:
+Examples of such API functions are:
 
   - memory_region_add_subregion()
   - memory_region_del_subregion()
@@ -443,6 +443,7 @@ Examples of such memory API functions are:
   - memory_region_set_enabled()
   - memory_region_set_address()
   - memory_region_set_alias_offset()
+  - portio_list_set_address()
 
 Iterative device migration
 --------------------------
-- 
MST


