Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AD2C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ1b-0002vE-Kj; Tue, 15 Jul 2025 02:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1T-0002ku-Gz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1R-0007M9-DW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so15203155e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560411; x=1753165211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgFpG0rF6KVbYpLZQoXHGkLj2oHogtOGTEuxO5gWl6M=;
 b=mjmHK/A1lt27LtoJVdzjdLDVDh94mhl2olX/NlZPs/LyCPWM0TodsFkh2lfXQuzolJ
 ceb9Viy2LuMMLWOdPTNS6hFX5jxpkx8Jj7F9FLi8Rzzt4G6xkd6ZAiIgXxCZm1gFDMXf
 PEySm9DCJItGupaEO1inoBNm9q8gwVxF3kgrbpbFaJlt1LNfvcZufwY7TkcTtQaHVuQA
 BPJJaB5A3JK8AZe5/T6NXZF6Jed1z4P1aLgNCnLgSM6X7zXB15JvTp7Gg7w8gRwmkbA1
 FObOxXK4fKJ6WCeh4+J83H71lHI2XA16zn4vwzCBwkkGRiuV0IOZNXr+fvnxzgoAv/XF
 HO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560411; x=1753165211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgFpG0rF6KVbYpLZQoXHGkLj2oHogtOGTEuxO5gWl6M=;
 b=rseIa3f1RKBo1PvdVb6yMOY0ugJfDbMp5P7K1Wj/7muABD95PmqHzCfPh5BlHABbdh
 4uSHuU04rVP+BHU5JhUK8uFkw4v1ithIMkcJwrANM8w4t0/OlMfQbZgDaijKAFEeMGXr
 NLJD65gWHDa7q/cf2ylY+CdLgohOY68QjnUTxEa3fD3ZnwIrd4yGaY04DdlhzWpejkuS
 9D+vHSds5LpxHkmTC4fN5F4eCDUNt2KppOy3Q8kGdNYm66ohQ2fJMX3GJcsphMqeX3en
 0+L3eF+srkb2Ky/XqHf/T9kKVwOWrzM+hOj0rQt4YafJDc7/zzuLXY5XVU8yv3bmjy1+
 V7rw==
X-Gm-Message-State: AOJu0YwOkF8nO64b6IlOgH7GwPtMN1JJivH2V8qqWibvxnbQ7ELszpQG
 HxRF6vva0LD/RI2PWIIBBvCOVXbN4wpOhWt2Km0rk4+R8d7PyMmTVtUOH6t2BmPf5V//oZBgwkI
 3BmzI
X-Gm-Gg: ASbGnctKiphjFaJP/v73oRp117fMJiNuO0cjPBSAJk+JXBfeEM2wjQreFwGiPP6YbUl
 raFMMRA8jkslxc666FGbMiymM0OjWARuhDtEypyhWMIU79DXch6SeTkVI2WpU0Fp+PlT5q3otln
 Nt3Nq2Un0VDmh6w7RmdTDn1HMpv+MbvcXrLGI5chrGJ917Kaa6gV48VUXcv4+et+j0ku6N7gZQh
 UjT/sGTM1Or3LEaKWry29BI+ZLei7FvYDsy/cV3QJzjcOw34YL1UUNld5j2CeoswzRHeO31J2PM
 Uwq2YNqYSnZ1uqZj1K6JrvUwRkoZNgx0ckd6VYjZwRhsN3zBQh8MwonJcTSGA5pP+M6L6gEtJwL
 nSYli6E9l8dfzaxsdLxREyz6PC4tQcyduDg22lX2Io1CSB0Q8WW4S28IXrOXQuissLoee9gn73W
 D5jxQzrH4=
X-Google-Smtp-Source: AGHT+IFxoEv69qpUFjeyT3G/ueHVC6NbQmo/GK7lh7Y/Vq1AN6tpPlLr4lNo7/ddtloI9jl1rKuA6Q==
X-Received: by 2002:a05:6000:420a:b0:3a4:d64a:3df6 with SMTP id
 ffacd0b85a97d-3b5f2daca74mr11812653f8f.3.1752560411187; 
 Mon, 14 Jul 2025 23:20:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b600722780sm6548582f8f.23.2025.07.14.23.20.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL 10/17] hw/microblaze: Add missing FDT dependency
Date: Tue, 15 Jul 2025 08:19:10 +0200
Message-ID: <20250715061918.44971-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

These boards ship with a bundled DTB, and dtc will be required for generating
these from device tree sources. Prepare for that by adding an FDT dependency.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250708204806.1898-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
index b0214b2c8b2..72d8072f764 100644
--- a/hw/microblaze/Kconfig
+++ b/hw/microblaze/Kconfig
@@ -1,7 +1,7 @@
 config PETALOGIX_S3ADSP1800
     bool
     default y
-    depends on MICROBLAZE
+    depends on MICROBLAZE && FDT
     select PFLASH_CFI01
     select XILINX
     select XILINX_AXI
@@ -11,7 +11,7 @@ config PETALOGIX_S3ADSP1800
 config PETALOGIX_ML605
     bool
     default y
-    depends on MICROBLAZE
+    depends on MICROBLAZE && FDT
     select PFLASH_CFI01
     select SERIAL_MM
     select SSI_M25P80
-- 
2.49.0


