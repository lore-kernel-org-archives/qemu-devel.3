Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B36C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsgty-0006M9-06; Sat, 08 Aug 2026 09:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heavenlydev01@gmail.com>)
 id 1wsfxn-0003UT-2Y
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 08:15:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <heavenlydev01@gmail.com>)
 id 1wsfxl-0007S7-Hp
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 08:15:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so222170f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786191339; x=1786796139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9hCpIvG3zqFTWZ/emUUOQn6PM9sEHG4810l70rNvOKA=;
 b=dQ/7yDKBRSobvW48/shW7rwk72Pi1tJAv8I+Utw/+4RDo3iWX3GW3ioLId94Gww6V8
 3u1hDiZktzqHSyjp898p0croX6KT5hU5HQPLqc/Hnf2I0Tkn4sbMT7+wEUeaPCNlAeDd
 h+qDQH0uJXtnZD23XnjONo5wWvVgDVjUk69q+y3fJLTC2Y6SRo49Xovl86I3I2e38Jqt
 YjspR37BGW/e5f9KAvHn7YK325uCtu13ZvxVXTt1hfEKNNzqph59kZ5B40NKC0WPHl7l
 7/rxGegvvUGXiKqFKkFjJppJwW8WqQYyi9jpDscG12oyfvLgLuMp9eR6u5rGxSzJcqge
 F8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786191339; x=1786796139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9hCpIvG3zqFTWZ/emUUOQn6PM9sEHG4810l70rNvOKA=;
 b=WFr+VJhxLwNtNfcnnjnUWP1VhzEucHJ9C528PhglCVhrXTOoPlZop9PLQP2gekv5iz
 IPdBUlphYg9V9tgRwMUC6VATj6w8naNR7IPKEyeZjitiIlvaEV/xjsowSqQSGXGxCj2C
 OKf2TJEtN0j7CcdNBRtiY0IDal00sm9chj2IIFTJ2AfJvTGs5Yu7pc18QlOWf30ONwPR
 +oMjTFb4zeZ6swasnnsBu93D8Yog6j1CbVpQDxOFF2dOcnv9r2yRhg26vgR9lGZPaH8j
 RQwMzgvJvvp1tUMVX61xAyRbhiHNsxfSJtdJDe7BApNRRfV8lLlcPP2HPhikPLi9oNZ4
 L9Tw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrr0f1fZv4CnQxHWNS9CjVUZH9DhYrUhxvkZF6ecfMoowdvdYENbpdzZYSw4x7nVNO478D0rg7S4wsy@nongnu.org
X-Gm-Message-State: AOJu0Yy9eb3LNVwJP5s5IPcism3cnVQw167lvpphg9HtCBiXWNDiTm/N
 i4zXQGW3eUIvM/o/u4i3RAPigAwdDSNhuG4Dakgj79Blz8/MFO+54kaG
X-Gm-Gg: AR+sD13Wuvdiz27rsttJ/89Wb44zgAacbToV7GdMCElp+ye9KVJXOQwkZh1DxU4Wu7L
 uzO6VXvFmFc3SIjrx10qS2cG7AbZE4Zfct1OWKbB4rVY1W+lNvKy/I0eCTBAI+PHQl/Atf5I3EA
 V9MnQ1yV301nTbtE4bImOiKFj865k7W48X9Ab9m2LsFc16KHLYabfpLcmBJrcU6rk1Eac4O9iC1
 APOcya1hiXNbw1wlceKjtwD9KZPwpIjFQonwo37yRK5hxkEtrLfvx0qu+WZeY0B3j7BghHhOrEh
 wIBwYZKqz4XmmL0ILDWpQLc2CqzY+hdO5D6qR2rLbxKlBBc3S0NheRHh4ggrZkTUvlPRu5DxV+p
 N1+0MhwCmMnQusWFq1Z6kaGL9ahsA0UZ8H4upmUdBy+Kr7e+XBQUcpzLBLzuZUhYkB1AeaFylrk
 Op/Opm78e+/mGNziBeifNnsoHRRhzh1FcZjt57ZsP3J1ab5/pCtb9/cJNwEjoxVqvlSs9VhyR6z
 zIWoK+uZZer249GSc2B
X-Received: by 2002:a05:6000:460f:b0:47f:8b1f:efa2 with SMTP id
 ffacd0b85a97d-47fec50c810mr51012130f8f.8.1786191339462; 
 Sat, 08 Aug 2026 05:15:39 -0700 (PDT)
Received: from localhost.localdomain ([193.145.230.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8cd0sm14855995f8f.17.2026.08.08.05.15.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Aug 2026 05:15:39 -0700 (PDT)
From: heavenlydev <heavenlydev01@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Enrique Abma Romero <heavenlydev01@gmail.com>
Subject: [PATCH] target/riscv/gdbstub.c: use misa_mxl_max for GPR write width
Date: Sat,  8 Aug 2026 14:15:11 +0200
Message-ID: <20260808121511.18088-1-heavenlydev01@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=heavenlydev01@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2026 09:15:48 -0400
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

From: Enrique Abma Romero <heavenlydev01@gmail.com>

riscv_cpu_gdb_write_register() decides whether to sign-truncate an
incoming GPR value to 32 bits based on env->xl, the hart current XLEN.
This is asymmetric with the rest of the gdbstub: both the read path
(riscv_cpu_gdb_read_register) and the target description size registers
off misa_mxl_max, the maximum XLEN. GDB therefore always exchanges
8-byte register fields for an RV64-max hart, but a write is truncated to
its low 32 bits whenever the hart happens to be executing in an RV32
privilege context (env->xl == MXL_RV32, e.g. S/U-mode with SXL/UXL
narrowed to 32). The upper 32 bits are silently dropped, so a debugger
cannot set the full 64-bit architectural register even though the CPU
state and the read path are 64-bit.

Key the write width off misa_mxl_max, matching the read path and the
advertised register size, so a full-width write is honored regardless of
the hart current privilege XLEN.

Signed-off-by: Enrique Abma Romero <heavenlydev01@gmail.com>
---
 target/riscv/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 9abbf5b..9284579 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -89,7 +89,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     const size_t regsize = mcc->def->misa_mxl_max == MXL_RV32 ? 4 : 8;
     uint64_t tmp = ldn(env, mem_buf, regsize);
 
-    if (env->xl < MXL_RV64) {
+    if (mcc->def->misa_mxl_max < MXL_RV64) {
         tmp = (int32_t)tmp;
     }
 
-- 
2.39.5


