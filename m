Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FDCC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UVI-0001KH-Kt; Thu, 03 Apr 2025 20:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVE-0000ue-OW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVC-0003Bd-SR
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1193256f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724901; x=1744329701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dncWdRA4NNhUDNyzQZGGLA4K2lDkI183ST8pz1FTTJM=;
 b=hPhoitybx1+Ywlu/jIqpDMxhkeUaJyG6W6JSNy/Qo+wODw1syKdZC1+I0e2IM8eUet
 pnwX10/1Ip2bnUj+09gNxWZemLlEIdskPys3z9BbDXHquHnYIRlD9uRq4bify+nXgGAK
 QCvgbYOt24sU60z0aHSYQt6wSqzkH3kQDvjGxWbQaLNndUt9A160Nlr+Y19eiZNeYk7G
 O4EGhJFkRmgs9+NBdM+FkZ6m6C4dkp0h7ZJwp0Wdhv3nffL4i/qdsUiH8vhI1dUqrJbX
 uNvUjGQRYHCxhEZLr8uvy58dhlc00WMnb4uHOinxmimpb1GAK1v+kRfJcJT7RxLYaMZ0
 iyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724901; x=1744329701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dncWdRA4NNhUDNyzQZGGLA4K2lDkI183ST8pz1FTTJM=;
 b=VZfrenaD5J2zsr32j6YN9qzlMFMGavetgDicB62/OvWhfMC4yoDiinVLzzX1FQiLzf
 65kLvDXa43gvqghd4MlC0VZgJ/QUN3z6VZx8BE+CB5lsIUEJfRc3KaCGWszNYaI9AAhi
 gfPwyWoIV99ixf4TGL8vgjSW5dbCSdda+Xz1pmOVEk8iUqDZVkXBUtAs0pNope8IBOer
 IxJbQg1ZjAUQAxr4i6zTcnaJiAeXZeZNX0gteS2NFAZbH9K8HaceqTdp1jJ0cLuiwO5B
 qByRmMs/79W5GaoIhtlNj9grPNC3IMzb0NkI1g1FkhI2hukA9wau2R/cR33l8LVr/MKN
 I00w==
X-Gm-Message-State: AOJu0Yw42fsnNxy1O9JLr6oEpNGZ3GWKk66bi1k44ppfO5xd+4Jgzo73
 cGZKQ+D9zWKAcunobo08U6QT3XgCh/WkZXVmMt/B+RZ9Dnjm2yHKe644lTmDC3OuhxT7w+Ve5GV
 k
X-Gm-Gg: ASbGnct+roI2IXNN1h1k9oDuY7WBzE5cECdRPtbn9T2Z1kH/5G4Zyh+FuvG8UdM6hKC
 9puppzLEeixIDiCE5l+kcCJWQ2BHWaX0Z8lF3xurnGl/Gxorp7FrsugcikABmPufn07fV15uz9v
 tj9giIUt9hT0ZLZGMumIVk1/Qw1RMfaghtLyyN787K979YrlwHsMCv005LzyJhY8JCkuEqQhK67
 /SB9Sia3GG9gavwXnr0+BGUNTXp+gsY4ygTaAXDijiLbwbTfxBtvl87tRgyBt5qYio95DvxhqLS
 BA37g1PIAvFAXWRDDvCH1L0odR/EHkk78ZGRQgzeyhqlhQaJRNrn2ny+8GP4y23fPUbi3gWn8v9
 8QMG76tzHLHWv9fWtjKU=
X-Google-Smtp-Source: AGHT+IGjG1R84fVAzjqWsK9Ze82Egq/p5RN6dfrVEcENuVujsxW1s6IsPSr3Iq1ByRDO708K+a5emA==
X-Received: by 2002:a05:6000:178a:b0:391:43cb:43e3 with SMTP id
 ffacd0b85a97d-39d0de67a65mr328125f8f.46.1743724900715; 
 Thu, 03 Apr 2025 17:01:40 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096401sm2982309f8f.1.2025.04.03.17.01.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 30/39] target/arm: Replace target_ulong -> hwaddr
 in ARMMMUFaultInfo
Date: Fri,  4 Apr 2025 01:58:12 +0200
Message-ID: <20250403235821.9909-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 01408e40a34..d6ac00be0f2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -25,6 +25,7 @@
 #ifndef TARGET_ARM_INTERNALS_H
 #define TARGET_ARM_INTERNALS_H
 
+#include "exec/hwaddr.h"
 #include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
@@ -726,8 +727,8 @@ typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
 struct ARMMMUFaultInfo {
     ARMFaultType type;
     ARMGPCF gpcf;
-    target_ulong s2addr;
-    target_ulong paddr;
+    hwaddr s2addr;
+    hwaddr paddr;
     ARMSecuritySpace paddr_space;
     int level;
     int domain;
-- 
2.47.1


