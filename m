Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD62D0BB7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3v54-0000n9-2G; Thu, 24 Oct 2024 06:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t3v51-0000le-BG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:28:35 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t3v4t-00087u-CX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:28:35 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so153003866b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729765704; x=1730370504;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awe07NOksR1ao1OasiHRde1JNGh5DYeYO6Ef7uq8wQo=;
 b=ZYV8QUT5q08k8i5tRsTYl6HAPszXN+ZSN5Unq32+SbrWmwyayAKBfA0+rnd4KHL57u
 np5bb4nZY+s2BlFFIhU6y/JH5n/lDwlmjHydt9c6ccqwyAl8nbwrxgD+CmLZdN/P5exS
 YbQFTDZj+mBagwQo/AqR6bSnJi+IgxB6x11sE4sTU8sQurhHU3hGCuiLLqrUetlU3Rrj
 OVzqJTDnk4RapWcCG+vyMGXRR0FIUjRvZ6liDHuoHK4sGTuEH6NxQrrDa6IMh9sCO76F
 2d0Ebif7Sbt30G54YnfGvcJGW87panKfGFGEeGT/h/i1DiSRXthEhwdXzoFTZk+CnDws
 lU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729765704; x=1730370504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awe07NOksR1ao1OasiHRde1JNGh5DYeYO6Ef7uq8wQo=;
 b=rxLdGCdeFOevfp0IbrhhTVj8nTEMtuMKpPcCuDLfMNPjECOMomK/MyngL//gKYO+XY
 2Fg+nSMm17a5k2e9dsE1tvi3wK7v4hU7zD0uCaYZEf5ORrE9vavNQj2SFcy39KUsr7u1
 vASvJDe9E50l+fAM2NzTjnT9uJyspeNm6Xu3z750R/8PvaJsIR5e6CXkfspT6VEa+RDw
 SJtYxBJm/knmyNTcdzbwkKOi/3W4R8cG5aZdrUbC7mAgrAwMS7P3UUvYGORkybP5wDh1
 12g7kH2pn/g9VrJm80Le/PtS3F05wvOXw2NDniGI95T+MN4kNegDAqlf/wEWluJ6neWH
 am+A==
X-Gm-Message-State: AOJu0YwCVxQg9LcW4slA+c4ED6HHMVg2m3x+YHzK4u7nHc3ceRpYLyJ8
 ZXR46Fzv7OfWUYiE7nPPD+//ZL7L2VwZVRHsOwwuat6aU1rKV8sOO6WBnl5VB+689+T4QVJiTCD
 e2w==
X-Google-Smtp-Source: AGHT+IFnwOlVGXvu5vMdnRrj88KCizIA04RU/tOWWBoYvFgXUz86j957W1cQi3V/VPCBA1bIERXcYA==
X-Received: by 2002:a17:907:7211:b0:a9a:ca:4436 with SMTP id
 a640c23a62f3a-a9ad19a8b5amr159060266b.13.1729765704224; 
 Thu, 24 Oct 2024 03:28:24 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a913706d3sm601019066b.134.2024.10.24.03.28.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 03:28:23 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v4 01/15] ui & main loop: Redesign of system-specific main
 thread event handling
Date: Thu, 24 Oct 2024 12:27:59 +0200
Message-Id: <20241024102813.9855-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241024102813.9855-1-phil@philjordan.eu>
References: <20241024102813.9855-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::630;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x630.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

macOS's Cocoa event handling must be done on the initial (main) thread
of the process. Furthermore, if library or application code uses
libdispatch, the main dispatch queue must be handling events on the main
thread as well.

So far, this has affected Qemu in both the Cocoa and SDL UIs, although
in different ways: the Cocoa UI replaces the default qemu_main function
with one that spins Qemu's internal main event loop off onto a
background thread. SDL (which uses Cocoa internally) on the other hand
uses a polling approach within Qemu's main event loop. Events are
polled during the SDL UI's dpy_refresh callback, which happens to run
on the main thread by default.

As UIs are mutually exclusive, this works OK as long as nothing else
needs platform-native event handling. In the next patch, a new device is
introduced based on the ParavirtualizedGraphics.framework in macOS.
This uses libdispatch internally, and only works when events are being
handled on the main runloop. With the current system, it works when
using either the Cocoa or the SDL UI. However, it does not when running
headless. Moreover, any attempt to install a similar scheme to the
Cocoa UI's main thread replacement fails when combined with the SDL
UI.

This change formalises main thread handling. UI (Display) and OS
platform implementations can declare requirements or preferences:

 * The Cocoa UI specifies that Qemu's main loop must run on a
   background thread and provides a function to run on the main thread
   which runs the NSApplication event handling runloop.
 * The SDL UI specifies that Qemu's main loop must run on the main
   thread.
 * For other UIs, or in the absence of UIs, the platform's default
   behaviour is followed.
 * The Darwin platform provides a default function to run on the
   main thread, which runs the main CFRunLoop.
 * Other OSes do not provide their own default main function and thus
   fall back to running Qemu's main loop on the main thread, as usual.

This means that on macOS, the platform's runloop events are always
handled, regardless of chosen UI. The new PV graphics device will
thus work in all configurations.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 include/qemu-main.h       |  3 +--
 include/qemu/typedefs.h   |  1 +
 include/sysemu/os-posix.h |  2 ++
 include/sysemu/os-win32.h |  2 ++
 include/ui/console.h      | 12 +++++++++
 os-posix.c                | 20 ++++++++++++++
 system/main.c             | 45 +++++++++++++++++++++++++++-----
 system/vl.c               |  2 ++
 ui/cocoa.m                | 55 +++++++++------------------------------
 ui/console.c              | 32 +++++++++++++++++++++--
 ui/sdl2.c                 |  2 ++
 ui/trace-events           |  1 +
 12 files changed, 123 insertions(+), 54 deletions(-)

diff --git a/include/qemu-main.h b/include/qemu-main.h
index 940960a7dbc..4bd0d667edc 100644
--- a/include/qemu-main.h
+++ b/include/qemu-main.h
@@ -5,7 +5,6 @@
 #ifndef QEMU_MAIN_H
 #define QEMU_MAIN_H
 
-int qemu_default_main(void);
-extern int (*qemu_main)(void);
+extern qemu_main_fn qemu_main;
 
 #endif /* QEMU_MAIN_H */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3d84efcac47..b02cfe1f328 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
  * Function types
  */
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
+typedef int (*qemu_main_fn)(void);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index b881ac6c6f7..51bbb5370e0 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -26,6 +26,7 @@
 #ifndef QEMU_OS_POSIX_H
 #define QEMU_OS_POSIX_H
 
+#include "qemu/typedefs.h"
 #include <sys/mman.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
@@ -54,6 +55,7 @@ void os_set_chroot(const char *path);
 void os_setup_limits(void);
 void os_setup_post(void);
 int os_mlock(void);
+qemu_main_fn os_non_loop_main_thread_fn(void);
 
 /**
  * qemu_alloc_stack:
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index b82a5d3ad93..db0daba9a52 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -26,6 +26,7 @@
 #ifndef QEMU_OS_WIN32_H
 #define QEMU_OS_WIN32_H
 
+#include "qemu/typedefs.h"
 #include <winsock2.h>
 #include <windows.h>
 #include <ws2tcpip.h>
@@ -105,6 +106,7 @@ void os_set_line_buffering(void);
 void os_setup_early_signal_handling(void);
 
 int getpagesize(void);
+static inline qemu_main_fn os_non_loop_main_thread_fn(void) { return NULL; }
 
 #if !defined(EPROTONOSUPPORT)
 # define EPROTONOSUPPORT EINVAL
diff --git a/include/ui/console.h b/include/ui/console.h
index 5832d52a8a6..4e3dc7da146 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -440,6 +440,18 @@ typedef struct QemuDisplay QemuDisplay;
 
 struct QemuDisplay {
     DisplayType type;
+    /*
+     * Some UIs have special requirements, for the qemu_main event loop running
+     * on either the process's initial (main) thread ('Off'), or on an
+     * explicitly created background thread ('On') because of platform-specific
+     * event handling.
+     * The default, 'Auto', indicates the display will work with both setups.
+     * If 'On', either a qemu_main_thread_fn must be supplied, or it must be
+     * ensured that all applicable host OS platforms supply a default main.
+     * (via os_non_loop_main_thread_fn())
+     */
+    OnOffAuto qemu_main_on_bg_thread;
+    qemu_main_fn qemu_main_thread_fn;
     void (*early_init)(DisplayOptions *opts);
     void (*init)(DisplayState *ds, DisplayOptions *opts);
     const char *vc;
diff --git a/os-posix.c b/os-posix.c
index 43f9a43f3fe..a173c026f6c 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -37,6 +37,8 @@
 
 #ifdef CONFIG_LINUX
 #include <sys/prctl.h>
+#elif defined(CONFIG_DARWIN)
+#include <CoreFoundation/CoreFoundation.h>
 #endif
 
 
@@ -342,3 +344,21 @@ int os_mlock(void)
     return -ENOSYS;
 #endif
 }
+
+#ifdef CONFIG_DARWIN
+static int os_darwin_cfrunloop_main(void)
+{
+    CFRunLoopRun();
+    abort();
+}
+#endif
+
+qemu_main_fn os_non_loop_main_thread_fn(void)
+{
+#ifdef CONFIG_DARWIN
+    /* By default, run the OS's event runloop on the main thread. */
+    return os_darwin_cfrunloop_main;
+#else
+    return NULL;
+#endif
+}
diff --git a/system/main.c b/system/main.c
index 9b91d21ea8c..358eab281b0 100644
--- a/system/main.c
+++ b/system/main.c
@@ -24,13 +24,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu-main.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"
 
-#ifdef CONFIG_SDL
-#include <SDL.h>
-#endif
-
-int qemu_default_main(void)
+static int qemu_default_main(void)
 {
     int status;
 
@@ -40,10 +37,44 @@ int qemu_default_main(void)
     return status;
 }
 
-int (*qemu_main)(void) = qemu_default_main;
+/*
+ * Various macOS system libraries, including the Cocoa UI and anything using
+ * libdispatch, such as ParavirtualizedGraphics.framework, requires that the
+ * main runloop, on the main (initial) thread be running or at least regularly
+ * polled for events. A special mode is therefore supported, where the QEMU
+ * main loop runs on a separate thread and the main thread handles the
+ * CF/Cocoa runloop.
+ */
+
+static void *call_qemu_default_main(void *opaque)
+{
+    int status;
+
+    bql_lock();
+    status = qemu_default_main();
+    bql_unlock();
+
+    exit(status);
+}
+
+static void qemu_run_default_main_on_new_thread(void)
+{
+    QemuThread thread;
+
+    qemu_thread_create(&thread, "qemu_main", call_qemu_default_main,
+                       NULL, QEMU_THREAD_DETACHED);
+}
+
+qemu_main_fn qemu_main;
 
 int main(int argc, char **argv)
 {
     qemu_init(argc, argv);
-    return qemu_main();
+    if (qemu_main) {
+        qemu_run_default_main_on_new_thread();
+        bql_unlock();
+        return qemu_main();
+    } else {
+        qemu_default_main();
+    }
 }
diff --git a/system/vl.c b/system/vl.c
index e83b3b2608b..c1db20dbee9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -134,6 +134,7 @@
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
 #include "qemu/keyval.h"
+#include "qemu-main.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -3667,6 +3668,7 @@ void qemu_init(int argc, char **argv)
     trace_init_file();
 
     qemu_init_main_loop(&error_fatal);
+    qemu_main = os_non_loop_main_thread_fn();
     cpu_timers_init();
 
     user_register_global_props();
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4c2dd335323..393b3800491 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -73,6 +73,8 @@
     int height;
 } QEMUScreen;
 
+@class QemuCocoaPasteboardTypeOwner;
+
 static void cocoa_update(DisplayChangeListener *dcl,
                          int x, int y, int w, int h);
 
@@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static NSInteger cbchangecount = -1;
 static QemuClipboardInfo *cbinfo;
 static QemuEvent cbevent;
+static QemuCocoaPasteboardTypeOwner *cbowner;
 
 // Utility functions to run specified code block with the BQL held
 typedef void (^CodeBlock)(void);
@@ -1321,8 +1324,10 @@ - (void) dealloc
 {
     COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
 
-    if (cocoaView)
-        [cocoaView release];
+    [cocoaView release];
+    [cbowner release];
+    cbowner = nil;
+
     [super dealloc];
 }
 
@@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender provideDataForType:(NSPasteboardType)t
 
 @end
 
-static QemuCocoaPasteboardTypeOwner *cbowner;
-
 static void cocoa_clipboard_notify(Notifier *notifier, void *data);
 static void cocoa_clipboard_request(QemuClipboardInfo *info,
                                     QemuClipboardType type);
@@ -2002,43 +2005,8 @@ static void cocoa_clipboard_request(QemuClipboardInfo *info,
     }
 }
 
-/*
- * The startup process for the OSX/Cocoa UI is complicated, because
- * OSX insists that the UI runs on the initial main thread, and so we
- * need to start a second thread which runs the qemu_default_main():
- * in main():
- *  in cocoa_display_init():
- *   assign cocoa_main to qemu_main
- *   create application, menus, etc
- *  in cocoa_main():
- *   create qemu-main thread
- *   enter OSX run loop
- */
-
-static void *call_qemu_main(void *opaque)
-{
-    int status;
-
-    COCOA_DEBUG("Second thread: calling qemu_default_main()\n");
-    bql_lock();
-    status = qemu_default_main();
-    bql_unlock();
-    COCOA_DEBUG("Second thread: qemu_default_main() returned, exiting\n");
-    [cbowner release];
-    exit(status);
-}
-
 static int cocoa_main(void)
 {
-    QemuThread thread;
-
-    COCOA_DEBUG("Entered %s()\n", __func__);
-
-    bql_unlock();
-    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
-                       NULL, QEMU_THREAD_DETACHED);
-
-    // Start the main event loop
     COCOA_DEBUG("Main thread: entering OSX run loop\n");
     [NSApp run];
     COCOA_DEBUG("Main thread: left OSX run loop, which should never happen\n");
@@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
-    qemu_main = cocoa_main;
-
     // Pull this console process up to being a fully-fledged graphical
     // app with a menubar and Dock icon
     ProcessSerialNumber psn = { 0, kCurrentProcess };
@@ -2188,8 +2154,11 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 }
 
 static QemuDisplay qemu_display_cocoa = {
-    .type       = DISPLAY_TYPE_COCOA,
-    .init       = cocoa_display_init,
+    .type                   = DISPLAY_TYPE_COCOA,
+    .init                   = cocoa_display_init,
+    /* The Cocoa UI will run the NSApplication runloop on the main thread.*/
+    .qemu_main_on_bg_thread = ON_OFF_AUTO_ON,
+    .qemu_main_thread_fn    = cocoa_main,
 };
 
 static void register_cocoa(void)
diff --git a/ui/console.c b/ui/console.c
index 5165f171257..1599d8b7095 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -33,6 +33,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu-main.h"
 #include "chardev/char.h"
 #include "trace.h"
 #include "exec/memory.h"
@@ -1569,12 +1570,39 @@ void qemu_display_early_init(DisplayOptions *opts)
 
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
 {
+    QemuDisplay *display;
+    bool bg_main_loop;
+
     assert(opts->type < DISPLAY_TYPE__MAX);
     if (opts->type == DISPLAY_TYPE_NONE) {
         return;
     }
-    assert(dpys[opts->type] != NULL);
-    dpys[opts->type]->init(ds, opts);
+    display = dpys[opts->type];
+    assert(display != NULL);
+    display->init(ds, opts);
+
+    switch (display->qemu_main_on_bg_thread) {
+    case ON_OFF_AUTO_OFF:
+        bg_main_loop = false;
+        qemu_main = NULL;
+        break;
+    case ON_OFF_AUTO_ON:
+        bg_main_loop = true;
+        break;
+    case ON_OFF_AUTO_AUTO:
+    default:
+        bg_main_loop = qemu_main;
+        break;
+    }
+
+    trace_qemu_display_init_main_thread(
+        DisplayType_str(display->type), display->qemu_main_thread_fn, qemu_main,
+        OnOffAuto_lookup.array[display->qemu_main_on_bg_thread],
+        display->qemu_main_on_bg_thread, bg_main_loop);
+    if (bg_main_loop && display->qemu_main_thread_fn) {
+        qemu_main = display->qemu_main_thread_fn;
+    }
+    assert(!bg_main_loop || qemu_main);
 }
 
 const char *qemu_display_get_vc(DisplayOptions *opts)
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da14..35e22785119 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -971,6 +971,8 @@ static QemuDisplay qemu_display_sdl2 = {
     .type       = DISPLAY_TYPE_SDL,
     .early_init = sdl2_display_early_init,
     .init       = sdl2_display_init,
+    /* SDL must poll for events (via dpy_refresh) on main thread */
+    .qemu_main_on_bg_thread = ON_OFF_AUTO_OFF,
 };
 
 static void register_sdl1(void)
diff --git a/ui/trace-events b/ui/trace-events
index 3da0d5e2800..1e72c967399 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -16,6 +16,7 @@ displaysurface_free(void *display_surface) "surface=%p"
 displaychangelistener_register(void *dcl, const char *name) "%p [ %s ]"
 displaychangelistener_unregister(void *dcl, const char *name) "%p [ %s ]"
 ppm_save(int fd, void *image) "fd=%d image=%p"
+qemu_display_init_main_thread(const char *display_name, bool qemu_display_sets_main_fn, bool qemu_main_is_set, const char *display_bg_main_loop_preference, int preference, bool bg_main_loop) "display '%s': sets main thread function: %d, platform provides main function: %d, display background main loop preference: %s (%d); main loop will run on background thread: %d"
 
 # gtk-egl.c
 # gtk-gl-area.c
-- 
2.39.3 (Apple Git-145)


