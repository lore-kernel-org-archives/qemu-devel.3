Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04043D65C58
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsjM-0001e0-JH; Wed, 17 Dec 2025 09:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsjK-0001do-OY
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:42:18 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsjJ-0000LT-6C
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:42:18 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so2824118f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765982534; x=1766587334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ikCoi5MMT0locayzfcw9+sXxbv1buX2zl7u6L0KAADA=;
 b=oRwh0Lsn5NaHd13mJmTVsAJmm9UVieeqwwUUOUD04PRxagiyCw52he68vcrHRaMjU9
 pIUvjWLU123XcKRtZKuehrEcb6OJkAcWyXLHQ4LSoQ629tvYlU82YV5tVd4p8/snqcTM
 pJjIALWUpbupqVYDXvCeDmFZcxoHEaLv5aAT7qEsN1ZxohFZ6ug925vD9WQa0ag8FI+P
 MdKvBCb4Bcsy1aMrADxcs3w8o9m8rm7NR7Fa6uus6NfF86Tv/SG94FaZHUOaOGqURzb4
 5hIdhZ1QK9m9hhNpAFvsOvsGCst5d9r7U0gyzmY9HQK8QELEaxi0roh4HfXY4LsGTcJV
 hQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765982534; x=1766587334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikCoi5MMT0locayzfcw9+sXxbv1buX2zl7u6L0KAADA=;
 b=OSJAeBCyq3sG2uExNW4Ex37MZCMEDseaKKvLzlH7i9d8UMtu+UxvqULGyvgA3DbHOy
 Y2E6WJsgNCbL6+VqyHTdvSLj6blOoR1JVN7M17WWMHnXsKlrM03o5pJh81qOuKw0qcDp
 WfKVp4h7w7cybEQzOu7ZySq+FGMsf/pDkFca4/SmYecrsyjJY+GYkrPpLKJrV642umuZ
 GEq6O7/CiO1zatMsRsYLQ/0RwgWxNAd+9A8o76EGeKTkc1bcAmc9KOKGuln4pDffjNCe
 XqFU4dotPcGvKMnqpDRHeHbPRvMd7ej8F8iixq+2lXgdIeyZhOhtME7k6A9GpPJQW/9B
 fgHA==
X-Gm-Message-State: AOJu0Yw33ZWT0RyZbbA6IPJ4NhcRzkPMSGLW71NDCDaXmictp+kQVhYO
 cQpr7e2EIk21IhLS2HUvvsSNwNuEQBXfe/IXJaJep139vTTVKYIov1/1LVEgBL2W1eqXH54bK+q
 jyQBw/Sw5EA==
X-Gm-Gg: AY/fxX6VD/R+oocZ9JLOe387/JR8cDroW2nxjDloP0Uh7OuiFZGhEDnwTUgpCntQF+8
 6wHmjs2tk4UCSD7uyfhDp8RW+pevgOtZCRo4TB8Aq8j9irrRmKd442uKc5FTt7vJJsi23TsnZYw
 4MafCfe6gZKqyW+QQvcblJkVA+zKlL5RSR6YLLzPVzPSUmjwbhvu/r0WUcfWJwZNUZSQv8hWbIK
 y82OzFEkX9RM60429T0ua2FgoHX91ONjiNrtoIK0zF8wij19imA4q2CTyMAOA8VXX6shVZl9AwG
 mGnHaT1w+v0r0922LeWide5s2s2iTc+jRMKACjKMUupArvIb+T/ENWFbXWtNCy8KYiP0KgXANlj
 X1QpF0pFwFhQAmV/J9M8MsQfD6MG1dHNk/9hikCeC60Du5AgtElxSjgkp70/AYHoWQ9nFCxFm/j
 bj+Zmc3nI3L1ASNeW0ZqD1S9enS0BE18PrWc8T9JtMlR4qObAeHNgN/8CAiUkXRSQmMpUeKTo=
X-Google-Smtp-Source: AGHT+IEjCPR5JjYsYp4MUwNJ2+PmRdrCUO/SX5jzgoW1RhLhvsXLaA5fqcajcn7tcQMy3x3ZqjO57A==
X-Received: by 2002:a5d:5f54:0:b0:42b:55a1:214c with SMTP id
 ffacd0b85a97d-42fb48e857emr18084625f8f.55.1765982533731; 
 Wed, 17 Dec 2025 06:42:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310adf701csm4733154f8f.42.2025.12.17.06.42.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:42:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/hexagon: Include missing 'cpu.h' header in 'internal.h'
Date: Wed, 17 Dec 2025 15:42:11 +0100
Message-ID: <20251217144211.95032-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Both CPUHexagonState and TOTAL_PER_THREAD_REGS are defined
in "cpu.h" which is luckily indirectly included. However when
refactoring unrelated files we get:

  In file included from target/hexagon/helper.h:18,
                   from include/exec/helper-proto.h.inc:56,
                   from include/exec/helper-proto.h:13,
                   from target/hexagon/op_helper.c:22:
  target/hexagon/internal.h: At top level:
  target/hexagon/internal.h:29:25: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
     29 | void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
        |                         ^~~~~~~~~~~~~~~
        |                         CPUPluginState
  target/hexagon/internal.h:30:25: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
     30 | void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
        |                         ^~~~~~~~~~~~~~~
        |                         CPUPluginState
  target/hexagon/internal.h:31:20: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
     31 | void hexagon_debug(CPUHexagonState *env);
        |                    ^~~~~~~~~~~~~~~
        |                    CPUPluginState
  target/hexagon/internal.h:33:44: error: ‘TOTAL_PER_THREAD_REGS’ undeclared here (not in a function)
     33 | extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
        |                                            ^~~~~~~~~~~~~~~~~~~~~

Fix that by including the missing header.

We don't need the "qemu/log.h" since commit 0cb73cb5a02 ("target/hexagon:
Remove HEX_DEBUG/HEX_DEBUG_LOG"): remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 32e96f00d97..5fc837ae229 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -18,7 +18,7 @@
 #ifndef HEXAGON_INTERNAL_H
 #define HEXAGON_INTERNAL_H
 
-#include "qemu/log.h"
+#include "target/hexagon/cpu.h"
 
 int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-- 
2.52.0


