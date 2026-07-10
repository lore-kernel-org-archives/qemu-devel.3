Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F51C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1PW-0007c8-NQ; Thu, 09 Jul 2026 22:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PV-0007bM-ES
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PT-0008NO-SK
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cc97653887so4319015ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652174; x=1784256974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hmz/NepL04w4ZffnyyRtbtEKZk6d3iXMBNOg5d0MXCs=;
 b=lE7iYIhAz4AIp/FGc457NhgYmuqgKjRmZ8BEdERD83JLnk31NZ30mYSx1Hz8yqwuLm
 nb3MeV2l3ZiVVRO0xGldjwPSmxfC/4NqJDFaW8M7Pjf+EFe+FDkfiNMT7GILxlshVlw/
 R+p+e1TvPXanIgQXm1aTmOg92Ig1aJB0LXEmorG6sGDyalufsUdQSjAR+g0hdgcnKCPG
 ItbpY0DkoQTVI+y30+EKwzseF2cc/w9mbqaXAyxDKhCUgwpeJU3UkQfp5tNpnNHrSMpI
 hMnNI8Gc3BE6Oy3AtQpuRAR5zYClnGh6nVNwO2cqB9cFhvF7f3E5Myn6afS+Fl08NJdg
 R2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652174; x=1784256974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hmz/NepL04w4ZffnyyRtbtEKZk6d3iXMBNOg5d0MXCs=;
 b=XWT2vnj5J0hSTRM/bRtD0zyRzJnIugpAtWAUwnccxoJC1JLqpY83SJneGmGyAi+tZk
 1yj1X7zIxXv9sRWtPjTcfxkmSW2ddwe0MRPhFEzTTF7g9fT8YNu6zr3fLfpPIj4vNARV
 Bbd61tjcXillXs199+pbz+D5uats1dqB0YuWsSW5SUlfSHo5DtRGvaloDcSDxTeGD7yK
 TLxLu1dGDRb4Ha9WDU2mQdoFJAmw5w8tQyukkpjNbPDSkJGodMbpBfAzTyQkfcsLlVb+
 g7y/IsuEXVZ84wq91Akf1E/Y/Grz8RkwN9ti/10KTyEBXfg0TdTVW1IcMoCLW4FgQRjW
 tVTw==
X-Gm-Message-State: AOJu0YzGLGgTmN7HcKfE7CBvX80or97zZhcsH4qPvt5vwusSaY11GrGA
 EFkY7aYTkHJst2NblZo9cwCwL/JdlGR/T0+IvveKi3gAC9Fv478vZmgDGwmRcQ==
X-Gm-Gg: AfdE7cn8RM3+q82XLfiiESUN2zfFINVuvP4cwr0eWzNUttT1UK19v/EPYsqhQz7zBMQ
 ad7yIDjfs0zbpHe0r9DW4S35igSIWBAS8mZI2K07eKciPi3um207Aeo1+D0O9QNM9wuxxK0O+JL
 UKWyb38GnI0TeZRRb8bGd3+3H7g1tX3W7/901XvZWkwXSNYCC2TDmTpdb6gJ6vucNLapM/Oo9QW
 gyou7U19yvAy2Uzu2mCQW1GzXnd1AdHXHorwSRSW8/NIb3JYU8UiQ0ydsKCqOmNorzyDHiFKXkA
 U9f8D0F9BN8WeyPUiKDCZIPh0ug8jlRB+6HD1DfQRYL5n2Wi1uRweekNv5IVGee+jpS7psk6C/h
 sMhMInrmwQuW5OP5NCCEdBM8wxkfQnZ9Avm3Qhv7IRw3nkx5ztiapowKpCFfN11402WZo6Bv1LD
 8IzorqV6j+QTkSW/U28bZTAm9vYz+WBmg=
X-Received: by 2002:a05:6a21:4cc3:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3c0bcfea2a8mr11288233637.16.1783652174402; 
 Thu, 09 Jul 2026 19:56:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/40] target/riscv/machine.c: do not migrate pmp state with kvm
Date: Fri, 10 Jul 2026 12:54:56 +1000
Message-ID: <20260710025525.1704417-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The PMP emulation isn't present in the KVM driver.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-6-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/machine.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ba96ceceef..ef0a8eae24 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
+#include "system/tcg.h"
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/debug.h"
@@ -29,21 +30,25 @@ static bool pmp_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.pmp;
+    if (kvm_enabled()) {
+        return false;
+    }
+
+    return tcg_enabled() && cpu->cfg.pmp;
 }
 
 static int pmp_post_load(void *opaque, int version_id)
 {
+#ifdef CONFIG_TCG
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
-    int i;
     uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    for (i = 0; i < pmp_regions; i++) {
+    for (int i = 0; i < pmp_regions; i++) {
         pmp_update_rule_addr(env, i);
     }
     pmp_update_rule_nums(env);
-
+#endif
     return 0;
 }
 
-- 
2.54.0


