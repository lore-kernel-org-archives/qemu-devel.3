Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C03EC48285
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0X-0004oJ-Gx; Sat, 27 Jan 2024 23:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0W-0004oA-DF
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:00 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0U-0004Ls-Qy
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:00 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29065efa06fso1553799a91.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416977; x=1707021777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p58dq3BNm1M9yORIAE2cQcXeCTaVjSrZcGgMOspnf2M=;
 b=FFQcIL8r9e1BzlduKnXMpK2Odl/2g3YabMHMfV/DpnnSRAW1ZYRpzhfq7Mw5AveHwH
 v4O8952/hjrwNgSFlvkzuiLP+Gsrm4Z2fAtJ9+BGvwyCkNWZPx6reep+kOd2DIME/865
 SZzfXszBPrz54YeYGlitwcZyOOCb+KCLyJr/EYp33THU0PpA3rrbFc8IPKtqUlK1mB64
 2DSEVhzDH/ERcogPQZcu2RVVhlwptj7l934hE9g1L8Rke6vXXF7RXivE3pVGJtMrq8gm
 vY/D2/5ImmvPrKRVy8qnH44PIh31c9vy+83/d3Gni9MlSmPpPot+IVcL0DYT4kU5kXKv
 l0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416977; x=1707021777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p58dq3BNm1M9yORIAE2cQcXeCTaVjSrZcGgMOspnf2M=;
 b=MWPLEWzIS05OMcunCN4hSdZp94iJCJDJn8OF0wlFnbyWLcuWEHI1B9GqF1MBzKm9pD
 +diRTJzhcuHgTrF3H9+5K20dEgSynFzBuwr2QQZEE+PMXJMgiRyOQ+NbtfrEXHBeLt1/
 aIA9tbkA2bVNhT56z1ViY/2h7STLszbatX+Z2LYF39w2A0JrMXHhJYw4eTVJ1y5rQqWW
 AHHJpKj4zgaFRhqbVEbDcjn7vaQy4oxWAMjzahAFDosn/+YTfqDw73R+PhBEMYvBagaf
 ca4HzSM6KWJH/4MCL0WHpW5vkyKXczY4NFDBNDYIP9LhEZkysZ6eTC/9922j0vkFRFlZ
 jdVQ==
X-Gm-Message-State: AOJu0Yxnl+PnIUMKOh4ZhBMehxpXqtEdMWll1Uwz+npWkh7IbaWa9mj1
 sy5q6jWrVOzuvMJxUDHc6/K+meSItARBBVG7p5Bp1WW2HVmSRG5XDP2MPjDzaFYD0UGTtRG3rlK
 3qS7hew==
X-Google-Smtp-Source: AGHT+IGf3VxO1VhOTznnn69pllVLFyMmg4ojYaF58hz4yLlUxbJX7zc1k3sy4UU7CYZW2yWFLmow4Q==
X-Received: by 2002:a17:90a:4bc6:b0:290:11a4:ec4b with SMTP id
 u6-20020a17090a4bc600b0029011a4ec4bmr1603372pjl.61.1706416977455; 
 Sat, 27 Jan 2024 20:42:57 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/33] accel/tcg/cpu-exec: Use RCU_READ_LOCK_GUARD
Date: Sun, 28 Jan 2024 14:41:56 +1000
Message-Id: <20240128044213.316480-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace the manual rcu_read_(un)lock calls in cpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124074201.8239-2-philmd@linaro.org>
[rth: Use RCU_READ_LOCK_GUARD not WITH_RCU_READ_LOCK_GUARD]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 40c268bfa1..950dad63cb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1050,7 +1050,7 @@ int cpu_exec(CPUState *cpu)
         return EXCP_HALTED;
     }
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     cpu_exec_enter(cpu);
 
     /*
@@ -1064,8 +1064,6 @@ int cpu_exec(CPUState *cpu)
     ret = cpu_exec_setjmp(cpu, &sc);
 
     cpu_exec_exit(cpu);
-    rcu_read_unlock();
-
     return ret;
 }
 
-- 
2.34.1


