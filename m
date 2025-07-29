Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49231C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguSX-0003UL-QE; Tue, 29 Jul 2025 20:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFM-0001qK-QW
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:42 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFK-00043x-Py
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:40 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so6769374b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833637; x=1754438437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=40hvyHMOpTXYVnjcesidjPN9bOJ+G6q7PsGtON63WME=;
 b=FlWkvDhseXPFCHiZS0PkWCw6fuUDnHtvTw1BS/+FBpfTtiLw1HsgUrQy9QuXr6iU8r
 uOEYR+nW9d133bftawIJ8v4fF+7utqdVsrzwkfDarQXjzOn2lNYNzg8ga/eh5xjFPxep
 F69WleotZt5YxPpFm1gyFLwtyYGUJJHe4lW9fGPR+11cD7S69ZjQXvF9Xf+c693ig2sz
 bd5jHIlLrhT1crXW1F4C9YNJeQ1kySTVvpY0wjG8AD2j79GlHH1PI7yK7IL/ZmAGMpCX
 l+T96SLshPRA/xmz+NN5sBMQhSaOrhCRRybv90KQcYDaeoVv4PFQQ/d6scF3PSyebxUd
 LS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833637; x=1754438437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40hvyHMOpTXYVnjcesidjPN9bOJ+G6q7PsGtON63WME=;
 b=TX4tkyus2pCqMOD1Rd7v4mwoSS7qQbXnQskcpleG0TMhcTp4GLYwKpe0tbwArk1R2p
 ZmgXr8+Bm9Xwb6/pI7JLnAkyKalIQ2dDzSFU0Yrie5M6moxbJQqBzti1t/f2fdrAipZs
 guZQYxMmOGCYRs9p0nxbBYNwdJhuY9+ActcTXUxn4rQLKIliDVyr8Oh+wmAMu+VDFMHp
 DLNtbBdhhu8/nT2i6Z5xYrbzL5+dTYxugaO6ZdJGhXcVInAHS3ZzrWiSn5t4XKeR1BTp
 X1hkizmmcCIQnONujSus8ob+WCBGGDXbu765m8r0cN3st1Wsu6XrXUV1pXa8bfb+LYl4
 2jfg==
X-Gm-Message-State: AOJu0YxYAvTRVf5oMEHlGnZgDVtbS/zLMeF7/5RwGbbIB2VUhMz1vyx3
 aYfaP9bIF3YEpFI2qma9Jl0YY6X8ND083skoXEEK8qz+XFn083tag/STygzySM/lAQ5sKiqJuSZ
 Tbunt
X-Gm-Gg: ASbGncuJNnxuvSMbxk/Ii209YtGVdsibPXn85/IA/+uaxpvRTQ/4/uEkifaM699mUP9
 YNz7fUnPW/hbijWUzxpJcFTUJtC25j/QrXj/SG5acb+Vqf2hcfdgzv+e5radaNMPRhR033MIb0x
 UmBZKGQ8GNVPi3hna5hMrSGmoVXwvKi9ix5QbgCPo/fRRp5anDLCwe+w7wCKybouw7Ajf3c+Cbf
 wBMdfSjefIUBIdtC77avYKiMKU3LoM+euExV3I972r/PiW4nTVK7L2taltR/y/FIOYjB6V6e/mY
 bbw3CakZRPFngGlA3YwDMz+HqMPX1xSrqZR+94LNTOx3P9vBq0qNBwMewb4dGxt6JAHB4T7KP4u
 mCQzEVY956vgeOup60Wt7aLfWEaYFK8mxJt7P+AnAcuIm9+3zOKoNKejKTapzQAMdjN71N3bQXc
 5q3xpbDnobxl5yaQL2HLZw
X-Google-Smtp-Source: AGHT+IFRA6p1Pvm8HYNy1dm/oTavlhqmyn7hRZXZgFbKpgLF/fSxafqPdVapd1YTPGf/BSQBQcinxg==
X-Received: by 2002:a05:6a00:1486:b0:76a:d724:d71d with SMTP id
 d2e1a72fcca58-76ad724dd83mr1410851b3a.8.1753833633873; 
 Tue, 29 Jul 2025 17:00:33 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/89] linux-user/hppa: Create get_elf_platform
Date: Tue, 29 Jul 2025 13:58:50 -1000
Message-ID: <20250730000003.599084-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Move the string literal to a new function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c      |  2 +-
 linux-user/hppa/elfload.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7591ec3fb6..58f4b642a5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1053,7 +1053,7 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_PARISC
-#define ELF_PLATFORM    "PARISC"
+#define ELF_PLATFORM    get_elf_platform(thread_cpu)
 #define STACK_GROWS_DOWN 0
 #define STACK_ALIGNMENT  64
 
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 73fa78ef14..ff0c2b862a 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -1 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "loader.h"
+
+
+const char *get_elf_platform(CPUState *cs)
+{
+    return "PARISC";
+}
-- 
2.43.0


