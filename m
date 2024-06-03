Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29A8C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hN-0005ts-Ej; Mon, 03 Jun 2024 07:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hB-0004k1-9Y
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gw-0006DJ-1c
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f4a52b9413so33629875ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413441; x=1718018241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql0FgN5uAYwS4fjD417MxORch4Nog+b+HrGavXDYZwI=;
 b=AroLpvhJIfbxr2BqgWt3ygVa+pHk337iyf8iBKjMgcJM0YkWfA3pFR6Vv0nYyT3Jma
 5KPBGc2AwvU8lqeZEOwyeu+Rkx5uvGpCfLBRQLcP7knIqJF5VK4vjMIVcbkB8Dubh5Ow
 f8IaOVC7BS/mqge2baPV+TvKPVH7azInLHqxADGb83iZ5Mw8lxeoDpKWVf7d8Y/Tlvpg
 cqfpgzIIXy2fKJKc32vmaN0wVHGWoeDfuf94HfG4/zDK2RjKasqcVEYZo2hlseKhtXb0
 E2mTjvvVy9I2NCEWWcFstCI6X1OLIlFNXcKZlT3uEWyt3IwNjFuPoopq92lPQTVu5yiK
 MLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413441; x=1718018241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ql0FgN5uAYwS4fjD417MxORch4Nog+b+HrGavXDYZwI=;
 b=VoTgDkKTJTihamJYVP21WaJZf94tSLzNy/aqgjKHYfa7IwAgQtZtBUIFxaG2jt2zxj
 zEtpd13zNaHDlh543lwIEgNdyusp2HxSgdrs7rCvh9UkP/7feayZFvlJlbPaDk72lct8
 zflGXqgV74PJIZsJHWjP6dUvDSUPWKbHOeKQmvfSvZtWu34A61Dy37jg8/Y+GCblHiS2
 kBvlwdkQKVbUeOYUsD62OEqNl7FZuBEyGy0C7iCE4fXNewiJc12u23vw+5r+5tb9uLCW
 VzPfJ6/Q4aSfmujqT9oz3IJiL5cpRmTh3L/OuCNyjG6SfMLai9+gu+keMvkNKG7eqcbj
 k/9Q==
X-Gm-Message-State: AOJu0YyOt+ck3aPnn21e8l0Dic1TZmdZF0ObNXvEZsOlIOFil79c3xlt
 9GS+zsso6XNyu97EsdytOODVnN/qB/i/0bQqPLlchdmiQqyZ0w3EKqZcog==
X-Google-Smtp-Source: AGHT+IHhrLPMEpT0ZOx5zD3TudQEgvLEZAA7T9PK+HuhZQgMbWRyOsqat26v8HNdlz4iEhJ0m+cCCw==
X-Received: by 2002:a17:902:f548:b0:1f6:8ae4:510d with SMTP id
 d9443c01a7336-1f68ae454d3mr4305475ad.39.1717413441131; 
 Mon, 03 Jun 2024 04:17:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 09/27] trans_privileged.c.inc: set (m|s)tval on ebreak
 breakpoint
Date: Mon,  3 Jun 2024 21:16:25 +1000
Message-ID: <20240603111643.258712-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Privileged spec section 4.1.9 mentions:

"When a trap is taken into S-mode, stval is written with
exception-specific information to assist software in handling the trap.
(...)

If stval is written with a nonzero value when a breakpoint,
address-misaligned, access-fault, or page-fault exception occurs on an
instruction fetch, load, or store, then stval will contain the faulting
virtual address."

A similar text is found for mtval in section 3.1.16.

Setting mtval/stval in this scenario is optional, but some softwares read
these regs when handling ebreaks.

Write 'badaddr' in all ebreak breakpoints to write the appropriate
'tval' during riscv_do_cpu_interrrupt().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240416230437.1869024-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_privileged.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 620ab54eb0..bc5263a4e0 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -62,6 +62,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
+                      offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
     }
     return true;
-- 
2.45.1


