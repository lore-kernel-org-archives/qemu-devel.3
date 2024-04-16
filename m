Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385BFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwogf-0003J2-Fn; Tue, 16 Apr 2024 15:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwoge-0003IJ-41
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:41:48 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwogb-00045I-P9
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:41:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e3c3aa8938so30540625ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713296504; x=1713901304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIXT4Ow0ePHNvQiW4c64R7S9d8m6CFTE0ZLlfQRIw4w=;
 b=LJdXHhydNUPcBG2bNgcTSMO6VhAkgYelybgq/ziVH+dYgRo9CFM9osjaUx1Ti+vGtm
 IXOE7Ac5w9O0fLz9HCOuWaM0e2XI7KBD2X17YY8hSvqZNvnmRnaWCEg4WZBAbZuFs+11
 4M6hTGf0TKrWPKb0F0FQJrtGyfMFVUnJ7S8SzraocNYfCTlOrKZa+tR4akko1UHKQ633
 ppKdSDITAQNP4C1zLnQhSLHAhoe1czw3s5qAsqhzVms8imjbTx/nO7+RrGTJna0OVACS
 dOUqq0tIi2lerxMIwl1qfhxL8dVvFsSUQrUXQsytMLr+dKj3hz6EgSIWVYuwJug5kfp/
 A03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713296504; x=1713901304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIXT4Ow0ePHNvQiW4c64R7S9d8m6CFTE0ZLlfQRIw4w=;
 b=Wz7cOoRexefj/2G1wj9/3DQRJmWosrq4BE9teHCpLeU67A7WmxcA3/BUZknVvDp1QA
 wqvWpEqPJnW1GKctlFjBK1sXPEguo8lR+QftXjzqyJmrJa1Hau1CccV7+hWSqn5DPR8a
 vmQh3kejhYjC8Eu617KnU/68DCx4yqIke2LKtw4pV80E2T3CdPtRUkyuN4ptN9fIwyUo
 D7kGhaLZNHS/rfngqcUBEWdGDwhWwZO0GlJRNSvRbsN/skLKGat+bM9cl6hluajvkpS0
 yWOk0U8kV5FaSrbEMVH5eLPid4wp4RmdigvngIupBB+FrXoDoI4j4FRPIUuOYNlBdIbm
 /ogg==
X-Gm-Message-State: AOJu0YwjyayxMe03E+V0zNyIDhcHBnvXS0irBOAooaOUwXOwdY9NLjvd
 4yWwvSbyEpjE2jMl2oU8dmC3gDwx9EMhzxKnq1FPnGpPBzmZoI5U9BmMVVKws2UCWvyerF71Sl2
 N
X-Google-Smtp-Source: AGHT+IG8lFONKE0bYSTjNnlkDB7gNgi017CmjRe3W4duWlr6iOdbUDUUvjfpZ2s8TRwDLnvAVmQAKQ==
X-Received: by 2002:a17:903:26c3:b0:1e5:62:7aaa with SMTP id
 jg3-20020a17090326c300b001e500627aaamr10843183plb.20.1713296503815; 
 Tue, 16 Apr 2024 12:41:43 -0700 (PDT)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902704500b001e3c972c83bsm10160586plt.76.2024.04.16.12.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:41:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.1 v2 2/2] trans_privileged.c.inc: set (m|s)tval on
 ebreak breakpoint
Date: Tue, 16 Apr 2024 16:41:32 -0300
Message-ID: <20240416194132.1843699-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416194132.1843699-1-dbarboza@ventanamicro.com>
References: <20240416194132.1843699-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/insn_trans/trans_privileged.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 620ab54eb0..b89e3bd5b5 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -62,6 +62,10 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+        TCGv temp = tcg_temp_new();
+        tcg_gen_movi_tl(temp, ebreak_addr);
+        tcg_gen_st_tl(temp, tcg_env, offsetof(CPURISCVState, badaddr));
+
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
     }
     return true;
-- 
2.44.0


