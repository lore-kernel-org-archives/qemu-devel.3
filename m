Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4F5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29k-0001zw-Eb; Fri, 02 Aug 2024 19:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29b-0001WH-AC
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:49 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29Z-0004HH-SG
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:47 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso363088839f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643064; x=1723247864;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TT3QX4LoQAijDXK3PbVvKtS6ffPFG//HKfS5znuzPiU=;
 b=oP1rAz2pyeJN3GyKijg27cI0TsnUlEDG3yQdLGDiBVReu/9vWoJzmbYUlB3zkVT5TA
 xIXcf8TIjLlsy62w13dTV6odmQS0+aU+8LKfyPFo+wmUfNCxAiOEiSiQqC+IZpulWRGq
 CCvXZHGws8xLfvCWHLH7c6RxMvpgrjKG8IiJRGD2zuhaA7JI/NfujFkLAnK5TL01sEYN
 F0mSydlrmTVzuttTI/GXgmRkFRXNoMZz1gXNo8AasVixJtrOpw17LSxOvqB+juTDoGP3
 RlbiIhahYM0fScNQQ1nyyJSDbPyxq1Umpk5cTA68RgK+n4LiuDKSE8gWj/Jp+ODLnHEk
 VLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643064; x=1723247864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TT3QX4LoQAijDXK3PbVvKtS6ffPFG//HKfS5znuzPiU=;
 b=efjWFIXvHRRbTj+ZQALkolmZqWyApv6MzEo+ZPWUQf0jhXoOCQl4jUNi/Eo3vYek5o
 aOFB8zcsXEX1YolYlyjABRbmuk/mj9x8kFsz7B36+S0z2VlTbnPoPXd/pA2ebx7MZP5c
 d2aI0DgfrUyuHu9ttyZft5eLtxJzyetQ6WQTyOB7XS+JHCcsqel78i7SIilFL4o2g3x9
 pO6jEuPlW9y97IEr/MzZR893ar6GxzP0mysJhvWrYJVDSef8xQXE7U4kcoIIqNcsG+Bt
 UyZH5ydG4zbaSNoUrs9F9YeilAQ1Ee+jzqw+jjz3Fr8g0LEOgtWhjo0uRKyyCYZVwDlE
 IPbA==
X-Gm-Message-State: AOJu0Yw5a5jzr2UHg9dGaamXqByRRojT5+yz0Vsh9K7nnMGb3uEELxbG
 81qObrSY2y/wIijCEKN+rk6p4YcKbFZtIE/JGvAF/r7kJyA5HKWpRA9u6bhSXn4YuDCOBTRh9GU
 inmo=
X-Google-Smtp-Source: AGHT+IHKMQy2uGTBXZNGdTpzn44FwHdb5451ftzXLqW17nSXCtUxbEnaKZOHbwwYB8Bmw02RhowFvg==
X-Received: by 2002:a05:6602:27c4:b0:81f:9552:e091 with SMTP id
 ca18e2360f4ac-81fd43623f5mr567102039f.7.1722643064423; 
 Fri, 02 Aug 2024 16:57:44 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:43 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 05/17] bsd-user: Eliminate unused regs arg in load_elf_binary
Date: Fri,  2 Aug 2024 17:56:05 -0600
Message-ID: <20240802235617.7971-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2a.google.com
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsdload.c | 2 +-
 bsd-user/elfload.c | 3 +--
 bsd-user/qemu.h    | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
index 5b3c061a452..dcf3ca14fcc 100644
--- a/bsd-user/bsdload.c
+++ b/bsd-user/bsdload.c
@@ -193,7 +193,7 @@ int loader_exec(const char *filename, char **argv, char **envp,
                 && bprm->buf[1] == 'E'
                 && bprm->buf[2] == 'L'
                 && bprm->buf[3] == 'F') {
-            retval = load_elf_binary(bprm, regs, infop);
+            retval = load_elf_binary(bprm, infop);
         } else {
             fprintf(stderr, "Unknown binary format\n");
             return -1;
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 833fa3bd057..caf8a1adf2d 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -597,8 +597,7 @@ load_elf_sections(const struct elfhdr *hdr, struct elf_phdr *phdr, int fd,
     return 0;
 }
 
-int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
-                    struct image_info *info)
+int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info)
 {
     struct elfhdr elf_ex;
     struct elfhdr interp_elf_ex;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index c7f78096734..f18a54cc933 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -163,8 +163,7 @@ int loader_exec(const char *filename, char **argv, char **envp,
                 struct target_pt_regs *regs, struct image_info *infop,
                 struct bsd_binprm *bprm);
 
-int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
-                    struct image_info *info);
+int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
                     struct image_info *info);
 int is_target_elf_binary(int fd);
-- 
2.45.1


