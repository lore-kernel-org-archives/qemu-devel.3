Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D1C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguVp-0003Mv-PY; Tue, 29 Jul 2025 20:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFg-00024y-PD
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFa-00046U-Op
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74b56b1d301so4182503b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833653; x=1754438453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J9vt3dhv3ms1n2Eyyp9F7yCrnh/3PJjaKewMs2/e6Tw=;
 b=R3m+cOtkYZogZ5t68+WMZwue2CjbMVzFftrKxE8lGKpONGQseUw4hAltq38DsVsGfZ
 8IS8eHcnZquizYBe6J6cx4s4ZNp54ksFyxpxwCfCCGUKxMAwTnWMm2eIjOgoUWYlI9iM
 e7+sIrCcfmM7KV1RLnBoHbtaItC2GRVE5juX00j2MACfNkbvgBQpvoXj6q+GrS0YIwZS
 N0p32z/CDg1mNyIIH4ktKuH63+CuuAEKrWFoZ2r4vh1sA2kHD0jWrLdLO8LjCiJud7Q+
 r3vl8BUgjojbi6pdwU/7Gg7DaXDmtRfNpqTblqDBHqSwLnOnhp+XFAAPDgPv2QVkhkd4
 Dvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833653; x=1754438453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9vt3dhv3ms1n2Eyyp9F7yCrnh/3PJjaKewMs2/e6Tw=;
 b=YIWCvsT89NigmHqm0f7Js+3Y5noi79G7dcWAqNCBd1aV3Gsy+c8SqBQU08aNV6FEWQ
 qmgkd5el51bMvR0O8t+lDqjmBClph+1WZMtpW9EMC875wz3RcZv26Jh7rWwnoaG8rVnZ
 DL9yBb9KFvyOiNVzE3byu2PivZwdcYcZdc6j9mhyQksXfxxc2NW/tnCh2aWnboNgw0Kw
 OhJXSQk5omebwFNEHnAlAdauo51vm/MeHlyzqQRzmjyq8g9xfn3NtijKwULFB2/O9ZWg
 rb40HvMYDtdiMaMe02lnAXsCtr6/KUlAVTd0yJTbdSP17cs3NXM3OPpEZWIPX7SJJsm7
 CVwQ==
X-Gm-Message-State: AOJu0YwalF0kFVmFJP7WQ8qJSG+TMEOETpwOYzJ2jbRTf4r4ffpnmYb5
 zS4e+973jbCdRHHAi1OTb5Ol7IU+1RDdUmHur1BxRYSFREF+SXxA8yESs5+rGWFgi5jSE1TkK51
 cMSFm
X-Gm-Gg: ASbGncuFvafgoYHXvgDY39E9drRdNTLLmx1xnITMpM8QjIx0bf9oHiINZXjXssCkkYK
 2UEtNTqK/UdVbgPUfSEKRwbp04/xdJTmmvaOKjD3CGOPTG1z569KElZpm+/T0YA+2Ls2+Xpkr9T
 aj03hW0Am0x1Uytc0G9CLy8qRtR1WnBHuZ3DaiANrmFB0eXiEjwFPMCEhJZnx40VLigC6g6CqpI
 UBnsivSInoghSXBIU/q7zW46QW0xcCMvp94SDYPQwzv2dmRd+PMP/mLpOHj7TD9FESJYIe7PfX3
 2A0w89PiReKqhjY8fQ01r2BKwy9dSOI7Y/UOQO+EJFYh3St6OtoKSe3RrF3xNU3zJJyeYA9qA3W
 ECvD/3hiIekk7O6WdbmQWFWFquM45BwrmRa/JFCHaj4+4Xl2t64Jw8/4kwf71OIC9hGGdZLwsh6
 MXFI/RFv8KNA==
X-Google-Smtp-Source: AGHT+IEVK+Gs+mET2/e5F+QgmSxlH7PbGy+mhMNUYB0yOjJOgutUg0zW/0W8hqNmao9pf+eQ9wWACA==
X-Received: by 2002:a05:6a00:2194:b0:742:a02e:dd8d with SMTP id
 d2e1a72fcca58-76ab30c968dmr2178521b3a.20.1753833653158; 
 Tue, 29 Jul 2025 17:00:53 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/89] linux-user/openrisc: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:04 -1000
Message-ID: <20250730000003.599084-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c           |  7 +------
 linux-user/openrisc/cpu_loop.c | 11 ++++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9e6ec4f20a..808f9f9ad0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -679,12 +679,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->pc = infop->entry;
-    regs->gpr[1] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 306b4f8eb4..8c72347a99 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -83,13 +83,10 @@ void cpu_loop(CPUOpenRISCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for (i = 0; i < 32; i++) {
-        cpu_set_gpr(env, i, regs->gpr[i]);
-    }
-    env->pc = regs->pc;
-    cpu_set_sr(env, regs->sr);
+    env->pc = info->entry;
+    cpu_set_gpr(env, 1, info->start_stack);
 }
-- 
2.43.0


