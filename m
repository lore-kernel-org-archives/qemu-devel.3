Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6E6D597A5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 20:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAxea-0001IT-O2; Tue, 12 Nov 2024 15:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeV-0001HP-9D
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:23 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeK-0008Ss-8w
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:16 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e2e23f2931so4922781a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731443882; x=1732048682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u0kRCYJEdfCPc7Ck3L3jOULPW0HIyB/R3/8bipse23E=;
 b=hsZ7sJHeYTDFO5O0gJTT/maZgWLqsyBpBvHS7VWGMf7Qsh/UqejeY2Wi+whOpCjKtL
 pWQ7x63oAQ/SjLxRpPrY78o4FSv7XeNj1bsqHULyhnYhxeXn5d3GV59X14iYnlELu127
 1qic6BRDFNU4J2A4O8x7ntvrNo0dMEUQzx487xkO3ZoNUZZcT7l/Sy3C2Z4bd48Eqbhz
 sksMNffpjdkLxX2AIzqlAQI0e5Z2rrbkaRPs/sXOi1KO78U0jxu0KmtZ/jQ3okHbgJ78
 9qA3aYAsfB1/K5sM6f0Kr8G62ZxkxL+MXQHdj4lj/e/fqL+Qg2vxQ3RPtsJJHQFi+5WQ
 48GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731443882; x=1732048682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0kRCYJEdfCPc7Ck3L3jOULPW0HIyB/R3/8bipse23E=;
 b=UwvZ6aPZctHcSrRLIvs3mGcDXn4VQnNjSGmKF2TNGkKN6xnzfR5B9PTLD9knCtbER0
 X1SEMvnE+A8lrFhk2K9Gr0L2gXWm44WCv9ybbYxTBhOgubcxuxG0M82Dn8u2+VFQYKf5
 bsAxPor3Q98MTKNJD1eUn0WJ5mDQadrT4bn4EDFsvo1Y/BuUTSufcCmMHiBpc8SLaUpe
 qhB8WrAqybP48ZSIGKrk9LqELDwtxrz1pxFWLXo3oy0Z4GszWdnBIEacWmH2CHH0S/5W
 8I2mp+zWD/KApzp7b7vTsGyw9v0P2wF0x2HuW0za3akvJBbSSsjtOTqANEvc3PDo7hz8
 nk9g==
X-Gm-Message-State: AOJu0YwY427oIDzMJiUBEXmM3/695m8THzcalD5X4jW+ZBRY0ON3yclp
 6vXgwjkr/e99sJUq56fZqGFmoe23WfGm0MdVGlhG2wXPCsaUMsRZsSJ+J7Lrln7Ntk3w84/O1vq
 1
X-Google-Smtp-Source: AGHT+IG+PusSF65DKFR2hLTKOhjc526pPP5zmfyLBEsSjciTtt65OE8TEDaqJ3a622vtVtknClVFHw==
X-Received: by 2002:a17:90b:1b46:b0:2e0:9d3e:bc2a with SMTP id
 98e67ed59e1d1-2e9b1784258mr21335772a91.32.1731443882158; 
 Tue, 12 Nov 2024 12:38:02 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3894192sm9860a91.21.2024.11.12.12.38.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 12:38:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] linux-user: Honor elf alignment when placing images
Date: Tue, 12 Nov 2024 12:37:52 -0800
Message-ID: <20241112203757.804320-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112203757.804320-1-richard.henderson@linaro.org>
References: <20241112203757.804320-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Most binaries don't actually depend on more than page alignment,
but any binary can request it.  Not honoring this was a bug.

This became obvious when gdb reported

    Failed to read a valid object file image from memory

when examining some vdso which are marked as needing more
than page alignment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d6ad77d27d..90e79a01b4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3179,7 +3179,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
                            char **pinterp_name)
 {
     g_autofree struct elf_phdr *phdr = NULL;
-    abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
+    abi_ulong load_addr, load_bias, loaddr, hiaddr, error, align;
+    size_t reserve_size, align_size;
     int i, prot_exec;
     Error *err = NULL;
 
@@ -3263,6 +3264,9 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     load_addr = loaddr;
 
+    align = pow2ceil(info->alignment);
+    info->alignment = align;
+
     if (pinterp_name != NULL) {
         if (ehdr->e_type == ET_EXEC) {
             /*
@@ -3271,8 +3275,6 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              */
             probe_guest_base(image_name, loaddr, hiaddr);
         } else {
-            abi_ulong align;
-
             /*
              * The binary is dynamic, but we still need to
              * select guest_base.  In this case we pass a size.
@@ -3290,10 +3292,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              * Since we do not have complete control over the guest
              * address space, we prefer the kernel to choose some address
              * rather than force the use of LOAD_ADDR via MAP_FIXED.
-             * But without MAP_FIXED we cannot guarantee alignment,
-             * only suggest it.
              */
-            align = pow2ceil(info->alignment);
             if (align) {
                 load_addr &= -align;
             }
@@ -3317,13 +3316,35 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    load_addr = target_mmap(load_addr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
+    reserve_size = (size_t)hiaddr - loaddr + 1;
+    align_size = reserve_size;
+
+    if (ehdr->e_type != ET_EXEC && align > qemu_real_host_page_size()) {
+        align_size += align - 1;
+    }
+
+    load_addr = target_mmap(load_addr, align_size, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
                             (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
                             -1, 0);
     if (load_addr == -1) {
         goto exit_mmap;
     }
+
+    if (align_size != reserve_size) {
+        abi_ulong align_addr = ROUND_UP(load_addr, align);
+        abi_ulong align_end = align_addr + reserve_size;
+        abi_ulong load_end = load_addr + align_size;
+
+        if (align_addr != load_addr) {
+            target_munmap(load_addr, align_addr - load_addr);
+        }
+        if (align_end != load_end) {
+            target_munmap(align_end, load_end - align_end);
+        }
+        load_addr = align_addr;
+    }
+
     load_bias = load_addr - loaddr;
 
     if (elf_is_fdpic(ehdr)) {
-- 
2.43.0


