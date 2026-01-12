Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A24CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQnJ-0000Tk-P2; Mon, 12 Jan 2026 17:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQn9-0007Ei-PP
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:43 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQn8-0003aU-6t
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:43 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso31720605e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258420; x=1768863220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kSPqFYpQ+X0CJ9T+5owpTaaxm87SQoNIrwW8UuRZ+88=;
 b=LB5aHyrkL4TU4pu6QhSKVMTotoAcAlVH2E6cKqnjCePeOpfGLQNklx1lVee11fMuxS
 6PeVf9+IsNFZijqjiL1IIDkHzXg74x8U/RAKmaN8XaVuGoUX+Xy0BpgTsCcghF3EjWpr
 QTTxEE4AyCGm5pZ3EXbO97cCSlZbGx+EqGxDoO1luvNKWfl00V4OsDVcXI917MU2BliB
 TboGKbLX6JEKE2iMAFFiYR1+M065EQDeRzT2Zncy/47+aEuqXkFQpzjMGM/JQoZAzOI+
 zgE7ukFbGvvtoNrQG359cDEO3uVKdmxfl4WQ//V6SMkZBJQwhTwltLqS3JKW6FmrosOM
 Dnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258420; x=1768863220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kSPqFYpQ+X0CJ9T+5owpTaaxm87SQoNIrwW8UuRZ+88=;
 b=PKe7U4uXf9IPLJTaeK+nVn0nQxLORNBQD/MnlcemRMCo/AYots9YALI7M4T/nfh/Cq
 JR54ZLnlysEWe/2xBnae9ZJeToIlwCr9/+rF5khlvifp3MJW/5D1DH2rPdz7N0fHWUOW
 VEk6EYaiVX3Nd6e5RyzQICOnA1vIqakX4fXJW8v55FqnckO+EeSib1l4f8EUhiT21ikY
 p8wdMmHUJxHeUTsKtkHGfo6lEV/gXKyjkaA6IebnXXFGE0d4jvGj0KM7ysgf3UomssQ6
 M3W7LTeJ6DdPgvsizbl6GU9r7RWJIiqoKUHJqPu/z1TDO4Tyzq/aL8Y/gNuHBMQBgXcq
 TbpQ==
X-Gm-Message-State: AOJu0YytYlFGfia2vUZphzX2dL5PSIaukaXKHt5E29LdLzOrJ0TBuR0C
 EycWaS33Vyk5ffii0G7W/fQX0IQJOJVw26RjpH1w1olOa6Yo1YtvnThu4wXqXLar/eYif7DEgSj
 dChWACQY=
X-Gm-Gg: AY/fxX761tzljnrbuKV7MHeIO+M2JOb8lfSXRVE2C7zalKKY727pXsiOaEomm1LYE5O
 TGNTU+tyy5jXce0qalI9e4z/gDALq1n1OA3DhR9Fcpg0cV1zZ8AxyjTp95PXKsSB+lQTHLcja8Y
 rjxKBcCC0H6oZcw1FJcnK1jSYc3PcbvSCY9yXs5WxtTtVMnWPgSj2yDkE/dqFJZa2Gih2kUEtKi
 Dm+HQlEDGtpA8BNyH7Fnz9m4/ueCOTL1s3f6VLRhDDW0K+nyIx2f+6S2qFaIkLd0iK6O7rikpFF
 GvmDutc0P4SrvddVC6HTUbkNysVWrCrqidIQE5fGHR/JrL2O6+VQ4uuE5cp1k0sbN7T1WKBsQX7
 yZb5JEEwAu6pZerLqeSSDj5s5q9ueQx4FpwNt4zA6CBQYgKlHlrCvllWJPGoV5ed/4ePhg+CYah
 voqFFi6P/Lasm91ZsOVjZWxfIez1eKswfEo8ZUd5P9wLA4r4hahk8dBdv/J73P
X-Google-Smtp-Source: AGHT+IEGX6rJ9v9GLIck2Cc0s0RutBaF82lIQSF1nmu1isxw1cTguIL3ErfYHRJ8kLWxroD+4E84Qg==
X-Received: by 2002:a05:600c:3152:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-47d84b17eb9mr227253085e9.12.1768258420335; 
 Mon, 12 Jan 2026 14:53:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184cbsm392489595e9.6.2026.01.12.14.53.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:53:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/61] target/openrisc: Remove unused 'gdbstub/helpers.h'
 header in helper.c
Date: Mon, 12 Jan 2026 23:48:36 +0100
Message-ID: <20260112224857.42068-42-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"gdbstub/helpers.h" uses target-specific symbols, but we don't
need it, so remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-5-philmd@linaro.org>
---
 target/openrisc/interrupt.c | 1 -
 target/openrisc/mmu.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 5528b80e7b8..6e89157639a 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/loader.h"
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index b2b2b3c4a98..315debaf3e5 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -24,7 +24,6 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-#include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
 #include "hw/core/loader.h"
 
-- 
2.52.0


