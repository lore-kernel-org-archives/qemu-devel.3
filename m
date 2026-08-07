Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717B6C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 12:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsJPZ-0007DG-2p; Fri, 07 Aug 2026 08:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wsG9E-0005fh-St
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 04:41:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wsG9D-00072V-87
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 04:41:48 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso3889872a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786092106; x=1786696906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yO8uMB87EPDnPpxjPt44btKXjFa1aoO3AkRJM+boOS8=;
 b=bAgWZoOLaNurHUGjp44u2kBkc3TIa9pX+o4UgFPYdEsp/gCtUQE6IpaBQtrKva8736
 LH4I0BZZCvg16EkxoRZ7iG8rh+vRlEDO1L/6/c1DQivte1ZhtUXpFBxRr3PU205ek3JC
 alx3riDSYDX3ZGZWIy9VErNnzB+OMkbQvaTGORpQ8wGBkY2rUwtfJdZrMlPaA/ANhb9J
 i1LZ9lpTaigYSMfHv6cu30ZR2ySPXrdwKMBbyLX3LFvNsT/RcaCFe+rYZnsjobeSwumw
 T1Jv/G1TKDLBuERBgMF7FYgKK2ZWXuttQ4FF7Y08gDuWtgoIaqPqhH21RD71B3OUFzRf
 oxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786092106; x=1786696906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yO8uMB87EPDnPpxjPt44btKXjFa1aoO3AkRJM+boOS8=;
 b=BgZyc/n3FfyXvKSR4j7d6YcWVxwFLhR/qpwFQaSUVHemRXuHBfeaUQDrXWPIvZAUbX
 bLwgAnI9l4UhwbbDkQJDqR1RL6QJ82odjLRah8OVR9WvcHgvEN/9kBp/9mHN8ROmzl3J
 avIZMbJRqVG8L1J23PvgxpQMIuwOd3+9OBh4pJnTrulE+2x35bWdCuKhgFFLAMI4t8Y+
 G/dL6wxv08cUw4OZaasEMndJescYvyK8OKJ6Dv5Ql/KLkZsaM9Li2H5EMY/K9V+Iyrpc
 R4WPvvcvLHOQHGK4Nnkj6JtXrKMNC+mEBp30bPYSUtcXBlkaaETEKt2/J7NMzoFP46ID
 6hUA==
X-Gm-Message-State: AOJu0Ywu0OB7vdz/5WkMfEVueot4Xsh4+uSH1gLyAwSV3t/wXVZHNZGY
 g6VWcfoiDG0FY8xkMW8pyhifgCwEq9Y/heoq6gN91TepxzMDGkjF19yH+qZUTckQ
X-Gm-Gg: AR+sD10wc8wWsjyC8tO6CL3rWe6/+qsfwwL3oHLeCaevooQcfwwBypz41oOP46gLgIS
 bBqp3+984f0/S6EBl0GwWL5Bbx1I0zSHPjd72fg8LYTxej8fr7uTPQ6d+yRz3jGmaEyfLB27nzv
 Rjzo//3ebel3dhnugWsnfnn9nJqCk/mO0Wn41QAzGAEsD7wSQzF6PY3xAgxYRgcE0fFFqeWEBEw
 kxU1qQWyKNtzqsLXOXr89pvuStASQYu2ovaBLbkg6w8uCdZA+2jmg+qUAO+Zc9xwOX50OflREGX
 1t0hitgsfI4GPVvCremabJKMn5TnalyOt7/SMEgvjBwSLmv/9T/RzSjsKIlYnHIOFpF+ZWraH91
 KPEc/m6H7pErbBCFeEVyff6ixdPJEKyMBdhRd74diaYenSAXI3PrXXAIU4dPnZQhfy8PBDJT7Hr
 c9oX5ymbEsP36ipXyeA7K6W0oaACJ4axUSe2JKAe2FI9DSibT6XbkC
X-Received: by 2002:a17:90b:38d2:b0:38e:2f21:3bb5 with SMTP id
 98e67ed59e1d1-3926237cd78mr2471762a91.21.1786092105768; 
 Fri, 07 Aug 2026 01:41:45 -0700 (PDT)
Received: from colazcyASUSlaptop ([2a09:bac1:76a0:3d0::26b:61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6dfcdsm1594357a91.4.2026.08.07.01.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 01:41:45 -0700 (PDT)
From: Chengyang Zhu <colazcyg@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Chengyang Zhu <colazcyg@gmail.com>
Subject: [PATCH RFC 1/1] ui/dbus: add extensible SetUIInfo2 method
Date: Fri,  7 Aug 2026 16:40:50 +0800
Message-ID: <20260807084050.526109-2-colazcyg@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807084050.526109-1-colazcyg@gmail.com>
References: <20260807084050.526109-1-colazcyg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=colazcyg@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 07 Aug 2026 08:10:51 -0400
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

Currently, the `SetUIInfo` method cannot set a refresh rate.
Simply adding a `refresh_rate` argument would break the method signature.

This patch adds:
  * An extensible `SetUIInfo2` method which takes a dictionary as input.
  * A property `QemuUIInfoTypes`
    which exposes the schema of the `SetUIInfo2` method's argument.

Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>
---
 ui/dbus-console.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml | 17 ++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index e1ac06814b..853a8a4087 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -217,6 +217,40 @@ dbus_console_set_ui_info(DBusDisplayConsole *ddc,
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
+static gboolean
+dbus_console_set_ui_info2(DBusDisplayConsole *ddc,
+                         GDBusMethodInvocation *invocation,
+                         GVariant *arg_ui_info)
+{
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "SetUIInfo2 is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    GVariantDict ui_info_dict;
+    g_variant_dict_init(&ui_info_dict, arg_ui_info);
+
+    QemuUIInfo info = *qemu_console_get_ui_info(ddc->dcl.con);
+
+    g_variant_dict_lookup(&ui_info_dict, "width_mm", "q", &info.width_mm);
+    g_variant_dict_lookup(&ui_info_dict, "height_mm", "q", &info.height_mm);
+    g_variant_dict_lookup(&ui_info_dict, "xoff", "i", &info.xoff);
+    g_variant_dict_lookup(&ui_info_dict, "yoff", "i", &info.yoff);
+    g_variant_dict_lookup(&ui_info_dict, "width", "u", &info.width);
+    g_variant_dict_lookup(&ui_info_dict, "height", "u", &info.height);
+    g_variant_dict_lookup(&ui_info_dict, "refresh_rate",
+                                         "u", &info.refresh_rate);
+
+    g_variant_dict_clear(&ui_info_dict);
+
+    qemu_console_set_ui_info(ddc->dcl.con, &info, false);
+    qemu_dbus_display1_console_complete_set_uiinfo2(ddc->iface, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
 #ifdef G_OS_WIN32
 bool
 dbus_win32_import_socket(GDBusMethodInvocation *invocation,
@@ -538,6 +572,23 @@ QemuConsole *dbus_display_console_get_qemu_console(DBusDisplayConsole *ddc)
     return ddc->dcl.con;
 }
 
+static GVariant *get_qemu_ui_info_types(void)
+{
+    GVariantBuilder builder;
+
+    g_variant_builder_init(&builder, G_VARIANT_TYPE("a{sg}"));
+
+    g_variant_builder_add(&builder, "{sg}", "width_mm", "q");
+    g_variant_builder_add(&builder, "{sg}", "height_mm", "q");
+    g_variant_builder_add(&builder, "{sg}", "xoff", "i");
+    g_variant_builder_add(&builder, "{sg}", "yoff", "i");
+    g_variant_builder_add(&builder, "{sg}", "width", "u");
+    g_variant_builder_add(&builder, "{sg}", "height", "u");
+    g_variant_builder_add(&builder, "{sg}", "refresh_rate", "u");
+
+    return g_variant_builder_end(&builder);
+}
+
 DBusDisplayConsole *
 dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
 {
@@ -575,6 +626,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "width", qemu_console_get_width(con, 0),
         "height", qemu_console_get_height(con, 0),
         "device-address", device_addr,
+        "qemu-uiinfo-types", get_qemu_ui_info_types(),
         "interfaces", interfaces,
         NULL);
     g_object_connect(ddc->iface,
@@ -583,6 +635,10 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "swapped-signal::handle-set-uiinfo",
         dbus_console_set_ui_info, ddc,
         NULL);
+    g_object_connect(ddc->iface,
+        "swapped-signal::handle-set-uiinfo2",
+        dbus_console_set_ui_info2, ddc,
+        NULL);
     g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
         G_DBUS_INTERFACE_SKELETON(ddc->iface));
 
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index d96bae2ed6..aa1816d02c 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -100,6 +100,23 @@
       <arg name="height" type="u" direction="in"/>
     </method>
 
+    <!--
+        QemuUIInfoTypes:
+
+        A D-Bus dictionary which maps the names of QemuUIInfo members to D-Bus type signatures.
+    -->
+    <property name="QemuUIInfoTypes" type="a{sg}" access="read"/>
+
+    <!--
+        SetUIInfo2:
+        @ui_info: the new QemuUIInfo.
+
+        Modify the display settings.
+    -->
+    <method name="SetUIInfo2">
+      <arg name="ui_info" type="a{sv}" direction="in"/>
+    </method>
+
     <!--
         Label:
 
-- 
2.55.0


