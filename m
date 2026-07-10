Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893B6C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKDq-0004HP-ES; Fri, 10 Jul 2026 19:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDj-0004GM-1q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDh-000318-5o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2023618a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724480; x=1784329280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yECRl5tw1xQRderX2DaWbpchyapuyXnai4wOZcSvlYo=;
 b=F7fDOv2gfx0am9XV3az1zTt61J4NR+6non/dqltE0oSDcwLp0T6H7OZsSKghHRVFLX
 TbSrReqTgsqw6P9it0EouzUhfo8ehXkPx2CcZrqhG8/36srMF4tNarud4PHyhSGYMOin
 NmVmtcH0/SA5YeU+YJpVMGs800Y5RZvO3R/k+4aC8BmfI429onIb5kfLaHW2xENkZy6g
 l9y4CRCr5J9hYGm9ORr10HBhpH/nxvJXM+jCv8vvcv6r4AzyD2/smrtCkVzEmrn8CO1a
 ROeYu/4SpAYF+MBB5xoyBdgiRBTc7rw5JAG8zXZFApki8TNOBa/nW0rdQhTsY1HsbcVL
 5mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724480; x=1784329280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yECRl5tw1xQRderX2DaWbpchyapuyXnai4wOZcSvlYo=;
 b=rhh+KDukvsVEHTEgJtwGOO7uw1c16z++g7KjR/oTqeuf9VEkmzFcM4Ye2s2Sy+pQpu
 3OojnO0Evre2lbM+qGQ1yulsWqpYm8I785dUSxCre2XDcFnkF5q1ULi00T+z9bsvw9O2
 FMIYEIhJJtaQvxCADF4f438b+P7L8U/feu3v+EHfMQ0LwXuQEL58gI4brsuPt2s4BOk9
 Aly7+gyDCEFEBsZM8rjn3yH7XwPARdOMs9CNgkOKq1zMIJynAF/nKrS2ZFlmJWA13he1
 QUIlmjD5BVy01i+xkYp5sQOHvgMZrYjLtsoFOExf1UJnUlccgA0jrC76ce/yY2ciYcuM
 3cng==
X-Gm-Message-State: AOJu0Yw4iGjqxIlMH6wIRwvNAYJrbTehqduD9z6FKxIigUIB2RYRDE2e
 YJU+X2Y8nyZ5/59L4Kf1s3Wblkqs1LJlujlS5wycz2bX7gTFZazrnui6lFSpSRCradMt3ocFTkB
 tLyYJ
X-Gm-Gg: AfdE7ckjVRjnyLbM2dGoFkxz9n2OEcXijg5XROZIUUYDINaqzJxfqeXnEtb0Ju0x7g7
 1RsSGMT33twNbcCwrCcIFER/1jUpwUbe5jJlpfbva0x2s8Ay0pXo7pP4qu7wboynz8KxSnpMIN8
 PFkCVPZV6RcNK7AILZFBdascVa/7TIjhOhOmMF4GkE7t65wCMOdZHl8gH2nRL6XesBv7EPko9i/
 tPKYZEikzyB8lYN02s5YqY644vD99RWrThMQ/iDyb3+n666f9UNMdnqUsz5DlA1lOm/Wg9a9vkm
 IQmz7HfBd9jsScRuc7++D4o4RwifSgv56LD1/GBFZIQSx/OYnsVUbxCt8IFgvsK3U+FisC8j9eT
 Cr3KGyen0uUlMwK7PKrJyfK7DCh8mQOcfPZVGyxDc5yvUqvQY9g/vWoxwISVBfdr0DyzPfoi/zO
 BLzfHT3T2lpK9Lpmo6qDOHoz/LzGeM
X-Received: by 2002:a17:90b:510f:b0:387:e0db:3faf with SMTP id
 98e67ed59e1d1-38dc7793df1mr785340a91.40.1783724479569; 
 Fri, 10 Jul 2026 16:01:19 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 03/13] linux-user: Drop hiaddr out-of-range check in
 probe_guest_base
Date: Fri, 10 Jul 2026 16:01:06 -0700
Message-ID: <20260710230116.900171-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since dropping 32-bit host support, a guest address cannot
overflow a host pointer.  This means guest_hiaddr is unused
for relocatable images, so don't pass guest_hiaddr as size.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c  | 26 +++++++-------------------
 linux-user/flatload.c |  3 +--
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 30d7beb562..1367657d58 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1092,20 +1092,11 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
     uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
-    if (reserved_va) {
-        if (guest_hiaddr > reserved_va) {
-            error_report("%s: requires more than reserved virtual "
-                         "address space (0x%" PRIx64 " > 0x%lx)",
-                         image_name, (uint64_t)guest_hiaddr, reserved_va);
-            exit(EXIT_FAILURE);
-        }
-    } else {
-        if (guest_hiaddr != (uintptr_t)guest_hiaddr) {
-            error_report("%s: requires more virtual address space "
-                         "than the host can provide (0x%" PRIx64 ")",
-                         image_name, (uint64_t)guest_hiaddr + 1);
-            exit(EXIT_FAILURE);
-        }
+    if (reserved_va && guest_hiaddr > reserved_va) {
+        error_report("%s: requires more than reserved virtual "
+                     "address space (0x%" PRIx64 " > 0x%lx)",
+                     image_name, (uint64_t)guest_hiaddr, reserved_va);
+        exit(EXIT_FAILURE);
     }
 
     if (have_guest_base) {
@@ -1373,11 +1364,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              */
             probe_guest_base(image_name, range.lo, range.hi);
         } else {
-            /*
-             * The binary is dynamic, but we still need to
-             * select guest_base.  In this case we pass a size.
-             */
-            probe_guest_base(image_name, 0, range.hi - range.lo);
+            /* The binary is dynamic; we still need to select guest_base. */
+            probe_guest_base(image_name, 0, 0);
 
             /*
              * Avoid collision with the loader by providing a different
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 4beb3ed1b9..8abdd2aef2 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -261,8 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
     /*
      * Allocate the address space.
      */
-    probe_guest_base(bprm->filename, 0,
-                     text_len + data_len + extra + indx_len - 1);
+    probe_guest_base(bprm->filename, 0, 0);
 
     /*
      * there are a couple of cases here,  the separate code/data
-- 
2.43.0


