Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9587CC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAsU-0004bv-L6; Thu, 07 Mar 2024 05:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsQ-0004X5-Vu
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:27 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsN-0007AG-F9
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:26 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso579667a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806882; x=1710411682;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g0+eTNzDAfP/I8pMSpLdPirrAbqQUuAszFkDupkQLY8=;
 b=KkXxzOCao1yI/9lsyirmPUzpCLGHugzeB3tsh6CnEk6DBT1YI4utnK4U5EOCDa3u+b
 CvsO5ORDn74uSqbxT+kabhSJqZVqsdfFMusncoomBTtFGO6rcs/xSIEjWSw3u/tFQBHF
 iX97bX4yCC6BppbkxGGQJkMGhqsfSbwqzUdhZHxS4uZWuEOddtjyqu2LwWCpFT2SXK2Q
 9GuK6Lj/CL1bv9bRxxH3REHLZZvCqu/qoUXdgEcXc529FSZh9OT2UuuDrM1BwYrxkqN3
 qyPF/vBoBeMi2fTgcMXdTz9HW6joQrLeF0H1bBLenw+P7fDX8o/JLwqobjtWSLGRDMvT
 He6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806882; x=1710411682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0+eTNzDAfP/I8pMSpLdPirrAbqQUuAszFkDupkQLY8=;
 b=Uf61ekR15ZnSO0F96dp09vQaLkXR6HydJMV+fw/utdvdbGEYmQQiC1wLPPWdw3W59q
 /mejnUdWQ/lUntGZD2touMenFd8wpfKGLCWd4UewcC2sSA03oNXPnQSmHHq+dRpX8+JA
 EbwSz/1qEiUUUSErSxd0Lx3VB7F36c6Z897QKJR9Auw19yCHXQoxQvFAOk2Cdg/9lUH2
 xELsQ+QQ61U5uOvzoJZUWruR86kbomUGFbd3pJQRusR7xucnvdybOR4b5uHYp9op8s0c
 OjfF0mpKmBKRwrX/o/jSsbWkgdhppxmVaEAVSIN2A16/EOoEjbTR2t2Iu6EY5MudlPQl
 pOBA==
X-Gm-Message-State: AOJu0YzCuHU/lXlYlgcp7z8yzusmzWhQzZfNZd7U8Mfr7gCPeXf2Gsnd
 BDiSupqxsUdKNwJgdJwruo58VvLbILdkq27yxoRF1FCVIDtmQnYt7S8Cuo7i9I6lDfo70ZH8k0h
 N
X-Google-Smtp-Source: AGHT+IE3oXDscRQyJLlAQugirK0otEyfEtPl8P9vkYqyOcdqznOTxPzT7bSLmqpYB2lzW2I7G9HleA==
X-Received: by 2002:a05:6a20:9189:b0:1a1:7513:1f74 with SMTP id
 v9-20020a056a20918900b001a175131f74mr823641pzd.37.1709806882276; 
 Thu, 07 Mar 2024 02:21:22 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 11-20020a63104b000000b005d8e30897e4sm12132972pgq.69.2024.03.07.02.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:51 +0900
Subject: [PATCH v4 08/19] contrib/elf2dmp: Fix error reporting style in
 qemu_elf.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-8-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
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

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/qemu_elf.h |  2 +-
 contrib/elf2dmp/main.c     |  2 +-
 contrib/elf2dmp/qemu_elf.c | 32 ++++++++++++++++----------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index afa75f10b2d2..adc50238b46b 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -42,7 +42,7 @@ typedef struct QEMU_Elf {
     int has_kernel_gs_base;
 } QEMU_Elf;
 
-int QEMU_Elf_init(QEMU_Elf *qe, const char *filename);
+bool QEMU_Elf_init(QEMU_Elf *qe, const char *filename);
 void QEMU_Elf_exit(QEMU_Elf *qe);
 
 Elf64_Phdr *elf64_getphdr(void *map);
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 7a3a7225905e..cb28971789e4 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -535,7 +535,7 @@ int main(int argc, char *argv[])
         return 1;
     }
 
-    if (QEMU_Elf_init(&qemu_elf, argv[1])) {
+    if (!QEMU_Elf_init(&qemu_elf, argv[1])) {
         eprintf("Failed to initialize QEMU ELF dump\n");
         return 1;
     }
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 055e6f8792e9..a22c057d3ec3 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -60,7 +60,7 @@ Elf64_Half elf_getphdrnum(void *map)
     return ehdr->e_phnum;
 }
 
-static int init_states(QEMU_Elf *qe)
+static bool init_states(QEMU_Elf *qe)
 {
     Elf64_Phdr *phdr = elf64_getphdr(qe->map);
     Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
@@ -70,7 +70,7 @@ static int init_states(QEMU_Elf *qe)
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
-        return 1;
+        return false;
     }
 
     qe->has_kernel_gs_base = 1;
@@ -107,7 +107,7 @@ static int init_states(QEMU_Elf *qe)
 
     qe->state_nr = cpu_nr;
 
-    return 0;
+    return true;
 }
 
 static void exit_states(QEMU_Elf *qe)
@@ -162,7 +162,7 @@ static bool check_ehdr(QEMU_Elf *qe)
     return true;
 }
 
-static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
+static bool QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
 {
 #ifdef CONFIG_LINUX
     struct stat st;
@@ -173,13 +173,13 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     fd = open(filename, O_RDONLY, 0);
     if (fd == -1) {
         eprintf("Failed to open ELF dump file \'%s\'\n", filename);
-        return 1;
+        return false;
     }
 
     if (fstat(fd, &st)) {
         eprintf("Failed to get size of ELF dump file\n");
         close(fd);
-        return 1;
+        return false;
     }
     qe->size = st.st_size;
 
@@ -188,7 +188,7 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     if (qe->map == MAP_FAILED) {
         eprintf("Failed to map ELF file\n");
         close(fd);
-        return 1;
+        return false;
     }
 
     close(fd);
@@ -201,14 +201,14 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     if (gerr) {
         eprintf("Failed to map ELF dump file \'%s\'\n", filename);
         g_error_free(gerr);
-        return 1;
+        return false;
     }
 
     qe->map = g_mapped_file_get_contents(qe->gmf);
     qe->size = g_mapped_file_get_length(qe->gmf);
 #endif
 
-    return 0;
+    return true;
 }
 
 static void QEMU_Elf_unmap(QEMU_Elf *qe)
@@ -220,25 +220,25 @@ static void QEMU_Elf_unmap(QEMU_Elf *qe)
 #endif
 }
 
-int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
+bool QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
 {
-    if (QEMU_Elf_map(qe, filename)) {
-        return 1;
+    if (!QEMU_Elf_map(qe, filename)) {
+        return false;
     }
 
     if (!check_ehdr(qe)) {
         eprintf("Input file has the wrong format\n");
         QEMU_Elf_unmap(qe);
-        return 1;
+        return false;
     }
 
-    if (init_states(qe)) {
+    if (!init_states(qe)) {
         eprintf("Failed to extract QEMU CPU states\n");
         QEMU_Elf_unmap(qe);
-        return 1;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 void QEMU_Elf_exit(QEMU_Elf *qe)

-- 
2.44.0


