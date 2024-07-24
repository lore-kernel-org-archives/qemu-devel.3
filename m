Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEC6C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk8C-0001Na-Hg; Wed, 24 Jul 2024 18:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7z-0000UZ-5R
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:31 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7w-0006cC-Rg
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:30 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7f6e9662880so16894939f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858787; x=1722463587;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Whe4XPbca7lrsBGH9KDOzbYV/caOsn/K1GjqT+CBVQ=;
 b=ahXEshitWKLHCQ0G+SO8WLSU6/YAYY8o8oRi1coH4/xTmPKiGEEHNfmM5kZEmVgOqU
 GGmKVChlkrRY0W/NgSpCK2qLtoKUhmgJKF2DqfJL5I0fSGMZLjHW5J2GffzKc89UsEiw
 BfgU//kLFrfM7nUuPb+gbIm8XufXRuSnDeSDLQnEAEe1lDf7Alari4xrhihqzX3ybF3n
 2L2aXVAk6Yz8hCbBvY9sR3m4D47AjahYPzCsUk5T0Stf+Uff4HvjSMbOppzu7PVmjsVR
 nBymYSQctZXrPlrQm5a5SBVCK7M2sgKff9TwqlaayLxU6Y1jaqwfcGh9roTz0KjHbe7w
 QYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858787; x=1722463587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Whe4XPbca7lrsBGH9KDOzbYV/caOsn/K1GjqT+CBVQ=;
 b=R9gzbqkn9Gj4i9Kev2grwZ1BEk3HbUL3gM9tn6FCEuVsCFt5Lwc6wOf9FkxAUQIa4X
 Klyh0T/hNuvjqwDkGUXhKz8zqHsB7p4nIArM1E/iSbp5u7vp/XMmank1e2LJ+EZ69LPX
 ufgBGS+aTJbuUpkuGufhOVTP7y3W37YplyZIpFaC+HYDSCqDcW5dQs5HTGypvRfP571/
 OGHxZO9UqA+S5IL+uH4RgYomF+/aJi+zP0CZSofqG2YKJcLW9OgSsg5hs8o0wFfDpnYn
 fCswtXHojzx3LifpUTsttFBFIpHNuebMToepq7M2AszIPqt7/9h3G/eyxfAn5A3aYDuI
 mi/w==
X-Gm-Message-State: AOJu0Yw4ISpsLdu09kw7tUvQHuWs0MpjRXJ+xMYCplt900qdopddJoVv
 6vs0n+bDNyiQHRPx3ylpzO1A+e5plnJfpU6zjagpIhQ+ONoTI72ZS6fDijP1hFv0JQ8LQxb75nx
 ZzK4=
X-Google-Smtp-Source: AGHT+IE1q7798A1JZmkyftq3Feci8Pt5KvdVdtFnW3VT2fddhYOrRbeOE1sl51tyXiuqUoYSqF6lQA==
X-Received: by 2002:a05:6602:2cd5:b0:81f:774b:88ee with SMTP id
 ca18e2360f4ac-81f7e49b0efmr16585639f.13.1721858786982; 
 Wed, 24 Jul 2024 15:06:26 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Doug Rabson <dfr@rabson.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/15] bsd-user: Simplify the implementation of execve
Date: Wed, 24 Jul 2024 16:04:42 -0600
Message-ID: <20240724220449.10398-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

From: Doug Rabson <dfr@rabson.org>

This removes the logic which prepends the emulator to each call to
execve and fexecve. This is not necessary with the existing
imgact_binmisc support and it avoids the need to install the emulator
binary into jail environments when using 'binmiscctl --pre-open'.

Signed-off-by: Doug Rabson <dfr@rabson.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-proc.c | 118 +------------------------------------
 bsd-user/main.c            |  18 ------
 2 files changed, 3 insertions(+), 133 deletions(-)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index e0203e259b0..bf993f1b662 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -26,65 +26,13 @@ struct kinfo_proc;
 
 #include "qemu.h"
 
-/*
- * Get the filename for the given file descriptor.
- * Note that this may return NULL (fail) if no longer cached in the kernel.
- */
-static char *
-get_filename_from_fd(pid_t pid, int fd, char *filename, size_t len)
-{
-    char *ret = NULL;
-    unsigned int cnt;
-    struct procstat *procstat = NULL;
-    struct kinfo_proc *kp = NULL;
-    struct filestat_list *head = NULL;
-    struct filestat *fst;
-
-    procstat = procstat_open_sysctl();
-    if (procstat == NULL) {
-        goto out;
-    }
-
-    kp = procstat_getprocs(procstat, KERN_PROC_PID, pid, &cnt);
-    if (kp == NULL) {
-        goto out;
-    }
-
-    head = procstat_getfiles(procstat, kp, 0);
-    if (head == NULL) {
-        goto out;
-    }
-
-    STAILQ_FOREACH(fst, head, next) {
-        if (fd == fst->fs_fd) {
-            if (fst->fs_path != NULL) {
-                (void)strlcpy(filename, fst->fs_path, len);
-                ret = filename;
-            }
-            break;
-        }
-    }
-
-out:
-    if (head != NULL) {
-        procstat_freefiles(procstat, head);
-    }
-    if (kp != NULL) {
-        procstat_freeprocs(procstat, kp);
-    }
-    if (procstat != NULL) {
-        procstat_close(procstat);
-    }
-    return ret;
-}
-
 /*
  * execve/fexecve
  */
 abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
         abi_ulong guest_envp, int do_fexec)
 {
-    char **argp, **envp, **qargp, **qarg1, **qarg0, **qargend;
+    char **argp, **envp, **qarg0;
     int argc, envc;
     abi_ulong gp;
     abi_ulong addr;
@@ -117,9 +65,7 @@ abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
     qarg0 = argp = g_new0(char *, argc + 9);
     /* save the first argument for the emulator */
     *argp++ = (char *)getprogname();
-    qargp = argp;
     *argp++ = (char *)getprogname();
-    qarg1 = argp;
     envp = g_new0(char *, envc + 1);
     for (gp = guest_argp, q = argp; gp; gp += sizeof(abi_ulong), q++) {
         if (get_user_ual(addr, gp)) {
@@ -137,7 +83,6 @@ abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
         total_size += strlen(*q) + 1;
     }
     *q++ = NULL;
-    qargend = q;
 
     for (gp = guest_envp, q = envp; gp; gp += sizeof(abi_ulong), q++) {
         if (get_user_ual(addr, gp)) {
@@ -166,71 +111,14 @@ abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
     }
 
     if (do_fexec) {
-        if (((int)path_or_fd > 0 &&
-            is_target_elf_binary((int)path_or_fd)) == 1) {
-            char execpath[PATH_MAX];
-
-            /*
-             * The executable is an elf binary for the target
-             * arch.  execve() it using the emulator if we can
-             * determine the filename path from the fd.
-             */
-            if (get_filename_from_fd(getpid(), (int)path_or_fd, execpath,
-                        sizeof(execpath)) != NULL) {
-                memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1));
-                qarg1[1] = qarg1[0];
-                qarg1[0] = (char *)"-0";
-                qarg1 += 2;
-                qargend += 2;
-                *qarg1 = execpath;
-#ifndef DONT_INHERIT_INTERP_PREFIX
-                memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1));
-                *qarg1++ = (char *)"-L";
-                *qarg1++ = (char *)interp_prefix;
-#endif
-                ret = get_errno(execve(qemu_proc_pathname, qargp, envp));
-            } else {
-                /* Getting the filename path failed. */
-                ret = -TARGET_EBADF;
-                goto execve_end;
-            }
-        } else {
-            ret = get_errno(fexecve((int)path_or_fd, argp, envp));
-        }
+        ret = get_errno(fexecve((int)path_or_fd, argp, envp));
     } else {
-        int fd;
-
         p = lock_user_string(path_or_fd);
         if (p == NULL) {
             ret = -TARGET_EFAULT;
             goto execve_end;
         }
-
-        /*
-         * Check the header and see if it a target elf binary.  If so
-         * then execute using qemu user mode emulator.
-         */
-        fd = open(p, O_RDONLY | O_CLOEXEC);
-        if (fd > 0 && is_target_elf_binary(fd) == 1) {
-            close(fd);
-            /* execve() as a target binary using emulator. */
-            memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1));
-            qarg1[1] = qarg1[0];
-            qarg1[0] = (char *)"-0";
-            qarg1 += 2;
-            qargend += 2;
-            *qarg1 = (char *)p;
-#ifndef DONT_INHERIT_INTERP_PREFIX
-            memmove(qarg1 + 2, qarg1, (qargend - qarg1) * sizeof(*qarg1));
-            *qarg1++ = (char *)"-L";
-            *qarg1++ = (char *)interp_prefix;
-#endif
-            ret = get_errno(execve(qemu_proc_pathname, qargp, envp));
-        } else {
-            close(fd);
-            /* Execve() as a host native binary. */
-            ret = get_errno(execve(p, argp, envp));
-        }
+        ret = get_errno(execve(p, argp, envp));
         unlock_user(p, path_or_fd, 0);
     }
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index dcad266c2c9..82e94a03160 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -90,7 +90,6 @@ unsigned long reserved_va;
 
 const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
-char qemu_proc_pathname[PATH_MAX];  /* full path to exeutable */
 
 unsigned long target_maxtsiz = TARGET_MAXTSIZ;   /* max text size */
 unsigned long target_dfldsiz = TARGET_DFLDSIZ;   /* initial data size limit */
@@ -247,22 +246,6 @@ adjust_ssize(void)
     setrlimit(RLIMIT_STACK, &rl);
 }
 
-static void save_proc_pathname(char *argv0)
-{
-    int mib[4];
-    size_t len;
-
-    mib[0] = CTL_KERN;
-    mib[1] = KERN_PROC;
-    mib[2] = KERN_PROC_PATHNAME;
-    mib[3] = -1;
-
-    len = sizeof(qemu_proc_pathname);
-    if (sysctl(mib, 4, qemu_proc_pathname, &len, NULL, 0)) {
-        perror("sysctl");
-    }
-}
-
 int main(int argc, char **argv)
 {
     const char *filename;
@@ -292,7 +275,6 @@ int main(int argc, char **argv)
         usage();
     }
 
-    save_proc_pathname(argv[0]);
 
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
-- 
2.45.1


