Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A355C54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgch-0002ri-Sm; Thu, 29 Feb 2024 08:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rfgcf-0002qw-MY
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:38:54 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rfgce-0000Es-9M
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:38:53 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d3ae9d1109so526685ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 05:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709213931; x=1709818731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwJF+3CnpNGG98WPk7NHzEn6/tSKAf2k0ZhiIYuVeiY=;
 b=GI7MzZ54VzSD+VwNrETlL/FmULm7YLse3coygyLHphb9RNXJQXeZxZfMdd2iHKTlzG
 gGyT9LjpXBsYDy/OwJdln32fzRBJ3LJgD2PrPk9OCirnewKKcP215Upg1keAtOoVUqga
 3IjcPG2/3MyT+MMRD1zgH7yBRNn8P7VkKfiG4qx/b/1ugcE4TfHJ2e0YpV98ykvzr7wn
 tMJMXEV/n9Ui9ETz1VF0zV0ToTeLJfPoIWsErhITSJYksTFJ2MLMUEQACCKzu9o7W7Kf
 Tik4MKBWxp+x4VzTaaig7fhdqwREzslqBdyHIAR2iM6GJebsU+1EFLDSJtKCq+VvhRYl
 suhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709213931; x=1709818731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwJF+3CnpNGG98WPk7NHzEn6/tSKAf2k0ZhiIYuVeiY=;
 b=gal6YZ2V+zrbIogMx9hBvfWWqJ+fEmahZiaYjW+BHuUmMjHAO8IU+XZfAkHBGyySbS
 sq+8zN35C6j9RKKbCnZUQLcBMKhc7tlDyBudGtN54MAtSIZKHymQmH6nx2GTgZMxS2sP
 B1D4mLomI5yLOnF6rQRN4Ppx73IxhFTE4PaUIyhzwHZKYcXbwHH16A5AbA2EH44fvNv2
 eEyRVn8NTRg0p082J0Z0QmRUhL5ofdfFafHytiRhtaDfF3a161h05GEJ9PqJHvXaEOd7
 PaWJjT8XRZW6Bfa98X4/WKlBAY0qnESR7nuXnGtA7c5R+UCxsKoRqMXL2qjFMkVCgNcM
 awvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF61ae9u9RMD5c88shp5OqLHRAF76TzqEPABYMu+uROfa79heExvDUQ70TEwkU1b3nMxIzkgg8NZin6V6lJVP2qeJYAS0=
X-Gm-Message-State: AOJu0YxDa+12ZS/K1QOj9+B4IKQalI0Adfx/mfKLR50K9j/U8GFtu/mk
 0HWfOkMJl9NpIF5iDNSXI1JntFSitKe+psNJjiEHJMJInZdZnbQSIjsKnPBQw/kFbrB4XcuAb7y
 t
X-Google-Smtp-Source: AGHT+IH9F5e3AGFt8HeB5MeK9lzOPX3dQy1cUr5yJZMWKw9YLUdHw7KJCxI9wKWM1tfY/ylWHqrtig==
X-Received: by 2002:a17:902:ee82:b0:1db:4b1b:d726 with SMTP id
 a2-20020a170902ee8200b001db4b1bd726mr1989325pld.1.1709213930826; 
 Thu, 29 Feb 2024 05:38:50 -0800 (PST)
Received: from localhost.localdomain ([49.37.249.67])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a170902fe0100b001dc941f145dsm1454918plj.253.2024.02.29.05.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 05:38:50 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [PATCH v3 2/2] target/riscv: Export sdtrig in ISA string
Date: Thu, 29 Feb 2024 19:07:45 +0530
Message-Id: <20240229133745.771154-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229133745.771154-1-hchauhan@ventanamicro.com>
References: <20240229133745.771154-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x634.google.com
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

This patch adds "sdtrig" in the ISA string when sdtrig extension is enabled.
The sdtrig extension may or may not be implemented in a system. Therefore, the
            -cpu rv64,sdtrig=<true/false>
option can be used to dynamically turn sdtrig extension on or off.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5d5d8f0375..6f98c0195c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1461,6 +1461,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
+    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, true),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
@@ -1724,7 +1725,7 @@ static void prop_debug_set(Object *obj, Visitor *v, const char *name,
     RISCVCPU *cpu = RISCV_CPU(obj);
     bool value;
 
-    warn_report("\"debug\" property is being deprecated.");
+    warn_report("\"debug\" property is deprecated; use \"sdtrig\"");
 
     visit_type_bool(v, name, &value, errp);
 
-- 
2.34.1


