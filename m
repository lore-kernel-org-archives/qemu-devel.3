Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D073C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNh-0000Ge-AQ; Fri, 22 Mar 2024 14:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNg-00007F-9H
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNd-00078M-TX
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lvnwCtrPDnXyVmehzwWHmW4+Ppw0puxVjxFyVwmVZY=;
 b=grAClwIb1EEUW0Zs5Z/2PoM0rYi8iYW1QvMOt3Vif+Yl3n2mdqA6xJ5TvRXAC6yoBhQEKh
 LDa/xrGF+z+Y1yj6J7B4AnyFoxoBe1ADju4C6Ly1ard0le8tW3zSTmbR9MG3V3W1F3Yr7v
 OZEMcq9jRNaxSLJYHQ7TTB/8IXn1oi8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-o9RGY3OcM7KzEng4ShpJnw-1; Fri, 22 Mar 2024 14:12:35 -0400
X-MC-Unique: o9RGY3OcM7KzEng4ShpJnw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d599dba7fbso22742561fa.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131153; x=1711735953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lvnwCtrPDnXyVmehzwWHmW4+Ppw0puxVjxFyVwmVZY=;
 b=oWfcG2a/2kZ5xCGnTXcqI0MjxT2UOTJC4p0qBPZIJNel4n6N3HgfItVWXKPinCMmFB
 E9CY7LABiu4CW0cbx0sHP2k/oLSgBnrMZWC93nocfdPtAD2GmRUAoftZy4BgVGrA5QIl
 MFz1OXEqvErQCCXoVplHrouEwsoWuwrlLX0m0t13StnmAwp110C+uXQ5XKr28PZo1mem
 VZi1c9JPhMRzdyAOHNM+F17ijnZB8cOYwNj8ktGkNQ/EuVfTc8oe8RlyA0DTlwhys2PG
 w+Qdb2JxavCXaAPG/QZxqAZM7BQHmkKmwwO+NokjWQXS8YYmWdsIj3fTjI4DCMnJkQhe
 fE8g==
X-Gm-Message-State: AOJu0YwYwdTx/WPGXWUMtqzZYZE9uXmxJSObU9Jq9TmXRyMwWFeo5PDc
 hlUOBDKTJCF+wv8DrxLTSis49B8h8hhw6/WlBOxprLe+VDkzku2t4DbevKdQdm1GOZ7707bU2rI
 dRE5ohiAI1WzqXQ+9tZQ2eU5DS/lixvKc4J/27kHkoqT2bU/9iI/CLNnnYYfAw4Th2Pbry8Ex2T
 eWNdFSkZI/d+AcKACYEZNHzrpteOhoO9wxvn8y
X-Received: by 2002:ac2:4c37:0:b0:513:ce00:1a2 with SMTP id
 u23-20020ac24c37000000b00513ce0001a2mr151745lfq.30.1711131153084; 
 Fri, 22 Mar 2024 11:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/vpsWvKW+UefxP1BB/BvMyzSgPRYSN4K4RqYzXi6rG4mgedTz/kYl+63v3Gp9WiJz5PsnzA==
X-Received: by 2002:ac2:4c37:0:b0:513:ce00:1a2 with SMTP id
 u23-20020ac24c37000000b00513ce0001a2mr151730lfq.30.1711131152667; 
 Fri, 22 Mar 2024 11:12:32 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a1709062ad700b00a46dd1f7dc1sm76391eje.92.2024.03.22.11.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 24/26] physmem: Introduce ram_block_discard_guest_memfd_range()
Date: Fri, 22 Mar 2024 19:11:14 +0100
Message-ID: <20240322181116.1228416-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

When memory page is converted from private to shared, the original
private memory is back'ed by guest_memfd. Introduce
ram_block_discard_guest_memfd_range() for discarding memory in
guest_memfd.

Based on a patch by Isaku Yamahata <isaku.yamahata@intel.com>.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Message-ID: <20240320083945.991426-12-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/cpu-common.h |  2 ++
 system/physmem.c          | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6346df17ce9..6d5318895a3 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -159,6 +159,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+                                        size_t length);
 
 #endif
 
diff --git a/system/physmem.c b/system/physmem.c
index 5ebcf5be116..c3d04ca9212 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3721,6 +3721,29 @@ err:
     return ret;
 }
 
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+                                        size_t length)
+{
+    int ret = -1;
+
+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+                    start, length);
+
+    if (ret) {
+        ret = -errno;
+        error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
+                     __func__, rb->idstr, start, length, ret);
+    }
+#else
+    ret = -ENOSYS;
+    error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
+                 __func__, rb->idstr, start, length, ret);
+#endif
+
+    return ret;
+}
+
 bool ramblock_is_pmem(RAMBlock *rb)
 {
     return rb->flags & RAM_PMEM;
-- 
2.44.0


