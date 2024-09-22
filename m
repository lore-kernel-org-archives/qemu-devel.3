Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B74ECF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLIo-0007NL-Gw; Sun, 22 Sep 2024 08:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHW-00015v-IW
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:38 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHT-0002R2-EB
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:38 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d51a7d6f5so500914466b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006493; x=1727611293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMF6RMQzTkGIjOqPFaNa6l8f7P3+Jaf1fsLuA2qYISY=;
 b=tbT1ZRtRcKrh8jPc+q9UljlXkuvxA1a6mBUguH2IJ0BVKQTUljbtfRfVS0/UlZtA4A
 MprmZSzQMCWq4EG2YnusDccJLkOT2tVBMqN6OMJIYZFMrFKJUYRdHyigZKtasg1o9fyk
 sNno8wjvAIJHvKGlSjNJk8ykSL1oTuZLGcd3MGnckCJfY7PTPtFeFemiaIBeMg0uIBNQ
 o6PSv71DeTfW8d9Jbfvhwza4CcGmdSOcmM8nCgcYi31hIb0Gf46Jqe6BeM2pfQ6ppBxH
 hTI5+XZD6LanZEwdM4bE8IprN4bhgmzNiaBDtm9HHxaEQPpcs0VtfMMl/eRmlZjzujxv
 sPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006493; x=1727611293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMF6RMQzTkGIjOqPFaNa6l8f7P3+Jaf1fsLuA2qYISY=;
 b=OpfWCK9UhVOrf7EArCbpANXdSzNqRS3a2+05veMm3xfNv4sekO16iNoaFz6x9CcXCc
 7io4ZX8MOF2Gl9UBcxR1VTZoEt40Dcm0QKE8FvoL2040y4AsR1b7vOXt9TZsoxEo4kVy
 WCGbr5TIMpP+QCQnXXzmInaPGwDi7sHDiYT66k5A8mAfOTTB0kqTBtLAzJoVVq/tC289
 JiNl3lUHRm6yAXTNw/GmEBXGAN8EpO/bnrTEy9Z8nF4kK5Ug28k61iS7ow24dG7ASMGg
 7UBjcplE7teXj1zlZF2lMnPP2O6LEComg+LtPiq2svCh+ozSoZVPGQ+IJ4qB3UfsiuUZ
 vl6g==
X-Gm-Message-State: AOJu0YzCV+sK4VLJJj0Xb1M3lUNcx8+NlZpT1EJEhnpcSZ6bkPe/ZyjA
 W4usEGwXbyN8Lfya1wjV3rq9pqbgl+6r7cPJ6fUCMFAHIcmM+Ja+zYu5AYIfC7jc4elyC7rP+Le
 5G+A=
X-Google-Smtp-Source: AGHT+IEsIYByDZc8iG9sZTFcfZc8ybRAMKqypZ6Dp3+U799fhdgl+1afT7093xDCESWaoko2I4WX5w==
X-Received: by 2002:a17:907:1b10:b0:a90:4199:2a73 with SMTP id
 a640c23a62f3a-a90d4fdea16mr835489166b.5.1727006493364; 
 Sun, 22 Sep 2024 05:01:33 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 31/31] linux-user: update syscall.tbl to Linux v6.11
Date: Sun, 22 Sep 2024 14:01:12 +0200
Message-ID: <20240922120112.5067-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Laurent Vivier <laurent@vivier.eu>

Updated running scripts/update-syscalltbl.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20240920151034.859533-7-laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/syscall.tbl       | 1 +
 linux-user/i386/syscall_32.tbl   | 7 ++++---
 linux-user/x86_64/syscall_64.tbl | 8 +++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/linux-user/arm/syscall.tbl b/linux-user/arm/syscall.tbl
index 2ed7d229c8..23c98203c4 100644
--- a/linux-user/arm/syscall.tbl
+++ b/linux-user/arm/syscall.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # Linux system call numbers and entry vectors
 #
diff --git a/linux-user/i386/syscall_32.tbl b/linux-user/i386/syscall_32.tbl
index d6ebcab1d8..534c74b14f 100644
--- a/linux-user/i386/syscall_32.tbl
+++ b/linux-user/i386/syscall_32.tbl
@@ -1,8 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 32-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point> <compat entry point>
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
 #
 # The __ia32_sys and __ia32_compat_sys stubs are created on-the-fly for
 # sys_*() system calls and compat_sys_*() compat system calls if
@@ -12,7 +13,7 @@
 # The abi is always "i386" for this file.
 #
 0	i386	restart_syscall		sys_restart_syscall
-1	i386	exit			sys_exit
+1	i386	exit			sys_exit			-			noreturn
 2	i386	fork			sys_fork
 3	i386	read			sys_read
 4	i386	write			sys_write
@@ -263,7 +264,7 @@
 249	i386	io_cancel		sys_io_cancel
 250	i386	fadvise64		sys_ia32_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
-252	i386	exit_group		sys_exit_group
+252	i386	exit_group		sys_exit_group			-			noreturn
 253	i386	lookup_dcookie
 254	i386	epoll_create		sys_epoll_create
 255	i386	epoll_ctl		sys_epoll_ctl
diff --git a/linux-user/x86_64/syscall_64.tbl b/linux-user/x86_64/syscall_64.tbl
index a396f6e6ab..7093ee21c0 100644
--- a/linux-user/x86_64/syscall_64.tbl
+++ b/linux-user/x86_64/syscall_64.tbl
@@ -1,8 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 64-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point>
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
 #
 # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
 #
@@ -68,7 +69,7 @@
 57	common	fork			sys_fork
 58	common	vfork			sys_vfork
 59	64	execve			sys_execve
-60	common	exit			sys_exit
+60	common	exit			sys_exit			-			noreturn
 61	common	wait4			sys_wait4
 62	common	kill			sys_kill
 63	common	uname			sys_newuname
@@ -239,7 +240,7 @@
 228	common	clock_gettime		sys_clock_gettime
 229	common	clock_getres		sys_clock_getres
 230	common	clock_nanosleep		sys_clock_nanosleep
-231	common	exit_group		sys_exit_group
+231	common	exit_group		sys_exit_group			-			noreturn
 232	common	epoll_wait		sys_epoll_wait
 233	common	epoll_ctl		sys_epoll_ctl
 234	common	tgkill			sys_tgkill
@@ -343,6 +344,7 @@
 332	common	statx			sys_statx
 333	common	io_pgetevents		sys_io_pgetevents
 334	common	rseq			sys_rseq
+335	common	uretprobe		sys_uretprobe
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	sys_pidfd_send_signal
-- 
2.43.0


