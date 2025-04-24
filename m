Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C3BC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 18:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u81Og-0003dL-D6; Thu, 24 Apr 2025 14:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81Ob-0003b9-L6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:34:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81OY-0007lw-DJ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:34:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224019ad9edso19739765ad.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745519637; x=1746124437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dV6kNi0FTww4zMCdoDaGt2FwS66xHIgmhnvrrJm5V+4=;
 b=Cwt5BvMakLvRUHwbN3GlTDRL8CF/1R7+N/WSD2FMEoihs/GnT6TZ7dmr5uIUn2FgAO
 ccIIS+qS7IBRm/sygLIvfNFt9QbZrTiiZw/HGiBBvrEl6NZ9QHy0wVtsAQZYYm2FXr9J
 oU1hxKBelCr/ub7rJFZ1KdMztuwEeo+I8oyKLuQk4+b3D1nkVwJUQ4G20eWFM2WdXKpj
 tDQY6o9S6/Xm815zkRgkZ+uRbDkIy8wXEijFVTkPXvasv2SD9C8v8nLR8YKrhzrTQsZ0
 FXyOSPa+j3TiZwV5HCBdBB5vmaPAmfa3vMJ+BclXjGOTZOSJqE+NJ/v+G4Tm62vKOGah
 jMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519637; x=1746124437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dV6kNi0FTww4zMCdoDaGt2FwS66xHIgmhnvrrJm5V+4=;
 b=mIG/FeO8fqVgFXMqjRc1nP/PxCNFGXkez+BDkuGABwUkJdx70fYx2s+ulJj+CzJU6w
 lTo++/BQtypzkhMH2qchlSQ/dLeVCFo31EAJ6QUbiOXJb033hX14dx4NSOj7AuLn50jU
 ruUAK3fJ2DZM4sGta/2ZF5cSPh9QowhW1Vdn6t3oO0x690LnEBSFvmge5W12kDxj4RPP
 SzgFq1w/4N7oGECwKy9zg0QqsCEpaJpGmn4Gh5qJvHIDYmgItsWSLpy0Vi7YRgzF0DcM
 jmuTmkkqA5Ihh7jEtz9fa/I7ZpjK+49u1oLgePnjOjO9SEiEhEmSBIWb0dVwK/GHB4dT
 LM2A==
X-Gm-Message-State: AOJu0YzWHmPXw4/KSh0hyTOUHDFvW0SK0ieijVsqCTaOc5gPX3lIWaYW
 lotRsVRRDq/YhQxP8+B7HD21w8O1rkCYytMUSUyag35joqnk1CG7/TbK/U6Cf/jJ2lxBhtL4gld
 GwiU=
X-Gm-Gg: ASbGncuoO0H1HqYYNDN+3lrns0UrY1DDhp3klX0doIewbCLcu41+LNRLvpQI6snzRwN
 n5Oepi2WPzLS+uHvWMA9WkDw0vTv00zBuXooRSrql5Mx/SvCnteqz98t8eRoKLp7YBWGbZHmMev
 5RjCQA2CKxbH/vSmMv/BAQn2kHYQJVp4u0humrAQ1J9LXsuTEh4S/CSk2yU6ioeHvM6H+e4KqRT
 NadnxgmGPduTlEfZS5jV3G8+ORmjIDGA+tXDY7a7tu610rkFGG2/IY7jQMXkTd/btJ5zfrOVfzJ
 epbIMQptph+4n/Pv4BaWWzE3F3gkHuqgirQm32FG
X-Google-Smtp-Source: AGHT+IEzUs1louzJohwSFH4e03wH3XbbRR/VRvrfHsB4wYl/+UMnCm3H2bWK2Jzk4E0q7TlVAQStYQ==
X-Received: by 2002:a17:902:ea09:b0:224:1609:a747 with SMTP id
 d9443c01a7336-22db3c33fbbmr48896735ad.31.1745519636852; 
 Thu, 24 Apr 2025 11:33:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa80fbaasm1544157a12.49.2025.04.24.11.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 11:33:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 1/3] qapi: add weak stubs for target specific commands
Date: Thu, 24 Apr 2025 11:33:48 -0700
Message-Id: <20250424183350.1798746-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

We are about to expose various target specific commands for all targets,
so we need to stub not implemented qmp_* functions.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
 qapi/meson.build           |  3 +++
 2 files changed, 41 insertions(+)
 create mode 100644 qapi/commands-weak-stubs.c

diff --git a/qapi/commands-weak-stubs.c b/qapi/commands-weak-stubs.c
new file mode 100644
index 00000000000..9734263c32e
--- /dev/null
+++ b/qapi/commands-weak-stubs.c
@@ -0,0 +1,38 @@
+/*
+ * Weak symbols for target specific commands
+ *
+ * Copyright Linaro, 2025
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <glib.h>
+
+#define NOT_REACHABLE(symbol)                                                  \
+void __attribute__((weak)) symbol(void);                                       \
+void __attribute__((weak)) symbol(void) { g_assert_not_reached(); }
+
+#define WEAK_STUB(command)                                                     \
+NOT_REACHABLE(qmp_marshal_##command)                                           \
+NOT_REACHABLE(qmp_##command)
+
+WEAK_STUB(query_cpu_model_comparison);
+WEAK_STUB(query_cpu_model_baseline);
+WEAK_STUB(set_cpu_topology);
+WEAK_STUB(query_s390x_cpu_polarization);
+WEAK_STUB(rtc_reset_reinjection);
+WEAK_STUB(query_sev);
+WEAK_STUB(query_sev_launch_measure);
+WEAK_STUB(query_sev_capabilities);
+WEAK_STUB(sev_inject_launch_secret);
+WEAK_STUB(query_sev_attestation_report);
+WEAK_STUB(query_sgx);
+WEAK_STUB(query_sgx_capabilities);
+WEAK_STUB(xen_event_list);
+WEAK_STUB(xen_event_inject);
+WEAK_STUB(query_cpu_model_expansion);
+WEAK_STUB(query_cpu_definitions);
+WEAK_STUB(query_gic_capabilities);
diff --git a/qapi/meson.build b/qapi/meson.build
index eadde4db307..ba9380d3f03 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -147,3 +147,6 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
   i = i + 1
 endforeach
+
+system_ss.add(when: 'CONFIG_SYSTEM_ONLY',
+              if_true: files('commands-weak-stubs.c'))
-- 
2.39.5


