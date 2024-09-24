Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3761DCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDtq-0000Mp-O3; Tue, 24 Sep 2024 18:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtj-0007oX-2R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtg-00020n-EL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:42 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-717934728adso4303375b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216439; x=1727821239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULSbBVgDAnxHpGCtUqBccyKl0y/ZVggCsXBfVU6jhrA=;
 b=gRLAshr9zcwhaE+5QYhEUUo4Uk+ggZEGpG4I+TpWVLBLyp7ZR7MYnnMpDd7DdiVYy9
 d2aNaTEbgesaowIVta/6vCsE0ec/mM04//xu0JWbbltUwHzADsJ5qD1CdyLLTKhLyl13
 Sx4hjOqrPNne4JFypThhfEx6vVpJ2Ayv4ru2lHGSBLQhPe8Xsj5T9mliAJ1K8BG+X4Lb
 DL+ntnrSs/56T6NhTBAua3eJJVQsm30s4HGaZod3/TRqrQLHalx3Nk+VN/Y7OSg9SJbJ
 /MCUfK3+z46Tpa9A0SRVndPIEKvCOv7GZcq8yJ8BjaX79lRYHd0Eec5rknynUrymmOoX
 f+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216439; x=1727821239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULSbBVgDAnxHpGCtUqBccyKl0y/ZVggCsXBfVU6jhrA=;
 b=hmxnT0WlXZ4XnDUiFTZIjE2vz+6p0fueJ6pYbeUfieYNM8aBN08PmCINH8x9TB0jjH
 4PVWlmdqOiFDTQYulJzMGRmLfmu8BG3aMiBn0fF/nhEH3nCcxAKMVjIAWClvlIm/g44+
 vwPCm8VBG/Vxw4XCA9oDaUsRkEjFIU6GTV9clMC39iHFgVtIiB9CcUE8rniEFA54uv6T
 BZ6P3zWpVfNE5wfCud0igRIhW0zFrhZ5DnUp+9ZlzD732olE/Zqzmfzcp+9FL77pRYV3
 njh3xgGPdasLZql2XSG3fUCb5tb8G8xea1TNlLPvGmIZiG27BQkyy3eVvT4hjFowesPg
 flnw==
X-Gm-Message-State: AOJu0Yw0DyYClqSSrrW6tQEN9/JBfBLQb9gvTGUzmcLtQea5r1S/fGYt
 W6NDQryesj1Xg05x88ncqGH9KvQEpp4I6Y1RjYdxOySM8SSKC5SMGpLLqQ==
X-Google-Smtp-Source: AGHT+IFS0qQ1B9UPpo1yM1ck6pHoMnK7kDzGHbyCCMYImz5ilX7x4yM7OO92usUZA0NowIdritbBHw==
X-Received: by 2002:a05:6a21:1707:b0:1d3:2759:bf97 with SMTP id
 adf61e73a8af0-1d4d4b9bb6fmr931338637.35.1727216438636; 
 Tue, 24 Sep 2024 15:20:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:20:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 46/47] bsd-user: Implement set_mcontext and
 get_ucontext_sigreturn for RISCV
Date: Wed, 25 Sep 2024 08:17:47 +1000
Message-ID: <20240924221751.2688389-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Added implementations for 'set_mcontext' and 'get_ucontext_sigreturn'
functions for RISC-V architecture,
Both functions ensure that the CPU state and user context are properly
managed.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-17-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/signal.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
index 072ad821d2..10c940cd49 100644
--- a/bsd-user/riscv/signal.c
+++ b/bsd-user/riscv/signal.c
@@ -114,3 +114,57 @@ abi_long get_mcontext(CPURISCVState *regs, target_mcontext_t *mcp,
 
     return 0;
 }
+
+/* Compare with set_mcontext() in riscv/riscv/exec_machdep.c */
+abi_long set_mcontext(CPURISCVState *regs, target_mcontext_t *mcp,
+        int srflag)
+{
+
+    regs->gpr[5] = tswap64(mcp->mc_gpregs.gp_t[0]);
+    regs->gpr[6] = tswap64(mcp->mc_gpregs.gp_t[1]);
+    regs->gpr[7] = tswap64(mcp->mc_gpregs.gp_t[2]);
+    regs->gpr[28] = tswap64(mcp->mc_gpregs.gp_t[3]);
+    regs->gpr[29] = tswap64(mcp->mc_gpregs.gp_t[4]);
+    regs->gpr[30] = tswap64(mcp->mc_gpregs.gp_t[5]);
+    regs->gpr[31] = tswap64(mcp->mc_gpregs.gp_t[6]);
+
+    regs->gpr[8] = tswap64(mcp->mc_gpregs.gp_s[0]);
+    regs->gpr[9] = tswap64(mcp->mc_gpregs.gp_s[1]);
+    regs->gpr[18] = tswap64(mcp->mc_gpregs.gp_s[2]);
+    regs->gpr[19] = tswap64(mcp->mc_gpregs.gp_s[3]);
+    regs->gpr[20] = tswap64(mcp->mc_gpregs.gp_s[4]);
+    regs->gpr[21] = tswap64(mcp->mc_gpregs.gp_s[5]);
+    regs->gpr[22] = tswap64(mcp->mc_gpregs.gp_s[6]);
+    regs->gpr[23] = tswap64(mcp->mc_gpregs.gp_s[7]);
+    regs->gpr[24] = tswap64(mcp->mc_gpregs.gp_s[8]);
+    regs->gpr[25] = tswap64(mcp->mc_gpregs.gp_s[9]);
+    regs->gpr[26] = tswap64(mcp->mc_gpregs.gp_s[10]);
+    regs->gpr[27] = tswap64(mcp->mc_gpregs.gp_s[11]);
+
+    regs->gpr[10] = tswap64(mcp->mc_gpregs.gp_a[0]);
+    regs->gpr[11] = tswap64(mcp->mc_gpregs.gp_a[1]);
+    regs->gpr[12] = tswap64(mcp->mc_gpregs.gp_a[2]);
+    regs->gpr[13] = tswap64(mcp->mc_gpregs.gp_a[3]);
+    regs->gpr[14] = tswap64(mcp->mc_gpregs.gp_a[4]);
+    regs->gpr[15] = tswap64(mcp->mc_gpregs.gp_a[5]);
+    regs->gpr[16] = tswap64(mcp->mc_gpregs.gp_a[6]);
+    regs->gpr[17] = tswap64(mcp->mc_gpregs.gp_a[7]);
+
+
+    regs->gpr[1] = tswap64(mcp->mc_gpregs.gp_ra);
+    regs->gpr[2] = tswap64(mcp->mc_gpregs.gp_sp);
+    regs->gpr[3] = tswap64(mcp->mc_gpregs.gp_gp);
+    regs->gpr[4] = tswap64(mcp->mc_gpregs.gp_tp);
+    regs->pc = tswap64(mcp->mc_gpregs.gp_sepc);
+
+    return 0;
+}
+
+/* Compare with sys_sigreturn() in riscv/riscv/machdep.c */
+abi_long get_ucontext_sigreturn(CPURISCVState *regs,
+                        abi_ulong target_sf, abi_ulong *target_uc)
+{
+
+    *target_uc = target_sf;
+    return 0;
+}
-- 
2.46.1


