Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA22C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyj-0000iD-GW; Wed, 07 May 2025 19:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyh-0000hQ-Gk
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyf-0007B5-LM
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22e4d235811so6191155ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659700; x=1747264500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPYvM/Yfcpm+cjpevJkSeWtzrQnOVm30pMe7ne9zBMA=;
 b=pZknOLXa7L6Nf5pqGgQszSuXJ/LWxk+YGxHRrh13f2mdOtfM3HHHYOaSr5w4tf+Oiv
 AAK44zhjoCmV5FpsHFxmnHjTxU04nXsIlEgtoy2Pk0kR7mwSatVTrV3985NGiOHVfTSF
 yyV+fClvvhjjnKQDIrZDQaNMYh1JdTaLw6rgAFNd7et8iNmYc4Dzh11Pu800VY5lFITh
 6csoZNtRUxtGbHMdv/TiW0fBGN2Jbw+jUELznLBDfO8oEhls/MJX787m7GknVFOE61eJ
 REWUAtaX6VZCv5CGIrioO97ESqLTAlXGJI3m2GtcLDgHXAbEgkwwaGnxxO8nsge0gDT+
 F8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659700; x=1747264500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPYvM/Yfcpm+cjpevJkSeWtzrQnOVm30pMe7ne9zBMA=;
 b=K1TVXcMf/9i4RFnxCMUfW/SnZMLqxRqh/UpLxQ+jdi21IkDf6G9RzGRikyaWsn1QAb
 Mo+fDuYGYAgUahAJl0gHF8davYS5lLkyZd2TAIB25C+CodCz3Z47UUs0n3/owlIIrhef
 +VT17iQYvhq7bVkskJbC0ars30+7LDinDaS3ah2t63oBdVWzXnkar0AaEUKUr7tc6NZ8
 y5Vrhzk8So5a8XLuVIvERnSLPGLEk0NcXRJAR7Is4mdjKEgmLH+s2a6KUecjXMK/qj1i
 QlSXsLckDuMzYONzRlfJNsRPpEUXuHaUT3WkjdgdvzrqI0oaqSmeif4xzO1TgOs3c4yM
 r1gg==
X-Gm-Message-State: AOJu0YzuKbEOU9gQHYCqR12dkm17TO2/oJMoAZM74kO/z7TKwvxoVMGl
 LaQ2lJHGvKlKMohjOx05M+akXR9nF5hMSSsfcPozqJl0y/buuC8Era767iIDqfmvAMl/G0Vj6SW
 q7h2wiA==
X-Gm-Gg: ASbGncv/BnITn/iafRjhe1OcQ3MRbXjL6mGxZb/a9Vh8BxdSASStSsijj9czDWDFOrn
 16WYdo7slpzVgvimKLSngnjGIqLFVmNAzRd7x0yAKsv13BnLn7QuloiSpkvef/MtATws0rvQ9FD
 ci9AKntieAOXNh9mJbvtPXs19tu5azUVyhXKKZo9FKbC5s7CuykXhTyR74sgvV+4moRS2OS1bbm
 1dyv2Da0VmPlFohgCtvc9pmKT/PKX67bkngjtzPqYtRHs3m7fX9Fg+InQ/DOfWrvaVbB4k6/oUa
 6RNG1nSPgLA8E6GkUM2/+KoxpeJWcJ65h9Q01wsy
X-Google-Smtp-Source: AGHT+IHepp6V73X3BRL3UlYuNN4CcKjmh718S2khwadIUiCkZF8HHu75OX6j7e215kH83aFiIK0IBA==
X-Received: by 2002:a17:903:3bcf:b0:224:24d5:f20a with SMTP id
 d9443c01a7336-22e8f0b62b7mr16441615ad.48.1746659700371; 
 Wed, 07 May 2025 16:15:00 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:15:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 10/13] qapi: add weak stubs for target specific commands
Date: Wed,  7 May 2025 16:14:40 -0700
Message-ID: <20250507231442.879619-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

MinGW does not support weak symbols without at least one strong
definition, so we'll have to detail stubs per target. Sad.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
 qapi/meson.build           |  2 ++
 2 files changed, 40 insertions(+)
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
index eadde4db307..60fc958ec10 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -147,3 +147,5 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
   i = i + 1
 endforeach
+
+system_ss.add(files('commands-weak-stubs.c'))
-- 
2.47.2


