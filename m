Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAC8C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZRw-00060T-2U; Fri, 07 Mar 2025 10:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQe-0005pz-RE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:06 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQd-0003cy-0X
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bd87f7c2eso11395935e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360556; x=1741965356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJ6QS8bPHspYWexuxW/Mo3/+G0MWF76KuZRGtLsMeFA=;
 b=fA/hhJRylF7WJsSoWEQvloCOypH9P60jFhquyRMNytYvJY3jBMphqwPMWP8mV3l5z3
 oMkMwPG+yaEWFgVFZdumjZSNP1hysX6ylV3rJdgejDwknBAOb6X1n2sXWya3JfZ8/x3o
 snTgttPFVav/qFvYKeuw6Q3IMIvHj5qRP9n3/gGz1R3g/qiK0kTPlBib9e/bTu1P0eN5
 KpdGlrYZt6ngIztmIYHERIpqgwtr2cy/A76fHnSfCmLXXu/nZHQhV06IdMFupRz1v3Dr
 k6HvfzyCJQG8ZteL3FZqOdiPJlPF42EcKA3S3HPgObyjL4AFWplFZs8jp+zEor6oE75c
 uesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360556; x=1741965356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJ6QS8bPHspYWexuxW/Mo3/+G0MWF76KuZRGtLsMeFA=;
 b=iAI/QIcOfscneJb3CXKz0ZBCKs70LJGV7ZbjVTgil1w7h7PeRB22ByzqOKVOAJ6EOg
 c1EKHc1+JBz6jlN+c7WXr7oi7TJN/Itf0fUmnnhrzVe2Z3sWDWW8+nkHeqPShyvq+T5Q
 MpwmIUU2V7YFb9n4EGlJhLO3BLALwmv6BuJ1cF7li6d+dk+qrSgbnvzxICO6pwUOUy5p
 8v4CxajcYlxzODwLWGRIvC1S9So/h1XYe7zFAoDldHb2PLUTR6odw36rcxNPvJ4DbA0G
 ilUCa/mgQvLUcHo35at49uB4r4vxENpQr1oBXuWjVNlOA8t9ZaEK6xEfeec4xsT4mQ12
 xEPA==
X-Gm-Message-State: AOJu0Yxd5ZUWp4LYUdR68ECXX1A6kfMKdJ7uKSyAF+i9uRL/jxwOLx8R
 ZQGQmshRzjqbEDxlPdapjgnfmMpl7Bpwpqx9cf/ByGAgzd6mNNmInw33lVXWiK/J8FLcejOb124
 BCBM=
X-Gm-Gg: ASbGncsVM/GS8udDZEScZk/Dm0jK6XL/y31RcCoHVmcYd2EOuyOtnCgvAbAY/liUINM
 +Dba8/0cNEGRcgBJOGGxNy6QYnFmIZRhVaKDRs4/rbkrDgRJM8d8H4fTje6cllp4ywHtxMF/J1Q
 tua8iDTVLVy5oPvNEuUvrfveLenFazM10+BDWdi2hkbzU+rwW4yRuSY+FOxZr5yFk9uSJvlAcod
 h5Tfan12/tbTff7yuWswAvAKL97tcgHZLKj3ifvTw+vIRdUWJa+OxbXDk697ynMNSoj5nkp2VaM
 Iai2ngGl8gLRfCUUeAhsc6XtxS9OhLtHtEh9N0eXQMJAXttqoPz16l1T6e3w5ijjBWrLRoHBL/0
 QvmOum1OuQ8yDbmI5KVQ=
X-Google-Smtp-Source: AGHT+IHIxS2nBbTkCFfhUa0L725ephvV/Uo1ESsaRG+Jl7BKmzoCqtJVQzYdFtvsEm6vfDvuJAb2yQ==
X-Received: by 2002:a5d:5f45:0:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-39132da8e47mr2305456f8f.46.1741360555832; 
 Fri, 07 Mar 2025 07:15:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfa52sm5474263f8f.21.2025.03.07.07.15.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 07:15:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] hw/acpi: Introduce acpi_builtin() helper
Date: Fri,  7 Mar 2025 16:15:38 +0100
Message-ID: <20250307151543.8156-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307151543.8156-1-philmd@linaro.org>
References: <20250307151543.8156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


