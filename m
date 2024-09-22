Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F311CCF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLIQ-0004O0-7v; Sun, 22 Sep 2024 08:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0000x1-Ra
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHJ-0002O9-6h
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:28 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c5b954c359so1133739a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006483; x=1727611283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2ZjvXoH00iViMW0slYpXozl5B8ORorypWDbC2UouOc=;
 b=FW4yZx0M90I7GvgyIyKy+MokEVi+Qw4pMOQCpuFbtHoaadtQSgIqfX/1WCJrpRytr1
 EDQPfE7eQbxlcyqITHFVuoXP27dYT7ypmRwXXnThYIhT3ShNuE35YgspXmILqfpbX2Z6
 iVOmI/aFPwQAj/P4AaHJbsKZSIDbsvBKzTOv/BqoF7FOeeICOci+A9meNqmLCYXtfRgI
 TfyNMX93uDxWSYLs4prG8GK3CzPiY+WEXQ2Mcl/9ogAIJ9CxZfkmodGblG7VKPMntETT
 ess+hOHr65L7bk4Do7KSSM+lx5J5vgrA3hInn1ndoNJP6G6J7yekBXSG1Y6ihwEQF66a
 6dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006483; x=1727611283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2ZjvXoH00iViMW0slYpXozl5B8ORorypWDbC2UouOc=;
 b=ryVGjv6Uc2d0DKvlI9P5xbVW4IJu8J706RK0PfxVmiC+bd95IYEHG7Bsb4OzI5H/6i
 pH2zWNegKkkfLYdWpL8U2Qo7rHmUDv0MX9YE/LgU84P7bAff66D+jUHVKs5+LeY7k196
 V4dWPsvjiKu4c7JKQb778KYItblQ8aFM8PBQpyw1Ve4ZHhiV6uB3HMDi/xHlunShuO/Y
 TQxfc+JQY24X+m1v8LD8wsoLTzN6mUWUF64l18sOruiNCoFpRdzCC47EVPXAr0uvha4e
 P4e0+ZH7T8ZZGFvmOo/W+GcXS+L/W8C//XYSp+zZCfvQxwAQaCbnCeANAG4k09TJFjsK
 nxQQ==
X-Gm-Message-State: AOJu0Yx74TyOUIyA+lNILS5QqudsJFtIRzNlPzjd2/3O+tEk61N4Tl38
 cUiXyj52XIgknqJZ/p4s6UTIBpa/OQ437py3dTFtonMm/soDbhaHYlMfJeKGS1rQeBrR8eaubKc
 WQZU=
X-Google-Smtp-Source: AGHT+IHFb3pxBUy7fhOJMIUAYjLdkAb56xiyQIiktsaI4aWjVzaga0MqcIAy/XmathJc7rjpPumQeA==
X-Received: by 2002:a17:907:7b92:b0:a8a:9246:7f57 with SMTP id
 a640c23a62f3a-a90d4fbcd4dmr1057994666b.4.1727006482864; 
 Sun, 22 Sep 2024 05:01:22 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/31] tcg/i386: Add predicate parameters to tcg_out_evex_opc
Date: Sun, 22 Sep 2024 14:00:56 +0200
Message-ID: <20240922120112.5067-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
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

Extend tcg_out_evex_opc to handle the predicate and
zero-merging parameters of the evex prefix.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b1d642fc67..f94a2a2385 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -674,7 +674,7 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
 }
 
 static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
-                             int rm, int index)
+                             int rm, int index, int aaa, bool z)
 {
     /* The entire 4-byte evex prefix; with R' and V' set. */
     uint32_t p = 0x08041062;
@@ -711,7 +711,9 @@ static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
     p = deposit32(p, 16, 2, pp);
     p = deposit32(p, 19, 4, ~v);
     p = deposit32(p, 23, 1, (opc & P_VEXW) != 0);
+    p = deposit32(p, 24, 3, aaa);
     p = deposit32(p, 29, 2, (opc & P_VEXL) != 0);
+    p = deposit32(p, 31, 1, z);
 
     tcg_out32(s, p);
     tcg_out8(s, opc);
@@ -720,7 +722,7 @@ static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
 static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
 {
     if (opc & P_EVEX) {
-        tcg_out_evex_opc(s, opc, r, v, rm, 0);
+        tcg_out_evex_opc(s, opc, r, v, rm, 0, 0, false);
     } else {
         tcg_out_vex_opc(s, opc, r, v, rm, 0);
     }
-- 
2.43.0


