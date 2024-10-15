Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78792CFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewy-0006mg-Bw; Tue, 15 Oct 2024 06:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewc-0006hW-NO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewa-0005ze-FD
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43057f4a16eso45357065e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988702; x=1729593502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T3QsANDVDDObFaRGubzLReP2JoJVVMU5E35nrvt2hBY=;
 b=Ko5djHuo8QGiRtcTcTPz3xeW4Pd4fyFcQItzXs1rgobQNlTGahlzopIyRjmor86JUl
 9yxgCe/2+knbexZzSRxZeCj8989k1FmYV7eoVhWur77ocBiWfH58bNas753llyXJDp+c
 Z3gjGgKZP3xJ2GHOut/8kZfunqEtkMEjMM2xcyf7f68HYhaiFU26Tz43wRGDcT2wHTp3
 0UKjPzvOm0/m5LKwB1+ah4SmOPtyuaMLXNYc/7QrtOSpABjYwYNqIKVuSrfvbXB8QHyU
 +g53G4z4NTe+6FLfJ2HZe4s2Y+1ZpOhnKceC48GlUKrkckhvdSCHyLSxhJrnIaovfxNC
 NFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988702; x=1729593502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3QsANDVDDObFaRGubzLReP2JoJVVMU5E35nrvt2hBY=;
 b=PRqoiQRq6wWvlTvpiDZlZQUvH7pBDHWtMrdP+GnRrqEoS8ZMrSmPnFBhf8Y+94pN+l
 GLczBroUaQWzuMGjefW1ZvN2PWxY8YfeTpk2q6puSN4NfxGgq250WE58JUkNjgDCeevA
 8spUPyhrzsA7wvFfky829KWNqmeGmBcbmDNFTK8bjNygj0w14VqiUlxtMP/S/INP+fpr
 b8bLmN0xfi2wbO80PPObeCzAcggiuAho2DWPCXsCY9hw0zmJtS6/yjkGo7rkH9jU8puX
 KIYj99OyI8HECOpsMqQtMXerOvMd7zu9PtWHZOvmZmXKx4XoTKvrOysag0pa2rqjCKUG
 ObmQ==
X-Gm-Message-State: AOJu0Yzn7IONmaQEu2+DkE9Xfj99paF8S3cMzzo2nlRbk5P3luCOeJwk
 fsFhoqlRzJQaQwujhAZ93AKi0rWqeW4yx3onnB4BxEHhS1OV8MM5G8GwNAq/dmi19eiAZU4LIka
 Q
X-Google-Smtp-Source: AGHT+IGTl2Luow8Sh0/n88e4Ia8aFmR4DSexJIadhxRww4jzfBSQ4gq7gCHME9SgiwzjmIQHs+SxpQ==
X-Received: by 2002:a05:600c:1e18:b0:431:166b:fc1e with SMTP id
 5b1f17b1804b1-4311df42cdamr125863385e9.25.1728988702458; 
 Tue, 15 Oct 2024 03:38:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/28] vl.c: Remove pxa2xx-specific -portrait and -rotate
 options
Date: Tue, 15 Oct 2024 11:38:06 +0100
Message-Id: <20241015103808.133024-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The ``-portrait`` and ``-rotate`` options were documented as only
working with the PXA LCD device, and all the machine types using
that display device were removed in 9.2.

These options were intended to simulate a mobile device being
rotated by the user, and had three effects:
 * the display output was rotated by 90, 180 or 270 degrees
   (implemented in the PXA display device models)
 * the mouse/trackpad input was rotated the opposite way
   (implemented in generic code)
 * the machine model would signal to the guest about its
   orientation
   (implemented by e.g. the spitz machine model)

Of these three things, the input-rotation was coded without being
restricted to boards which supported the full set of device-rotation
handling, so in theory the options were usable on other machine
models with odd effects (rotating input but not display output).  But
this was never intended or documented behaviour, so we can reasonably
drop these command line arguments without a formal deprecate-and-drop
cycle for them.

Remove the options, and their implementation and documentation.
Describe the removal in removed-features.rst.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241003140010.1653808-7-peter.maydell@linaro.org
---
 docs/about/removed-features.rst | 23 +++++++++++++++++++++
 include/sysemu/sysemu.h         |  1 -
 system/globals.c                |  1 -
 system/vl.c                     | 11 ----------
 ui/input.c                      | 36 ---------------------------------
 qemu-options.hx                 | 16 ---------------
 6 files changed, 23 insertions(+), 65 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c76b91a88d4..912e0a1fcfc 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -532,6 +532,29 @@ security model option, or switch to ``virtiofs``.   The virtiofs daemon
 ``virtiofsd`` uses vhost to eliminate the high latency costs of the 9p
 ``proxy`` backend.
 
+``-portrait`` and ``-rotate`` (since 9.2)
+'''''''''''''''''''''''''''''''''''''''''
+
+The ``-portrait`` and ``-rotate`` options were documented as only
+working with the PXA LCD device, and all the machine types using
+that display device were removed in 9.2, so these options also
+have been dropped.
+
+These options were intended to simulate a mobile device being
+rotated by the user, and had three effects:
+
+* the display output was rotated by 90, 180 or 270 degrees
+* the mouse/trackpad input was rotated the opposite way
+* the machine model would signal to the guest about its
+  orientation
+
+Of these three things, the input-rotation was coded without being
+restricted to boards which supported the full set of device-rotation
+handling, so in theory the options were usable on other machine models
+to produce an odd effect (rotating input but not display output). But
+this was never intended or documented behaviour, so we have dropped
+the options along with the machine models they were intended for.
+
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 5b4397eeb80..7ec419ce132 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -41,7 +41,6 @@ extern int graphic_height;
 extern int graphic_depth;
 extern int display_opengl;
 extern const char *keyboard_layout;
-extern int graphic_rotate;
 extern int old_param;
 extern uint8_t *boot_splash_filedata;
 extern bool enable_mlock;
diff --git a/system/globals.c b/system/globals.c
index d602a04fa28..84ce943ac96 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -40,7 +40,6 @@ int autostart = 1;
 int vga_interface_type = VGA_NONE;
 bool vga_interface_created;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
-int graphic_rotate;
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
 int old_param;
diff --git a/system/vl.c b/system/vl.c
index fe547ca47c2..e83b3b2608b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2910,17 +2910,6 @@ void qemu_init(int argc, char **argv)
                 nographic = true;
                 dpy.type = DISPLAY_TYPE_NONE;
                 break;
-            case QEMU_OPTION_portrait:
-                graphic_rotate = 90;
-                break;
-            case QEMU_OPTION_rotate:
-                graphic_rotate = strtol(optarg, (char **) &optarg, 10);
-                if (graphic_rotate != 0 && graphic_rotate != 90 &&
-                    graphic_rotate != 180 && graphic_rotate != 270) {
-                    error_report("only 90, 180, 270 deg rotation is available");
-                    exit(1);
-                }
-                break;
             case QEMU_OPTION_kernel:
                 qdict_put_str(machine_opts_dict, "kernel", optarg);
                 break;
diff --git a/ui/input.c b/ui/input.c
index dc745860f48..7ddefebc439 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -174,37 +174,6 @@ void qmp_input_send_event(const char *device,
     qemu_input_event_sync();
 }
 
-static int qemu_input_transform_invert_abs_value(int value)
-{
-  return (int64_t)INPUT_EVENT_ABS_MAX - value + INPUT_EVENT_ABS_MIN;
-}
-
-static void qemu_input_transform_abs_rotate(InputEvent *evt)
-{
-    InputMoveEvent *move = evt->u.abs.data;
-    switch (graphic_rotate) {
-    case 90:
-        if (move->axis == INPUT_AXIS_X) {
-            move->axis = INPUT_AXIS_Y;
-        } else if (move->axis == INPUT_AXIS_Y) {
-            move->axis = INPUT_AXIS_X;
-            move->value = qemu_input_transform_invert_abs_value(move->value);
-        }
-        break;
-    case 180:
-        move->value = qemu_input_transform_invert_abs_value(move->value);
-        break;
-    case 270:
-        if (move->axis == INPUT_AXIS_X) {
-            move->axis = INPUT_AXIS_Y;
-            move->value = qemu_input_transform_invert_abs_value(move->value);
-        } else if (move->axis == INPUT_AXIS_Y) {
-            move->axis = INPUT_AXIS_X;
-        }
-        break;
-    }
-}
-
 static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
 {
     const char *name;
@@ -340,11 +309,6 @@ void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt)
 
     qemu_input_event_trace(src, evt);
 
-    /* pre processing */
-    if (graphic_rotate && (evt->type == INPUT_EVENT_KIND_ABS)) {
-            qemu_input_transform_abs_rotate(evt);
-    }
-
     /* send event */
     s = qemu_input_find_handler(1 << evt->type, src);
     if (!s) {
diff --git a/qemu-options.hx b/qemu-options.hx
index d5afefe5b63..daae4941474 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2331,22 +2331,6 @@ SRST
         pick the first available. (Since 2.9)
 ERST
 
-DEF("portrait", 0, QEMU_OPTION_portrait,
-    "-portrait       rotate graphical output 90 deg left (only PXA LCD)\n",
-    QEMU_ARCH_ALL)
-SRST
-``-portrait``
-    Rotate graphical output 90 deg left (only PXA LCD).
-ERST
-
-DEF("rotate", HAS_ARG, QEMU_OPTION_rotate,
-    "-rotate <deg>   rotate graphical output some deg left (only PXA LCD)\n",
-    QEMU_ARCH_ALL)
-SRST
-``-rotate deg``
-    Rotate graphical output some deg left (only PXA LCD).
-ERST
-
 DEF("vga", HAS_ARG, QEMU_OPTION_vga,
     "-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]\n"
     "                select video card type\n", QEMU_ARCH_ALL)
-- 
2.34.1


