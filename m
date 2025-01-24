Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDFEC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMXo-00032H-Jx; Fri, 24 Jan 2025 11:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbMXi-00031H-IP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbMXf-0005Ib-4x
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737736101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Exu5epeTQjUXGqc6EvI9Ro49B7EhhPUJNuPMkX7VzoI=;
 b=gp4q76eYK7EchlRqqB3UG+TJyfWaTbnsLgMXbTXAJHUdl0mxCjZfmcysmaqhRwn+Q3Vu+3
 +KIGe9UqoeVju57d+XGK2+TXohrQsgApoJKOJzZ9XSW75ydFvACHnF/ZJtPh25iEFYD1mf
 Sr8JCSX5zVnHQ5s69ldDeTShvQ4dNMI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-Nyg78LUIP3CSKpp-2B1yig-1; Fri, 24 Jan 2025 11:28:18 -0500
X-MC-Unique: Nyg78LUIP3CSKpp-2B1yig-1
X-Mimecast-MFC-AGG-ID: Nyg78LUIP3CSKpp-2B1yig
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5dbaaed8aeeso2664244a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736094; x=1738340894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Exu5epeTQjUXGqc6EvI9Ro49B7EhhPUJNuPMkX7VzoI=;
 b=a4PqyscTw6+eo8JBmr/17rKHB4KY6+uhRvE89RDApD70sbcULqOdaqi0LOM2lcxFiY
 uDkoLsLcZvWE3ehb2prbt8VigisSoN2/J7F85yRgY/yWHfGSlRkueqe+ypVEBJgIgXfV
 FHpERYxNA/6ITsANcZt3Vf7RM9mBQ1xUBcYG3RsVDc8eaEe3g6Ge6O7gqyGSs1kVoE7L
 SuYHCq5STKw7e4hGWtfzKG7iaLeIWTIVtjI7uSaGV+umeCw5SzxB4vKePSCDf/Cm8y3C
 4N0DmOrroViVcG8q3eXvkaMmjt6URE/yjADVqaSU1GWqDR1zGQ3BKz8pp8009o8PImmQ
 TgHg==
X-Gm-Message-State: AOJu0Yx/TH1LDzKLbi4lIAGdq8iD2+j9k6WZBv2P0GgpgyIylEa4JK0I
 PaBysBXlDybQA90l0/zjP2fKuANQetnZxmVkr45ZkiW8IL/DZ12KUx2G64rNUIjC8zH3gPzRNK0
 vCctrtOOFCmIyJ62icdjBSPUIQX1JbPGoCYQHqZ8ixMMRr4KRf23Ci/+6sC6+oT2dO2hkzgAX25
 QUj8SMt4CDDoND25Cd9HoSTrhqkw5YTeXz1Hk2xg==
X-Gm-Gg: ASbGncsyGYxPTvocMrHZmtThk9vmYdewSG5caoSkbR/w4/hKPcE8R5XzqiNXRWb6pnQ
 cmLkvGfpU3iSh48xoCF3IltiWMSUW0NU+oH3pIYfosX9pTxHEKZr4+iZrL+EQZ7AJvvN26KbZj4
 HolOcyrNwsW+CL2AKAzrXRflJI4ISWiPp3FMMnln9GL31r+f0OPHJoPvWZJC08oiVbw+G5cFko0
 M/LDRjxS3hbZQjf3hu4WSW+QUvK30OaVpSdvVkJxAVS+G0NwVhK7fuzyJZKKfNnN/0yJA47QeTA
 taTokrbYDDik/t95thN7AmYQKaMUzVomuf0GeIgg+5ZhXdsxoqom57A=
X-Received: by 2002:a05:600c:a03:b0:434:f7e3:bfbd with SMTP id
 5b1f17b1804b1-4389142e8b5mr278514765e9.23.1737733555850; 
 Fri, 24 Jan 2025 07:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHYcoJ39rm7gawbJbNWFUQOBEGFPj86Ylt2BpokstkF84V5QmwjWichPRMD70s0emuvSL/sA==
X-Received: by 2002:a05:600c:a03:b0:434:f7e3:bfbd with SMTP id
 5b1f17b1804b1-4389142e8b5mr278514425e9.23.1737733555431; 
 Fri, 24 Jan 2025 07:45:55 -0800 (PST)
Received: from localhost
 (p200300cbc719e000ca2c77c5de7dce89.dip0.t-ipconnect.de.
 [2003:cb:c719:e000:ca2c:77c5:de7d:ce89])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-438bd4fa57csm32121725e9.4.2025.01.24.07.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:45:54 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v2 7/7] physmem: teach cpu_memory_rw_debug() to write to more
 memory regions
Date: Fri, 24 Jan 2025 16:45:32 +0100
Message-ID: <20250124154533.3534250-8-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124154533.3534250-1-david@redhat.com>
References: <20250124154533.3534250-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/cpu-system.c    | 13 +++++++++----
 include/exec/memattrs.h |  5 ++++-
 include/exec/memory.h   |  3 ++-
 system/physmem.c        |  9 ++-------
 4 files changed, 17 insertions(+), 13 deletions(-)

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
diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index e27c18f3dc..14e0edaa58 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -26,7 +26,8 @@ typedef struct MemTxAttrs {
     /* Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
      * distinguish "all attributes deliberately clear" from
-     * "didn't specify" if necessary.
+     * "didn't specify" if necessary. "debug" can be set alongside
+     * "unspecified".
      */
     unsigned int unspecified:1;
     /*
@@ -50,6 +51,8 @@ typedef struct MemTxAttrs {
      * (see MEMTX_ACCESS_ERROR).
      */
     unsigned int memory:1;
+    /* Debug access that can even write to ROM. */
+    unsigned int debug:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index b3287518f0..2b9447ec8f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3008,7 +3008,8 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
     if (!memory_region_supports_direct_access(mr)) {
         return false;
     }
-    if (is_write) {
+    /* Debug access can write to ROM. */
+    if (is_write && !attrs.debug) {
         return !mr->readonly && !mr->rom_device;
     }
     return true;
diff --git a/system/physmem.c b/system/physmem.c
index 52b20b8ae5..f153f57666 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3572,13 +3572,8 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
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
2.47.1


