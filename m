Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B065AC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwINk-0001JJ-4I; Tue, 18 Aug 2026 07:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wwINi-0001Iw-7e
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:53:26 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wwINg-0004rI-GR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:53:26 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6aae90e595fso3086347eaf.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787054003; x=1787658803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U3LWr6P8Ku/lh3RxThq5whcRnXRSEiPxDQHrBsc656Q=;
 b=KMw04Xv7K6QzzIQpSQe6STUoULQQBl3pogqaBFgoZE1Hf5Jptj3C+YtsCfonK9bngG
 Ug/SpeLlM4DVD6usxZPYbsKu8WOPOfpwYMq3NnWPwxil+gdp2u2k5iXeKZShhYrY3QKH
 jMAxOA9JPWiI+KJzW7SBi/dARudG94HzIWtEuJCa2IVvapo0rUgOkarAQGeVADjyEUjM
 btrtIDsHaFTC+mET6uymshiuJuDtzPIWCAoQTnnxGQXbmCQ3YRRS4IUQ0dWRxPnd2sqX
 sQ+UBVOEyPZ685vZFAUHTxVsXxRmls4VuhjbdB/x7lFtKWk3mWujOXqhRZ7Yyfyx27vb
 wfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787054003; x=1787658803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U3LWr6P8Ku/lh3RxThq5whcRnXRSEiPxDQHrBsc656Q=;
 b=LYg+j0s6NauiRLhl6PPmuXz/AllNe2WG8xftxEx/KOr7SkXfG6617vQFwaTUC7k3AB
 O+TkqUd0tKWv1o+vcMQrZQSfD+YhRSptG0EMstCFRdCcjwff0906xzBOsKwi5bhtOA6D
 oftqJqiPCLIV5F3w1lnhU09zyzc1Xbj4MzxTO5z7M+EjebvcvHwC4ZWL2Yei5PFo2ORf
 GIgmzA1ycywJXTc7yoR0rJUTdYFIuxsRIjUE/LoxcRVgeUzTWxukZrNKZfqa0lKsH0J9
 wF0zX5o8gB+8AetAGIQgrIXHaV5IIFPX15AfDDFBVrVxVnfiQwefz5kRd7js7D0cP+kb
 V2OQ==
X-Gm-Message-State: AOJu0YwGSgPoDZm1P5xLs30EGKdb2O4thZH0lswh3q6SjCOsYDmONdSf
 n0tFizkfzuPvHDD4vPFCW8ke4vJVytfxHO5RMdUq35tU/V1Fvni1IIlF2fmrYvi0TcA=
X-Gm-Gg: AR+sD103RM0aQwrTEi4kryXFybIVBrYQ8nPZIE5WNjmcCu6yRLKbRATNP8t1a7IASxB
 hXjbSGjf18hOHCpsQHMD5v5cOVgsJklVh0rGtaUnG63kE7zKEJamnca2KFUXcLbzNBsT5JE+3EU
 a3Fceg6D5ulKi30fyQ9J5T0KBXZjsisqV2cmSOpvayhg0SLeT6pLctnJTGgKAVMm6P/nzHwj+7E
 PXGaIk5m1H6zIpOo7IvlO+G2kLCNuJqe62Cc2bGGfWUvnLlaGbRtMf5oy4MxPVp88NSW+qhtZDm
 R3Nnz+v2FZxszmbiQMdhcZYuZEtcQAu8+CObf9hK7W7G/OMbWcLwzKae9Gx4I3iMRobnsc1epEY
 DjWLzrGgKcomh2hXqOcxdAK1lASw2O6YwJEmBeWIXnNmw1zWSt3xPdiXVIFh8LBEX+vikMDoM4O
 tHK9gukpGW4n44dDysTG7dklT4imii7/aVmAuu65RBEoytaj8tBb/xvEnDtrUYAhWH
X-Received: by 2002:a05:6820:2d09:b0:6b0:4c98:8e2b with SMTP id
 006d021491bc7-6b11dd5404fmr6251500eaf.9.1787054003233; 
 Tue, 18 Aug 2026 04:53:23 -0700 (PDT)
Received: from colazcyASUSlaptop ([104.28.213.39])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45f226904b6sm3039002fac.0.2026.08.18.04.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 04:53:22 -0700 (PDT)
From: Chengyang Zhu <colazcyg@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Chengyang Zhu <colazcyg@gmail.com>
Subject: [PATCH RFC v2 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
Date: Tue, 18 Aug 2026 19:52:58 +0800
Message-ID: <20260818115258.429605-2-colazcyg@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818115258.429605-1-colazcyg@gmail.com>
References: <20260818115258.429605-1-colazcyg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=colazcyg@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Currently, the SetUIInfo method cannot set a refresh rate.
Simply adding a refresh_rate argument would break the method signature.

This patch adds the UIInfo interface containing
  * properties as staged display settings.
  * the method `Apply` applying staged settings.
  * the method `Reload` reloading settings from the console.

Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>
---
 ui/dbus-console.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml | 32 +++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index e1ac06814b..dc5c991f80 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -55,6 +55,8 @@ struct _DBusDisplayConsole {
     guint last_x;
     guint last_y;
     Notifier mouse_mode_notifier;
+
+    QemuDBusDisplay1UIInfo *iface_ui_info;
 };
 
 G_DEFINE_TYPE(DBusDisplayConsole,
@@ -155,6 +157,7 @@ dbus_display_console_dispose(GObject *object)
     qemu_input_led_notifier_remove(&ddc->led_notifier);
     qemu_console_unregister_listener(&ddc->dcl);
     qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
+    g_clear_object(&ddc->iface_ui_info);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);
@@ -528,6 +531,80 @@ dbus_mouse_mode_change(Notifier *notify, void *data)
     dbus_mouse_update_is_absolute(ddc);
 }
 
+static gboolean
+dbus_ui_info_reload(DBusDisplayConsole *ddc,
+                    GDBusMethodInvocation *invocation)
+{
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "UIInfo is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    QemuUIInfo ui_info = *qemu_console_get_ui_info(ddc->dcl.con);
+
+    g_object_set(ddc->iface_ui_info,
+                "width-mm", ui_info.width_mm,
+                "height-mm", ui_info.height_mm,
+                "xoff", ui_info.xoff,
+                "yoff", ui_info.yoff,
+                "width", ui_info.width,
+                "height", ui_info.height,
+                "refresh-rate", ui_info.refresh_rate,
+                NULL);
+
+    qemu_dbus_display1_uiinfo_complete_reload(ddc->iface_ui_info, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+dbus_ui_info_apply(DBusDisplayConsole *ddc,
+                   GDBusMethodInvocation *invocation)
+{
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "UIInfo is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    guint width_mm;
+    guint height_mm;
+    gint xoff;
+    gint yoff;
+    guint width;
+    guint height;
+    guint refresh_rate;
+
+    g_object_get(G_OBJECT(ddc->iface_ui_info),
+                "width-mm", &width_mm,
+                "height-mm", &height_mm,
+                "xoff", &xoff,
+                "yoff", &yoff,
+                "width", &width,
+                "height", &height,
+                "refresh-rate", &refresh_rate,
+                NULL);
+
+    QemuUIInfo ui_info = {
+        .width_mm = (uint16_t)width_mm,
+        .height_mm = (uint16_t)height_mm,
+        .xoff = (int)xoff,
+        .yoff = (int)yoff,
+        .width = (uint32_t)width,
+        .height = (uint32_t)height,
+        .refresh_rate = (uint32_t)refresh_rate
+    };
+
+    qemu_console_set_ui_info(ddc->dcl.con, &ui_info, false);
+    qemu_dbus_display1_uiinfo_complete_apply(ddc->iface_ui_info, invocation);
+
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
 int dbus_display_console_get_index(DBusDisplayConsole *ddc)
 {
     return qemu_console_get_index(ddc->dcl.con);
@@ -550,6 +627,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "org.qemu.Display1.Keyboard",
         "org.qemu.Display1.Mouse",
         "org.qemu.Display1.MultiTouch",
+        "org.qemu.Display1.UIInfo",
         NULL
     };
 
@@ -626,5 +704,13 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
     qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     dbus_mouse_update_is_absolute(ddc);
 
+    ddc->iface_ui_info = qemu_dbus_display1_uiinfo_skeleton_new();
+    g_object_connect(ddc->iface_ui_info,
+        "swapped-signal::handle-reload", dbus_ui_info_reload, ddc,
+        "swapped-signal::handle-apply", dbus_ui_info_apply, ddc,
+        NULL);
+    g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
+        G_DBUS_INTERFACE_SKELETON(ddc->iface_ui_info));
+
     return ddc;
 }
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index d96bae2ed6..a766fd0862 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -1159,4 +1159,36 @@
     -->
     <property name="Encoding" type="s" access="read"/>
   </interface>
+
+  <!--
+      org.qemu.Display1.UIInfo:
+
+        WidthMm: the physical display width in millimeters.
+        HeightMm: the physical display height in millimeters.
+        XOff: horizontal offset, in pixels.
+        YOff: vertical offset, in pixels.
+        Width: console width, in pixels.
+        Height: console height, in pixels.
+        RefreshRate: display refresh rate, in millihertz.
+
+      Reload:
+        Set the staged properties to the state of the display.
+      Apply:
+        Apply the staged properties to the display.
+  -->
+  <interface name="org.qemu.Display1.UIInfo">
+    <property name="WidthMm" type="q" access="readwrite"/>
+    <property name="HeightMm" type="q" access="readwrite"/>
+    <property name="XOff" type="i" access="readwrite"/>
+    <property name="YOff" type="i" access="readwrite"/>
+    <property name="Width" type="u" access="readwrite"/>
+    <property name="Height" type="u" access="readwrite"/>
+    <property name="RefreshRate" type="u" access="readwrite"/>
+
+    <method name="Reload">
+    </method>
+
+    <method name="Apply">
+    </method>
+  </interface>
 </node>
-- 
2.55.0


