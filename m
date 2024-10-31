Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307E5E68949
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFa-0007Cz-Js; Wed, 30 Oct 2024 23:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFY-0007CT-VC
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFX-0003sN-Ee
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20e576dbc42so5428675ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346810; x=1730951610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Yu9l8eltS3GqEhoKZQqPKNc4z7ST450TJjjoaz/+KI=;
 b=iS5TvKBsOhi9zWeB0u+3ytwXryYYstuvzyXuFNHkMr+nLo94EA06tQhbjUrLiCl/CX
 wf3DPyafoUHLCoRFqlrj+4lllgV7I+/OKUdRsLL8xHf8QrOd0MTpU47tIy9GIBaB0iq1
 iCZmORX4s4dRtWF66FUZpeNGFZ9HxVuR+o+qu8nSQLXIrO/r8nifsM4uf58anG4m2DAN
 umUY4BqmQvpbdDG7p2Un8axytBimE16DorfvB9aj1jGjInpoHd762QDTdathD0ls7wvp
 /Uwo4edvS/qsGDG3noBLkC/w+CQvpTrEKta7I2gubXg8z+HUFZIviaOnknGVFyWfC85Z
 ikQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346810; x=1730951610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Yu9l8eltS3GqEhoKZQqPKNc4z7ST450TJjjoaz/+KI=;
 b=R/h+E3fTKgfzeRfvJ3+YuKwELVN+7t7tZnRZ/B9hLct4RwbxFzLDjza6NwVLmPrgmj
 b9TfXKG0tviSqWxhzDfCS9TYwQ/2yOrDOjC4/Q0Yyt1uA7ngxGnEyn9z8UJjg62N6lsJ
 4hS/517+4rVOBU/tpp4O93WTG5YrKn+4RBcVFD05r3MvpnZYa9dD3o4YkP7vlRB0greL
 zREJ3ENHQkvypwYj7d2L8MLersUv+6Koabr5SHvbh6WmNjVx/nhFWN8NnfxXD+dbaZDd
 G6fudePf5tXBjJE/LSpz4oiRLV06ANEWmIZ0MBlbKLrwrRzhshI2p+mk1tMWqd2Q7trE
 Rghw==
X-Gm-Message-State: AOJu0Yzc/J+JU+z77PxzZzBBrNzNri6sU8vyq9jy8u/Xbm0dXsD6rISU
 2sMbZmsDGQ1chuMLXF12EgBk6q3Sjk8Lxl7OB9G/15R77djFxafRh7XC/p08
X-Google-Smtp-Source: AGHT+IFFB9xchlzOCWRmRZ2W5AiaX/XDaU6oladBNFYEAsroF6ZGljbN8tZ0bPoAIJGoQmJsYJComQ==
X-Received: by 2002:a17:902:c943:b0:20c:d072:c89a with SMTP id
 d9443c01a7336-21103ccbe1dmr20630715ad.59.1730346809712; 
 Wed, 30 Oct 2024 20:53:29 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/50] target/riscv/csr.c: Fix an access to VXSAT
Date: Thu, 31 Oct 2024 13:52:29 +1000
Message-ID: <20241031035319.731906-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>

The register VXSAT should be RW only to the first bit.
The remaining bits should be 0.

The RISC-V Instruction Set Manual Volume I: Unprivileged Architecture

The vxsat CSR has a single read-write least-significant bit (vxsat[0])
that indicates if a fixed-point instruction has had to saturate an output
value to fit into a destination format. Bits vxsat[XLEN-1:1]
should be written as zeros.

Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241002084436.89347-1-evgenii.prokopiev@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea3560342c..c88ee1265e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -734,7 +734,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
 static RISCVException read_vxsat(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
-    *val = env->vxsat;
+    *val = env->vxsat & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
@@ -744,7 +744,7 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
 #endif
-    env->vxsat = val;
+    env->vxsat = val & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.47.0


