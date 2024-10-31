Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17393E6894F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGD-0007L7-C2; Wed, 30 Oct 2024 23:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGB-0007Kl-SH
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MGA-0003vg-6Z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cdb889222so5108355ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346848; x=1730951648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aECLQYoFa6jL11vXtmcyRzHRyOWnIrCCQVCMGwmJA+M=;
 b=CTuSX0T8Y9Q9kfqSpGqmaBZpUk2zeTIbduBkFs3Epkz8DHh9zyZGbWgEtObXeIQpsX
 Pruf5EjjQifoYnV0kJ7BMZJ8Y38n6Ol5rBXP+o9Bhnx1MQl8s2B1KDWxPjj48BAnuZAT
 YvsIo6rreB5l6sDXW7/Z83uORZuHbmWtbLMwOOn12bASc1qJv3/rCODLJrAa4ozmqqC1
 EU9jHgSGfXqcV+9VJoqVdyvoWIDCsicQtpmBgDEUsk8sF/NDTQT/UeEBmDnhR2+DUoj4
 +R26mWH9BhR9hW0KaF0IVEqQNUvk72qNq+4prdHr4yBIumSXGTZereODLFhuWJD0MkxC
 xnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346848; x=1730951648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aECLQYoFa6jL11vXtmcyRzHRyOWnIrCCQVCMGwmJA+M=;
 b=dTGMzvL6tqeGWT2mqlOhTeLHRs9w/RRlz1WA7pRzXGr7v8/NgUWeQJX+CpXkdtncFl
 Z/bD1s+Pe8WLqpqgkAdOZvFRsRm79Ia5KCj8+IEy/vN0+c1Vx2FMLlZJYT2brR/UXXa3
 ujzCxbDBZiD038ylFKHt/19LH1basynEkZli+sYDeL7fgM4yCwz4Rf8OflR0CPAjSR6i
 B3oLtzkeAbXEG64VeXl8s5x9oDXWzXy4lIzTvj6NqyDgOVJ8pa92TnqrEjS3XFxMSwgI
 L7BvZZZ6xzO+VmlshoC0aKfBYkHrMNjuF7I448FX8vCGKX/dTsAT83rQWyg/DmcYbGWJ
 A24Q==
X-Gm-Message-State: AOJu0YyScYvEynJkYbHp2Y7jkK4Gl03G3yPtAXTEY0++94GGg2gkOsNR
 b0C1J2x2ymfY/5XD5DpiKgwDt3sNJLLN4LO/rQlYMKpQ+G1+Lan5SXs2+GW2
X-Google-Smtp-Source: AGHT+IGGJ+LrXXl1kj3QmXcEAwBF7AtJncdMumGMQkTQzNLmYGTNYxOUvRHsgOM00sN7i+5kLs9hbA==
X-Received: by 2002:a17:903:2a84:b0:207:4c7c:743b with SMTP id
 d9443c01a7336-211039ecf51mr26714795ad.0.1730346848614; 
 Wed, 30 Oct 2024 20:54:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:54:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/50] hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
Date: Thu, 31 Oct 2024 13:52:42 +1000
Message-ID: <20241031035319.731906-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910045419.1252277-2-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 54fd55c3e6..0345088e8b 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -217,7 +217,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
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
@@ -236,7 +240,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
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
2.47.0


