Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D669FC36010
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LXi-0000tO-Fj; Tue, 08 Apr 2025 22:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LXg-0000sD-P1
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:51:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LXf-00019a-1F
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:51:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22401f4d35aso71642155ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 19:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744167113; x=1744771913; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=34lLEwB0Gg3cwH10oPYf9tvhYdTQGgJnGI9qEibZYP8=;
 b=h5dXJeE8JN+k1C4AU4i2Wc9u+Ke2t5BWUKvsXgXXCSIfhjvpKnihS7sZx6F2YzFQcy
 KwM9Nd/I/RUwSTFSElU9lYeI4bm82yPkLX9vqmFdmWHcCN/jMVS/K0pO403/c4wC1ZaH
 FWZFpLVNLlDGFgGe2vQCrWwD6J16GbmUaUK39si3uADdtRVJgOBTR+6QNvPieYJbeeFh
 L/NvA9gLQ1jBW1IsxhhWEys8hNOyyMrVnENZk8UEGUk3y7es5ha1V0bXOhBJG/Ze5iQN
 De67tfcMocv3mFz389sh/zbMV2KV3eTnJCKFCg9jOxritceqlRMo0aBUARKeE01+GlWU
 0yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744167113; x=1744771913;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=34lLEwB0Gg3cwH10oPYf9tvhYdTQGgJnGI9qEibZYP8=;
 b=EimITTMvW0we+Q9Zf9UkmWaX2QAFf3AhQ2I+Ufo5skQgHY0LZEa9bZ/suvS6HfjfCi
 50uygJUQqim+jd0QKoHybam5CJNOf6un9oT0iMZs91a1ajNOOYkA2jWbYA8ssEoOj3Ng
 P8HN5F71Lse4It9ZtIXYvBpZbqzqgkB6LakFZ2UBeKjXh8o3ijpQ9OG3QFHYWcnMgmu+
 3yIfolro7kupgJqNC8dVgGQM54mOBrnLMWV+TCM90Olaoa18yCYuHvJMqd6uw7sJ/SYq
 B53MX2K8yxPwG1rX5LvXQFbyoBuNA91TSvCz7ySj1u3J7GW9EF8eu5WQUf/7u6c7N4Hb
 nB7A==
X-Gm-Message-State: AOJu0YxtP7DA9l/4XHQTKGOJDa5Y3QTb4GRNuOhbJLVRH0HabPwZzslH
 rX57ydg3PY9AOQxXEocb3RQdi4v8F1/vGEC/f6bU3YqBHsgYbZ58kq2n5G6vVrCNPiPgyt06tZg
 WR8ddYUcsfryG4A248GsOsNqhYRXXM4vMqNN+3C6li2zn6BD5VThJQWW79fOqP3fFZq7kgCr/Cl
 ktnSKlIU34a1uPr5+KP008Kf7jTmtXiG9p/g==
X-Gm-Gg: ASbGncu45G6If3HMYzemqoFpQrjLz0ziAUy1lY50t4M6fG14/3AupaAOXiTC/fwFUjA
 sdxZGynPuwfOxvzvpVSDr2WvAL8fdG56Rsu86IN3bQNwFSkEqRFS6w77VWPDUMrfwRvVRyPqJtO
 e/fQJllmjCXjXUHCyqBRqbhLSy99sdcC01vbo4+dyA+MiUG4m7UQalHuYmyrDpXMNiuq4gBKPH7
 vST17WQwQ2CBpfxL9NEGSuvJeNypqhLJecY8sMfGsYqVIO8sLKcjAO85/KSfH6oKMxE6Wyhyeje
 hhXszNGILVEjB4U4NyqiT4zxCu2iMOMxkFuCO3Ssd0WZpxkfB04VkltmIL7XwWMgDsXRZw+mSxH
 ppA==
X-Google-Smtp-Source: AGHT+IHuZxg1XkNr9HdgCzep2yi5FoOs4gQYQjdn86csPg0WTyyAoPp3Pa3tlKPVjO2/r354THkDLQ==
X-Received: by 2002:a17:902:f9c3:b0:224:78e:4ebe with SMTP id
 d9443c01a7336-22ac2a1df74mr12899575ad.33.1744167113040; 
 Tue, 08 Apr 2025 19:51:53 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7cb5463sm665725ad.195.2025.04.08.19.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 19:51:52 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 2/4] hw/intc: riscv_aclint: Fix mtime write for sstc
 extension
Date: Wed,  9 Apr 2025 10:51:29 +0800
Message-Id: <20250409025131.3670-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250409025131.3670-1-jim.shu@sifive.com>
References: <20250409025131.3670-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x632.google.com
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

When changing the mtime value, the period of [s|vs]timecmp timers
should also be updated, similar to the period of mtimecmp timer.

The period of the stimecmp timer is the time until the next S-mode
timer IRQ. The value is calculated as "stimecmp - time". [1]
It is equal to "stimecmp - mtime" since the time CSR is a read-only
shadow of the memory-mapped mtime register.
Thus, changing mtime value will update the period of stimecmp timer.

Similarly, the period of vstimecmp timer is calculated as "vstimecmp -
(mtime + htimedelta)" [2], so changing mtime value will update the
period of vstimecmp timer.

[1] RISC-V Priv spec ch 9.1.1. Supervisor Timer (stimecmp) Register
A supervisor timer interrupt becomes pending, as reflected in the STIP
bit in the mip and sip registers whenever time contains a value
greater than or equal to stimecmp.
[2] RISC-V Priv spec ch19.2.1. Virtual Supervisor Timer (vstimecmp) Register
A virtual supervisor timer interrupt becomes pending, as reflected in
the VSTIP bit in the hip register, whenever (time + htimedelta),
truncated to 64 bits, contains a value greater than or equal to
vstimecmp

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/intc/riscv_aclint.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index db374a7c2d..5f4a17e177 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
+#include "target/riscv/time_helper.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/riscv_aclint.h"
 #include "qemu/timer.h"
@@ -240,6 +241,10 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
             riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu),
                                               mtimer->hartid_base + i,
                                               mtimer->timecmp[i]);
+            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0, MIP_STIP);
+            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
+                                      env->htimedelta, MIP_VSTIP);
+
         }
         return;
     }
-- 
2.17.1


