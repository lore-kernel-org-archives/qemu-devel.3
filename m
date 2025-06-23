Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C6EC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRp-00062x-Vf; Mon, 23 Jun 2025 16:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRo-00062P-Bg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRm-0003YK-H8
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfapCsZl0kYjzSD6EX3sg9lpxnZK3jQJXXQJ8voRQa8=;
 b=L4Aot1g3HEj43XB42V+pvWVTk3yDLVg8U5V/3jhs8fDMddEKjNnLYhSzmmePtyHGts0bxy
 6ATnZkOcpWoE6huid88ThpfUC5v4oQbeEDNJ0tszD6SavFZoeEHisCuvqhETnEL6a6lGf4
 tSwTvp9H55Mv1e+JjdDFkV5OgxhOcdU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-xa774GB-MpqDT_LNxgq0kQ-1; Mon, 23 Jun 2025 16:07:16 -0400
X-MC-Unique: xa774GB-MpqDT_LNxgq0kQ-1
X-Mimecast-MFC-AGG-ID: xa774GB-MpqDT_LNxgq0kQ_1750709235
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fb32203ca6so99042556d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709235; x=1751314035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfapCsZl0kYjzSD6EX3sg9lpxnZK3jQJXXQJ8voRQa8=;
 b=vQMaQ8CWmmP1DQ6O2SA3MAQ8IgCAodRMdhWLhNVPohIMGA2w5JYCZA9A4LX6/TFob/
 FtKgiE39Ermh9OrthZoPF1eC5K1oZB/4pj37SGnP7yVmRL43+ElWq7ZR/JB73Qr6R4HX
 18S41nQxlni7iHUcUiZ4rm48Jw4fP3lD3Qi++nBeNt8p8HjCWuLx/RqiaSjc9vSxIUGW
 TT8IFDZGrYFt0u6Xcb+6pyGK2sQtvBE3v20eop9T8X8pT4SMuFC05t0syRjCG6+i3rhC
 kIEKpFSZ/ST96XRnUTW6h52PEUkZwQq+Q67HwkjyXreADh5TrtCb/I4czB6AtqQ2edj9
 AF1A==
X-Gm-Message-State: AOJu0YwpRaRY0cFTXEOxDLOwOrwbDvPHpiiUcKJJ1asTFKpkH2N/laF6
 2LVjHwjYRj31UyC08gYTRP56o7Tm5aOmEEefbH1dEWFm0hbKBocAg5VyL/PTo8PM4bIwxpU8DHs
 JMj/UmIFZFeV37nS9AijGuqKEM2bPxnbx/sIQcFi+4gNNIP6kv8hLA+VqgGrwNdYWSz9mHQL31u
 wWW+ckt8M1UPfsA9NlQuhmphDE5WTNZzdPICe/9Q==
X-Gm-Gg: ASbGnctvov+kK+u5XQZmV4iXRnFRMwLXEciYagQFCKqlxnYJh8dWsP1eu4oyPs9lzXH
 WFnc2bFeej9KVW3R7ynXPpZNqv5YczUFuL+7//7eOYd23dzGubZaoSW8H4rg+XciVoTaJMkALFP
 R4lTQzhfmFvdBGLqInA8VetO93NlLXxROcWz00h/+1CPCN2QTMF6kL/h8yLHtGhcE6+lQDchA62
 EIIg76zkv7p0o+uy2Rc4d0Nmf9QswFj3djCuUlDk7zB38mThn9LNuyE3S6nZEgrAskmjB088AxS
 8LZ+Ia3PwhU=
X-Received: by 2002:a05:6214:2f92:b0:6fa:c3e4:4251 with SMTP id
 6a1803df08f44-6fd0a48c2b9mr239956496d6.15.1750709235260; 
 Mon, 23 Jun 2025 13:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWyP1V/g+yzfyABeqhnxTNWZcPgH7gHU3iOvPv6n7FaHcfi+1VPnEz6HlCV6QxBELaHZc66w==
X-Received: by 2002:a05:6214:2f92:b0:6fa:c3e4:4251 with SMTP id
 6a1803df08f44-6fd0a48c2b9mr239955876d6.15.1750709234802; 
 Mon, 23 Jun 2025 13:07:14 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PULL 11/11] physmem: Support coordinated discarding of RAM with
 guest_memfd
Date: Mon, 23 Jun 2025 16:06:56 -0400
Message-ID: <20250623200656.1882674-12-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

A new field, attributes, was introduced in RAMBlock to link to a
RamBlockAttributes object, which centralizes all guest_memfd related
information (such as fd and status bitmap) within a RAMBlock.

Create and initialize the RamBlockAttributes object upon ram_block_add().
Meanwhile, register the object in the target RAMBlock's MemoryRegion.
After that, guest_memfd-backed RAMBlock is associated with the
RamDiscardManager interface, and the users can execute RamDiscardManager
specific handling. For example, VFIO will register the
RamDiscardListener and get notifications when the state_change() helper
invokes.

As coordinate discarding of RAM with guest_memfd is now supported, only
block uncoordinated discard.

Tested-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20250612082747.51539-6-chenyi.qiang@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/ramblock.h |  1 +
 accel/kvm/kvm-all.c       |  9 +++++++++
 system/physmem.c          | 23 +++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 1bab9e2dac..87e847e184 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -46,6 +46,7 @@ struct RAMBlock {
     int fd;
     uint64_t fd_offset;
     int guest_memfd;
+    RamBlockAttributes *attributes;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a31778341c..d095d1b98f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3091,6 +3091,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    ret = ram_block_attributes_state_change(RAM_BLOCK_ATTRIBUTES(mr->rdm),
+                                            offset, size, to_private);
+    if (ret) {
+        error_report("Failed to notify the listener the state change of "
+                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
+                     start, size, to_private ? "private" : "shared");
+        goto out_unref;
+    }
+
     if (to_private) {
         if (rb->page_size != qemu_real_host_page_size()) {
             /*
diff --git a/system/physmem.c b/system/physmem.c
index a8a9ca309e..ff0ca40222 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1916,7 +1916,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
         assert(new_block->guest_memfd < 0);
 
-        ret = ram_block_discard_require(true);
+        ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "cannot set up private guest memory: discard currently blocked");
@@ -1931,6 +1931,24 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
+        /*
+         * The attribute bitmap of the RamBlockAttributes is default to
+         * discarded, which mimics the behavior of kvm_set_phys_mem() when it
+         * calls kvm_set_memory_attributes_private(). This leads to a brief
+         * period of inconsistency between the creation of the RAMBlock and its
+         * mapping into the physical address space. However, this is not
+         * problematic, as no users rely on the attribute status to perform
+         * any actions during this interval.
+         */
+        new_block->attributes = ram_block_attributes_create(new_block);
+        if (!new_block->attributes) {
+            error_setg(errp, "Failed to create ram block attribute");
+            close(new_block->guest_memfd);
+            ram_block_coordinated_discard_require(false);
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
+        }
+
         /*
          * Add a specific guest_memfd blocker if a generic one would not be
          * added by ram_block_add_cpr_blocker.
@@ -2287,8 +2305,9 @@ static void reclaim_ramblock(RAMBlock *block)
     }
 
     if (block->guest_memfd >= 0) {
+        ram_block_attributes_destroy(block->attributes);
         close(block->guest_memfd);
-        ram_block_discard_require(false);
+        ram_block_coordinated_discard_require(false);
     }
 
     g_free(block);
-- 
2.49.0


