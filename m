Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA61E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwCU-0002Ib-VK; Thu, 09 Jan 2025 12:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCT-0002HS-FQ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:05 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCR-0000bk-Dn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:04 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so791731f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443201; x=1737048001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vk41Fdbmt4kvm6C2wIMyLOfMKTEmUCUG4l8SIJbTN28=;
 b=GF4TXF0yhS0GCLBjE+DDN3JgAAALPqQF+hdmuDOlNNbSw1wlT+q7LGoBuYTeTS0Yr7
 OPVyMO8KM4yVm9BdyOLTlBzEZun8Dxu84DeQTh8Dn2KRIGBICpBKf7VpImkl1Tks/ka/
 t2MKz5avUvrXrhjCEIRIfg188uT8Yr72JLw+52s0sHjq/K7DwiWA3tQzbNYoeSawp/bb
 nhiX+vOqK1+XA1PWnbvuJb7hcoxRcrwPuWsCgBa2epStZsQlvmRwUrPyLB3xSLe5GAjj
 5Ahp5nj3Hnf++b7jLO/Lfr7GkpyD/94+06qCtVfzva4TApMRzJ6qqmzIVaz5/9HgQL96
 McEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443201; x=1737048001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vk41Fdbmt4kvm6C2wIMyLOfMKTEmUCUG4l8SIJbTN28=;
 b=qL7ObRLV+ayDnjXrD9JojDJC/ZKNeLBrxPbCBWU5mNaQc2yGaduxGQcYwaWiTAtmZx
 wmBAtmgEPucapHrUb0pu5rUaGbSIm/R8wJrh/M668XgNlc0dgB9GONbcesmiJaPI2vLQ
 l9Mr5cL/JW8U/HaxcrpKO8NXcQhy099vn1mbFthbemfNSc4mI7XHvD5zeSay4w4liHIO
 NQjj6L31Yy6xXw1vvqQ3JyG769jLDIWePmsXREWIgx3hMF+pvcnNrOJkqwtKFimZpFNe
 eMn6VzD6V4TfRG/AHmJ5054r3Vq/+6JEl9jghz76H0IfxPyOx3kBzhFTfdlfpOLkq1z3
 m8SA==
X-Gm-Message-State: AOJu0YxvpCoA4BOkTKMorPpH8m5BonaqX4lEMqHaJjVMRLddFlncO8l2
 PvzB8rLxYUO+P3Ff2GMnkS+8omAaXUSmQwtfFeWe96EWKWd/lzFeAKNIl7nQCph5iMXvNtEgk96
 HgsM=
X-Gm-Gg: ASbGncv7cyDFW6/KK1mUVIYEJTxi40pMyDCIvSd81IhsnplIoIiY0aJKUsiehI85obM
 yumZDIydXix3c7hoNaM6j3+cg4JuxVoAACyyWO0Nq+2UdLN3qVeBA4mtl2m39Wi7TFveRH+0JPr
 K0eiwGZlBdj7xQ0bfypX+uQFDZzzFuwTLAtBqcGXDfV42JkIoxhy+J/gJtcNbuhl6efmiGf5CKz
 VjT/C5C9ROx+oH00UpxmxkWpoDtzkdfumSZMseCoq+JrcG1WJ0sG0VPVG4406QkN2JkCiZjyy1h
 KH4yyZU4ZJu8TJJ57297DJy+K/Fq8RSAYc+S
X-Google-Smtp-Source: AGHT+IHAuzPivzlPebHg8AsqBSkDnohRC0UqTfTP5nzc3x3Lt8jf/Xmqp8L3y/oJw8hvTdNivN0syA==
X-Received: by 2002:a05:6000:2a9:b0:38a:88bc:aea6 with SMTP id
 ffacd0b85a97d-38a8b0b816dmr3668256f8f.6.1736443200760; 
 Thu, 09 Jan 2025 09:20:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81a4sm2372032f8f.68.2025.01.09.09.19.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:19:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/11] qdev: Remove opts member
Date: Thu,  9 Jan 2025 18:19:39 +0100
Message-ID: <20250109171948.31092-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250104-reuse-v18-14-c349eafd8673@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h |  4 ----
 hw/core/qdev.c         |  1 -
 system/qdev-monitor.c  | 12 +++++++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e6ef80b7fd0..c4d3dc39064 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -248,10 +248,6 @@ struct DeviceState {
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
index 57c1d9df3a7..09c4489e3c4 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -691,7 +691,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c844f538025..6a38b567876 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -631,6 +631,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -712,13 +713,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
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
2.47.1


