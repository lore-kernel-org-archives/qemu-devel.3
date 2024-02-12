Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E868C48BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 10:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZTQs-0007vt-Je; Mon, 12 Feb 2024 05:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQp-0007u7-AH
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:59 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQn-0007e9-Qi
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:59 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso2745767a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 02:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707733256; x=1708338056;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iAJ7lmtnfUSGNk+HI1ogBnXGyYd20Hja7FW5nhY7UzQ=;
 b=3F8oK8b0Ha8QAkj1Q9TdBnCV90MToxpk1VY4z6Nwl2QaEJYU77ADGEwMq022Cns386
 cOqrYFXozEUBXbyAHcKfloLC8k3IZLxS4aKsyz8tVboUyeM2+BtlMHuuS/f2AlKON0fI
 T1AO4xUx2kciKgpSssr5yoAQ0sU9uLJw0KanzPsBjfHGWzPrsg5qNfcpPkqP1PuDyrkY
 QzQqv7XcFdNXA4vTAElsfsPQldww9/Hcn/N2ZE3IzI7g9ad5lSDO3NTQ2+xfHyWwBK1j
 GlHFKkymDWWKM/a+DYClapTE139H2B7SSHwyihKZtPds2LAzB6X2LhthOGG5dBkE1NXv
 zfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707733256; x=1708338056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAJ7lmtnfUSGNk+HI1ogBnXGyYd20Hja7FW5nhY7UzQ=;
 b=k1PYSL/B92smT+JILOeWrhZuwjECAbeguPmZr4m6xEoMQQS20d0QqbPeZGWA5azlMJ
 yR2fY3tpaGR/kf1S8U84BblBofzUhAT8ZNMeCT4V4lBq2XZShqlVqhQRWAb0mTuEJ8bF
 L307UeCp4QrdWCGClHZnyQxhNgTq+D7TqODw4Y0WhwNIPkHOGUyp9Uk/xcexDUdBN8zm
 zKW8hgBu8t/nOSMtD8mq1Duz5qrzHUfH6iAVa6FeB2sLyx4XmUKW6Db2a47knuDsNi5G
 2abH9YlNwaaSkSslnpbVUy2DiPZutxyxJ+0lB9LmFJCd8k+F8w979wubWsFK5o0AjQWq
 SYXg==
X-Gm-Message-State: AOJu0YyNR6Tviw+NQIQv+hOyIaBkkuOzJSuklgbaNkRMTR8ZwPQoNQs3
 fPOL7VlwTxyesd2byTAep/l9cFsnpsXvGWF74nxHWMwaxRsK6UKzgRPy/M5CyCI=
X-Google-Smtp-Source: AGHT+IH2Mo7+PTCQHSFx59CZCvYs10r3V+V5NVOPXqT2wwTxLOONmG1rWT5TqvMURS3XpWgEeRs0EQ==
X-Received: by 2002:a05:6a20:9c99:b0:19e:9a59:20df with SMTP id
 mj25-20020a056a209c9900b0019e9a5920dfmr10669455pzb.9.1707733256083; 
 Mon, 12 Feb 2024 02:20:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWMj7GQfQXqhbXZwFjrqCLTPcXcrnc8Y9TzuFPDX1KwbPK7t6TPQlZEngnMbSCiR6TYhHYBEonuz0PIxTbIu4KSC+dqQVwW18zcyy9PAt7IxkD+6MbaWCSZ22dvnf983qWhE+yhqP5XzKQw9UK36unXNtCEFt6ezVAXTNq4DPPfeUeqrCTqNBKK9dE0CEJbh68CQ9WoLn3iPraNjY2rqw2x//Z4vMI4iUWeFMAo1EyYbAtTkueUYjfIBL4emHCUowuvHLX4YqNzHU5fWVH7fKAC9/7jaLcGAsgMJyaqLL1TfZMMNPcIngVcSc0rPPGPGouh/y501rXuPU/s0EdRdaZsq1Z30rZSc0StmsqliY/m0UlWbu5vLq6ChQnM71MVDqaPNPlEnCFyGksRb1Vs5UxS8tYeDU2Xm366+s+y4mcy/0wMUS1fss/PUBQIghg=
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 g7-20020a62e307000000b006e0978bb895sm5182820pfh.68.2024.02.12.02.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 02:20:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 12 Feb 2024 19:20:32 +0900
Subject: [PATCH v3 4/7] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-reuse-v3-4-8017b689ce7f@daynix.com>
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
In-Reply-To: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 include/hw/qdev-core.h |  4 ----
 hw/core/qdev.c         |  1 -
 system/qdev-monitor.c  | 12 +++++++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 151d9682380d..6befbca31117 100644
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
index 43d863b0c5b0..c98691a90d48 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5dd..71c00f62ee38 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -625,6 +625,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
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
2.43.0


