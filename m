Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867ABC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6X2-0003us-MN; Mon, 17 Jun 2024 03:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6X0-0003uD-PP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:58 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Wz-0002Cr-4x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57c61165af6so5213390a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608315; x=1719213115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZanXSYwPxQjKnLjTcwqew9kPvqMmq1FF1wpubY0qEhg=;
 b=AnPlV5Tt++/50AIVqZdudO22KTKi4UkrdaQhvM8V+Ux7mPiUagpSyYLREYWtkRBklV
 9PHFOfmWX4S4nBPdNCSrZskvtqwWELRqfYQ/9tC/M3bLtVvyj2dkwzchz+fgOy6xEbrN
 xBcV4Mjm6sVebIFZtOeCBy67KISGeXL6J1bkYAho0YG5k8A6aauEBRTp/P6VaYPpfws1
 uQtQX5jwlnLFLH7LeRT1paSXvZFLw8stLvB3e5u/b5JcuHIjkWLZv2MhTcO47j1hQKgW
 275GxVfWR4ubznddz5BFm8Z9wFFpjN6vQzCg7XaGO5a3Tyhzp2brJ8ky3ZgEroPfOIWZ
 hsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608315; x=1719213115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZanXSYwPxQjKnLjTcwqew9kPvqMmq1FF1wpubY0qEhg=;
 b=j0Oztr0QY/G8GD3HoONir02DUNyAaw+jWrPxJ4+UgiVw0nlAc0suDwHlUUmquvpz8Y
 RV1HJeuxh4VXUN5NKtL3PRqRJQ7+l7L7QkAfglfUy6PswChjDWigUZwqdvEoEVfw1gSO
 Q6Ar3Aeb0zl/sGmzAVkeKeFrJ7deg6GYCSotgB9CFYgTcKhDTZe+/UyaL0Mz2rIv0fKF
 NXpNKxZ2ijJ98btAJGJ/7DfJ12WMXvUFwPEI+6OO7W9p9maaEj20Epl2PHsx9hvkOTdN
 6xdtf7vE0nkPNFRgqaa5SxoGIDtIzgnmnR9uyETr718cb8tHltTMVuemUIqOjSEOwkVn
 mojQ==
X-Gm-Message-State: AOJu0YzZomWaa1+UlDCQfT/U2xUG8krkNk7gg0cvpcwWestzJDupwWyQ
 TD4pPMV7AIJ5UlJgJ7D0uacYnbKlWF56anX52yYQhm+ARyjR1qypa71OiDIkHOOaEw77zw9jCyY
 HFEE=
X-Google-Smtp-Source: AGHT+IHJ+Urf/Kpnspz2yO522d7E4b5eRX69N3SdWiDQoybAbZImCEgfqHSllec5eJ5wOXBAaNez/w==
X-Received: by 2002:a50:cd51:0:b0:57c:4875:10a9 with SMTP id
 4fb4d7f45d1cf-57cbd6ab5d4mr5141895a12.24.1718608314804; 
 Mon, 17 Jun 2024 00:11:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cbc4f5870sm5221203a12.4.2024.06.17.00.11.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:11:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 06/23] hw/acpi/ich9: Remove 'memory-hotplug-support'
 property
Date: Mon, 17 Jun 2024 09:11:01 +0200
Message-ID: <20240617071118.60464-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

No external code sets the 'memory-hotplug-support'
property, remove it.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ich9.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 573d032e8e..9b605af21a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -351,21 +351,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_memory_hotplug_support(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.acpi_memory_hotplug.is_enabled;
-}
-
-static void ich9_pm_set_memory_hotplug_support(Object *obj, bool value,
-                                               Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.acpi_memory_hotplug.is_enabled = value;
-}
-
 static bool ich9_pm_get_cpu_hotplug_legacy(Object *obj, Error **errp)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
@@ -445,9 +430,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                         NULL, NULL, pm);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
-    object_property_add_bool(obj, "memory-hotplug-support",
-                             ich9_pm_get_memory_hotplug_support,
-                             ich9_pm_set_memory_hotplug_support);
     object_property_add_bool(obj, "cpu-hotplug-legacy",
                              ich9_pm_get_cpu_hotplug_legacy,
                              ich9_pm_set_cpu_hotplug_legacy);
-- 
2.41.0


