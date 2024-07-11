Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65804C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KN-0000vK-Of; Thu, 11 Jul 2024 18:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KL-0000ns-Rl
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KI-0001e1-3U
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:48 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fb4a807708so13275455ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737105; x=1721341905;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ppUbuQ8Wa7YiIwlG2SqWh54KeHcuFzLEgO4lTPZv86E=;
 b=0zmcfBZBqXabwEL2qx4VUb7LX5t9wjq/n6zeDP1AkPxmRqxoctsXxMnAto+R2mMBwl
 WZ+F/Rzet4vS1Pn3NfFyClRLI5d9YeBSDK+JmOneK7VHHNpjozjzUgSj0w5Y0DmN4eEx
 /J77lhdFAwKUNacVx3JqeaYsEhxkh0WA1koV+QF+O1QzKoY/e4NiIOpxVfa8lgXRZuIe
 /DOiGcw48KqH5WPnt2nMZ3nPX5q+yM59OFmE+XEEL+bfQdxrcNAB6X6XsbqJeNvWjOLn
 GEawKf+ulnZvCnCvOiJ/m3ffnumOLvPQfQoFA9oPoLWYelrdLRsDQkh/54HLM1aEFwnE
 bOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737105; x=1721341905;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppUbuQ8Wa7YiIwlG2SqWh54KeHcuFzLEgO4lTPZv86E=;
 b=ub/YwtLXF/uf6P6RR9oD7O+uFfzuKpjyW74PqDrwcPUA8EBPAMq1JdIN9TE2lELAOu
 8xQGNHWK0SCIqmeX/YFnNE5t/7L39umap2dUvqpYwNjr+REn/u0Sl4Aggp9796UR++dL
 84uiUGa7tUKfCXjqP41dryfbTBqAPxs8q4t7pMGOBjudPDJ2OmtSQh/fDpCtTCxtSTdG
 tWoSWB8QSR9nxlJugDU7NQ6uVA2R4a8PsSpHNbECrk0bF01A1yqPoSekXuuDFWF8Xt9C
 qDGx3ON3taT+AfTfzf2hD/NRn9Vl/3Itxd9vqozJTZ+3ECZYhD9eZyXxI9LmmPAkQ+96
 a/vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN0Pwh1SgqcWhgojK4hJ3hGH03xB/hmzSbgW6YlbfvdyeIDZ3oTSD5rpWv2t3AxgkCB8dvp8TUpmWAoazm+mzcRvdKtuI=
X-Gm-Message-State: AOJu0YwHAm4MaTfHrXqHPoLx8KbFbt+RzSkqfmIWfEx1/O4PIriXZS3o
 RKEa3MWdbqkqzLLSQMI6Cwt0ejIZB+3diq5VDjlIjEpP6XsCUKHGEL1uYPpD7jI=
X-Google-Smtp-Source: AGHT+IHNOTlj53A7LFSWQMvggfVxGQyUWJYi0JIa0Zxs24tF4+OH52GfIPpvYds8esxkc1H9ooi9yw==
X-Received: by 2002:a17:903:22ce:b0:1f7:19b7:98bd with SMTP id
 d9443c01a7336-1fbb6d23ffamr98786465ad.6.1720737104885; 
 Thu, 11 Jul 2024 15:31:44 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:43 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:12 -0700
Subject: [PATCH v8 09/13] target/riscv: Enforce WARL behavior for
 scounteren/hcounteren
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-9-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

scounteren/hcountern are also WARL registers similar to mcountern.
Only set the bits for the available counters during the write to
preserve the WARL behavior.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5e76ad5a350c..5ef641918120 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3063,7 +3063,11 @@ static RISCVException read_scounteren(CPURISCVState *env, int csrno,
 static RISCVException write_scounteren(CPURISCVState *env, int csrno,
                                        target_ulong val)
 {
-    env->scounteren = val;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    /* WARL register - disable unavailable counters */
+    env->scounteren = val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_TM |
+                             COUNTEREN_IR);
     return RISCV_EXCP_NONE;
 }
 
@@ -3722,7 +3726,11 @@ static RISCVException read_hcounteren(CPURISCVState *env, int csrno,
 static RISCVException write_hcounteren(CPURISCVState *env, int csrno,
                                        target_ulong val)
 {
-    env->hcounteren = val;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    /* WARL register - disable unavailable counters */
+    env->hcounteren = val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_TM |
+                             COUNTEREN_IR);
     return RISCV_EXCP_NONE;
 }
 

-- 
2.34.1


