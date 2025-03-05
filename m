Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C2EC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdx1-0001PX-11; Tue, 04 Mar 2025 20:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwy-0001OZ-Nv
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:32 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwv-0008Lj-Mu
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:31 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2238d965199so61653515ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139608; x=1741744408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW5zURPCWXC9LghxnOTTQW/12iqlMGnRb2lijiceHcM=;
 b=lfVLYRfRMlqULJDCrlPoM4HjfftDma6Shh15XWlmQQEsWfBvjFINinlyDXsCGU1mzO
 kuIVOSgce9dnbXFLR0dd9Vgc73YA/+4fRmp4y9sThG7+0p2YHRS2w8M0OaMiIy4mTDKN
 vlI1XAThYv71wcNzUd/FRHChcrFrx2ah+GWEzqKIKGRVHmnrjA4E62vOAwTJX8yhFotU
 gP12fm6zikgDRMA92WqEzpmozX5DFAE9wlj3IlAB8waSEXMyzblwXlMFwCna6rMVn2IL
 yLCpRUAdlK5qkZidBvmEoq7DvSazGgGEzHhiSddLpZJqE90z1HQYcPAwd2uSzQVhjOLN
 +0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139608; x=1741744408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wW5zURPCWXC9LghxnOTTQW/12iqlMGnRb2lijiceHcM=;
 b=adnP4aPOst1As7eU39FAgaqKayRev6ztsEHP0z1EP2dhOpgK3OxwKirTtrBlRnp4pM
 96R0RAROYt5I5QRagTp9YVxpfZlwU/DEgwyqRCgwHEt4QybTayXz46A5o0gvACl/qNJJ
 P7pKWH+OlRPO8yuy4f4pkNWMi+Env8fLCvLI474jN6pVZoOxWKdsZ1ot8wBE0xvqTo4v
 UrM+ZDg2K9ipaU34xsqHdr/uNDsZLF7Y7Ihy9/Rr46VWFiPioEWz++X7VQyfSd2mLO2y
 6M3Ua/4VLqvy6J8Jh9utcM7lucYDHx0RIxE3s4T1vr5k57D817dYD2LHd+/7+LDS6vgp
 a4rA==
X-Gm-Message-State: AOJu0YwhgkQmqneLt51I70k+wnCwrLLdBDdNgqLfDJ0SqwEPwuuRSv6F
 0JxVB3/yrT4/gmGdzCfCiF1icmMchGdDGLDjfLKU+TIGGNAzgY1/ABM00v0Qpw8=
X-Gm-Gg: ASbGncvqyKVkkrZOQhs2f+x8OsaZ3rNrpOjPvinRPFAddqSOuoo00Jg4d/d73lCpI2M
 BC9twlmL3tXQoGghu9azmKAz2r3bJamaW/h6PzfVP/GaXaFFOmyY1CIhZJ5guR3V0p5ft6ley8S
 QHurS73dzAc83anapsMNS+X1AyorNRH6BxOi3/H4RmFpng6OMwJVdZNdtBFVOzvW2YyEaXVT0h0
 19OS++GKium0NgOxPOiwWyoWtLzu3Fd12LZzCEECUDKEivFpD+hQ9tdJn/zfGo3F25vN97UFJV1
 aJdJ7fB+R74Cva6q39qoIR0uvU2oq3P29aIQOoz4PfT0cYL3dC/5LO3KpDCqqI2uK/sh4WswdP4
 hr87IA1+cUb0w97QIlc2mNseEDMIGNiMfT+vJu+rf5lgRbwDVHwI=
X-Google-Smtp-Source: AGHT+IFoq01iz0MCSueot8Imc7i5RllpvClielHOgJOh24LtPKrIDovz1DIP0o3Stt7uu5fm3gt+aA==
X-Received: by 2002:a17:903:22d0:b0:223:4d7e:e523 with SMTP id
 d9443c01a7336-223f1d3543fmr21502325ad.50.1741139608131; 
 Tue, 04 Mar 2025 17:53:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/59] target/riscv/cpu_helper.c: fix bad_shift in
 riscv_cpu_interrupt()
Date: Wed,  5 Mar 2025 11:52:13 +1000
Message-ID: <20250305015307.1463560-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Coverity reported a BAD_SHIFT issue in the following code:

 > 2097
 >>>>      CID 1590355:  Integer handling issues  (BAD_SHIFT)
 >>>>      In expression "hdeleg >> cause", right shifting by more than 63
       bits has undefined behavior.  The shift amount, "cause", is at least 64.
 > 2098         vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
 > 2099         /*

It is not clear to me how the tool guarantees that '"cause" is at least
64', but indeed there's no guarantees that it would be < 64 in the
'async = true' code path.

A simple fix to avoid a potential UB is to add a 'cause < 64' guard like
'mode' is already doing right before 'vsmode_exc'.

Resolves: Coverity CID 1590355
Fixes: 967760f62c ("target/riscv: Implement Ssdbltrp exception handling")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250121184847.2109128-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8ff6d900f2..1de8e0e494 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2084,7 +2084,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
 
-    vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
+    vsmode_exc = env->virt_enabled && cause < 64 &&
+        (((hdeleg >> cause) & 1) || vs_injected);
+
     /*
      * Check double trap condition only if already in S-mode and targeting
      * S-mode
-- 
2.48.1


