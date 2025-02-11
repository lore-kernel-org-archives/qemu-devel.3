Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6479C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz6K-0005ir-PP; Tue, 11 Feb 2025 17:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6J-0005hh-5t
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz6H-00056f-E1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GVYGVKTNNJ14jZdJ2J7SbDQH89zHrOWXpmWYxPzaaI=;
 b=AJzSIkPsabAG1WfeVq1o/unPEi0jwPnp/KPMIvp8HGPYkUnON7EzTHtOb0ps0BTSpj99Xq
 aoUaUpje7QJ/TqTiArdpn9nLLT0i/qfo0Xpt1IAhJnRbWPDuAQkkJ7gqy+/8dsnphNwtYW
 D2bI6iUXyIKLHg05S+Gb56jzNs9tY0Y=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-2WXLarOkMPmMRIfMfwz6oQ-1; Tue, 11 Feb 2025 17:51:26 -0500
X-MC-Unique: 2WXLarOkMPmMRIfMfwz6oQ-1
X-Mimecast-MFC-AGG-ID: 2WXLarOkMPmMRIfMfwz6oQ_1739314286
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5fc834b0d5bso810697eaf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314285; x=1739919085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GVYGVKTNNJ14jZdJ2J7SbDQH89zHrOWXpmWYxPzaaI=;
 b=GPieFwhwgg4HWrwXAhz9OxzcU5ZvzAxaZJn+3XkrshpvxLbq0JoTIfLAR0y+PlEIA3
 xKkseZvQISOz4MgzIc7ergkS1n0PoU1oinGrRUTHnhd7mrypUEd8X11sxu7ppCi5rO+7
 uyByRqxF1/ahULA9M9SUKMNuq2JpmBOOgwlMRB3cHsG1FiSDLjRyLcAj/va9YCTPZKwl
 DFMOah0EXdl8xrKVaQYZM6VsdTZzJhC8Sta1ua3qFlZHZkP7Et7t67wRjsA5j9Un5wH5
 pPNNaDixbpoTaLAOVhKrdSy+KeY20ePSlGG57aeCyQCIV9TkOSRkUdcGkYO57rWN8TI4
 cKJw==
X-Gm-Message-State: AOJu0YzNSgAezeKdHnAHP8/p7wtN4seLD44a79IsAyuAumZ381Abrdyq
 jj/64/vChEjgegv7UQ6h/TWawyoJq2dy7HC5c41+aKol55Tel4IbzOlN3m2wGK+uOuXo3q6pG/f
 GUDE1SqRQdyJjw5LWpSj0fw8DStKm3JVdIkyDxDUFJ+qp8G7PAh/Fb3piwiYcCNBTSlOnt72VsF
 lbrKAr1yL7R4k+dnnGlctI5uART9SuDMOcTg==
X-Gm-Gg: ASbGnct7jinu7If8qeEZZaXFatMIScPCcD6vCoDGfRC9Rup1ClmXXTvqvAtlCZAbEpS
 Jg+CoXUiPXhYrHP7GavsRCa9Axc4Udss4i0AC+C/giRxb4V3K66L2OkWDXPQOZg+eg0TJpoJY6Y
 XRxAgZVnuRBOOCL+mpk4yFkjR6BTpeKR79cRuLcz18nNwdDKIEwC9+4hBLN4lZj5WhmyTK8QarC
 imWvewaa6XK+8QlUjKVRBF/OfxinXNKQutgFp/myChSbOye3AJ57XlJ
X-Received: by 2002:a05:6820:16ab:b0:5fc:9d2a:4921 with SMTP id
 006d021491bc7-5fca187cdb2mr689695eaf.5.1739314285247; 
 Tue, 11 Feb 2025 14:51:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf9VdW7Gi+M7z0XGNMi3OY6myZ4ZfgzX+GF32HekQ60VQroCYfWQ4/Z5DdAti1XShnh/UqIQ==
X-Received: by 2002:a05:6820:16ab:b0:5fc:9d2a:4921 with SMTP id
 006d021491bc7-5fca187cdb2mr689671eaf.5.1739314284490; 
 Tue, 11 Feb 2025 14:51:24 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:23 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 12/14] physmem: teach cpu_memory_rw_debug() to write to more
 memory regions
Date: Tue, 11 Feb 2025 17:50:56 -0500
Message-ID: <20250211225059.182533-13-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: David Hildenbrand <david@redhat.com>

Right now, we only allow for writing to memory regions that allow direct
access using memcpy etc; all other writes are simply ignored. This
implies that debugging guests will not work as expected when writing
to MMIO device regions.

Let's extend cpu_memory_rw_debug() to write to more memory regions,
including MMIO device regions. Reshuffle the condition in
memory_access_is_direct() to make it easier to read and add a comment.

While this change implies that debug access can now also write to MMIO
devices, we now are also permit ELF image loads and similar users of
cpu_memory_rw_debug() to write to MMIO devices; currently we ignore
these writes.

Peter assumes [1] that there's probably a class of guest images, which
will start writing junk (likely zeroes) into device model registers; we
previously would silently ignore any such bogus ELF sections. Likely
these images are of questionable correctness and this can be ignored. If
ever a problem, we could make these cases use address_space_write_rom()
instead, which is left unchanged for now.

This patch is based on previous work by Stefan Zabka.

[1] https://lore.kernel.org/all/CAFEAcA_2CEJKFyjvbwmpt=on=GgMVamQ5hiiVt+zUr6AY3X=Xg@mail.gmail.com/

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/213
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250210084648.33798-8-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memattrs.h |  5 ++++-
 include/exec/memory.h   |  3 ++-
 hw/core/cpu-system.c    | 13 +++++++++----
 system/physmem.c        |  9 ++-------
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 060b7e7131..8db1d30464 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -44,6 +44,8 @@ typedef struct MemTxAttrs {
      * (see MEMTX_ACCESS_ERROR).
      */
     unsigned int memory:1;
+    /* Debug access that can even write to ROM. */
+    unsigned int debug:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
 
@@ -56,7 +58,8 @@ typedef struct MemTxAttrs {
      * Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
      * distinguish "all attributes deliberately clear" from
-     * "didn't specify" if necessary.
+     * "didn't specify" if necessary. "debug" can be set alongside
+     * "unspecified".
      */
     bool unspecified;
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index b18ecf933e..78c4e0aec8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3018,7 +3018,8 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
     if (!memory_region_supports_direct_access(mr)) {
         return false;
     }
-    if (is_write) {
+    /* Debug access can write to ROM. */
+    if (is_write && !attrs.debug) {
         return !mr->readonly && !mr->rom_device;
     }
     return true;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 6aae28a349..6e307c8959 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -51,13 +51,18 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    hwaddr paddr;
 
     if (cc->sysemu_ops->get_phys_page_attrs_debug) {
-        return cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
+        paddr = cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
+    } else {
+        /* Fallback for CPUs which don't implement the _attrs_ hook */
+        *attrs = MEMTXATTRS_UNSPECIFIED;
+        paddr = cc->sysemu_ops->get_phys_page_debug(cpu, addr);
     }
-    /* Fallback for CPUs which don't implement the _attrs_ hook */
-    *attrs = MEMTXATTRS_UNSPECIFIED;
-    return cc->sysemu_ops->get_phys_page_debug(cpu, addr);
+    /* Indicate that this is a debug access. */
+    attrs->debug = 1;
+    return paddr;
 }
 
 hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
diff --git a/system/physmem.c b/system/physmem.c
index 8745c10c9d..d3efdf13d3 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3680,13 +3680,8 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         if (l > len)
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
-        if (is_write) {
-            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
-                                          attrs, buf, l);
-        } else {
-            res = address_space_read(cpu->cpu_ases[asidx].as, phys_addr,
-                                     attrs, buf, l);
-        }
+        res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
+                               l, is_write);
         if (res != MEMTX_OK) {
             return -1;
         }
-- 
2.47.0


