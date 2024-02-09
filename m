Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD53C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObs-0004Im-Ix; Fri, 09 Feb 2024 05:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObn-0003ya-Of
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:51 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObi-0000K1-Nc
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:51 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso240895b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476385; x=1708081185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYEKFF6j0R/Jcre/B6RLGTiKnt8r3XB9ZUvmabKXgek=;
 b=cv0jTfHade8YZWLRJB2qsOUMbA3TJ4lzL0o6HNF8AFIXK5PdixpQWsRy9w7Ap1wHjn
 6vaOhyhPnR3+NSItM2KcrFHeZba6/cc90LBILHlwdcq0mnz6WdcLAii2DxNDXeAD+JeD
 WW2IyxFyNzOEWEW4MeeB/jAIa2ptDELr3PYo3cwxd/x2l3YO61FNknTyySlgTvD2aTJv
 31ZYFMe0oI40Oihu0QUdQRbRjEZ3twEIcX+NxcseP0FqzooeqTJy68LNzYZlznRnLXBA
 Bzf0jBUgA9X8ZI+AmlAQI8VVNnlH4iIlss3Kp2sbRSRt9MNHwKltw9iQv4Vw58pS9Zzm
 jSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476385; x=1708081185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYEKFF6j0R/Jcre/B6RLGTiKnt8r3XB9ZUvmabKXgek=;
 b=hgDJuO8ufz1tRT9i/9wcdv4uWy2Am8Wi/fgpLFuW9x6p+cnavGQEbgA4BtWk0JaNN4
 2/dYMWLit4RANrCY2gFGuZEIaPqDrkjwtkXblb+yRVeFj9fdyOP8dodI2ueCxgIHNT6p
 pBf675tipYzONZN5IP7HNFZWbj3YPnUTCKgFOmF9pUo7LCht1wuZBu35dYTf638inUCb
 l8kLRJJ2iYmNtXI9B5nWWJ+JRn+UWlEC7/AtYrMTmhigBBdvjbA0eBHCMVvpOqumDmRr
 Pl8+wZuHhUOQ6bEg1wHNr3caPbAGN6/ni+97Ab0V2iJQjz7uZbbolNyVsVC4y3Zrn5sE
 +iKQ==
X-Gm-Message-State: AOJu0Ywc/MjP9onpUCdFDZUTdZievWZMumpQe55P9u18u4wHTabp0DZR
 2Gb5eDRfHe6XvFUKf5PliVWVJP8mwns92BWtdAQLdS3vYvdhwGPDAz+7tj0LKjMwCw==
X-Google-Smtp-Source: AGHT+IFyRgbtxqdrVHGtlKAl6yiq/pQJfWDivyzp0mBC9sYmIeNGcJGy5xTKpsOH4+GMHbmvpJW/zw==
X-Received: by 2002:a05:6a00:d52:b0:6e0:3894:998f with SMTP id
 n18-20020a056a000d5200b006e03894998fmr746190pfv.17.1707476385071; 
 Fri, 09 Feb 2024 02:59:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUBHDsYfvBCMssW//y/PMBKAPUPUFbPybhaOQg/pOohYAaAk3UfjDiUqmt9OSPMWs2STmh4XSKoca5mwIzjKig5tFAyk+5wCW4C4Dla4trntF6c2BJpi9Wq64BCOtjpuKMiQ4XXmrfeF6b8q2Zx0hi5mSZFXr5xy4Q0GWOqMErRyGg=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:44 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/61] target/riscv/gdbstub.c: use 'vlenb' instead of shifting
 'vlen'
Date: Fri,  9 Feb 2024 20:57:36 +1000
Message-ID: <20240209105813.3590056-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122161107.26737-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 58b3ace0fe..5ab0abda19 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -130,7 +130,7 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
 
 static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
 {
-    uint16_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint16_t vlenb = riscv_cpu_cfg(env)->vlenb;
     if (n < 32) {
         int i;
         int cnt = 0;
@@ -146,7 +146,7 @@ static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
 
 static int riscv_gdb_set_vector(CPURISCVState *env, uint8_t *mem_buf, int n)
 {
-    uint16_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint16_t vlenb = riscv_cpu_cfg(env)->vlenb;
     if (n < 32) {
         int i;
         for (i = 0; i < vlenb; i += 8) {
@@ -266,7 +266,7 @@ static int ricsv_gen_dynamic_vector_xml(CPUState *cs, int base_reg)
     RISCVCPU *cpu = RISCV_CPU(cs);
     GString *s = g_string_new(NULL);
     g_autoptr(GString) ts = g_string_new("");
-    int reg_width = cpu->cfg.vlen;
+    int reg_width = cpu->cfg.vlenb << 3;
     int num_regs = 0;
     int i;
 
-- 
2.43.0


