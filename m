Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E121C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYl-0001SN-IM; Mon, 24 Aug 2026 01:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYR-0001Km-C9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:08 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYP-0001qp-0l
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:07 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so2357574a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550543; x=1788155343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=InDjCg2L0Bovh8ca/Rz0G2mpdBtxcIk8gJadCrq3EA0=;
 b=JOPi3gu38waoWiy9rZF+qNydIFpT4dsEVNK64qyDqrtxYfxhFssGK2bxWS1Y1IOZQ1
 qorraKoOmDFIJ4ukDmM+yj/5g8/wA6sjF/mOb7m6D3r3rq3LjVsUgB5Vj/OuoRypk5bI
 JyS0y93mgKN99UOcwgGmCUCfEP1FgPKqQp1LkMy3wAX6SZgufzpm71n1zT6jSsNPoX0H
 x4QPcr/qUAwIY8pBJumxX5frPwSfHWct2jjUmg8R5zEeeycM9uVT/uZk10/FwT/DtBwr
 FppeXc4jrE0jQkzihWLADXvuR9Yqb5JyXqwp6FWeO16KLbcUdik+RGAV6fo+isjC2BJs
 KcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550543; x=1788155343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=InDjCg2L0Bovh8ca/Rz0G2mpdBtxcIk8gJadCrq3EA0=;
 b=IBGLT7PwjSXVJKmb7bJdxYeUsx1UD1qyly9WCtOPNJipwduUKiZ/qG2OSryn7Jra2e
 w9lBbd3G8GCCZoRsCW1yj8+i71EsGso9WHL6rJPk2vK0/7kyeRAWhgWcYLoPOMN2rMa6
 WDYVKEibkkG3SkNYIt4pX64tLeLavT8zVwUcixBm4D33+T4gc5f0bMKmTOYiXyZJHe0l
 TbhwrgG7rm5jGTx0fZxcuxkHy/5N6J3TOX9A9uXxlITUhB/Ocuxjg2kRnS9g0wbRKdEu
 SXH2FJfrUh5nMQXJfbgxTx/4FqNuqpiVh0XWEL99bJ1fHXYWElDpZPpiViqAHhHhCzxx
 4PMw==
X-Gm-Message-State: AFuF++lGRopZ5s7NK3UwiBwAchXPA9WvH9Lc+hXKDnBC5ZCyUF1h5t3m
 tpfTilJ2UF+3OABffv8Cyfp3Bf3FGHgB65asfh2svzDQLpL7Rayo8FOnKwQbJA==
X-Gm-Gg: AR+sD10q+LxHaMuCoFh+5n61t2TyAoNHEbGTWlArDMWYwO2QlUrXOqrd/MibPOC9x4/
 z3KvfQrZX6/tPpXzThge1DkYDkz39ZqyYuWhDOlzAxpSo0yv5JF6l/TWz184cZ8mGXtD/07wrte
 hPMV8dwfAZDPfku0D24NmJSqL6sbxqaKjo8c2rSvAIp9fhd9ex5rqHT85iwxWFssb3TzQwl85Yu
 Js0n/xwqF1KWJT6kS2IpwP/8t6NAtWfzq2CZ6h+KzDhHLm4h8uVp2B0+6k2t8BIYZnMCUVdCLU5
 jRL+QhjObqRS5/zqgngywnRTBvpGarz/dH40ZEu9AaQSAhtRV4Yc6TMvkgHmqupJ48VAVjaf3+l
 wPPzFyltuILNyTmwuUzJRktKX5bBugYQELUJ5zJg1yhWbV1fWntZvE4AUrrqG+7o+UlihGDfD97
 fEcoBHqc2sMt/aEWrjDS5h+5/f2OxJxrKs5C4GoDx/MS0Pa+Wz8bZysKnoK/YMv1Lxd4CfxEDIV
 g9Cg4v9D6zeqzdR
X-Received: by 2002:a17:90b:5805:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-395c3a514a5mr43599685a91.15.1787550543555; 
 Sun, 23 Aug 2026 22:49:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Abhigyan Kumar <314abh@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 14/96] target/riscv: use SXL instead of MXL for read_sstatus
Date: Mon, 24 Aug 2026 15:46:44 +1000
Message-ID: <20260824054806.2790041-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Abhigyan Kumar <314abh@gmail.com>

According to the RISC-V spec, a 64-bit system can have M-mode in 64-bit
with S-mode being 32-bit (SXL bits or mstatus[35:34] being 1). In this
case, read_sstatus should use SXL.

QEMU doesn't allow changing the SXL bits in mstatus in M-mode. This was
because of the missing MSTATUS64_SXL mask in write_mstatus. Now, both
the SXL field in mstatus can be safely modified in M-mode and
read_sstatus correctly uses SXL not MXL.

Fixes: b550f89457 ("target/riscv: Compute mstatus.sd on demand")
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260723142254.1683113-1-314abh@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36f2004bc5..a90449b87f 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2067,6 +2067,11 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
+        if ((val & MSTATUS64_SXL) != 0) {
+            mask |= MSTATUS64_SXL;
+            val = riscv_write_uxl(env, val, MSTATUS64_SXL);
+        }
+
         if ((val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
             val = riscv_write_uxl(env, val, MSTATUS64_UXL);
@@ -4014,8 +4019,8 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mask |= SSTATUS_SDT;
     }
-    /* TODO: Use SXL not MXL. */
-    *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
+
+    *val = add_status_sd(riscv_cpu_sxl(env), env->mstatus & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.54.0


