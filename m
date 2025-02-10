Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AC0C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPS7-0007Ed-Gu; Mon, 10 Feb 2025 03:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRo-0006VF-QI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRm-00047Z-SC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rC/aAIY4bXHpHCmeTCgc5miTxFonU93tbQUmgYf9EM=;
 b=SYmXwpoIBgneCs8rOoTws3hcMXPbPUa/4XNA70lM5XY4pFnOU9w+JVPn1sRXpOGAzl82ma
 jHhLV7HVg0L2JOyE4Grh1o4g2cDWqTOjLCFW5GzfPVaCxp7nN+ofBvrvL6kLUNZRDisgdd
 BJqtAqfXsdaLJyS16GErfMLAhd0aVmk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-pbjbCsgRPCK8mQV0Tajtgw-1; Mon, 10 Feb 2025 03:47:14 -0500
X-MC-Unique: pbjbCsgRPCK8mQV0Tajtgw-1
X-Mimecast-MFC-AGG-ID: pbjbCsgRPCK8mQV0Tajtgw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38de0201961so325921f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177233; x=1739782033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rC/aAIY4bXHpHCmeTCgc5miTxFonU93tbQUmgYf9EM=;
 b=OfJf8ctHH2k6KIOKedmCVn7I6ET3mGheAK6AOS0lFko71XPiD8QBshSylOfTW8bEzD
 3wgGfVtD/gI8qDzTAOZLnZK70tTJawJ0VuY12dizaC+AM2glqprNXHpLKilVwWROuCtA
 KSh8Yh3Vu+vie3gQ43+S8+vaYKCivctBinpMWmxlubDdT6dZRKW4TH0aPrGmjMapi5oB
 V2etVawZjsD5jOAVLqJp0V7q00i0GFR76fbjoSUDC5mYyTnXQ1YB1jWL/Qg167ZM19xb
 KUk4cK+wN2g3yhrThpMTcUbmjDhcq9jnVW31dDWxtSAbiCSLLgLnT1XMv6x5swiC0ll5
 BZ4w==
X-Gm-Message-State: AOJu0YypvbgXB2w5LGhddS9fuA6hPRifnxBKc1+sNGPneDKc1uv3os4m
 KmS3swuaZgK/00aFNlW+J3DQWCqTHlaMl5W6QOOS+vWDDs/YI4jy2kbKMdqn/hwkZyaZ+WoSbEq
 qs63jsFJq/QpVEwnORHU72Oo2rEc7EOYDJ1yqZWdYIMLrrkqQgwuELrkSnuwfwyxyoUtCaTDbBH
 kEYfJnVQvtH//dAjkrsu9J650Gw6o/CjZt
X-Gm-Gg: ASbGncug3Z2S5DjlWs1D7za672DvqXeOY38Laizk6eiv3SdJVPInS9Q8kLOi+9FkC0b
 1bT+KgE6ffLFGl58Rt8s/Gp49Lal5hvM1Xko0/KPsmYk3PtT4xhfvImMAjEzaYwOZCwJE8kZYRj
 LXzhR//Q1q4ON8ERpStqxWhPYryyYjFwd5Wgg+dwYCqA77QFzC/QqWtWpQZ53/cdXBQt1r5/sBM
 +kcXWC7Q8tH6USlV+3NG7Rlafw5dd2GtvuMT9JWKUfJ9S/Ikbu2JB4/Ely/0bIRYGWD/VKsRo/R
 f8uLbw8I/Cg6EncvikD9eQy8AHg0yMaG22IPV3H5uOBXVTbbVJ18VBtC4dJnGaTczw==
X-Received: by 2002:a05:6000:4010:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-38dc8d9b92dmr8412932f8f.1.1739177232836; 
 Mon, 10 Feb 2025 00:47:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECcBoKP/sF3v8PkI2LBIugtYE6I6jRzXGQ+B3MPKzQIR+gy4Pfo84cEN0DTa4LJbgv3YTStw==
X-Received: by 2002:a05:6000:4010:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-38dc8d9b92dmr8412893f8f.1.1739177232393; 
 Mon, 10 Feb 2025 00:47:12 -0800 (PST)
Received: from localhost
 (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de.
 [2003:cb:c734:b800:12c4:65cd:348a:aee6])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38dcb55b7a5sm8896013f8f.14.2025.02.10.00.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:47:11 -0800 (PST)
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
Subject: [PATCH v3 7/7] physmem: teach cpu_memory_rw_debug() to write to more
 memory regions
Date: Mon, 10 Feb 2025 09:46:48 +0100
Message-ID: <20250210084648.33798-8-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
References: <20250210084648.33798-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
diff --git a/system/physmem.c b/system/physmem.c
index 9766c6d2e0..486316b651 100644
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
2.48.1


