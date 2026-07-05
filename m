Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86142C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 20:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgTEJ-0003HQ-1a; Sun, 05 Jul 2026 16:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kernel@0in.de>) id 1wgSfZ-0006Gw-Fo
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 15:38:25 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <kernel@0in.de>) id 1wgSfW-0006Oa-QC
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 15:38:25 -0400
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gtd7p3pDtz9tFN;
 Sun,  5 Jul 2026 21:38:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0in.de; s=MBO0001;
 t=1783280294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WlDpGJfEd3561hSi+Tj5FsRGcIYOmaKgBglzaimXtpU=;
 b=pJPTt2DiC81LNShq+5Y3wG2fnjxdexiNTv7ulCjGS6na6yvy1GO005rlrJvaSpUfhInOa/
 we21us+TrPICW7SXtMIi00OzGuGWLWLQKm9NP6402mJ6MmPZxvcwhXvZgJ0PjRc6w2UnrO
 6+6tZcc2TcL3602fe2qF/zXbrWuwgZtKUgbuivgRzfuNEO1rJ4faFkBclCzBVmOwykc/2p
 6fXzqa1gzIGwfYLQqq1eGG6b6FA/WriXYMbU60DPRAvO2GgBHt53Xp9rEiO1fUR98N8SM8
 4pzO2yIV9kzFJklXRvy5dRhpTSZUwNvPYQdZHe52CI28UM2KVeKGts/TwkIXzw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of kernel@0in.de designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@0in.de
Content-Type: multipart/alternative;
 boundary="------------I1ODxRa0pzNNen8IKwgIi4DM"
Message-ID: <3cb937dc-db7e-4e87-ab46-3a7ba754ef55@0in.de>
Date: Sun, 5 Jul 2026 21:38:10 +0200
MIME-Version: 1.0
From: Maximilian Senftleben <kernel@0in.de>
Subject: [PATCH v4] input-linux: Add option to not grab a device upon guest
 startup
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Justinien Bouron <justinien.bouron@gmail.com>
Content-Language: en-US
X-Rspamd-Queue-Id: 4gtd7p3pDtz9tFN
Received-SPF: pass client-ip=80.241.56.172; envelope-from=kernel@0in.de;
 helo=mout-p-202.mailbox.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 05 Jul 2026 16:14:17 -0400
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

This is a multi-part message in MIME format.
--------------I1ODxRa0pzNNen8IKwgIi4DM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Some workflows start a guest in the background and do not want evdev
devices to be grabbed immediately.  In that case, the current behavior
is annoying because the host loses control of the keyboard or mouse
before the user actually wants to interact with the guest.

Add a new boolean input-linux property, grab-on-startup.  When true,
the device is grabbed during initialization, which keeps the existing
behavior.  When false, the device remains ungrabbed until the toggle
key combination is entered.

Also make sure startup grabbing is skipped entirely when
grab-on-startup is false, even if keys are already pressed during
device initialization.  Without this, QEMU could still perform a delayed
grab once those keys are released.

This revives an earlier patch originally posted by Justinien Bouron and
incorporates the follow-up review feedback.

Link:https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/
Link:https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html
Signed-off-by: Maximilian Senftleben YOUR NAME <YOUR EMAIL>
---
This revives Justinien Bouron's earlier input-linux grab-on-startup
patch:

      https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/

Last known review state:
- Marc-Andre Lureau asked for a resend with an updated commit message:
      https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04003.html
- Markus Armbruster reviewed the QAPI schema and pointed out that the
      delayed-grab path still needed to be skipped when keys are already
      pressed at startup and grab-on-startup is false:
      https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html
- Daniel P. Berrange asked for a clearer motivation for the feature:
      https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg01969.html

Changes since v3:
- Skip startup grabbing entirely when grab-on-startup is false, even if
   keys are already pressed during initialization
- Refresh the commit message to clarify the motivation for the option
- Keep the QAPI documentation formatting requested in prior review and
   update the since tag for the current development cycle

  qapi/qom.json    | 14 +++++++++++++-
  ui/input-linux.c | 27 +++++++++++++++++++++++++++
  2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..e3eda5c1ec 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -558,13 +558,25 @@
  # @grab-toggle: the key or key combination that toggles device grab
  #     (default: ctrl-ctrl)
  #
+# @grab-on-startup: if true, grab the device immediately upon starting
+#     the guest.  Otherwise, don't grab the device until the
+#     combination is entered.  This does not influence other devices
+#     even if grab_all is true, i.e. in the unlikely scenario where
+#     device1 has grab_all=true + grab-on-startup=true and device2 has
+#     grab-on-startup=false, only device1 is grabbed on startup, then,
+#     once the grab combination is entered, grabbing is toggled off
+#     for both devices (because device1 enforces the grab_all
+#     property) until the combination is entered again at which point
+#     both devices will be grabbed.  (default: true)  (since 11.1).
+#
  # Since: 2.6
  ##
  { 'struct': 'InputLinuxProperties',
    'data': { 'evdev': 'str',
              '*grab_all': 'bool',
              '*repeat': 'bool',
-            '*grab-toggle': 'GrabToggleKeys' },
+            '*grab-toggle': 'GrabToggleKeys',
+            '*grab-on-startup': 'bool' },
    'if': 'CONFIG_LINUX' }
  
  ##
diff --git a/ui/input-linux.c b/ui/input-linux.c
index f4eee1ffd7..767374e99a 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -43,6 +43,7 @@ struct InputLinux {
      bool        grab_request;
      bool        grab_active;
      bool        grab_all;
+    bool        grab_on_startup;
      bool        keydown[KEY_CNT];
      int         keycount;
      int         wheel;
@@ -394,12 +395,17 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
      }
  
      qemu_set_fd_handler(il->fd, input_linux_event, NULL, il);
+    if (!il->grab_on_startup) {
+        goto skip_grab;
+    }
      if (il->keycount) {
          /* delay grab until all keys are released */
          il->grab_request = true;
      } else {
          input_linux_toggle_grab(il);
      }
+
+skip_grab:
      QTAILQ_INSERT_TAIL(&inputs, il, next);
      il->initialized = true;
      return;
@@ -487,6 +493,21 @@ static void input_linux_set_grab_toggle(Object *obj, int value,
      il->grab_toggle = value;
  }
  
+static bool input_linux_get_grab_on_startup(Object *obj, Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+
+    return il->grab_on_startup;
+}
+
+static void input_linux_set_grab_on_startup(Object *obj, bool value,
+                                            Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+
+    il->grab_on_startup = value;
+}
+
  static void input_linux_instance_init(Object *obj)
  {
  }
@@ -494,6 +515,7 @@ static void input_linux_instance_init(Object *obj)
  static void input_linux_class_init(ObjectClass *oc, const void *data)
  {
      UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    ObjectProperty *grab_on_startup_prop;
  
      ucc->complete = input_linux_complete;
  
@@ -510,6 +532,11 @@ static void input_linux_class_init(ObjectClass *oc, const void *data)
                                     &GrabToggleKeys_lookup,
                                     input_linux_get_grab_toggle,
                                     input_linux_set_grab_toggle);
+    grab_on_startup_prop = object_class_property_add_bool(
+        oc, "grab-on-startup",
+        input_linux_get_grab_on_startup,
+        input_linux_set_grab_on_startup);
+    object_property_set_default_bool(grab_on_startup_prop, true);
  }
  
  static const TypeInfo input_linux_info = {
-- 2.53.0

--------------I1ODxRa0pzNNen8IKwgIi4DM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-text-plain" wrap="true"
      style="font-family: -moz-fixed; font-size: 12px;" lang="x-unicode">
      <pre wrap="" class="moz-quote-pre">Some workflows start a guest in the background and do not want evdev
devices to be grabbed immediately.  In that case, the current behavior
is annoying because the host loses control of the keyboard or mouse
before the user actually wants to interact with the guest.

Add a new boolean input-linux property, grab-on-startup.  When true,
the device is grabbed during initialization, which keeps the existing
behavior.  When false, the device remains ungrabbed until the toggle
key combination is entered.

Also make sure startup grabbing is skipped entirely when
grab-on-startup is false, even if keys are already pressed during
device initialization.  Without this, QEMU could still perform a delayed
grab once those keys are released.

This revives an earlier patch originally posted by Justinien Bouron and
incorporates the follow-up review feedback.

Link: <a class="moz-txt-link-freetext"
href="https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/">https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/</a>
Link: <a class="moz-txt-link-freetext"
href="https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html">https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html</a>
Signed-off-by: Maximilian Senftleben YOUR NAME &lt;YOUR EMAIL&gt;
---
This revives Justinien Bouron's earlier input-linux grab-on-startup
patch:

     <a class="moz-txt-link-freetext" href="https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/">https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/</a>

Last known review state:
- Marc-Andre Lureau asked for a resend with an updated commit message:
     <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04003.html">https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04003.html</a>
- Markus Armbruster reviewed the QAPI schema and pointed out that the
     delayed-grab path still needed to be skipped when keys are already
     pressed at startup and grab-on-startup is false:
     <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html">https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html</a>
- Daniel P. Berrange asked for a clearer motivation for the feature:
     <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg01969.html">https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg01969.html</a>

Changes since v3:
- Skip startup grabbing entirely when grab-on-startup is false, even if
  keys are already pressed during initialization
- Refresh the commit message to clarify the motivation for the option
- Keep the QAPI documentation formatting requested in prior review and
  update the since tag for the current development cycle

 qapi/qom.json    | 14 +++++++++++++-
 ui/input-linux.c | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..e3eda5c1ec 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -558,13 +558,25 @@
 # @grab-toggle: the key or key combination that toggles device grab
 #     (default: ctrl-ctrl)
 #
+# @grab-on-startup: if true, grab the device immediately upon starting
+#     the guest.  Otherwise, don't grab the device until the
+#     combination is entered.  This does not influence other devices
+#     even if grab_all is true, i.e. in the unlikely scenario where
+#     device1 has grab_all=true + grab-on-startup=true and device2 has
+#     grab-on-startup=false, only device1 is grabbed on startup, then,
+#     once the grab combination is entered, grabbing is toggled off
+#     for both devices (because device1 enforces the grab_all
+#     property) until the combination is entered again at which point
+#     both devices will be grabbed.  (default: true)  (since 11.1).
+#
 # Since: 2.6
 ##
 { 'struct': 'InputLinuxProperties',
   'data': { 'evdev': 'str',
             '*grab_all': 'bool',
             '*repeat': 'bool',
-            '*grab-toggle': 'GrabToggleKeys' },
+            '*grab-toggle': 'GrabToggleKeys',
+            '*grab-on-startup': 'bool' },
   'if': 'CONFIG_LINUX' }
 
 ##
diff --git a/ui/input-linux.c b/ui/input-linux.c
index f4eee1ffd7..767374e99a 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -43,6 +43,7 @@ struct InputLinux {
     bool        grab_request;
     bool        grab_active;
     bool        grab_all;
+    bool        grab_on_startup;
     bool        keydown[KEY_CNT];
     int         keycount;
     int         wheel;
@@ -394,12 +395,17 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
     }
 
     qemu_set_fd_handler(il-&gt;fd, input_linux_event, NULL, il);
+    if (!il-&gt;grab_on_startup) {
+        goto skip_grab;
+    }
     if (il-&gt;keycount) {
         /* delay grab until all keys are released */
         il-&gt;grab_request = true;
     } else {
         input_linux_toggle_grab(il);
     }
+
+skip_grab:
     QTAILQ_INSERT_TAIL(&amp;inputs, il, next);
     il-&gt;initialized = true;
     return;
@@ -487,6 +493,21 @@ static void input_linux_set_grab_toggle(Object *obj, int value,
     il-&gt;grab_toggle = value;
 }
 
+static bool input_linux_get_grab_on_startup(Object *obj, Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+
+    return il-&gt;grab_on_startup;
+}
+
+static void input_linux_set_grab_on_startup(Object *obj, bool value,
+                                            Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+
+    il-&gt;grab_on_startup = value;
+}
+
 static void input_linux_instance_init(Object *obj)
 {
 }
@@ -494,6 +515,7 @@ static void input_linux_instance_init(Object *obj)
 static void input_linux_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    ObjectProperty *grab_on_startup_prop;
 
     ucc-&gt;complete = input_linux_complete;
 
@@ -510,6 +532,11 @@ static void input_linux_class_init(ObjectClass *oc, const void *data)
                                    &amp;GrabToggleKeys_lookup,
                                    input_linux_get_grab_toggle,
                                    input_linux_set_grab_toggle);
+    grab_on_startup_prop = object_class_property_add_bool(
+        oc, "grab-on-startup",
+        input_linux_get_grab_on_startup,
+        input_linux_set_grab_on_startup);
+    object_property_set_default_bool(grab_on_startup_prop, true);
 }
 
 static const TypeInfo input_linux_info = {
<div class="moz-txt-sig">-- 
2.53.0
</div></pre>
    </div>
  </body>
</html>

--------------I1ODxRa0pzNNen8IKwgIi4DM--

