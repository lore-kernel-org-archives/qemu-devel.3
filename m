Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758A0C3ABC6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyj-0000iF-Ey; Wed, 07 May 2025 19:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyf-0000gQ-TU
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyd-0007Ai-SD
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e6344326dso4944775ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659698; x=1747264498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AD0wBkIB6INtnwcEFWKK+z4tJ5aOGPeiDtfz2k1oSg=;
 b=UW3dIm98PBw35sXFTNGIRrAaqzPv76CJou4gKKQHfQjfFUNqchPdvStDbjycr2m8e1
 DcYY95iPQ8JdsBjn7fOuGQhbHb1LhxEhJJAjlFq1TFK+FAC3sUd+nFTOsPxvemlvws8f
 xRuDcSZDUHEON6JDKnHtuNlJaay5lwyvS8pqWTdG5CaQ9Wyv2TLPrpRSvrF/6Iq+6WKV
 wK6thHYDMwdDos4zdpRNPXHResc7xirrP8+7CAEsAgWDJ14w3RwN9Y8Gt6YjH411C6BT
 +rv9Kzu0neNLMxx4qHcH36k+WhYrNQde/ZEBFw6ljGTORXdKcAy6LD/HWSetbi2SE5lg
 7G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659698; x=1747264498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7AD0wBkIB6INtnwcEFWKK+z4tJ5aOGPeiDtfz2k1oSg=;
 b=inH1bEb7RTnAB+w2p0/6UETgQHwbZ/iNoDXPRB3ZqQ4g+8PrmYshs9SuyjKtT2dcMA
 6VzOKfCH5txAc+Ki1OwkK2OyZtFnTr3mua3PaHvZSin+ObQMfSjRNqZlPPidLZMrOC6w
 A+H5RL6YlzB7A7TYR+ywUE47fhLOxniqHUVMkvTBoK0mddJyWoJab26YEqDcl6cBxArl
 esxsaQ2l7O7ZGQgCLT+X6Ta/s28Qv6l+A1/8522NAmqRXEENuMSKxjUcsV9FZEJxSQG7
 DGUesjgEnbjfsO7nOSZvV5aG+Mo6bqsMCU6EORChqiS95ISNfGR8IGRAABbmqkYUF5y/
 zJ3w==
X-Gm-Message-State: AOJu0Yyan9CMfoPRlZt0oGB354+LxdDj7al7ea9Zg9EmGU8YGefVLmG9
 eTsiw0JGrzr4YMyR4D3BwAF1uV22UUMU11GkN0VD1Yx6HDCpI7bUUcO8eDNq65W9fvJ+YBwN0+m
 fWP+Upw==
X-Gm-Gg: ASbGncsTBWdc9R4A1lqXFlVvIQQzUKr1lVSRyATvvmtpVQxMJ1B2mkZ/RYYh8Zi0qm4
 0Tue8292Y8xToaF8uR1yz3pHNZZkl+kQ9BYcSWntODPef1KS10i6/kjfx1QaAlj3YoNDDzZHsIk
 HR43kYc2FLW+sKvfstNvOKno3H5jpEm2M4OA4Yv02lBrL5n6WQb8R8Jt2sMkRM0RM1Atta7nUzz
 xli3cMSZQd8aPCw5PIrxxP5HLyHyEZce/86p/eobka7Gg48fdP/59Dq+o3HGU9fT6Lp18a3ztQO
 SXSKlz5dzoRp1Thk9xB1gbUq/HYcmN0kvfi57ZZN
X-Google-Smtp-Source: AGHT+IHkDxb/3QSYuqNyRMa7hBtpzZgcEsi99M+TX6miRHQQw6JxuczqtQjbR06TbHOaXWPjR+k02A==
X-Received: by 2002:a17:902:c94f:b0:21a:8300:b9d5 with SMTP id
 d9443c01a7336-22e861d5e25mr16823395ad.23.1746659698562; 
 Wed, 07 May 2025 16:14:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 08/13] qemu/target-info: implement missing helpers
Date: Wed,  7 May 2025 16:14:38 -0700
Message-ID: <20250507231442.879619-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Add runtime helpers for target and config queries.

Note: This will be reimplemented later [1] using proper information in
TargetInfo. Meanwhile, just add a simple implementation.

[1] https://patchew.org/QEMU/20250424222112.36194-1-philmd@linaro.org/20250424222112.36194-19-philmd@linaro.org/

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                |   2 +-
 include/qemu/target-info.h |  14 +++++
 target-info.c              | 117 +++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 6b235b291dc..7094832c3e2 100644
--- a/meson.build
+++ b/meson.build
@@ -3822,7 +3822,7 @@ endif
 common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
-common_ss.add(files('target-info.c'))
+specific_ss.add(files('target-info.c'))
 specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 850a2958b9c..d9c0df10c53 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -38,4 +38,18 @@ const char *target_machine_typename(void);
  */
 const char *target_cpu_type(void);
 
+bool target_i386(void);
+bool target_x86_64(void);
+bool target_arm(void);
+bool target_aarch64(void);
+bool target_s390x(void);
+bool target_mips(void);
+bool target_mips64(void);
+bool target_loongarch64(void);
+bool target_riscv32(void);
+bool target_riscv64(void);
+bool target_ppc(void);
+bool target_ppc64(void);
+bool target_has_kvm(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 16fdca7aaaf..f2bdae18f4f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -29,3 +29,120 @@ const char *target_machine_typename(void)
 {
     return target_info()->machine_typename;
 }
+
+bool target_i386(void)
+{
+#ifdef TARGET_I386
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_x86_64(void)
+{
+#ifdef TARGET_X86_64
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_arm(void)
+{
+#ifdef TARGET_ARM
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_aarch64(void)
+{
+#ifdef TARGET_AARCH64
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_s390x(void)
+{
+#ifdef TARGET_S390X
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_mips(void)
+{
+#ifdef TARGET_MIPS
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_mips64(void)
+{
+#ifdef TARGET_MIPS64
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_loongarch64(void)
+{
+#ifdef TARGET_LOONGARCH64
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_riscv32(void)
+{
+#ifdef TARGET_RISCV32
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_riscv64(void)
+{
+#ifdef TARGET_RISCV64
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_ppc(void)
+{
+#ifdef TARGET_PPC
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_ppc64(void)
+{
+#ifdef TARGET_ppc64
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_has_kvm(void)
+{
+#ifdef CONFIG_KVM
+    return true;
+#else
+    return false;
+#endif
+}
-- 
2.47.2


