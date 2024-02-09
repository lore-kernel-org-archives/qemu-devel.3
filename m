Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A0EC4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObj-0003KG-7c; Fri, 09 Feb 2024 05:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObg-00037J-TP
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:44 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObf-0000Jk-9x
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:44 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so531359a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476382; x=1708081182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6o9MMOZ4dHEFNKiRTdazExjhHjp0AZ6zY+L7OhMwUFw=;
 b=a4ieQKaqoctBeEXPrSgxor5rSpymorJNB7oiQjWzG8oloBuUgYvz2HlyizbHQn323Z
 j6Y7QxHlMNcHtNyHqEujSMCo8N83ZfJLPQKwjiUDU9vXjAnHG1oOKuSP24W7x8b4Gnlg
 wadUaq9Ak9EmvAgSK4ZNSnGfz7MvWiQBfMDJ6xRGVcTdN4JgQ4K1Ze01IhpbifDt9CUo
 nOry7o663GhTGUn1YIoyJHRoaP14C73VPNPWmtvdSXIW+Tq518UlDDgl0LANgTykTesq
 fJUL5/vCUaa/ChmOBAXhciuj765OzWMbz6UVk8UUJLjvgBeffKBi6E+Iu+ecGYvOX+ii
 QNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476382; x=1708081182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6o9MMOZ4dHEFNKiRTdazExjhHjp0AZ6zY+L7OhMwUFw=;
 b=kLQa8slfZnIFAL7os6f/ZiUyWNfwpszxT7Z3qQIpAVg1kHVuKTt4oTeno0paFTNCiN
 EGFQ3x0WPjGES5RqnG5wfsgeyCRaC71DAVQxW2C+0A2w9sm0DV6FbTh5TA4m1MY6XyNC
 xuDm/rPr/K/Sn6oQBYJN1ZkFRvIEb2VqUiD3NvSFHGzFRvFVPeVM71BM/ZIc8gW/bUAQ
 U6Cb1zzab7pVZl9DLH/rlHCq8+/JejFoA7YluWhr6CE83sesTnfM4eUEJr94os51AIlc
 x3yQt2rjk3jURDobMpvAL1At4H3OmfmTOLpsSG2EpHyzt8NVEjDOfdpCQUeIA1QxYieG
 LEGw==
X-Gm-Message-State: AOJu0YzMSk+dLqqdMtdLEsc93fKqxJw91HSToT3y06yos5qw7TYell21
 8jxj3O2+l3+8DgPDb63iSOMJwk3mciNZFqgkIVeHOfh2l2cMqtud2BD9lpnMHZjSXA==
X-Google-Smtp-Source: AGHT+IHRLCUHz8uxsMdnNGqyjV1FR3s46V1yzGsvcVm+cUgWKW0/V+8NvkBt2eaIAjw1v7bPdUadUg==
X-Received: by 2002:a05:6a20:389d:b0:19c:8ed6:8bb5 with SMTP id
 n29-20020a056a20389d00b0019c8ed68bb5mr938148pzf.39.1707476381649; 
 Fri, 09 Feb 2024 02:59:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWg0uauXXzH09mhvOi5yVK2XJnL4R9n2UD1DQDLTkqKBfOCoLy1jCrrXglvEhXtjGHtDl7oJSJSXzTj0CmafT+vaPKZ50y0yVnzyfmaV09HV7Lsgiq5GcyQYiJkoc5r7TjEPdTyVtibdjBc7RJlZLIfl/G8BW1poqpGAH0m8Me4v9M=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:41 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/61] target/riscv/csr.c: use 'vlenb' instead of 'vlen'
Date: Fri,  9 Feb 2024 20:57:35 +1000
Message-ID: <20240209105813.3590056-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

As a bonus, we're being more idiomatic using cpu->cfg.vlenb when
reading CSR_VLENB.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d666620e48..d9a010387f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -683,7 +683,7 @@ static RISCVException read_vl(CPURISCVState *env, int csrno,
 
 static int read_vlenb(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    *val = riscv_cpu_cfg(env)->vlen >> 3;
+    *val = riscv_cpu_cfg(env)->vlenb;
     return RISCV_EXCP_NONE;
 }
 
@@ -738,7 +738,7 @@ static RISCVException write_vstart(CPURISCVState *env, int csrno,
      * The vstart CSR is defined to have only enough writable bits
      * to hold the largest element index, i.e. lg2(VLEN) bits.
      */
-    env->vstart = val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlen));
+    env->vstart = val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlenb << 3));
     return RISCV_EXCP_NONE;
 }
 
-- 
2.43.0


