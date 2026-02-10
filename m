Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0135EA813A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq91-0000ac-HE; Tue, 10 Feb 2026 10:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpq8x-0000aI-Qt
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:59:15 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpq8t-0005tB-Oh
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:59:15 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-824484dba4dso891567b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770739150; x=1771343950;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O695NH1IMt5rOzTIn7UjVKTKo/DEUy+kPNLuMvZjXHk=;
 b=K5IPghMSQ7VvzYO1sH7iXfcAwxanRJ8w2s5bmvNxyTQ7JqiJ1pr0ADo3k39qIRiRhz
 nFLhEJi4HkFOyam6oOLtZGyen/uMO8EfGadv5917AmVmPcqfJgWvU7UmRuUL1lRXR36R
 QzbufM4TxqCugk7KUKKfYkuuJ5EG8mv2iaMe7mDOp46GfgPB8B5znm5qX7oW+bzE+83R
 YW3MavmytYSAbTbV9NizgUitsRYoFUd3fkHF+dfk2a1WTXhLRRKtvVrvkseuqeoT5LM/
 RRxpY2Ap/8LwgZe/v7zTjiDsc/vD7kgqZLGDYPru6YOYs4JlQ25X7xsFLYq8nQIsOT1c
 RMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739150; x=1771343950;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O695NH1IMt5rOzTIn7UjVKTKo/DEUy+kPNLuMvZjXHk=;
 b=GarHfipD2VV6DlPUgdzKFuHpJpVbjJqkrIS+sRWc//XDB21/gS5LDTAoLoevXS7W9O
 9Ve057oYNmyz9g0DI3fMc2ybMoJSjlpU/ht3qIakDwmwPJhCKGNLGu2peKX3i0LmfSJ7
 plR1JlIZdqka0WHQ98g/IyU5Hr4deCbYkMiF8MdkKRl6DUSzgiWoTMcHaTaEyC+HRlgf
 RgwDqoWEX3BKbxvbrzxxsA17A0Kn1RJ2ETT2xWsUNLlKIeCMu8dg/pB9VcYNci+fl5Ck
 jYvkHIGgqEa1NvagilJzNO5LYIM9WWigjKNSMRjbezRTb54d8EsZT8zqGJaYYBBERcof
 XtgQ==
X-Gm-Message-State: AOJu0YzYLzEGQj07Hgi6NT5jghoodDfj0KRoLrB63ds0rJB2IzyHzwEi
 chfx6Alj5Oq6nHxpFw2zJuD6ekPKSR4IG3SymMjmJMydN1Pq43Occql6h9mcSEE4WJxmVToqzBA
 2eIRGn34=
X-Gm-Gg: AZuq6aJdKjXCVqTtO+G1FXIcxnQ9sY8KypVl5B4vfo1QHbd9K/IKoTofL16GTRDe7jg
 scImvbKGxcOgnST5AF47/bm4fs8X+IdcsJu8454RAI6iJ3Ft1tysJCUfn7XO8ihq97A9KgwoGcx
 J5mpx+PENO9lQpmU+0Byr4ZyVAX/6oB2FQCTwYtIRsgPbOSR51H0oAYXZmt7vKry2f3C0x2sc6h
 kLHEfKGYBlQtFG/rV+f+9fJDbtNxUIU+u6ko057O9soZ/kTaXMUCWsptMIDG8rqUsA4AVoGlgRu
 xmkmIYippJkEd1aed9iPAYpG71pMNGfgrxatTfbKPppLGR5RWOMssz5N9BGVB28PNvADgqti4g9
 962kIta1k51OtBvLkFcLja5oGHsZCnfyNG1993H49QdKhQKkCyjkbPSVmqKFkIHFGKUX/zHCoqt
 EJdflby8ycdw==
X-Received: by 2002:a05:6830:829b:b0:7c7:6626:b595 with SMTP id
 46e09a7af769-7d4643eee36mr9039885a34.3.1770738401785; 
 Tue, 10 Feb 2026 07:46:41 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464457a98sm9841679a34.0.2026.02.10.07.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:46:41 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 08:46:17 -0700
Subject: [PATCH v2 1/2] bsd-user: Remove the openbsd-specific code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-bsd-user-rm-openbsd-netbsd-v2-1-3dd10091d359@bsdimp.com>
References: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
In-Reply-To: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=42886; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=qhzYWaCXVBSt57FOWt75P4dUl2GXzZaySgE6UlSZSl4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpi1LfchDt9mGqq/PiwWs6Vkqeusst/aVe7RGkZ
 ygmxXihuZeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYtS3wAKCRBsHNEofbAR
 APxxEACYT7srk4QXJC3FuqGhpznD/SAkUVUzCsEqu2Ob98BqAb2DW1z0H3HTMRBDrJ6MWE4/bVJ
 e+kGJPzEgx5oAz/PBSgUHorAjWK+ToqCRX0ZJWg0ZV8VYnuV/hONcjlIiejwZGKt4ln0u66fJfq
 Wn41upO0y+L+VH+Yf9fBjGOmX3a1gdgvK7f+ND2ZofB7nq0KHUqWsKFwWjD1BU01C3nxtEAAHlt
 xrgvRZ9JDnvXnVKCifHpxqtPtQYbNSQf1wiMXJuK2WHqCpQw7/ogX0+MMNjNWz5tK491CWpva9O
 Jif2HvQRgkR41XQYuZDZwVwX0ErZJfmyaHwOpWBi4QPJitRwRwb6BxvbD0dCp4ed96NhIQxMWOa
 qOf54RLxxsBcUTW/yEBnu2PZjhau87ckeAc8Kx8pRxMDDXGrr2fVKs8sapsInnWaRedKeU4EGSH
 x6xSR9X3wO3UDVgau1EIjAFbnmBYAKKZRPTkNsu+d9UODijqDGjWUOIJN9KNfHnsRUz0SzCxkIE
 o+xuA6rVO4HICqHmLNoZRbfGK6qPVzR5uUncFjD+Y1x1qXMvVDfdDDz1peuOb3vTxNmmpgEUZJI
 wZY2UBskd5Y/WvfoAKgogO4fbYd9rR0djJ88i0qWhmC+NpOMsGjpo993L14EBW6RrtqNeJWNNHA
 Nz+duXGMNKMr3Eg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=imp@bsdimp.com; helo=mail-pf1-x42f.google.com
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

Remove the OpenBSD specific code form bsd-user. It's not been maintained
in any meaningful way since it was introduced to the tree in 2008. It
hasn't been connected to the build since 2021, and last time (in 2023) I
tried to mock-up the meson support it needed, it failed to build. I
contacted the OpenBSD people in 2018, it appears, and even at that time
they tought this code was not at all useful.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/openbsd/host-os.h           |  25 ----
 bsd-user/openbsd/os-strace.h         |   1 -
 bsd-user/openbsd/strace.list         | 187 -----------------------------
 bsd-user/openbsd/syscall_nr.h        | 225 -----------------------------------
 bsd-user/openbsd/target_os_elf.h     | 148 -----------------------
 bsd-user/openbsd/target_os_siginfo.h |  82 -------------
 bsd-user/openbsd/target_os_signal.h  |  69 -----------
 bsd-user/openbsd/target_os_stack.h   |  56 ---------
 bsd-user/openbsd/target_os_thread.h  |  25 ----
 bsd-user/qemu.h                      |   8 --
 bsd-user/strace.c                    |  17 ---
 bsd-user/syscall_defs.h              |  10 --
 12 files changed, 853 deletions(-)

diff --git a/bsd-user/openbsd/host-os.h b/bsd-user/openbsd/host-os.h
deleted file mode 100644
index b9222335d4..0000000000
--- a/bsd-user/openbsd/host-os.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  OpenBSD host dependent code and definitions
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
-#define HOST_DEFAULT_BSD_TYPE target_openbsd
-
-#endif /* HOST_OS_H */
diff --git a/bsd-user/openbsd/os-strace.h b/bsd-user/openbsd/os-strace.h
deleted file mode 100644
index 9161390433..0000000000
--- a/bsd-user/openbsd/os-strace.h
+++ /dev/null
@@ -1 +0,0 @@
-/* XXX OpenBSD dependent strace print functions */
diff --git a/bsd-user/openbsd/strace.list b/bsd-user/openbsd/strace.list
deleted file mode 100644
index 1f0a3316f3..0000000000
--- a/bsd-user/openbsd/strace.list
+++ /dev/null
@@ -1,187 +0,0 @@
-{ TARGET_OPENBSD_NR___getcwd, "__getcwd", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR___semctl, "__semctl", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR___syscall, "__syscall", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR___sysctl, "__sysctl", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_accept, "accept", "%s(%d,%#x,%#x)", NULL, NULL },
-{ TARGET_OPENBSD_NR_access, "access", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_OPENBSD_NR_acct, "acct", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_adjfreq, "adjfreq", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_adjtime, "adjtime", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_bind, "bind", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_break, "break", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_chdir, "chdir", "%s(\"%s\")", NULL, NULL },
-{ TARGET_OPENBSD_NR_chflags, "chflags", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_chmod, "chmod", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_OPENBSD_NR_chown, "chown", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_chroot, "chroot", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_clock_getres, "clock_getres", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_clock_gettime, "clock_gettime", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_clock_settime, "clock_settime", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_close, "close", "%s(%d)", NULL, NULL },
-{ TARGET_OPENBSD_NR_closefrom, "closefrom", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_connect, "connect", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_OPENBSD_NR_dup, "dup", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_dup2, "dup2", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_execve, "execve", NULL, print_execve, NULL },
-{ TARGET_OPENBSD_NR_exit, "exit", "%s(%d)\n", NULL, NULL },
-{ TARGET_OPENBSD_NR_fchdir, "fchdir", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_fchflags, "fchflags", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_fchmod, "fchmod", "%s(%d,%#o)", NULL, NULL },
-{ TARGET_OPENBSD_NR_fchown, "fchown", "%s(\"%s\",%d,%d)", NULL, NULL },
-{ TARGET_OPENBSD_NR_fcntl, "fcntl", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_fhopen, "fhopen", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_fhstat, "fhstat", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_fhstatfs, "fhstatfs", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_flock, "flock", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_fork, "fork", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_fpathconf, "fpathconf", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_fstat, "fstat", "%s(%d,%p)", NULL, NULL },
-{ TARGET_OPENBSD_NR_fstatfs, "fstatfs", "%s(%d,%p)", NULL, NULL },
-{ TARGET_OPENBSD_NR_fsync, "fsync", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_ftruncate, "ftruncate", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_futimes, "futimes", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getdirentries, "getdirentries", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getegid, "getegid", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_geteuid, "geteuid", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_getfh, "getfh", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getfsstat, "getfsstat", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getgid, "getgid", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_getgroups, "getgroups", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getitimer, "getitimer", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getlogin, "getlogin", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getpeereid, "getpeereid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getpeername, "getpeername", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getpgid, "getpgid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getpgrp, "getpgrp", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_getpid, "getpid", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_getppid, "getppid", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
-{ TARGET_OPENBSD_NR_getresgid, "getresgid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getresuid, "getresuid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getrlimit, "getrlimit", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getrusage, "getrusage", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getsid, "getsid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getsockname, "getsockname", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getsockopt, "getsockopt", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getthrid, "getthrid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_gettimeofday, "gettimeofday", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_getuid, "getuid", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_ioctl, "ioctl", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_issetugid, "issetugid", "%s()", NULL, NULL },
-{ TARGET_OPENBSD_NR_kevent, "kevent", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_kill, "kill", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_kqueue, "kqueue", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_ktrace, "ktrace", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_lchown, "lchown", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_lfs_bmapv, "lfs_bmapv", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_lfs_markv, "lfs_markv", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_lfs_segclean, "lfs_segclean", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_lfs_segwait, "lfs_segwait", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_link, "link", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_OPENBSD_NR_listen, "listen", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_lseek, "lseek", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_lstat, "lstat", "%s(\"%s\",%p)", NULL, NULL },
-{ TARGET_OPENBSD_NR_madvise, "madvise", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_mincore, "mincore", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_minherit, "minherit", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_mkdir, "mkdir", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_OPENBSD_NR_mkfifo, "mkfifo", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_mknod, "mknod", "%s(\"%s\",%#o,%#x)", NULL, NULL },
-{ TARGET_OPENBSD_NR_mlock, "mlock", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_mlockall, "mlockall", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_mmap, "mmap", NULL, NULL, print_syscall_ret_addr },
-{ TARGET_OPENBSD_NR_mount, "mount", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_mprotect, "mprotect", "%s(%#x,%#x,%d)", NULL, NULL },
-{ TARGET_OPENBSD_NR_mquery, "mquery", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_msgctl, "msgctl", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_msgget, "msgget", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_msgrcv, "msgrcv", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_msgsnd, "msgsnd", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_msync, "msync", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_munlock, "munlock", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_munlockall, "munlockall", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_munmap, "munmap", "%s(%p,%d)", NULL, NULL },
-{ TARGET_OPENBSD_NR_nanosleep, "nanosleep", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_nfssvc, "nfssvc", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_open, "open", "%s(\"%s\",%#x,%#o)", NULL, NULL },
-{ TARGET_OPENBSD_NR_opipe, "opipe", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_osigaltstack, "osigaltstack", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_pathconf, "pathconf", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_pipe, "pipe", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_poll, "poll", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_pread, "pread", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_preadv, "preadv", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_profil, "profil", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_ptrace, "ptrace", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_pwrite, "pwrite", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_pwritev, "pwritev", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_quotactl, "quotactl", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_read, "read", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_OPENBSD_NR_readlink, "readlink", "%s(\"%s\",%p,%d)", NULL, NULL },
-{ TARGET_OPENBSD_NR_readv, "readv", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_reboot, "reboot", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_recvfrom, "recvfrom", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_recvmsg, "recvmsg", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_rename, "rename", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_OPENBSD_NR_revoke, "revoke", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_rfork, "rfork", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_rmdir, "rmdir", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sbrk, "sbrk", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sched_yield, "sched_yield", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_select, "select", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_semget, "semget", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_semop, "semop", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sendmsg, "sendmsg", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sendto, "sendto", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setegid, "setegid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_seteuid, "seteuid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setgid, "setgid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setgroups, "setgroups", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setitimer, "setitimer", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setlogin, "setlogin", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setpgid, "setpgid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setpriority, "setpriority", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setregid, "setregid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setresgid, "setresgid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setresuid, "setresuid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setreuid, "setreuid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setrlimit, "setrlimit", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setsid, "setsid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setsockopt, "setsockopt", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_settimeofday, "settimeofday", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_setuid, "setuid", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_shmat, "shmat", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_shmctl, "shmctl", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_shmdt, "shmdt", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_shmget, "shmget", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_shutdown, "shutdown", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sigaction, "sigaction", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sigaltstack, "sigaltstack", "%s(%p,%p)", NULL, NULL },
-{ TARGET_OPENBSD_NR_sigpending, "sigpending", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sigprocmask, "sigprocmask", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sigreturn, "sigreturn", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sigsuspend, "sigsuspend", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_socket, "socket", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_socketpair, "socketpair", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sstk, "sstk", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_stat, "stat", "%s(\"%s\",%p)", NULL, NULL },
-{ TARGET_OPENBSD_NR_statfs, "statfs", "%s(\"%s\",%p)", NULL, NULL },
-{ TARGET_OPENBSD_NR_swapctl, "swapctl", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_symlink, "symlink", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_OPENBSD_NR_sync, "sync", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_sysarch, "sysarch", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_syscall, "syscall", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_threxit, "threxit", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_thrsigdivert, "thrsigdivert", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_thrsleep, "thrsleep", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_thrwakeup, "thrwakeup", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_truncate, "truncate", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_umask, "umask", "%s(%#o)", NULL, NULL },
-{ TARGET_OPENBSD_NR_unlink, "unlink", "%s(\"%s\")", NULL, NULL },
-{ TARGET_OPENBSD_NR_unmount, "unmount", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_utimes, "utimes", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_vfork, "vfork", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_wait4, "wait4", NULL, NULL, NULL },
-{ TARGET_OPENBSD_NR_write, "write", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_OPENBSD_NR_writev, "writev", "%s(%d,%p,%#x)", NULL, NULL },
-{ TARGET_OPENBSD_NR_xfspioctl, "xfspioctl", NULL, NULL, NULL },
diff --git a/bsd-user/openbsd/syscall_nr.h b/bsd-user/openbsd/syscall_nr.h
deleted file mode 100644
index dececfd9e8..0000000000
--- a/bsd-user/openbsd/syscall_nr.h
+++ /dev/null
@@ -1,225 +0,0 @@
-/*      $OpenBSD: syscall.h,v 1.101 2008/03/16 19:43:41 otto Exp $      */
-
-/*
- * System call numbers.
- *
- * created from;        OpenBSD: syscalls.master,v 1.90 2008/03/16 19:42:57 otto Exp
- */
-
-#define TARGET_OPENBSD_NR_syscall     0
-#define TARGET_OPENBSD_NR_exit        1
-#define TARGET_OPENBSD_NR_fork        2
-#define TARGET_OPENBSD_NR_read        3
-#define TARGET_OPENBSD_NR_write       4
-#define TARGET_OPENBSD_NR_open        5
-#define TARGET_OPENBSD_NR_close       6
-#define TARGET_OPENBSD_NR_wait4       7
-#define TARGET_OPENBSD_NR_link        9
-#define TARGET_OPENBSD_NR_unlink      10
-#define TARGET_OPENBSD_NR_chdir       12
-#define TARGET_OPENBSD_NR_fchdir      13
-#define TARGET_OPENBSD_NR_mknod       14
-#define TARGET_OPENBSD_NR_chmod       15
-#define TARGET_OPENBSD_NR_chown       16
-#define TARGET_OPENBSD_NR_break       17
-#define TARGET_OPENBSD_NR_getpid      20
-#define TARGET_OPENBSD_NR_mount       21
-#define TARGET_OPENBSD_NR_unmount     22
-#define TARGET_OPENBSD_NR_setuid      23
-#define TARGET_OPENBSD_NR_getuid      24
-#define TARGET_OPENBSD_NR_geteuid     25
-#define TARGET_OPENBSD_NR_ptrace      26
-#define TARGET_OPENBSD_NR_recvmsg     27
-#define TARGET_OPENBSD_NR_sendmsg     28
-#define TARGET_OPENBSD_NR_recvfrom    29
-#define TARGET_OPENBSD_NR_accept      30
-#define TARGET_OPENBSD_NR_getpeername 31
-#define TARGET_OPENBSD_NR_getsockname 32
-#define TARGET_OPENBSD_NR_access      33
-#define TARGET_OPENBSD_NR_chflags     34
-#define TARGET_OPENBSD_NR_fchflags    35
-#define TARGET_OPENBSD_NR_sync        36
-#define TARGET_OPENBSD_NR_kill        37
-#define TARGET_OPENBSD_NR_getppid     39
-#define TARGET_OPENBSD_NR_dup 41
-#define TARGET_OPENBSD_NR_opipe       42
-#define TARGET_OPENBSD_NR_getegid     43
-#define TARGET_OPENBSD_NR_profil      44
-#define TARGET_OPENBSD_NR_ktrace      45
-#define TARGET_OPENBSD_NR_sigaction   46
-#define TARGET_OPENBSD_NR_getgid      47
-#define TARGET_OPENBSD_NR_sigprocmask 48
-#define TARGET_OPENBSD_NR_getlogin    49
-#define TARGET_OPENBSD_NR_setlogin    50
-#define TARGET_OPENBSD_NR_acct        51
-#define TARGET_OPENBSD_NR_sigpending  52
-#define TARGET_OPENBSD_NR_osigaltstack        53
-#define TARGET_OPENBSD_NR_ioctl       54
-#define TARGET_OPENBSD_NR_reboot      55
-#define TARGET_OPENBSD_NR_revoke      56
-#define TARGET_OPENBSD_NR_symlink     57
-#define TARGET_OPENBSD_NR_readlink    58
-#define TARGET_OPENBSD_NR_execve      59
-#define TARGET_OPENBSD_NR_umask       60
-#define TARGET_OPENBSD_NR_chroot      61
-#define TARGET_OPENBSD_NR_vfork       66
-#define TARGET_OPENBSD_NR_sbrk        69
-#define TARGET_OPENBSD_NR_sstk        70
-#define TARGET_OPENBSD_NR_munmap      73
-#define TARGET_OPENBSD_NR_mprotect    74
-#define TARGET_OPENBSD_NR_madvise     75
-#define TARGET_OPENBSD_NR_mincore     78
-#define TARGET_OPENBSD_NR_getgroups   79
-#define TARGET_OPENBSD_NR_setgroups   80
-#define TARGET_OPENBSD_NR_getpgrp     81
-#define TARGET_OPENBSD_NR_setpgid     82
-#define TARGET_OPENBSD_NR_setitimer   83
-#define TARGET_OPENBSD_NR_getitimer   86
-#define TARGET_OPENBSD_NR_dup2        90
-#define TARGET_OPENBSD_NR_fcntl       92
-#define TARGET_OPENBSD_NR_select      93
-#define TARGET_OPENBSD_NR_fsync       95
-#define TARGET_OPENBSD_NR_setpriority 96
-#define TARGET_OPENBSD_NR_socket      97
-#define TARGET_OPENBSD_NR_connect     98
-#define TARGET_OPENBSD_NR_getpriority 100
-#define TARGET_OPENBSD_NR_sigreturn   103
-#define TARGET_OPENBSD_NR_bind        104
-#define TARGET_OPENBSD_NR_setsockopt  105
-#define TARGET_OPENBSD_NR_listen      106
-#define TARGET_OPENBSD_NR_sigsuspend  111
-#define TARGET_OPENBSD_NR_gettimeofday        116
-#define TARGET_OPENBSD_NR_getrusage   117
-#define TARGET_OPENBSD_NR_getsockopt  118
-#define TARGET_OPENBSD_NR_readv       120
-#define TARGET_OPENBSD_NR_writev      121
-#define TARGET_OPENBSD_NR_settimeofday        122
-#define TARGET_OPENBSD_NR_fchown      123
-#define TARGET_OPENBSD_NR_fchmod      124
-#define TARGET_OPENBSD_NR_setreuid    126
-#define TARGET_OPENBSD_NR_setregid    127
-#define TARGET_OPENBSD_NR_rename      128
-#define TARGET_OPENBSD_NR_flock       131
-#define TARGET_OPENBSD_NR_mkfifo      132
-#define TARGET_OPENBSD_NR_sendto      133
-#define TARGET_OPENBSD_NR_shutdown    134
-#define TARGET_OPENBSD_NR_socketpair  135
-#define TARGET_OPENBSD_NR_mkdir       136
-#define TARGET_OPENBSD_NR_rmdir       137
-#define TARGET_OPENBSD_NR_utimes      138
-#define TARGET_OPENBSD_NR_adjtime     140
-#define TARGET_OPENBSD_NR_setsid      147
-#define TARGET_OPENBSD_NR_quotactl    148
-#define TARGET_OPENBSD_NR_nfssvc      155
-#define TARGET_OPENBSD_NR_getfh       161
-#define TARGET_OPENBSD_NR_sysarch     165
-#define TARGET_OPENBSD_NR_pread       173
-#define TARGET_OPENBSD_NR_pwrite      174
-#define TARGET_OPENBSD_NR_setgid      181
-#define TARGET_OPENBSD_NR_setegid     182
-#define TARGET_OPENBSD_NR_seteuid     183
-#define TARGET_OPENBSD_NR_lfs_bmapv   184
-#define TARGET_OPENBSD_NR_lfs_markv   185
-#define TARGET_OPENBSD_NR_lfs_segclean        186
-#define TARGET_OPENBSD_NR_lfs_segwait 187
-#define TARGET_OPENBSD_NR_pathconf    191
-#define TARGET_OPENBSD_NR_fpathconf   192
-#define TARGET_OPENBSD_NR_swapctl     193
-#define TARGET_OPENBSD_NR_getrlimit   194
-#define TARGET_OPENBSD_NR_setrlimit   195
-#define TARGET_OPENBSD_NR_getdirentries       196
-#define TARGET_OPENBSD_NR_mmap        197
-#define TARGET_OPENBSD_NR___syscall   198
-#define TARGET_OPENBSD_NR_lseek       199
-#define TARGET_OPENBSD_NR_truncate    200
-#define TARGET_OPENBSD_NR_ftruncate   201
-#define TARGET_OPENBSD_NR___sysctl    202
-#define TARGET_OPENBSD_NR_mlock       203
-#define TARGET_OPENBSD_NR_munlock     204
-#define TARGET_OPENBSD_NR_futimes     206
-#define TARGET_OPENBSD_NR_getpgid     207
-#define TARGET_OPENBSD_NR_xfspioctl   208
-#define TARGET_OPENBSD_NR_semget      221
-#define TARGET_OPENBSD_NR_msgget      225
-#define TARGET_OPENBSD_NR_msgsnd      226
-#define TARGET_OPENBSD_NR_msgrcv      227
-#define TARGET_OPENBSD_NR_shmat       228
-#define TARGET_OPENBSD_NR_shmdt       230
-#define TARGET_OPENBSD_NR_clock_gettime       232
-#define TARGET_OPENBSD_NR_clock_settime       233
-#define TARGET_OPENBSD_NR_clock_getres        234
-#define TARGET_OPENBSD_NR_nanosleep   240
-#define TARGET_OPENBSD_NR_minherit    250
-#define TARGET_OPENBSD_NR_rfork       251
-#define TARGET_OPENBSD_NR_poll        252
-#define TARGET_OPENBSD_NR_issetugid   253
-#define TARGET_OPENBSD_NR_lchown      254
-#define TARGET_OPENBSD_NR_getsid      255
-#define TARGET_OPENBSD_NR_msync       256
-#define TARGET_OPENBSD_NR_pipe        263
-#define TARGET_OPENBSD_NR_fhopen      264
-#define TARGET_OPENBSD_NR_preadv      267
-#define TARGET_OPENBSD_NR_pwritev     268
-#define TARGET_OPENBSD_NR_kqueue      269
-#define TARGET_OPENBSD_NR_kevent      270
-#define TARGET_OPENBSD_NR_mlockall    271
-#define TARGET_OPENBSD_NR_munlockall  272
-#define TARGET_OPENBSD_NR_getpeereid  273
-#define TARGET_OPENBSD_NR_getresuid   281
-#define TARGET_OPENBSD_NR_setresuid   282
-#define TARGET_OPENBSD_NR_getresgid   283
-#define TARGET_OPENBSD_NR_setresgid   284
-#define TARGET_OPENBSD_NR_mquery      286
-#define TARGET_OPENBSD_NR_closefrom   287
-#define TARGET_OPENBSD_NR_sigaltstack 288
-#define TARGET_OPENBSD_NR_shmget      289
-#define TARGET_OPENBSD_NR_semop       290
-#define TARGET_OPENBSD_NR_stat        291
-#define TARGET_OPENBSD_NR_fstat       292
-#define TARGET_OPENBSD_NR_lstat       293
-#define TARGET_OPENBSD_NR_fhstat      294
-#define TARGET_OPENBSD_NR___semctl    295
-#define TARGET_OPENBSD_NR_shmctl      296
-#define TARGET_OPENBSD_NR_msgctl      297
-#define TARGET_OPENBSD_NR_sched_yield 298
-#define TARGET_OPENBSD_NR_getthrid    299
-#define TARGET_OPENBSD_NR_thrsleep    300
-#define TARGET_OPENBSD_NR_thrwakeup   301
-#define TARGET_OPENBSD_NR_threxit     302
-#define TARGET_OPENBSD_NR_thrsigdivert        303
-#define TARGET_OPENBSD_NR___getcwd    304
-#define TARGET_OPENBSD_NR_adjfreq     305
-#define TARGET_OPENBSD_NR_getfsstat   306
-#define TARGET_OPENBSD_NR_statfs      307
-#define TARGET_OPENBSD_NR_fstatfs     308
-#define TARGET_OPENBSD_NR_fhstatfs    309
-
-/* syscall flags from machine/trap.h */
-
-/*      $OpenBSD: trap.h,v 1.4 2008/07/04 22:04:37 kettenis Exp $       */
-/*      $NetBSD: trap.h,v 1.4 1999/06/07 05:28:04 eeh Exp $ */
-
-/*
- * Copyright (c) 1996-1999 Eduardo Horvath
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR  ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR  BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- */
-#define TARGET_OPENBSD_SYSCALL_G2RFLAG 0x400   /* on success, return to %g2 rather than npc */
-#define TARGET_OPENBSD_SYSCALL_G7RFLAG 0x800   /* use %g7 as above (deprecated) */
diff --git a/bsd-user/openbsd/target_os_elf.h b/bsd-user/openbsd/target_os_elf.h
deleted file mode 100644
index 4cf5747dcd..0000000000
--- a/bsd-user/openbsd/target_os_elf.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- *  openbsd ELF definitions
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
-        size += 1;                        /* argc itself */
-        size *= n;
-        if (size & 15) {
-            sp -= 16 - (size & 15);
-        }
-
-        /*
-         * OpenBSD defines elf_addr_t as Elf32_Off / Elf64_Off
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
diff --git a/bsd-user/openbsd/target_os_siginfo.h b/bsd-user/openbsd/target_os_siginfo.h
deleted file mode 100644
index 732009a820..0000000000
--- a/bsd-user/openbsd/target_os_siginfo.h
+++ /dev/null
@@ -1,82 +0,0 @@
-#ifndef TARGET_OS_SIGINFO_H
-#define TARGET_OS_SIGINFO_H
-
-#define TARGET_NSIG     32   /* counting 0; could be 33 (mask is 1-32) */
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
diff --git a/bsd-user/openbsd/target_os_signal.h b/bsd-user/openbsd/target_os_signal.h
deleted file mode 100644
index 4ee4f768e0..0000000000
--- a/bsd-user/openbsd/target_os_signal.h
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
diff --git a/bsd-user/openbsd/target_os_stack.h b/bsd-user/openbsd/target_os_stack.h
deleted file mode 100644
index 264a658608..0000000000
--- a/bsd-user/openbsd/target_os_stack.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- *  OpenBSD setup_initial_stack() implementation.
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
diff --git a/bsd-user/openbsd/target_os_thread.h b/bsd-user/openbsd/target_os_thread.h
deleted file mode 100644
index c3adc6712f..0000000000
--- a/bsd-user/openbsd/target_os_thread.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  OpenBSD thread dependent code and definitions
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
index 93388e7c34..2594c3ef2a 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -182,9 +182,6 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
                            abi_long arg2, abi_long arg3, abi_long arg4,
                            abi_long arg5, abi_long arg6);
-abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
-                            abi_long arg2, abi_long arg3, abi_long arg4,
-                            abi_long arg5, abi_long arg6);
 void gemu_log(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 extern __thread CPUState *thread_cpu;
 char *target_strerror(int err);
@@ -215,11 +212,6 @@ print_netbsd_syscall(int num,
                      abi_long arg1, abi_long arg2, abi_long arg3,
                      abi_long arg4, abi_long arg5, abi_long arg6);
 void print_netbsd_syscall_ret(int num, abi_long ret);
-void
-print_openbsd_syscall(int num,
-                      abi_long arg1, abi_long arg2, abi_long arg3,
-                      abi_long arg4, abi_long arg5, abi_long arg6);
-void print_openbsd_syscall_ret(int num, abi_long ret);
 /**
  * print_taken_signal:
  * @target_signum: target signal being taken
diff --git a/bsd-user/strace.c b/bsd-user/strace.c
index 6dc01d3be7..bf54b3bfff 100644
--- a/bsd-user/strace.c
+++ b/bsd-user/strace.c
@@ -156,9 +156,6 @@ static const struct syscallname freebsd_scnames[] = {
 static const struct syscallname netbsd_scnames[] = {
 #include "netbsd/strace.list"
 };
-static const struct syscallname openbsd_scnames[] = {
-#include "openbsd/strace.list"
-};
 
 static void print_syscall(int num, const struct syscallname *scnames,
         unsigned int nscnames, abi_long arg1, abi_long arg2, abi_long arg3,
@@ -244,20 +241,6 @@ void print_netbsd_syscall_ret(int num, abi_long ret)
     print_syscall_ret(num, ret, netbsd_scnames, ARRAY_SIZE(netbsd_scnames));
 }
 
-void print_openbsd_syscall(int num, abi_long arg1, abi_long arg2, abi_long arg3,
-        abi_long arg4, abi_long arg5, abi_long arg6)
-{
-
-    print_syscall(num, openbsd_scnames, ARRAY_SIZE(openbsd_scnames), arg1, arg2,
-            arg3, arg4, arg5, arg6);
-}
-
-void print_openbsd_syscall_ret(int num, abi_long ret)
-{
-
-    print_syscall_ret(num, ret, openbsd_scnames, ARRAY_SIZE(openbsd_scnames));
-}
-
 static void
 print_signal(abi_ulong arg, int last)
 {
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index cc4b484f3a..ed28a318dd 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -27,7 +27,6 @@
 
 #include "freebsd/syscall_nr.h"
 #include "netbsd/syscall_nr.h"
-#include "openbsd/syscall_nr.h"
 
 /*
  * machine/_types.h
@@ -120,15 +119,6 @@ struct bsd_shm_regions {
 
 #define TARGET_NETBSD_MAP_FLAGMASK      0x3ff7
 
-#define TARGET_OPENBSD_MAP_INHERIT      0x0080  /* region is retained after */
-                                                /* exec */
-#define TARGET_OPENBSD_MAP_NOEXTEND     0x0100  /* for MAP_FILE, don't change */
-                                                /* file size */
-#define TARGET_OPENBSD_MAP_TRYFIXED     0x0400  /* attempt hint address, */
-                                                /* even within heap */
-
-#define TARGET_OPENBSD_MAP_FLAGMASK     0x17f7
-
 /* XXX */
 #define TARGET_BSD_MAP_FLAGMASK         0x3ff7
 

-- 
2.52.0


