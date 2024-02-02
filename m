Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F5EC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvMy-0008Mw-UI; Fri, 02 Feb 2024 10:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMx-0008Mh-76
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:19 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVvMt-0004W5-GH
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:22:17 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d71cb97937so20948815ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706887333; x=1707492133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxKoQ94zKlqMPCHHDl0lpsAYUVMqT6+u0BOsNpnJVKQ=;
 b=NrD/L9pLQlCfSKrmakZWkZ851jj4ACkHnLxH8Q6b9v5zvnFlKH2FtE6A8793FxsM91
 k45T7lpAoKTWeiOMXakqaDMZDjgh/f5QkXRpk6w64M4M3pW4jqNDFGa5gPm9Nfia7POJ
 ulVCFUHA5t/eBvZ9EyikMng+nBoxJpbqR0RuVHQdcBcHb+89psKooqgfHRgWPS3qVu0O
 48g7Hl4rKj7Q36DqKoqFGUZ3HZxejQExV0KndQkG/B/nQLpL5e1Fr5wO2S40vqDwfIOS
 sZLidxVxmwurEjD00aD8i5FnmNhnP2K0BSQQ6Vb7oPz6Bn4JEilyuFgY7ku7t2LvgVMs
 +meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706887333; x=1707492133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxKoQ94zKlqMPCHHDl0lpsAYUVMqT6+u0BOsNpnJVKQ=;
 b=JUh/N3Ar6daIHhD/qIMXRo3M/qmtk/db6eh3AnQfJIRpMgtB5u135V2iUSL8M6McDS
 RTsNzbKJIxJdoae2AfFD0Xi/vLQNSj5k6KVihkGftXVM+r/eC6UexP/Tnyz420W41iXR
 akuuKny7d+m//ZK2OwVCsFnguaAgULOpULLKtyPfp9ZtdTNU9Kll7UnrsKpHMjNU3wOd
 TiAviFJz/G08GKEjuWukVgru8OcZRI5wKLHGX7D15W9SiBJvL26ZXBpLxeGnbyM+OIwm
 uarXgsOwpluAep79cpZM1kpx5jZMMT6XuboVuYPcQpJSLZ9/ncwqohL7fJg42lCJ76xk
 E8AQ==
X-Gm-Message-State: AOJu0Yw1VMwXaNxC2djaOU23tvL9v2j1Aa9vxEdLdRLdvxI+ZuzZGAYK
 E6nnvNcKE023TrieC0u4BiyDGjEdPjscm4tNIl5AcArc+/us2uzzCBUFFItASRAme1xibzCTxAy
 e
X-Google-Smtp-Source: AGHT+IGeKfI3rE5yQ1xzei8JXqlGxs5Y2nUTMqBsYExa8HRDj551u6lvjbx+vpihFZxFbA118igXww==
X-Received: by 2002:a17:903:40cc:b0:1d9:8b7:52b3 with SMTP id
 t12-20020a17090340cc00b001d908b752b3mr10918984pld.10.1706887333225; 
 Fri, 02 Feb 2024 07:22:13 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXnqd7ivKG+QDlhPAE+WhPavl4RJWsgvEYzZlRzQf6YgetxkymCAjNbsCEXu+0x6Vd0SKzpvMH0VzuOWnhTN7OIgSylNMeyOr61r6QRf9JR0g1J/UeI+xXJwPbWbbrmik8bpkgV5+D54Nn0JY1DGjeExuLOUhDKiYCOcZrognVQSlx8BYMfMYqsn6OtL/2fdep6D8DffEnXIeKj0g3rlsNoRTQ9IE2XyOQUTZKuDxOOCSth1SgHhMOKUjv9zZRVeoG6rqHSbEAsBIcGQvnLtGVL8U4pDn499g==
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902f24300b001d714a1530bsm1734381plc.176.2024.02.02.07.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:22:12 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 4/6] target/riscv: Reset henvcfg to zero
Date: Fri,  2 Feb 2024 12:21:52 -0300
Message-ID: <20240202152154.773253-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152154.773253-1-dbarboza@ventanamicro.com>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Andrew Jones <ajones@ventanamicro.com>

The hypervisor should decide what it wants to enable. Zero all
configuration enable bits on reset.

Also, commit ed67d63798f2 ("target/riscv: Update CSR bits name for
svadu extension") missed one reference to 'hade'. Change it now.

Fixes: 0af3f115e68e ("target/riscv: Add *envcfg.HADE related check in address translation")
Fixes: ed67d63798f2 ("target/riscv: Update CSR bits name for svadu extension")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 3 +--
 target/riscv/csr.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 94843c4f6e..9045f87481 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -961,8 +961,7 @@ static void riscv_cpu_reset_hold(Object *obj)
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
                    (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
-    env->henvcfg = (cpu->cfg.ext_svpbmt ? HENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0);
+    env->henvcfg = 0;
 
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d9a010387f..93f7bc2cb4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2115,7 +2115,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
     /*
      * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
      * henvcfg.stce is read_only 0 when menvcfg.stce = 0
-     * henvcfg.hade is read_only 0 when menvcfg.hade = 0
+     * henvcfg.adue is read_only 0 when menvcfg.adue = 0
      */
     *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
                            env->menvcfg);
-- 
2.43.0


