Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CF5C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujiKC-0003i4-Rq; Wed, 06 Aug 2025 13:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1ujiKB-0003hw-RF
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 13:53:15 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1ujiK9-0002sj-BB
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 13:53:15 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7e817450f7eso16213185a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754502792; x=1755107592; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=HE3LsxDnIfCoMAC3rO0Ayp7pYv2zjmz6eHf+dRchh1w=;
 b=kRM/48aBJydVAZLJSRKCyx4ng2xz7vWXTa9p6PZGnP3IsNjIl7Owyq8KWhYrKeQeFd
 p1TTKBwBbMSFUp7U1oc/LQx9nlPeuUcZHcs1/5Wc51268NOGr/gTxQ1PWlFg5ILxK66s
 c29a3Z7kCH2HubPGJulcFC9viISLwwRpXlt+duy+GiqJct9Disf/iYnowGeyUNXv4p3m
 SdSroI7mOhv9+Hy/ebEzvPJGBpXnBRYKYZOCX/eLleGygT+46SMzavXUODgM4RSYEJty
 /p9pvYaZdD/KD73DlY/3ieCbpKsizPJpWg+0EoE5VVLvMqwsUgnugHenwwCZ6GriDzXh
 wj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754502792; x=1755107592;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HE3LsxDnIfCoMAC3rO0Ayp7pYv2zjmz6eHf+dRchh1w=;
 b=Xm6ziDfRWVlAFYHOx8BeQzeFiGtXkHjRZQ361kumU9Yb2wGrMhf054/WJMpqwZWu2r
 J/edtS3MwG4LKTwFQSe0wNPOXLdiwGve4CYrc3UOv+PfwD53TZIztQjGUyVr3JyMLtUI
 6MX0Tm7FZlHvGIghJopaa1Vch7jV4V9MGF9dZFvJcfQ7zMUpJUp280mjpWSCQUo19vJX
 9IckgIIMlB8DrsLscbcZYycbf+HXPf6bp27ay1PSQaZgZCYxu6x3L86CvFMCW3pSRlmA
 bwmxW1Hv6WpVfNrchAu5ltqbEd5kGy+jDySrD6yhla11iiV85P0A9e7Yfy6O21EjS4wI
 0ueA==
X-Gm-Message-State: AOJu0Yy52JJhdiGjJosSs2ZkLzecycCq0tqjYVSDu+SJQRh3j7T42ejp
 n+QcbICFV+NmQv4dJklJVjhm79r2Zoc+UCnU6ABfKUkeKssqAvLV6IB6bbyo3UR9
X-Gm-Gg: ASbGncsqLfPm8CyrKGCzsfsXZ3GFweGT83VD0R0bh1PjeOKozQ841dFAEHLsaVOw8+3
 JE47PtupsPmNYsaj7yKASO31+mR+H7zAV2ZG7yZfVIZ7DPo8Va6mzvd+BWmV5rlNAE4rqOWDBtQ
 7dMqVIdvkzdifon2fXI3DqFwFeaubY5ehqLfpCUs70VomsZxcJsYFaU/vLEXKldgw3cEewLP8aW
 U9g85lFCjBN3xmxQemR7q2Qi5Gf5N+HYbkHj1SOnn2Mkiat6jMOgbyZo/s56Mp/oQXcPV3G4VY/
 MTvl8+sohwBb1oVqasti/8q4/Ps9ohFKqDkSBO0DNiP4PU8jkbDpDaxgVIkXzqNEtohPgRd/opR
 cgtfREyUK5EHQbc1GWesO9SOvpYiCKvuFk/16
X-Google-Smtp-Source: AGHT+IEV9I38UskB8l0G+eFRGrrnbHvw1Stj7t9lEpy9cFwS9JVm9XSFyRakowTs238U01X6iVnddA==
X-Received: by 2002:a05:620a:44c7:b0:7e8:16cb:afa3 with SMTP id
 af79cd13be357-7e816cbbf76mr458385385a.13.1754502791616; 
 Wed, 06 Aug 2025 10:53:11 -0700 (PDT)
Received: from nuc (192-0-220-237.cpe.teksavvy.com. [192.0.220.237])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e69716fa4asm610317885a.58.2025.08.06.10.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 10:53:11 -0700 (PDT)
Date: Wed, 6 Aug 2025 13:53:08 -0400
From: Mark Johnston <markj@freebsd.org>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: [PATCH v2] 9pfs: Add FreeBSD support
Message-ID: <aJOWhHB2p-fbueAm@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=markjdb@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is largely derived from existing Darwin support.  FreeBSD
apparently has better support for *at() system calls so doesn't require
workarounds for a missing mknodat().  The implementation has a couple of
warts however:
- The extattr(2) system calls don't support anything akin to
  XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
- Attribute names cannot begin with "user." on ZFS, so the prefix is
  trimmed off.  FreeBSD's extattr system calls sport an extra
  "namespace" identifier, and attributes created by the 9pfs backend
  live in the universal user namespace, so this seems innocent enough.

The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
filesystems.

Signed-off-by: Mark Johnston <markj@FreeBSD.org>
---
Changes since v1:
- Handle extended attributes in the system.* namespace as well.
- Fix a typo in a comment.
- Clarify a comment.

 fsdev/file-op-9p.h        |   6 +-
 fsdev/meson.build         |   2 +-
 hw/9pfs/9p-synth.c        |   2 +-
 hw/9pfs/9p-util-freebsd.c | 132 ++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h         |  20 ++++--
 hw/9pfs/9p.c              |  16 ++++-
 hw/9pfs/meson.build       |   2 +
 include/qemu/xattr.h      |   6 +-
 meson.build               |   8 +--
 9 files changed, 179 insertions(+), 15 deletions(-)
 create mode 100644 hw/9pfs/9p-util-freebsd.c

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b9dae8c84c..b85c9934de 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -21,9 +21,11 @@
 
 #ifdef CONFIG_LINUX
 # include <sys/vfs.h>
-#endif
-#ifdef CONFIG_DARWIN
+#elif defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
 # include <sys/param.h>
+# ifdef CONFIG_FREEBSD
+#  undef MACHINE /* work around some unfortunate namespace pollution */
+# endif
 # include <sys/mount.h>
 #endif
 
diff --git a/fsdev/meson.build b/fsdev/meson.build
index c751d8cb62..95fe816604 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -5,6 +5,6 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
   '9p-marshal.c',
   'qemu-fsdev.c',
 ), if_false: files('qemu-fsdev-dummy.c'))
-if host_os in ['linux', 'darwin']
+if host_os in ['linux', 'darwin', 'freebsd']
   system_ss.add_all(fsdev_ss)
 endif
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 9cd1884224..b3743f6169 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -451,7 +451,7 @@ static int synth_statfs(FsContext *s, V9fsPath *fs_path,
     stbuf->f_bsize = 512;
     stbuf->f_blocks = 0;
     stbuf->f_files = synth_node_count;
-#ifndef CONFIG_DARWIN
+#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
     stbuf->f_namelen = NAME_MAX;
 #endif
     return 0;
diff --git a/hw/9pfs/9p-util-freebsd.c b/hw/9pfs/9p-util-freebsd.c
new file mode 100644
index 0000000000..9dd1d069f6
--- /dev/null
+++ b/hw/9pfs/9p-util-freebsd.c
@@ -0,0 +1,132 @@
+/*
+ * 9p utilities (FreeBSD Implementation)
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * Not so fast! You might want to read the 9p developer docs first:
+ * https://wiki.qemu.org/Documentation/9p
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/xattr.h"
+#include "9p-util.h"
+
+static int mangle_xattr_name(const char **namep)
+{
+    const char *name = *namep;
+
+    /*
+     * ZFS forbids attributes in starting with "user." or "system.".
+     */
+    if (strncmp(name, "system.", 7) == 0) {
+        *namep = name + 7;
+        return EXTATTR_NAMESPACE_SYSTEM;
+    }
+    if (strncmp(name, "user.", 5) == 0) {
+        *namep = name + 5;
+    }
+    return EXTATTR_NAMESPACE_USER;
+}
+
+ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
+{
+    int namespace;
+
+    namespace = mangle_xattr_name(&name);
+    return extattr_get_fd(fd, namespace, name, value, size);
+}
+
+ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                             void *value, size_t size)
+{
+    ssize_t ret;
+    int fd, namespace;
+
+    fd = openat_file(dirfd, filename,
+                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    namespace = mangle_xattr_name(&name);
+    ret = extattr_get_fd(fd, namespace, name, value, size);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size)
+{
+    ssize_t ret;
+    int fd;
+
+    fd = openat_file(dirfd, filename,
+                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = extattr_list_fd(fd, EXTATTR_NAMESPACE_USER, list, size);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name)
+{
+    int fd, namespace, ret;
+
+    fd = openat_file(dirfd, filename,
+                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    namespace = mangle_xattr_name(&name);
+    ret = extattr_delete_fd(fd, namespace, name);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                         void *value, size_t size, int flags)
+{
+    ssize_t ret;
+    int fd, namespace;
+
+    namespace = mangle_xattr_name(&name);
+    if (flags == (XATTR_CREATE | XATTR_REPLACE)) {
+        errno = EINVAL;
+        return -1;
+    }
+    fd = openat_file(dirfd, filename,
+                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    if (flags & (XATTR_CREATE | XATTR_REPLACE)) {
+        ret = extattr_get_fd(fd, namespace, name, NULL, 0);
+        if (ret == -1 && errno != ENOATTR) {
+            close_preserve_errno(fd);
+            return -1;
+        }
+        if (ret >= 0 && (flags & XATTR_CREATE)) {
+            errno = EEXIST;
+            close_preserve_errno(fd);
+            return -1;
+        }
+        if (ret == -1 && (flags & XATTR_REPLACE)) {
+            errno = ENOATTR;
+            close_preserve_errno(fd);
+            return -1;
+        }
+    }
+    ret = extattr_set_fd(fd, namespace, name, value, size);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
+{
+    return mknodat(dirfd, filename, mode, dev);
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index a1924fe3f0..8dfa803dc2 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -21,6 +21,15 @@
 #define O_PATH_9P_UTIL 0
 #endif
 
+#ifdef CONFIG_FREEBSD
+/*
+ * FreeBSD does not have these flags, so we can only emulate their intended
+ * behaviour (racily).
+ */
+#define XATTR_CREATE    0x1
+#define XATTR_REPLACE   0x2
+#endif
+
 #if !defined(CONFIG_LINUX)
 
 /*
@@ -64,9 +73,9 @@ static inline uint64_t host_dev_to_dotl_dev(dev_t dev)
 static inline int errno_to_dotl(int err) {
 #if defined(CONFIG_LINUX)
     /* nothing to translate (Linux -> Linux) */
-#elif defined(CONFIG_DARWIN)
+#elif defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
     /*
-     * translation mandatory for macOS hosts
+     * translation mandatory for non-Linux hosts
      *
      * FIXME: Only most important errnos translated here yet, this should be
      * extended to as many errnos being translated as possible in future.
@@ -155,13 +164,13 @@ static inline int openat_file(int dirfd, const char *name, int flags,
 {
     int fd, serrno, ret;
 
-#ifndef CONFIG_DARWIN
+#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
 again:
 #endif
     fd = qemu_openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
                      mode);
     if (fd == -1) {
-#ifndef CONFIG_DARWIN
+#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
         if (errno == EPERM && (flags & O_NOATIME)) {
             /*
              * The client passed O_NOATIME but we lack permissions to honor it.
@@ -202,6 +211,9 @@ again:
     return fd;
 }
 
+#ifdef CONFIG_FREEBSD
+ssize_t fgetxattr(int dirfd, const char *name, void *value, size_t size);
+#endif
 ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
                              void *value, size_t size);
 int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index acfa7db4e1..bc4a016ee3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -136,8 +136,10 @@ static int dotl_to_open_flags(int flags)
         { P9_DOTL_NONBLOCK, O_NONBLOCK } ,
         { P9_DOTL_DSYNC, O_DSYNC },
         { P9_DOTL_FASYNC, FASYNC },
-#ifndef CONFIG_DARWIN
+#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
         { P9_DOTL_NOATIME, O_NOATIME },
+#endif
+#ifndef CONFIG_DARWIN
         /*
          *  On Darwin, we could map to F_NOCACHE, which is
          *  similar, but doesn't quite have the same
@@ -3658,7 +3660,7 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
     f_bavail = stbuf->f_bavail / bsize_factor;
     f_files  = stbuf->f_files;
     f_ffree  = stbuf->f_ffree;
-#ifdef CONFIG_DARWIN
+#if defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
     fsid_val = (unsigned int)stbuf->f_fsid.val[0] |
                (unsigned long long)stbuf->f_fsid.val[1] << 32;
     f_namelen = NAME_MAX;
@@ -4050,6 +4052,16 @@ out_nofid:
  * Linux guests.
  */
 #define P9_XATTR_SIZE_MAX 65536
+#elif defined(CONFIG_FREEBSD)
+/*
+ * FreeBSD similarly doesn't define a maximum xattr size, the limit is
+ * filesystem dependent.  On UFS filesystems it's 2 times the filesystem block
+ * size, typically 32KB.  On ZFS it depends on the value of the xattr property;
+ * with the default value there is no limit, and with xattr=sa it is 64KB.
+ *
+ * So, a limit of 64k seems reasonable here too.
+ */
+#define P9_XATTR_SIZE_MAX 65536
 #else
 #error Missing definition for P9_XATTR_SIZE_MAX for this host system
 #endif
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index d35d4f44ff..7f4d6e3a45 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -15,6 +15,8 @@ fs_ss.add(files(
 ))
 if host_os == 'darwin'
   fs_ss.add(files('9p-util-darwin.c'))
+elif host_os == 'freebsd'
+  fs_ss.add(files('9p-util-freebsd.c'))
 elif host_os == 'linux'
   fs_ss.add(files('9p-util-linux.c'))
 endif
diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
index b08a934acc..224ba1276e 100644
--- a/include/qemu/xattr.h
+++ b/include/qemu/xattr.h
@@ -26,7 +26,11 @@
 #    define ENOATTR ENODATA
 #  endif
 #  ifndef CONFIG_WIN32
-#    include <sys/xattr.h>
+#    ifdef CONFIG_FREEBSD
+#      include <sys/extattr.h>
+#    else
+#      include <sys/xattr.h>
+#    endif
 #  endif
 #endif
 
diff --git a/meson.build b/meson.build
index c2bc3eeedc..4c681bd2e8 100644
--- a/meson.build
+++ b/meson.build
@@ -2382,11 +2382,11 @@ dbus_display = get_option('dbus_display') \
   .allowed()
 
 have_virtfs = get_option('virtfs') \
-    .require(host_os == 'linux' or host_os == 'darwin',
-             error_message: 'virtio-9p (virtfs) requires Linux or macOS') \
-    .require(host_os == 'linux' or cc.has_function('pthread_fchdir_np'),
+    .require(host_os == 'linux' or host_os == 'darwin' or host_os == 'freebsd',
+             error_message: 'virtio-9p (virtfs) requires Linux or macOS or FreeBSD') \
+    .require(host_os != 'darwin' or cc.has_function('pthread_fchdir_np'),
              error_message: 'virtio-9p (virtfs) on macOS requires the presence of pthread_fchdir_np') \
-    .require(host_os == 'darwin' or libattr.found(),
+    .require(host_os != 'linux' or libattr.found(),
              error_message: 'virtio-9p (virtfs) on Linux requires libattr-devel') \
     .disable_auto_if(not have_tools and not have_system) \
     .allowed()
-- 
2.49.0


