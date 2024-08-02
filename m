Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F2EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29p-0002M6-Kl; Fri, 02 Aug 2024 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29h-0001pz-97
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:53 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29f-0004IU-FV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:52 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso363089939f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643070; x=1723247870;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8/T8Zg48KUN7dtjWNUDu011IwEcHhj9Ls+BvEab5T4=;
 b=iP5jsyp48iBDvkuhUy7ioYtn6RFziXLGpW9UuMy/P0R7npximG3M464GeGEUiuEA+5
 okbqoIL6VD/qA3RhmM29CfaDcdeKrgrtTLOmtPxlr9IJ2Qj4wmtNehQMLXZNP76TJfaR
 Xa6AB6f6H2p4G9ZKnsghhgzaqOvYCfEYz21Jd8ObYmWkxzLzONlfdW+bIALj5NZ1deGn
 Xx/z4ByoLC/2dldT2Cl7RIMfv22QXQ5p+amlgANyVFbmMXMXQNbSUOtbffMNydF3Zi/D
 DMyRQWf34XCzC2JugX2mkN7dQO9no1DIU/sD8Qi7dK6yuzs6q9ayE+gda6VPaEwNtc6t
 7V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643070; x=1723247870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8/T8Zg48KUN7dtjWNUDu011IwEcHhj9Ls+BvEab5T4=;
 b=bjs5HI9kprb1Lejl9BbKXJg/9emtOSajV03MzfmX4Cr5tXoUwrg4ccW08dZbn+OVN1
 e5OLLf2KJoEdqO0WPqeRyOiSpf7QwmXSZl9AAFU1xOEurP0shg5jSYOrEaq8svPoVi8A
 HRD3FSzzxciT2pg3IlOmoJvo2SQDF40/5nYlNgt8OC1NMJr7YuD/1A4ery9/c26OwLfl
 BjkBgj6Kgi4QleTNbz7iUUmt+vrzOgX9GzJal+2dSmvf9qQ+f2WU8+pStK219J96c5ZS
 ZFnTnvXZXS95Q3lUWYb/BfU80ecZ0UxGt5X3syjI4YmEO5MXAvXH0rssb3oWG8J9XM8z
 J9hw==
X-Gm-Message-State: AOJu0YyTB35YcV/K74zngfji3EuHgPB3IAjvsGPQ/c3T7YCoQfkYY+hI
 SL+kI8qemYeJ5ucgqecZJcKAz5xwlERxjjTEwYpl/VpwWw4avdW5jCdFTvaX0znND4T7MX1XzdS
 4Vro=
X-Google-Smtp-Source: AGHT+IFypnwCX92FWsXd9Iwc3Ip+JeDls2I4arRl7Tzy3Hr7pVFB8PfUcwlFTGxdjuPbwqi8Vdp2Wg==
X-Received: by 2002:a05:6602:6d17:b0:81f:9328:9631 with SMTP id
 ca18e2360f4ac-81fd434decdmr572602639f.2.1722643069922; 
 Fri, 02 Aug 2024 16:57:49 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 10/17] bsd-user: Pass image name down the stack
Date: Fri,  2 Aug 2024 17:56:10 -0600
Message-ID: <20240802235617.7971-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Pass the image name down the stack so that we can give better error
messages. Inspired by similar work in linux-user, and more likely to
come.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/elfload.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index caf8a1adf2d..dba03f17465 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -36,8 +36,8 @@ abi_ulong target_stksiz;
 abi_ulong target_stkbas;
 
 static int elf_core_dump(int signr, CPUArchState *env);
-static int load_elf_sections(const struct elfhdr *hdr, struct elf_phdr *phdr,
-    int fd, abi_ulong rbase, abi_ulong *baddrp);
+static int load_elf_sections(const char *image_name, const struct elfhdr *hdr,
+    struct elf_phdr *phdr, int fd, abi_ulong rbase, abi_ulong *baddrp);
 
 static inline void memcpy_fromfs(void *to, const void *from, unsigned long n)
 {
@@ -268,7 +268,8 @@ static void padzero(abi_ulong elf_bss, abi_ulong last_bss)
     }
 }
 
-static abi_ulong load_elf_interp(struct elfhdr *interp_elf_ex,
+static abi_ulong load_elf_interp(const char *elf_interpreter,
+                                 struct elfhdr *interp_elf_ex,
                                  int interpreter_fd,
                                  abi_ulong *interp_load_addr)
 {
@@ -335,7 +336,7 @@ static abi_ulong load_elf_interp(struct elfhdr *interp_elf_ex,
         }
     }
 
-    error = load_elf_sections(interp_elf_ex, elf_phdata, interpreter_fd, rbase,
+    error = load_elf_sections(elf_interpreter, interp_elf_ex, elf_phdata, interpreter_fd, rbase,
         &baddr);
     if (error != 0) {
         perror("load_elf_sections");
@@ -526,8 +527,9 @@ int is_target_elf_binary(int fd)
 }
 
 static int
-load_elf_sections(const struct elfhdr *hdr, struct elf_phdr *phdr, int fd,
-    abi_ulong rbase, abi_ulong *baddrp)
+load_elf_sections(const char *image_name, const struct elfhdr *hdr,
+                  struct elf_phdr *phdr, int fd, abi_ulong rbase,
+                  abi_ulong *baddrp)
 {
     struct elf_phdr *elf_ppnt;
     abi_ulong baddr;
@@ -764,7 +766,7 @@ int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info)
 
     info->elf_flags = elf_ex.e_flags;
 
-    error = load_elf_sections(&elf_ex, elf_phdata, bprm->fd, et_dyn_addr,
+    error = load_elf_sections(bprm->filename, &elf_ex, elf_phdata, bprm->fd, et_dyn_addr,
         &load_addr);
     for (i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
         if (elf_ppnt->p_type != PT_LOAD) {
@@ -780,7 +782,8 @@ int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info)
     }
 
     if (elf_interpreter) {
-        elf_entry = load_elf_interp(&interp_elf_ex, interpreter_fd,
+        elf_entry = load_elf_interp(elf_interpreter,
+                                    &interp_elf_ex, interpreter_fd,
                                     &interp_load_addr);
         reloc_func_desc = interp_load_addr;
 
-- 
2.45.1


