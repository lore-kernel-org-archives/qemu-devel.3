Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D686C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 02:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6i4c-00019w-7z; Mon, 13 May 2024 22:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6i4a-00019Q-5Y; Mon, 13 May 2024 22:39:24 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6i4Y-0002ZD-L4; Mon, 13 May 2024 22:39:23 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ad8fb779d2so3592110a91.0; 
 Mon, 13 May 2024 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715654360; x=1716259160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K9LmETSBiCjuNp7Xbj3dHZPC3tRA6gbNmWQkPFxSajk=;
 b=YCR9dCBBP0RpQNyNYnVMalKa5JxguYMbSeZOxnzgysTPSl4GBUwKn1wR3yZ8gVfegX
 h7v/1ZnvqvBky0S3+R4VWvQAZ/wRLQrVlR0Rq3G+xZlvLMHKAI4dpvkXdg0IWRIu41hz
 VT3bqBJSGmCKBS9R5oIHzQWc2Eeu0vG1iyQp6sSvsXhCyUJbuw4wsTytZ11KGJybTwLp
 0IpNldSfBH0NbMmEvIsLix8uJzNKVtjEaOprIo8iLBgMAKrj5KrieBeIYllt9iJ/acJi
 95PAQpr3YSG2eEw0LuWXzqefNQwutxuqkYcG4+4w9EadCNDYba3jTDsBp/rFfCtuUWeM
 g04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715654360; x=1716259160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9LmETSBiCjuNp7Xbj3dHZPC3tRA6gbNmWQkPFxSajk=;
 b=wN9+KGfrlT+0dwHZXn5smayAoHZAsmQccREaCdHJ4gT34ERqLY5AT4KLxI4H4AFb+D
 p+svbZeXee6RVgILCrKNqVXjtLfVCRhQSbCFedchrI3zCqB4JngTo/1UoGIdSjQo9g0d
 NdjRU+8aYZFWnJAuFblKIYiyq1Jg+lvgVBzb17cvvi5Vmm0ROWkvOmGLIh5VoMmd6swE
 GstOGGgzhd4XpFUokjaVPlBU8SznT3TkH0uNkqKJRE7xcDISIMg6lmmtfEuLMfUoeQhQ
 piN9jc1sZnF5jatg+o7wp6x2X5Mtg7QTWUxCcYPsJklHy3FXA3i3KJL5mUmHIYNA/1Bv
 c7Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc9UeMLCkEoICEVCBfurfXtuYGLdjMGM5MIRU9uSjE6Eq/jcizjzj/f6KNPZ73PUWgFk5BTT23qm92rvSfXxhyqfRNBf8=
X-Gm-Message-State: AOJu0YwHOhSyjc+zna1RpTKxGs5VmH0a9vtZnROXaB7vzWAv0bW9pIB6
 l0RAb40G9c3BqQXzc17ehpRWQuJb7qb4LE/W4L/3K7bx+fsSoQp0+aFitJ0Y
X-Google-Smtp-Source: AGHT+IFUqpo8Q4VqeP3q+z/gRbcNaW91aFJ9SQdaf4VjDU1vokWdAytyQ/zEI4HyokbqRGDVZxKPCQ==
X-Received: by 2002:a17:90b:19d4:b0:2a6:1625:368c with SMTP id
 98e67ed59e1d1-2b6cc03f971mr9373596a91.6.1715654360501; 
 Mon, 13 May 2024 19:39:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6ab8sm10476083a91.55.2024.05.13.19.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 19:39:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-riscv@nongnu.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@dabbelt.com, bin.meng@windriver.com, dbarboza@ventanamicro.com,
 qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 fabian.thomas@cispa.de, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] target/riscv: rvzicbo: Fixup CBO extension register
 calculation
Date: Tue, 14 May 2024 12:39:10 +1000
Message-ID: <20240514023910.301766-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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
2.45.0


