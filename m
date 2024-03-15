Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B35C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 04:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkyie-0003AU-V6; Thu, 14 Mar 2024 23:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyib-00033M-Sc
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:53 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyiY-0002Ao-3r
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6b54a28d0so1465647b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 20:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710475127; x=1711079927;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H7E9EG3dQmBUyTgcienZoEqzuD43Z4lt38iAA+Vg5x8=;
 b=s7B5hDwZOSTh5sJF8xG0kWX9SllzSvH99xMXeYB+JTcudGgC16kTTOhwV+ljh//F3I
 fmn6+r8FS4Ze6wzi5Wt1nQlkMLqtjvkX8mlcEGCaPOqQTJIRcnOJIcKx6b/koOcbNdka
 /2iWITcRAPL1BH247GQnyN2eS7X77NujoyHuyivXM2gHmFm2Um09GijIiuXZMkUKuX1w
 UUBVMKQegjzOAMtT1uoAnrjMmEPeTUDabpsEIHD7ZzpHsPB9/1G3cDgYQJAfnrl0VaR4
 hfe8utVAx0g2EJ35HRI5SGja4H32EOCKEcHWdozQ9wYVF9ndyPuGN6faSMIzmbxzTsHe
 EtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475127; x=1711079927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7E9EG3dQmBUyTgcienZoEqzuD43Z4lt38iAA+Vg5x8=;
 b=l9TVM5zunvO3h37Tht5F1zSghPncJvzxzxfj3cx8bdI4cnV8ohV9vfDiy1DhbxaqHH
 zX3U0yjGjPzQE24I/G8/oHYA7zFg8vZmSMuMelXXoYyXltauTyTi4gfmiZ+1qL0+4IjT
 im3Q4II1FblqNxoBqJz4o0tWrmXaWoIlWPIjwGrkHXEhYP7v75yE7MM1wfZ3zI4MDDHn
 0jha11ZZaWds23jcvB5JO74kiCcSf0UP/igV7F9ZFWIYwV5e069K544rKLPY+Ya8UaMY
 kwUx13PPpdS73z36d9X2iwuI1MOEQNB/ahNjc+Xo4k9fCr/5q/dBZqBA0Dl5yzayvbD4
 ud0Q==
X-Gm-Message-State: AOJu0YyIWqlzvHzzrKHLiAI1Vp511JwhWJehWO+09N1zI68ZluV3lCjU
 U1eI35V0L/eTxZNgJU4GKf1orjNx+T/hUZY69KG1AnSptkfU0QOrZGQRpBswTYg=
X-Google-Smtp-Source: AGHT+IEc5a39ura361pMdIfLf4Is7ZrDwERnRR5ici/jr9CQxuauaUYCmzUY1/y1sN4P3SyTtRlYFQ==
X-Received: by 2002:a05:6a20:9191:b0:1a1:8c5e:874f with SMTP id
 v17-20020a056a20919100b001a18c5e874fmr2591860pzd.57.1710475126369; 
 Thu, 14 Mar 2024 20:58:46 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 u7-20020a170902b28700b001dbcfb23d6csm2583479plr.267.2024.03.14.20.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 20:58:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Mar 2024 12:57:58 +0900
Subject: [PATCH for 9.1 v9 11/11] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240315-reuse-v9-11-67aa69af4d53@daynix.com>
References: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
In-Reply-To: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
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
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 9228e96c87e9..5954404dcbfe 100644
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
index c68d0f7c512f..7349c9a86be8 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c1243891c38f..6bcf5e23e6de 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -624,6 +624,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -704,13 +705,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
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
2.44.0


