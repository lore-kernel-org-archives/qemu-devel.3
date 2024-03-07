Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74F3C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riEKb-00084f-Qj; Thu, 07 Mar 2024 09:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1ri7Hw-0007n1-Ub
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:31:32 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1ri7Hv-0007qJ-4e
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:31:32 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso391028b3a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709793089; x=1710397889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iyxR+OpRzCgMTyr69jyOIljZ6vwQoblG0/7Lpey7Y8k=;
 b=jezloXzoe+7V7xeElEKeD75Q5P/M/yh3rn9Wr1Bam/T59P+c8Vj/gtMgry8fn2xFvR
 MN1wL567ljpoVfJtpG7U2eObDh597/oJaKRepLd56Hn76szjKw96C8oRGLkDatdtIDe6
 gsnmyXmdG/XkcMSZgkzhKeOvMOQ5OpNwy+B5mRB7eoJlzXYSYwbDtBSSktosSodw6tHH
 sGU5XRgpVsTU6kyVCabJ2JIvWdlgMTwPKPSwNYXkHYHOgQe0az6lmIbGSTFlPmf5P95T
 eD5HLJIY2mAi5yNUtULIj9u88lvhWzhUvkQ7VlRzbrPMM9F4Bb9T+FdgpUE3KeJuRG6T
 cOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709793089; x=1710397889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iyxR+OpRzCgMTyr69jyOIljZ6vwQoblG0/7Lpey7Y8k=;
 b=nQtfE95RnvpZ1xXi09lTpFxgmxAC0wAdanS7c1qUXUQUwXqQS5wLakjXoYVchyHW7X
 5Emf7GcwzJmYq2nAM9sbzt3Wm9p4vJ0dm7NHtvddnxfIs2Wu0LgVEKAMvfteBRwU8rJf
 GvCae8FNkqYB9g3Zn7Whe7gRzx9OBVIT47nplSQOobRfI1BYqGX3lWxuYkk8hH9e9ebC
 R7scvO4d8+CIIeDUmCuEqpU5eQMlwvyMRnC/H3W3CGthpnNsdKA1pnE6HA/aqF8nEc5/
 482Rgkg43BuHyRg080lMZqwRu1G3bSZRz72gFnFHcl1DKMu32OMQlaaujFy/q2vOlrD5
 oZ6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8wmlPftICNJUM1nn2oigbcqIEofpRhdjHiniKs6UkeWWZ1KOhnnVcuoO3SEiOJ3VY0J0TH9gqh5VYENvJH+CUbqlmaSo=
X-Gm-Message-State: AOJu0YxUyKGlnyTAlBjf98ZAs0kN+pp/m341TdgG2If2p35/pXknLfzZ
 4z33cJVwk07T+6I0zDLiWpyZ8QQPeCW//gA+ULGPmUYDX5A454cT
X-Google-Smtp-Source: AGHT+IHOSHoVkxGGJ/afxQ+Ux1zuq/xc1DFYvgtHTlH84qdu6Lt9mPuue8RocXPSKaVQaIoCMMm7wg==
X-Received: by 2002:a05:6a20:af87:b0:1a1:4487:ee25 with SMTP id
 ds7-20020a056a20af8700b001a14487ee25mr6015172pzb.49.1709793089063; 
 Wed, 06 Mar 2024 22:31:29 -0800 (PST)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 m7-20020aa78a07000000b006e319d8c752sm11778013pfa.150.2024.03.06.22.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 22:31:28 -0800 (PST)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Justinien Bouron <justinien.bouron@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] input-linux: Add option to not grab a device upon guest
 startup
Date: Wed,  6 Mar 2024 22:28:22 -0800
Message-ID: <20240307062823.2377318-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=justinien.bouron@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 Mar 2024 09:02:44 -0500
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
the input device immediately upon starting the guest, especially if the
guest takes a while to start in which case it may take a few seconds
before being able to release the device via the toggle combination.

Added a new bool option to input-linux: grab-on-startup. If true, the
device is grabbed as soon as the guest is started, otherwise it is not
grabbed until the toggle combination is entered. To avoid breaking
existing setups, the default value of grab-on-startup is true, ie. same
behaviour as before this change.

Signed-off-by: Justinien Bouron <justinien.bouron@gmail.com>
---
 qapi/qom.json    | 13 ++++++++++++-
 ui/input-linux.c | 20 +++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 032c6fa037..50e66d55cc 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -508,13 +508,24 @@
 # @grab-toggle: the key or key combination that toggles device grab
 #     (default: ctrl-ctrl)
 #
+# @grab-on-startup: if true, grab the device immediately upon starting the
+#     guest. Otherwise, don't grab the device until the combination is entered.
+#     This does not influence other devices even if grab_all is true, ie. in the
+#     unlikely scenario where device1 has grab_all=true + grab-on-startup=true
+#     and device2 has grab-on-startup=false, only device1 is grabbed on startup,
+#     then, once the grab combination is entered, grabbing is toggled off for
+#     both devices (because device1 enforces the grab_all property) until the
+#     combination is entered again at which point both devices will be grabbed.
+#     (default: true).
+
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
index e572a2e905..cf9376ddb0 100644
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


