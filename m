Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA71FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwrt-0003Eb-4i; Wed, 29 Apr 2026 00:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrn-00034l-9z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:44 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrl-0008UO-NP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:43 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c7961d7bc09so4937177a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438180; x=1778042980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnyPHQlUiDDCph8rrdK6ut5dk8ag4T7nwEwsUHMnquw=;
 b=VRY9+CyoHqlIhAs3MQU6RNhWmymeWGzEfeCoKYZSP4fcQvH/j+jfwbXDEbKnXi368x
 nOy5tYiqBOBDpjwmtDY3Hi+KQbq5HpwTedrIVKbWc9FXlupjaoYQOWvy258sbrtIouAu
 2kAOc4fq9dQxHl/FvTRenuW4tTt5XWBQ6+BbfwZttXnCCEI67ux+jZqdHUs2n9Fstq7O
 02ucuNTosfxYrS29qb4VeZEnmcG5zflltOrHXeX1vv9MLIULtGmnF4JTrW4Jvl47vbxp
 xQ/Kh+pGLoxDIKtdpwLajZoNNsj88hF4gX6U9mxdcc+HgquIAzC4YH27ZM6KMkCPIGeU
 aoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438180; x=1778042980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RnyPHQlUiDDCph8rrdK6ut5dk8ag4T7nwEwsUHMnquw=;
 b=GRQgnLHCfiHMZ0+Me62/XB2twI4++vI90zjcgS4roEUv8ejYpBvSDw3kpCH+eJWrmN
 f4BQHutFTkmC0Rn37d9RtT7P0cQ4wz5YBZz1gMiiNx13LWJGYW45ISBHerNjWsqWbLL0
 n6tT24pSc1s7WxL+NXZCpFPkPiz7OzaN8AcuTxbw4++sr6+Kq3zhyzTz4NCoYFY+4XRj
 M+0Eu6vPId7pmAuObp6wjRNotwVvU758SueisUZDcUs77ncK6rtY5UpQSUiWScKhUXwT
 vyezYPhsUmkFCPTan8wZ6kNXGcpuSJJV9bFXoifU2jZCjtVlLiS4TlMIcRwPZjxrkQQc
 FFNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8a4vNmSQrU/qXURgX7cWWfkEAWhAyqWksOPfNy0Y2rHy7z5RVbZsuakBym2zoj4DoBYeHRZgvblYAX@nongnu.org
X-Gm-Message-State: AOJu0YzmYfON3NfrwHKPyvxGoQX1YNG3tNQCHByGLJofjR2V4WfPbBrI
 swd62Rai/yM7I+wMFUuxr7Swfyc1kdrRBN0aQ+6OJ870A8+7VWJd/ehe
X-Gm-Gg: AeBDievN5BT6CAaRnDtAPA7IiqJJ4Jl2YcAHjNQlLkN2dsu4wVGcXaOmom0SRh11YYZ
 yacgBfSn3KuPxpo9uZmKQLQgl4dhRyO/LGyGzk5uqgfzns5dW+F5LF2fk3Gk/ro6RlzSfQL/v5Z
 o9+hrRKD/RoDDdQjOtOCYY6htqaniofmkueqBJIDKjoUkd34vsWXeKjcJxZDdaIXlTObUYxLS9n
 Vsf8tkCxsbyds4rQ29NfpTUmCLSaPWlGDlR7shNhnOHmcc5uxC5Hk3h+NUvkj6oOJlH73kF4KuB
 yE9MTjZtU+2bEPzkU6MiyIE3vDF+UWGdhgkR8rVfWMY3LlRmOy/CFqvGgDZZ3DPOVndnrCnvG9A
 QfzeBKAdDf8HHSYOUF8MK8evMQZ737dX7VnM1Ip5ghvSxWygcG3/rq2CFqNrdopaW/npfXMSUcX
 GyumoOgcivR9FjBpnuTC+GB8X31F3AWSlRCQdoC+ubYmskcHQTzUoq
X-Received: by 2002:a17:902:ebca:b0:2b2:5704:5715 with SMTP id
 d9443c01a7336-2b97c43d4d3mr56814955ad.15.1777438180374; 
 Tue, 28 Apr 2026 21:49:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/51] target/riscv: Use MO_LE for instruction fetch
Date: Wed, 29 Apr 2026 14:47:19 +1000
Message-ID: <20260429044752.4176397-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

RISC-V instructions are always little-endian regardless of the data
endianness mode configured via mstatus SBE/MBE/UBE bits.

Currently, instruction fetches in decode_opc() and the page boundary
check use mo_endian(ctx), which returns MO_TE. This happens to work
today because RISC-V targets are little-endian only, but is
semantically incorrect and will break once mo_endian() is updated to
respect runtime data endianness for big-endian support.

Use MO_LE explicitly for all instruction fetch paths. Data memory
operations (AMOs, loads/stores via mxl_memop) continue to use
mo_endian(ctx) as they should respect the configured data endianness.

Not-Signed-off-by: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260311115910.564481-3-djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260318103122.97244-16-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1a25c517a2..f6b915a7fb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1258,7 +1258,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
          * additional page fault.
          */
         opcode = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
-                                    mo_endian(ctx));
+                                    MO_LE);
     } else {
         /*
          * For unaligned pc, instruction preload may trigger additional
@@ -1266,7 +1266,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
          */
         opcode = (uint32_t) translator_lduw_end(env, &ctx->base,
                                                 ctx->base.pc_next,
-                                                mo_endian(ctx));
+                                                MO_LE);
     }
     ctx->ol = ctx->xl;
 
@@ -1288,7 +1288,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
             opcode = deposit32(opcode, 16, 16,
                                translator_lduw_end(env, &ctx->base,
                                                    ctx->base.pc_next + 2,
-                                                   mo_endian(ctx)));
+                                                   MO_LE));
         }
         ctx->opcode = opcode;
 
@@ -1404,7 +1404,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
                 uint16_t next_insn =
                     translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
-                                        mo_endian(ctx));
+                                        MO_LE);
                 int len = insn_len(next_insn);
 
                 if (!translator_is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
-- 
2.53.0


