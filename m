Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3840C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGY1-0003Hc-9m; Tue, 08 Jul 2025 18:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGFn-0000UF-RX
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:53:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGFk-0003I3-Q1
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:53:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so41094315e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752011607; x=1752616407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91kh8gM7bE1DvG8K9EhiXTHWKL7JzNJQDQuB0S1EOTc=;
 b=IHUFDqXCfKJXgCFnMt7oJMBpvCNJJomYd7DKtkg1/6h9DVjgKHlmbKaoyIrcDi/8O7
 RIbBlK3xbDzhbCMPfKG9Q+EPI+Em/jme5e0UqLd+G9u1t32l92jZ1ar47d+irypcNgX7
 PlcMv78vFoN18+5hif4gBLRq0USuUe8ZXvtdcr4ocqaJLqMmLcBiHbGXEFRbvV6EFocO
 BaOU99A4iNqmvxDTDmCLsZ1CeAmooecPnS0V63H7oCUdKLtY5sY6MG6pdQyzetywYUp8
 iaguY5kllyuX6HB1MnhkNLl85w1YubTGv9NyYWPo3e4Whty03Us7mf37jXAW0gzz87jC
 +Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752011607; x=1752616407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91kh8gM7bE1DvG8K9EhiXTHWKL7JzNJQDQuB0S1EOTc=;
 b=lKeY7PrsDrAy76rTdL8LUedl/aEs8wGAOcQF91v9gFonW32GQBA/QLSSsvL4kh6IgW
 zJH4mV3JKoAFFvIWsBtGnY6m75amOvobeqqR9JQ0YYBOKdmTPAJY06rAwaMeBIm5H2H0
 5RWD9gI/oCBFE3/jdgBOPVK5JB/eUwzg9oMlsbL/ufO9ZtPunxQeKRYUx2SxenFAuWJm
 VBxMehieGdQNLX3pMVCPiP47tA3uFkpYhBjG1//oZk822eZNCoEBXZH8SP42zaejfuig
 8OS58MBec+9pSe4h2uLiKvBgsfF8yIcoPrvSxSpiG+kua9QWCHnbfG+3FJnBmzxTKfiz
 L1VQ==
X-Gm-Message-State: AOJu0YzCNxhf7ySpPkhuBik28bm99cWxigyExHsevRQl7f7UT8u6H6Ib
 7xSoqFtuQ/PRxeK0QOF2dHOOMAAF8w9tWemi37fLIbwfv5SxFb0t2RcRI1PfedGG7fADG5NkWsa
 9ssWW
X-Gm-Gg: ASbGnctM1gYw9GKm199KIglqq9tJbrftvf5UxfoXZYRS4U/KwiPg3Jmt3I0g4sk41Id
 WUj6uQmpy2+EcCW1ioEM4CVswTuBveXBwvB+RdNWhyth+L8M2fdE2x6EiKSI+J7UDjLGoA4vAhe
 HyzQyO1EwGtqRx/ZUnf9AdO9u8+k2PyWwLiPDnA9Qf+ZRMnTpzqK5LiSqCh6zX0dZpu+FLmmiJM
 PSScrf3bK84u3Mpl6ECKHG+7Aln7NmuqYAuvL2wBpmQFDwWGan7SFvEbiceBjVIv0kP2q/AGLXe
 ZSwyE/fgdywK+93xsTf7l5jEa9YtvbSnPslrsNv4L/IrAzmFnBApz1FSiZXg1Dokux6hbBDha7G
 KNiGD18i7eADjOlRllqdGp6Mqc7SjyN/2twqwUbGlhg==
X-Google-Smtp-Source: AGHT+IEKeaIf8ydwFxaC7CzcMoJiykZ7tpJY4NEy7E6eR7UMiSfrgE10xDZswu4cPQ2P+J+t+Kl90Q==
X-Received: by 2002:a05:600c:4452:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-454b5d08af0mr194483995e9.18.1752011607002; 
 Tue, 08 Jul 2025 14:53:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5070691sm732755e9.29.2025.07.08.14.53.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 14:53:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-10.1 RESEND v8 1/8] target/qmp: Use target_cpu_type()
Date: Tue,  8 Jul 2025 23:53:12 +0200
Message-ID: <20250708215320.70426-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708215320.70426-1-philmd@linaro.org>
References: <20250708215320.70426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/arm-qmp-cmds.c             | 3 ++-
 target/loongarch/loongarch-qmp-cmds.c | 3 ++-
 target/mips/system/mips-qmp-cmds.c    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cefd2352638..d292c974c44 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
 #include "qapi/error.h"
@@ -241,7 +242,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_ARM_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, arm_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f5f1cd0009d..1d8cd32f5fc 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
@@ -32,7 +33,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_LOONGARCH_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, loongarch_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index d98d6623f2f..b6a2874f2dd 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
@@ -40,7 +41,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_MIPS_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
-- 
2.49.0


