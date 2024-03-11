Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9A6C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl9u-0007Hx-FC; Mon, 11 Mar 2024 15:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl57-0003R1-G2
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:09 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4s-0000Mc-HF
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:05 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513173e8191so4648910e87.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184367; x=1710789167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZKRgQA/0ld0Nx08VQWNukHwwGQ+d9ybOAarqZYkU/Wk=;
 b=eSua3Q4pfY5Xj46/eQvHcGv0yDFxOuUH3hdFEYl75d+9CrMA4rJfFeXq4pPzkLbqol
 Ooa731wYNf0EagSFjwsIix6ph8H9KlQzyv8oo+9rtg4IeLPYqVjcAnk8avGz3GLG65ea
 LxQfXVMvq1dXk6Kc74mEUS2xqOnRJH7KChp2Ny4XUgdvjLnKeAhzvcAuzGlqRL53IW8X
 KgIgR1AJHfGnbO174kDWIym7cIqldabhHWu1luZ+7r0eK1j08K5R+rbx3QPWAnwhbUXK
 amNeXOC900+kJew3dd60PynNqUTEEWc4Ov4/ILEY/gtaKQaa7L+v5K89xehL/zivAFzz
 pPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184367; x=1710789167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKRgQA/0ld0Nx08VQWNukHwwGQ+d9ybOAarqZYkU/Wk=;
 b=Uj9ycY0bos3R9qQPNIobCtpm9skI6QXuvDEc8czRgy4ssyRi9sQSsLfLnic0dTshyu
 0IJeZandn8pEtX5WJ+qJN1bTHuF6eF+khLwop/t4TkRNv5mN63O6Brq5A17p4R/x0dPF
 3++Z0IaKtwtFJfW1WUt1uq9DNktbYHSTZLbGPBRBs3KPWABp4hmZsVT6hNMN+f0MDFWx
 rdTo2iIjG82K+ens/8JD9sk8rKTdusUTYm7kOJrlcQYErmja6uedjS2WY4JZgVTRZEc6
 V2aY8K4K2IP9Si2gi21uaPxgMfFJDLqKMZuxeYKxzFKaTR2ZRMaOJv7XNxuppkrEWKXd
 3PhQ==
X-Gm-Message-State: AOJu0YzJ0GU62FxxQy3NfjD5puEAYw9k1gpcdqu60vZottnEAXMR1eGM
 v2Y1V4gkD+CyVDrjCiuwMLOiZFs7/T9aVFPjtJzcChHY5bz93iarf2hqqorRrvzKSTGIFL0h2bW
 X
X-Google-Smtp-Source: AGHT+IGOJ1KoXZO237edtystrfVew5o+hfqMo2FwLdhI0++2yRKsF43Lzl985lHcFyaphFsVEkNQQA==
X-Received: by 2002:a05:6512:2823:b0:513:42e:ddf0 with SMTP id
 cf35-20020a056512282300b00513042eddf0mr6981266lfb.36.1710184367095; 
 Mon, 11 Mar 2024 12:12:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] contrib/elf2dmp: Fix error reporting style in qemu_elf.c
Date: Mon, 11 Mar 2024 19:12:30 +0000
Message-Id: <20240311191241.4177990-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240307-elf2dmp-v4-8-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.h |  2 +-
 contrib/elf2dmp/main.c     |  2 +-
 contrib/elf2dmp/qemu_elf.c | 32 ++++++++++++++++----------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index afa75f10b2d..adc50238b46 100644
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
index 7a3a7225905..cb28971789e 100644
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
index 055e6f8792e..a22c057d3ec 100644
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
2.34.1


