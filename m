Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA4FCCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWQL-0007fG-HZ; Thu, 15 Oct 2026 21:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMI-0000TY-IU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:51 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMF-0004IO-La
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:40 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ac6794fe45so1918363a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112618; x=1792717418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/sIldZ0dU711EsMF8z6ztMUtXll6EZ6iwh6/7xBf8+M=;
 b=GRXNlWh+PZsEbiN+7QC1n6Q8N+NdxkSYOJ25KVr6j5ueJXVfUHE6Dhd24ZhQM3RnP7
 7JGtABX142i11uzbCdRHYBX2oRKBErGo2jjQbbhEH+8xE5rU+TGXU0tScxDhleKOaR83
 AYygs2J+UtOFx0F5aIX/J3bG/zU1AqqCQodZ5dbG1IYJ8gvelYErXcvCUQD9fRZNOiBd
 LLjI49ArIHt2Ac//h+E3yy639XhnER/ffVC7VwdZ0U/Gs479vMmkQZkB0aHvcjWwlqYp
 d0ZxO234S/24AiW1utfcuap4bhoYnmksmfc1mkIG3kjJhg0g+1P+N5wvdWtWVaxKmwqx
 e+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112618; x=1792717418;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/sIldZ0dU711EsMF8z6ztMUtXll6EZ6iwh6/7xBf8+M=;
 b=SX/ShCMeuAOPy4QMva8/A6L5sdM7c2EkLy5DYNoJfzP7hLWmrxHH+BWCP2Xv8WlI6g
 O5BvaM8xQdlvbzODfETJzY5E8XpCgSxwlEtQaSHkolILCSPUQfZNdjzkTGUEo/y2VEaR
 86c7U9CdCbT2St+BeW8ZHajK0SuZzx0CTBdq5lC1Dpmpti+XhxtUHbPaJRXoW4C1O1q6
 IBK+El1JAhoyfwFnUnUdoFZA9OucuvVF9Lt9f9bS94/d2P7S8qNsNqDzTNscHYAoHRuB
 7NQ2+Ow7BBbhkIK0tePNmha9OBwFi5nYD8GeUpDls/zRg+gvq5QmPYopxYReMspiCjR5
 2+lw==
X-Gm-Message-State: AFq9FYLD6wThjZXyRjfcAABBFBqkR+ZzlF9d1ORwthrY/Rbr+MYCbTRC
 tvItGCDqgk8XYLwoHlko7zVrhfvBP815XbFm4ogkRsvurehJdBGtkDTk5nRzTg==
X-Gm-Gg: AYBFou0sYLpYATTL+OI8ZhVKAaEYz68sGERpuOliOLZ8s5uboEVyzIaoIS7HfSsaCO4
 Q40qPhdCwCBANSBxYoKVM83NmCpVS0qQZgeG1PLWjPJ0YTCh3rv+jacXL1fNzZjaIU+kXnYO/oI
 U2xZKyTqLf40n0447kRrl30mIkGBM5CSpVLQoubE0z+5Zuoz/jVoZm9xkjlgoMTKv5lESBcY+QD
 tQNgO67upZt4HgYI7AIAI5BJ9ZRklEIi7bx6Npapjki6Rezbk0zegxkWEBd5tXcvgrbsdMBJrca
 /iiWVP5bSu6nIiiARojFeYgQV2/kCdFLbXw1PXiaYzj9O2Mkz/OJQ0nSW1EaY4WjXLPzh5DoSGY
 YfWlzVpaO5tT8TiMisNo8OOQ+3OdkDg5564zTD8yCXWnw0SFiAHWQp2+Cl6/P9/R0/uHH5dVTGl
 DzIgvoXkL9h/AGohfikJBD7St5HOx49MbXxuclyXJH5vFXj8/Xmuk8rlZTEayd8obJJ6pipKR4B
 4Jx9q6gnM5HJY6j
X-Received: by 2002:a17:90b:134b:b0:3ac:12e6:a5bc with SMTP id
 98e67ed59e1d1-3ac12e6c028mr10947358a91.61.1792112618313; 
 Thu, 15 Oct 2026 18:03:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 18/50] target/riscv: Clarify riscv_accel_set_irq() arguments
Date: Fri, 16 Oct 2026 11:02:05 +1000
Message-ID: <20261016010237.1102834-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Use per-accelerator locals to make the differing conventions
explicit: TCG takes a MIP bitmask and value, KVM takes an IRQ
number and a level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-4-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/time_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index ede1a4c2a3..29bbebb96f 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -25,18 +25,24 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 
-static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
+static void riscv_accel_set_irq(RISCVCPU *cpu,
+                                int irq_or_mask, int level_or_value)
 {
     if (kvm_enabled()) {
+        int irq = irq_or_mask;
+        int level = level_or_value;
+
         kvm_riscv_set_irq(cpu, irq, level);
     }
 
     if (tcg_enabled()) {
-        riscv_cpu_update_mip(&cpu->env, irq, level);
+        uint64_t mask = irq_or_mask;
+        uint64_t value = level_or_value;
+
+        riscv_cpu_update_mip(&cpu->env, mask, value);
     }
 }
 
-
 static void riscv_vstimer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
-- 
2.55.0


