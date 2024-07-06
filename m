Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C5C38150
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 09:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ1ju-0000A6-F9; Sat, 06 Jul 2024 05:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1js-00005g-68
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:29:52 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1jq-0006qL-PF
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:29:51 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d84546a05bso1255018b6e.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720258188; x=1720862988;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0VSYKVQCF4c9EWbUkbZPOSynuO1Ww6rZL2afZDm8mb0=;
 b=rYOZpOlY1s1RJ3rM5v/l5RQuhu6qwSesIPp+QA9dGkGXX0BVcM5+7bCrbsc+QqZ+Gu
 pGCRp0hnw9ZdHv6MNoAvzWcFOWQYGf2iQxqsYkTvN/guB8TtyP98aF37E5aHOan8liZ/
 iAtQHfZD6EQyyRGoG0UEZq2F3AD3rfRLZPOIE0okpUTfhfBpzD4Iyl3d1werkb5EouEr
 TWWV71o2PNuHzRWIVyudIC5BpWIRDvWCrVOq3DJUuYl1gBCsuEwagdI9ls7N4qBE39lg
 GwemISAXPE8sliO41gS9CcU7uZDuraf/M7UbgXpmtNP7C24vzvTZWgTxaVJOestD9GC9
 ddUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720258188; x=1720862988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VSYKVQCF4c9EWbUkbZPOSynuO1Ww6rZL2afZDm8mb0=;
 b=v5TphcjcXpasWOdUS/oJefZUQP7+9bZTrHY0OeRaIS2cO1NgjVkXdPIm9TcdK8i1N8
 U0OhpR7BxIZMlCXKMEPh6NS1V+eOqqesnM09nBkOCbztT5Vl4C95k2J3Tg0lvrijNBDl
 8QRqCTmRy8sZXA7YHrhO+npN4lhhsgD0FBBf0i8UldLGU2PDYFr1/ha4rlZAMevJS7Ud
 E1gEg35Z9/hil1aJzW8TmZZ9d74z+ChAlJPu0IM4gq8kpgUto0LgXj6appndbfZaTp9l
 xJdlB52MdADyCHJhuWauuGevLgIajWPqG/Uqa162eBRXKxAZfymiVo85QhKQw+W3I5KL
 aw1g==
X-Gm-Message-State: AOJu0YwTsy5TVS/0O6YHHVlf0uFAJG0TwWE06DKzG0mY8MWrDPbuOAgh
 XSVBBgwg9IuCXXjJ/CP/42gZqaJfPKg9WmCca6j6GaMUVO0SlXKenwhkEy8f+LY=
X-Google-Smtp-Source: AGHT+IGB+EQlGz0ilMTKvabnps6LeG4zVWHm59SVK/fv5Eab3qpVTNNrIDwe+aHjtVkCrYk1VyjumQ==
X-Received: by 2002:a05:6808:144b:b0:3d5:5e73:1645 with SMTP id
 5614622812f47-3d914b7899bmr9378745b6e.0.1720258188183; 
 Sat, 06 Jul 2024 02:29:48 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70803ecf9d0sm15394737b3a.115.2024.07.06.02.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jul 2024 02:29:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 06 Jul 2024 18:29:24 +0900
Subject: [PATCH 4/4] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240706-rombar-v1-4-802daef2aec1@daynix.com>
References: <20240706-rombar-v1-0-802daef2aec1@daynix.com>
In-Reply-To: <20240706-rombar-v1-0-802daef2aec1@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-core.h |  4 ----
 hw/core/qdev.c         |  1 -
 system/qdev-monitor.c  | 12 +++++++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5336728a23f6..40f2d185f17c 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -237,10 +237,6 @@ struct DeviceState {
      * @pending_deleted_expires_ms: optional timeout for deletion events
      */
     int64_t pending_deleted_expires_ms;
-    /**
-     * @opts: QDict of options for the device
-     */
-    QDict *opts;
     /**
      * @hotplugged: was device added after PHASE_MACHINE_READY?
      */
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f3a996f57dee..2fc84699d432 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6af6ef7d667f..3551989d5153 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -624,6 +624,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -705,13 +706,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     /* set properties */
-    dev->opts = qdict_clone_shallow(opts);
-    qdict_del(dev->opts, "driver");
-    qdict_del(dev->opts, "bus");
-    qdict_del(dev->opts, "id");
+    properties = qdict_clone_shallow(opts);
+    qdict_del(properties, "driver");
+    qdict_del(properties, "bus");
+    qdict_del(properties, "id");
 
-    object_set_properties_from_keyval(&dev->parent_obj, dev->opts, from_json,
+    object_set_properties_from_keyval(&dev->parent_obj, properties, from_json,
                                       errp);
+    qobject_unref(properties);
     if (*errp) {
         goto err_del_dev;
     }

-- 
2.45.2


