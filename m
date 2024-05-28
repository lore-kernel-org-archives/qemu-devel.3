Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E3CC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpF-0002yP-29; Mon, 27 May 2024 22:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpD-0002w1-Nq
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:31 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpB-0003jr-EN
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:31 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2bdefdeb545so262586a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864267; x=1717469067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql0FgN5uAYwS4fjD417MxORch4Nog+b+HrGavXDYZwI=;
 b=H2GqarPhN0kqpLMmWqjVdNsC55+kNkjIwXAeUTpq777S0m4XtMQznwFp0/BuxwgQpt
 H5GjCObpTnu7LAkn7rMo1PrH+7rUynqM10JlZDQry61rpOyEkusBGuvyztuabQIraGJ3
 8e8WJRDJkXERgcANJ1PKlhJvgdGjbgOFvR+vCzBObQSpZVbucPz6mmWONJPMZFY/eZBd
 QCn4FtFnx0GCMzYc2BQaaHNusU09Udb6pI3M/eMx/j2C7CcZ0A0oJq+p7yiiH2y3bS0/
 dCSVZl7CELAziWNjELkat6KdcL25lUswjdw4stiWoF+g2Zn4quSs50xQO/CFZWYY5Wtt
 1dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864267; x=1717469067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ql0FgN5uAYwS4fjD417MxORch4Nog+b+HrGavXDYZwI=;
 b=krIixk4IKFX3goAlupEHKUBBRDkC1/1xpkJXTBBPRf5vTUWrWR0pkgosbsTNfmFjx4
 EhV8sGqmDktz8ISMtnQa/u7xgCYD1z77lRUDj9AyYvyvfCsmgqcO7JAeV8VPXDnAMxS+
 rRYnj4ugCoR7gj3gQEgsh4TrAmfbdzKh2AYF5PNBSfTMIhx0APjg+HMOc33hIky8xeIx
 qejArcWanOEzbyEUsWvc8/9bP69mU8GmE6WYIF8Y+UiaTp7r/oDg9jeApXun5L7Tc1rN
 Zq/+PA7lNyiY7JvtNo1cqXsZA47HWounzMjR8utZ+9g2tqVduLGyCksvPblIx+SrCnxt
 BTPw==
X-Gm-Message-State: AOJu0Yy8A2OhEv0laTrjO8cmauTTgoQEPDzFiPqzG6bvITeUvHjliqaP
 l8mmC8ZjzD2A6Xt2a4zutX7oamwwbNT2F4hsupjuMSz/G1k8xA+cOjXm/A==
X-Google-Smtp-Source: AGHT+IFZbKQEfLwaWE7UGaUvdtw6KhORrld8W9I60HoCXD5SqbPydenu8wCfDRn08LNvkum6C4Zm/g==
X-Received: by 2002:a17:90a:c257:b0:2bd:edbe:4e1 with SMTP id
 98e67ed59e1d1-2bf5f2080b5mr10244051a91.31.1716864266759; 
 Mon, 27 May 2024 19:44:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/28] trans_privileged.c.inc: set (m|s)tval on ebreak
 breakpoint
Date: Tue, 28 May 2024 12:43:09 +1000
Message-ID: <20240528024328.246965-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Privileged spec section 4.1.9 mentions:

"When a trap is taken into S-mode, stval is written with
exception-specific information to assist software in handling the trap.
(...)

If stval is written with a nonzero value when a breakpoint,
address-misaligned, access-fault, or page-fault exception occurs on an
instruction fetch, load, or store, then stval will contain the faulting
virtual address."

A similar text is found for mtval in section 3.1.16.

Setting mtval/stval in this scenario is optional, but some softwares read
these regs when handling ebreaks.

Write 'badaddr' in all ebreak breakpoints to write the appropriate
'tval' during riscv_do_cpu_interrrupt().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240416230437.1869024-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_privileged.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 620ab54eb0..bc5263a4e0 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -62,6 +62,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
+                      offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
     }
     return true;
-- 
2.45.1


