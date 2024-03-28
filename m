Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CA0C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqPE-0004MV-9q; Thu, 28 Mar 2024 10:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpqPC-0004J4-Rr
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpqP9-0004Pc-Il
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711634814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HmnkEi4Xrv5p3rnmEdYqUcU4Qbghf77Z/RDogMW1HU=;
 b=Tkijz9RJ6an725z47mNJ76PEGfaWV9XpQBx6IdXLnqCNFJuMZh76idkK9+KIShZuQQKLIK
 oAT8e7k4Esb6qzJ1jcdWmxw8GOxIHwmgBKEE0LFAAIw1Nssc7DquCtVcRSmp4XV205BZPy
 QhOO37IHUAbj6XNLC0O0HzcznvkAf9g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-PVql2vj0ODqwHMZSz62Vxg-1; Thu,
 28 Mar 2024 10:06:51 -0400
X-MC-Unique: PVql2vj0ODqwHMZSz62Vxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 865211C54068;
 Thu, 28 Mar 2024 14:06:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35AC440C6DB7;
 Thu, 28 Mar 2024 14:06:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH for-9.1 4/9] Bump minimum glib version to v2.66
Date: Thu, 28 Mar 2024 15:06:01 +0100
Message-ID: <20240328140607.2433889-5-thuth@redhat.com>
In-Reply-To: <20240328140607.2433889-1-thuth@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now that we dropped support for CentOS 8 and Ubuntu 20.04, we can
look into bumping the glib version to a new minimum for further
clean-ups. According to repology.org, available versions are:

 CentOS Stream 9:       2.66.7
 Debian 11:             2.66.8
 Fedora 38:             2.74.1
 Freebsd:               2.78.4
 Homebrew:              2.80.0
 Openbsd:               2.78.4
 OpenSuse leap 15.5:    2.70.5
 pkgsrc_current:        2.78.4
 Ubuntu 22.04:          2.72.1

Thus it should be safe to bump the minimum glib version to 2.66 now.
Version 2.66 comes with new functions for URI parsing which will
allow further clean-ups in the following patches.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build              | 16 +---------------
 include/glib-compat.h    | 27 ++-------------------------
 qga/commands-posix-ssh.c |  4 ++--
 3 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/meson.build b/meson.build
index c9c3217ba4..c0aaceffc0 100644
--- a/meson.build
+++ b/meson.build
@@ -865,7 +865,7 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
 
 # When bumping glib minimum version, please check also whether to increase
 # the _WIN32_WINNT setting in osdep.h according to the value from glib
-glib_req_ver = '>=2.56.0'
+glib_req_ver = '>=2.66.0'
 glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
                     method: 'pkg-config')
 glib_cflags = []
@@ -906,20 +906,6 @@ if not cc.compiles('''
         to the right pkg-config files for your build target.''')
 endif
 
-# Silence clang warnings triggered by glib < 2.57.2
-if not cc.compiles('''
-  #include <glib.h>
-  typedef struct Foo {
-    int i;
-  } Foo;
-  static void foo_free(Foo *f)
-  {
-    g_free(f);
-  }
-  G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
-  int main(void) { return 0; }''', dependencies: glib_pc, args: ['-Wunused-function', '-Werror'])
-  glib_cflags += cc.get_supported_arguments('-Wno-unused-function')
-endif
 glib = declare_dependency(dependencies: [glib_pc, gmodule],
                           compile_args: glib_cflags,
                           version: glib_pc.version())
diff --git a/include/glib-compat.h b/include/glib-compat.h
index 43a562974d..86be439ba0 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -19,12 +19,12 @@
 /* Ask for warnings for anything that was marked deprecated in
  * the defined version, or before. It is a candidate for rewrite.
  */
-#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_56
+#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_66
 
 /* Ask for warnings if code tries to use function that did not
  * exist in the defined version. These risk breaking builds
  */
-#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_56
+#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_66
 
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
@@ -105,29 +105,6 @@ static inline gpointer g_memdup2_qemu(gconstpointer mem, gsize byte_size)
 }
 #define g_memdup2(m, s) g_memdup2_qemu(m, s)
 
-#if defined(G_OS_UNIX)
-/*
- * Note: The fallback implementation is not MT-safe, and it returns a copy of
- * the libc passwd (must be g_free() after use) but not the content. Because of
- * these important differences the caller must be aware of, it's not #define for
- * GLib API substitution.
- */
-static inline struct passwd *
-g_unix_get_passwd_entry_qemu(const gchar *user_name, GError **error)
-{
-#if GLIB_CHECK_VERSION(2, 64, 0)
-    return g_unix_get_passwd_entry(user_name, error);
-#else
-    struct passwd *p = getpwnam(user_name);
-    if (!p) {
-        g_set_error_literal(error, G_UNIX_ERROR, 0, g_strerror(errno));
-        return NULL;
-    }
-    return (struct passwd *)g_memdup(p, sizeof(*p));
-#endif
-}
-#endif /* G_OS_UNIX */
-
 static inline bool
 qemu_g_test_slow(void)
 {
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 236f80de44..b0e0b1d674 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -35,7 +35,7 @@ test_get_passwd_entry(const gchar *user_name, GError **error)
     return p;
 }
 
-#define g_unix_get_passwd_entry_qemu(username, err) \
+#define g_unix_get_passwd_entry(username, err) \
    test_get_passwd_entry(username, err)
 #endif
 
@@ -45,7 +45,7 @@ get_passwd_entry(const char *username, Error **errp)
     g_autoptr(GError) err = NULL;
     struct passwd *p;
 
-    p = g_unix_get_passwd_entry_qemu(username, &err);
+    p = g_unix_get_passwd_entry(username, &err);
     if (p == NULL) {
         error_setg(errp, "failed to lookup user '%s': %s",
                    username, err->message);
-- 
2.44.0


