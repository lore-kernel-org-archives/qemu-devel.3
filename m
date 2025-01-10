Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C2EE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBAw-0007Gr-GJ; Fri, 10 Jan 2025 04:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAu-0007Gi-G6
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:28 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAs-0007Jc-DI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:28 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so21250175e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736500764; x=1737105564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvotUkgIAo4Bek1E23vWcUJA+NmHBkCSsm3lADq1RFM=;
 b=lEn35KpDgJoIqyYbuZOgDIj/Gr0Hk8pkPgVSv/47PL/rTc0WQnhiGJ2kwz+D+ETRbz
 /kO6uB4sO0Z9wOxg+baFf8eLx3Qr9H6gKrdJsr77myhJmvXB8wBl8ou2kkUkMMOW0kcl
 fT4/YnPl8VHMI6ua4YZA+NRo4K+iVGHIiA2/Z+awlbVHMkD2qRl0xhqsxVGH58YYgKab
 /vPDsjG5/7SB2fadfYcPUw7fwl9mTr663/fhAYAOGKTcfIUgajS7XCySR7AhH3H92EYs
 NtijjhJ0bE1HWRLt90TrH8FRReqwrNuRSiP9sAVmTv4VrmvFu69IHwWt9vuDhGIAts1g
 4aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500764; x=1737105564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvotUkgIAo4Bek1E23vWcUJA+NmHBkCSsm3lADq1RFM=;
 b=CUV70NYiX+zeO3tSrHOxgfUY20UxlNq2VV50fEYETdRO45uB3oFo9egzCeXXmNSLGN
 h7qsCNMdEzbv66gKUmGLK8BcXW0erJvteFQ7QpkdNNZ+00d8ZZX3B+h50NdN1P6OFFzx
 IkpQFozNKOo8m8al2Hhb7Lp39w3ChZ2WCfrzdKV52DdKMQGCN1kaGIcEmnTqi0ZmEGF1
 /sq2+EeNcGK1eC0P9nzgahS+UINPgZGp4lIDm8ZzxO3uZ1touiFkuL9HBKRwnrTcXGM6
 9ySQyClUc15nJRsi0P+zb3o245GKLUlk6QHrWE7Ioha36NbkaC8GPNvVX6LcbHBOX9Jy
 nCmA==
X-Gm-Message-State: AOJu0YxyK5whSpNLtJR7Au0ztXtCxYtp50C9qK93dr7tEX9Fl5rLzZQ/
 /CSBuLmRd2zE8cpNua+NtR9RBtbWszQSTQAMypURF6Xe6kBmGvFuImFhz3GxoGr7WhbgoRWSsLM
 /2WQ=
X-Gm-Gg: ASbGncvUj8RUflVBLFpGsjdepcNe6F9nzp6iItIJDl7VK+wBDIomvpdiaEiswkkuxlo
 OsArUva+Bd0jCdrJa5fgBjD9bL27ON84MwigOMeZtPK3mX5zno8EH9XXl1doEu8XlV8zQuq9oYC
 /5pueABcHrnw/CH3oDpsO/328eJC3uNFHoLYpRR+jSEzXtNc6yEVdvjKxHmJ7SDac+Vrx56N1p+
 cFMGBE+RjXRwfHPq/mVj6+BDvc5W+yuh4S+uSgdsGRgLWb4BMYluHYDMWMKHpt6xUKSs45gnYKN
 WxDqFCHJqE5CvtnmsrYJiTm+EKrtuFlmEn2V
X-Google-Smtp-Source: AGHT+IFcMZVi+Klm6BsG/GFtfr1xkX8kQrnP1WcBDkynGdid7nxw4ZKK5LGDdjTnt9rd3eA1di/PFw==
X-Received: by 2002:a05:600c:354e:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-436e269c42dmr102934975e9.10.1736500764275; 
 Fri, 10 Jan 2025 01:19:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03ffcsm46058505e9.20.2025.01.10.01.19.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 01:19:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 3/6] hw/qdev: Introduce qdev_hotplug_unplug_allowed_common()
Date: Fri, 10 Jan 2025 10:19:05 +0100
Message-ID: <20250110091908.64454-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
References: <20250110091908.64454-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Introduce qdev_hotplug_unplug_allowed_common() to hold
common code between checking hot-plug/unplug is allowed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev-hotplug.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index dc35110e735..168d7964740 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -30,12 +30,22 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
+static bool qdev_hotplug_unplug_allowed_common(DeviceState *dev, BusState *bus,
+                                               Error **errp)
+{
+    return true;
+}
+
 bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp)
 {
     MachineState *machine;
     MachineClass *mc;
     Object *m_obj = qdev_get_machine();
 
+    if (!qdev_hotplug_unplug_allowed_common(dev, bus, errp)) {
+        return false;
+    }
+
     if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
         machine = MACHINE(m_obj);
         mc = MACHINE_GET_CLASS(machine);
@@ -49,7 +59,8 @@ bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp)
 
 bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp)
 {
-    return !qdev_unplug_blocked(dev, errp);
+    return !qdev_unplug_blocked(dev, errp) &&
+           qdev_hotplug_unplug_allowed_common(dev, dev->parent_bus, errp);
 }
 
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
-- 
2.47.1


