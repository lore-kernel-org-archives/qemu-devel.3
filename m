Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E315DCD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 05:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrtX5-00084E-Cs; Wed, 03 Apr 2024 01:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rrtX4-000844-Eq
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:51:34 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rrtX2-0005oY-QY
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 01:51:34 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so3660196a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712123491; x=1712728291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WbyTwD1JMG3Dr7ly64VVXatRedqaR/rWik/cD9AEyak=;
 b=gduz9jvMZx+05ET++zR2yo8XIQlo0Mpf3F8eIE6+i4jO3tETpRSqQV6DJ91hn3yhtm
 1v9ZMC1+ILnYq001IRWxsvWzsX1oJQK/z32bHrctB9QL4jmDLcXPin/LfJUFKPGSkA6o
 6Au0jRVZnwC/+qVZplskdh/akDlSdNdFufS/xCgqADZKk+FwFKCwrTEZRESIth8wOIiO
 I/C7yIk67ktFFBfyzU1Murd2jWJd/oMTgy7NTfZBap3SsGh9gt5HqGW6D6V6pje1dW/T
 /DdSv8yfY4hQLjS4dXjYGy+YflQJ0DNU5IOdzuCRtK6WNZyhS80TMDiHibTpfEquAsNr
 ivmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712123491; x=1712728291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WbyTwD1JMG3Dr7ly64VVXatRedqaR/rWik/cD9AEyak=;
 b=BOLjN1phSW3XHu2pZBbujY2P/606XeqL0fIzPM6OzivO8e27jVrfj2+sj9ps6BYBvL
 /IIDNzHl/KBXfyD8vBI6kaH+YyGwp2UUVOcadIjh13cWMQopjYghHNtYmPhljnMQsX+s
 7Kc3HmMJvWjcLfE0vo3i5Tzwiy0X67YVDDmspFEZI5D8WX2lwNfOgE6h+PWP5TRRLNqG
 EUCotzZoSHH32+5azBeleLfKX0G49p8ZQeZdspUAlCO7/PXuKcFBSswgvLlwOtf+OH/+
 xR4KFCA28BBtpmHFUhM45eYcTQDUIy4jk2oKz6TaOmarL52nyp0eImpjSINo5EKEzRkr
 Nh7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzgDASSBy52Wx3Bra0c9QKGLoLImbHnyrVKYkeej2q6pL1tJtNNAs+nFaNfoKBFEsrBl/t79YGnjD7PTcuuQcIUQiLQRA=
X-Gm-Message-State: AOJu0Yx7ZW+3LYHoa0FHEG8Phuk5vFQc/fARHnJA8f3rIZE4ZwtWLsA0
 l/cAmIpHS+AsoEBZVvdZFfahLa0A+xdFywjeU2S+zZXOx6Qg3V9t
X-Google-Smtp-Source: AGHT+IFB7MNSz1B1x01y/fJWjlbzHCe5SR2NHrwxIYtyAGQ1mkU40yDHNGT4jgcfTVXjzP0lDXbCnw==
X-Received: by 2002:a05:6a21:3294:b0:1a6:f914:891d with SMTP id
 yt20-20020a056a21329400b001a6f914891dmr2389890pzb.3.1712123491175; 
 Tue, 02 Apr 2024 22:51:31 -0700 (PDT)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 u13-20020a17090a890d00b002a056551c1dsm10754124pjn.6.2024.04.02.22.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 22:51:30 -0700 (PDT)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Justinien Bouron <justinien.bouron@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3] input-linux: Add option to not grab a device upon guest
 startup
Date: Tue,  2 Apr 2024 22:50:02 -0700
Message-ID: <20240403055002.890760-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=justinien.bouron@gmail.com; helo=mail-pg1-x52f.google.com
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

Changes since v2:
    - Added missing (since 9.1) to the new option in qapi/qom.json

 qapi/qom.json    | 14 +++++++++++++-
 ui/input-linux.c | 20 +++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 85e6b4f84a..2067e41991 100644
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
+#     both devices will be grabbed.  (default: true)  (since 9.1).
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
2.44.0


