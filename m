Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03015C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubd5g-0004kh-Sx; Tue, 15 Jul 2025 06:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5Z-0004iV-P9
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5V-0005nO-0c
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so37469185e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752576039; x=1753180839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlnnQVYR7UDi9FQuqtljHTy9JqrOVxDZXhuwIJFwMtU=;
 b=m5OyBd0IcXQ6ypUcJnesDvr4fcnkDicnchkDQCdvlt/pXfX0+in7rwv4l9GDzYLaV/
 SHRXSwzpq8syU1hRTzBBhsNTA3DyvGeGwoGU5Qz8eSPJzd5aYDLA5s7wCqNEkSeMINSg
 9K0Fg8jkLq4J46C/smQfQH2kmhUUW/3E3gsBGjCEgbnwpXjEtqBKvFn/m7890EchUjKZ
 tK++bGrQZmudm52j7+OZosuzLyz+6HAeclxMi14fmNIMtPtFqBBzpC/9FGoPCjVbQhY2
 ruig1rDczoJViCbLprPOMfzBVQ+C8x/X/YR50l469ce2BMIi51ZX88Iei/+7/uPnuuKK
 xInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576039; x=1753180839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlnnQVYR7UDi9FQuqtljHTy9JqrOVxDZXhuwIJFwMtU=;
 b=nrQJHJzBYXEuWrYGLme8mtPOfQOOC0yLba+Qo5mKt5NGT220IeqMEOJi1gLe5YR+IT
 y+B0WuMS9X21Og3WPKd8YSYWmgE6fQ/FxUZsXlmd1NAaJDJDRALGhPF5dGUrfE8RRphl
 ehUZC6uL47WUmz2xRU20Mc4R3TFFhUeuqdC3dNLK3/wCd7b0Vw8kBOCiR2NCsOkgmGcf
 kB9b09AVx+9OAEHY6LKI6LsMirTExA2EmsGOuc5YA1CFPdCLKzF2BPlO35X0jd5h5QRm
 HjbJMhpTFvLTxEQVB14pqHQajYCy23xukg2Cfowxa/Zq/TM2jNru23OFFif6FqS6giEC
 BP1Q==
X-Gm-Message-State: AOJu0Yw5C50zUSs0PpLzJRBKWIYWQUBBCwjPo80waB4zmTZg1FtDieSJ
 CKD8quO+o0a7DLCKFZC0MlYQu6/YkMCHsIfffjU0i6a4skOU2xp6dd8z6GuFlbOtq1WGD1U8Xnk
 3kTPm
X-Gm-Gg: ASbGncvrJRCKNwzFFYwixQIrRuK9vVYCuY6P2nNbIVuIDiMuWg71sWDewqodYto9EsJ
 1iy5JGCsCSp8CRTH4iTtFOhfPb3pB9LQMl4iJvap6cuFIQp7EideEmTW5t6oKc9UmmffRpelCXU
 ZFafrqZu4UbneWCzJKejZiyn6Vlpl/bGDK8q3Pxh+7gj6RPorJNbjLi8FcUHk50hzQ5NQ2C022b
 Gn6aMTQxW33FCRj1Iu351dnXlao8B8J6dkpXRPfaM+ElnW2JeyzewFoU/fKn/fUkHqybtC5s/qT
 xWhzS6CNlU6Hn373OwHr8iWwcY/5DLiZFa6PfIO34Vmy6zsmh/MzNbsv3kdX6H+HcrJGoL+9uEc
 HGwuJSMc32xTbQhQ6UWgcvNTmSOiCCtTJSpRH7p1qR1N1aLK0AhO5H3dawjaancwK5h5lltpkfc
 oKSUQ5vUaqmfie
X-Google-Smtp-Source: AGHT+IEfiKtUlY2NC3T23b6YhD2TXornCw2N7iQ9AKSkfMpzVs7HgdyMgnjHsiNkknOiZcS6N1s+cg==
X-Received: by 2002:a05:600c:154c:b0:456:1824:4808 with SMTP id
 5b1f17b1804b1-456182448e1mr58815025e9.32.1752576039051; 
 Tue, 15 Jul 2025 03:40:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5f5sm14910909f8f.56.2025.07.15.03.40.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 03:40:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH-for-10.1 v5 4/7] accel/system: Add 'info accel' on human
 monitor
Date: Tue, 15 Jul 2025 12:40:12 +0200
Message-ID: <20250715104015.72663-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715104015.72663-1-philmd@linaro.org>
References: <20250715104015.72663-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

'info accel' dispatches to the AccelOpsClass::get_stats()
and get_vcpu_stats() handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/accel-system.c |  8 ++++++++
 hmp-commands-info.hx | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 76cf4e7ef7a..1e97c64fdca 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qapi/qapi-commands-accelerator.h"
+#include "monitor/monitor.h"
 #include "hw/boards.h"
 #include "hw/core/cpu.h"
 #include "accel/accel-ops.h"
@@ -103,11 +105,17 @@ void accel_init_ops_interfaces(AccelClass *ac)
     cpus_register_accel(ops);
 }
 
+static void accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    monitor_register_hmp_info_hrt("accel", qmp_x_accel_stats);
+}
+
 static const TypeInfo accel_ops_type_info = {
     .name = TYPE_ACCEL_OPS,
     .parent = TYPE_OBJECT,
     .abstract = true,
     .class_size = sizeof(AccelOpsClass),
+    .class_init = accel_ops_class_init,
 };
 
 static void accel_system_register_types(void)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d7979222752..6142f60e7b1 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -267,6 +267,18 @@ ERST
         .cmd        = hmp_info_sync_profile,
     },
 
+    {
+        .name       = "accel",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show accelerator info",
+    },
+
+SRST
+  ``info accel``
+    Show accelerator info.
+ERST
+
 SRST
   ``info sync-profile [-m|-n]`` [*max*]
     Show synchronization profiling info, up to *max* entries (default: 10),
-- 
2.49.0


