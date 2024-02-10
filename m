Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793FFC4829A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 10:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYkXi-00074c-0y; Sat, 10 Feb 2024 05:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXh-000745-4a
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:25:05 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXc-0002eI-Qd
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:25:04 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d7881b1843so16280525ad.3
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 02:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707560697; x=1708165497;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EtHvqx0pYo51UarG6u8auC68i9+0d57qDsSmnOr8C/4=;
 b=JyWA9tL0PL4EYbLsWPH1jaPdZF1kZ8CgteDrG9cSbOL6U1zwrBpKzrBKn2BnbRge9O
 9f33BmcUWka75RFCGsB4Qw0Vx+k7QIJ338qmRa60f7W/tQBB9yvR7IEHIyGp1BlJroAW
 CaRYHg3sSCQv7uYXL7xv9gr+3MjlZKz7IukfC7cthjZoKAYD0cAdROdvym2O2NfYlv0w
 3ew8OlV+8ZiS94kMM6dCgjRkfQn6WVJpx2SA1lTsm+FmsBtdCjc2SxAu7/hpg0Soetmn
 kGJUjxaLC1LGV4z657JYr2AVQTbCLZu9ITsxhK0wk0U2VUOyZ76az09mdLLgR+Abg7n0
 GpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707560697; x=1708165497;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtHvqx0pYo51UarG6u8auC68i9+0d57qDsSmnOr8C/4=;
 b=UY/+Ofx89S14AdzlRi5yqUgJyCUy2XqHxvn01GX14qL+1RxBH9+IBbUKgOv96JHS4P
 QLpUO7MfA7+dG8pR+Dlh4gQQcdmg85554aDqnmR96TtD/0slT6vybqmqohAFfpyAaWBd
 glUX2WgGw8pfI0Jjh7YZam28a8xxkbufWO4RGi+Ukaz8+aSa2vNM2yBezI3nM0a62ptn
 tdsPI/Kq36p3KmS8KjOdNjQitIEFGGMap4M7NlWtm1h0LDx3ds+75aQXp+Cs/Jw18QQj
 WMmudWHtUQt4PwQ6+0kLBGgFcr+S55wBu7pqma9pQyTZhDLja7vIZEVTTuL5M8+8OWe2
 F2nw==
X-Gm-Message-State: AOJu0Yy1wO6YzjnxpJrEzf3APmgwlJ1vJypQgAyStZFec3H7JLcP++1f
 YW1LVuOCWI5xbpE4BQequ8S0rRfVCOf7x8w22EzdWA4W/1km8nPuGPtAo3W7ZKc=
X-Google-Smtp-Source: AGHT+IGYE4PNSJjBF+CoByHfCaHkIA1VNxP61Kk3nOm0dMgbKj7wbi9/hpMc7ogtADbEXnT1/Pahlw==
X-Received: by 2002:a17:902:e892:b0:1d8:f07f:7592 with SMTP id
 w18-20020a170902e89200b001d8f07f7592mr2732126plg.55.1707560697214; 
 Sat, 10 Feb 2024 02:24:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVRHrnhxgd2YqiGxRE2OhT4DvwSt9cngi6gIXemefyRFJqZ3MuqroESeqTHi19e35cJibHIjGkbCiEM8TG3PPkrrcFhR7qGZbET6//JWRVWn+ACbawuCn+wPU+ZJ2gp21dsGFz3XyBN2Kj3RaDKM3h/xGGU+3ZtGR96CNmUasVbTea7ImEPQGzfVXE/NzqYY8p1xI4tLJzh5JUderokBkvX2jzZ/qm2Gcrzl38mMepjp2zCc5Lr3Bqdu83WMsilDlQtit2TBkRFVbAwDiKyvVR3XUSPHeGYmUQpu0KsW2W10ANLj1w90isOfhvRqAlhSACSEh6lMaDK8QtJyfx0CrCdxeA1VnuWVjQo75wLO9WNvu7VkrQBk+AnHLdb4lmV6/SvEs5wc01R0nfRZpg92hW5Du626w5FBrJ/wwu3Mg==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 la11-20020a170902fa0b00b001d9daf742ccsm2782712plb.233.2024.02.10.02.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 02:24:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 Feb 2024 19:24:38 +0900
Subject: [PATCH v2 3/6] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-reuse-v2-3-24ba2a502692@daynix.com>
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
In-Reply-To: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
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
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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


