Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C15C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWP-0004B0-LS; Wed, 29 Jan 2025 11:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVM-0003Ga-Sb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVC-0005DO-3Q
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EC00210F3;
 Wed, 29 Jan 2025 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyV7dYf16wY9+0dNIGehX+OaiO8HFmow5RlsO9XkqVw=;
 b=wTI/YfK5ybH3jTfGA7XWfS/sYQuZhvgvvlluUNR4vTr90qQcZHeHL5sIjJtYi7CHm8N/D5
 DPVPHzzhratBbygKl4vQNwVg5CPVo+rha3oqedt1ZM0ycyFyeBgB7M734UKiowRwYGeNWL
 swG/MxoOb7fXT2UUabaOi/Pfk4jyBlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyV7dYf16wY9+0dNIGehX+OaiO8HFmow5RlsO9XkqVw=;
 b=i3qm//H7EBWlEBUxyf5zyZyfXSO68IKqzB0PfhgMegTpSFJeklAFuqnRZ/18FCyIweG55v
 CJrmFsrMw9JBvSAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DMzhj4Hd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/6rmrmiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyV7dYf16wY9+0dNIGehX+OaiO8HFmow5RlsO9XkqVw=;
 b=DMzhj4Hdkzw0Z8+au1hlsPrn1qfTs7XXUTisbzqKhVCbjE9owCMKzf5iqPRBYDtIoN0w2A
 mG/hZ93mAHWq0iwTehKa6zBHQIfAecvbNql5vdMv3DOw6xW2uZ07lvk2zu7sa9m3cyOzRi
 9YGJQieETx62ivDW/Via3xrNTNT16Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyV7dYf16wY9+0dNIGehX+OaiO8HFmow5RlsO9XkqVw=;
 b=/6rmrmiqnQoNZ0HjqksEMWcTL+ZEC8o/N9bas4OF2dt0mEWkeZLiZ4fKAteHyban21lDnR
 ofc2TQ06Yws7aUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE50613AA6;
 Wed, 29 Jan 2025 16:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SKAFK8dQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 02/42] backends/hostmem-shm: factor out allocation of
 "anonymous shared memory with an fd"
Date: Wed, 29 Jan 2025 13:00:19 -0300
Message-Id: <20250129160059.6987-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EC00210F3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,oracle.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Let's factor it out so we can reuse it.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-2-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 backends/hostmem-shm.c | 45 ++++--------------------------------
 include/qemu/osdep.h   |  1 +
 meson.build            |  8 +++++--
 util/oslib-posix.c     | 52 ++++++++++++++++++++++++++++++++++++++++++
 util/oslib-win32.c     |  6 +++++
 5 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 5551ba78a6..fabee41f2c 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -25,11 +25,9 @@ struct HostMemoryBackendShm {
 static bool
 shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
-    g_autoptr(GString) shm_name = g_string_new(NULL);
     g_autofree char *backend_name = NULL;
     uint32_t ram_flags;
-    int fd, oflag;
-    mode_t mode;
+    int fd;
 
     if (!backend->size) {
         error_setg(errp, "can't create shm backend with size 0");
@@ -41,48 +39,13 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
 
-    /*
-     * Let's use `mode = 0` because we don't want other processes to open our
-     * memory unless we share the file descriptor with them.
-     */
-    mode = 0;
-    oflag = O_RDWR | O_CREAT | O_EXCL;
-    backend_name = host_memory_backend_get_name(backend);
-
-    /*
-     * Some operating systems allow creating anonymous POSIX shared memory
-     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
-     * defined by POSIX, so let's create a unique name.
-     *
-     * From Linux's shm_open(3) man-page:
-     *   For  portable  use,  a shared  memory  object should be identified
-     *   by a name of the form /somename;"
-     */
-    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
-                    backend_name);
-
-    fd = shm_open(shm_name->str, oflag, mode);
+    fd = qemu_shm_alloc(backend->size, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno,
-                         "failed to create POSIX shared memory");
-        return false;
-    }
-
-    /*
-     * We have the file descriptor, so we no longer need to expose the
-     * POSIX shared memory object. However it will remain allocated as long as
-     * there are file descriptors pointing to it.
-     */
-    shm_unlink(shm_name->str);
-
-    if (ftruncate(fd, backend->size) == -1) {
-        error_setg_errno(errp, errno,
-                         "failed to resize POSIX shared memory to %" PRIu64,
-                         backend->size);
-        close(fd);
         return false;
     }
 
+    /* Let's do the same as memory-backend-ram,share=on would do. */
+    backend_name = host_memory_backend_get_name(backend);
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
 
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index b94fb5fab8..112ebdff21 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -509,6 +509,7 @@ int qemu_daemon(int nochdir, int noclose);
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared,
                           bool noreserve);
 void qemu_anon_ram_free(void *ptr, size_t size);
+int qemu_shm_alloc(size_t size, Error **errp);
 
 #ifdef _WIN32
 #define HAVE_CHARDEV_SERIAL 1
diff --git a/meson.build b/meson.build
index 15a066043b..2c9ac9cfe1 100644
--- a/meson.build
+++ b/meson.build
@@ -3696,9 +3696,13 @@ libqemuutil = static_library('qemuutil',
                              build_by_default: false,
                              sources: util_ss.sources() + stub_ss.sources() + genh,
                              dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc])
+qemuutil_deps = [event_loop_base]
+if host_os != 'windows'
+  qemuutil_deps += [rt]
+endif
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res,
-                              dependencies: [event_loop_base])
+                              dependencies: qemuutil_deps)
 
 if have_system or have_user
   decodetree = generator(find_program('scripts/decodetree.py'),
@@ -4357,7 +4361,7 @@ if have_tools
   subdir('contrib/elf2dmp')
 
   executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
-             dependencies: qemuutil,
+             dependencies: [qemuutil, rt],
              install: true)
 
   if have_vhost_user
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7a542cb50b..2bb34dade3 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -931,3 +931,55 @@ void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
         qemu_close_all_open_fd_fallback(skip, nskip, open_max);
     }
 }
+
+int qemu_shm_alloc(size_t size, Error **errp)
+{
+    g_autoptr(GString) shm_name = g_string_new(NULL);
+    int fd, oflag, cur_sequence;
+    static int sequence;
+    mode_t mode;
+
+    cur_sequence = qatomic_fetch_inc(&sequence);
+
+    /*
+     * Let's use `mode = 0` because we don't want other processes to open our
+     * memory unless we share the file descriptor with them.
+     */
+    mode = 0;
+    oflag = O_RDWR | O_CREAT | O_EXCL;
+
+    /*
+     * Some operating systems allow creating anonymous POSIX shared memory
+     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
+     * defined by POSIX, so let's create a unique name.
+     *
+     * From Linux's shm_open(3) man-page:
+     *   For  portable  use,  a shared  memory  object should be identified
+     *   by a name of the form /somename;"
+     */
+    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%d", getpid(),
+                    cur_sequence);
+
+    fd = shm_open(shm_name->str, oflag, mode);
+    if (fd < 0) {
+        error_setg_errno(errp, errno,
+                         "failed to create POSIX shared memory");
+        return -1;
+    }
+
+    /*
+     * We have the file descriptor, so we no longer need to expose the
+     * POSIX shared memory object. However it will remain allocated as long as
+     * there are file descriptors pointing to it.
+     */
+    shm_unlink(shm_name->str);
+
+    if (ftruncate(fd, size) == -1) {
+        error_setg_errno(errp, errno,
+                         "failed to resize POSIX shared memory to %zu", size);
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b623830d62..b7351634ec 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -877,3 +877,9 @@ void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp)
     }
     CloseHandle(h);
 }
+
+int qemu_shm_alloc(size_t size, Error **errp)
+{
+    error_setg(errp, "Shared memory is not supported.");
+    return -1;
+}
-- 
2.35.3


