Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EA9C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 04:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7oY2-0005jC-2R; Thu, 24 Apr 2025 00:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oY0-0005ix-Sy
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:52 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oXy-0003WL-MF
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:52 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-aee79a0f192so319538a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 21:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745470249; x=1746075049;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BdUG64MOtuB3ZvgnW7R6lB6dGxWNK/aX5ltv/O5QLQI=;
 b=bvMYW6k9fuYD+LRJ+21ha2SpKbAdoUs5s1t5HX6AY1tSu/K5wief9nMiglMxTOLtkk
 6eAxMFw7X65Ra1G4PYGM0qQ9TrXPbOcalJWfZIw46G9SWnkQRXuS0AsKdY6I1nGDnyxu
 As5XBzDJ7ZJGrecSHkeD+h2hgXaC//bVNECn6ITwOYlMnQ5tOgfgpK+9Nw/lMCpNEPX4
 pcM2RuynZYrdvNm2UYIaPzwRLjMHI7LtOMIB6TE6Y48RGra8P07zJCGYwz7OhhZtCdZI
 0tMu6fqqzklFoyaHqOwhy9m6PZx0JSZyvG9ZWiLeZE85b1P2h7ADHIbgA3vW1QRVWguW
 aMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745470249; x=1746075049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdUG64MOtuB3ZvgnW7R6lB6dGxWNK/aX5ltv/O5QLQI=;
 b=rtQR4nCHGtRCLtKTPaWXRnV+CmX7TR1WkVhRWazpcLHsrbH4pTEVzwQvCdXI8W0P+4
 KIVp2HwsOc9mJYVOSXAZUIXm1CCZ8zT9nCAI69bDvTm/3m8+XZwwCEeiGSnPXXoidoAn
 /41G/7iV8coUVbl/9QCt3NR/nt/K4d4ikb0GNX0cSyzKxKB0PIZOGGhQaMz8Jx6XFzV8
 Kx1l3mzemdHESpB+WSS05O15GxrxKpei0Feaffk6KW+MIWigp5WYEhcFGhH6+OZazywI
 qnaoR4Dc9Wru9aiaaSQQprRnCTODN9GlaNmCwy3iAPq9z18vNvL8oEfc02g45yT7MMS2
 aKmg==
X-Gm-Message-State: AOJu0Yz7j+oLoWzniKjgpVmOx2UrXnnI+wYPfnSjkesuFbSm099L0qNS
 uHWD1Y5jxwUQa9I8uJPTa0dzMyawkLEPkhaAfTKuQP09dBzXASNDsJQjeVW0A2g=
X-Gm-Gg: ASbGncsSgxSGvnq/JdAnTi8/rBIWRdCf1zs8z8HRbwWyjTXuU09/J3EeFOWi/LgfMMl
 rJQsS8F7kAN+Y6hj+MXW52AMwE0rSVgZHu8geqlJx8XAUPB+/hr2NVGysNJtEkgyTnaYN/vFVEh
 XjACQPKjCwBibX8CjXXxsGB97RQQa/0WMICJCWF2g3yUaRe7F8n6r8OJS81yjdT6MIDDbCTCsVc
 HUp/dwr7XCq1LFbRJ6QWs3Sm8homsk0GcEDANfsJT3fxVCDszUW02qRuX9IoKcg4ksMrs0czDDX
 syi3JQV93bU7CIyWcYM5T0o5h1mNNlspUhO4ZOmF6N8W
X-Google-Smtp-Source: AGHT+IGQgJxP8iP/9emUrbfAaCr4Qe23m4kx0MOoLUDx047YrzauNRxypZczGn65nlxBHs/Ql82XYg==
X-Received: by 2002:a05:6a20:9c8d:b0:1f5:6b36:f574 with SMTP id
 adf61e73a8af0-20444f45dddmr1795022637.38.1745470248768; 
 Wed, 23 Apr 2025 21:50:48 -0700 (PDT)
Received: from localhost ([157.82.205.213])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b15fadeb911sm350553a12.65.2025.04.23.21.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 21:50:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 24 Apr 2025 13:50:13 +0900
Subject: [PATCH 3/4] meson: Share common C source prefixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-buildsys-v1-3-97655e3b25d7@daynix.com>
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
In-Reply-To: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

gnu_source_prefix defines _GNU_SOURCE for compiler object functions.
The definition is universally available in the code base.

docs/devel/style.rst also says that the "qemu/osdep.h" header is
always included, so files included in the file is also universally
available in the code base.

Rename gnu_source_prefix to osdep_prefix, and add #include directives
that are referred by the users of gnu_source_prefix and contained in
qemu/osdep.h to safely de-duplicate #include directives.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 68 +++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/meson.build b/meson.build
index 1a02cd89903b..0a35fc3fa9fe 100644
--- a/meson.build
+++ b/meson.build
@@ -2185,10 +2185,21 @@ if not has_malloc_trim and get_option('malloc_trim').enabled()
   endif
 endif
 
-gnu_source_prefix = '''
+osdep_prefix = '''
   #ifndef _GNU_SOURCE
   #define _GNU_SOURCE
   #endif
+
+  #include <stddef.h>
+  #include <sys/types.h>
+
+  #include <limits.h>
+  /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
+   * function availability on recentish Mingw-w64 platforms. */
+  #include <unistd.h>
+  #include <time.h>
+  #include <errno.h>
+  #include <fcntl.h>
 '''
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
@@ -2703,7 +2714,7 @@ config_host_data.set('CONFIG_FIEMAP',
                      cc.has_header('linux/fiemap.h') and
                      cc.has_header_symbol('linux/fs.h', 'FS_IOC_FIEMAP'))
 config_host_data.set('CONFIG_GETCPU',
-                     cc.has_header_symbol('sched.h', 'getcpu', prefix: gnu_source_prefix))
+                     cc.has_header_symbol('sched.h', 'getcpu', prefix: osdep_prefix))
 config_host_data.set('CONFIG_GETRANDOM',
                      cc.has_function('getrandom') and
                      cc.has_header_symbol('sys/random.h', 'GRND_NONBLOCK'))
@@ -2748,8 +2759,7 @@ config_host_data.set('HAVE_UTMPX',
 config_host_data.set('CONFIG_EVENTFD', cc.links('''
   #include <sys/eventfd.h>
   int main(void) { return eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC); }'''))
-config_host_data.set('CONFIG_FDATASYNC', cc.links(gnu_source_prefix + '''
-  #include <unistd.h>
+config_host_data.set('CONFIG_FDATASYNC', cc.links(osdep_prefix + '''
   int main(void) {
   #if defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO > 0
   return fdatasync(0);
@@ -2758,10 +2768,8 @@ config_host_data.set('CONFIG_FDATASYNC', cc.links(gnu_source_prefix + '''
   #endif
   }'''))
 
-has_madvise = cc.links(gnu_source_prefix + '''
-  #include <sys/types.h>
+has_madvise = cc.links(osdep_prefix + '''
   #include <sys/mman.h>
-  #include <stddef.h>
   int main(void) { return madvise(NULL, 0, MADV_DONTNEED); }''')
 missing_madvise_proto = false
 if has_madvise
@@ -2771,21 +2779,18 @@ if has_madvise
   # missing-prototype case, we try again with a definitely-bogus prototype.
   # This will only compile if the system headers don't provide the prototype;
   # otherwise the conflicting prototypes will cause a compiler error.
-  missing_madvise_proto = cc.links(gnu_source_prefix + '''
-    #include <sys/types.h>
+  missing_madvise_proto = cc.links(osdep_prefix + '''>
     #include <sys/mman.h>
-    #include <stddef.h>
     extern int madvise(int);
     int main(void) { return madvise(0); }''')
 endif
 config_host_data.set('CONFIG_MADVISE', has_madvise)
 config_host_data.set('HAVE_MADVISE_WITHOUT_PROTOTYPE', missing_madvise_proto)
 
-config_host_data.set('CONFIG_MEMFD', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_MEMFD', cc.links(osdep_prefix + '''
   #include <sys/mman.h>
   int main(void) { return memfd_create("foo", MFD_ALLOW_SEALING); }'''))
-config_host_data.set('CONFIG_OPEN_BY_HANDLE', cc.links(gnu_source_prefix + '''
-  #include <fcntl.h>
+config_host_data.set('CONFIG_OPEN_BY_HANDLE', cc.links(osdep_prefix + '''
   #if !defined(AT_EMPTY_PATH)
   # error missing definition
   #else
@@ -2796,13 +2801,12 @@ config_host_data.set('CONFIG_OPEN_BY_HANDLE', cc.links(gnu_source_prefix + '''
 # i.e. errno is set and -1 is returned. That's not really how POSIX defines the
 # function. On the flip side, it has madvise() which is preferred anyways.
 if host_os != 'darwin'
-  config_host_data.set('CONFIG_POSIX_MADVISE', cc.links(gnu_source_prefix + '''
+  config_host_data.set('CONFIG_POSIX_MADVISE', cc.links(osdep_prefix + '''
     #include <sys/mman.h>
-    #include <stddef.h>
     int main(void) { return posix_madvise(NULL, 0, POSIX_MADV_DONTNEED); }'''))
 endif
 
-config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_W_TID', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_W_TID', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
   static void *f(void *p) { return NULL; }
@@ -2813,7 +2817,7 @@ config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_W_TID', cc.links(gnu_source_pref
     pthread_setname_np(thread, "QEMU");
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_WO_TID', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_WO_TID', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
   static void *f(void *p) { pthread_setname_np("QEMU"); return NULL; }
@@ -2823,7 +2827,7 @@ config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_WO_TID', cc.links(gnu_source_pre
     pthread_create(&thread, 0, f, 0);
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(osdep_prefix + '''
   #include <pthread.h>
   #include <pthread_np.h>
 
@@ -2835,9 +2839,8 @@ config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(gnu_source_prefix +
     pthread_set_name_np(thread, "QEMU");
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix + '''
   #include <pthread.h>
-  #include <time.h>
 
   int main(void)
   {
@@ -2846,7 +2849,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(gnu_source_pre
     pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_PTHREAD_AFFINITY_NP', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_PTHREAD_AFFINITY_NP', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
   static void *f(void *p) { return NULL; }
@@ -2863,15 +2866,10 @@ config_host_data.set('CONFIG_PTHREAD_AFFINITY_NP', cc.links(gnu_source_prefix +
     CPU_FREE(cpuset);
     return 0;
   }''', dependencies: threads))
-config_host_data.set('CONFIG_SIGNALFD', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_SIGNALFD', cc.links(osdep_prefix + '''
   #include <sys/signalfd.h>
-  #include <stddef.h>
   int main(void) { return signalfd(-1, NULL, SFD_CLOEXEC); }'''))
-config_host_data.set('CONFIG_SPLICE', cc.links(gnu_source_prefix + '''
-  #include <unistd.h>
-  #include <fcntl.h>
-  #include <limits.h>
-
+config_host_data.set('CONFIG_SPLICE', cc.links(osdep_prefix + '''
   int main(void)
   {
     int len, fd = 0;
@@ -2880,13 +2878,13 @@ config_host_data.set('CONFIG_SPLICE', cc.links(gnu_source_prefix + '''
     return 0;
   }'''))
 
-config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
+config_host_data.set('HAVE_MLOCKALL', cc.links(osdep_prefix + '''
   #include <sys/mman.h>
   int main(void) {
     return mlockall(MCL_FUTURE);
   }'''))
 
-config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
+config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(osdep_prefix + '''
   #include <sys/mman.h>
   int main(void) {
       return mlockall(MCL_FUTURE | MCL_ONFAULT);
@@ -2895,7 +2893,7 @@ config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
 have_l2tpv3 = false
 if get_option('l2tpv3').allowed() and have_system
   have_l2tpv3 = cc.has_type('struct mmsghdr',
-    prefix: gnu_source_prefix + '''
+    prefix: osdep_prefix + '''
       #include <sys/socket.h>
       #include <linux/ip.h>''')
 endif
@@ -3011,13 +3009,13 @@ if has_int128_type
   endif
 endif
 
-config_host_data.set('CONFIG_GETAUXVAL', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_GETAUXVAL', cc.links(osdep_prefix + '''
   #include <sys/auxv.h>
   int main(void) {
     return getauxval(AT_HWCAP) == 0;
   }'''))
 
-config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(gnu_source_prefix + '''
+config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(osdep_prefix + '''
   #include <sys/auxv.h>
   int main(void) {
     unsigned long hwcap = 0;
@@ -3130,9 +3128,7 @@ config_host_data.set('CONFIG_MEMBARRIER', get_option('membarrier') \
   .allowed())
 
 have_afalg = get_option('crypto_afalg') \
-  .require(cc.compiles(gnu_source_prefix + '''
-    #include <errno.h>
-    #include <sys/types.h>
+  .require(cc.compiles(osdep_prefix + '''
     #include <sys/socket.h>
     #include <linux/if_alg.h>
     int main(void) {

-- 
2.49.0


