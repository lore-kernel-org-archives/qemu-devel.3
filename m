Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D7CCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNQ-0001jD-C1; Thu, 21 May 2026 20:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNL-0001fb-V0
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:27 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNK-0003O8-9J
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:27 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c7980c060cfso2995649a12.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408264; x=1780013064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AsLKIKSjxv8nk05Qhrn0NmtTJ8lIc/gH0gx8e16TAU=;
 b=T0DZ1U4QmJRz75hIYZPI+/Y5ovqLqwiSOv2nRZJW42D+Ejs9I6xvOnq5ktEmygl4f0
 vgrvq4U0oVTK4zfGH4cu9GZEyvOh7/Uhw4rFJQoHMuxU52dy0VNY3do6nCASRD1of2rp
 EOY8WxuczZf1yykL/nxB3VO+7MsiI3HrU7S2LP0zlfohTRmXlJRPDESymPtx8G270RIg
 CxqWZg4/7vkqnn5Kznu5YhqmbVUM17R3u7+r83DeBADG5luAALhtUDgS/a0lnqfev4qB
 X82FIU13piYQfdVbPgjgpROcGYkHA9wUwnJpUeVIkTRFNz+fBXYA0RjWmGQQhLPfcn+8
 tYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408264; x=1780013064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+AsLKIKSjxv8nk05Qhrn0NmtTJ8lIc/gH0gx8e16TAU=;
 b=KzyXHuakSGsPC/6PjwBDRbmdSqbVzHckqBY2NxmB6ixY/nqKRHAQTcZmW0XeRhKLUG
 KmcqUi7yKAoka8r+M3rYPnZU9i22+vqbPC0zZm+S90g9uWBnl4kjUMT9sDGcvONy6SaO
 Ob2TX0I6VbWoBHQ/MV5tk+lJSzPstXS9tDmRccXm56+MUuIaklrtlagKnExJmul+X1zw
 UGbHYsfjwVnJTy/X5MyD2Y6OkpgxLDb4cY8zmMNtGmOL0vmdEr6jUAUqjdLMdBEjKZQ0
 Mwuk7nkm/I8ivcOWm1gqFrFze/NhWPiUAR1Ew2ME3ric6PR8dzz6vpjKw+L2d1S4uP8b
 F7IQ==
X-Gm-Message-State: AOJu0YzMmKpuPFfzCHZRyZS4WF9lN8tmwj84p7jqSn54mRa6d1RwaAaS
 AIBYGUHae5QDLTTxyfHd+B6bLftoA+vBP+/FWFneHQup/H9Uqf1rnXGy3gQu9X3C
X-Gm-Gg: Acq92OGxYA8i0F7J+n2yB0iljXh0yghlrtzLqsbYvEZYc5Mkvh6J1oQ/2D2iJ8gWh0G
 rDaNM65BnMpIBAZMIoFasJAx4ZCeQ9PuqfkzoXw+hpOATFDKRbACAulSjSwmdvoUcPqtIRx/287
 HSB9Ngoh4+qHdptuanIXVshwySEY7qEqE1MjQO4/65Tz+gyjSSv30mTiz19/CmIokqjmzrYHJUk
 onj4D6MRlagr443abtZK/5PWvAT33aNc2nDzH/qDaUq7LQ8rxg+OaerdeLOuT6NiRYJh7lb2O+i
 tplbXhVcKIbCb09Rg76aJIp+ACme7/KNsKVSzox6c7wmxXeHN2Z+Z5AMw94YSCBkqA5ryj9fNwO
 DbeyGYRpD0WFD+PJHsU6TyIHkNa00pRJlVi/CjMG8F6WgeckwPjgDKas24ZdGK0M2giCh/b36WS
 xEJd3WtUPcLgAc2YG2pZoI+9sn7TRowznJAIJOp2k/Qg==
X-Received: by 2002:a17:903:2290:b0:2bd:5a99:f293 with SMTP id
 d9443c01a7336-2beb0631928mr11253885ad.21.1779408264213; 
 Thu, 21 May 2026 17:04:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/48] target/riscv: Remove unconditional MENVCFG_CDE from mask
Date: Fri, 22 May 2026 10:02:51 +1000
Message-ID: <20260522000324.23255-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Zishun Yi <vulab@iscas.ac.cn>

Currently, the MENVCFG_CDE (Counter Delegation Enable) bit is
unconditionally included in the base write mask for CSR_MENVCFG.
This make the subsequent conditional check
`(cfg->ext_smcdeleg ? MENVCFG_CDE : 0)` completely ineffective,
as a bitwise OR cannot clear a bit that is already set.

Fix this by removing MENVCFG_CDE from the initial base mask. The bit
will now only be writable when explicitly granted by the `ext_smcdeleg`
configuration.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2601/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260511040534.2862443-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 60ac307012..e041f5c16e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3177,7 +3177,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
-                    MENVCFG_CBZE | MENVCFG_CDE;
+                    MENVCFG_CBZE;
     bool stce_changed = false;
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
-- 
2.53.0


