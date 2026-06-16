Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAEECD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjX-0006qC-5l; Tue, 16 Jun 2026 06:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjV-0006pK-IX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:25 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjU-0003t5-0R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:25 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c858961a8efso1814419a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604563; x=1782209363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyL2f336HSE9UBR6i/wiYZkJNqrj2PCoYVGUodbMamE=;
 b=M9yjGU1SK9ThQJ+zdzUeA04+X09AiWbvKlcGyyBKk+qZtglNG5YIDJ0YfioHwJQRoX
 FND5j8znxZqBOueN7ev+2XziAZU8F2c0x84WVk2ejw8Prg7lgOOpjET5XvkC8jEImVMx
 XQmbWNxCDg7hLvfEQInCQN8Y+G2YWjU0xf2AofgKVlnC/HcT17Xle1/Ad1P/YAQLiTks
 NvkMa82rA97tn73/7PMj3OnIVTr4EhBzPR9iDidPQ3UuD2qkYEpG0XyjtBho738UzjbZ
 Xk3gN+kwSj1yEo18NPO+8fTzusgWf22jFRk3kYnaFhFuaQjtZOXuIkffGLPoPhVZnt8q
 02pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604563; x=1782209363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tyL2f336HSE9UBR6i/wiYZkJNqrj2PCoYVGUodbMamE=;
 b=ENRc7FIN+EpopwBU5qBm3KOMtdNw6yt33SRD1Jt+T/n2prTwmytQ4mk0fQqptQi0Mn
 y9sacivVX613aXcYjxWrGmuNVYTLPGCvL1gj7PQKPSmdcHtQCbxNOmXESlIeWbCVnrQz
 f7KT11Qu4IPMpxN+px1Z5cwzom+az50+H4gEaOxC4TdqQFbgLhrKx+9f6P7Yp56HRWbP
 DL3PALqxJM59ga85+tfdLgU2RaiVYe/1opuAuAdqcTX11fWeLW3pe4xg0sPyaWDQ7hWU
 UmD/mIM7amd19/Dbs5j0lNtnZS1Y79Hd5loWzQPtx07+UAT92ZqvSQGMBTWzapq9THV1
 Ajxg==
X-Gm-Message-State: AOJu0Yw/0zjeXNyxO7EVlkRFRUrOwQpLU4l3WEzex0rajNoxb8cCC6eu
 cpp6xVm+wU8yAyXg3AvBJ35BTBZ+5Tystm2rWMYnIfYkvbHSMBKderRQqcobmBr0
X-Gm-Gg: Acq92OGxiCI06mJzbxrwtF4K51MZbWYY4DUT6M/W4/lYebRJ4btwrA/r8OmYawb/S/u
 jneYXgB2s3HYh3zVBCA104tUGpuT5cpkBzvC3q5PWoq1BXk7IUmsKoe4ztDnTl0FyzCw3+77VEn
 GE+TlkIa+stOEZskZ1z3RbSE7ICOvpt9CwxvgQqWM/IqhkFYN/9D1WJiTyfbf/7/EHH4NnjUnTt
 CL+0LMyih7fLRk2TS/3NuDoZ1EL6eNsaweUYPbYYt9dB5LDnPzbtrjSNCII3hmuOb7nfqSwSSSX
 oqgU9AMgnIuBbd2S85AUlKxlMWk4SZUf7csWYycg7iMjxHul8UArlX+R9svDt4PCF8Dgubo1gFw
 budqfh1CduFqNCvHVuzz+M/GAHhzWw6SC6toG+J6GBsDo6InopU79JRrGcPasTjZdoS0bZyeqrB
 1pVIOOnYjFFK/pXI7YIMBz7rbPGM8N97h+XEo8nm4+
X-Received: by 2002:a05:6a21:2986:b0:3b5:4dd2:7284 with SMTP id
 adf61e73a8af0-3b7e49510fdmr3422267637.9.1781604562662; 
 Tue, 16 Jun 2026 03:09:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, imaginos <imaginos32@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 65/83] disas/riscv: enable `mnret` disassembly
Date: Tue, 16 Jun 2026 20:05:08 +1000
Message-ID: <20260616100527.1939565-66-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: imaginos <imaginos32@gmail.com>

The translator has supported mnret since commit 3157a553ec6b9a
("target/riscv: Add Smrnmi mnret instruction"), but the
disassembler still renders it as illegal. Add it unguarded,
since the encoding does not overlap any other extension.

Signed-off-by: imaginos <imaginos32@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260614141315.17320-1-imaginos32@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index b8ec546883..7f1b262773 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -989,6 +989,7 @@ typedef enum {
     rv_op_cbo_clean = 957,
     rv_op_cbo_flush = 958,
     rv_op_cbo_zero = 959,
+    rv_op_mnret = 960,
 } rv_op;
 
 /* register names */
@@ -2263,6 +2264,7 @@ const rv_opcode_data rvi_opcode_data[] = {
    { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
    { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
    { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -4077,6 +4079,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 64: op = rv_op_mret; break;
                     }
                     break;
+                case 1792:
+                    switch ((inst >> 15) & 0b1111111111) {
+                    case 64: op = rv_op_mnret; break;
+                    }
+                    break;
                 case 1952:
                     switch ((inst >> 15) & 0b1111111111) {
                     case 576: op = rv_op_dret; break;
-- 
2.54.0


