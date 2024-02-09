Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C23C48BC0
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOai-0008IO-1H; Fri, 09 Feb 2024 05:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOag-0008Hp-GB
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:42 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOaf-0000Bd-3I
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:42 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5986d902ae6so404212eaf.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476319; x=1708081119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUXKBuZ8Cb3nqQgihfy7eqaegjmyQPsSLDGYh00UV8A=;
 b=TwS0Atza9O9Ib3IRrwNFdFEOKxq9sF1YPhepJXglmllk7g+C04ISzwWa0bKEDj/pEV
 8EY1BIeTjdhndwtZqe4CG7PTR6fQXjOaA7qnYSdh8EssTQqDenkbfcYaZitI1jfQRDcB
 HNVyX8Q8lR42jVjYL42T9UKlxVpstB4BTzENlDInaJ7Bz1MvandQ23LHWQblabdx0VmL
 MPE0UvCsnFDezNTXI53LpAMtONBDM6DZx5cXF6aiRtTm4Eph9kQYmJGE/i+TbWAq0MwG
 6jI904fENLfohuFPlP0dmt5gX4DrD+vY1lVkNf7+K1Tt/GcEzPNXgDdh+XS/R65evnVh
 x1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476319; x=1708081119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUXKBuZ8Cb3nqQgihfy7eqaegjmyQPsSLDGYh00UV8A=;
 b=pOHrLZ4vTfEzK9JlsoN+9lqi/Kg0uJhbYX8iC+Xlottea/GqL/YtapSbL1r4Nel10V
 9RX+W4I36ZTo2ad+CRcqsloujD9BYSR0Jx+gPvtDzbl2oiM83KpPhOWc3oo/ZhJPr6n7
 cqXr4ZAahiKb+D3JV+EJpzLiu9gvr1OWnEEdO9PADozkrdtctxpAOUNDpXqwyfgHx9SU
 gzwcZM+/rPo8/TjoYwbrYTxCOproEECbUFSE47/DMC2H3BQBzYrDpyDtXPnWWufG4ivR
 CpiuH/krcVhos8fdK2HFWW5jZjzmfnIWoqWxn7URc+7Wr9PSIh457m9gWoS33mH+SB8K
 kG6g==
X-Gm-Message-State: AOJu0Yx4U1VjWOYmTmjCZ2YErn3TyuIPfGRHjb2t1OH5uFxS3GK+C4ZW
 +oSkWraPos8RZKt3oUlDFEVChxy4DSU1hBCfbPlOS+P025BaQtGzYR/nbWVlq7VFoQ==
X-Google-Smtp-Source: AGHT+IHJS7Nsm+pC7VKwXDUc9A9db+ReVvl6LbhjotKloNRSMjjr5hODUjv++1jHAfExWyxmvTsnNg==
X-Received: by 2002:a05:6358:5908:b0:176:5bef:d337 with SMTP id
 g8-20020a056358590800b001765befd337mr1333744rwf.3.1707476318908; 
 Fri, 09 Feb 2024 02:58:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUUfczttgQcOkTj1G1Z9C8HoI/2wP0XOmkUXL7uTptH0Mj51kcryC3ccFa7/npO58Gg3QQHwovQSCgU7+BKxFH1yKkBwRt4Gg5uf26DiNahqDXf8gat3quTD4Ax3xV/O6qeToREZ7SYMaS9kjJYKcYlTXBEZhmZ3/QHdGMN+qiFC7Q=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:38 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 04/61] target/riscv/cpu_cfg.h: remove unused fields
Date: Fri,  9 Feb 2024 20:57:16 +1000
Message-ID: <20240209105813.3590056-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2e.google.com
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

user_spec, bext_spec and bext_ver aren't being used.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Message-ID: <20240105230546.265053-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 1 -
 target/riscv/cpu_cfg.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 136fc1de73..52648e3af0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -181,7 +181,6 @@ struct CPUArchState {
     target_ulong guest_phys_fault_addr;
 
     target_ulong priv_ver;
-    target_ulong bext_ver;
     target_ulong vext_ver;
 
     /* RISCVMXL, but uint32_t for vmstate migration */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 780ae6ef17..0612668144 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -140,8 +140,6 @@ struct RISCVCPUConfig {
 
     uint32_t pmu_mask;
     char *priv_spec;
-    char *user_spec;
-    char *bext_spec;
     char *vext_spec;
     uint16_t vlen;
     uint16_t elen;
-- 
2.43.0


