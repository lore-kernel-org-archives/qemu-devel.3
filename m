Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1122606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ToNPt+od
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL04M-0001MH-1T; Sun, 25 Oct 2026 11:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xL04K-0001M2-3g
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 11:23:32 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xL04G-0004YB-UT
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 11:23:31 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3ab01c46697so17962691fa.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792941806; x=1793546606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qUT9iuPYRbM96jh3wL60XywJWR4lUFFm/QZ9Ss5o7zc=;
 b=ToNPt+odPBAm9XsRi5bqoF8CMF7Sasg0Gxxpb/OvlscZHu1ZMTR9cYsstbBFUvd+c8
 DUvkGSDDTR6oFGPYezVfMHhZXjl0c4dqUQ7at50F/6+lTcQhhrmNehf0IX+vsH3PL74d
 5QPq0Nuu1jZiK4EdzDzqtZomexgTSVsldnueQ2HiMvHAnuWOFboSl1xp8Rh0+286rBNV
 jjskb6Rv4JU9lulIeTQJM4xo+7t4ZbGQD8xKV7bKgAQbZa0YOisxm+61zCAwC6yqPlaR
 VD+wXMdN2+ewQyPcUYGiMzZ1bxBQxzXyobH07y7j0DjKIGPUifw+0w4U/wHNdft5s1xG
 RnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792941806; x=1793546606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qUT9iuPYRbM96jh3wL60XywJWR4lUFFm/QZ9Ss5o7zc=;
 b=o4O2JGDyWrZ5bocY4BdL8EZIV0Qrugkk4Ik0Hq52cRHI252NnC1vU+29PkRaLSXEJR
 UcDWcHw3thklIrTeuexJBsOKRPXkOVcItetu8aHzzdFAOJu586aDW3aiCp/nECu8i6ch
 f04XJINjq0QPoYitnnXndAHW7XQuhKYgJ8uPwnyUKECphBKQLnFd7LFdI2ir/u8Xk9t7
 jiLPGPWNZmNon0tDa0OWdQbRO1mWwhS+eODlIIVqPDYur7gSE5kvGuW/EJ/wUT+Kk8es
 qiDOr9wuZW0m45WtSKBukJORA9a+eQ1sMqoM0pJJNOLoFrLUxlF4L4SrdSLc26Jox0KA
 uUTQ==
X-Gm-Message-State: AFq9FYLKM438L+CkpThsoNuk8/AJcMap0jgdnH24d1wgRD2iWZ3KvMh7
 EwqTgyBvLMbpax91osjiqwEnIgi34XAFPiCAhdUXWM3c4D3ZhBw2Iy66CXNjclX7go4=
X-Gm-Gg: AYBFou0EYd5KTPpxgjYKM/3VH6dMwXDZlrqA0Wp9rvzCsadAh9Cm9BAPnKFAX1dhtEo
 l1hhNgHQhlIuS/lTWjiFll06VHBr4RIUmvZ+I4aouqOTAjlvohTArgA8FOlC3gjDvixVuE6H02R
 wSsdaaTIAnG8XHaTfhFiHhjt2ojgpNq9c1q8AXmixUpMRb/AWvwZSpvxqox4DXdnTDzUPj7M4wI
 06Y1OsRNSiqYay+whlqtK7W8UI5J4jioZchnBQcQC6CWJKYXldr4xmKcRucu7jWMLW4pdYY1/Eg
 hHXLxJ5PX8j/YWGNzR75UYznYdw1cCbHpogTOQKrMZ2SykA2jhrQmtZ+6u1bPJCoRMz3v0ACys6
 100b146tJfnVIZyMdIOf0bssx8XoW/A9GxQ/WSS7fRzVztzPC7QJU1eN9ll2Xjx86Cffj/b3Tqj
 BoqX3UCsA5e40RHIbXXN3W/Pbt5TN+mNbHDMePC5xP9ISjP6GSXwomlifWLadhlk13md9T6kFky
 +BfPry2bR9qk/atnAtjUsJVbLprbAsqILGLQ54qIrDnr6ngMLGe9szsDCYXj5TiFEH4C6wpHJH/
 xAMlEPSx+LHJkOfSenZUeZEF33Mdhk4pTNmzXkV3wck8PZwrc3Q=
X-Received: by 2002:a05:6512:1087:b0:5bf:b996:d8ee with SMTP id
 2adb3069b0e04-5bfb996dc25mr989175e87.47.1792941805303; 
 Sun, 25 Oct 2026 08:23:25 -0700 (PDT)
Received: from qblck ([188.130.155.185]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a322e9sm982783e87.4.2026.10.25.08.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 08:23:24 -0700 (PDT)
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] linux-user: honor dirfd for synthetic proc opens
Date: Sun, 25 Oct 2026 18:23:14 +0300
Message-ID: <20261025152314.49954-1-ralerrdirsardx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025131700.34930-1-ralerrdirsardx@gmail.com>
References: <20261025131700.34930-1-ralerrdirsardx@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Opening "<pid>/cmdline" relative to a directory descriptor for /proc
can return QEMU's command line instead of the guest's.

Honor dirfd when selecting synthetic proc contents and add regression
coverage for openat and openat2.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4458
Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
---
 linux-user/syscall.c                     | 321 +++++++++++++++++------
 tests/tcg/multiarch/linux/proc-openat.c  |  94 +++++++
 tests/tcg/multiarch/linux/proc-openat2.c |  83 ++++++
 tests/tcg/multiarch/meson.build          |   2 +
 4 files changed, 418 insertions(+), 82 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/proc-openat.c
 create mode 100644 tests/tcg/multiarch/linux/proc-openat2.c

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0380691a8b..0583e7e19d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8839,12 +8839,132 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
-                              const char *fname, int flags, mode_t mode,
-                              int openat2_resolve, bool safe)
+static char *proc_entry_path(int dirfd, const char *name)
+{
+    g_autofree char *base = NULL;
+    g_autofree char *absolute = NULL;
+    g_autofree char *parent = NULL;
+    g_autofree char *resolved = NULL;
+    g_autofree char *entry = NULL;
+    char fd_path[64];
+
+    if (!name[0]) {
+        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", dirfd);
+        return g_file_read_link(fd_path, NULL);
+    }
+    if (name[0] == '/') {
+        absolute = g_strdup(name);
+    } else {
+        if (dirfd == AT_FDCWD) {
+            base = getcwd(NULL, 0);
+        } else {
+            snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", dirfd);
+            base = g_file_read_link(fd_path, NULL);
+        }
+        if (!base) {
+            return NULL;
+        }
+        absolute = g_build_filename(base, name, NULL);
+    }
+    parent = g_path_get_dirname(absolute);
+    resolved = realpath(parent, NULL);
+    if (!resolved) {
+        return NULL;
+    }
+    entry = g_path_get_basename(absolute);
+    return g_build_filename(resolved, entry, NULL);
+}
+
+static int fake_open_contents(CPUArchState *cpu_env,
+                              int (*fill)(CPUArchState *, int),
+                              int status_flags, bool safe)
+{
+    g_autofree char *filename = NULL;
+    const char *tmpdir = g_get_tmp_dir();
+    const char *reader_path;
+    char fd_path[64];
+    bool named = status_flags & O_NOFOLLOW;
+    int fd, reader = -1, result = -1, saved_errno;
+
+retry:
+    if (named) {
+        g_free(filename);
+        filename = g_build_filename(tmpdir, "qemu-open.XXXXXX", NULL);
+        fd = g_mkstemp_full(filename, O_RDWR | O_CLOEXEC, 0600);
+        if (fd < 0 && strcmp(tmpdir, P_tmpdir) &&
+            errno != EMFILE && errno != ENFILE &&
+            errno != ENOMEM && errno != EINTR) {
+            tmpdir = P_tmpdir;
+            goto retry;
+        }
+    } else {
+        fd = memfd_create("qemu-open", MFD_CLOEXEC);
+    }
+    if (fd < 0) {
+        if (!named && (errno == ENOSYS || errno == EPERM)) {
+            named = true;
+            goto retry;
+        }
+        return -1;
+    }
+    if (fill(cpu_env, fd)) {
+        goto out;
+    }
+    if (named) {
+        int closed = close(fd);
+
+        fd = -1;
+        if (closed < 0) {
+            goto out;
+        }
+        reader_path = filename;
+    } else {
+        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd);
+        reader_path = fd_path;
+    }
+    reader = safe ? safe_openat(AT_FDCWD, reader_path, status_flags, 0) :
+                    openat(AT_FDCWD, reader_path, status_flags, 0);
+    if (reader < 0) {
+        if (!named && errno == EMFILE) {
+            close(fd);
+            named = true;
+            goto retry;
+        }
+        goto out;
+    }
+    result = named ? reader : dup3(reader, fd, status_flags & O_CLOEXEC);
+    if (result >= 0) {
+        if (named) {
+            reader = -1;
+        } else {
+            fd = -1;
+        }
+    }
+out:
+    saved_errno = errno;
+    if (reader >= 0) {
+        close(reader);
+    }
+    if (fd >= 0) {
+        close(fd);
+    }
+    if (named) {
+        unlink(filename);
+    }
+    errno = saved_errno;
+    return result;
+}
+
+static int maybe_do_fake_open(CPUArchState *cpu_env, int opened_fd, int dirfd,
+                              const char *fname,
+                              const struct open_how_ver0 *how,
+                              bool safe)
 {
     g_autofree char *proc_name = NULL;
+    char fd_path[64];
     const char *pathname;
+    int flags = how->flags;
+    int original_errno = errno;
     struct fake_open {
         const char *filename;
         int (*fill)(CPUArchState *cpu_env, int fd);
@@ -8869,26 +8989,70 @@ static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
         { NULL, NULL, NULL }
     };
 
-    /* if this is a file from /proc/ filesystem, expand full name */
-    proc_name = realpath(fname, NULL);
-    if (proc_name && strncmp(proc_name, "/proc/", 6) == 0) {
-        pathname = proc_name;
-    } else {
-        pathname = fname;
+    if (opened_fd >= 0 &&
+        ((flags & (O_PATH | O_NOFOLLOW)) == (O_PATH | O_NOFOLLOW))) {
+        return opened_fd;
+    }
+    if (opened_fd < 0 && original_errno != ENOENT) {
+        return opened_fd;
     }
 
-    if (is_proc_myself(pathname, "exe")) {
-        /* Honor openat2 resolve flags */
-        if ((openat2_resolve & RESOLVE_NO_MAGICLINKS) ||
-            (openat2_resolve & RESOLVE_NO_SYMLINKS)) {
-            errno = ELOOP;
-            return -1;
+    if (opened_fd >= 0 && !(flags & O_NOFOLLOW) &&
+        !(how->resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH |
+                           RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINKS))) {
+        struct stat opened, executable;
+
+        if (fstat(opened_fd, &opened) == 0 &&
+            stat("/proc/self/exe", &executable) == 0 &&
+            opened.st_dev == executable.st_dev &&
+            opened.st_ino == executable.st_ino) {
+            g_autofree char *entry = proc_entry_path(dirfd, fname);
+
+            if (entry && is_proc_myself(entry, "exe")) {
+                close(opened_fd);
+                if (how->resolve) {
+                    return safe_openat2(AT_FDCWD, real_exec_path,
+                                        how, sizeof(*how));
+                }
+                return safe ? safe_openat(AT_FDCWD, real_exec_path,
+                                          flags, how->mode) :
+                       openat(AT_FDCWD, real_exec_path, flags, how->mode);
+            }
         }
-        if (safe) {
-            return safe_openat(dirfd, real_exec_path, flags, mode);
-        } else {
-            return openat(dirfd, real_exec_path, flags, mode);
+    }
+
+    if (opened_fd < 0) {
+        g_autofree char *parent = g_path_get_dirname(fname);
+        g_autofree char *entry = g_path_get_basename(fname);
+        g_autofree char *directory = NULL;
+        struct open_how_ver0 parent_how = {
+            .flags = O_PATH | O_DIRECTORY | O_CLOEXEC,
+            .resolve = how->resolve,
+        };
+        int fd;
+
+        fd = how->resolve ?
+             safe_openat2(dirfd, parent, &parent_how, sizeof(parent_how)) :
+             safe ? safe_openat(dirfd, parent, parent_how.flags, 0) :
+                    openat(dirfd, parent, parent_how.flags, 0);
+        if (fd >= 0) {
+            snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd);
+            directory = g_file_read_link(fd_path, NULL);
+            close(fd);
+            if (directory) {
+                proc_name = g_build_filename(directory, entry, NULL);
+            }
         }
+    } else {
+        snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", opened_fd);
+        proc_name = g_file_read_link(fd_path, NULL);
+    }
+    pathname = proc_name;
+
+    if ((opened_fd >= 0 && (flags & O_PATH)) ||
+        !pathname || strncmp(pathname, "/proc/", 6)) {
+        errno = original_errno;
+        return opened_fd;
     }
 
     for (fake_open = fakes; fake_open->filename; fake_open++) {
@@ -8898,60 +9062,52 @@ static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
     }
 
     if (fake_open->filename) {
-        const char *tmpdir;
-        char filename[PATH_MAX];
-        int fd, r;
-
-        fd = memfd_create("qemu-open", 0);
-        if (fd < 0) {
-            if (errno != ENOSYS) {
-                return fd;
-            }
-            /* create temporary file to map stat to */
-            tmpdir = getenv("TMPDIR");
-            if (!tmpdir)
-                tmpdir = "/tmp";
-            snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX", tmpdir);
-            fd = mkstemp(filename);
-            if (fd < 0) {
-                return fd;
-            }
-            unlink(filename);
-        }
-
-        if ((r = fake_open->fill(cpu_env, fd))) {
-            int e = errno;
-            close(fd);
-            errno = e;
-            return r;
+        int saved_errno, status_flags;
+
+        status_flags = flags & ~(O_CREAT | O_EXCL | O_TRUNC);
+        if (opened_fd >= 0) {
+            status_flags = fcntl(opened_fd, F_GETFL);
+            saved_errno = errno;
+            close(opened_fd);
+            if (status_flags < 0) {
+                errno = saved_errno;
+                return -1;
+            }
+        } else if (flags & O_DIRECTORY) {
+            errno = ENOTDIR;
+            return -1;
+        } else if ((flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL)) {
+            errno = EEXIST;
+            return -1;
         }
-        lseek(fd, 0, SEEK_SET);
 
-        return fd;
+        status_flags |= flags & O_CLOEXEC;
+        return fake_open_contents(cpu_env, fake_open->fill, status_flags, safe);
     }
 
-    return -2;
+    errno = original_errno;
+    return opened_fd;
 }
 
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
                     int flags, mode_t mode, bool safe)
 {
-    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, flags, mode, 0, safe);
-    if (fd > -2) {
-        return fd;
-    }
+    struct open_how_ver0 how = { .flags = flags, .mode = mode };
+    const char *host_name = path(pathname);
+    int fd;
 
     if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
+        fd = safe_openat(dirfd, host_name, flags, mode);
     } else {
-        return openat(dirfd, path(pathname), flags, mode);
+        fd = openat(dirfd, host_name, flags, mode);
     }
+    return maybe_do_fake_open(cpu_env, fd, dirfd, host_name, &how,
+                              safe);
 }
 
-
 static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
-                      abi_ptr guest_pathname, abi_ptr guest_open_how,
-                      abi_ulong guest_size)
+                     abi_ptr guest_pathname, abi_ptr guest_open_how,
+                     abi_ulong guest_size)
 {
     struct open_how_ver0 how = {0};
     char *pathname;
@@ -8981,23 +9137,19 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
     how.flags = target_to_host_bitmask(tswap64(how.flags), fcntl_flags_tbl);
     how.mode = tswap64(how.mode);
     how.resolve = tswap64(how.resolve);
-    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags, how.mode,
-                                how.resolve, true);
-    if (fd > -2) {
-        ret = get_errno(fd);
-    } else {
-        const char *host_pathname = pathname;
-        if (pathname[0] == '/' &&
-            !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
-            /*
-             * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
-             * resolves them relative to dirfd.
-             */
-            host_pathname = path(pathname);
-        }
-        ret = get_errno(safe_openat2(dirfd, host_pathname, &how,
-                                     sizeof(struct open_how_ver0)));
+    const char *host_pathname = pathname;
+    if (pathname[0] == '/' &&
+        !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
+        /*
+         * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
+         * resolves them relative to dirfd.
+         */
+        host_pathname = path(pathname);
     }
+    int fd = safe_openat2(dirfd, host_pathname, &how,
+                         sizeof(struct open_how_ver0));
+    ret = get_errno(maybe_do_fake_open(cpu_env, fd, dirfd, host_pathname, &how,
+                                      true));
 
     fd_trans_unregister(ret);
     unlock_user(pathname, guest_pathname, 0);
@@ -9034,6 +9186,19 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
     return ret;
 }
 
+static ssize_t do_guest_readlinkat(int dirfd, const char *pathname,
+                                  char *buf, size_t bufsiz)
+{
+    const char *host_name = path(pathname);
+    g_autofree char *entry_path = proc_entry_path(dirfd, host_name);
+    ssize_t ret = readlinkat(dirfd, host_name, buf, bufsiz);
+
+    if (ret >= 0 && entry_path && is_proc_myself(entry_path, "exe")) {
+        return do_guest_readlink(entry_path, buf, bufsiz);
+    }
+    return ret;
+}
+
 static int do_execv(CPUArchState *cpu_env, int dirfd,
                     abi_long pathname, abi_long guest_argp,
                     abi_long guest_envp, int flags, bool is_execveat)
@@ -11143,16 +11308,8 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             } else if (!arg4) {
                 /* Short circuit this for the magic exe check. */
                 ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                /*
-                 * Don't worry about sign mismatch as earlier mapping
-                 * logic would have thrown a bad address error.
-                 */
-                ret = MIN(strlen(real_exec_path), arg4);
-                /* We cannot NUL terminate the string. */
-                memcpy(p2, real_exec_path, ret);
             } else {
-                ret = get_errno(readlinkat(arg1, path(p), p2, arg4));
+                ret = get_errno(do_guest_readlinkat(arg1, p, p2, arg4));
             }
             unlock_user(p2, arg3, ret);
             unlock_user(p, arg2, 0);
diff --git a/tests/tcg/multiarch/linux/proc-openat.c b/tests/tcg/multiarch/linux/proc-openat.c
new file mode 100644
index 0000000000..4af2fde113
--- /dev/null
+++ b/tests/tcg/multiarch/linux/proc-openat.c
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <unistd.h>
+
+static char expected[16384];
+static size_t expected_size;
+
+static void check(int dirfd, const char *name, int flags, int expected_errno)
+{
+    char actual[sizeof(expected)];
+    size_t size = 0;
+    int fd = openat(dirfd, name, flags);
+
+    if (expected_errno) {
+        assert(fd == -1 && errno == expected_errno);
+        return;
+    }
+    assert(fd >= 0);
+    assert((fcntl(fd, F_GETFD) & FD_CLOEXEC) ==
+           ((flags & O_CLOEXEC) ? FD_CLOEXEC : 0));
+    assert((fcntl(fd, F_GETFL) & (O_PATH | O_NOFOLLOW | O_ACCMODE)) ==
+           (flags & (O_PATH | O_NOFOLLOW | O_ACCMODE)));
+    if (flags & O_PATH) {
+        assert(read(fd, actual, 1) == -1 && errno == EBADF);
+    } else {
+        for (;;) {
+            ssize_t n = read(fd, actual + size, sizeof(actual) - size);
+
+            if (n < 0 && errno == EINTR) {
+                continue;
+            }
+            assert(n >= 0);
+            if (!n) {
+                break;
+            }
+            size += n;
+            assert(size < sizeof(actual));
+        }
+        assert(size == expected_size && !memcmp(actual, expected, size));
+        assert(write(fd, "x", 1) == -1 && errno == EBADF);
+    }
+    assert(close(fd) == 0);
+}
+
+int main(int argc, char **argv)
+{
+    struct rlimit saved, limit;
+    int cwd = open(".", O_PATH | O_DIRECTORY | O_CLOEXEC);
+    int proc = open("/proc", O_PATH | O_DIRECTORY | O_CLOEXEC);
+    int self = open("/proc/self", O_PATH | O_DIRECTORY | O_CLOEXEC);
+    int flags = O_RDONLY | O_CLOEXEC;
+
+    assert(cwd >= 0 && proc >= 0 && self >= 0);
+    for (int i = 0; i < argc; i++) {
+        size_t size = strlen(argv[i]) + 1;
+
+        assert(size <= sizeof(expected) - expected_size);
+        memcpy(expected + expected_size, argv[i], size);
+        expected_size += size;
+    }
+    check(AT_FDCWD, "/proc/self/cmdline", flags, 0);
+    check(-1, "/proc/self/cmdline", flags, 0);
+    check(proc, "self/cmdline", flags, 0);
+    check(proc, "./self/cmdline", flags, 0);
+    check(self, "cmdline", flags, 0);
+    check(self, "cmdline", flags | O_NOFOLLOW, 0);
+    check(self, "cmdline", O_PATH | O_CLOEXEC, 0);
+    check(self, "cmdline", flags | O_DIRECTORY, ENOTDIR);
+    assert(chdir("/proc") == 0);
+    check(AT_FDCWD, "self/cmdline", flags, 0);
+    check(-1, "self/cmdline", flags, EBADF);
+    assert(fchdir(cwd) == 0);
+    assert(close(self) == 0);
+    assert(close(proc) == 0);
+    assert(close(cwd) == 0);
+    assert(getrlimit(RLIMIT_NOFILE, &saved) == 0);
+    int next = open("/dev/null", O_RDONLY | O_CLOEXEC);
+
+    assert(next >= 0);
+    limit = saved;
+    limit.rlim_cur = next + 1;
+    assert(setrlimit(RLIMIT_NOFILE, &limit) == 0);
+    assert(close(next) == 0);
+    check(AT_FDCWD, "/proc/self/cmdline", flags, 0);
+    check(AT_FDCWD, "/proc/self/cmdline", flags | O_NOFOLLOW, 0);
+    assert(setrlimit(RLIMIT_NOFILE, &saved) == 0);
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/multiarch/linux/proc-openat2.c b/tests/tcg/multiarch/linux/proc-openat2.c
new file mode 100644
index 0000000000..7641bbe634
--- /dev/null
+++ b/tests/tcg/multiarch/linux/proc-openat2.c
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#ifdef SYS_openat2
+#include <linux/openat2.h>
+
+static int cmdline_argc;
+static char **cmdline_argv;
+
+static void check(int dirfd, const char *name, uint64_t flags,
+                  uint64_t resolve, int expected_errno)
+{
+    struct open_how how = { .flags = flags, .resolve = resolve };
+    char byte;
+    int fd = syscall(SYS_openat2, dirfd, name, &how, sizeof(how));
+
+    if (expected_errno) {
+        assert(fd == -1 && errno == expected_errno);
+        return;
+    }
+    assert(fd >= 0);
+    assert(fcntl(fd, F_GETFD) == FD_CLOEXEC);
+    if (flags & O_PATH) {
+        assert(fcntl(fd, F_GETFL) & O_PATH);
+        assert(read(fd, &byte, 1) == -1 && errno == EBADF);
+    } else {
+        for (int i = 0; i < cmdline_argc; i++) {
+            const char *p = cmdline_argv[i];
+
+            do {
+                assert(read(fd, &byte, 1) == 1 && byte == *p);
+            } while (*p++);
+        }
+        assert(read(fd, &byte, 1) == 0);
+        assert(write(fd, "x", 1) == -1 && errno == EBADF);
+    }
+    assert(close(fd) == 0);
+}
+#endif
+
+int main(int argc, char **argv)
+{
+#ifdef SYS_openat2
+    struct open_how how = { .flags = O_RDONLY | O_CLOEXEC };
+    int fd = syscall(SYS_openat2, AT_FDCWD, "/proc/self/cmdline",
+                     &how, sizeof(how));
+    int proc, self, root, flags = O_RDONLY | O_CLOEXEC;
+
+    cmdline_argc = argc;
+    cmdline_argv = argv;
+    if (fd < 0 && errno == ENOSYS) {
+        return EXIT_SUCCESS;
+    }
+    assert(fd >= 0 && close(fd) == 0);
+    proc = open("/proc", O_PATH | O_DIRECTORY | O_CLOEXEC);
+    self = open("/proc/self", O_PATH | O_DIRECTORY | O_CLOEXEC);
+    root = open("/", O_PATH | O_DIRECTORY | O_CLOEXEC);
+    assert(proc >= 0 && self >= 0 && root >= 0);
+    check(-1, "/proc/self/cmdline", flags, 0, 0);
+    check(AT_FDCWD, "/proc/self/cmdline", flags,
+          RESOLVE_NO_SYMLINKS, ELOOP);
+    check(proc, "self/cmdline", flags, 0, 0);
+    check(proc, "self/cmdline", flags, RESOLVE_NO_SYMLINKS, ELOOP);
+    check(proc, "self/root/proc/self/cmdline", flags,
+          RESOLVE_NO_MAGICLINKS, ELOOP);
+    check(self, "../self/cmdline", flags, RESOLVE_BENEATH, EXDEV);
+    check(self, "../self/cmdline", flags, RESOLVE_IN_ROOT, ENOENT);
+    check(root, "proc/self/cmdline", flags, RESOLVE_NO_XDEV, EXDEV);
+    check(proc, "self/cmdline", flags, UINT64_C(1) << 63, EINVAL);
+    check(self, "cmdline", O_PATH | O_CLOEXEC, 0, 0);
+    assert(close(root) == 0);
+    assert(close(self) == 0);
+    assert(close(proc) == 0);
+#endif
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index e60a052700..337dda729a 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -61,6 +61,8 @@ tests += {
   multiarch/'linux/linux-shmat-null.c': {},
   multiarch/'linux/linux-sigrtminmax.c': {},
   multiarch/'linux/linux-test.c': {},
+  multiarch/'linux/proc-openat.c': {},
+  multiarch/'linux/proc-openat2.c': {},
   multiarch/'linux/test-vma.c': {},
 }
 
-- 
2.55.0


