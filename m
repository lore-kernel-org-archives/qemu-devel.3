Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CB5C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdwo-0001JN-0i; Tue, 04 Mar 2025 20:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwm-0001J2-Ej
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:20 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwk-0008Jw-TT
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:20 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2232b12cd36so86346185ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139597; x=1741744397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mF3n+pRh+e300NOA7bOH0Ula4mldw0TP8aiKSv/NutE=;
 b=f0siyMt9b78uXDzg9QxAgT5WiV4dm8o7elp0OP5hN2PdjufnAVexYODmP7oScgyKQW
 QziCIyo7+hKOSacpS4rkhh/s0TZSbj+29+lOXH/2zi9qdwwOC8yyCL8fJ99JRQMp9Op2
 +s9tBd2ve3u+Wl3Y4DXS5D/PPEofdqczSBxELSGlP5SA0IcUpcS6rdwnd1Gx1y3+oHMS
 wJ0cnkzvZWyP7hjI1fyhq0Ojk84MzevEoNbzGArr7xycSID/SUs1KHtBgmjQd7bWIsQz
 RkYyep3n3PpBlspIMlUKtXJR3GUF8/9D+wm+R0k2GpHfLPu9MozTjYMvEUqG6eFwqu6x
 s+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139597; x=1741744397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mF3n+pRh+e300NOA7bOH0Ula4mldw0TP8aiKSv/NutE=;
 b=D4Q/yGUvHo2NzKGTmSZxk+zAbzbugUP9zTCtUyOS44b78ifdlCXcpVmhpsHe96E4Sh
 HLe4LkEAk5neGJko9PKHbHxoY7fSlyuNb0Z/+OeNAtMKhlpaEK3YuNCFjtFWtlm6RDmc
 YGNXBmcPkEnZQsXDzWXg8eQMwE7vulqgQTpKIkYNQdD+R+CgumtZ/Fy5QR7/cJE/nOLB
 Zpc8Qa/vJf+umWYufRovNxnBeszdLlWiVFespoFkiWVruCUpKGndI+htIh/SsMWAr0ji
 rz22rPFH9DYQ7PYA929L1taU4KQcP/iISWYnt9TO0QGpE7wKEgeiy3XotCo/KzH36SRs
 ZyfA==
X-Gm-Message-State: AOJu0YzX1ahuzal1FLxsJycK0+fafXoQZPqhabpTDs3TwgbzdVkeijvH
 kYTme7yblPMMvI36F59+AdQpVhC3eBxPrLPmClsVdWcHerM+3XuM3g3Y5q9JvKw=
X-Gm-Gg: ASbGnctMLCKBFHw1Tx59Vt5q/sOye2fWsXSf3RnmUtXZoyb/IZT2rTH1/xn68VJSmb0
 w3k8NnhRsw6XnvWl2wIx61VSrVRjovq2JtDmEMXglzWINaSHxo/Q23ofsD7JSYPmn08dzFzaOMv
 armCkqgujqjeCmDWV661d+TNyHWMyukLfDJncjXMZ8GhwZH2oAH34/ZErBJPL1TCxygMiIOgWe4
 KM103AroNDHnMp9lRwcBwimpctJSMbAoGYUnyCApg57H2nDP14//1RGQPrjtH97MfroIj9cwr+e
 lBpuRXsDJemUFUwkaO8zKIyx98R+rqMlwrzXxzH/OkP19k0g44uQC0W9aAv2rZOQU0obDEiqSZ1
 7DFjy1pVNXNLd2ra8UxuJRrBDaTjPf5URezyGkMglEIlbq3mYjpc=
X-Google-Smtp-Source: AGHT+IEUs/z57J6otEYiBs09M8JfSc9zAm7lPrAuYP2QXY99ZItnZOedQBaRJ7NaRRaDXlhrhknguw==
X-Received: by 2002:a17:903:19d0:b0:220:e63c:5b08 with SMTP id
 d9443c01a7336-223f1c66040mr25468955ad.11.1741139597242; 
 Tue, 04 Mar 2025 17:53:17 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:16 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/59] target/riscv/csr.c: fix deadcode in rmw_xireg()
Date: Wed,  5 Mar 2025 11:52:09 +1000
Message-ID: <20250305015307.1463560-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

Coverity found a DEADCODE issue in rmw_xireg() claiming that we can't
reach 'RISCV_EXCP_VIRT_INSTRUCTION_FAULT' at the 'done' label:

done:
    if (ret) {
        return (env->virt_enabled && virt) ?
               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
    }
    return RISCV_EXCP_NONE;

This happens because the 'virt' flag, which is only used by 'done', is
set to 'false' and it will always remain 'false' in any condition where
we'll jump to 'done':

    switch (csrno) {
    (...)
    case CSR_VSIREG:
        isel = env->vsiselect;
        virt = true;
        break;
    default:
        goto done;
    };

'virt = true' will never reach 'done' because we have a if/else-if/else
block right before the label that will always return:

    if (xiselect_aia_range(isel)) {
        return ...
    } else if (...) {
        return ...
    } else {
        return RISCV_EXCP_ILLEGAL_INST;
    }

All this means that we can preserve the current logic by reducing the
'done' label to:

done:
    if (ret) {
        return RISCV_EXCP_ILLEGAL_INST;
    }
    return RISCV_EXCP_NONE;

The flag 'virt' is now unused. Remove it.

Fix the 'goto done' identation while we're at it.

Resolves: Coverity CID 1590359
Fixes: dc0280723d ("target/riscv: Decouple AIA processing from xiselect and xireg")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250121184847.2109128-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index afb7544f07..ab209d0cda 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2658,7 +2658,6 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
                                 target_ulong *val, target_ulong new_val,
                                 target_ulong wr_mask)
 {
-    bool virt = false;
     int ret = -EINVAL;
     target_ulong isel;
 
@@ -2680,10 +2679,9 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
         break;
     case CSR_VSIREG:
         isel = env->vsiselect;
-        virt = true;
         break;
     default:
-         goto done;
+        goto done;
     };
 
     /*
@@ -2705,8 +2703,7 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
 
 done:
     if (ret) {
-        return (env->virt_enabled && virt) ?
-               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+        return RISCV_EXCP_ILLEGAL_INST;
     }
     return RISCV_EXCP_NONE;
 }
-- 
2.48.1


