Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8CBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 01:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sePhF-0005V5-VD; Wed, 14 Aug 2024 21:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sePh8-0005NM-Ra; Wed, 14 Aug 2024 21:54:31 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sePh6-0003la-W7; Wed, 14 Aug 2024 21:54:30 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cd5d6b2581so328825a91.2; 
 Wed, 14 Aug 2024 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723686866; x=1724291666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUCMHPp07k4dvdcPQu5lMZBREYWJ6ieRcJ5oeGbqTms=;
 b=PdCU3USff2o1vExOiGJgzJ/isiFyrOqdSDHBCvSljI2N2mIuOI1P2Adx1lh6CjFwsa
 4za85tB0mkvQoBOA+jVjmCCQtCGPGPxvpNtUkoWmc3cBE9+lseCxERwmVL2tJfM4FA16
 HPNwIKj668tZSY5mPEYnG3C/1kScJM6EYtd/XU/OrU0w038loppENmuVHnoVfKig6Xw+
 3Q1GpeYcR5rAk62LrYP1Sc1dWsE8H8VvIOZ45dB7om7FPHxMXQ+duvOd9RQDT0AkACTx
 Buse/PI+YoDLX6+f5I+VuIJ8VsKyxguTBcPU7N2P3RXOv0PQFuB2J7Ss4zMFZrUX5mn4
 TtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723686866; x=1724291666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUCMHPp07k4dvdcPQu5lMZBREYWJ6ieRcJ5oeGbqTms=;
 b=Joo67bvBNsxlnNbJcW4P30E65vlXGNXeAHyb5Q7Kmy9JV8wOc2ezs8bCTPamTyaH7w
 rIM3Y7hYJ+UIL2/0reMnQtl42QrguYwJS9if7gRGzS1UNZNjipIQiQqyaGLpxLeo1IzM
 ZkvAzkJNz4uHtRxGpe1qj69wyrfZFdek71h23Tvx1eFba/vaTs8r5Fb9G6NtjsiVWkhR
 hlulwQIuydChc0O4VtluMqa9N2n4e94AEgKDMxZRmv57uQSh/TuZRQVUYz0mTHS4k39d
 Y2DCqK3z8VtiLBll8O/EFLbQBIJox5ySjQqpBZ5FRsvNQLcOpdt64HD8WW/2vp92eYUL
 F5WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxeM/e4gVIpDRSpHUJHawTEa5EfXQC3/LIIsYx1lzikdV6yo9CA+a8HhboSM2Umnosg3SSpOFCCqc7OkgqrS4VJ7/oq39HqygbOkZEU7sGUhy5ciTjkdw6O3r/1Q==
X-Gm-Message-State: AOJu0Yx7SrzfVAicCWcBnZyZOi4xuMTKcftBrfnYNZHgK9AkWZa3DTGd
 S9KnTNXl5DYzjSoze8xa9kAHgWx7KBZOxTHNzr2cXKgvq0hWFVIMSKgqbA==
X-Google-Smtp-Source: AGHT+IFbUvGY8XDCMtEcLPXd/qbZH+O5ifETchpqHujU41urwQ2Pm0W7NId2cPVk4knAipSxFTIUug==
X-Received: by 2002:a17:90a:c8c:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2d3aaa9cffamr5227352a91.17.1723686865951; 
 Wed, 14 Aug 2024 18:54:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d396a59287sm2477688a91.0.2024.08.14.18.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 18:54:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.bennee@linaro.org,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: alistair23@gmail.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com,
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
Date: Thu, 15 Aug 2024 11:54:09 +1000
Message-ID: <20240815015410.369925-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815015410.369925-1-alistair.francis@wdc.com>
References: <20240815015410.369925-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The current approach of using qemu_chr_fe_write() and ignoring the
return values results in dropped charecters [1]. Ideally we want to
report FIFO status to the guest, but the HTIF isn't a real UART, so we
don't really have a way to do that.

Instead let's just use qemu_chr_fe_write_all() so at least we don't drop
charecters.

1: https://gitlab.com/qemu-project/qemu/-/issues/2114

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


