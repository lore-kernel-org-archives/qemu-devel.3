Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6CCC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfD6-000458-C4; Wed, 05 Aug 2026 13:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfD3-000444-J6
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:18 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfD1-0006Fc-Nz
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:17 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6680ae2031fso1242964d50.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950114; x=1786554914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6sMuktQUriti/FzTn7dvyAmebqh+5sPjlYwFRIl8IhM=;
 b=CUxGFouOsqGoHoxITvGZQtCVkF9YdBf+Pm49mdLj0H1t6QNxAPn3zGKCToQKTxJ0j0
 0YuFNIlSPSwQjzbHVlRFZ6I2OeQ4h3CwlRKwJZY0kSyMh3LW3MVBtYLK5wX01OYEqiEw
 z6euSEWmmAA0Spop1ZrRxM9OVvLYCi6ZwN3Wjv6sOGk9d8BeEUmb71w1DPhbFboExUt6
 mXyewelgDvYrbALhjDDLWd8XI3nD1TKLThUDc25OIyp4lmkjczK8IPZL7/kQUFrz6sYT
 zFq0A99cgAAyC9NR9YOxVA+TQbiL4HyMSMhjiYbpVsRjvcqIPw/pBG6XIvKaNU6RFHIN
 OvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950114; x=1786554914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6sMuktQUriti/FzTn7dvyAmebqh+5sPjlYwFRIl8IhM=;
 b=AX0DIPl+6Ikru1oqo9TFPmtdQNj108GA1VgccLtzNxLyILtXJEUTMZ7M0DIpsnhK6D
 yB1mS87qVwlrBgqFSdxqKc/XG6pCAYzJn1dWXUPSWjwHauOkzMsttaJY0zX+MknJL21q
 S22r8doz/3FWCvplMaZ1P3AKvcQARNbcDHwvDGyvKDwpJnAXXKw7w8xneMRtupyk0Udo
 tILEXjz/G50lxKMcYpXvOpZW36siAjLGDzuLfla/gm+tF+1Y0c7HlVeSWVB5mlp39H1M
 www9K7lrEw4YrwJoErazA4O1YItk8DhG5hIKLTT6SBv66Q3eBoWTr5q0FpqdViLPgp68
 Lk3Q==
X-Gm-Message-State: AOJu0YwdznRg/YXmiPrNM2DQ48DXw7/LqWvrmHXWvb7HZ3q3XG5Mennu
 2w4tBATFrjNyU8R2WdATulMf5zCt51dU8eJdIi40BcsomMFjL/3R6KVccWrBgjoYFL4=
X-Gm-Gg: AR+sD11KXI/0zP0g+cg01nPRHHNx+2OhpzyMf35KlVgfv3s2JTFypPvMUj7epeLZf9g
 xb1TKnlaw31ojLSXuxIuugy/S3aW8JMJnAJP0APkhffxiy/bfl25R28wMpopR/fBGr5jr9OFk7A
 am0ATaWRX/IfBVK4h/RPa753D2E20L+ovtIrdlhmQCqo490T/pko+cw3kLYyrGsE/O9OtKdMWxs
 YsmjK/jnOpCVV06LdEXj5oqD94gZR60tifY7ec2oL/qE7yiT7YZPfbprsliFPinR/5yo1GmpTrI
 EnyicVq3FDXuorOU+hk5cssKPfskJB9l3DCVGPRi5Lo+NQwW2fb4zOetHqo1BrH15aXiegNB0DK
 5F5spTCcdeo759sXoPFg11c9kgPqc9l6F4NnJpo9cLrGD8YNlHiHlsw47O1g6No81pLZr5eOuS1
 GOvtKDNZoaLDAfKOLOd52fknelPRyTqZB29s3M29IjliErg1EgOgiE53RIOYzi
X-Received: by 2002:a05:690e:130e:b0:667:e2e1:44 with SMTP id
 956f58d0204a3-6699a93b621mr4205083d50.22.1785950114205; 
 Wed, 05 Aug 2026 10:15:14 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6699136af82sm3554926d50.3.2026.08.05.10.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:15:12 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/5] linux-user/hppa: write the floating-point registers to a
 core dump
Date: Wed,  5 Aug 2026 13:15:05 -0400
Message-ID: <20260805171507.3119442-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805171507.3119442-1-mattst88@gmail.com>
References: <20260805171507.3119442-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Write an NT_FPREGSET note for HPPA, matching the kernel's
elf_fpregset_t layout (ELF_NFPREG = 32): fr0-fr31 as 64-bit values.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/hppa/elfload.c    | 7 +++++++
 linux-user/hppa/target_elf.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git ./linux-user/hppa/elfload.c ./linux-user/hppa/elfload.c
index ff4301b2ed..dd5b0b380e 100644
--- ./linux-user/hppa/elfload.c
+++ ./linux-user/hppa/elfload.c
@@ -17,6 +17,13 @@ const char *get_elf_platform(CPUState *cs)
     return "PARISC";
 }
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUArchState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->fpr[i] = tswap64(env->fr[i]);
+    }
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUArchState *env)
 {
     int i;
diff --git ./linux-user/hppa/target_elf.h ./linux-user/hppa/target_elf.h
index 22547b1437..4357873aff 100644
--- ./linux-user/hppa/target_elf.h
+++ ./linux-user/hppa/target_elf.h
@@ -39,4 +39,13 @@ typedef struct target_elf_gregset_t {
 #define STACK_ALIGNMENT         64
 #define VDSO_HEADER             "vdso.c.inc"
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches the kernel's elf_fpregset_t (ELF_NFPREG = 32): fr0-fr31.
+ */
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[32];
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0


