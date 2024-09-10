Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15927ECE57A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 04:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snstp-0003t0-ML; Tue, 10 Sep 2024 00:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snsto-0003qb-8S; Tue, 10 Sep 2024 00:54:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snstm-0002wi-LQ; Tue, 10 Sep 2024 00:54:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-205722ba00cso43281235ad.0; 
 Mon, 09 Sep 2024 21:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725944080; x=1726548880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsWFRdYWdBaST8wvMPQrZTKJI/aAOCM7Gcb6EQnnHW0=;
 b=ADDmu4i4diWAWmpDU68MKFDRIKost0ioEQOqokRnMccG2iVWrMtwSv8IJ7/HaJGxW9
 4UaRQXFd6MQ/r/YBSJeHF52JnVYbh0yGD0jqOgT0+z6tPWwDrMGti6diR+Cq5z2taZ9Y
 5tbJ4v1iHgDJBzTXrIXvrqrPSPMviscbmUZfXY3pMwrHJ5SXy1U0ASYV0NAV8vVbmbim
 5bru0YYfjKf4B2c/END1kgaYb+g6UBEx52gAR/5cayW84iJU3NHlkZEnrgSw1QPt5l5f
 SP6xLtpDSDulURRBR9tArakH/KT71Y+7dkbinfZUyKFNn+tSQlMBTwCM9Prflw/pRqyk
 0Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725944080; x=1726548880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsWFRdYWdBaST8wvMPQrZTKJI/aAOCM7Gcb6EQnnHW0=;
 b=nQiuP4ML9gGn1bjqJFTM8SAs9wmzKuRuFkFL68CfgLCKD03+TqL97/oVhhV1IHG7/L
 KT1aOPHeYlLEwfpz5McEc2sjr5yWTBw+bI4A1CohX8UiSakENuD09keI026djdyg3Bnd
 2geKh16Vz3zR9FhKHuil9FUWK6A0WD0+2JVfHQuK7Ye/O6NlUJKjEy+0ONXWo08jJtSM
 AI+RQXxwQ1/t1GGoCUJf/JfZ6Qg7S2HE2Ox8cPVazSADfJ/raP2/LN7fdMgwcqVXMJNV
 rXwYD29E/5ZYXRnUFhCo7nlXAeaBPYvKUNdwjsq6z9Nb7TjXa6AHvUZsFo58YVd2V0Mg
 X0Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm2YraGkjpF78zfqu1lb5PlWHqT+EoNkEDkyvf1GFxnJaAJ5WfrU/PlIc2Ot9b1ckTP0W2MEAGJz2m@nongnu.org
X-Gm-Message-State: AOJu0YxuJaslV4UH2f3n05knu359JFKffBKfBCnmRs+uEMXjFbl/Cd0j
 GnQFgNHnoDIFeOlNtQtGYlaCmBf773uZlV0WPkLv/YCLjttaqmd6r/LeFA==
X-Google-Smtp-Source: AGHT+IFDoRw0eMMdU8vPnIkwfHRlJT5X7aP5QRJldzhxYJuwZ384MDCvNFtWEzobczdFbKHZcy0PSA==
X-Received: by 2002:a17:902:e88a:b0:206:96ad:e823 with SMTP id
 d9443c01a7336-206f05e78f9mr2933955ad.39.1725944080494; 
 Mon, 09 Sep 2024 21:54:40 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e352d8sm40944425ad.72.2024.09.09.21.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 21:54:40 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org,
	peter.maydell@linaro.org
Cc: Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, dbarboza@ventanamicro.com,
 Alistair Francis <alistair.francis@wdc.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 1/2] hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
Date: Tue, 10 Sep 2024 14:54:18 +1000
Message-ID: <20240910045419.1252277-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910045419.1252277-1-alistair.francis@wdc.com>
References: <20240910045419.1252277-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

The current approach of using qemu_chr_fe_write() and ignoring the
return values results in dropped characters [1]. Ideally we want to
report FIFO status to the guest, but the HTIF isn't a real UART, so we
don't really have a way to do that.

Instead let's just use qemu_chr_fe_write_all() so at least we don't drop
characters.

1: https://gitlab.com/qemu-project/qemu/-/issues/2114

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/char/riscv_htif.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 9bef60def1..d40b542948 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -218,7 +218,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                     tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                     uint8_t ch;
                     cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
-                    qemu_chr_fe_write(&s->chr, &ch, 1);
+                    /*
+                     * XXX this blocks entire thread. Rewrite to use
+                     * qemu_chr_fe_write and background I/O callbacks
+                     */
+                    qemu_chr_fe_write_all(&s->chr, &ch, 1);
                     resp = 0x100 | (uint8_t)payload;
                 } else {
                     qemu_log_mask(LOG_UNIMP,
@@ -237,7 +241,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
             return;
         } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
             uint8_t ch = (uint8_t)payload;
-            qemu_chr_fe_write(&s->chr, &ch, 1);
+            /*
+             * XXX this blocks entire thread. Rewrite to use
+             * qemu_chr_fe_write and background I/O callbacks
+             */
+            qemu_chr_fe_write_all(&s->chr, &ch, 1);
             resp = 0x100 | (uint8_t)payload;
         } else {
             qemu_log("HTIF device %d: unknown command\n", device);
-- 
2.46.0


