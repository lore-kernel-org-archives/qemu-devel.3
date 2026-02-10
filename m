Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6DAEA813A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq73-0007Tr-KO; Tue, 10 Feb 2026 10:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpq72-0007Th-8U
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:57:16 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpq6x-0005Z7-9G
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:57:15 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-89545bd3324so52580696d6.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770739030; x=1771343830;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WVNyf8npL5fhHE6PJvPT13uXTdsifB9/vPqLkBYUp4k=;
 b=wxA1PA5xiXTsPllPsZYvEwA2u21v4dbWgvP8TDuysCpcPG2w75lIBO3kkSIH4ybGBy
 vT9WL4X9R0KWft71jbdP8XP+KS0aFkekr5ZMGBozkFzhEFawQ5IT6EPNlZJr+umMVWcZ
 YxOfwJbe8jr0uHPpiWDKzyYAQXqnnmgfJ5KHSSHUXgrNSWY1tAR92NQzYNJ0hg3oNgq0
 vO/6opgr44EEyabRwutCQyj2fe84usRgsfxkRG0OLys3p5Gyaybt78cQIXPjLowA1s3O
 g6dbWGJP1QKindawuPFloIyq0Vg9SOTHIIatsfX7wsEIsUdJYxrUgOguqn2zTUxxLnka
 pm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739030; x=1771343830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WVNyf8npL5fhHE6PJvPT13uXTdsifB9/vPqLkBYUp4k=;
 b=FVYu2OFjFFqjvdyC4Z05w9j7MoKfIRwJFDGLRYsizVpMyh2E17UxvZKtmbxVMtIC2A
 QoCMhjrAYZCOwJLLaMqcDkJDlUn4qKghgKFYsVu7QqmNiGEq+HjWfnxwKIMgvJj8vREB
 yXSikkL5alL5YMl31UXWhOSq0gKxJ/dKh9Ng7QUYMIl5HwHz9P5e2lFQPGjg2wyPRAnl
 uYRDjQdcsZO2idDgcXzKvHuUONX/F2VaU7WgM0fWpiMbjgPYusT/qQNLJQm2VWmvGHv+
 ayVEPbEijFyRgv07f3OveLrwWuktz5108x+uMPfRMuFojjb+jxYM4qtNq46YP6Ky/Pkf
 GV/Q==
X-Gm-Message-State: AOJu0YxR09MXoCVqYtnDWxKs5RhOU5NeawuNLc4zRYv03NBdR4vJQ3de
 DZbf4dGBjkO90lFQO0/xM056dVyoehFwTiJnBcAnda+bXlRHfslgBqmcPG1kjBTmkGiM+0enXI2
 b65dJVsQ=
X-Gm-Gg: AZuq6aJBpcukaNDLXWGZspzSAzTe1+iNnzPUy8m40R3HsunldaaQS5Zz3ev/FYN4DgX
 /BdsBZqnmiSfsd56rxpEO2m45i6A93mx8V/JLUD2lRcXwB3kosD55HDMMZfONhCjfbveWCAdltE
 V7xAI2QtMF7+jQkZpZa+q2M5/7b3b//KUYiLRYuib+eSOZDZOayDmTr158a9oajFERWrE4CiNjM
 aauY75cyIQuY2QVGYkxBxYs1YlsO45RgH0uJYAAwlw5pmFmCXlrYlLvvuI8bWBB0CKk0UDGDUlc
 YtPh1zEiiVGuIbhick1ii32gLjiEHVFtxg0nEH7/xUG8NYi5gHfSxklV+C49oijj7Q7UxOebI+S
 ecYo5NkLMAr0ktH1HcZznU0yooF816RqiHxSaJ9PxsO7mHiux5Rsa+3+GMPoiECHi9Qt55pfnOC
 Tr8JWgpuKNYw==
X-Received: by 2002:a05:6830:688a:b0:7d1:9c68:8d9d with SMTP id
 46e09a7af769-7d464697ac9mr7205735a34.29.1770738402848; 
 Tue, 10 Feb 2026 07:46:42 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464457a98sm9841679a34.0.2026.02.10.07.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:46:42 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 08:46:18 -0700
Subject: [PATCH v2 2/2] bsd-user: Remove NetBSD supprot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-bsd-user-rm-openbsd-netbsd-v2-2-3dd10091d359@bsdimp.com>
References: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
In-Reply-To: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=47225; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Qdr+ej8KC4Ti0PQYL1nGknJ26vGD52x6ZrGHg7cn36c=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpi1LfnG7h0SRXEBbc/pBF1TUR16cDl7F0r1Km9
 zR1BTve0pyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYtS3wAKCRBsHNEofbAR
 ALQvD/0Yf/wvqwXTpwEhs9IpmZ6/xNDbQEl4uZzOOUKURGL08DD508LMDIbScnZJRRCL/VR2SDE
 zLZoGIMv1nvSm6MLwpQyMArZ718naed87E7tDa5yXOQAb2XGmbmWRxk0InU8q2Wj7zBeMQdBXC/
 NaKSvNL0tfq7Q4t8ybzS3DHQh8x9opPA59RWnN0QEaP5Y4KfyTieZfVbncAwwxUbVQFiqYjHU+r
 TZoFnnweCW+zZnXhdU8GieCDe+e81lD4yu6NgAV6fbb2attQw0yLUQX3260L0KS6vyLCBPBAcZW
 gB2NUxTPoOWLFt8twOffq11RbqJYYNjj61Jo278BnNkqazj3ZvKcoZuI9e5UeU19snroz6A9Xda
 TTdHuOioAweMGRqrYp8CITjgC9NZPrPCN7Q+FO1zjBbhbyF4BUTAhTZLF+CTEGRPKqLe+hm4AV9
 5vta6kRvFSI1vWoMwg/P7DwvXq50Coo9V2Rrpk208c7ZONGJAuguAAEwL1eXXjKWjCX4BzsCt72
 oHVfQYI0sGF8/OG790ntYET7wMnQCKsnqW7nALPMj7nLEW9X2NI1k8Kk4GtYKz/ENKBLf1DE4qq
 jxXdkhr9+fKP7La9GMPzZAV5XSyWY3D8mDfS8HJFCJ0wjASTsUsUJ4gFp53EYR6P9rPR8kTazC0
 Tc5L22pZYRUWvWw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=imp@bsdimp.com; helo=mail-qv1-xf2d.google.com
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

Remove the NetBSD specific code form bsd-user. It's not been maintained
in any meaningful way since it was introduced to the tree in 2008. It
hasn't been connected to the build since 2021, and last time (in 2023) I
tried to mock-up the meson support it needed, it failed to build. While
there were some out-of-tree work, I've not been able to connect with
that code.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/netbsd/host-os.h           |  25 ---
 bsd-user/netbsd/os-strace.h         |   1 -
 bsd-user/netbsd/strace.list         | 145 --------------
 bsd-user/netbsd/syscall_nr.h        | 373 ------------------------------------
 bsd-user/netbsd/target_os_elf.h     | 148 --------------
 bsd-user/netbsd/target_os_siginfo.h |  82 --------
 bsd-user/netbsd/target_os_signal.h  |  69 -------
 bsd-user/netbsd/target_os_stack.h   |  56 ------
 bsd-user/netbsd/target_os_thread.h  |  25 ---
 bsd-user/qemu.h                     |   8 -
 bsd-user/strace.c                   |  17 --
 bsd-user/syscall_defs.h             |  13 --
 12 files changed, 962 deletions(-)

diff --git a/bsd-user/netbsd/host-os.h b/bsd-user/netbsd/host-os.h
deleted file mode 100644
index 7c14b1ea78..0000000000
--- a/bsd-user/netbsd/host-os.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  NetBSD host dependent code and definitions
- *
- *  Copyright (c) 2013 Stacey D. Son
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef HOST_OS_H
-#define HOST_OS_H
-
-#define HOST_DEFAULT_BSD_TYPE target_netbsd
-
-#endif /* HOST_OS_H */
diff --git a/bsd-user/netbsd/os-strace.h b/bsd-user/netbsd/os-strace.h
deleted file mode 100644
index 70cf51d63a..0000000000
--- a/bsd-user/netbsd/os-strace.h
+++ /dev/null
@@ -1 +0,0 @@
-/* XXX NetBSD dependent strace print functions */
diff --git a/bsd-user/netbsd/strace.list b/bsd-user/netbsd/strace.list
deleted file mode 100644
index 5609d70d65..0000000000
--- a/bsd-user/netbsd/strace.list
+++ /dev/null
@@ -1,145 +0,0 @@
-{ TARGET_NETBSD_NR___getcwd, "__getcwd", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR___syscall, "__syscall", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR___sysctl, "__sysctl", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_accept, "accept", "%s(%d,%#x,%#x)", NULL, NULL },
-{ TARGET_NETBSD_NR_access, "access", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_NETBSD_NR_acct, "acct", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_adjtime, "adjtime", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_bind, "bind", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_break, "break", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_chdir, "chdir", "%s(\"%s\")", NULL, NULL },
-{ TARGET_NETBSD_NR_chflags, "chflags", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_chmod, "chmod", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_NETBSD_NR_chown, "chown", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_chroot, "chroot", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_clock_getres, "clock_getres", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_clock_gettime, "clock_gettime", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_clock_settime, "clock_settime", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_close, "close", "%s(%d)", NULL, NULL },
-{ TARGET_NETBSD_NR_connect, "connect", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_NETBSD_NR_dup, "dup", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_dup2, "dup2", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_execve, "execve", NULL, print_execve, NULL },
-{ TARGET_NETBSD_NR_exit, "exit", "%s(%d)\n", NULL, NULL },
-{ TARGET_NETBSD_NR_fchdir, "fchdir", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_fchflags, "fchflags", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_fchmod, "fchmod", "%s(%d,%#o)", NULL, NULL },
-{ TARGET_NETBSD_NR_fchown, "fchown", "%s(\"%s\",%d,%d)", NULL, NULL },
-{ TARGET_NETBSD_NR_fcntl, "fcntl", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_flock, "flock", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_fork, "fork", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_fpathconf, "fpathconf", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_fsync, "fsync", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_ftruncate, "ftruncate", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_futimes, "futimes", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getegid, "getegid", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_geteuid, "geteuid", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_getgid, "getgid", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_getgroups, "getgroups", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getitimer, "getitimer", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getpeername, "getpeername", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getpgid, "getpgid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getpgrp, "getpgrp", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_getpid, "getpid", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_getppid, "getppid", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
-{ TARGET_NETBSD_NR_getrlimit, "getrlimit", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getrusage, "getrusage", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getsid, "getsid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getsockname, "getsockname", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getsockopt, "getsockopt", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_gettimeofday, "gettimeofday", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_getuid, "getuid", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_ioctl, "ioctl", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_issetugid, "issetugid", "%s()", NULL, NULL },
-{ TARGET_NETBSD_NR_kevent, "kevent", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_kill, "kill", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_kqueue, "kqueue", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_ktrace, "ktrace", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_lchown, "lchown", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_lfs_bmapv, "lfs_bmapv", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_lfs_markv, "lfs_markv", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_lfs_segclean, "lfs_segclean", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_lfs_segwait, "lfs_segwait", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_link, "link", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_NETBSD_NR_listen, "listen", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_lseek, "lseek", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_madvise, "madvise", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_mincore, "mincore", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_minherit, "minherit", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_mkdir, "mkdir", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_NETBSD_NR_mkfifo, "mkfifo", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_mknod, "mknod", "%s(\"%s\",%#o,%#x)", NULL, NULL },
-{ TARGET_NETBSD_NR_mlock, "mlock", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_mlockall, "mlockall", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_mmap, "mmap", NULL, NULL, print_syscall_ret_addr },
-{ TARGET_NETBSD_NR_mprotect, "mprotect", "%s(%#x,%#x,%d)", NULL, NULL },
-{ TARGET_NETBSD_NR_msgget, "msgget", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_msgrcv, "msgrcv", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_msgsnd, "msgsnd", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_munlock, "munlock", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_munlockall, "munlockall", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_munmap, "munmap", "%s(%p,%d)", NULL, NULL },
-{ TARGET_NETBSD_NR_nanosleep, "nanosleep", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_nfssvc, "nfssvc", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_open, "open", "%s(\"%s\",%#x,%#o)", NULL, NULL },
-{ TARGET_NETBSD_NR_pathconf, "pathconf", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_pipe, "pipe", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_poll, "poll", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_pread, "pread", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_preadv, "preadv", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_profil, "profil", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_ptrace, "ptrace", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_pwrite, "pwrite", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_pwritev, "pwritev", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_quotactl, "quotactl", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_read, "read", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_NETBSD_NR_readlink, "readlink", "%s(\"%s\",%p,%d)", NULL, NULL },
-{ TARGET_NETBSD_NR_readv, "readv", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_reboot, "reboot", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_recvfrom, "recvfrom", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_recvmsg, "recvmsg", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_rename, "rename", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_NETBSD_NR_revoke, "revoke", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_rmdir, "rmdir", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_sbrk, "sbrk", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_sched_yield, "sched_yield", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_select, "select", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_semget, "semget", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_semop, "semop", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_sendmsg, "sendmsg", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_sendto, "sendto", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setegid, "setegid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_seteuid, "seteuid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setgid, "setgid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setgroups, "setgroups", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setitimer, "setitimer", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setpgid, "setpgid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setpriority, "setpriority", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setregid, "setregid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setreuid, "setreuid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setrlimit, "setrlimit", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setsid, "setsid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setsockopt, "setsockopt", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_settimeofday, "settimeofday", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_setuid, "setuid", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_shmat, "shmat", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_shmdt, "shmdt", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_shmget, "shmget", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_shutdown, "shutdown", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_socketpair, "socketpair", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_sstk, "sstk", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_swapctl, "swapctl", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_symlink, "symlink", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_NETBSD_NR_sync, "sync", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_sysarch, "sysarch", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_syscall, "syscall", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_truncate, "truncate", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_umask, "umask", "%s(%#o)", NULL, NULL },
-{ TARGET_NETBSD_NR_unlink, "unlink", "%s(\"%s\")", NULL, NULL },
-{ TARGET_NETBSD_NR_unmount, "unmount", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_utimes, "utimes", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_vfork, "vfork", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_wait4, "wait4", NULL, NULL, NULL },
-{ TARGET_NETBSD_NR_write, "write", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_NETBSD_NR_writev, "writev", "%s(%d,%p,%#x)", NULL, NULL },
diff --git a/bsd-user/netbsd/syscall_nr.h b/bsd-user/netbsd/syscall_nr.h
deleted file mode 100644
index 2e9ab5378e..0000000000
--- a/bsd-user/netbsd/syscall_nr.h
+++ /dev/null
@@ -1,373 +0,0 @@
-/* $NetBSD: syscall.h,v 1.215 2008/06/17 16:07:57 tsutsui Exp $ */
-
-/*
- * System call numbers.
- *
- * created from	NetBSD: syscalls.master,v 1.204 2008/06/17 16:05:23 tsutsui Exp
- */
-
-#define TARGET_NETBSD_NR_syscall     0
-#define TARGET_NETBSD_NR_exit        1
-#define TARGET_NETBSD_NR_fork        2
-#define TARGET_NETBSD_NR_read        3
-#define TARGET_NETBSD_NR_write       4
-#define TARGET_NETBSD_NR_open        5
-#define TARGET_NETBSD_NR_close       6
-#define TARGET_NETBSD_NR_wait4       7
-#define TARGET_NETBSD_NR_compat_43_ocreat    8
-#define TARGET_NETBSD_NR_link        9
-#define TARGET_NETBSD_NR_unlink      10
-#define TARGET_NETBSD_NR_chdir       12
-#define TARGET_NETBSD_NR_fchdir      13
-#define TARGET_NETBSD_NR_mknod       14
-#define TARGET_NETBSD_NR_chmod       15
-#define TARGET_NETBSD_NR_chown       16
-#define TARGET_NETBSD_NR_break       17
-#define TARGET_NETBSD_NR_compat_20_getfsstat 18
-#define TARGET_NETBSD_NR_compat_43_olseek    19
-#define TARGET_NETBSD_NR_getpid      20
-#define TARGET_NETBSD_NR_getpid      20
-#define TARGET_NETBSD_NR_compat_40_mount     21
-#define TARGET_NETBSD_NR_unmount     22
-#define TARGET_NETBSD_NR_setuid      23
-#define TARGET_NETBSD_NR_getuid      24
-#define TARGET_NETBSD_NR_getuid      24
-#define TARGET_NETBSD_NR_geteuid     25
-#define TARGET_NETBSD_NR_ptrace      26
-#define TARGET_NETBSD_NR_recvmsg     27
-#define TARGET_NETBSD_NR_sendmsg     28
-#define TARGET_NETBSD_NR_recvfrom    29
-#define TARGET_NETBSD_NR_accept      30
-#define TARGET_NETBSD_NR_getpeername 31
-#define TARGET_NETBSD_NR_getsockname 32
-#define TARGET_NETBSD_NR_access      33
-#define TARGET_NETBSD_NR_chflags     34
-#define TARGET_NETBSD_NR_fchflags    35
-#define TARGET_NETBSD_NR_sync        36
-#define TARGET_NETBSD_NR_kill        37
-#define TARGET_NETBSD_NR_compat_43_stat43    38
-#define TARGET_NETBSD_NR_getppid     39
-#define TARGET_NETBSD_NR_compat_43_lstat43   40
-#define TARGET_NETBSD_NR_dup 41
-#define TARGET_NETBSD_NR_pipe        42
-#define TARGET_NETBSD_NR_getegid     43
-#define TARGET_NETBSD_NR_profil      44
-#define TARGET_NETBSD_NR_ktrace      45
-#define TARGET_NETBSD_NR_compat_13_sigaction13       46
-#define TARGET_NETBSD_NR_getgid      47
-#define TARGET_NETBSD_NR_getgid      47
-#define TARGET_NETBSD_NR_compat_13_sigprocmask13     48
-#define TARGET_NETBSD_NR___getlogin  49
-#define TARGET_NETBSD_NR___setlogin  50
-#define TARGET_NETBSD_NR_acct        51
-#define TARGET_NETBSD_NR_compat_13_sigpending13      52
-#define TARGET_NETBSD_NR_compat_13_sigaltstack13     53
-#define TARGET_NETBSD_NR_ioctl       54
-#define TARGET_NETBSD_NR_compat_12_oreboot   55
-#define TARGET_NETBSD_NR_revoke      56
-#define TARGET_NETBSD_NR_symlink     57
-#define TARGET_NETBSD_NR_readlink    58
-#define TARGET_NETBSD_NR_execve      59
-#define TARGET_NETBSD_NR_umask       60
-#define TARGET_NETBSD_NR_chroot      61
-#define TARGET_NETBSD_NR_compat_43_fstat43   62
-#define TARGET_NETBSD_NR_compat_43_ogetkerninfo      63
-#define TARGET_NETBSD_NR_compat_43_ogetpagesize      64
-#define TARGET_NETBSD_NR_compat_12_msync     65
-#define TARGET_NETBSD_NR_vfork       66
-#define TARGET_NETBSD_NR_sbrk        69
-#define TARGET_NETBSD_NR_sstk        70
-#define TARGET_NETBSD_NR_compat_43_ommap     71
-#define TARGET_NETBSD_NR_vadvise     72
-#define TARGET_NETBSD_NR_munmap      73
-#define TARGET_NETBSD_NR_mprotect    74
-#define TARGET_NETBSD_NR_madvise     75
-#define TARGET_NETBSD_NR_mincore     78
-#define TARGET_NETBSD_NR_getgroups   79
-#define TARGET_NETBSD_NR_setgroups   80
-#define TARGET_NETBSD_NR_getpgrp     81
-#define TARGET_NETBSD_NR_setpgid     82
-#define TARGET_NETBSD_NR_setitimer   83
-#define TARGET_NETBSD_NR_compat_43_owait     84
-#define TARGET_NETBSD_NR_compat_12_oswapon   85
-#define TARGET_NETBSD_NR_getitimer   86
-#define TARGET_NETBSD_NR_compat_43_ogethostname      87
-#define TARGET_NETBSD_NR_compat_43_osethostname      88
-#define TARGET_NETBSD_NR_compat_43_ogetdtablesize    89
-#define TARGET_NETBSD_NR_dup2        90
-#define TARGET_NETBSD_NR_fcntl       92
-#define TARGET_NETBSD_NR_select      93
-#define TARGET_NETBSD_NR_fsync       95
-#define TARGET_NETBSD_NR_setpriority 96
-#define TARGET_NETBSD_NR_compat_30_socket    97
-#define TARGET_NETBSD_NR_connect     98
-#define TARGET_NETBSD_NR_compat_43_oaccept   99
-#define TARGET_NETBSD_NR_getpriority 100
-#define TARGET_NETBSD_NR_compat_43_osend     101
-#define TARGET_NETBSD_NR_compat_43_orecv     102
-#define TARGET_NETBSD_NR_compat_13_sigreturn13       103
-#define TARGET_NETBSD_NR_bind        104
-#define TARGET_NETBSD_NR_setsockopt  105
-#define TARGET_NETBSD_NR_listen      106
-#define TARGET_NETBSD_NR_compat_43_osigvec   108
-#define TARGET_NETBSD_NR_compat_43_osigblock 109
-#define TARGET_NETBSD_NR_compat_43_osigsetmask       110
-#define TARGET_NETBSD_NR_compat_13_sigsuspend13      111
-#define TARGET_NETBSD_NR_compat_43_osigstack 112
-#define TARGET_NETBSD_NR_compat_43_orecvmsg  113
-#define TARGET_NETBSD_NR_compat_43_osendmsg  114
-#define TARGET_NETBSD_NR_gettimeofday        116
-#define TARGET_NETBSD_NR_getrusage   117
-#define TARGET_NETBSD_NR_getsockopt  118
-#define TARGET_NETBSD_NR_readv       120
-#define TARGET_NETBSD_NR_writev      121
-#define TARGET_NETBSD_NR_settimeofday        122
-#define TARGET_NETBSD_NR_fchown      123
-#define TARGET_NETBSD_NR_fchmod      124
-#define TARGET_NETBSD_NR_compat_43_orecvfrom 125
-#define TARGET_NETBSD_NR_setreuid    126
-#define TARGET_NETBSD_NR_setregid    127
-#define TARGET_NETBSD_NR_rename      128
-#define TARGET_NETBSD_NR_compat_43_otruncate 129
-#define TARGET_NETBSD_NR_compat_43_oftruncate        130
-#define TARGET_NETBSD_NR_flock       131
-#define TARGET_NETBSD_NR_mkfifo      132
-#define TARGET_NETBSD_NR_sendto      133
-#define TARGET_NETBSD_NR_shutdown    134
-#define TARGET_NETBSD_NR_socketpair  135
-#define TARGET_NETBSD_NR_mkdir       136
-#define TARGET_NETBSD_NR_rmdir       137
-#define TARGET_NETBSD_NR_utimes      138
-#define TARGET_NETBSD_NR_adjtime     140
-#define TARGET_NETBSD_NR_compat_43_ogetpeername      141
-#define TARGET_NETBSD_NR_compat_43_ogethostid        142
-#define TARGET_NETBSD_NR_compat_43_osethostid        143
-#define TARGET_NETBSD_NR_compat_43_ogetrlimit        144
-#define TARGET_NETBSD_NR_compat_43_osetrlimit        145
-#define TARGET_NETBSD_NR_compat_43_okillpg   146
-#define TARGET_NETBSD_NR_setsid      147
-#define TARGET_NETBSD_NR_quotactl    148
-#define TARGET_NETBSD_NR_compat_43_oquota    149
-#define TARGET_NETBSD_NR_compat_43_ogetsockname      150
-#define TARGET_NETBSD_NR_nfssvc      155
-#define TARGET_NETBSD_NR_compat_43_ogetdirentries    156
-#define TARGET_NETBSD_NR_compat_20_statfs    157
-#define TARGET_NETBSD_NR_compat_20_fstatfs   158
-#define TARGET_NETBSD_NR_compat_30_getfh     161
-#define TARGET_NETBSD_NR_compat_09_ogetdomainname    162
-#define TARGET_NETBSD_NR_compat_09_osetdomainname    163
-#define TARGET_NETBSD_NR_compat_09_ouname    164
-#define TARGET_NETBSD_NR_sysarch     165
-#define TARGET_NETBSD_NR_compat_10_osemsys   169
-#define TARGET_NETBSD_NR_compat_10_omsgsys   170
-#define TARGET_NETBSD_NR_compat_10_oshmsys   171
-#define TARGET_NETBSD_NR_pread       173
-#define TARGET_NETBSD_NR_pwrite      174
-#define TARGET_NETBSD_NR_compat_30_ntp_gettime       175
-#define TARGET_NETBSD_NR_ntp_adjtime 176
-#define TARGET_NETBSD_NR_setgid      181
-#define TARGET_NETBSD_NR_setegid     182
-#define TARGET_NETBSD_NR_seteuid     183
-#define TARGET_NETBSD_NR_lfs_bmapv   184
-#define TARGET_NETBSD_NR_lfs_markv   185
-#define TARGET_NETBSD_NR_lfs_segclean        186
-#define TARGET_NETBSD_NR_lfs_segwait 187
-#define TARGET_NETBSD_NR_compat_12_stat12    188
-#define TARGET_NETBSD_NR_compat_12_fstat12   189
-#define TARGET_NETBSD_NR_compat_12_lstat12   190
-#define TARGET_NETBSD_NR_pathconf    191
-#define TARGET_NETBSD_NR_fpathconf   192
-#define TARGET_NETBSD_NR_getrlimit   194
-#define TARGET_NETBSD_NR_setrlimit   195
-#define TARGET_NETBSD_NR_compat_12_getdirentries     196
-#define TARGET_NETBSD_NR_mmap        197
-#define TARGET_NETBSD_NR___syscall   198
-#define TARGET_NETBSD_NR_lseek       199
-#define TARGET_NETBSD_NR_truncate    200
-#define TARGET_NETBSD_NR_ftruncate   201
-#define TARGET_NETBSD_NR___sysctl    202
-#define TARGET_NETBSD_NR_mlock       203
-#define TARGET_NETBSD_NR_munlock     204
-#define TARGET_NETBSD_NR_undelete    205
-#define TARGET_NETBSD_NR_futimes     206
-#define TARGET_NETBSD_NR_getpgid     207
-#define TARGET_NETBSD_NR_reboot      208
-#define TARGET_NETBSD_NR_poll        209
-#define TARGET_NETBSD_NR_compat_14___semctl  220
-#define TARGET_NETBSD_NR_semget      221
-#define TARGET_NETBSD_NR_semop       222
-#define TARGET_NETBSD_NR_semconfig   223
-#define TARGET_NETBSD_NR_compat_14_msgctl    224
-#define TARGET_NETBSD_NR_msgget      225
-#define TARGET_NETBSD_NR_msgsnd      226
-#define TARGET_NETBSD_NR_msgrcv      227
-#define TARGET_NETBSD_NR_shmat       228
-#define TARGET_NETBSD_NR_compat_14_shmctl    229
-#define TARGET_NETBSD_NR_shmdt       230
-#define TARGET_NETBSD_NR_shmget      231
-#define TARGET_NETBSD_NR_clock_gettime       232
-#define TARGET_NETBSD_NR_clock_settime       233
-#define TARGET_NETBSD_NR_clock_getres        234
-#define TARGET_NETBSD_NR_timer_create        235
-#define TARGET_NETBSD_NR_timer_delete        236
-#define TARGET_NETBSD_NR_timer_settime       237
-#define TARGET_NETBSD_NR_timer_gettime       238
-#define TARGET_NETBSD_NR_timer_getoverrun    239
-#define TARGET_NETBSD_NR_nanosleep   240
-#define TARGET_NETBSD_NR_fdatasync   241
-#define TARGET_NETBSD_NR_mlockall    242
-#define TARGET_NETBSD_NR_munlockall  243
-#define TARGET_NETBSD_NR___sigtimedwait      244
-#define TARGET_NETBSD_NR_modctl      246
-#define TARGET_NETBSD_NR__ksem_init  247
-#define TARGET_NETBSD_NR__ksem_open  248
-#define TARGET_NETBSD_NR__ksem_unlink        249
-#define TARGET_NETBSD_NR__ksem_close 250
-#define TARGET_NETBSD_NR__ksem_post  251
-#define TARGET_NETBSD_NR__ksem_wait  252
-#define TARGET_NETBSD_NR__ksem_trywait       253
-#define TARGET_NETBSD_NR__ksem_getvalue      254
-#define TARGET_NETBSD_NR__ksem_destroy       255
-#define TARGET_NETBSD_NR_mq_open     257
-#define TARGET_NETBSD_NR_mq_close    258
-#define TARGET_NETBSD_NR_mq_unlink   259
-#define TARGET_NETBSD_NR_mq_getattr  260
-#define TARGET_NETBSD_NR_mq_setattr  261
-#define TARGET_NETBSD_NR_mq_notify   262
-#define TARGET_NETBSD_NR_mq_send     263
-#define TARGET_NETBSD_NR_mq_receive  264
-#define TARGET_NETBSD_NR_mq_timedsend        265
-#define TARGET_NETBSD_NR_mq_timedreceive     266
-#define TARGET_NETBSD_NR___posix_rename      270
-#define TARGET_NETBSD_NR_swapctl     271
-#define TARGET_NETBSD_NR_compat_30_getdents  272
-#define TARGET_NETBSD_NR_minherit    273
-#define TARGET_NETBSD_NR_lchmod      274
-#define TARGET_NETBSD_NR_lchown      275
-#define TARGET_NETBSD_NR_lutimes     276
-#define TARGET_NETBSD_NR___msync13   277
-#define TARGET_NETBSD_NR_compat_30___stat13  278
-#define TARGET_NETBSD_NR_compat_30___fstat13 279
-#define TARGET_NETBSD_NR_compat_30___lstat13 280
-#define TARGET_NETBSD_NR___sigaltstack14     281
-#define TARGET_NETBSD_NR___vfork14   282
-#define TARGET_NETBSD_NR___posix_chown       283
-#define TARGET_NETBSD_NR___posix_fchown      284
-#define TARGET_NETBSD_NR___posix_lchown      285
-#define TARGET_NETBSD_NR_getsid      286
-#define TARGET_NETBSD_NR___clone     287
-#define TARGET_NETBSD_NR_fktrace     288
-#define TARGET_NETBSD_NR_preadv      289
-#define TARGET_NETBSD_NR_pwritev     290
-#define TARGET_NETBSD_NR_compat_16___sigaction14     291
-#define TARGET_NETBSD_NR___sigpending14      292
-#define TARGET_NETBSD_NR___sigprocmask14     293
-#define TARGET_NETBSD_NR___sigsuspend14      294
-#define TARGET_NETBSD_NR_compat_16___sigreturn14     295
-#define TARGET_NETBSD_NR___getcwd    296
-#define TARGET_NETBSD_NR_fchroot     297
-#define TARGET_NETBSD_NR_compat_30_fhopen    298
-#define TARGET_NETBSD_NR_compat_30_fhstat    299
-#define TARGET_NETBSD_NR_compat_20_fhstatfs  300
-#define TARGET_NETBSD_NR_____semctl13        301
-#define TARGET_NETBSD_NR___msgctl13  302
-#define TARGET_NETBSD_NR___shmctl13  303
-#define TARGET_NETBSD_NR_lchflags    304
-#define TARGET_NETBSD_NR_issetugid   305
-#define TARGET_NETBSD_NR_utrace      306
-#define TARGET_NETBSD_NR_getcontext  307
-#define TARGET_NETBSD_NR_setcontext  308
-#define TARGET_NETBSD_NR__lwp_create 309
-#define TARGET_NETBSD_NR__lwp_exit   310
-#define TARGET_NETBSD_NR__lwp_self   311
-#define TARGET_NETBSD_NR__lwp_wait   312
-#define TARGET_NETBSD_NR__lwp_suspend        313
-#define TARGET_NETBSD_NR__lwp_continue       314
-#define TARGET_NETBSD_NR__lwp_wakeup 315
-#define TARGET_NETBSD_NR__lwp_getprivate     316
-#define TARGET_NETBSD_NR__lwp_setprivate     317
-#define TARGET_NETBSD_NR__lwp_kill   318
-#define TARGET_NETBSD_NR__lwp_detach 319
-#define TARGET_NETBSD_NR__lwp_park   320
-#define TARGET_NETBSD_NR__lwp_unpark 321
-#define TARGET_NETBSD_NR__lwp_unpark_all     322
-#define TARGET_NETBSD_NR__lwp_setname        323
-#define TARGET_NETBSD_NR__lwp_getname        324
-#define TARGET_NETBSD_NR__lwp_ctl    325
-#define TARGET_NETBSD_NR_sa_register 330
-#define TARGET_NETBSD_NR_sa_stacks   331
-#define TARGET_NETBSD_NR_sa_enable   332
-#define TARGET_NETBSD_NR_sa_setconcurrency   333
-#define TARGET_NETBSD_NR_sa_yield    334
-#define TARGET_NETBSD_NR_sa_preempt  335
-#define TARGET_NETBSD_NR_sa_unblockyield     336
-#define TARGET_NETBSD_NR___sigaction_sigtramp        340
-#define TARGET_NETBSD_NR_pmc_get_info        341
-#define TARGET_NETBSD_NR_pmc_control 342
-#define TARGET_NETBSD_NR_rasctl      343
-#define TARGET_NETBSD_NR_kqueue      344
-#define TARGET_NETBSD_NR_kevent      345
-#define TARGET_NETBSD_NR__sched_setparam     346
-#define TARGET_NETBSD_NR__sched_getparam     347
-#define TARGET_NETBSD_NR__sched_setaffinity  348
-#define TARGET_NETBSD_NR__sched_getaffinity  349
-#define TARGET_NETBSD_NR_sched_yield 350
-#define TARGET_NETBSD_NR_fsync_range 354
-#define TARGET_NETBSD_NR_uuidgen     355
-#define TARGET_NETBSD_NR_getvfsstat  356
-#define TARGET_NETBSD_NR_statvfs1    357
-#define TARGET_NETBSD_NR_fstatvfs1   358
-#define TARGET_NETBSD_NR_compat_30_fhstatvfs1        359
-#define TARGET_NETBSD_NR_extattrctl  360
-#define TARGET_NETBSD_NR_extattr_set_file    361
-#define TARGET_NETBSD_NR_extattr_get_file    362
-#define TARGET_NETBSD_NR_extattr_delete_file 363
-#define TARGET_NETBSD_NR_extattr_set_fd      364
-#define TARGET_NETBSD_NR_extattr_get_fd      365
-#define TARGET_NETBSD_NR_extattr_delete_fd   366
-#define TARGET_NETBSD_NR_extattr_set_link    367
-#define TARGET_NETBSD_NR_extattr_get_link    368
-#define TARGET_NETBSD_NR_extattr_delete_link 369
-#define TARGET_NETBSD_NR_extattr_list_fd     370
-#define TARGET_NETBSD_NR_extattr_list_file   371
-#define TARGET_NETBSD_NR_extattr_list_link   372
-#define TARGET_NETBSD_NR_pselect     373
-#define TARGET_NETBSD_NR_pollts      374
-#define TARGET_NETBSD_NR_setxattr    375
-#define TARGET_NETBSD_NR_lsetxattr   376
-#define TARGET_NETBSD_NR_fsetxattr   377
-#define TARGET_NETBSD_NR_getxattr    378
-#define TARGET_NETBSD_NR_lgetxattr   379
-#define TARGET_NETBSD_NR_fgetxattr   380
-#define TARGET_NETBSD_NR_listxattr   381
-#define TARGET_NETBSD_NR_llistxattr  382
-#define TARGET_NETBSD_NR_flistxattr  383
-#define TARGET_NETBSD_NR_removexattr 384
-#define TARGET_NETBSD_NR_lremovexattr        385
-#define TARGET_NETBSD_NR_fremovexattr        386
-#define TARGET_NETBSD_NR___stat30    387
-#define TARGET_NETBSD_NR___fstat30   388
-#define TARGET_NETBSD_NR___lstat30   389
-#define TARGET_NETBSD_NR___getdents30        390
-#define TARGET_NETBSD_NR_compat_30___fhstat30        392
-#define TARGET_NETBSD_NR___ntp_gettime30     393
-#define TARGET_NETBSD_NR___socket30  394
-#define TARGET_NETBSD_NR___getfh30   395
-#define TARGET_NETBSD_NR___fhopen40  396
-#define TARGET_NETBSD_NR___fhstatvfs140      397
-#define TARGET_NETBSD_NR___fhstat40  398
-#define TARGET_NETBSD_NR_aio_cancel  399
-#define TARGET_NETBSD_NR_aio_error   400
-#define TARGET_NETBSD_NR_aio_fsync   401
-#define TARGET_NETBSD_NR_aio_read    402
-#define TARGET_NETBSD_NR_aio_return  403
-#define TARGET_NETBSD_NR_aio_suspend 404
-#define TARGET_NETBSD_NR_aio_write   405
-#define TARGET_NETBSD_NR_lio_listio  406
-#define TARGET_NETBSD_NR___mount50   410
-#define TARGET_NETBSD_NR_mremap      411
-#define TARGET_NETBSD_NR_pset_create 412
-#define TARGET_NETBSD_NR_pset_destroy        413
-#define TARGET_NETBSD_NR_pset_assign 414
-#define TARGET_NETBSD_NR__pset_bind  415
-#define TARGET_NETBSD_NR___posix_fadvise50   416
diff --git a/bsd-user/netbsd/target_os_elf.h b/bsd-user/netbsd/target_os_elf.h
deleted file mode 100644
index 9de0f290c0..0000000000
--- a/bsd-user/netbsd/target_os_elf.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- *  netbsd ELF definitions
- *
- *  Copyright (c) 2013 Stacey D. Son
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef TARGET_OS_ELF_H
-#define TARGET_OS_ELF_H
-
-#include "target_arch_elf.h"
-#include "elf.h"
-#include "user/tswap-target.h"
-
-/* this flag is uneffective under linux too, should be deleted */
-#ifndef MAP_DENYWRITE
-#define MAP_DENYWRITE 0
-#endif
-
-/* should probably go in elf.h */
-#ifndef ELIBBAD
-#define ELIBBAD 80
-#endif
-
-#ifndef ELF_PLATFORM
-#define ELF_PLATFORM (NULL)
-#endif
-
-#ifndef ELF_HWCAP
-#define ELF_HWCAP 0
-#endif
-
-#ifdef TARGET_ABI32
-#undef ELF_CLASS
-#define ELF_CLASS ELFCLASS32
-#undef bswaptls
-#define bswaptls(ptr) bswap32s(ptr)
-#endif
-
-/* max code+data+bss space allocated to elf interpreter */
-#define INTERP_MAP_SIZE (32 * 1024 * 1024)
-
-/* max code+data+bss+brk space allocated to ET_DYN executables */
-#define ET_DYN_MAP_SIZE (128 * 1024 * 1024)
-
-/* Necessary parameters */
-#define TARGET_ELF_EXEC_PAGESIZE TARGET_PAGE_SIZE
-#define TARGET_ELF_PAGESTART(_v) ((_v) & \
-        ~(unsigned long)(TARGET_ELF_EXEC_PAGESIZE - 1))
-#define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE - 1))
-
-#define DLINFO_ITEMS 12
-
-static abi_ulong target_create_elf_tables(abi_ulong p, int argc, int envc,
-                                          abi_ulong stringp,
-                                          struct elfhdr *exec,
-                                          abi_ulong load_addr,
-                                          abi_ulong load_bias,
-                                          abi_ulong interp_load_addr,
-                                          struct image_info *info)
-{
-        abi_ulong sp;
-        int size;
-        abi_ulong u_platform;
-        const char *k_platform;
-        const int n = sizeof(elf_addr_t);
-
-        sp = p;
-        u_platform = 0;
-        k_platform = ELF_PLATFORM;
-        if (k_platform) {
-            size_t len = strlen(k_platform) + 1;
-            sp -= (len + n - 1) & ~(n - 1);
-            u_platform = sp;
-            /* FIXME - check return value of memcpy_to_target() for failure */
-            memcpy_to_target(sp, k_platform, len);
-        }
-        /*
-         * Force 16 byte _final_ alignment here for generality.
-         */
-        sp = sp & ~(abi_ulong)15;
-        size = (DLINFO_ITEMS + 1) * 2;
-        if (k_platform) {
-            size += 2;
-        }
-#ifdef DLINFO_ARCH_ITEMS
-        size += DLINFO_ARCH_ITEMS * 2;
-#endif
-        size += envc + argc + 2;
-        size += 1;                         /* argc itself */
-        size *= n;
-        if (size & 15) {
-            sp -= 16 - (size & 15);
-        }
-
-        /*
-         * NetBSD defines elf_addr_t as Elf32_Off / Elf64_Off
-         */
-#define NEW_AUX_ENT(id, val) do {               \
-            sp -= n; put_user_ual(val, sp);     \
-            sp -= n; put_user_ual(id, sp);      \
-          } while (0)
-
-        NEW_AUX_ENT(AT_NULL, 0);
-
-        /* There must be exactly DLINFO_ITEMS entries here.  */
-        NEW_AUX_ENT(AT_PHDR, (abi_ulong)(load_addr + exec->e_phoff));
-        NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof(struct elf_phdr)));
-        NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
-        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
-        NEW_AUX_ENT(AT_BASE, (abi_ulong)(interp_load_addr));
-        NEW_AUX_ENT(AT_FLAGS, (abi_ulong)0);
-        NEW_AUX_ENT(AT_ENTRY, load_bias + exec->e_entry);
-        NEW_AUX_ENT(AT_UID, (abi_ulong)getuid());
-        NEW_AUX_ENT(AT_EUID, (abi_ulong)geteuid());
-        NEW_AUX_ENT(AT_GID, (abi_ulong)getgid());
-        NEW_AUX_ENT(AT_EGID, (abi_ulong)getegid());
-        NEW_AUX_ENT(AT_HWCAP, (abi_ulong)ELF_HWCAP);
-        NEW_AUX_ENT(AT_CLKTCK, (abi_ulong)sysconf(_SC_CLK_TCK));
-        if (k_platform) {
-            NEW_AUX_ENT(AT_PLATFORM, u_platform);
-        }
-#ifdef ARCH_DLINFO
-        /*
-         * ARCH_DLINFO must come last so platform specific code can enforce
-         * special alignment requirements on the AUXV if necessary (eg. PPC).
-         */
-        ARCH_DLINFO;
-#endif
-#undef NEW_AUX_ENT
-
-        sp = loader_build_argptr(envc, argc, sp, stringp);
-        return sp;
-}
-
-#endif /* TARGET_OS_ELF_H */
diff --git a/bsd-user/netbsd/target_os_siginfo.h b/bsd-user/netbsd/target_os_siginfo.h
deleted file mode 100644
index eb57e0a309..0000000000
--- a/bsd-user/netbsd/target_os_siginfo.h
+++ /dev/null
@@ -1,82 +0,0 @@
-#ifndef TARGET_OS_SIGINFO_H
-#define TARGET_OS_SIGINFO_H
-
-#define TARGET_NSIG     32  /* counting 0; could be 33 (mask is 1-32) */
-#define TARGET_NSIG_BPW     (sizeof(uint32_t) * 8)
-#define TARGET_NSIG_WORDS   (TARGET_NSIG / TARGET_NSIG_BPW)
-
-/* this struct defines a stack used during syscall handling */
-typedef struct target_sigaltstack {
-    abi_long    ss_sp;
-    abi_ulong   ss_size;
-    abi_long    ss_flags;
-} target_stack_t;
-
-typedef struct {
-    uint32_t __bits[TARGET_NSIG_WORDS];
-} target_sigset_t
-
-struct target_sigaction {
-    abi_ulong   _sa_handler;
-    int32_t     sa_flags;
-    target_sigset_t sa_mask;
-};
-
-/* Compare to sys/siginfo.h */
-typedef union target_sigval {
-    int         sival_int;
-    abi_ulong   sival_ptr;
-} target_sigval_t;
-
-struct target_ksiginfo {
-    int32_t     _signo;
-    int32_t     _code;
-    int32_t     _errno;
-#if TARGET_ABI_BITS == 64
-    int32_t     _pad;
-#endif
-    union {
-        struct {
-            int32_t             _pid;
-            int32_t             _uid;
-            target_sigval_t    _value;
-        } _rt;
-
-        struct {
-            int32_t             _pid;
-            int32_t             _uid;
-            int32_t             _struct;
-            /* clock_t          _utime; */
-            /* clock_t          _stime; */
-        } _child;
-
-        struct {
-            abi_ulong           _addr;
-            int32_t             _trap;
-        } _fault;
-
-        struct {
-            long                _band;
-            int                 _fd;
-        } _poll;
-    } _reason;
-};
-
-typedef union target_siginfo {
-    int8_t     si_pad[128];
-    struct     target_ksiginfo  _info;
-} target_siginfo_t;
-
-#define target_si_signo     _info._signo
-#define target_si_code      _info._code
-#define target_si_errno     _info._errno
-#define target_si_addr      _info._reason._fault._addr
-
-#define TARGET_SEGV_MAPERR  1
-#define TARGET_SEGV_ACCERR  2
-
-#define TARGET_TRAP_BRKPT   1
-#define TARGET_TRAP_TRACE   2
-
-
-#endif /* TARGET_OS_SIGINFO_H */
diff --git a/bsd-user/netbsd/target_os_signal.h b/bsd-user/netbsd/target_os_signal.h
deleted file mode 100644
index 4ee4f768e0..0000000000
--- a/bsd-user/netbsd/target_os_signal.h
+++ /dev/null
@@ -1,69 +0,0 @@
-#ifndef TARGET_OS_SIGNAL_H
-#define TARGET_OS_SIGNAL_H
-
-#include "target_os_siginfo.h"
-#include "target_arch_signal.h"
-
-#define TARGET_SIGHUP  1       /* hangup */
-#define TARGET_SIGINT  2       /* interrupt */
-#define TARGET_SIGQUIT 3       /* quit */
-#define TARGET_SIGILL  4       /* illegal instruction (not reset when caught) */
-#define TARGET_SIGTRAP 5       /* trace trap (not reset when caught) */
-#define TARGET_SIGABRT 6       /* abort() */
-#define TARGET_SIGIOT  SIGABRT /* compatibility */
-#define TARGET_SIGEMT  7       /* EMT instruction */
-#define TARGET_SIGFPE  8       /* floating point exception */
-#define TARGET_SIGKILL 9       /* kill (cannot be caught or ignored) */
-#define TARGET_SIGBUS  10      /* bus error */
-#define TARGET_SIGSEGV 11      /* segmentation violation */
-#define TARGET_SIGSYS  12      /* bad argument to system call */
-#define TARGET_SIGPIPE 13      /* write on a pipe with no one to read it */
-#define TARGET_SIGALRM 14      /* alarm clock */
-#define TARGET_SIGTERM 15      /* software termination signal from kill */
-#define TARGET_SIGURG  16      /* urgent condition on IO channel */
-#define TARGET_SIGSTOP 17      /* sendable stop signal not from tty */
-#define TARGET_SIGTSTP 18      /* stop signal from tty */
-#define TARGET_SIGCONT 19      /* continue a stopped process */
-#define TARGET_SIGCHLD 20      /* to parent on child stop or exit */
-#define TARGET_SIGTTIN 21      /* to readers pgrp upon background tty read */
-#define TARGET_SIGTTOU 22      /* like TTIN for out if (tp->t_local&LTOSTOP) */
-#define TARGET_SIGIO   23      /* input/output possible signal */
-#define TARGET_SIGXCPU 24      /* exceeded CPU time limit */
-#define TARGET_SIGXFSZ 25      /* exceeded file size limit */
-#define TARGET_SIGVTALRM 26    /* virtual time alarm */
-#define TARGET_SIGPROF   27    /* profiling time alarm */
-#define TARGET_SIGWINCH  28    /* window size changes */
-#define TARGET_SIGINFO   29    /* information request */
-#define TARGET_SIGUSR1   30    /* user defined signal 1 */
-#define TARGET_SIGUSR2   31    /* user defined signal 2 */
-
-/*
- * Language spec says we must list exactly one parameter, even though we
- * actually supply three.  Ugh!
- */
-#define TARGET_SIG_DFL         ((void (*)(int))0)
-#define TARGET_SIG_IGN         ((void (*)(int))1)
-#define TARGET_SIG_ERR         ((void (*)(int))-1)
-
-#define TARGET_SA_ONSTACK   0x0001  /* take signal on signal stack */
-#define TARGET_SA_RESTART   0x0002  /* restart system on signal return */
-#define TARGET_SA_RESETHAND 0x0004  /* reset to SIG_DFL when taking signal */
-#define TARGET_SA_NODEFER   0x0010  /* don't mask the signal we're delivering */
-#define TARGET_SA_NOCLDWAIT 0x0020  /* don't create zombies (assign to pid 1) */
-#define TARGET_SA_USERTRAMP 0x0100  /* do not bounce off kernel's sigtramp */
-#define TARGET_SA_NOCLDSTOP 0x0008  /* do not generate SIGCHLD on child stop */
-#define TARGET_SA_SIGINFO   0x0040  /* generate siginfo_t */
-
-/*
- * Flags for sigprocmask:
- */
-#define TARGET_SIG_BLOCK       1       /* block specified signal set */
-#define TARGET_SIG_UNBLOCK     2       /* unblock specified signal set */
-#define TARGET_SIG_SETMASK     3       /* set specified signal set */
-
-#define TARGET_BADSIG       SIG_ERR
-
-#define TARGET_SS_ONSTACK 0x0001 /* take signals on alternate stack */
-#define TARGET_SS_DISABLE 0x0004 /* disable taking signals on alternate stack */
-
-#endif /* TARGET_OS_SIGNAL_H */
diff --git a/bsd-user/netbsd/target_os_stack.h b/bsd-user/netbsd/target_os_stack.h
deleted file mode 100644
index 8349e9149b..0000000000
--- a/bsd-user/netbsd/target_os_stack.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- *  NetBSD setup_initial_stack() implementation.
- *
- *  Copyright (c) 2013-14 Stacey D. Son
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef TARGET_OS_STACK_H
-#define TARGET_OS_STACK_H
-
-#include "target_arch_sigtramp.h"
-
-static inline int setup_initial_stack(struct bsd_binprm *bprm, abi_ulong *p,
-    abi_ulong *stringp)
-{
-    int i;
-    abi_ulong stack_base;
-
-    stack_base = (target_stkbas + target_stksiz) -
-                  MAX_ARG_PAGES * TARGET_PAGE_SIZE;
-    if (p) {
-        *p = stack_base;
-    }
-    if (stringp) {
-        *stringp = stack_base;
-    }
-
-    for (i = 0; i < MAX_ARG_PAGES; i++) {
-        if (bprm->page[i]) {
-            info->rss++;
-            if (!memcpy_to_target(stack_base, bprm->page[i],
-                        TARGET_PAGE_SIZE)) {
-                errno = EFAULT;
-                return -1;
-            }
-            g_free(bprm->page[i]);
-        }
-        stack_base += TARGET_PAGE_SIZE;
-    }
-
-    return 0;
-}
-
-#endif /* TARGET_OS_STACK_H */
diff --git a/bsd-user/netbsd/target_os_thread.h b/bsd-user/netbsd/target_os_thread.h
deleted file mode 100644
index 8ccfa16e4b..0000000000
--- a/bsd-user/netbsd/target_os_thread.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  NetBSD thread dependent code and definitions
- *
- *  Copyright (c) 2013 Stacey D. Son
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef TARGET_OS_THREAD_H
-#define TARGET_OS_THREAD_H
-
-#include "target_arch_thread.h"
-
-#endif /* TARGET_OS_THREAD_H */
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 2594c3ef2a..2c586e546f 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -179,9 +179,6 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8);
-abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
-                           abi_long arg2, abi_long arg3, abi_long arg4,
-                           abi_long arg5, abi_long arg6);
 void gemu_log(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 extern __thread CPUState *thread_cpu;
 char *target_strerror(int err);
@@ -207,11 +204,6 @@ print_freebsd_syscall(int num,
                       abi_long arg1, abi_long arg2, abi_long arg3,
                       abi_long arg4, abi_long arg5, abi_long arg6);
 void print_freebsd_syscall_ret(int num, abi_long ret);
-void
-print_netbsd_syscall(int num,
-                     abi_long arg1, abi_long arg2, abi_long arg3,
-                     abi_long arg4, abi_long arg5, abi_long arg6);
-void print_netbsd_syscall_ret(int num, abi_long ret);
 /**
  * print_taken_signal:
  * @target_signum: target signal being taken
diff --git a/bsd-user/strace.c b/bsd-user/strace.c
index bf54b3bfff..41bbef72ce 100644
--- a/bsd-user/strace.c
+++ b/bsd-user/strace.c
@@ -153,9 +153,6 @@ static void print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
 static const struct syscallname freebsd_scnames[] = {
 #include "freebsd/strace.list"
 };
-static const struct syscallname netbsd_scnames[] = {
-#include "netbsd/strace.list"
-};
 
 static void print_syscall(int num, const struct syscallname *scnames,
         unsigned int nscnames, abi_long arg1, abi_long arg2, abi_long arg3,
@@ -227,20 +224,6 @@ void print_freebsd_syscall_ret(int num, abi_long ret)
     print_syscall_ret(num, ret, freebsd_scnames, ARRAY_SIZE(freebsd_scnames));
 }
 
-void print_netbsd_syscall(int num, abi_long arg1, abi_long arg2, abi_long arg3,
-        abi_long arg4, abi_long arg5, abi_long arg6)
-{
-
-    print_syscall(num, netbsd_scnames, ARRAY_SIZE(netbsd_scnames),
-                  arg1, arg2, arg3, arg4, arg5, arg6);
-}
-
-void print_netbsd_syscall_ret(int num, abi_long ret)
-{
-
-    print_syscall_ret(num, ret, netbsd_scnames, ARRAY_SIZE(netbsd_scnames));
-}
-
 static void
 print_signal(abi_ulong arg, int last)
 {
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index ed28a318dd..b42dff153f 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -26,7 +26,6 @@
 #include "errno_defs.h"
 
 #include "freebsd/syscall_nr.h"
-#include "netbsd/syscall_nr.h"
 
 /*
  * machine/_types.h
@@ -107,18 +106,6 @@ struct bsd_shm_regions {
 
 #define TARGET_FREEBSD_MAP_FLAGMASK     0x1ff7
 
-#define TARGET_NETBSD_MAP_INHERIT       0x0080  /* region is retained after */
-                                                /* exec */
-#define TARGET_NETBSD_MAP_TRYFIXED      0x0400  /* attempt hint address, even */
-                                                /* within break */
-#define TARGET_NETBSD_MAP_WIRED         0x0800  /* mlock() mapping when it is */
-                                                /* established */
-
-#define TARGET_NETBSD_MAP_STACK         0x2000  /* allocated from memory, */
-                                                /* swap space (stack) */
-
-#define TARGET_NETBSD_MAP_FLAGMASK      0x3ff7
-
 /* XXX */
 #define TARGET_BSD_MAP_FLAGMASK         0x3ff7
 

-- 
2.52.0


