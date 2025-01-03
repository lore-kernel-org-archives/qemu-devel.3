Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209BEE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlCL-0000RR-8d; Fri, 03 Jan 2025 12:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCC-0000Pm-Iy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:10:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCB-0006md-4u
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:10:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso89660895e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924245; x=1736529045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhLJyNKpXTaAG71p496OhoK9px2w3vuRidPr1o8/SQw=;
 b=QNbTF/Z+EIYKTIzNqycgTUaGheTcrKDdz1USiNYNc+8zA5+59DddTr/cCdLZnF1gao
 eswymmb+kODh8V+ZVliF7pHKgGxR+eHOufRpRdJl1oKJR/UjQeXt/++hSJM6LTvLlqB3
 A4fkbZvKH0DwbA4FnQ8VKhzMxTsILEKPsKyJMlM5TduqamQ1jBlg5/w0wmHb59RcXTOT
 hoHsO3i7jA39DkiHDy2kFY9DjaB6s0EMG8UUmM6tJqYWTRk6MhTzMgnMMHrQjAenGbMm
 uBxcSRJZVIYzLQF+Hs51z0N6w75hwWClF5FXkj0nyJxknBLyo5sUSKFRq8bps/a1np40
 UWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924245; x=1736529045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhLJyNKpXTaAG71p496OhoK9px2w3vuRidPr1o8/SQw=;
 b=Nh+Wle2TMahVy5LJWGcVzIWN+r55Jk5JxEyag5Ha1M1kBuLZoLFf+tq+an8toWUNe+
 ADpYZf4a6owptcNH1cV2UHui/unESIZXRj2Z/SurFe6NLUVKb/+UiisZYxC6UZPrxnqu
 NrXIk/89NJowQKtfUS9ER7yHoYJjqINVsKvg7W/FbFEoKQuSJQqvTz0MxvNK3rltrNs7
 3UoKXPmO8NFPjjf6XmXw94T4IAPBqGLWqdUITfthV8f4hUX4425lcCyCTCx4sbgi1+ZK
 ysmxpngbO1Uv4yoSVkvhxHkfqgrqEpSx+J4X7SdEZbV/3646LHCvfc9VfjpIbdRHvxnv
 VrFA==
X-Gm-Message-State: AOJu0YxUwAUYayQ3T94VOSsSiwFDh8TNx/oyDDXJA4LCDDCKzXbyyqWz
 +v6ZQPZOG5FL+Dz8WYmXq9J6SwI4RUiqFy5rwADSk9KJFuCxuM9WlfklTwPV0nj5D2ao27sN456
 NRBs=
X-Gm-Gg: ASbGnctQUaf810vKRI/FGzMIP0Cig4Wso4MHqOYRGMAwzkHr/Joz5R9JX5rG0OFNZLZ
 oT/EuqI2Rmv4fZ1EN3TZQ5kqyfAK6hDjzT7sycbE5fE0BIBXgcUtUyY5l9UVV3Ubk3JsQaE/Lco
 ROXsHUFIeiUZSHvUGyc61GKQ0RceaznVYTOPk9YswM1SCCvcmhnlt/FgXMN5BrSuVqEv5xc+9J/
 VZWZNuD+6vQYj5TRwEPKeauV1JhGI0/DJrTzUH+As01+31ieLgoKx4kNdDsWQ3vU0WJ4E8fapul
 nS9uqTLq14jD3VgdjH4dC+CKNmm9iQ8=
X-Google-Smtp-Source: AGHT+IF8Nsy3ccr7cQYoUOI7TTONOJuDjDJ8wD8LLXAHwSTD/oHVYSofldv6C/suyviRUkfllAm1gw==
X-Received: by 2002:a05:600c:3b86:b0:434:f3d8:62d0 with SMTP id
 5b1f17b1804b1-43668547175mr449340245e9.3.1735924245179; 
 Fri, 03 Jan 2025 09:10:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acafesm40979667f8f.98.2025.01.03.09.10.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:10:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] semihosting/syscalls: Include missing 'exec/cpu-defs.h'
 header
Date: Fri,  3 Jan 2025 18:10:33 +0100
Message-ID: <20250103171037.11265-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103171037.11265-1-philmd@linaro.org>
References: <20250103171037.11265-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

target_ulong is defined in each target "cpu-param.h",
itself included by "exec/cpu-defs.h".
Include the latter in order to avoid when refactoring:

  include/semihosting/syscalls.h:26:24: error: unknown type name 'target_ulong'
     26 |                        target_ulong fname, target_ulong fname_len,
        |                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/semihosting/syscalls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index b5937c619a6..6627c45fb28 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -9,6 +9,7 @@
 #ifndef SEMIHOSTING_SYSCALLS_H
 #define SEMIHOSTING_SYSCALLS_H
 
+#include "exec/cpu-defs.h"
 #include "gdbstub/syscalls.h"
 
 /*
-- 
2.47.1


