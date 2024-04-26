Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B70C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RTE-0000sv-1d; Fri, 26 Apr 2024 15:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTD-0000rk-7W
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:55 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTA-0002yp-JD
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:54 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a557044f2ddso320836066b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160571; x=1714765371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHpChPLpjXlPm4sz2ZPmxjIjHGSHb3jC7Cykk4D98j0=;
 b=AHBocRxb55dFwBoDNMXxbm5eeMorfPXbPqYhzrOUCk8HiRFOU0FKto0eTpG0UgRSxU
 VusLzWQos+AHsTc4kFvYFDWEXQHrpjDJvky4sCMDhcTVdRxFSYw+EHTpNrvsnlDUKoT/
 Ikn6WnmPMl1sb9fNI4HcbriP8EawVGhkOmIYRCyi5XGYSK/X8fWydq7MEGgfmLTVsh7E
 L46o5GGBvm+vONo8Y2jO700qJOuU4XIVZqIEoldICJczwZBXxjs8k+361npsno0i0lw/
 /ySQhut3OqPr52uCA695UuwDRBFG809D7jBshDRQJPt1HogRAiKvHVTFuuJ6WWmhMVhy
 ePBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160571; x=1714765371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHpChPLpjXlPm4sz2ZPmxjIjHGSHb3jC7Cykk4D98j0=;
 b=kN5BcVYHu3Td0m+Jg55/bNBTfIrxmrQxvJ+FDs9rxI+L5ELmXuPzAAXe1xHriF1RrD
 DZThrhSqjl1bbDSMCCtMADUsS0+ofs1utFBt4f6XK8k7aaGYeXCDu5Vq3mbJ7DPT5VnB
 Re8IDjgZZxf9QvMEW9rVg5DlaHUwdRNmdFb6nrMhFCcXQADztS9/OnSbmGuZiYfuMFB3
 biqqp0C9LQMTFXdaMJM3c/ivg+92JmaJXhwTzuW/yKshRrYDomQ7RAz2yH8WXcHA6pdr
 34dB2K8Qufx48oykzN+uPgxHCa2H78+L9MGa6xMi1StgC3449VM+WC/GBr080tbOoytx
 4x2Q==
X-Gm-Message-State: AOJu0YxYRlIO5q8OEqpviZEWKe7g7d4hoYj6NhJyE98HyUYztOtT37uI
 9kz4/G0XjpGg9jpF8Rzjl3MrGjWhqZu/QyJW7oGsnOQyhZ/9Y7uLIZnZ//4FUTLsqJhselity32
 jc4M=
X-Google-Smtp-Source: AGHT+IGbNeMhzgN98z4dLatfRNgzD4JoCLYAUAAa0SGI/fSgo7fYEHmK/xLWoyE9mZAyJiPl+fFwig==
X-Received: by 2002:a17:906:27d0:b0:a58:7470:21f3 with SMTP id
 k16-20020a17090627d000b00a58747021f3mr322493ejc.28.1714160570950; 
 Fri, 26 Apr 2024 12:42:50 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 t11-20020a170906a10b00b00a5244a80cfcsm10944860ejy.91.2024.04.26.12.42.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:42:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 08/38] gdbstub: Avoid including 'cpu.h' in 'gdbstub/helpers.h'
Date: Fri, 26 Apr 2024 21:41:28 +0200
Message-ID: <20240426194200.43723-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

We only need the "exec/tswap.h" and "cpu-param.h" headers.
Only include "cpu.h" in the target gdbstub.c source files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240418192525.97451-20-philmd@linaro.org>
---
 include/gdbstub/helpers.h | 3 ++-
 target/avr/gdbstub.c      | 1 +
 target/tricore/gdbstub.c  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6277a858a1..26140ef1ac 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -16,7 +16,8 @@
 #error "gdbstub helpers should only be included by target specific code"
 #endif
 
-#include "cpu.h"
+#include "exec/tswap.h"
+#include "cpu-param.h"
 
 /*
  * The GDB remote protocol transfers values in target byte order. As
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
index 2eeee2bf4e..d6d3c1479b 100644
--- a/target/avr/gdbstub.c
+++ b/target/avr/gdbstub.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "gdbstub/helpers.h"
+#include "cpu.h"
 
 int avr_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
index f9309c5e27..29a70051ff 100644
--- a/target/tricore/gdbstub.c
+++ b/target/tricore/gdbstub.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "gdbstub/helpers.h"
+#include "cpu.h"
 
 
 #define LCX_REGNUM         32
-- 
2.41.0


