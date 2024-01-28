Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C908C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0a-0004on-31; Sat, 27 Jan 2024 23:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0Y-0004oZ-Vg
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:02 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0X-0004MI-BG
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:02 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-59502aa878aso892602eaf.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416980; x=1707021780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gt1CNQckx8yO7WR3bedyoAfBxjm8E850nOtIhoFZIA=;
 b=WJdnCzucKZBV4towWVl24R5F++q0UC7aooRKRVdEr1NrI1SIwOPwOwnsSTa/8bsqgw
 idc5cJdzLWbUjiLmxd9QG4KIMNpVtFFFSXu+Wvvz1KnxbjZq/yGSNIudUGr9MwVFl3C4
 v9x7huVVhm1wo/Pvo/3IQ4AVydOgxH8boYalJXeXAWg9vF5oRBolMslBNW/1YxEhgWto
 2RSdg2Fhysh7ixasKRJ4yyhqE0EyKIXKrm+qtprToll1urUAIyhVlMQ6ypVxshbity8u
 82mNg0ze2JUAJ4dcPkqGLeK23L2ZrcpJMB1CJBLepEYUghlZ9Mz7qTZZ5RdeoMRavWIw
 n48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416980; x=1707021780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Gt1CNQckx8yO7WR3bedyoAfBxjm8E850nOtIhoFZIA=;
 b=nkWsa+9IKszQZLk6mo4uYAcVAaS7g0rQMs8d2mJvcb7BHVD99fpoWzsidAEJE30PCw
 I3NlwkxqqtBBAGPTrPPB6luDUry/x4haGMp0TYsgcJp95lnZeeNH5ROXxUVaI6TBeu/t
 7NzHyTlUEoyQYphiDNUomtGXoXDDfDFpmDns/v8iLz+rn7falL+R5jTNr3Giqv/6n97U
 4bbNDTKmxNEHZ4JepQQnaXXPRzmZQnU2QvDwktzjc9TZHWcc6tB/qT4aoZRXHluHy8X6
 J6ckEXBjUNP93XSMDQmHUjSUqDpdIw014N0gumdyI1NsrBBEhIc0v5UG6mu+zB4+e+Nm
 l8kQ==
X-Gm-Message-State: AOJu0YxEP28HXgZt9AZIWeNnujV1PrCTMYjYxOPGDoMarNPVyhcDmDph
 68nDD+n5t1Ne6gfUDbyS8VdOO8g915XB8OYlEghnFWDTy/okxmhYE13c3+gmEVe2s8p2sRxiStD
 tig5Dvw==
X-Google-Smtp-Source: AGHT+IHKOjdAhCfbPIdMghraXMGmP3LDCEbjqUjU9s7DX1xYeJcB3q1unkvroBBod6ZpguoBSarosA==
X-Received: by 2002:a05:6358:cc1b:b0:176:b6fe:db88 with SMTP id
 gx27-20020a056358cc1b00b00176b6fedb88mr2148763rwb.64.1706416979988; 
 Sat, 27 Jan 2024 20:42:59 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/33] target: Make qemu_target_page_mask() available for
 *-user
Date: Sun, 28 Jan 2024 14:41:57 +1000
Message-Id: <20240128044213.316480-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently qemu_target_page_mask() is usable only from the softmmu
code. Make it possible to use it from the *-user code as well.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20231208003754.3688038-2-iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124075609.14756-2-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Split out change to accel/tcg/perf.c]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c       |  5 -----
 target/target-common.c | 10 ++++++++++
 target/meson.build     |  2 ++
 3 files changed, 12 insertions(+), 5 deletions(-)
 create mode 100644 target/target-common.c

diff --git a/system/physmem.c b/system/physmem.c
index cc68a79763..5e66d9ae36 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3431,11 +3431,6 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
-int qemu_target_page_mask(void)
-{
-    return TARGET_PAGE_MASK;
-}
-
 int qemu_target_page_bits(void)
 {
     return TARGET_PAGE_BITS;
diff --git a/target/target-common.c b/target/target-common.c
new file mode 100644
index 0000000000..903b10cfe4
--- /dev/null
+++ b/target/target-common.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "exec/target_page.h"
+
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
diff --git a/target/meson.build b/target/meson.build
index a53a60486f..dee2ac47e0 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -19,3 +19,5 @@ subdir('sh4')
 subdir('sparc')
 subdir('tricore')
 subdir('xtensa')
+
+specific_ss.add(files('target-common.c'))
-- 
2.34.1


