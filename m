Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE83FDEE39
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG4ct-0004TK-El; Thu, 23 Apr 2026 20:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wG1jl-0002Zb-O6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:37:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wG1jj-00017U-6d
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:37:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891c569cb1so7275175e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776980246; x=1777585046; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uA+3oshFCqGtJFNZ2+y4Ee11ofsxVMEKZKGagbGyBPI=;
 b=h7QPoEsFz+c550CVT9mFvjMSK8viWS6jD1E+VaX17WgYxwJJTYPx5H/f9xOWKSrEi3
 0Fv5tEekXtRaCww8G8vOVSSjYyjzMc2u7Nep2DC+SIE5QX2crpZYJwjYtzicz4rJng+N
 ZywE+1Q6C3oPAjl4h2imZGQ9YJlMHG2C8skR33vKSvnULC5EMnUp56neqDxCMUeybm0d
 jiydv3g3HBhR9b5fLqTKEG+yDvXZKKf0X/MR/+e6escq4NtjPECiaqXpEjxCSMC6C1Ps
 614iz5KsoKXx6SoNjfkSncz+4hF/RFrfulS6P9ybpJoyQQXCkAZlw6XE7+lOZduCrd5x
 rOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980246; x=1777585046;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uA+3oshFCqGtJFNZ2+y4Ee11ofsxVMEKZKGagbGyBPI=;
 b=eIDby3b9Na6o+8djwW4sLDEtK/N9CKSnURdL9lpfiViydOe0vGeJ7WiEGceeLVQmit
 dOxjHXE+ybvfJPRlGUiaAWyjcWfq6HGpOY3hO85Bh7TQDTtWLHb5hfYRX3sKzI0Pc4t8
 5PQQK3n9vW0iiFIy906SYoXL6zypQeZE4pNOJ1uldc+zDsgGjSUb6L63rLo0HCu1wdpB
 hTuehaqjmSNvXn5jjOsjLnMCiFXXFaeL3iepDM2vrPKTIdte2KYSiC0Y9CncktZrzQrM
 gz/nsC68AzE1MM4/2SE1CEvb7Fll9qcAgm22uIG4JC3KZ0VMXHQvakn1FiRLi7+1q3hW
 gRJQ==
X-Gm-Message-State: AOJu0YwGhrEsnA/uktpQ4R1iJ2mzlU3C+j1IkTezkFK73f1LIiPFN/N1
 gVGxw9zlIrg/DfuvB2jdszi1b0S2moHvkzx/m/hk+X6oxPukEiuJG3ZCDKZBZGMD
X-Gm-Gg: AeBDievndWLorc8/6XhkmY5xxa8lVO8VER13NXi4rej92CLB546xc6xkbgTkWKn3gXw
 VQnqeY8wYZmVOmPuKs6NkyX4RpXY3QDZXR7n0Tp0jfAzNrNJpZdMN/8Ruq8JNrcGc00R2Ope5K0
 gDCL6qCqIxy8S7QGgvmWpx0gVwsE0KloCxCt/bpkERkLxtjsaQenx2sMO7cI8W1JtD+7dDgYwHD
 eyT3fEOIsmmYiPi7yIoSmtivXe+KPzOI9BmA6MN2DjsZBLS1OIYnI1N6dk5GsEuKaeS9IiMWUVy
 /+ZPFA6YMaUIv/IWWx6pisyptCW3qBWADLAXuJuqDDs4AmAh09Mm/We67X3xRH5e5loN2ynKcRU
 po6bwOzzWYjBPz2l3JEeG79jMdpkRXOy8GunOqzUCIQj6GhPZXWNNa2bdcBP0ezTBW0g4c1RBTk
 saYagmwfhiS/yvAoBsx8KfGa4hzg2oXg/V1GLLlfGmUQ==
X-Received: by 2002:a05:600c:1f82:b0:48a:5546:619e with SMTP id
 5b1f17b1804b1-48a55466251mr92148725e9.4.1776980245251; 
 Thu, 23 Apr 2026 14:37:25 -0700 (PDT)
Received: from [10.94.10.196] ([223.123.19.204])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48919f54572sm138755225e9.26.2026.04.23.14.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 14:37:24 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Date: Fri, 24 Apr 2026 02:36:38 +0500
Subject: [PATCH v2 1/3] linux-user: Filter /proc/*/task/ to hide
 QEMU-internal threads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-master-v2-1-8b50b5c063ed@gmail.com>
References: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
In-Reply-To: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ali Raza <elirazamumtaz@gmail.com>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Apr 2026 20:42:33 -0400
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

When a guest process reads /proc/<pid>/task/ via getdents/getdents64,
the host kernel returns directory entries for all host threads in the
process, including QEMU-internal threads (RCU, TCG workers) that have
no guest CPUState.  This causes problems for guest libraries like
libcap's PSX that enumerate threads via /proc/self/task/ and send
signals to each one -- signals sent to QEMU-internal threads are never
handled, leading to deadlocks.

Add filtering to do_getdents() and do_getdents64() that detects when
the fd refers to a /proc/<pid>/task/ directory and skips entries whose
TID does not belong to a guest thread.  Guest thread TIDs are
identified by iterating the CPU list via CPU_FOREACH(), matching the
existing pattern used for /proc/self/stat num_threads.

This fixes the psx_test hang reported in containers using QEMU
user-mode emulation for cross-architecture builds.

Resolves: https://github.com/AndrewGMorgan/libcap_mirror/issues/6
Signed-off-by: Ali Raza (@locus-x64)

---
Changes in v2:
- Use pid_t instead of long for the parsed tid in do_getdents() and
  do_getdents64() (suggested by Helge Deller).
- Replace the ad-hoc readlink-at-getdents check with fd_trans-based
  tagging at open time, eliminating a TOCTOU race and a broad-prefix
  match that also matched /proc/<pid>/task/<tid>/fd.
- Retry sys_getdents when an entire host batch is filtered out, so
  the guest does not see a false EOF.
- Parse the dirent TID with qemu_strtoi() instead of strtol() so
  out-of-range values cannot wrap silently into pid_t.
---
 linux-user/fd-trans.c |   6 +
 linux-user/fd-trans.h |  18 +++
 linux-user/syscall.c  | 298 +++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 244 insertions(+), 78 deletions(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 64dd0745d2..6bad892b78 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -1881,3 +1881,9 @@ static abi_long host_to_target_data_inotify(void *buf, size_t len)
 TargetFdTrans target_inotify_trans = {
     .host_to_target_data = host_to_target_data_inotify,
 };
+
+/*
+ * No callbacks: this trans entry is purely a marker to identify fds
+ * that refer to our own /proc/<pid>/task directory.  See getdents().
+ */
+TargetFdTrans target_proc_pid_task_trans;
diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
index 3bbc15fa1f..76b8c35374 100644
--- a/linux-user/fd-trans.h
+++ b/linux-user/fd-trans.h
@@ -142,4 +142,22 @@ extern TargetFdTrans target_signalfd_trans;
 extern TargetFdTrans target_eventfd_trans;
 extern TargetFdTrans target_timerfd_trans;
 extern TargetFdTrans target_inotify_trans;
+
+/*
+ * Marker (no callbacks) used to tag fds that refer to /proc/<pid>/task
+ * for our own process.  Used by getdents to filter out QEMU-internal
+ * host threads (RCU, TCG workers) that have no guest CPUState.
+ */
+extern TargetFdTrans target_proc_pid_task_trans;
+
+static inline bool fd_trans_is_proc_pid_task(int fd)
+{
+    if (fd < 0) {
+        return false;
+    }
+
+    QEMU_LOCK_GUARD(&target_fd_trans_lock);
+    return fd < target_fd_max
+           && target_fd_trans[fd] == &target_proc_pid_task_trans;
+}
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4b74ad350..44f2cd851f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8870,6 +8870,7 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
     }
 
     fd_trans_unregister(ret);
+    maybe_tag_proc_pid_task(ret);
     unlock_user(pathname, guest_pathname, 0);
     return ret;
 }
@@ -9108,6 +9109,58 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
     return 0;
 }
 
+/*
+ * If the freshly-opened host fd refers to our own /proc/<pid>/task
+ * directory, register a marker on it via fd_trans so getdents() can
+ * later filter out QEMU-internal host threads (RCU, TCG workers) that
+ * have no guest CPUState.  Tagging at open time (rather than at
+ * getdents time) avoids TOCTOU on the fd's resolved path and lets us
+ * piggy-back on the existing fd_trans infrastructure for dup/close.
+ */
+static void maybe_tag_proc_pid_task(int fd)
+{
+    char link_path[64];
+    char link_target[PATH_MAX];
+    char expected[64];
+    ssize_t len;
+    int expected_len;
+
+    if (fd < 0) {
+        return;
+    }
+
+    snprintf(link_path, sizeof(link_path), "/proc/self/fd/%d", fd);
+    len = readlink(link_path, link_target, sizeof(link_target) - 1);
+    if (len < 0) {
+        return;
+    }
+    link_target[len] = '\0';
+
+    expected_len = snprintf(expected, sizeof(expected),
+                            "/proc/%d/task", getpid());
+    if (expected_len > 0 && (ssize_t)expected_len == len
+        && memcmp(link_target, expected, expected_len) == 0) {
+        fd_trans_register(fd, &target_proc_pid_task_trans);
+    }
+}
+
+/*
+ * Check if a given host TID belongs to a guest thread by looking it up
+ * in the CPU list.  Must be called under RCU read lock.
+ */
+static bool is_guest_tid(pid_t tid)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        TaskState *ts = get_task_state(cpu);
+        if (ts->ts_tid == tid) {
+            return true;
+        }
+    }
+    return false;
+}
+
 #ifdef TARGET_NR_getdents
 static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
 {
@@ -9116,78 +9169,123 @@ static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
     int hlen, hoff, toff;
     int hreclen, treclen;
     off_t prev_diroff = 0;
+    bool filter_task = fd_trans_is_proc_pid_task(dirfd);
+    bool stop = false;
 
     hdirp = g_try_malloc(count);
     if (!hdirp) {
         return -TARGET_ENOMEM;
     }
 
-#ifdef EMULATE_GETDENTS_WITH_GETDENTS
-    hlen = sys_getdents(dirfd, hdirp, count);
-#else
-    hlen = sys_getdents64(dirfd, hdirp, count);
-#endif
-
-    hlen = get_errno(hlen);
-    if (is_error(hlen)) {
-        return hlen;
-    }
-
     tdirp = lock_user(VERIFY_WRITE, arg2, count, 0);
     if (!tdirp) {
         return -TARGET_EFAULT;
     }
 
-    for (hoff = toff = 0; hoff < hlen; hoff += hreclen, toff += treclen) {
+    toff = 0;
+    /*
+     * Loop until we either produce a visible target entry, hit a
+     * real EOF (host returns 0), or hit an error.  Without this
+     * retry, a host batch consisting entirely of filtered entries
+     * would be reported to the guest as EOF.
+     */
+    while (!stop) {
 #ifdef EMULATE_GETDENTS_WITH_GETDENTS
-        struct linux_dirent *hde = hdirp + hoff;
+        hlen = sys_getdents(dirfd, hdirp, count);
 #else
-        struct linux_dirent64 *hde = hdirp + hoff;
+        hlen = sys_getdents64(dirfd, hdirp, count);
 #endif
-        struct target_dirent *tde = tdirp + toff;
-        int namelen;
-        uint8_t type;
+        hlen = get_errno(hlen);
+        if (is_error(hlen)) {
+            unlock_user(tdirp, arg2, 0);
+            return hlen;
+        }
+        if (hlen == 0) {
+            break; /* real EOF */
+        }
 
-        namelen = strlen(hde->d_name);
-        hreclen = hde->d_reclen;
-        treclen = offsetof(struct target_dirent, d_name) + namelen + 2;
-        treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent));
+        for (hoff = 0; hoff < hlen; hoff += hreclen, toff += treclen) {
+#ifdef EMULATE_GETDENTS_WITH_GETDENTS
+            struct linux_dirent *hde = hdirp + hoff;
+#else
+            struct linux_dirent64 *hde = hdirp + hoff;
+#endif
+            struct target_dirent *tde = tdirp + toff;
+            int namelen;
+            uint8_t type;
+
+            namelen = strlen(hde->d_name);
+            hreclen = hde->d_reclen;
 
-        if (toff + treclen > count) {
             /*
-             * If the host struct is smaller than the target struct, or
-             * requires less alignment and thus packs into less space,
-             * then the host can return more entries than we can pass
-             * on to the guest.
+             * Filter /proc/<pid>/task/ listings to hide QEMU-internal
+             * host threads (RCU, TCG) that have no guest CPUState.
              */
-            if (toff == 0) {
-                toff = -TARGET_EINVAL; /* result buffer is too small */
+            if (filter_task) {
+                int tid_int;
+                if (qemu_strtoi(hde->d_name, NULL, 10, &tid_int) == 0
+                    && tid_int > 0) {
+                    pid_t tid = (pid_t)tid_int;
+                    bool drop;
+
+                    WITH_RCU_READ_LOCK_GUARD() {
+                        drop = !is_guest_tid(tid);
+                    }
+                    if (drop) {
+                        treclen = 0;
+                        continue;
+                    }
+                }
+            }
+            treclen = offsetof(struct target_dirent, d_name) + namelen + 2;
+            treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent));
+
+            if (toff + treclen > count) {
+                /*
+                 * If the host struct is smaller than the target struct, or
+                 * requires less alignment and thus packs into less space,
+                 * then the host can return more entries than we can pass
+                 * on to the guest.
+                 */
+                if (toff == 0) {
+                    toff = -TARGET_EINVAL; /* result buffer is too small */
+                    stop = true;
+                    break;
+                }
+                /*
+                 * Return what we have, resetting the file pointer to the
+                 * location of the first record not returned.
+                 */
+                lseek(dirfd, prev_diroff, SEEK_SET);
+                stop = true;
                 break;
             }
+
+            prev_diroff = hde->d_off;
+            tde->d_ino = tswapal(hde->d_ino);
+            tde->d_off = tswapal(hde->d_off);
+            tde->d_reclen = tswap16(treclen);
+            memcpy(tde->d_name, hde->d_name, namelen + 1);
+
             /*
-             * Return what we have, resetting the file pointer to the
-             * location of the first record not returned.
+             * The getdents type is in what was formerly a padding byte at the
+             * end of the structure.
              */
-            lseek(dirfd, prev_diroff, SEEK_SET);
-            break;
+#ifdef EMULATE_GETDENTS_WITH_GETDENTS
+            type = *((uint8_t *)hde + hreclen - 1);
+#else
+            type = hde->d_type;
+#endif
+            *((uint8_t *)tde + treclen - 1) = type;
         }
 
-        prev_diroff = hde->d_off;
-        tde->d_ino = tswapal(hde->d_ino);
-        tde->d_off = tswapal(hde->d_off);
-        tde->d_reclen = tswap16(treclen);
-        memcpy(tde->d_name, hde->d_name, namelen + 1);
-
         /*
-         * The getdents type is in what was formerly a padding byte at the
-         * end of the structure.
+         * If we produced any visible target entry, return; otherwise
+         * loop again to fetch more host entries (avoid false EOF).
          */
-#ifdef EMULATE_GETDENTS_WITH_GETDENTS
-        type = *((uint8_t *)hde + hreclen - 1);
-#else
-        type = hde->d_type;
-#endif
-        *((uint8_t *)tde + treclen - 1) = type;
+        if (toff != 0) {
+            break;
+        }
     }
 
     unlock_user(tdirp, arg2, toff);
@@ -9203,57 +9301,99 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
     int hlen, hoff, toff;
     int hreclen, treclen;
     off_t prev_diroff = 0;
+    bool filter_task = fd_trans_is_proc_pid_task(dirfd);
+    bool stop = false;
 
     hdirp = g_try_malloc(count);
     if (!hdirp) {
         return -TARGET_ENOMEM;
     }
 
-    hlen = get_errno(sys_getdents64(dirfd, hdirp, count));
-    if (is_error(hlen)) {
-        return hlen;
-    }
-
     tdirp = lock_user(VERIFY_WRITE, arg2, count, 0);
     if (!tdirp) {
         return -TARGET_EFAULT;
     }
 
-    for (hoff = toff = 0; hoff < hlen; hoff += hreclen, toff += treclen) {
-        struct linux_dirent64 *hde = hdirp + hoff;
-        struct target_dirent64 *tde = tdirp + toff;
-        int namelen;
+    toff = 0;
+    /*
+     * Loop until we either produce a visible target entry, hit a
+     * real EOF (host returns 0), or hit an error.  Without this
+     * retry, a host batch consisting entirely of filtered entries
+     * would be reported to the guest as EOF.
+     */
+    while (!stop) {
+        hlen = get_errno(sys_getdents64(dirfd, hdirp, count));
+        if (is_error(hlen)) {
+            unlock_user(tdirp, arg2, 0);
+            return hlen;
+        }
+        if (hlen == 0) {
+            break; /* real EOF */
+        }
+
+        for (hoff = 0; hoff < hlen; hoff += hreclen, toff += treclen) {
+            struct linux_dirent64 *hde = hdirp + hoff;
+            struct target_dirent64 *tde = tdirp + toff;
+            int namelen;
 
-        namelen = strlen(hde->d_name) + 1;
-        hreclen = hde->d_reclen;
-        treclen = offsetof(struct target_dirent64, d_name) + namelen;
-        treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent64));
+            namelen = strlen(hde->d_name) + 1;
+            hreclen = hde->d_reclen;
 
-        if (toff + treclen > count) {
             /*
-             * If the host struct is smaller than the target struct, or
-             * requires less alignment and thus packs into less space,
-             * then the host can return more entries than we can pass
-             * on to the guest.
+             * Filter /proc/<pid>/task/ listings to hide QEMU-internal
+             * host threads (RCU, TCG) that have no guest CPUState.
              */
-            if (toff == 0) {
-                toff = -TARGET_EINVAL; /* result buffer is too small */
+            if (filter_task) {
+                int tid_int;
+                if (qemu_strtoi(hde->d_name, NULL, 10, &tid_int) == 0
+                    && tid_int > 0) {
+                    pid_t tid = (pid_t)tid_int;
+                    bool drop;
+
+                    WITH_RCU_READ_LOCK_GUARD() {
+                        drop = !is_guest_tid(tid);
+                    }
+                    if (drop) {
+                        treclen = 0;
+                        continue;
+                    }
+                }
+            }
+            treclen = offsetof(struct target_dirent64, d_name) + namelen;
+            treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent64));
+
+            if (toff + treclen > count) {
+                /*
+                 * If the host struct is smaller than the target struct, or
+                 * requires less alignment and thus packs into less space,
+                 * then the host can return more entries than we can pass
+                 * on to the guest.
+                 */
+                if (toff == 0) {
+                    toff = -TARGET_EINVAL; /* result buffer is too small */
+                    stop = true;
+                    break;
+                }
+                /*
+                 * Return what we have, resetting the file pointer to the
+                 * location of the first record not returned.
+                 */
+                lseek(dirfd, prev_diroff, SEEK_SET);
+                stop = true;
                 break;
             }
-            /*
-             * Return what we have, resetting the file pointer to the
-             * location of the first record not returned.
-             */
-            lseek(dirfd, prev_diroff, SEEK_SET);
-            break;
+
+            prev_diroff = hde->d_off;
+            tde->d_ino = tswap64(hde->d_ino);
+            tde->d_off = tswap64(hde->d_off);
+            tde->d_reclen = tswap16(treclen);
+            tde->d_type = hde->d_type;
+            memcpy(tde->d_name, hde->d_name, namelen);
         }
 
-        prev_diroff = hde->d_off;
-        tde->d_ino = tswap64(hde->d_ino);
-        tde->d_off = tswap64(hde->d_off);
-        tde->d_reclen = tswap16(treclen);
-        tde->d_type = hde->d_type;
-        memcpy(tde->d_name, hde->d_name, namelen);
+        if (toff != 0) {
+            break;
+        }
     }
 
     unlock_user(tdirp, arg2, toff);
@@ -9732,6 +9872,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                                   target_to_host_bitmask(arg2, fcntl_flags_tbl),
                                   arg3, true));
         fd_trans_unregister(ret);
+        maybe_tag_proc_pid_task(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
@@ -9742,6 +9883,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                                   target_to_host_bitmask(arg3, fcntl_flags_tbl),
                                   arg4, true));
         fd_trans_unregister(ret);
+        maybe_tag_proc_pid_task(ret);
         unlock_user(p, arg2, 0);
         return ret;
     case TARGET_NR_openat2:

-- 
2.43.0


