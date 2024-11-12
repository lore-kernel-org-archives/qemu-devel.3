Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8AAD597A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 20:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAxec-0001IV-J7; Tue, 12 Nov 2024 15:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeY-0001Hc-CG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:23 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeK-0008Sw-8w
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:21 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ee7e87f6e4so4532978a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731443883; x=1732048683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i9Tx+e50KlhsYgpRqVjdsO/z4tv3m55Kc+AlE2OCoQs=;
 b=s9KSLqLjSdP9FhTEzjVTREwqrBkjqLZW512iM3/GRgSdLm/FbX8jXzJEUGyUi0v91t
 KmHWIEmDqbYllapFCKgB/Fp8ckWa3bNpVAHGrT5RI+ZNm+3Uf5c/6f5/CSl2sMsK6jkl
 ER1KnCnvfAU6q2I7a8bTM3PLymZVRjLIdmmLXgVKgj0wykW1kxDGNMDGePtInQCLG6KW
 kLEVjUUy+LPcRfa46DWdcEpO0TL3jrr/PTH9VPNfRuS7AafnN57eu5p8DVjGRAiDuQxf
 MfOlU2wDHEh6Dr13a1sMRgV1Y546Vm8coD1fS/w319mmOSAoCbrrqB40BJNiKes/wFQR
 zMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731443883; x=1732048683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9Tx+e50KlhsYgpRqVjdsO/z4tv3m55Kc+AlE2OCoQs=;
 b=nWyIluYh+jUqw04fV8LmaODWKMxeShepSI7vD3shoRqz1bH8OxQBN+aFGttSYbTn6e
 lMqdE7cnV5fdJijIau4sjCNdETq+1W0y7soPt5azqKoaVFviWRir4T0tQbPvpc/9B1Ak
 X2GlUEJtXD49IZxdaQrynqlNdseJavpDQlflRtbQDe6+hd0UMn6K33lXM0O8OiO6zoU5
 HRrcIP+LX7e8XVWFz51FYATA1Pp8meOa47c433N/PZzGO7JcUuBJM7SIk4hu9hd10A0D
 2QppoXLLroWMlgCv0+Hn9iWuwkintmzD2Tkcy3xXU6s9GVZTBuEEu/4MxCuQ3VUfWdxz
 gYbg==
X-Gm-Message-State: AOJu0YyoLq3HuMAmxh5cdT3t4ZzsSi8J5mSIVqAclt804Hj3rzs8zU1C
 6YTRG7jFm7ZtMMXnHXcr7Pzo9gXX//PJgPJYssO3yqsBZYHPw4gkgPFlwYbkCkrwId/0LGVFTg/
 V
X-Google-Smtp-Source: AGHT+IEWesqoAAo3sX2bA7Clerqd327iPQ5JhX8BTOxXQjcvZ3repDP9WJYn/VfAYNn8JGXilqpsdg==
X-Received: by 2002:a17:90b:3847:b0:2e2:e159:8f7b with SMTP id
 98e67ed59e1d1-2e9b16e6415mr21149876a91.3.1731443883349; 
 Tue, 12 Nov 2024 12:38:03 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3894192sm9860a91.21.2024.11.12.12.38.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 12:38:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] linux-user: Drop image_info.alignment
Date: Tue, 12 Nov 2024 12:37:53 -0800
Message-ID: <20241112203757.804320-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112203757.804320-1-richard.henderson@linaro.org>
References: <20241112203757.804320-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

This field is write-only.  Use only the function-local
variable within load_elf_image.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    | 1 -
 linux-user/elfload.c | 7 +++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 895bdd722a..67bc81b149 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -44,7 +44,6 @@ struct image_info {
         abi_ulong       file_string;
         uint32_t        elf_flags;
         int             personality;
-        abi_ulong       alignment;
         bool            exec_stack;
 
         /* Generic semihosting knows about these pointers. */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 90e79a01b4..ef9cffbe4a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3220,7 +3220,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * amount of memory to handle that.  Locate the interpreter, if any.
      */
     loaddr = -1, hiaddr = 0;
-    info->alignment = 0;
+    align = 0;
     info->exec_stack = EXSTACK_DEFAULT;
     for (i = 0; i < ehdr->e_phnum; ++i) {
         struct elf_phdr *eppnt = phdr + i;
@@ -3234,7 +3234,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
                 hiaddr = a;
             }
             ++info->nsegs;
-            info->alignment |= eppnt->p_align;
+            align |= eppnt->p_align;
         } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
             g_autofree char *interp_name = NULL;
 
@@ -3264,8 +3264,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     load_addr = loaddr;
 
-    align = pow2ceil(info->alignment);
-    info->alignment = align;
+    align = pow2ceil(align);
 
     if (pinterp_name != NULL) {
         if (ehdr->e_type == ET_EXEC) {
-- 
2.43.0


