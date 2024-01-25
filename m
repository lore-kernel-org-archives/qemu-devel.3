Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5A9C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5nD-0004dr-Kr; Thu, 25 Jan 2024 14:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5nB-0004cw-BR
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:41 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rT5n9-0001Zv-PM
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:53:41 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-290b37bb7deso3520833a91.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706212418; x=1706817218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQBov+3obq4yDLy1SQOmpy/NkorWmiTmSoDtME+DQ+c=;
 b=fDFA51HzADNXQ9Lrp0Q7A3H9An0r8Qtl66oT54rMLeUZ6BVfXH49mvt3MbdWgOb3kV
 OQfnaXDTsVx/qzB5CaCY1mCz1LPwhLiboYbDO3+tvu/VVJj8hdXzGRifSLpg1opupW2/
 Uv7hFzCSB4MYn9v64aPVLV6bh3K99Kqm74qZKoYLo3qrQyKSWtoW/5P9jkHUZ8Xh5Akq
 R0MRFi/+N4gLzdcq1GKBS7OjBt7Sx4vgW0uZAl3sifsf20p52NwlzOrPD5HDTA5E2P95
 A9veB3AODPIbuuLBePFrHTe/kEuS6bAAbDCRQrBlAAx2UlwqO7BqYVEbKYlnNT89WiDd
 calQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706212418; x=1706817218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQBov+3obq4yDLy1SQOmpy/NkorWmiTmSoDtME+DQ+c=;
 b=GuQ7sUKP/C0kHmsQvkNM+q1b+kbRaNukC4Te6/nntnqvH2xvYCZosVZtHDhL+tCIsK
 Gmlp0nZk22WSiG7hO5VTd+7tTHiGx6t/C1R893W15HZctdVorDpTqmrIELudJ1qeArVR
 3AJE+aC3uJ9meOu+4b/49Q+xnI/QNKbB8NVGvjspzamSrN73UZgjvD9kSRgTDBWGqCqm
 ktU0d0ib9uOy/Q/1z0ewQZLOGboWDq6jGDQfjreCAVtRhKlsiy+swgbVvuV4FZaGNRcA
 nJSTN3gqA+ZnF4446Z+mB29mt+z1p8Eiz2VnXZ6Ce3/TY6NS1LsWtE7FDofdEWyuTQkX
 frfg==
X-Gm-Message-State: AOJu0YzFZZyqObsr7y955ffXV7GTlIQap++4l2zcr++QdPfD3d6osvFH
 tbRZi2Lnbv7tuy5Ux/MZSe6s0gclj1xbmpwjgofbvCXgQ20ijjJv68U7lA7/KTDnI+WXi/LeR/m
 t
X-Google-Smtp-Source: AGHT+IGi7LQEjLFm0wH4Z6JEEQ7kCOFsdn3zXsSyAVfed37sCRo2kviAd8WlKr2Eu212IMUi/uxjrw==
X-Received: by 2002:a17:90a:e551:b0:28c:bb6d:4d16 with SMTP id
 ei17-20020a17090ae55100b0028cbb6d4d16mr134807pjb.31.1706212417953; 
 Thu, 25 Jan 2024 11:53:37 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a17090ad40700b0028b6759d8c1sm1958613pju.29.2024.01.25.11.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 11:53:37 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/6] target/riscv: Reset henvcfg to zero
Date: Thu, 25 Jan 2024 16:53:17 -0300
Message-ID: <20240125195319.329181-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125195319.329181-1-dbarboza@ventanamicro.com>
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 3 +--
 target/riscv/csr.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1ecd8a57ed..7fd433daee 100644
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


