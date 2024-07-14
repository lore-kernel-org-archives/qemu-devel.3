Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FF1C3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 07:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sStz5-0005ce-17; Sun, 14 Jul 2024 03:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyz-0005Sz-8z
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:49:21 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyu-0007fm-9B
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:49:21 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70af8128081so2392155b3a.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720943355; x=1721548155;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0VSYKVQCF4c9EWbUkbZPOSynuO1Ww6rZL2afZDm8mb0=;
 b=Z3//t0lAuC5c7cDHMdP9RW2/oezUGCg+MCAu1rz3xUNCfkrrcLp4XyNMnNxCeVpwOG
 kjh2lldXxZPb3xgF0runKoTglda0wNl11AJVUIbb3fOuqkk31OrCDPiKqbw/uGOe8Crt
 hx+rUEfohN680dV8BA2fNCGf16Ez5y5no5TbUZy7PdZBjHMGsakbH93lsTsrsouJRWvY
 1Lw/3yX3pXZWRfb3Jf12R9pCnt7ETUfyFJl04VjabJSLvqt87TvREfpJ8UvSCrwucWl0
 BIuQffczt0R9geZ9pOf/QegNye++sGZPp+GRQPr3Vmn99UxByGeF6oV7SMVDYZS9aT/H
 n4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720943355; x=1721548155;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VSYKVQCF4c9EWbUkbZPOSynuO1Ww6rZL2afZDm8mb0=;
 b=meC6IRPTpz01GHaiI3jjIKOQEChqHpFa5L8JOhIFN0I9/4RaFK+8eRSNumRokIcD8H
 0YvK4TeE9oW1nofWeZcBfR3Mwof3qZj5lW4+g7KYIjo6iYbDgKi4KO6Bz0Oh4ZTYl5ro
 AJb/TwSMi3Bwo5lsNei/Jbpso+6Nb1rJYKjPvL/S1HzyUMSdZD3uF37ip+kWJ1CWa4xq
 meWoXmbA1Fd5znanBhJpnplo9NItmfk1KnI46lDF7oYxceivXoo6IOeeZbR+fYIi8etE
 QFQy88yWYHmqqa5uBmniPcjM+++Suia6I/urLWbNPZ81EwsVu39h+zsNmk8RG4D6grmr
 GoTA==
X-Gm-Message-State: AOJu0Ywh9sWtX0iaOFn2JDeeFVX2CzVgFzZ5Knagn5v7fTz1L6MQCHba
 fQX8ARjzTGUm90EKtEWYgpEhRVJqeAD28om7/VJbmiNwvR2HeFm5Jjo00GaJO/M=
X-Google-Smtp-Source: AGHT+IHjl9twXCA9eQvJfVQb1xfkFskT71A2789HR/NoA4zrPc2snsuB9tNAMTOGNzwgCUIxtqa6Ig==
X-Received: by 2002:a05:6a00:c86:b0:70b:23d9:98ae with SMTP id
 d2e1a72fcca58-70b43668370mr16055569b3a.28.1720943354825; 
 Sun, 14 Jul 2024 00:49:14 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7eb9b3aasm2213754b3a.6.2024.07.14.00.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 00:49:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 16:48:34 +0900
Subject: [PATCH v2 4/4] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240714-rombar-v2-4-af1504ef55de@daynix.com>
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
In-Reply-To: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


