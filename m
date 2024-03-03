Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B04C5475B
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgjR7-0002GX-EY; Sun, 03 Mar 2024 05:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjR6-0002G4-52
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:16 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjR4-0001lO-SP
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:15 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so3343542a12.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 02:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709463073; x=1710067873;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nyTUdQB4Cl6gt8pecVagVZSZXNdna6Waf3JQSWyiOlc=;
 b=cPbFKGgs5hW3TR5OpxEdHzHfOEwkCxXY8BrGbhuCrSQdgX/EGnrlE0kQxg+6ieMAFi
 Qr/OYvWYwCQ8AOTbhYAT1zn/ivUtv1azmcQjzDETRf0IQWnn3A8rrbBaQJhK+DyS7lTq
 CtTSkDuuDoQlDhmM4fY3cYvMYauM9hn90KfZvE8zAB+t35ezIPvH+u/fxYCeiLfdRvVf
 j/pJLCQ6uOkNEYy998UCYKqYFG0dXk5rBIcPRd71q8GoUGz9RtnI0XcHxRsN2cnFo48G
 CcNsNeJru7q73ydjNTMEWWW2P3R511W4/LCFIN8S3QWLtDZ2d7jyeVTm4/RsA7E4dNBM
 Zv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709463073; x=1710067873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nyTUdQB4Cl6gt8pecVagVZSZXNdna6Waf3JQSWyiOlc=;
 b=HLIcNJ96X54P2b0lWyvQz6V//2YDh/BnjjSL32XByzGO+XDleDg4o2FihzKNAwQwLF
 /gga5xlOR81HDGC38oD8tDxp8FQjikPcaDoSF1mh1nyT/8Es7WXC4LvsZ9tQ+zOw3SS0
 Is7v6QZbuBfr7EB1j3PBbV2uBCW9K9rrRNjJPF0sW739gxsGfBl1AscMCau7cflvD7e6
 Q55o2c+wmhA8ox1f/EyUQxFgkM3kYAwBQj9z9yuZ+IXSy2SEy+22qxFq37bGNsSuch4A
 JPVrmR5PAUmAUJhfY20e5ZQI2xoizCnzZz6369NSo9NbkbuqgDZSt/EJ/V4Vj9MKD7u6
 mOJQ==
X-Gm-Message-State: AOJu0YyH+PqAz93QczURnjDQJBlx4aiMHTxyheLK5nwmf6mab2u8SDTF
 DOpBZlheroU+NVyxS9p4C9DHNfk7fuY9uPnODJM1PjoFTloWWoYxvB9yNVLfoQSrPxOmTpu5SjK
 k
X-Google-Smtp-Source: AGHT+IGLbvF6FQNEyp6HcSPDrwmnb2srrduPn775HPtwW3D5RmtXDbUaT9LtEl+5muFKkrMUUtgj7Q==
X-Received: by 2002:a17:902:dac4:b0:1dc:ca43:307 with SMTP id
 q4-20020a170902dac400b001dcca430307mr9094105plx.60.1709463073355; 
 Sun, 03 Mar 2024 02:51:13 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 k15-20020a170902ba8f00b001dc91b4081dsm6431936pls.271.2024.03.03.02.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 02:51:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 03 Mar 2024 19:50:35 +0900
Subject: [PATCH 1/7] contrib/elf2dmp: Always check for PA resolution
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-elf2dmp-v1-1-bea6649fe3e6@daynix.com>
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Not checking PA resolution failure can result in NULL deference.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/addrspace.c | 46 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 6f608a517b1e..980a7aa5f8fb 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -22,7 +22,7 @@ static struct pa_block *pa_space_find_block(struct pa_space *ps, uint64_t pa)
     return NULL;
 }
 
-static uint8_t *pa_space_resolve(struct pa_space *ps, uint64_t pa)
+static void *pa_space_resolve(struct pa_space *ps, uint64_t pa)
 {
     struct pa_block *block = pa_space_find_block(ps, pa);
 
@@ -33,6 +33,19 @@ static uint8_t *pa_space_resolve(struct pa_space *ps, uint64_t pa)
     return block->addr + (pa - block->paddr);
 }
 
+static int pa_space_read64(struct pa_space *ps, uint64_t pa, uint64_t *value)
+{
+    uint64_t *resolved = pa_space_resolve(ps, pa);
+
+    if (!resolved) {
+        return 1;
+    }
+
+    *value = *resolved;
+
+    return 0;
+}
+
 static void pa_block_align(struct pa_block *b)
 {
     uint64_t low_align = ((b->paddr - 1) | ELF2DMP_PAGE_MASK) + 1 - b->paddr;
@@ -108,19 +121,20 @@ void va_space_create(struct va_space *vs, struct pa_space *ps, uint64_t dtb)
     va_space_set_dtb(vs, dtb);
 }
 
-static uint64_t get_pml4e(struct va_space *vs, uint64_t va)
+static int get_pml4e(struct va_space *vs, uint64_t va, uint64_t *value)
 {
     uint64_t pa = (vs->dtb & 0xffffffffff000) | ((va & 0xff8000000000) >> 36);
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pa);
+    return pa_space_read64(vs->ps, pa, value);
 }
 
-static uint64_t get_pdpi(struct va_space *vs, uint64_t va, uint64_t pml4e)
+static int get_pdpi(struct va_space *vs, uint64_t va, uint64_t pml4e,
+                    uint64_t *value)
 {
     uint64_t pdpte_paddr = (pml4e & 0xffffffffff000) |
         ((va & 0x7FC0000000) >> 27);
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pdpte_paddr);
+    return pa_space_read64(vs->ps, pdpte_paddr, value);
 }
 
 static uint64_t pde_index(uint64_t va)
@@ -133,11 +147,12 @@ static uint64_t pdba_base(uint64_t pdpe)
     return pdpe & 0xFFFFFFFFFF000;
 }
 
-static uint64_t get_pgd(struct va_space *vs, uint64_t va, uint64_t pdpe)
+static int get_pgd(struct va_space *vs, uint64_t va, uint64_t pdpe,
+                   uint64_t *value)
 {
     uint64_t pgd_entry = pdba_base(pdpe) + pde_index(va) * 8;
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pgd_entry);
+    return pa_space_read64(vs->ps, pgd_entry, value);
 }
 
 static uint64_t pte_index(uint64_t va)
@@ -150,11 +165,12 @@ static uint64_t ptba_base(uint64_t pde)
     return pde & 0xFFFFFFFFFF000;
 }
 
-static uint64_t get_pte(struct va_space *vs, uint64_t va, uint64_t pgd)
+static int get_pte(struct va_space *vs, uint64_t va, uint64_t pgd,
+                   uint64_t *value)
 {
     uint64_t pgd_val = ptba_base(pgd) + pte_index(va) * 8;
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pgd_val);
+    return pa_space_read64(vs->ps, pgd_val, value);
 }
 
 static uint64_t get_paddr(uint64_t va, uint64_t pte)
@@ -186,13 +202,11 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
 {
     uint64_t pml4e, pdpe, pgd, pte;
 
-    pml4e = get_pml4e(vs, va);
-    if (!is_present(pml4e)) {
+    if (get_pml4e(vs, va, &pml4e) || !is_present(pml4e)) {
         return INVALID_PA;
     }
 
-    pdpe = get_pdpi(vs, va, pml4e);
-    if (!is_present(pdpe)) {
+    if (get_pdpi(vs, va, pml4e, &pdpe) || !is_present(pdpe)) {
         return INVALID_PA;
     }
 
@@ -200,8 +214,7 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
         return get_1GB_paddr(va, pdpe);
     }
 
-    pgd = get_pgd(vs, va, pdpe);
-    if (!is_present(pgd)) {
+    if (get_pgd(vs, va, pdpe, &pgd) || !is_present(pgd)) {
         return INVALID_PA;
     }
 
@@ -209,8 +222,7 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
         return get_2MB_paddr(va, pgd);
     }
 
-    pte = get_pte(vs, va, pgd);
-    if (!is_present(pte)) {
+    if (get_pte(vs, va, pgd, &pte) || !is_present(pte)) {
         return INVALID_PA;
     }
 

-- 
2.44.0


