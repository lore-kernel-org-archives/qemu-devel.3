Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BB0C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfs-00080i-Sy; Sun, 26 May 2024 15:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfo-0007ys-5u
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:52 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfd-0006TW-P8
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:44 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2bfdae0b0e0so39388a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752200; x=1717357000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ClmjZOy3QQNiKciKtrEnKHv+DzIwPzBDEJYBBNDBr+E=;
 b=IJbOoxe/czAzduaMEWaFs0lGyKWq0RAo4+sJ0O8gSd3d/KRSdZibjSYWxeIMnIis5D
 +S28EyL7mIjEZy8Rt2/uNcn95ixyvcN0g8argrxXQrL7OBUNBCmvVi4RrOMFzb4gVnS6
 3q2Gsx5PKW9xdufMx4OwAyXlSUE2WHBCa8UaWCx2E01ZeMLLRu9LHQJkrwYYSWkUT7TJ
 gF9nq2GGH5feqkkzHjLNt8i4MuHlRZi7Jcfiik7V2GjeUedk7GG9oJMVXptiQLfnzau8
 MkPgy6erLjSihADwZvXP4qFYHocg05pr7p9i8PgZ0rGE7t9IMD+tgLeh2LnuDFWJS/jx
 dh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752200; x=1717357000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClmjZOy3QQNiKciKtrEnKHv+DzIwPzBDEJYBBNDBr+E=;
 b=SI7vfR+1APst4SLldCw7ybYhBvGsaU4CNVOxvO6BIWa9yw4RnCQZCmhu3siedXUuZA
 79ppURjr8gjLEkNf0KAs8via3U1nMawabmkyYtkLVIcDRoxl9Cz8G+eE8mZyKgglQNSm
 d3iDplLfsAWB9mm0Sb6Ms3jfCdZW0Rcj3h0l52bLYVAI2m43t5435FUn8Ee0Lg3TEww0
 /6ftzUFEM7Y3f4vUdZdirJ6LPR8sTA0lDPPa8Esw9EmHKj+6JaloidOSLTzsc2UHt87K
 1Wp7FJW1a0s6FRxw3fQDfBTSHoyZXZn4VeEC+hekdjQdTTC9KIkUx2mw98ipxhHFLxTn
 uNug==
X-Gm-Message-State: AOJu0Yxlb8O1YqTomLNW2xwqeHWQLKRDEY1a/EM1fdFyXRfNIxWpnoKS
 W37AKK5rOKHKmDlLKlmIFVLe89+tesF/IVYSz4DI8VF1syXQiGXGzRTBvRSejTPnW6trNexQL7E
 D
X-Google-Smtp-Source: AGHT+IFieMRRiC/FrMuy+Am3GtBHjQKaPDgDDUiALMlnBJ+hysStfFhvRBv5cxES7iGCTxPwYC6jWw==
X-Received: by 2002:a17:90a:296:b0:2bd:d2f9:fa18 with SMTP id
 98e67ed59e1d1-2bf5f85ddcdmr6502183a91.48.1716752199933; 
 Sun, 26 May 2024 12:36:39 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 01/13] risu: Allow use of ELF test files
Date: Sun, 26 May 2024 12:36:25 -0700
Message-Id: <20240526193637.459064-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

By using elf files, we make it easier to disassemble
the test file, to match comparison failures to code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/risu.c b/risu.c
index c28b4a5..c9c3a38 100644
--- a/risu.c
+++ b/risu.c
@@ -24,6 +24,15 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <string.h>
+#include <elf.h>
+
+/* TODO: Improve configure. */
+#ifdef __linux__
+#include <endian.h>
+#define HOST_BIG_ENDIAN  (__BYTE_ORDER == __BIG_ENDIAN)
+#else
+#error Need HOST_BIG_ENDIAN
+#endif
 
 #include "config.h"
 #include "risu.h"
@@ -346,8 +355,11 @@ static void load_image(const char *imgfile)
 {
     /* Load image file into memory as executable */
     struct stat st;
+    void *addr;
+    int fd;
+
     fprintf(stderr, "loading test image %s...\n", imgfile);
-    int fd = open(imgfile, O_RDONLY);
+    fd = open(imgfile, O_RDONLY);
     if (fd < 0) {
         fprintf(stderr, "failed to open image file %s\n", imgfile);
         exit(EXIT_FAILURE);
@@ -356,20 +368,55 @@ static void load_image(const char *imgfile)
         perror("fstat");
         exit(EXIT_FAILURE);
     }
-    size_t len = st.st_size;
-    void *addr;
 
     /* Map writable because we include the memory area for store
      * testing in the image.
      */
-    addr = mmap(0, len, PROT_READ | PROT_WRITE | PROT_EXEC,
+    addr = mmap(0, st.st_size, PROT_READ | PROT_WRITE | PROT_EXEC,
                 MAP_PRIVATE, fd, 0);
     if (addr == MAP_FAILED) {
         perror("mmap");
         exit(EXIT_FAILURE);
     }
     close(fd);
-    image_start = addr;
+
+    if (memcmp(addr, ELFMAG, SELFMAG) == 0) {
+        union {
+            unsigned char ident[EI_NIDENT];
+            Elf32_Ehdr h32;
+            Elf64_Ehdr h64;
+        } *e = addr;
+        size_t entry;
+
+        /*
+         * TODO: More complete parsing of ELF file, verify assumtion, namely:
+         * Single PT_LOAD covering the ELF header, code and data.
+         * For now, simply update image_start from the elf header.
+         */
+        if (e->ident[EI_DATA] !=
+            (HOST_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB)) {
+            fprintf(stderr, "%s: Endian mismatch: EI_DATA = %x\n",
+                    imgfile, e->ident[EI_DATA]);
+            exit(1);
+        }
+
+        switch (e->ident[EI_CLASS]) {
+        case ELFCLASS32:
+            entry = e->h32.e_entry;
+            break;
+        case ELFCLASS64:
+            entry = e->h64.e_entry;
+            break;
+        default:
+            fprintf(stderr, "%s: Bad elf header: EI_CLASS = %x\n",
+                    imgfile, e->ident[EI_CLASS]);
+            exit(1);
+        }
+        image_start = addr + entry;
+    } else {
+        /* Raw binary image. */
+        image_start = addr;
+    }
     image_start_address = (uintptr_t) addr;
 }
 
-- 
2.34.1


