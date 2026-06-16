Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2D0CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQfx-000534-4d; Tue, 16 Jun 2026 06:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQfu-00052P-SA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:42 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQft-000309-7n
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:42 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c858dc05ee3so2614311a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604339; x=1782209139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=579fDnycKwEIquqyh6afxaytmurovCPt44b3Wi782Bs=;
 b=LDr3tRLdnfkYe6RWJmqYrqV4gLHj+FW73NtqB45OnxkGVaxafC6QJYUyUEJ+A4Dcen
 U9wt0XRwvXiqd12Wvsp2rxMBQIGE+0tyT/+OQvxG4P6Nl5OJ2svug4TfOX0ggzGUHoCc
 /3vLmehcCRh+Yf4PkbZbgwk93J/Vd0KJPxY9CvIK4UXvmxiyEscJOSptjoowKtn8zrsu
 KarSet/s7NRgaSSR938mc3yDv9B9QFfLk7UxBWUCEPUnebNi5adjYAFYOel9nQAUHSO9
 MjnvoRr7sNjebFbUrUym9nof32ITzZC+6sqD3Kip8aDZuZfTB6qIe0Ux7UuiE81Y/SGf
 n0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604339; x=1782209139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=579fDnycKwEIquqyh6afxaytmurovCPt44b3Wi782Bs=;
 b=KfvkKk8s5zvXW0gGiqN+NgRCsHnJgP4X7DKeykWXLj7YOU/tJsTPKZlDjaMVsWTepU
 +Y4/Wgl9WtUIx3D/LzgmtgeOYDV8QzLvH1SE9wRjBn6Nzbb+47aKaYKS8BS1ude6Ww0G
 g+aQ0YjMSj1o7rYH2v9kXAFR/F0jAEoKIpXZb0fRDfBmQTrL5w2uObEKgHKJqn2cRe+U
 +RGKsrV8suqUTXdYY6EjFzgp7i2J0RjWx7JXmPcOj9+gt0sh4aDEdWaXx10FYe31cwGy
 mm5Zs30QpM88hMrAMA2DGjn/eNxZYd3i9U/wubNbv7Tve/7QPBZ4e3S/4fNuCqEcpviY
 x1YQ==
X-Gm-Message-State: AOJu0Yxd0lMbRHQr3wjAN4FJqJgbRY4VjWZy1qU+Bs74kA8OlUefShtN
 5rjOsLEqWguzHQPuBv3CefcC/LRp5jTzRTSgQ3sIP+HB06EnkHp7NRkNuLo9g/sD
X-Gm-Gg: Acq92OFLDtjQeRAYnXu5SGIyxRC1rrYx1fTUIVARLtg5dr8kKZLQxKTy75/Gd4b1Ov4
 DvJuGk14GZuWWRLwPuOPkIRKm8udoHGjCD9wWS6BH89ucCb9djto8Ra0qZk+Vuhyw7nwVh2n8Sv
 AnWic8KS0giGeN+yQv3K//iWcqP5fsvbyxeYZQ5Rs5oxt5exPT5gfsdIX29EnwIkV8v7ITqe5co
 dr+vsDfnLJCOquDcCwppEElf4576tBDeiI6587VDX6FW2bFUXYuTJD5vrrRvk32ye49LJ9PP/cM
 GS1ltnpNuB9lUuK4WrqUPvd9be+azX55BX1l8UOuyk4/iDHRoZ5pXY8R/kJYi6gOczBRZwd/7zq
 ydBEAaAqzK/ygCtyY7urFC2gPYmnmNl2w3nnXG+g5RfY8S3jGFiwPQZe0PBAN8UCbigK94CC1tL
 A6RfodI7NQACP2Fj/B3gWasHw/GCqFrdt1LfGg6wMM
X-Received: by 2002:a05:6a20:ef18:b0:3b7:d8d5:232b with SMTP id
 adf61e73a8af0-3b7d8d53111mr5205188637.8.1781604339517; 
 Tue, 16 Jun 2026 03:05:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:05:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/83] target/riscv/tcg: disable svpbmt if satp_mode < sv39
Date: Tue, 16 Jun 2026 20:04:04 +1000
Message-ID: <20260616100527.1939565-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

Priv spec chapter "Svpbmt Extension for Page-Based Memory Types, Version
1.0" mentions that "The Svpbmt extension depends on the Sv39
extension.".

We're not doing any satp checks when enabling svpbmt.  This causes
problems with the riscv32 'max' CPU that happens to be enabling svpbmt
even though it doesn't support the required satp mode.  In fact all rv32
CPUs are allowing menvcfg.PBMTE writes, which doesn't make sense for
them in any circunstance since svpbmt is not possible for rv32 at this
moment [1].

This also impacts rv64 CPUs that are running in satp 'bare' mode and are
reporting svpbmt in the riscv,isa.

All these problems can be solved by disabling svpbmt if satp_mode is not
at least sv39.  The problem reported in [1] goes away because we'll
never enable MENVCFG_PBMTE write mask in write_menvcfgh().  We're also
become consistent with how svpbmt is enabled for rv64.

In case the user enables svpbmt in the command line using an invalid setup,
not just disable svpbmt but also throw a warning:

$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb \
    -cpu max,sv39=off,sv48=off,sv57=off,sv64=off,svpbmt=on
qemu-system-riscv64: warning: svpbmt requires at least satp sv39, current satp mode: none

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3473

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3473
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260519114858.316532-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3e22e7ed53..f8b2f04a94 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -837,6 +837,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_svpbmt && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
+        cpu->cfg.ext_svpbmt = false;
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svpbmt))) {
+            warn_report("svpbmt requires at least satp sv39, "
+                        "current satp mode: %s",
+                        satp_mode_str(cpu->cfg.max_satp_mode,
+                                     riscv_cpu_is_32bit(cpu)));
+        }
+    }
+#endif
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.54.0


