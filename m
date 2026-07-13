Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B63C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 01:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj5au-0003bl-5t; Sun, 12 Jul 2026 21:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wj5aq-0003bK-Ei
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 21:36:25 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wj5ap-0001wJ-1A
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 21:36:24 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6647bc8f900so4460090d50.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783906581; x=1784511381; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7rWQIUX8PpQ5NxVKonL7S1py2DeqtMM2zWHNywk2IBY=;
 b=fnonOWl914BqWjT8oVaUkmXXTlhXVGqUzq/UZWbpUEbqgII17Q+HvPzZpla3riyS/5
 mjPIkdNB4oQjE5mIzSgzV4oYRWNJ14PDuHE+gVQ8ICn3yx/jKxkwNkg2Uzm4zHqKuYs/
 pJ6/253RYNfyPg+hs0ChcZNqhWTpNJKM46ficPADK5MxTqdiEvHPq9ulyL2S5esZQEfo
 hN/eMRuhXj0Xv51nMYbASeYNPja1LRf1bvpQbYs1GfNUbeFu/WDIW5hY2FuTULNaKFE/
 sfmLrJK+6OpT7gAC0xmCKS0RERmOaI0tKmvQSapOlnBDYmeldfivPv56yjeHKpAn57+J
 b+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783906581; x=1784511381;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7rWQIUX8PpQ5NxVKonL7S1py2DeqtMM2zWHNywk2IBY=;
 b=go0S5H330M4iEX6H0TfEyzaI+3TUdhBS/twFTEGzAtDc0XeaaV/XkDiPtZ8rs5aAVT
 BhWSucIWI6qKmw2U9jStW5jt7fijtfo/ZhpciL0QIHq09wuakpthgr5WfEo4liFUB/BP
 JE2ee9K7cyYnxXyzSSlghpeKH+jB7cj+9awk6HsdsXRovpj/T014xzuOFqB87B6Cin9x
 fDDe85nUngU5Pw/vgzrsYDX3uAwwJsMSpwH6uLZVXo9eao3oAieo8nBmySrkE9j2Ez/Y
 fZllSjqDEOphod2fgodv1fDQ0f3FiBs4+FHSpMSBZTNnxJv8aXTmsFmhWKWfzc6D2pwd
 SHaA==
X-Gm-Message-State: AOJu0YwMvG0Nt50gXV2ni6UsQy+Vi1oTZWZdZ/xmd/plW29n6X1NZN1q
 1Y3Em2bIVLT7XsocUyUCC80g5h1ubUqSzPpC1oUHARd46VVMP0vwogyc1NJQIw==
X-Gm-Gg: AfdE7cmsVWFkloeLBmhR1OHv4dLKal8XYOQnkuRYwwBCEh3qseT6Iz5OUd5Mwp5UnVD
 TCsZxbK/8fdET+GjKPOQmLSM4KQEm9p3tesQHHUeEuuDoQaVDoFYUJPf4vQpj0ybJfUjcEi4L5Y
 455UqEbvH+1WuuTfzpD3Yff6Vp3pS/i8DX8I928uoD2/r57mNCkC69/NkWisO2XCTjGJsZSQjvI
 LyqqZapMzFOERAI27f8aiU4+E21aE9svF7hh1jhHBjeY9pl6sYOUOZpJhIWIh3RmQHERFxp2fwN
 yTvgYAPnfyp+tEOcYMc7YSuRTOTreTPLaz1ZRM1dczqt4eM8RzCVBYM4npRjmMvLrr/8x3faSH9
 d7vBQOHCQTYr/eABkLf87i2h3IJf1toW5Z3S2r7imX9Jn3PXhIgD7iHHFzjdlKRVyOZCCMobdbA
 mqkI7F9jaTQH8RAHXAoK4Hxf0=
X-Received: by 2002:a05:690e:4009:b0:667:db66:eb47 with SMTP id
 956f58d0204a3-667db66f36emr4425148d50.10.1783906581404; 
 Sun, 12 Jul 2026 18:36:21 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-667c2efa583sm8245709d50.15.2026.07.12.18.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 18:36:20 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH] linux-user/alpha: populate AT_HWCAP from env->amask
Date: Sun, 12 Jul 2026 21:36:07 -0400
Message-ID: <20260713013610.2691128-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb129.google.com
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

Alpha has never set AT_HWCAP in linux-user emulation, so getauxval(AT_HWCAP)
always returned 0 regardless of the emulated CPU model.

The Linux kernel computes ELF_HWCAP as ~amask(-1), i.e. the set of ISA
extension bits that the amask instruction reports as supported (cleared in
its output).  env->amask stores exactly those bits with the same layout
(BWX=0x1, FIX=0x2, CIX=0x4, MVI=0x100, TRAP=0x200, PREFETCH=0x1000), so
returning it directly from get_elf_hwcap matches the kernel convention.

Add HAVE_ELF_HWCAP to target_elf.h and implement get_elf_hwcap() in
elfload.c to expose the emulated CPU's capability mask to user-space
programs via the auxiliary vector.

Without this fix, programs using getauxval(AT_HWCAP) to detect BWX/FIX/CIX
(such as glibc's memcpy or JIT compilers targeting Alpha) incorrectly
concluded that no extensions were available even when emulating ev56+.
---
 linux-user/alpha/elfload.c    | 11 +++++++++++
 linux-user/alpha/target_elf.h |  1 +
 2 files changed, 12 insertions(+)

diff --git ./linux-user/alpha/elfload.c ./linux-user/alpha/elfload.c
index 1969f620a5..7be9e466b6 100644
--- ./linux-user/alpha/elfload.c
+++ ./linux-user/alpha/elfload.c
@@ -6,6 +6,17 @@
 #include "target_elf.h"
 
 
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    /*
+     * The Linux kernel computes ELF_HWCAP as ~amask(-1), which clears a bit
+     * for each supported ISA extension.  env->amask stores exactly those bits
+     * set for the extensions supported by the emulated CPU model, matching
+     * the kernel's convention: bit set in AT_HWCAP ↔ extension present.
+     */
+    return cpu_env(cs)->amask;
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUAlphaState *env)
 {
     int i;
diff --git ./linux-user/alpha/target_elf.h ./linux-user/alpha/target_elf.h
index 4987ae3944..dd90c6f783 100644
--- ./linux-user/alpha/target_elf.h
+++ ./linux-user/alpha/target_elf.h
@@ -12,6 +12,7 @@
 #define ELF_MACHINE             EM_ALPHA
 
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_ELF_HWCAP          1
 
 /*
  * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
-- 
2.54.0


