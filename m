Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BC4C30658
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiJx-0005hK-2O; Thu, 27 Jun 2024 02:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJu-0005fO-Er
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:09:22 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJs-0003kG-Qv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:09:22 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d561d685e7so910881b6e.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719468559; x=1720073359;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0VSYKVQCF4c9EWbUkbZPOSynuO1Ww6rZL2afZDm8mb0=;
 b=irLZ/xYtoMe/0O/Il4yssRobLUdLGV2nWS+dmWnGmN2zv/NgRb4MwtAGEbhA8uMol5
 Xf9uA/XQ6fnmy9Hmgo9T1mAx2H7YoHxRgc8PoycMLXwR6PhMm+DdXoTAtMIFpDPOcOHu
 vj7taG14V7c7BZVSCnugZ+XGq0JZq9DOU0xuBzDXM3pnsfC2Rj+4IWhM253kPnf9vM/d
 LR8jqy+4uLlZvcSdMAs4W9BzJLFHUieyi9S0Rgu8m8tQptycIkJmMZSvzEjEgYo7jbwM
 hcTHf4WGpO15+JEcX6+u+31UOhE1o0ASClMY6Gwkm8kmSCGD5DdBa97LmLDmgsVX51Co
 rkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468559; x=1720073359;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VSYKVQCF4c9EWbUkbZPOSynuO1Ww6rZL2afZDm8mb0=;
 b=Jz48RQho/+qTypHvZjuxPbBzSbLHCu61AHqar7LUO/YM1S+yXsKTBMqtTxINb3aOiZ
 m5cBCtTOgVthtEcbN6r3+a6s83qnx3oqJ4JJ3LWAxwk6dDP3SkvJsli3ttZ7udeaIRCk
 wKbzWICOSh2oSxz5pm92LXPcwrwn6zLk7nUuwgsSYSVLjubJ4xdIW8hM8T8b845Bfahu
 1XYEj7QMTYAVnZkYBZa2B/T0MjZCOHNF0T0+pm1GOdODl+mePPn98CwLidgkfwkGnhf4
 iN8Z4vJaszsBQvyHoHkPhibPg8KV1NJhQTH/unhbiN2tezug4uUW0vjiioBwYI1MbxtI
 uk6g==
X-Gm-Message-State: AOJu0YwrxLQtzHiYGZYFYb2BLg04O0tEy7RU8jx886ieKzpSEfAFeFqR
 CRCRfqhlZZtig9UuOeZ4Vs9I3n5cxg8gYWnxzPMeSl4iHZf7IxzTaG0gGV/WsW4=
X-Google-Smtp-Source: AGHT+IEeQY+jsXzOPIdCnxY1tErK2YCzaKS6CHxT6+8fsnHv+js7MzGaDJkAVsZ7lo86ns+jMWFUlQ==
X-Received: by 2002:a05:6808:3089:b0:3d6:2b12:7dc0 with SMTP id
 5614622812f47-3d62b127f21mr315710b6e.20.1719468558621; 
 Wed, 26 Jun 2024 23:09:18 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706b4a5889bsm494556b3a.188.2024.06.26.23.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:09:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 15:08:01 +0900
Subject: [PATCH v10 12/12] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240627-reuse-v10-12-7ca0b8ed3d9f@daynix.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
In-Reply-To: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


