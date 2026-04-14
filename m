Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6547FA0C27
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 04:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCrXf-0006n6-6r; Wed, 15 Apr 2026 00:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wCnee-0008F7-P8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:58:52 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wCnec-0003X9-Nb
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:58:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43cf7258875so428958f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776211129; x=1776815929; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uqvJg/Mgtv6OwVCd/aP++X0wBdWO0zPsmqBCsAcI/WQ=;
 b=gn1QZLriw27dIV7VAxwziwGLAI9ZsKlQjYJV41tgm+W1/z0HWjH7OCHjn+99IFFeDc
 7VAd/y+UFfzPEyigEipnOiq6WwP30hA+rKUlGF2w8idE9iQSjXgX39woHt9M8ZCjS/uP
 Tcd4XUcehhSnUm3H2o+eZOqR2wQt/Jnmldyve5K6K0s2sQc5tH0QjzsEhajRSpozotNN
 HyrvlAmHtvb3ZultY3qfWIVRUuJ8ER1j4xoUr5rm4ri3C9TZhR33RxqDBWdZBbwFtsYv
 l7VlKcKl1rOHMPoZOldNGk31pZDzzx3TtdJ1FGdX63OO/qSIlIOUcSR7xUjMVf+MROXc
 Q6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776211129; x=1776815929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uqvJg/Mgtv6OwVCd/aP++X0wBdWO0zPsmqBCsAcI/WQ=;
 b=cinv0EBwJ4fho3yXLQqoi7N3/Dfsgslxe8tuvSV6LElXAfJ0xDTAbuuN7qxYZlTNRn
 LGj9Y/srj0QkAzuVF9BhO+zBDeyOUorgfWd8yLNRCW2z+1FWMzZYsxpRx+ajGt1f+bmu
 4ve4LOhh5eYTO8xNeHFs1E54kZFlPOVHIqpGHsYDw+ZBaa8Porsi5Rt4B0i2dnmfhkHQ
 HHol9AYwF9Uu3SL+13/7EOH8VjO5kQajVFXl2XfInV/cZ/TnUWlyVI7qDcGMk5/WadWB
 EOkP7XMCpoQpC4o2mzyLU2f5VOj7iI0bX17MeR6A3E13+5ch46Fi3AenPz+Ifd7i8yp1
 nSzg==
X-Gm-Message-State: AOJu0Yz9x0QWAN/eeAInJIo+YdhxyGffjTuY6RqZkPAua/mx2LCNsfHK
 rCrtRsJSiUyF4PtHFBVN7AA4Dda7Bnixp6ftCS0ilA1we1j83GUx92ua
X-Gm-Gg: AeBDieuDBXeaD40YjLmwKhP1rHJFyJwy/p/A1JmiT7vAV1s6NLlKpYYrq7Dgn7TSmf+
 rXKht0cRCzyHZeWXumYvvUTWCojbDLrUZtWTQ0knLsApXZwmWSx3wWckVc6EBu7Acf6nFoty1is
 IudD/rtFx6bBSv98orD3cOazzgtBjvPv27VyX4DlgjDj361iXvxn8QlMGMO89VLcZShOXiG23rx
 dYInE5QulZ8MlTaiUUdRHDCAP6SHYyOLFMpeLVWFv8g7TzauQSkzMhdPBwI8hIHIPt+fZXo/ovs
 fIIDpjOgpn/VpT0iu1QM2tcx/3Sl/QmAMbuJiUS5Gkqpn/H2Ra7BfJNFZBzJjjdELOkliTgxub/
 rk4Z0o3VSmvTlxxoXLFzVCRflQSYKJ+B6t4agRKsjeHAcP6mwxM4j3hClTgsdYe6SC9YuHdilJV
 xcZfZhvr1CkULf8Mv0RIBQlYGXTKsoIBQH
X-Received: by 2002:a05:6000:2109:b0:43d:74dc:7e9 with SMTP id
 ffacd0b85a97d-43eacfa1546mr117387f8f.1.1776211128977; 
 Tue, 14 Apr 2026 16:58:48 -0700 (PDT)
Received: from [192.168.10.11] ([182.181.137.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm115535f8f.18.2026.04.14.16.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 16:58:48 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Date: Wed, 15 Apr 2026 04:58:34 +0500
Subject: [PATCH 1/3] linux-user: Filter /proc/*/task/ to hide QEMU-internal
 threads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-master-v1-1-8dd2ef111eee@gmail.com>
References: <20260415-master-v1-0-8dd2ef111eee@gmail.com>
In-Reply-To: <20260415-master-v1-0-8dd2ef111eee@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ali Raza <elirazamumtaz@gmail.com>, morgan@kernel.org
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Apr 2026 00:07:54 -0400
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
 linux-user/syscall.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4b74ad350..b5a912dc22 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9108,6 +9108,50 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
     return 0;
 }
 
+/*
+ * Check if a directory fd refers to /proc/<pid>/task/ for the current
+ * process.  Used to filter out QEMU-internal host threads (RCU, TCG)
+ * that are not guest threads from directory listings.
+ */
+static bool is_proc_pid_task_dir(int dirfd)
+{
+    char link_path[64];
+    char link_target[PATH_MAX];
+    ssize_t len;
+    char expected[80];
+    int expected_len;
+
+    snprintf(link_path, sizeof(link_path), "/proc/self/fd/%d", dirfd);
+    len = readlink(link_path, link_target, sizeof(link_target) - 1);
+    if (len < 0) {
+        return false;
+    }
+    link_target[len] = '\0';
+
+    expected_len = snprintf(expected, sizeof(expected),
+                            "/proc/%d/task", getpid());
+    return strncmp(link_target, expected, expected_len) == 0
+           && (link_target[expected_len] == '\0'
+               || link_target[expected_len] == '/');
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
@@ -9116,6 +9160,7 @@ static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
     int hlen, hoff, toff;
     int hreclen, treclen;
     off_t prev_diroff = 0;
+    bool filter_task = is_proc_pid_task_dir(dirfd);
 
     hdirp = g_try_malloc(count);
     if (!hdirp) {
@@ -9150,6 +9195,23 @@ static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
 
         namelen = strlen(hde->d_name);
         hreclen = hde->d_reclen;
+
+        /*
+         * Filter /proc/<pid>/task/ listings to hide QEMU-internal
+         * host threads (RCU, TCG) that have no guest CPUState.
+         */
+        if (filter_task) {
+            char *endp;
+            long tid = strtol(hde->d_name, &endp, 10);
+            if (tid > 0 && *endp == '\0') {
+                WITH_RCU_READ_LOCK_GUARD() {
+                    if (!is_guest_tid(tid)) {
+                        treclen = 0;
+                        continue;
+                    }
+                }
+            }
+        }
         treclen = offsetof(struct target_dirent, d_name) + namelen + 2;
         treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent));
 
@@ -9203,6 +9265,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
     int hlen, hoff, toff;
     int hreclen, treclen;
     off_t prev_diroff = 0;
+    bool filter_task = is_proc_pid_task_dir(dirfd);
 
     hdirp = g_try_malloc(count);
     if (!hdirp) {
@@ -9226,6 +9289,23 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 
         namelen = strlen(hde->d_name) + 1;
         hreclen = hde->d_reclen;
+
+        /*
+         * Filter /proc/<pid>/task/ listings to hide QEMU-internal
+         * host threads (RCU, TCG) that have no guest CPUState.
+         */
+        if (filter_task) {
+            char *endp;
+            long tid = strtol(hde->d_name, &endp, 10);
+            if (tid > 0 && *endp == '\0') {
+                WITH_RCU_READ_LOCK_GUARD() {
+                    if (!is_guest_tid(tid)) {
+                        treclen = 0;
+                        continue;
+                    }
+                }
+            }
+        }
         treclen = offsetof(struct target_dirent64, d_name) + namelen;
         treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent64));
 

-- 
2.43.0


