Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3284BCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDN0-0001XP-FD; Thu, 21 May 2026 20:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMy-0001X5-DA
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMw-0003HB-AL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2bd80b3aa13so43713095ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408241; x=1780013041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwTQ3UjJgnhZeMCZxzlg6974M/fv9yFfvT11+V0MwTY=;
 b=gPE8rdI/Jze0MRJfEKW0zcyQU9knRdNqaxPpzW872pEgclFkTN8vsrq4geGCzRUASY
 whAha81DJ74GJx6y/+ihy1WOCX4aK+wRwnap6huDEP1i0YV1nRxmZrxkgjHVaPeteQdD
 FsRD9LYvPJkRHDXd+QqzGgexXt302PAWwQk5wm2A+Y2Qvsj7IZnYnW4XG1uHBsXKxCJj
 e/dmjZjdUDYTGIxp9c+IFNXj0GoGJOfwyMuts/m60rGon52YL+pU6+6uGYBsmqMIY7Kq
 PaO6+N2chZv8a9fa4cu8SqdtGK0IGDBinjxTmkIQg1Kd39Efuv5by57jhaulHHPuOeoc
 bvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408241; x=1780013041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZwTQ3UjJgnhZeMCZxzlg6974M/fv9yFfvT11+V0MwTY=;
 b=fZIV8qfcPoEAj9g6qCOE8vyEwybFmxdy8xUnC1M3AyMoOuW7/iQ3eEnwaNGR40aa9/
 apprZEGnEHaSRcH5HGef8q2Lc9MpodXGngaPtP/2qQFjEgAyCaWnXaLCx1c0w6wSZK71
 PRu3ynBHC0Jrtml83EGaefh5b0S7fD4+X68n3Hq/vzH92EANK0wvYAgyXASSAwR2dSKk
 smYf5C+U2I3V2pfN+gZMS5Dq0eviZYK428BkmevKsiAI7pYaeg7IZGvFC2lGNr9EjQ4v
 n/EuKUo7wLSSyI6LwyLst0XxQXUFtrl9d7uFpUEebOpqNX+lSbL+5hDdcl8eIGZ+afzD
 Cgmw==
X-Gm-Message-State: AOJu0YxrudNr+/m5I344Nbqr36PV3hLgMY/c+18rIR9Ns/SbLuXOSGfE
 Pi628rOiTo0ZNvjm4MYaPuc35OnAvIDJLr6qpLeAQc2wSTEm/4rTtyIak1ZtEqhq
X-Gm-Gg: Acq92OEZmXyY9T5BHfB563Korg8gRk6kpSOwbu3g3/5Luuj27W3rS8vYtToYgr6t9d/
 uGOPE3us1wKy1AQwnflge/KPEigamB3LjpJaSDVEh37N7Eld0iP5mRug5hx+2emsFFEvRO2vcNn
 zSogBCDsHMR+SKli1zpcTMEzzWOWXrBFwuKbsPMUAicKKyHAEtp915vIPQhC0JukaMZeTP1uzfp
 239qdbgsrlxW0lOV9tkxgdYqoFdXQG/o43SokwYBJxAxj/MgnQ801197i/kXq/gHircCeevcFDw
 Xqp4Hxf9lwH0poDkBURnehPv2CoSUQ0io9yqIf+3xLLfUYRtsxog1SDDULya4Bwl/k7HTrZIddt
 jynbDdgIr3VS7m44/d9M9OrZkTUT8zSSB4u3ZihrMwQQ692yCa6xrZTnEl4rO700vK2K8wgjUTj
 oU2NWF6bvNuWaELns8SjSruTcxHIzdw4jGGjXUpcy/VqY301mYuYv4
X-Received: by 2002:a17:903:1b10:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2beb058078cmr9980315ad.0.1779408240931; 
 Thu, 21 May 2026 17:04:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/48] target/riscv: Allow mseccfg access based on ext_zicfilp
Date: Fri, 22 May 2026 10:02:44 +1000
Message-ID: <20260522000324.23255-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

The Zicfilp extension adds the MLPE field to the mseccfg CSR. According
to the RISC-V Privileged Specification, mseccfg exists if any extension
that adds a field to it is implemented.

Currently, the `have_mseccfg()` predicate function checks for Smepmp,
Zkr, and Smmpm, but misses Zicfilp. As a result, if a CPU is configured
with `zicfilp=true` but without the other extensions, accessing the
mseccfg CSR will incorrectly raise an illegal instruction exception.

This patch adds the missing check for `ext_zicfilp` to ensure the CSR
is properly accessible when the Zicfilp extension is enabled.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2561/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260511072705.3015986-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da366cf562..e1cd4a299c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -783,6 +783,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     if (riscv_cpu_cfg(env)->ext_smmpm) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_zicfilp) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
-- 
2.53.0


