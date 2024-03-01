Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF756C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBy8-0005RB-TU; Fri, 01 Mar 2024 18:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxh-0004s4-FX
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:42 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxf-0004ES-VQ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:41 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso24887475ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334397; x=1709939197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HEYpUbYOjLF3aHdvtZVlKWz9YeEEY+0zYSzPOHYy/W8=;
 b=pmFLZGTXXZXzdF5qfX0OU4tBoQ8yXXaL4zaJKuPkSw2ygntThzwFtiqu6BSQh0Jm1Y
 Nc8VZmaFnsEPZv8gdfqYFofoPQZkRlgyJ5Er9i1j6g1zn28zeXj9vsDPwpYJnBSzCuo1
 bBTSWlNUqaAQSuuZaMOis9pONSeVpsV9UF5YBh4Xo5AOJm7zDDlFknQxcU7flzyVFWu+
 58hEEbiqZnswvMOaXpxiiPdqL3OdHBjefGDcuwRT1v/tUTkcZ4LXJ0uTQko+F9Almowm
 FxNWZ33FPAfF1d8e/jFkBUxVNukf0QzbUcsEm7Yb7lUc8ASlzg70+lUld1XbB6Ws9F92
 aV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334397; x=1709939197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEYpUbYOjLF3aHdvtZVlKWz9YeEEY+0zYSzPOHYy/W8=;
 b=ICHSrWGyipgiYsnLxr8MnJQcAr9zKmT5nlUv5BPSegczwX0EME9fDOYq+Q5LTolXKv
 CsWXxd1RlXOCKiKmHgxvl0d9WyxRJcQA++5JpdpFTsZ6B2nzd1AspMiy3wTKlGbj2T7B
 kDPMiJX8slUVrTEA6sPBHSbZv0EvtQhvP+vjaMjqN0FioPqRnpVwOli1+faRYJqd+YKz
 qfSWf5ydL5+tlo5iPuEPK9ESnLe+ED1V+I76TKn4a1qJ0uaJhmhWG6rFnvrOaQw+8e7s
 pTJ+cKI1RnTP8k6eS2LmmirrOnD32C6rJOdJ0EJP8E7SJm5ZEBeP3wFgUL8YvoKHKNKl
 vBwQ==
X-Gm-Message-State: AOJu0YxBGuMfvFWCXrdG7/HKxFH/MyF5HiurYcS6vZICWvBwuHCg9s1t
 vNQ0yXiPiflQYeH5GduUFOd7DssY6J5aDlxOgcYt8LKM5XMLh2YvcUd1P375v9h6ryLNUYs2tdP
 z
X-Google-Smtp-Source: AGHT+IEd0beH7QMF02Nz3Zan/ETCnbSA2HLemCUmoOCUgdlpheKv8HIgh85zS/4mYsFXA4prnN0THw==
X-Received: by 2002:a17:902:e744:b0:1dc:d722:4c08 with SMTP id
 p4-20020a170902e74400b001dcd7224c08mr3969526plf.5.1709334397658; 
 Fri, 01 Mar 2024 15:06:37 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/60] linux-user/elfload: Simplify vma_dump_size
Date: Fri,  1 Mar 2024 13:05:31 -1000
Message-Id: <20240301230619.661008-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use the flags that we've already saved in order to test
accessibility.  Use g2h_untagged and compare guest memory
directly instead of copy_from_user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 491e754f72..47b5ce3005 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4166,37 +4166,23 @@ static int vma_get_mapping_count(const struct mm_struct *mm)
  */
 static abi_ulong vma_dump_size(const struct vm_area_struct *vma)
 {
-    /* if we cannot even read the first page, skip it */
-    if (!access_ok_untagged(VERIFY_READ, vma->vma_start, TARGET_PAGE_SIZE))
-        return (0);
+    /* The area must be readable. */
+    if (!(vma->vma_flags & PROT_READ)) {
+        return 0;
+    }
 
     /*
      * Usually we don't dump executable pages as they contain
      * non-writable code that debugger can read directly from
-     * target library etc.  However, thread stacks are marked
-     * also executable so we read in first page of given region
-     * and check whether it contains elf header.  If there is
-     * no elf header, we dump it.
+     * target library etc. If there is no elf header, we dump it.
      */
-    if (vma->vma_flags & PROT_EXEC) {
-        char page[TARGET_PAGE_SIZE];
-
-        if (copy_from_user(page, vma->vma_start, sizeof (page))) {
-            return 0;
-        }
-        if ((page[EI_MAG0] == ELFMAG0) &&
-            (page[EI_MAG1] == ELFMAG1) &&
-            (page[EI_MAG2] == ELFMAG2) &&
-            (page[EI_MAG3] == ELFMAG3)) {
-            /*
-             * Mappings are possibly from ELF binary.  Don't dump
-             * them.
-             */
-            return (0);
-        }
+    if (!(vma->vma_flags & PROT_WRITE) &&
+        (vma->vma_flags & PROT_EXEC) &&
+        memcmp(g2h_untagged(vma->vma_start), ELFMAG, SELFMAG) == 0) {
+        return 0;
     }
 
-    return (vma->vma_end - vma->vma_start);
+    return vma->vma_end - vma->vma_start;
 }
 
 static int vma_walker(void *priv, target_ulong start, target_ulong end,
-- 
2.34.1


