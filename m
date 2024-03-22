Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B58C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 03:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnVqj-00068h-JQ; Thu, 21 Mar 2024 23:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rnVqh-00068U-2w
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 23:45:43 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rnVqe-0000Ks-HQ
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 23:45:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dde26f7e1dso12215115ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711079137; x=1711683937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bVljfNtlzmrreaC7yxl9G9ns4R/l5409MaJH1OKGdxc=;
 b=PvrkFXblcQipBZUjznmFJKkpKSKNcF5b/M4+AcAVheOUgtCpxfXnQvsJqB03osHzp0
 BhsD5rsy/8QJ3IyfkQNBHfm1Vk5dBrwEOyJ+7RhDE1+8PHxrN9EK9VZDWyFS4GPIiflz
 u6wtCyGUyoqxJEs8K7jnqnCUdSc2WIAQi3WjylPF4TgWk0pgy2jQ7sVIj/+tRKFqfbMw
 8H+ld2q7Jusshw5RAwa+sKdCSk6WfODbXTA31CwBAF4pV2+W4WYW3lBniE42lCKgAx6b
 YXeX/9st22xv+SS/XMSocSS47/BO9OfJCjZlwfiwBemnVBCKlYPxsdUPPyFTh7d69Muz
 lMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711079137; x=1711683937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVljfNtlzmrreaC7yxl9G9ns4R/l5409MaJH1OKGdxc=;
 b=Zz3hAi2gDdXN4poTGlRJ1RcRjTd0GBJUnlqQ2wbfhPP8Mxu4y3pRmY5/EdRKHPEtoy
 ncYAykOoSTpoiPvGkzgjNPwC3t7iUquikwE6da1qNnUQUT5zWk1gHaeMG+sHm4+kKMDu
 8kR9x17pvgreyLR+dl/RAcCKbPXPazHdLfJZYY/rEL3fBdmQmxb+DSiMJMFdml1JDGJW
 fIRoqEMJa+2TuH0CUthWpz2KaJfxGtDK7r09cI/A7PVOF+Zaqw+C/A7FxRmOW0kxYfeR
 4/vP+FN1JmEaEhxg8JFj0PzKOzhAawWttqHhe0nOs4/uEen5QgYFJTXTJWWLDavJrBy5
 L9tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYO4Vt3iqNzGJipz+m8KjgaQiLoLJwdMziUGldstxZAbS0CX5ml4ce2xAoaQm3/iFMwmhifM4hrv1QQMHbmDb6Yci43Z8=
X-Gm-Message-State: AOJu0YxrOzlP+NmtpxrHq6uuve7d2rtB0h5ZojfXaJq+kzfO0TOEVMEK
 uYiRYUZBRDoPzindfj+Hu9gEzdXHPXGjpAOotitvruEEil8WU1Ep
X-Google-Smtp-Source: AGHT+IHq9h4S1hy00+Z7XhbxjW/8zqw8ddlBvjqDv4bnGtheRwqQ8ePdgLofixkerJLNqyWgizomEw==
X-Received: by 2002:a17:903:2402:b0:1de:e6a9:e94e with SMTP id
 e2-20020a170903240200b001dee6a9e94emr1133231plo.51.1711079137161; 
 Thu, 21 Mar 2024 20:45:37 -0700 (PDT)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ec8400b001da1fae8a73sm707756plg.12.2024.03.21.20.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 20:45:36 -0700 (PDT)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Justinien Bouron <justinien.bouron@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] input-linux: Add option to not grab a device upon guest
 startup
Date: Thu, 21 Mar 2024 20:43:11 -0700
Message-ID: <20240322034311.2980970-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=justinien.bouron@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Depending on your use-case, it might be inconvenient to have qemu grab
the input device from the host immediately upon starting the guest.

Added a new bool option to input-linux: grab-on-startup. If true, the
device is grabbed as soon as the guest is started, otherwise it is not
grabbed until the toggle combination is entered. To avoid breaking
existing setups, the default value of grab-on-startup is true, i.e. same
behaviour as before this change.

Signed-off-by: Justinien Bouron <justinien.bouron@gmail.com>
---

Changes since v1:
    - Revised commit message.
    - Revised grab-on-startup description in qapi/qom.json to comply with
      conventions.

 qapi/qom.json    | 14 +++++++++++++-
 ui/input-linux.c | 20 +++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index baae3a183f..4bcffd265c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -508,13 +508,25 @@
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
+#     both devices will be grabbed.  (default: true).
+#
 # Since: 2.6
 ##
 { 'struct': 'InputLinuxProperties',
   'data': { 'evdev': 'str',
             '*grab_all': 'bool',
             '*repeat': 'bool',
-            '*grab-toggle': 'GrabToggleKeys' } }
+            '*grab-toggle': 'GrabToggleKeys',
+            '*grab-on-startup': 'bool'} }
 
 ##
 # @EventLoopBaseProperties:
diff --git a/ui/input-linux.c b/ui/input-linux.c
index e572a2e905..68b5c6d485 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -44,6 +44,7 @@ struct InputLinux {
     bool        grab_request;
     bool        grab_active;
     bool        grab_all;
+    bool        grab_on_startup;
     bool        keydown[KEY_CNT];
     int         keycount;
     int         wheel;
@@ -400,7 +401,7 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
     if (il->keycount) {
         /* delay grab until all keys are released */
         il->grab_request = true;
-    } else {
+    } else if (il->grab_on_startup) {
         input_linux_toggle_grab(il);
     }
     QTAILQ_INSERT_TAIL(&inputs, il, next);
@@ -491,6 +492,19 @@ static void input_linux_set_grab_toggle(Object *obj, int value,
     il->grab_toggle = value;
 }
 
+static bool input_linux_get_grab_on_startup(Object *obj, Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+    return il->grab_on_startup;
+}
+
+static void input_linux_set_grab_on_startup(Object *obj, bool value,
+                                            Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+    il->grab_on_startup = value;
+}
+
 static void input_linux_instance_init(Object *obj)
 {
 }
@@ -498,6 +512,7 @@ static void input_linux_instance_init(Object *obj)
 static void input_linux_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    ObjectProperty *grab_on_startup_prop;
 
     ucc->complete = input_linux_complete;
 
@@ -514,6 +529,9 @@ static void input_linux_class_init(ObjectClass *oc, void *data)
                                    &GrabToggleKeys_lookup,
                                    input_linux_get_grab_toggle,
                                    input_linux_set_grab_toggle);
+    grab_on_startup_prop = object_class_property_add_bool(oc, "grab-on-startup",
+        input_linux_get_grab_on_startup, input_linux_set_grab_on_startup);
+    object_property_set_default_bool(grab_on_startup_prop, true);
 }
 
 static const TypeInfo input_linux_info = {
-- 
2.43.0


