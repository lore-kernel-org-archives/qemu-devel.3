Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EB6CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGd-0006rb-4E; Sun, 05 Oct 2025 15:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFu-0004qH-6N
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFj-0006fN-H4
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9WvSj244bnTQx+NCrPES38aqSUsl9JKhLvBXSEeZN0=;
 b=g7Zi+NDnSRXQzCJe+8VaigYZfhUKavB4/z9pIYOLbDRNeASY3FfEzQ+YlvJi41iyAslQ4a
 gM8bEeqcxJzrcLmEYuykkE5Kzm/a2uLj0ka5jcZEPJVMPXjg724HgQTyVgiZGkWGgOYI/Q
 Auazndq0nP0/Kb0Skbmes2eZaMw/zm4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-coKXyuFXPp6gxs-QPOg0fQ-1; Sun, 05 Oct 2025 15:18:36 -0400
X-MC-Unique: coKXyuFXPp6gxs-QPOg0fQ-1
X-Mimecast-MFC-AGG-ID: coKXyuFXPp6gxs-QPOg0fQ_1759691915
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso22009325e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691915; x=1760296715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9WvSj244bnTQx+NCrPES38aqSUsl9JKhLvBXSEeZN0=;
 b=TOGnKNGDkINItWfRzyQT0dD/OliibejjT1mxjISlJC5i5f6MuS47bQ3UNV/0CTPpRe
 2ZSKIynPUY2MlD8H9oPMkEQEL7S013A9Rai3Ol3eZVtXlz2dIsHwK6g5g1tMX1WzFaFL
 Qg1RP2hd6Aby0nIlFgeUQ2hNYdPbVXq5/jHXqCLk1NuzSQVi+Yt7OhhF4qbjiFbKoxY/
 RF9oanGHR1XMUuG6MibJWG9Alp5jH8A+YWssXOro8g9h3YnvFeazDK0z1+ExH/29Pxlt
 YoKT99JdQw/JV7D2rqOhmELQ0YUJZrEBAIfjKLi8mMLcfq0S+mw1nedLE9Ko/2ZNPSMK
 dxzg==
X-Gm-Message-State: AOJu0Yw2+Qhllo5lRMvWvUFucFdxRf8WpqbvVHFzqwXC5Y5anaN9z7+7
 tfZ1pXVVT8U7IndUBULdnK2aISqTnQhZDt0TleTl/jTZig8xaxHsc40jvRydau1QYSzcrOwecTy
 6bjUTSdO0pMgber5iV7p3BKnHZCoJWHw60sFCO6PdOsULL0NZdg0DrbzFAfPdQoQZIXwbcCj4/t
 HGHXsnXKvm5rQcUonqAbLjquw9uiqvBOK6oQ==
X-Gm-Gg: ASbGncuU6xExe1VJgzOW7LtESTA/OTg+tkQtr8g9oZ8zy3S1uIoR2cyBUoty37aFLT2
 wR7aExC1lF1hW2jLwjUuBoPrTLpUs94Du8pwE4bK0dNfe0IWS7CFeYDDA/8Xn9ko8rs+WsNihAY
 ObIaejIKz6PV6ej0jAcdKacJmmTqcEuZObH8Y65rEznB3rCeAHTT1oEMBboEM7WVJDFB6HDQ0Kb
 bfXMEqR5p/mtEic0y+SyllhBaT/eo3S+Ldga3T/m0wZh5Y3wjtLtlZt08huAyFhwAJs6HGhBEad
 bBqAe72t09HYCmLkn0r0Ic2hI7N9H2xE2V5ZNcI=
X-Received: by 2002:a05:600c:3b16:b0:46e:502c:8d6a with SMTP id
 5b1f17b1804b1-46e7114e1dbmr63603545e9.25.1759691915084; 
 Sun, 05 Oct 2025 12:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTDzKhbmHa3yjDHhvm5nUqNg3dWGt5UTnWw4BUbMZxvwlOHpGQ3kvdxOx6yDmz0R7ZFhRlWQ==
X-Received: by 2002:a05:600c:3b16:b0:46e:502c:8d6a with SMTP id
 5b1f17b1804b1-46e7114e1dbmr63603345e9.25.1759691914543; 
 Sun, 05 Oct 2025 12:18:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e5fdsm125552985e9.6.2025.10.05.12.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:34 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 68/75] amd_iommu: Do not assume passthrough translation when
 DTE[TV]=0
Message-ID: <b53b9413f7708469f6940a690f81986a5f65d06a.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The AMD I/O Virtualization Technology (IOMMU) Specification (see Table
8: V, TV, and GV Fields in Device Table Entry), specifies that a DTE
with V=1, TV=0 does not contain a valid address translation information.
If a request requires a table walk, the walk is terminated when this
condition is encountered.

Do not assume that addresses for a device with DTE[TV]=0 are passed
through (i.e. not remapped) and instead terminate the page table walk
early.

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-20-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 95 +++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index e916dcb2be..1bda2a8ac3 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1722,51 +1722,60 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     uint64_t pte = dte[0], pte_addr, page_mask;
 
     /* make sure the DTE has TV = 1 */
-    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
-        level = get_pte_translation_mode(pte);
-        if (level >= 7) {
-            trace_amdvi_mode_invalid(level, addr);
-            return;
-        }
-        if (level == 0) {
-            goto no_remap;
-        }
-
-        /* we are at the leaf page table or page table encodes a huge page */
-        do {
-            pte_perms = amdvi_get_perms(pte);
-            present = pte & 1;
-            if (!present || perms != (perms & pte_perms)) {
-                amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
-                trace_amdvi_page_fault(addr);
-                return;
-            }
-
-            /* go to the next lower level */
-            pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
-            /* add offset and load pte */
-            pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
-            pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
-            if (!pte || (pte == (uint64_t)-1)) {
-                return;
-            }
-            oldlevel = level;
-            level = get_pte_translation_mode(pte);
-        } while (level > 0 && level < 7);
-
-        if (level == 0x7) {
-            page_mask = pte_override_page_mask(pte);
-        } else {
-            page_mask = pte_get_page_mask(oldlevel);
-        }
-
-        /* get access permissions from pte */
-        ret->iova = addr & page_mask;
-        ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
-        ret->addr_mask = ~page_mask;
-        ret->perm = amdvi_get_perms(pte);
+    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
+        /*
+         * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
+         * An IOMMU processing a request that requires a table walk terminates
+         * the walk when it encounters this condition. Do the same and return
+         * instead of assuming that the address is forwarded without translation
+         * i.e. the passthrough case, as it is done for the case where DTE[V]=0.
+         */
         return;
     }
+
+    level = get_pte_translation_mode(pte);
+    if (level >= 7) {
+        trace_amdvi_mode_invalid(level, addr);
+        return;
+    }
+    if (level == 0) {
+        goto no_remap;
+    }
+
+    /* we are at the leaf page table or page table encodes a huge page */
+    do {
+        pte_perms = amdvi_get_perms(pte);
+        present = pte & 1;
+        if (!present || perms != (perms & pte_perms)) {
+            amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+            trace_amdvi_page_fault(addr);
+            return;
+        }
+        /* go to the next lower level */
+        pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
+        /* add offset and load pte */
+        pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
+        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+        if (!pte) {
+            return;
+        }
+        oldlevel = level;
+        level = get_pte_translation_mode(pte);
+    } while (level > 0 && level < 7);
+
+    if (level == 0x7) {
+        page_mask = pte_override_page_mask(pte);
+    } else {
+        page_mask = pte_get_page_mask(oldlevel);
+    }
+
+    /* get access permissions from pte */
+    ret->iova = addr & page_mask;
+    ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
+    ret->addr_mask = ~page_mask;
+    ret->perm = amdvi_get_perms(pte);
+    return;
+
 no_remap:
     ret->iova = addr & AMDVI_PAGE_MASK_4K;
     ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
-- 
MST


