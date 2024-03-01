Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80554C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxi-0004t5-VN; Fri, 01 Mar 2024 18:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxX-0004qU-Mt
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:31 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxW-0004Co-4N
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:31 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so23771625ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334388; x=1709939188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=keqqLzVNAo4uH25B4sgF/a/mk1kxuvixDsagaZwoXEA=;
 b=PB9EjzNw4+NNo/r7ILU/XW4K8BIXsGue2sjOwBuYukLQAdy0Ib67UueXkqSiXx8aB+
 VLOC6soi0HY9DJGoHwzXkVr044D82ymw57jeXGD61FYTqzpl0C3T2zyTTOW+aWoyNOob
 Bl8HJ8jz9bTrz5rv1CJ/FfB4P+2sPqXmtIIGPvT6C1B7WUu+y1RW4tFQmfTyt0rrwyXJ
 /lMaWCJmvhMpqgjjzJ3cFOVx+wh3Kz4KZCQzordgYufAhEdI2a62Hm4YrUVEOM07pmM4
 69cG31S462xYENZ4CVwtgxd7/1LxvxGz6tl9Q1YEQgAMnRn6iIZwsTEKhOh1z0jGF46N
 qhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334388; x=1709939188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keqqLzVNAo4uH25B4sgF/a/mk1kxuvixDsagaZwoXEA=;
 b=BBTVgrwjERFMD0WzpQp17D+q46zWc4St2LlXNRZXkHf4D8s6heckFZ1hGCgJygtDgP
 m4oM9acC8+FlO0RLfNdaBMV3IWC8gVDO1SHQjC1L/aqhyzIkuJles/Bdlu7Xb/OcChnm
 hFvf/kz2cD7RobvFMI66VHV/utCJycDVHSFF0Ta0EJooFlGfo+a5ewHUjFewAHkLQvr4
 mkMMdORyK6SNMnu00XIwE0L8bcZgzIbcXupFC0ZWY6+GOh7TlCFJgX6JsWK8U14RCZsd
 upqNYnRwpxEsmwMWyTWEmeUct6wXMaO+WvWPFV4dsKqrqeEibrfjYQDdZ4BcqsivJYr0
 w4VA==
X-Gm-Message-State: AOJu0YzK+6igmV5yJK7uCFQaPSzadskPRi5x+5qITOxThSBMKJ7Uxyec
 UoURVNNCB9VAfBJaBtBeV/6y+8pdCxOQhcrLb1X7M461ALFODEWB0HAd7a2gaLHYWA8fqLj5Lrh
 3
X-Google-Smtp-Source: AGHT+IGSqzanFoyo3BGVUsOeqWu1YHLIOlVtTGEdsd+m0TdUJ+wOn5LN80SQbgUAO5mVZjIH3zM5gQ==
X-Received: by 2002:a17:903:190:b0:1db:b8dc:a016 with SMTP id
 z16-20020a170903019000b001dbb8dca016mr4261042plg.7.1709334387715; 
 Fri, 01 Mar 2024 15:06:27 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/60] linux-user/elfload: Stack allocate struct mm_struct
Date: Fri,  1 Mar 2024 13:05:23 -1000
Message-Id: <20240301230619.661008-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Ignoring the fact that g_malloc cannot fail, the structure
is quite small and might as well be allocated locally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cc43487a37..98b82b1a49 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4099,7 +4099,7 @@ struct mm_struct {
     int mm_count;           /* number of mappings */
 };
 
-static struct mm_struct *vma_init(void);
+static void vma_init(struct mm_struct *);
 static void vma_delete(struct mm_struct *);
 static int vma_add_mapping(struct mm_struct *, target_ulong,
                            target_ulong, abi_ulong);
@@ -4174,17 +4174,10 @@ static inline void bswap_note(struct elf_note *en) { }
  * thread that received the signal is stopped.
  */
 
-static struct mm_struct *vma_init(void)
+static void vma_init(struct mm_struct *mm)
 {
-    struct mm_struct *mm;
-
-    if ((mm = g_malloc(sizeof (*mm))) == NULL)
-        return (NULL);
-
     mm->mm_count = 0;
     QTAILQ_INIT(&mm->mm_mmap);
-
-    return (mm);
 }
 
 static void vma_delete(struct mm_struct *mm)
@@ -4195,7 +4188,6 @@ static void vma_delete(struct mm_struct *mm)
         QTAILQ_REMOVE(&mm->mm_mmap, vma, vma_link);
         g_free(vma);
     }
-    g_free(mm);
 }
 
 static int vma_add_mapping(struct mm_struct *mm, target_ulong start,
@@ -4638,7 +4630,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     struct elfhdr elf;
     struct elf_phdr phdr;
     struct rlimit dumpsize;
-    struct mm_struct *mm = NULL;
+    struct mm_struct mm;
     off_t offset = 0, data_offset = 0;
     int segs = 0;
     int fd = -1;
@@ -4664,11 +4656,10 @@ static int elf_core_dump(int signr, const CPUArchState *env)
      * set up structure containing this information.  After
      * this point vma_xxx functions can be used.
      */
-    if ((mm = vma_init()) == NULL)
-        goto out;
+    vma_init(&mm);
 
-    walk_memory_regions(mm, vma_walker);
-    segs = vma_get_mapping_count(mm);
+    walk_memory_regions(&mm, vma_walker);
+    segs = vma_get_mapping_count(&mm);
 
     /*
      * Construct valid coredump ELF header.  We also
@@ -4701,7 +4692,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
      * Write program headers for memory regions mapped in
      * the target process.
      */
-    for (vma = vma_first(mm); vma != NULL; vma = vma_next(vma)) {
+    for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
         (void) memset(&phdr, 0, sizeof (phdr));
 
         phdr.p_type = PT_LOAD;
@@ -4738,7 +4729,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     /*
      * Finally we can dump process memory into corefile as well.
      */
-    for (vma = vma_first(mm); vma != NULL; vma = vma_next(vma)) {
+    for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
         abi_ulong addr;
         abi_ulong end;
 
@@ -4767,8 +4758,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
  out:
     free_note_info(&info);
-    if (mm != NULL)
-        vma_delete(mm);
+    vma_delete(&mm);
     (void) close(fd);
 
     if (errno != 0)
-- 
2.34.1


