Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF99C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuyzd-0007No-RF; Wed, 19 Mar 2025 15:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tuyzb-0007NI-Py
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:22:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tuyzZ-0002CG-8X
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:22:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22401f4d35aso140357445ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1742412134; x=1743016934; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aB7jDkATDxOkVutkBfcIFSoI2+BwZTyJZbSJyUJb0gI=;
 b=fuPfaIQ3pTx1wKERcgOBSma35je5TNhRmk8RkwCM5q4RlUiks0egEajWZMfPq3KRJm
 W18HLz4pZmLHdJyJ6ackprOrzMRWpPf0m6KqUxthaapwuNMM54xKX5G5gvdSs/z9iXKn
 e1bDUt+zIWC7GT9ozpAN59EkTxXGeZXgKPefLcFfbnpvA8Gg9ysqSoCbKGl9/5bn2SF7
 UbFGM5IQSym8i+MgBvBNKm4aSxpRF/Xn2sSVuQh9KAzB0Ogb0fBQCoI1vDi043nsmXI8
 M9n18/WfesOo0x0RlkN7NnFyMyvitbatLazYVR1RhV7c3qU8RfitYpPZQr07mTI8efPq
 Zuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412134; x=1743016934;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aB7jDkATDxOkVutkBfcIFSoI2+BwZTyJZbSJyUJb0gI=;
 b=uIrO6X1PmEYrf/2ptS0De7w0l9fQF5sCZczpeOETUd1AqYIX9zXlTdb/cJl1Jj1H5A
 sWNUkbVKzBF48mNhjv92R8uacm7/GHYkkRjDwJHR8K8xbk8N27wATRRxiA6P8jPMercM
 ZJjtli3NGSANVXnb5TgIr/FGf/F0TNAw4IzR+vHpWJr3zezZnZTFi0uSpcTpQvV7Gelk
 sfj+IqPy+lrNRALf6FjjqA42eSlEZyb2IQnBjq7cKXiw//9mo7uuhLT2xvE4sRzfLmL2
 gnqUyQYJH4wl7/kwzzbAZrs82cvtFFKIBLAhUItY9Oku8TH6m2EkdnPB5dtyjseH7UFe
 B16A==
X-Gm-Message-State: AOJu0YzB4CuqgQxkmK5SVWtYNy/x+M0DaFBaRymHYMOFFLmmmSCX5B/4
 xQ+lLX0utRZsbC4o5RZgJtxanErgjYgVAp2rS2+qNRFaMdcyU7ESOwMKQz6eRzFGsXSRhOV3Yci
 w4nJzTzEGgrh0PDk9evoNsPZHUa6z6Pktx5HEXjbc91JiKJP3uwxnV6LgZtVoyDeYwTmatlaiDR
 es0FYRiXHoPSvZcKvgxgclnaLtlS5EV2uzIQ==
X-Gm-Gg: ASbGncsCIP93sIYKe6E98VkWMV9wkLt9t4Ik6pzfpPwoqF8x3+Y9j/O64JrvCAKB5FU
 FjlXxD6a6p0RL4JSFyWWiiPdDUqlT5bt5AfoXQnm+NGMtUE9ZrrxjcEbIJrIDpp0IiE9lOUthHN
 jqc0i/mpeImRXtNR9qGX1WRxEhmdZZ5pVS2BQdI9yglsFaTWZ524RQ1dtosWzomcEpVdvLZfCDv
 TcFzvtlIXcZxf0K5CBrjZli5Mc/Xjf23ZLB+Pyr6vEcRTSho/qm3mJC6flYk0GYvXLEKk5sSQha
 2D6YEvgmNrjyTjeQpSYULpAS3yEuG+DKdOQT+ofZ5OXDo+xO4M7fpV0mfFtZq53xWMQ=
X-Google-Smtp-Source: AGHT+IHTLAvYYyrqSDbcwJ5pY7yoLP/D/Q6TaHC3f53YzVmOa3CKAp2LNp9bCZmBJ2xOyPoN3ATFLw==
X-Received: by 2002:a05:6a21:1643:b0:1f5:9961:c40 with SMTP id
 adf61e73a8af0-1fbeae8f5f7mr6365795637.8.1742412134468; 
 Wed, 19 Mar 2025 12:22:14 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea947a4sm11432175a12.70.2025.03.19.12.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:22:13 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 2/4] hw/intc: riscv_aclint: Fix mtime write for sstc extension
Date: Thu, 20 Mar 2025 03:21:51 +0800
Message-Id: <20250319192153.28549-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319192153.28549-1-jim.shu@sifive.com>
References: <20250319192153.28549-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x634.google.com
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
should also be updated like the period of mtimecmp timer.

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


