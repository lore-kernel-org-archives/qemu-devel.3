Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA32CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQnA-0007Ot-Pq; Mon, 12 Jan 2026 17:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmw-0005Dv-4t
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:30 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmu-0003YJ-Ie
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so51062265e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258407; x=1768863207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kbjExCft2bxFUe4ER2XObcujGSAepb71NphBWSn8QrA=;
 b=s4J0MHBa1Xo6IcfDtn7vkk+0vJlvkOVkheaO/UCwfhXPbgN1oZjEd5/AOnt6yYOM1w
 HiIT/G2+qqCLzemLJgAVW6BGrJHdJGigy3T4b94SjxLRX37tCMshgPFFEegzjeguJCUg
 BR0P/XQ/WyzHc4SjfzjyT3tNPkPQyRGkfjF4+G+NmKfuhoFGK87Se7VfuAcPStwALmXU
 gg5DvP7xzqHchtCyQczKTkuCo/IxaB5SFSzN9q1J/rnS6E/pj21Zv1lByNLpJ1D7ese5
 Qs+FCYVvzj2JJtaGbMjIr8py5BN2gawy3y8/X7EejDCXknMOAVAcc1yphoPosJzOHhWT
 nxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258407; x=1768863207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kbjExCft2bxFUe4ER2XObcujGSAepb71NphBWSn8QrA=;
 b=jVX9qxGdpL/zXlwIqA9u5iRi3tg2Xn+QJyN3/srr0RVDCiAFKlJwzB3Y1eOuWgxljP
 nSao4UNCUAUWb7m6LpaQn/jqR5FzgbN1KyZHsNIhlGaGzuMjCoyOoqc1cRa98RWhxh/e
 QYFE4QGQysgnTDcJS0W8pLe9RmWmhr1G8g9kH89Uxh1vUofsWQSCJ/45GiUk13E4FPR/
 yvELDz0o0wgOM+/MTm998Dr09U9EVNrEjYvVMhEkfBFpwGLbeYOPoH8Mf4vQuqF5otHY
 vsJQVcb+RCgcV8pDNDK5lK4ouvkILcWaXhujT+HqlL/SK8eOxrfDJr3P4CjpjMj6e6+Q
 1hrw==
X-Gm-Message-State: AOJu0Yzfl2Yed8/oqeN3yG0uIWtwLzgtrUsnvQVY9yLNz7C66DWvYieL
 2+r7rBFRad24RXAE010YejGFgpDnCEPVcrwJE3pIbOYBWJFT+G5Q9cxVjf7DyVTSVx5bPGyFBnz
 PNj8Wqps=
X-Gm-Gg: AY/fxX4wr5vuCHYmgvc6twXGTdqi3rJoQaLT8Erhkw1/lFMSmF/JyH7qSLkUifbg8mc
 Pe0JgCKfIq5Ux8/dqablePvMFcs22mE5TSL4YfYPToh19IvBy+9VLZuRUpQBW9pTijqkQ5Tfgx/
 wHFmV3MOwx8Qosm/6RQPaoT8mWwr4w6/AqG8Capg/qZncPnK5x0uws7RXvaj81CJwN8p3Ev0Pku
 9FOwQxiXOv6fBoZbJrXFNwoXqxQeFi8PDTWC8iUlCTqn5HIzZo6LqF9e6E+2XVP2DW4GbsxE6GE
 cR8MUXsA6ThQg8aN17BgeU7uGIc3Y1PVb7bWhF2lYerTN+jRoYv7PTwh0psPNNIm7aKpH7D1gBw
 +6rXYI2n+6PMyE3WJa0iqThRQDRnqabmxDwhA+Fu4dmriJzh9rB2knQNU1cgSN4j3GIpoGDTz7o
 wioxQLQoOolCfhWb073JhBKNN/hQJS/edpI20doiOu1StPXZOVQ3xsPJAFImY0TOsGNi65yEc=
X-Google-Smtp-Source: AGHT+IFxBU4EBT3457X+fZK6iSavnvPsTqjOOJACTzo/pVS+8l1MsB4+3bfLJIchrdlYEQF0YDKCxw==
X-Received: by 2002:a05:600c:3b15:b0:47b:e0ff:60f9 with SMTP id
 5b1f17b1804b1-47d84b347bbmr196167755e9.20.1768258406596; 
 Mon, 12 Jan 2026 14:53:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184e1sm364539295e9.4.2026.01.12.14.53.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:53:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/61] target/openrisc: Use explicit big-endian LD/ST API
Date: Mon, 12 Jan 2026 23:48:34 +0100
Message-ID: <20260112224857.42068-40-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The OpenRISC architecture uses big endianness. Directly
use the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/openrisc/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224161804.90064-3-philmd@linaro.org>
---
 target/openrisc/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 45bba80d878..ca1592c6200 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -50,7 +50,7 @@ int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUOpenRISCState *env = cpu_env(cs);
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 
     if (n < 32) {
         cpu_set_gpr(env, n, tmp);
-- 
2.52.0


