Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3152C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx03-0004gS-6S; Sat, 27 Jan 2024 23:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx01-0004ft-Ah
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:29 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTwzz-0004He-Qr
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:29 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cdbc4334edso782591a12.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416946; x=1707021746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADBUc3fCETku7gSMiSslG1Ep+CbDq8k+uqgwv8Xr0vk=;
 b=GxFUAyKyJ2o/erIMEZwWZ75wlqDokA1HmbgjqiQ1d8Rs7AtwVK8V2R4UtBvGiIV0mD
 abe372aoUmeTGm6vh4dWrfWdJDvKgSyjJIUHnukSChm1XmnzAHgS9m0f8d2XuM7ULPpL
 dqyCNd9XQ5w6MxP4JEQmo5kT1PmTOkHn7dbL4LLgIxHqiKH+NNYhXcwetFp0+7pM6ehP
 3jZh0a0F9UIz8MAxtr91YHRcoETB0YM9Xi04BWdUKLJ+FRIqGps0FVnzOOaBexJKn9Eb
 n+0gHAAajbH/p0865xQqJSuQmjN0q6xCTbV68GMda7VQnXa6EuXqoUXT8yiGsoVNJGJO
 rNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416946; x=1707021746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADBUc3fCETku7gSMiSslG1Ep+CbDq8k+uqgwv8Xr0vk=;
 b=Fi6ZO185nDedax49ceU3fMngMEKEBZKYETDubuDiA7BT2BDd5U/bn6st55I93uCpaZ
 AWwewMoV4il5qZA2myQlc8Z9QHET6XGC5L3MTuU90DW73y5wHUn/mzTSZJ83dtCai23V
 lT9PXZcyRKKEzJNVX3b8j0iNS4bDhhBwKxFgTSBu9qxJflNw0pQPvdPjIkwZMc1Gi96A
 FsuQFb/Vs1H33779Gkc1mC7J6lAC9WQ+JyE0eDXtT8kJcqyKm7sQ9GkOJaQ5eA5zHJfC
 fJ8g0tGjNmL33kKYyDGnhMg0lLxzmZg/Wmkb6yk/58yXQ9WgUXv4g1X2hutiSygk6YmN
 3QwQ==
X-Gm-Message-State: AOJu0YyNig+XlQ/f/oKHwjVBHiPqDVrPf3bhiQbL6CTXc93UnpmnVG1E
 jbiDRn5oKlXTVQXW/0MZxIdKUVAyTs/o87jSxizrPXaE3AgWgcDg8tLOmgYBJSTCATmugC7oulY
 oSV6jjA==
X-Google-Smtp-Source: AGHT+IGni/2IOtdevUIzh4oxbadX3CrC8Oy9rUOG3cpQHcc43qMaTLhwe6RH33xjq2UFSIwZq96REA==
X-Received: by 2002:a17:90b:4d8e:b0:290:3439:154f with SMTP id
 oj14-20020a17090b4d8e00b002903439154fmr877084pjb.83.1706416946468; 
 Sat, 27 Jan 2024 20:42:26 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 03/33] hw/core: Include vaddr.h from cpu.h
Date: Sun, 28 Jan 2024 14:41:43 +1000
Message-Id: <20240128044213.316480-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

From: Anton Johansson <anjo@rev.ng>

cpu-common.h is only needed for vaddr

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-8-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 238c02c05e..db58f12233 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -22,8 +22,8 @@
 
 #include "hw/qdev-core.h"
 #include "disas/dis-asm.h"
-#include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
+#include "exec/vaddr.h"
 #include "exec/memattrs.h"
 #include "exec/tlb-common.h"
 #include "qapi/qapi-types-run-state.h"
-- 
2.34.1


