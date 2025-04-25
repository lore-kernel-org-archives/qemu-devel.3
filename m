Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C882C369DC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2G-0007Oe-T1; Fri, 25 Apr 2025 11:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L24-0006bu-4c
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L20-00046g-Rc
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso21349185e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595119; x=1746199919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWBvK3X5bV3SuKKaFzVoRzC83J1Q7Cori3kEUJfd8m8=;
 b=gSFugjLKdpF8V7lGkjiU/Vsyywp6S8JqY6mzjtnwUDi0KKRrPzH4Ll9C7VySsMBdJy
 X0Jt4LvYDbvaMUxF69gFPPok1KwCZnPFuwmHp+RnkEUWlFW8HQvPmprDt1CuKBuEwAp+
 I/qX1Jo9k2pzJ7ACleZ3v1CC+sTmJhJWKFKfaOR3y0uUZ7azUpsZNLKMUzzyR8kAUs5A
 sBFmvEAof7oM1VGSWjoP8dL/NLIqXk4XAgVOcBAOCWlniRz4xLC4pCQ0G+sY8uOCTiU3
 jZV3azp4QxGy84JwKSjBSvsw9rB9p9Hn8z52SwhI3MHU0VyO4NDGTKP1aF9NjarCsyRV
 o3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595119; x=1746199919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWBvK3X5bV3SuKKaFzVoRzC83J1Q7Cori3kEUJfd8m8=;
 b=m7Zy2LNpM/5WtV2SC+ts6r4AqYKi4J6VZxkZ1FO7nOgoJJq+YIYMpiEHEI4SYRpp1S
 tS8MIuoA/K60HUS1Rnhya3d2kf/bQOTOGugiGcBRZLzH8tuYlz5Fi13jXPBQtBhvfZ42
 1TA+6gRN/QBie8tTBXdfjL5iSVJS9j8HPk92EsQ19llBmKVKCK15WImS7g8wg9MaI7bu
 rnz+4PuHJBOG5c2yUforYGyM1DXKQFT/6HK66OlyophZegQu+d9CKGZIyh+72pFKhFEs
 /z47aT3MgeaZPzE3BrYjeCW9JxBobbEDZOFvAsWhct/8syBBJYiZfEPga8TmfbpcYW9h
 7xKA==
X-Gm-Message-State: AOJu0YzM9udO7TocvKyTz8dSXigsBRA/1OU1rGfhf+RJCnmWMVtVBn5V
 gAEZZ3hkc1VVZRfwmXEWrcncFcPfgVmhTwB3CktSvljcfdo3CDGDnRaAEFCTfuTDf8rwmoPR6d7
 H
X-Gm-Gg: ASbGncsRv1VYQWIFC5uMnwuFGYx2DRz78IsbJmtaaR1/g+JWg+Ban0xa5Ev7cbn+1/r
 5j1sTKqDqQfQIcAS9oFbxbSysMh8s+WaXbL3kLPoMvXY9/VRaoS3mcUNUkY/RiVwI5UYmJ9vMkc
 YP4ygNrbamVu/JSEReHUNYGq23OZMdWOMYZW3SdN1Gj5q2MJGsv1Em/eM47ytg9trqYYTS0nLWX
 NUqop06yK3e3aXl+bxAHrkJNrxQYZkikys6AdJO51ct0GEW5leiYvHhbk0rymrdM3FOgALi1X84
 POCb74pYMFihhRUzwJmGfgvghRMROLzynZUscU65LnPgSJqBuo1lYimIoHlocPd7EiC0YaJJYnp
 L1uHakSraLQDlbDLf6/s2GMXfxw==
X-Google-Smtp-Source: AGHT+IGJEHcYX3NHYpV7xzouJF5gv/EmpWZ15Y5rN4PWavwqKz4HCiZ/pz4dh5qd3iZiNj6SgmULRw==
X-Received: by 2002:a05:600c:a363:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-440a66ab2bamr25048375e9.29.1745595118661; 
 Fri, 25 Apr 2025 08:31:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5311403sm28114225e9.23.2025.04.25.08.31.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/58] meson: Share common C source prefixes
Date: Fri, 25 Apr 2025 17:28:23 +0200
Message-ID: <20250425152843.69638-40-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

gnu_source_prefix defines _GNU_SOURCE for compiler object functions.
The definition is universally available in the code base.

docs/devel/style.rst also says that the "qemu/osdep.h" header is
always included, so files included in the file is also universally
available in the code base.

Rename gnu_source_prefix to osdep_prefix, and add #include directives
that are referred by the users of gnu_source_prefix and contained in
qemu/osdep.h to safely de-duplicate #include directives.

Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424-buildsys-v1-3-97655e3b25d7@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 68 +++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/meson.build b/meson.build
index 35dcec8ce5c..d93dbde194f 100644
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
2.47.1


