Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3E6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 11:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg0cN-0004k4-A5; Mon, 19 Aug 2024 07:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sg0cJ-0004in-Sn; Mon, 19 Aug 2024 07:32:08 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sg0cH-0007tE-Sg; Mon, 19 Aug 2024 07:32:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-201fbd0d7c2so24158335ad.0; 
 Mon, 19 Aug 2024 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724067124; x=1724671924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=021PAq7IpXYIvnIVv8yykD2C9A93y9EXWvxSgWQNcyk=;
 b=ByB9CW46n/C9Z1E0eppec16imzZPmsXiXWfRxHGDyMOnNLRh4q0nT4ykmBRlbWncPx
 Qcg4GqcCXlE8gj8ZlvoH53QrrV3D4X1kDNpqIc3Cy3DaTi3gt6gp3GYQkn6hrwEljaPb
 VCxQlP8s8Sm2yASYfyP0VC8kwr36nzECdaif23/li4ODXvBZspRrwwnzwa0j7hcvMUz/
 +RXNJRkFm2xc2XGVMVGh4ggy+BKNzNOdh+dhiIgDETUIKdkhB0Ev9RLmRR4FqTmTExPw
 rVHfONRDs9qu2JLqgrbUgm6QUIiBForJFrEgTZZOrYDGy1BUCVmxxhOVI/8qpeFjlMcy
 4EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724067124; x=1724671924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=021PAq7IpXYIvnIVv8yykD2C9A93y9EXWvxSgWQNcyk=;
 b=XUmIVVy1FyVuBTLOgWs/XYsUZRLNnEHg5U3tnAzgNrfyJzTCFWgOV40m+hKlHGAUBf
 3HWxtHB3/BbP2WLV3KaaHtobLMfVG02+6HpIrCKDrm+XR5kcngW5D/krKbWzkW7rzUq5
 arNf58exc36uc9XtflqnsyylUaNS3y3w3czrQxygY0/RkXcNb/wYwJiuhGO+/J++Q//R
 c0VDwiEwniNK99O7Oo2ydF8t9bE0tjo0c9N7n4Y6F6p/zqwLIzvhS5TfoX0/loH0feUC
 T4WuyoVTwnz/vavkJkBUbDMyTrpTVtgJobmY/5UkNq4QuzEslobdUtXdERMu/lmu3U4s
 tpww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtmCwAZ/+FNILVCIMp8p60b9jYaHdkWxbZHUeEkMyH3UEcSuVUDPQwBYnOZBfzGrJZ/+jlZ0Xc+V1vHP2q1a2NNtCnC+CwyXMffSa7FVLj//Q2wcGswJszMrTG3g==
X-Gm-Message-State: AOJu0YzItAAsplxd8GfpHzLxIgKMXYljxV+z5kcRQ4PN0LcU0T0guW+Q
 WKiy/5lmB9wy6IfV+HBjK4RSrf6+mnvL7cKPfwroKvWJUqs+AP6P
X-Google-Smtp-Source: AGHT+IE3dYfue1VGocS7gztoDn7V5ccsnhmGclrjfY6RCgAHj4ZxfR81GQhL4p+wMK33lTJ64Q5r5w==
X-Received: by 2002:a17:902:da8a:b0:1fd:8c25:415d with SMTP id
 d9443c01a7336-20203ed3a00mr83580015ad.36.1724067123559; 
 Mon, 19 Aug 2024 04:32:03 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a84esm61263445ad.189.2024.08.19.04.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 04:32:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	alex.bennee@linaro.org
Cc: liwei1518@gmail.com, atishp@rivosinc.com, palmer@dabbelt.com,
 Bin Meng <bmeng.cn@gmail.com>, zhiwei_liu@linux.alibaba.com,
 Paolo Bonzini <pbonzini@redhat.com>, dbarboza@ventanamicro.com,
 alistair23@gmail.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 1/2] hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
Date: Mon, 19 Aug 2024 21:31:47 +1000
Message-ID: <20240819113148.3007047-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819113148.3007047-1-alistair.francis@wdc.com>
References: <20240819113148.3007047-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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


