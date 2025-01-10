Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A06E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBAt-0007GR-6i; Fri, 10 Jan 2025 04:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAp-0007Fq-DY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:23 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAn-0007JF-LL
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:23 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so1140345f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736500759; x=1737105559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vF5lGOX4v2031Uz2Kj5gxqQl2XDpdfzIKHMWP9T6C90=;
 b=xoxi69WWMeWDuubazWodX5EX+V0LKUJIHql82qpB15s70jx929EjzE6k6aiVxcVNUJ
 TwQ1URzfL6HN14Awpo7UatF8CZZOcQRh3JEmIvfWcTGRTVGjnUh1WGkKIMkWVO4LSe90
 1VreEQd2OHi9Izssdk1kaCTe/8GvQvi2lXq4zh4aUPs4MZsanTzq5b3PavL/nMF3PgWE
 iwlO9z+HQ1P+UWtWkj1KCc32wIKhAKKkzuBAo+gGvk2quTc+JZwE7d3Negn4ct2ToD15
 t4N7OjDkpiByU8BvT+TjQTvbRjDdIuC1aiA7iN8BN1KtLZPZb2N+NNJTABG7jm570xmH
 TrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500759; x=1737105559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vF5lGOX4v2031Uz2Kj5gxqQl2XDpdfzIKHMWP9T6C90=;
 b=n3am4gQQAhUEDWoNzlLF85j0Z5eRgeubm99UEz7/lt2+5+B3fR7XB/hoXCGNOlY5SX
 /SnpEEj/kDnuuaPcZ/fArSfrI33XSqGhxfUT0RpjDmUvEdiL6HuMnkmPd7vYbNgUl/yB
 UAY+MRkZxI3lGgwm+1ZQakfXta3X3vN3dYZbneg/KcxBxltLyfNQwlgVXKt6SH7Kd6EU
 MHlFUQBbsdPpwVoCnKyvVfhLRj3NC1UMZaTOxaLeAF9tGF/aVdP5f6xQ9FNksnyHWLCD
 3zN97TZxeGzP/DjL6GUXxx2ZEFhmWn7Fu9AK7KMvcnZQDWv1xh/uuXcnJKSDEdTrs0Po
 QpHA==
X-Gm-Message-State: AOJu0Ywv6sKkKh6KF4h29qRyGvuto9VTqzc2C39UyWoY8wyZ9ZvuMO05
 DovuM6+bimjO8njFUgKJTrVO6coQEsw2Q2T2abo4+HVxqF9N0QkHefKAZF/1VTVShhtwzuc5t4T
 aCzk=
X-Gm-Gg: ASbGncs5hAQXc+zBE6zZIEYQCUocIWSP3BLTrcpqt4qNPrZW00n5EPrMMNfgrLf7Aeh
 l8z0Cvm7whT/UYtZBqsJfQT7t8kPGtmlu2TRaEDpLt1N3NUEbftGm64TGP5o2EBXOPUYkUlCIqQ
 bFUAh1yHSlgZaeXodytMXnxpa8UIqTHQuxvnlgMPUtinn95xVcAevPA4069hHrFATclUSziwIE+
 XeXw9cen2CJ55zPHcmtVaKxOUcXTuca59v/ckqQ+5EH4miVNA7imSv/B5YZsNnv5sb0bovxc9LL
 cnkJUQY73og5Qe6DT0n7RTXgc2I6LxKaWBs0
X-Google-Smtp-Source: AGHT+IF+OBL8J8evYSi+1nFMk4ptM6+mJWX7XttOmFvM1G+5Q2NVbRgQVcDwf0RMDpm3L7h1+1wiJQ==
X-Received: by 2002:a5d:6da2:0:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-38a872fadf3mr8494964f8f.7.1736500759360; 
 Fri, 10 Jan 2025 01:19:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d472sm3964167f8f.1.2025.01.10.01.19.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 01:19:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 2/6] hw/qdev: Factor qdev_hotunplug_allowed() out
Date: Fri, 10 Jan 2025 10:19:04 +0100
Message-ID: <20250110091908.64454-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
References: <20250110091908.64454-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Factor qdev_hotunplug_allowed() out of qdev_unplug().
Start checking the device is not blocked.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h | 1 +
 hw/core/qdev-hotplug.c | 5 +++++
 system/qdev-monitor.c  | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b4a5b203aab..c417d4f92bd 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -545,6 +545,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
 bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp);
+bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp);
 
 /**
  * qdev_get_hotplug_handler() - Get handler responsible for device wiring
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index 19fbb11a316..dc35110e735 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -47,6 +47,11 @@ bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
+bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp)
+{
+    return !qdev_unplug_blocked(dev, errp);
+}
+
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
 {
     if (dev->parent_bus) {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index bf1afb81886..e1c8e847d1f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -907,7 +907,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
-    if (qdev_unplug_blocked(dev, errp)) {
+    if (!qdev_hotunplug_allowed(dev, errp)) {
         return;
     }
 
-- 
2.47.1


