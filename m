Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FC4C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hg1-0005eO-9Z; Sun, 13 Sep 2026 06:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfy-0005dv-QL
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfw-0008BO-MB
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1kQehvGGYRVKpVI9ygv1umIB6Insz/gldoaKQQkoJE=;
 b=e0+okKjgRITRCHf2WrSUZlfVBk8c6E+Xd1TmB4D/GeM/zJVWdQquOI+5jkmFSHpB20iYMz
 apW1sWm9iPJu0htvmrI66l095TjZDNrJOAcIis8e17P96oVj3hrm34A70WCJKN6g6yq6q+
 mQqd41IU52hMwjZEERwUk5wMDgQ31hU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-UXizevtlMH6ug2ImaAtR6g-1; Sun,
 13 Sep 2026 06:43:06 -0400
X-MC-Unique: UXizevtlMH6ug2ImaAtR6g-1
X-Mimecast-MFC-AGG-ID: UXizevtlMH6ug2ImaAtR6g_1789296185
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34A0518011DB
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:05 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49E121956087; Sun, 13 Sep 2026 10:43:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:23 +0400
Subject: [GIT PULL 05/14] ui/dbus: add org.qemu.Display1.UIInfo interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-5-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9221;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uuMIKhltp7NgwfazxaG9tM38Oiycmen/Gb8pKcNxxCs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4is6ZvFHfnNcbA5UuP5M5o+M8W0VLhr8nTF
 hgWmPBcPD6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5TDSD/4h9yxLu8KdnmKbZz3IJJUwd4SYXwPBhV6alA3ZaAFqODg5YnmEt70n+Ya39K4bbwNN9pY
 HHx4Oh1s6Eqsk6ro6d+lTScVIdZfEfk3RHZqkIEt7RE8iDiJY5/C18aEbKLNQhsauIKZQUVy3i4
 1KpUVvpSiH/MR68/e5Fqr0LLSRRbAqsYKi02ImmB/hUUXFxWBaue1VY/O34rZskr3gWL356dUoz
 KAWNWWFp4LYY+DZq/avKZ/ZYgqeeK8DjfvfCY+P5TzW+T42OYZ5c750zFAdJ92ps+v5qxxm/sFy
 tZ7X3g5hDb5GQqAttHlISTZwPaAhwJJodkVhyKHgl5Hamv2xjly5n5HvJ0uhpwz5YZjFu+87ojS
 36JMRRJ9ARF5txn35wQJli1s5cqRy40RdS/Ey0TBlhrBlXbkWB+KziG7xolpVCegeRDofozYcxH
 uw7DkjoV0rB1Ex5URofsc/McoyoDVPraJ4DCvZJUWKhzrzMIVU8UxaTvUJ6rlHPdBiCzTiR+QcK
 rd97Y3A/siMl+eGmwEMahKy0l3TF6GDre5NDVLQ6Wsm9ZRV9O+Hkv/mc64sV74LEkdHQeBhFNrs
 QbxbFhIKwfG19BIxRX6cRuUvZV4nSqx3qgbb2t5276kN/pzVXf9FOG3G/DwC13VOYObzmsvBmEK
 aug+EVuWBL2gBPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chengyang Zhu <colazcyg@gmail.com>

Currently, the SetUIInfo method cannot set a refresh rate.
Simply adding a refresh_rate argument would break the method signature.

This patch adds the UIInfo interface containing
  * property `Supported` indicating whether console UI info is supported.
  * the method `Apply` taking a dictionary as input.
  * the method `Get` returning the current UI info as a dictionary.

Message-ID: <20260830054641.45437-2-colazcyg@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>
---
 ui/dbus-console.c    | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml |  55 ++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index e1ac06814ba8..947c3b3a545e 100644
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
@@ -528,6 +531,98 @@ dbus_mouse_mode_change(Notifier *notify, void *data)
     dbus_mouse_update_is_absolute(ddc);
 }
 
+static gboolean
+dbus_ui_info_get(DBusDisplayConsole *ddc,
+                 GDBusMethodInvocation *invocation)
+{
+    QemuUIInfo ui_info;
+    GVariantDict dict;
+
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "UIInfo is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    ui_info = *qemu_console_get_ui_info(ddc->dcl.con);
+    g_variant_dict_init(&dict, NULL);
+
+    g_variant_dict_insert(&dict, "width_mm", "q", ui_info.width_mm);
+    g_variant_dict_insert(&dict, "height_mm", "q", ui_info.height_mm);
+    g_variant_dict_insert(&dict, "xoff", "i", ui_info.xoff);
+    g_variant_dict_insert(&dict, "yoff", "i", ui_info.yoff);
+    g_variant_dict_insert(&dict, "width", "u", ui_info.width);
+    g_variant_dict_insert(&dict, "height", "u", ui_info.height);
+    g_variant_dict_insert(&dict, "refresh_rate", "u", ui_info.refresh_rate);
+
+    qemu_dbus_display1_uiinfo_complete_get(ddc->iface_ui_info, invocation,
+                                           g_variant_dict_end(&dict));
+
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static bool
+dbus_ui_info_apply_lookup(GDBusMethodInvocation *invocation,
+                          GVariantDict *dict,
+                          const gchar *key,
+                          const gchar *fmt_str,
+                          void *res)
+{
+    if (g_variant_dict_contains(dict, key) &&
+        !g_variant_dict_lookup(dict, key, fmt_str, res)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_INVALID,
+                                              "%s must have D-Bus signature %s",
+                                              key, fmt_str);
+        return false;
+    }
+    return true;
+}
+
+static gboolean
+dbus_ui_info_apply(DBusDisplayConsole *ddc,
+                   GDBusMethodInvocation *invocation,
+                   GVariant *arg_ui_info)
+{
+    QemuUIInfo ui_info;
+    g_auto(GVariantDict) dict = G_VARIANT_DICT_INIT(arg_ui_info);
+
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "UIInfo is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    ui_info = *qemu_console_get_ui_info(ddc->dcl.con);
+
+    if (!dbus_ui_info_apply_lookup(invocation, &dict, "width_mm", "q",
+                                   &ui_info.width_mm) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "height_mm", "q",
+                                   &ui_info.height_mm) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "xoff", "i",
+                                   &ui_info.xoff) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "yoff", "i",
+                                   &ui_info.yoff) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "width", "u",
+                                   &ui_info.width) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "height", "u",
+                                   &ui_info.height) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "refresh_rate", "u",
+                                   &ui_info.refresh_rate)) {
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
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
@@ -550,6 +645,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "org.qemu.Display1.Keyboard",
         "org.qemu.Display1.Mouse",
         "org.qemu.Display1.MultiTouch",
+        "org.qemu.Display1.UIInfo",
         NULL
     };
 
@@ -626,5 +722,15 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
     qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     dbus_mouse_update_is_absolute(ddc);
 
+    ddc->iface_ui_info = qemu_dbus_display1_uiinfo_skeleton_new();
+    qemu_dbus_display1_uiinfo_set_supported(ddc->iface_ui_info,
+        qemu_console_ui_info_supported(ddc->dcl.con));
+    g_object_connect(ddc->iface_ui_info,
+        "swapped-signal::handle-get", dbus_ui_info_get, ddc,
+        "swapped-signal::handle-apply", dbus_ui_info_apply, ddc,
+        NULL);
+    g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
+        G_DBUS_INTERFACE_SKELETON(ddc->iface_ui_info));
+
     return ddc;
 }
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index d96bae2ed642..a23ca0b8b125 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -90,6 +90,10 @@
         @height: console height, in pixels.
 
         Modify the dimensions and display settings.
+
+        .. seealso::
+
+           :dbus:iface:`org.qemu.Display1.UIInfo` which supports a superset of these properties.
     -->
     <method name="SetUIInfo">
       <arg name="width_mm" type="q" direction="in"/>
@@ -1159,4 +1163,55 @@
     -->
     <property name="Encoding" type="s" access="read"/>
   </interface>
+
+  <!--
+      org.qemu.Display1.UIInfo:
+
+      This interface is implemented on
+      ``/org/qemu/Display1/Console_$id`` (see
+      :dbus:iface:`~org.qemu.Display1.Console`).
+  -->
+  <interface name="org.qemu.Display1.UIInfo">
+    <!--
+        Supported:
+
+        Whether console UI info is supported.
+    -->
+    <property name="Supported" type="b" access="read"/>
+
+    <!--
+        Get:
+        @ui_info: a dictionary of UI info properties.
+
+        Return the currently requested properties for the console.
+        The list of returned properties may vary and be extended in the future.
+
+        - ``width_mm`` (q): the physical display width in millimeters.
+        - ``height_mm`` (q): the physical display height in millimeters.
+        - ``xoff`` (i): the horizontal offset in pixels.
+        - ``yoff`` (i): the vertical offset in pixels.
+        - ``width`` (u): the console width in pixels.
+        - ``height`` (u): the console height in pixels.
+        - ``refresh_rate`` (u): the display refresh rate in millihertz.
+    -->
+    <method name="Get">
+      <arg name="ui_info" type="a{sv}" direction="out"/>
+    </method>
+
+    <!--
+        Apply:
+        @ui_info: a dictionary of new UI info properties.
+
+        Apply the properties to the console display.
+        The dictionary schema of ``Apply`` is a subset of that of ``Get``.
+
+        The properties will be merged with existing values.
+        Extra keys will be ignored.
+        The invocation will fail if any key has the wrong type,
+        leaving the UI info unchanged.
+    -->
+    <method name="Apply">
+      <arg name="ui_info" type="a{sv}" direction="in"/>
+    </method>
+  </interface>
 </node>

-- 
2.55.0.543.g5ebe2ebe4ea8


