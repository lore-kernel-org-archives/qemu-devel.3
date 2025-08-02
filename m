Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7786FC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLID-0000Yf-Ga; Sat, 02 Aug 2025 19:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLI8-0000SZ-7m
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:28 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLI6-00013H-9K
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:27 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-61585dfc8f8so1027536eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175925; x=1754780725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H0jeyCcSEjMBxTKGV/82sfQKVYsOIFo4wUMfyRnC/oo=;
 b=N+wn9uywBpYiWn4d3aLoB2BPLO8bRXik2sC4BRUx9W6GDBj3O99CHl2pOVXMvYRFAe
 e3y6rUekMKPsKWnAXdZMArD1VwtT89RARClCBQXdwkZmHOiovUF16zO8gdJZMFSIT8ph
 sLQACMYainQ5okmM0OLnR+4OrS1QZ2WBP6CYsqgOmr0gmpyiTCfK3TfthM8GW5T3wSCl
 lsboi33yJqJJqcDbl+WBQTh7UlXpCIxz2ft754VrY+P7R5lbfbI0pJEvivAdBJNb5CAA
 0Q+Qjm6Vn32P/yt5rjUS1cuMuMLhybCHJvGaBKyzgEpNHO3ljNcgRj/1NbZ+GxXpqQpz
 s+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175925; x=1754780725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0jeyCcSEjMBxTKGV/82sfQKVYsOIFo4wUMfyRnC/oo=;
 b=ra1O/HqGB/nt1ACfER37DzHkc5UqgWleyjUx5pWhgR1NeB2tJ8vU5AVBI+mA8ZNuay
 Y33sQst3VY9joY5+NA/hwSVq4H5JJF/ms6f/CiqHf353uzDYDPRZR7XUY48FxvlVkW8K
 M8GlutUCHvpcS4Vzp0lj62yT7J0wRdh7oK9jCufPQGFGJS0eUDVkGRw4kIK6pMgwGt+Q
 +z1DTyQ5ohsmwN5hwnSpwkpk4euAvtVQXSGU8mlh+CIukr8aZ/n3iov1zvd3tbfkOBru
 9wmA7RRkMbfm0gPpwVDfNf3uRuilRzC9xXEm+5MG69/lqFx/3BaKAlIXd7T+/QOb6FDq
 Y1cA==
X-Gm-Message-State: AOJu0Yxkcm7YrjP3E5asKWHww0Hj9auy8ZiNaLBn6ufItZyLcWx3Lnme
 Fpgx2iW41FkDh2eTm4RoETvU7k4HH20heIYeoyrLR2eCnK+/MJxVjIB0az2PB35iHIBu8K3d/eE
 8XM19fIM=
X-Gm-Gg: ASbGncuCM1BwIQRTOGpsmA7tf+8vZ/+45h71oW6Kiu1j5evyAfdG/9IRiUoPO54h45r
 psIiMFYttTGb6JdDbbfPpnYLhPfDJ3lsAisuJcLP6ZbYKR+lduo1KWs19zaThqzbj7DfD5lWC+L
 9Mj0VXQRPVr89Y12NClTIMXmbkTfHl3wCs0TiIQd4p7FMACkdSwvvACiEGeOUVsCY4/HiHw5Y6N
 8hQHZVZ7JAD2lSbDm9gveH63ddx0e+o4sGVEoprDSaYpjKPVEiU8eEIZMjW7MCaK0dOuLBZ88ut
 +++TD3OGa54hL76Oqy+dgGAKlqONUO+Bon9MBrQQ6PjgSRO7v3Zo37gtaiM06a91TIS8+lNmJ1X
 3c6x2AqIdwfwkjUKcIHIM/hfupu64U38Z8ylhUF03pxzvPHo+tCei
X-Google-Smtp-Source: AGHT+IGiQsoDl/Ug72WBvM2nQgZcYFt3cLKqSqmCwBRpyIYbqYDpltX78RC+5tOEKTVBPbb86aon0g==
X-Received: by 2002:a4a:edc5:0:b0:610:fc12:cbb4 with SMTP id
 006d021491bc7-6198f0be1e8mr2561854eaf.1.1754175924876; 
 Sat, 02 Aug 2025 16:05:24 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/95] linux-user: Move ppc uabi/asm/elf.h workaround to
 osdep.h
Date: Sun,  3 Aug 2025 09:03:28 +1000
Message-ID: <20250802230459.412251-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

Move the workaround out of linux-user/elfload.c, so that
we don't have to replicate it in many places.  Place it
immediately after the include of <signal.h>, which draws
in the relevant symbols.

Note that ARCH_DLINFO is not defined by the kernel header,
and so there's no need to undef it either.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h |  8 ++++++++
 hw/core/loader.c     |  4 ----
 linux-user/elfload.c | 10 ----------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 96fe51bc39..be3460b32f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -133,6 +133,14 @@ QEMU_EXTERN_C int daemon(int, int);
 #include <setjmp.h>
 #include <signal.h>
 
+/*
+ * Avoid conflict with linux/arch/powerpc/include/uapi/asm/elf.h, included
+ * from <asm/sigcontext.h>, but we might as well do this unconditionally.
+ */
+#undef ELF_CLASS
+#undef ELF_DATA
+#undef ELF_ARCH
+
 #ifdef CONFIG_IOVEC
 #include <sys/uio.h>
 #endif
diff --git a/hw/core/loader.c b/hw/core/loader.c
index e7056ba4bd..524af6f14a 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -295,10 +295,6 @@ static void *load_at(int fd, off_t offset, size_t size)
     return ptr;
 }
 
-#ifdef ELF_CLASS
-#undef ELF_CLASS
-#endif
-
 #define ELF_CLASS   ELFCLASS32
 #include "elf.h"
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ea214105ff..4ca8c39dc2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -35,16 +35,6 @@
 #include "target/arm/cpu-features.h"
 #endif
 
-#ifdef _ARCH_PPC64
-#undef ARCH_DLINFO
-#undef ELF_PLATFORM
-#undef ELF_HWCAP
-#undef ELF_HWCAP2
-#undef ELF_CLASS
-#undef ELF_DATA
-#undef ELF_ARCH
-#endif
-
 #ifndef TARGET_ARCH_HAS_SIGTRAMP_PAGE
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
 #endif
-- 
2.43.0


