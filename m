Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193ADC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoIK-0008DM-1U; Sat, 24 Feb 2024 04:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoIH-0008C4-B7
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:26:05 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoIF-00034S-PQ
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:26:05 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso1289823a12.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766761; x=1709371561;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FEXfVsaC8WiwQLHzBhL9P9YmKLGvJ5rGOGPmQWC7dng=;
 b=WTUF1Tza1XqfASJ3O88x2F/o8EAE6EKSfZoJGFLIObujtDteWGEtInzoC6SbuEpqfd
 mLL2s7QHeoLP4CS4E47O7+suP6ObFatTiXwrM5NFAbS+FnKJrIuYcDtKidpfgsngf9b0
 IKPyt9mJJ1s2DMQu/VhIyh0+B5LffzoP5wak0S21rdl5VEaRjvG6eHqOC1ywD5+XDhGZ
 ootHsPcdaoNMSBDGe60FtkTZZ8FfQkQoywIr3F2ZpxZ0Cq054TvTcuBNFf3biBn3oKWm
 xnXm8Utxp5D9TlpZx52SGCbgF8lg+hqJj5P8m8iULDicKWbAnv6CSrTrqM4c4zRuDkOM
 tWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766761; x=1709371561;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEXfVsaC8WiwQLHzBhL9P9YmKLGvJ5rGOGPmQWC7dng=;
 b=cOqIrpVRquhWkOXuy+/ILriOLl8QT9B5LZucyoCGChdQfvzdRWGfAfMixkMr4eccts
 L5DsaGwlAuHxCP8IQ0r/zYrO+gqYLr0w555ZdKFHZlu+8gOLVWmWtGtLYbdbtSiCOSCl
 xUgaZu0jCw9YLlL0J1NYS/8UQEqHhe9aSQz7U/A+Y29vCNqxHq7CwKzKrHFV1eO+X3S5
 AvC9GRN88FhG+2lsXE1DGDNXvlaMEQXJ51ydZVgF8KpYiUDjgWUJ4j1P/+luKaNp/oA/
 loiK3AVnjSE7UdZLq9dbuha2NoYPb0eihqv3j4CEkznkcXrBTvwl5gjZuTXznJdh/DhU
 Mcpw==
X-Gm-Message-State: AOJu0Yz33OC3ozCTCDXs1DqXOMZIqmfYE1vm3uanTf8zKbu0qD1Srmf3
 ZuS9eXbubqdkj+iutMzM7Wf42Bj6C01UjgDcy29gvzIGmbCu5dDvkDjWA6X2hgE=
X-Google-Smtp-Source: AGHT+IGaLjdgP5krYgwf6HXi1q9/8/pOXNaYZkIYsqW9ZF3fXUVZtSVryX/NDJnMItOrXBC/N8lL5A==
X-Received: by 2002:a05:6a20:9d92:b0:1a0:6496:84c1 with SMTP id
 mu18-20020a056a209d9200b001a0649684c1mr2546192pzb.37.1708766761374; 
 Sat, 24 Feb 2024 01:26:01 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 k25-20020a635619000000b005bdbe9a597fsm744828pgb.57.2024.02.24.01.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:26:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:48 +0900
Subject: [PATCH v7 16/16] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240224-reuse-v7-16-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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
2.43.2


