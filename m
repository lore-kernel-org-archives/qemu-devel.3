Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF82CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkP-0002J8-TZ; Sat, 30 Aug 2025 11:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cB-0004zW-IE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:35 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c9-00041A-Me
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so2756908b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506632; x=1757111432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXwv+ZFBmnLT3vqO0wpKBBBu8DiiTjaPnesjLL2Fb9A=;
 b=m98BXMe8kRcCtYKZIx4da1kZPNnidO9/rVgN2NQ8c743n5aL7Bghm7qciNtYzxF92u
 NrR/hhT6pvKr9YpIcPjX6Wr/jdnchNfExYpsuqZGXrWjFro6VYfj4YVq/qyJLfFirvLX
 ChUFUclDFP5Zn/UdLaMANh4Wecvx/25kbGQKPp5Y7XOUg2zosO1/xHJYwQBcJcUSyLim
 +kWSuGZD8o8Op3MRsFUl9yk4ZGf6EAReRjUecFRyJDqEHzo+w5Dluaqc73cKPT4380Xy
 0AUb1AikYM4KY61oZG8HXrgIghN+Q5kns2JxDCx23Ms/iLKsLk+SFsFp9De/SA42k+i/
 eZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506632; x=1757111432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXwv+ZFBmnLT3vqO0wpKBBBu8DiiTjaPnesjLL2Fb9A=;
 b=ERtGL2dxxroQxC3/Y1VzmnKFaHHnKoHNPsNhY4PpOzZx6Jxv6tMHlFqjO6cX2rx8wP
 xLrMmpus2IPPscX+IvQDYIYhs6Q5wrier+9L+Z753MNZ8z3RyeQBE39dJt7Aq4xnXzFH
 97Yd3byw4xwIOEnzo8pr+B1h0Vxsu0zjRELsNVTj+vzeX7jyb53HqABPRYqOsMJ1I/2i
 W9A9/H6aZ8kxKHYKjNKNxU8HPhk1qAnguQT6N/nm+YK0CVAh0DMMM8KdgSyFoT4JDHQV
 ydxw+R9d/FEAU6nZ4hK4IKqISbu3VZbX9yaUpSIJ2407fB9ym4V7yfeqxJ+AUgBG/36Y
 USuw==
X-Gm-Message-State: AOJu0YxYhVOVApUKH4k0xWj0bJORnaCxXStYtjj4V7gao6SQK5+kBrAn
 1VOcf/sUPU2Z4E08QmzwBnogcnMak20+C2bLBxCfQtMqLJCRhnBuYESniDOKY+WBbtT2kfLp7qJ
 6D5ZjXPk=
X-Gm-Gg: ASbGncsSxeiJKchxNvcM1X0qT6rGMQbtSHO0u4GErO0voM5ag+r2NkcDWWJAqnBmjrJ
 rBeO9A+c/eO3PhIcU1pKvNId3YMYY5yTX/JTURr0OLUGlPtKwjAbmO5gkizbeOWo3JaS+vtz5Fe
 0kVqjqLuqPyA5YZeyO8e/EI1OrUOuQP4kSzI5v0XdDMhROMml0pdcdtzuXlRstUPjP+rBY+eWz3
 neKB2Szw0Jsdirbl6k5kM5uE4Y26AxdlBnJ9lAdp/4qaIzrdyyRdS60ACvMQjvjluisHdoNiV9v
 jqQ7VcpkaG4tZk2m5L9G/oEkyQ0dJfoLL4kDutrPAc2s66KSeo8X1KzuiuhjsqTBpArAXoEteP7
 dGh8ExW5bPYrZmflFI2zfkAEsFm406UBNHMjdojd03M7RcIeHgipebWHJbFpMCcqXJmZIyd86RT
 i0eqR9fx28
X-Google-Smtp-Source: AGHT+IHeqZiJ3E3GiJlHjmDaxhPUJntWt9YsEZ4jcJai70QuXxLvOovFXr9Z6BniHxeOKcXPPUWhBQ==
X-Received: by 2002:a05:6a20:1584:b0:243:aec9:41cb with SMTP id
 adf61e73a8af0-243d6e009femr341480637.17.1756506632202; 
 Fri, 29 Aug 2025 15:30:32 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 74/91] linux-user: Move elf parameters to
 microblaze/target_elf.h
Date: Sat, 30 Aug 2025 08:24:10 +1000
Message-ID: <20250829222427.289668-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_elf.h | 5 +++++
 linux-user/elfload.c               | 9 ---------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 56de77d4f3..a622cd8e43 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -10,6 +10,11 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_MICROBLAZE
+
+#define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
+
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a67147d43b..6c8771d804 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,15 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_MICROBLAZE
-
-#define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
-
-#define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_MICROBLAZE
-
-#endif /* TARGET_MICROBLAZE */
-
 #ifdef TARGET_OPENRISC
 
 #define ELF_ARCH EM_OPENRISC
-- 
2.43.0


