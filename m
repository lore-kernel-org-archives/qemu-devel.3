Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C53AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmqf-0006oG-3F; Mon, 27 May 2024 22:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmq2-0005kM-F3; Mon, 27 May 2024 22:45:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpz-00042d-Gx; Mon, 27 May 2024 22:45:21 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f47eb2354bso2405445ad.3; 
 Mon, 27 May 2024 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864318; x=1717469118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tj+xbQPw1aTPPkVQS9cYzQUJajn8RHcrOCksv3MTYMs=;
 b=KOehGwjsf+U6bOgzN/xi10jTGikrVJjM8QOmVhybPN0l7ad5/LHR83pSxHZZVkXvcy
 yBfoZyKKjhplIQD95bjEnIGXlMYQHTJIKHgCH6kwAu24n+VjXaVLYHMweehyroq4+bNy
 A7abHRbx7PrYYbQuptuQZqdZUfZYfSfQetmBUblkhCILRVMGzUnqB3urm8VWnio/GuWn
 SFtfcYJ8ZZ+WJYdo3oJTsAP7tsPPlaU8u8q+DOxLi5DRA8H2K1kCkH3Hd3JAlP7RfYMu
 n+Em2pVHVkz3RNpYdZepDREj76/gbsEUgFSVr8nIapsZ8JkSAOr0fNczrY4SCpiURm0k
 mYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864318; x=1717469118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tj+xbQPw1aTPPkVQS9cYzQUJajn8RHcrOCksv3MTYMs=;
 b=uTOh3bTvx32WjKT/di+U9fTmAL6N6gYEHwwwWLQ6ir656QJ0s53GP8iIcvP/lBJFPV
 zRt2gH9wzBrNqa6MdCzgDd971U2jtgDlxAi8uTwVEBlpBjlHz5x/JuJ/9r1aUaz1SO0l
 LmbwR4vtHfDlh7451OcficGxKL1pJ1YRGYFFHO92Ns5UTLPh/GgcR2ef3G3HMhJlab1G
 eBQidrB3DU5dmDIPg+tyweMpUMYg39wvI4TSfbn/eUBEiIEa0O6GYV/wud/OFL4eoR8d
 axfjtEdUFfFg51GxeXIfqSSQBy6qmghdTHqW6clAOEcQ1zS0HDSFynAazOzoOtoTQaoe
 9+Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUScBgwyIqayrMqkgQdec6jEvCYvwuTGiWfyd1vHN07u1mtXjHo8RZ38YZRv47t4kk2XDj0I8srbyjzY5JspofGHo30CHVx
X-Gm-Message-State: AOJu0YycOZ4Ji9HpHeBGWAJbowgbtqolUn2OqQLLEQK+5ZcXOub1Qnq9
 LhimqcGHsMZ3I3evEbtnpE/dkVrGl4ex1OKnLUZR57sTHm1Wpr9qcx0Cvg==
X-Google-Smtp-Source: AGHT+IHNY3mxTsO4GD2NNhPfEfODwh8OY9wim5AAeReOnQOeVOX+bhORTPA04dSr7Ub7EGIto9QyOw==
X-Received: by 2002:a17:903:184:b0:1f4:bcef:e962 with SMTP id
 d9443c01a7336-1f4bceff50cmr23240845ad.52.1716864317698; 
 Mon, 27 May 2024 19:45:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Fabian Thomas <fabian.thomas@cispa.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 24/28] target/riscv: rvzicbo: Fixup CBO extension register
 calculation
Date: Tue, 28 May 2024 12:43:24 +1000
Message-ID: <20240528024328.246965-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Alistair Francis <alistair23@gmail.com>

When running the instruction

```
    cbo.flush 0(x0)
```

QEMU would segfault.

The issue was in cpu_gpr[a->rs1] as QEMU does not have cpu_gpr[0]
allocated.

In order to fix this let's use the existing get_address()
helper. This also has the benefit of performing pointer mask
calculations on the address specified in rs1.

The pointer masking specificiation specifically states:

"""
Cache Management Operations: All instructions in Zicbom, Zicbop and Zicboz
"""

So this is the correct behaviour and we previously have been incorrectly
not masking the address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reported-by: Fabian Thomas <fabian.thomas@cispa.de>
Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240514023910.301766-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzicbo.c.inc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index d5d7095903..15711c3140 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -31,27 +31,35 @@
 static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_inval(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
 {
     REQUIRE_ZICBOZ(ctx);
-    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_zero(tcg_env, src);
     return true;
 }
-- 
2.45.1


