Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4117C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMj-0006Y2-VZ; Tue, 05 Mar 2024 02:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLy-00068J-LK
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:48 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLx-0005rT-40
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:46 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso256654b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624203; x=1710229003;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6W1zD/8uLpCTCiaWLd6Xa/456MMTWCq7KFm2ch3UxRE=;
 b=bicB6OjJwL6Scpy8afptD8MEZaNuqZOIeIgtdg9Lt8E6ZitX88OCn3vE16gLniZwdg
 tT/EfmbXiA5X+Np/8XZniPi2l/8EWARVMIJzv133qzwT+ZQrZJgq/rMQVQkTTme1JW4U
 /ihgwEZYLhEO25m+kT0r7dNOgUWh2NzVP1XadpNLJjN1khWjSugDoVlB4uh2lrhaBSP6
 /kMmulcH9s8LgNt0rak33Uas5PdYLTCcnlaFz5JnYTndfg1cJTUs/KKpgpXK6I1nHu10
 0aLsxVS4DHGx3QtHBwK2efh0wx32j9UcPCkPbx0RapwroEx8zHQbPkgnsMV32JFnGKKN
 HMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624203; x=1710229003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6W1zD/8uLpCTCiaWLd6Xa/456MMTWCq7KFm2ch3UxRE=;
 b=S3utQnRvp3ADj4UbCqnWEbElZxDev1fElPVRSr+tYHmwNnLkXKY0sToJ3TNyjJBGxt
 BM/vnvnJXTUqRyW7IANlrJyFwKUPv5YtYJlxbvb57xmGwG+5Qw7l7awZF4VvwS+YmCNP
 QkW3DUoFIH3M2TRFmIY9SHQYHHd6HsfGC8FhwrpAFX79xumMJekpfqYSDrSvEl34A5Ow
 BbPGdhVnI1ypDUgQRTsUqn55U+gAVgiW1PfbC7SzQDOAOiCaGvOT38ySgM/o7EGk7h9T
 uPRa80wHS2OXjdyLM9by4jfxFRJN/QMo0NFtyAzVvjUjcpBapgQA40+0fsWgaUQmbjMl
 CQxQ==
X-Gm-Message-State: AOJu0YyQX58f61HpTzws3aA5xaTNUPds2mcX7XQwor4QEJ3K1sOzZes5
 Yd+t0CwF1d4TX8We9CLgozgeSY6RhKn6Kn88R1UIszO5PbVtDOp8PeHzlmjy/+UkSoW0NdHRVQt
 c
X-Google-Smtp-Source: AGHT+IHtVJNQXYKW6U8wBfnPulRZZwrAdj4fkR6CRZ9kLD52CODxLMuOVL0WDLtZoCM/4REvgNZtwg==
X-Received: by 2002:a05:6a20:da8f:b0:1a1:1fee:5fea with SMTP id
 iy15-20020a056a20da8f00b001a11fee5feamr1196246pzb.12.1709624203672; 
 Mon, 04 Mar 2024 23:36:43 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 x29-20020aa79a5d000000b006e3f09fd6a4sm8558372pfj.170.2024.03.04.23.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:43 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:22 +0900
Subject: [PATCH v2 05/13] contrib/elf2dmp: Always check for PA resolution
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-5-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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
index c995c723ae80..e01860d15b07 100644
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
 
+static bool pa_space_read64(struct pa_space *ps, uint64_t pa, uint64_t *value)
+{
+    uint64_t *resolved = pa_space_resolve(ps, pa);
+
+    if (!resolved) {
+        return false;
+    }
+
+    *value = *resolved;
+
+    return true;
+}
+
 static void pa_block_align(struct pa_block *b)
 {
     uint64_t low_align = ((b->paddr - 1) | ELF2DMP_PAGE_MASK) + 1 - b->paddr;
@@ -106,19 +119,20 @@ void va_space_create(struct va_space *vs, struct pa_space *ps, uint64_t dtb)
     va_space_set_dtb(vs, dtb);
 }
 
-static uint64_t get_pml4e(struct va_space *vs, uint64_t va)
+static bool get_pml4e(struct va_space *vs, uint64_t va, uint64_t *value)
 {
     uint64_t pa = (vs->dtb & 0xffffffffff000) | ((va & 0xff8000000000) >> 36);
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pa);
+    return pa_space_read64(vs->ps, pa, value);
 }
 
-static uint64_t get_pdpi(struct va_space *vs, uint64_t va, uint64_t pml4e)
+static bool get_pdpi(struct va_space *vs, uint64_t va, uint64_t pml4e,
+                    uint64_t *value)
 {
     uint64_t pdpte_paddr = (pml4e & 0xffffffffff000) |
         ((va & 0x7FC0000000) >> 27);
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pdpte_paddr);
+    return pa_space_read64(vs->ps, pdpte_paddr, value);
 }
 
 static uint64_t pde_index(uint64_t va)
@@ -131,11 +145,12 @@ static uint64_t pdba_base(uint64_t pdpe)
     return pdpe & 0xFFFFFFFFFF000;
 }
 
-static uint64_t get_pgd(struct va_space *vs, uint64_t va, uint64_t pdpe)
+static bool get_pgd(struct va_space *vs, uint64_t va, uint64_t pdpe,
+                   uint64_t *value)
 {
     uint64_t pgd_entry = pdba_base(pdpe) + pde_index(va) * 8;
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pgd_entry);
+    return pa_space_read64(vs->ps, pgd_entry, value);
 }
 
 static uint64_t pte_index(uint64_t va)
@@ -148,11 +163,12 @@ static uint64_t ptba_base(uint64_t pde)
     return pde & 0xFFFFFFFFFF000;
 }
 
-static uint64_t get_pte(struct va_space *vs, uint64_t va, uint64_t pgd)
+static bool get_pte(struct va_space *vs, uint64_t va, uint64_t pgd,
+                   uint64_t *value)
 {
     uint64_t pgd_val = ptba_base(pgd) + pte_index(va) * 8;
 
-    return *(uint64_t *)pa_space_resolve(vs->ps, pgd_val);
+    return pa_space_read64(vs->ps, pgd_val, value);
 }
 
 static uint64_t get_paddr(uint64_t va, uint64_t pte)
@@ -184,13 +200,11 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
 {
     uint64_t pml4e, pdpe, pgd, pte;
 
-    pml4e = get_pml4e(vs, va);
-    if (!is_present(pml4e)) {
+    if (!get_pml4e(vs, va, &pml4e) || !is_present(pml4e)) {
         return INVALID_PA;
     }
 
-    pdpe = get_pdpi(vs, va, pml4e);
-    if (!is_present(pdpe)) {
+    if (!get_pdpi(vs, va, pml4e, &pdpe) || !is_present(pdpe)) {
         return INVALID_PA;
     }
 
@@ -198,8 +212,7 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
         return get_1GB_paddr(va, pdpe);
     }
 
-    pgd = get_pgd(vs, va, pdpe);
-    if (!is_present(pgd)) {
+    if (!get_pgd(vs, va, pdpe, &pgd) || !is_present(pgd)) {
         return INVALID_PA;
     }
 
@@ -207,8 +220,7 @@ static uint64_t va_space_va2pa(struct va_space *vs, uint64_t va)
         return get_2MB_paddr(va, pgd);
     }
 
-    pte = get_pte(vs, va, pgd);
-    if (!is_present(pte)) {
+    if (!get_pte(vs, va, pgd, &pte) || !is_present(pte)) {
         return INVALID_PA;
     }
 

-- 
2.44.0


