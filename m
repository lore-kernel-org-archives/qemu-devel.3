Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B90C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZEo-0001V1-Bm; Sat, 17 Feb 2024 23:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEn-0001UY-0i
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:13 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEl-0004A9-G2
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:12 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso2512836a34.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232229; x=1708837029;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UlKagWgW/Suhx5XrwPdfnlsQ3+kK6LLiHW7W/dUMHaY=;
 b=PjiJa9CI192izjrgVvuydFDbzVhhqxv3gJ9s5UW0tWdElOkA0dt7GS4lskw2mCBfLT
 dUbcB/xNp6fnIhpWXlsFRyXWWTnymGkT6lLgE+xfSOdw5aZHTjHx5T637J0a0+sG0Cpz
 ypGbY+BEWFNhZFEnszeCqGf/Q+Mn6HQHUvH2ZpphfW6RljiibZCqwTrGfVBf1l7q59vn
 ykCvQmmb33EEpaTG/h5YI25IJ2RmUyHlLadumHEaE76c2e1xy7fANwcI5vbKN2d6vR4H
 9L4piWQTULj0impJ0OmOJDs2F0+xZeAYU+8Va5FoAN+vMLrk8j99zc49k/QxMgiWRU+Q
 wBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232229; x=1708837029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlKagWgW/Suhx5XrwPdfnlsQ3+kK6LLiHW7W/dUMHaY=;
 b=Ep+KWsJiYul7X4YJ6mdROYJa3HuX2DE7GoQ8S5b7uEetBFOpaKGXt5t+r8xPPkr/M+
 Q1sDQVWmTTEiM7uYWIJCvwb8hq33GBjfJE+lTAw+d9RBaBa7w7ZZir3jPYoGqsjDxJeM
 F6B0tmtCsldx43iH9XF/7VfuDrjRhAa8VSmOfsQ8v9KEqY1f7Qn4ftCSVdbecedcMPKb
 LOL4ouVmdEFF/Bj9vQehORU26jgI2W37SXlTKPG+2ZY8XzHe5KIe9Is1amlLGkZWpAtr
 dkXRSKwFug3cEWK0MDmqZl9t1fCn+vr/5OeateBBDN08+nxh51g0OeFg6CV105umLite
 86tw==
X-Gm-Message-State: AOJu0YwRE/15eM+3ZRZVUuTZsVByIAG/xhf31xN7W4vBiHHa8fAo9dkw
 h2wkxVCl5TK0D5uK91g6XzmLame6QQ4JDTmVjFhA4NH63P3CG2kacIJOVPxwSZ8=
X-Google-Smtp-Source: AGHT+IHkTm8oqPb/qgb6fxbhdLnsVZpqodL1oivOPOqqDJqnyatdJeOLma8/csN6u7qUHExtswb/XA==
X-Received: by 2002:a05:6830:1153:b0:6e0:ba7c:4203 with SMTP id
 x19-20020a056830115300b006e0ba7c4203mr8645400otq.1.1708232229329; 
 Sat, 17 Feb 2024 20:57:09 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 e13-20020a056a0000cd00b006e35c1acedcsm1682100pfj.211.2024.02.17.20.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:57:09 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:11 +0900
Subject: [PATCH v5 06/11] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240218-reuse-v5-6-e4fc1c19b5a9@daynix.com>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
In-Reply-To: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32e.google.com
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
2.43.1


