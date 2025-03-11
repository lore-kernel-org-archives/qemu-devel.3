Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F66C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5eH-0007C8-5P; Tue, 11 Mar 2025 15:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eE-00077l-S7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eD-0007WM-59
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso33996675e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722734; x=1742327534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBo2I2SdAyn3zmLJlBPf5O0YjymMe7D9mRmgdIXVIEw=;
 b=eN609VIJg8KVOIFWVzeW22ons5xPmCazNGUE60BdJ228ePxSfJTUsfXVxnVK0TWXw3
 1VyiRreECcmG7SKqLytKil7Dga+gGwlRU861Prl66/TJEkYAZIthwuJNLN4c2ygpRswg
 uhQhu1qEV19GBqVjV2sRCQQSlbmuCG6Iq5dah9RCqknk9tXgnsxl9sM78Nmm1qW3mu9f
 c5eLHafOOcMPNSlLPIqPKTVh/yMt7WY87rAF8zewyCoX7eYO6EoiA5fvwixnWo4CQ9Dg
 VSAlhpsqoZqYwKHzliu+wrWbXfErpD0D0ml3X5FMIgRF30lACZWPHkqIdWKnUo5/rYYI
 yqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722734; x=1742327534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBo2I2SdAyn3zmLJlBPf5O0YjymMe7D9mRmgdIXVIEw=;
 b=QxTN/GR4in+JaEjMx/Rkf0v8KQI3G90GQqbmyLzlN7Nz7EXOVatzyEqe1XLoLsZP8K
 YecfFaIk1AzyfbfcERv6uuQd2sBjjD6QU31L8lhpojb2uT+yqNZCSReAPCx7VZZdTaGn
 NrG2cAsGq/wSDlE2nASN8sTv+W0hS6GiMATzw4D/Zw7cEU7z5L0uJw5ntCCZLUVMoWKp
 e0bq8m4LfDgk2HO3jQmjy5ylouhjCGOqyn46xUJo+QafIoCdFvkp8Vpb2R9YpIbfLTPT
 I8Omia61+RuBX4WRGxnF46m3Bm9STH4uoG1FxeDodHU2T2ReasHatp5yma/CdhKVuZ7B
 /9rA==
X-Gm-Message-State: AOJu0Yw3B62pHJnU6EGoS+bUrbuTsW+FjADnwp2xMMhsKRv2Fw+TfjDt
 jwynhICmUbJEol+m0q7zyzSFQ+MxqvM3lU+xG0Q/l1yAK33fg1ct+r1pU0mHM5F2Y6fYLZP/rTg
 DD+4=
X-Gm-Gg: ASbGncuF1s3vDG7MeX6epbPyXXepQBNOy5fLuXFd2foqlaoi8TsjmFPxHkR8HwaWOoC
 VEDciSa+t6THAh2P3lL/B/0qoGS9dpW+uwRTeqUiq43VvmMqJQwEP5yVJ+sq+pBkxFHgoH90546
 vk4BNMfkAczQIupD6o/SDC0vjG+zIfYqyI+5jrq3fCK9J0y4QSH6/AF+Dvgi4/jzvmkEf9GD6Ud
 Uf6DDdgDEeGdusOJPFx6EfQxk1AYem7HpFKjZ1mYTwFsQM+tIf1Xj4pgbcX3C2Pz4yN7i1Wjk5A
 OmX6xArYOz/abgRwHDycqbKIChVaAKG5iK0gFxRKZtNbAryK4kJJfJPWzuy8x04ttRnX9RPuSb+
 Y3R47ZhTYE/ckFZhgt8Y=
X-Google-Smtp-Source: AGHT+IGRo5NTN5RdxiQ5DVSIl8Bi5uLtKl5f4Ls62hdB3StAMfhpvCnEFF1w9FUX4zRe8zMDJ8yBPg==
X-Received: by 2002:a05:600c:4fc5:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-43cf9691636mr102410835e9.29.1741722734023; 
 Tue, 11 Mar 2025 12:52:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d06fd90fesm20981745e9.17.2025.03.11.12.52.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:52:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 10/14] hw/acpi: Introduce acpi_builtin() helper
Date: Tue, 11 Mar 2025 20:51:19 +0100
Message-ID: <20250311195123.94212-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

acpi_builtin() can be used to check at runtime whether
the ACPI subsystem is built in a qemu-system binary.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250307223949.54040-3-philmd@linaro.org>
---
 include/hw/acpi/acpi.h | 3 +++
 hw/acpi/acpi-stub.c    | 5 +++++
 hw/acpi/core.c         | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index e0e51e85b41..d1a4fa2af84 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -150,6 +150,9 @@ struct ACPIREGS {
     Notifier wakeup;
 };
 
+/* Return whether ACPI subsystem is built in */
+bool acpi_builtin(void);
+
 /* PM_TMR */
 void acpi_pm_tmr_update(ACPIREGS *ar, bool enable);
 void acpi_pm_tmr_calc_overflow_time(ACPIREGS *ar);
diff --git a/hw/acpi/acpi-stub.c b/hw/acpi/acpi-stub.c
index e268ce9b1a9..790bf509e5d 100644
--- a/hw/acpi/acpi-stub.c
+++ b/hw/acpi/acpi-stub.c
@@ -25,3 +25,8 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
 {
     g_assert_not_reached();
 }
+
+bool acpi_builtin(void)
+{
+    return false;
+}
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 870391ed7c8..58f8964e130 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -78,6 +78,11 @@ static void acpi_register_config(void)
 
 opts_init(acpi_register_config);
 
+bool acpi_builtin(void)
+{
+    return true;
+}
+
 static int acpi_checksum(const uint8_t *data, int len)
 {
     int sum, i;
-- 
2.47.1


