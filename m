Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C584FC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuvy-0007zD-9A; Wed, 06 Mar 2024 12:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuvu-0007la-WA
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:19:59 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuvp-0000lx-2l
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:19:56 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dcc7f4717fso70351145ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709745590; x=1710350390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+g4D54pWhc9krlDTCdNm9ak9WWqZ2BdKgUJhackDh2M=;
 b=apapRWABxwCJ+9v5WlDnn5fpJa4ysEyE+oRIyI7S3murAHtP9NFvPEv9XZbZbyl5kJ
 ElmNrSIo1cGONcnLtZXuby9TiRWfVsigxtS+wE9wZbqY7v2X0tA0hKvB1ruddASR4+RW
 dbev+QXlhMKkzVUQ2KallJNNEyRYFtRJ8RkG0MT/Wuex5gpeDkvcXLFBL8rZ/Q4WOQJx
 +66MqRQe5kTWSRUl7922LR3/HMoIp6G0m95CrNemHuBWqEeJ48ywgBCChr4So7CKaDrY
 8YEZbCIZI1iQpQnOvAn4s2jfeGBi4GDFiTrg+P34YH6y+6haHCNAVJlrZ+qUfdMfIMWW
 ZJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745590; x=1710350390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+g4D54pWhc9krlDTCdNm9ak9WWqZ2BdKgUJhackDh2M=;
 b=SqFrJy5BSa4qKPgevXuw+kOegkFhsr/Ry8WSUcA/7iGNJxo8AXSd0KkPcr02ehFo+f
 CIT5GG7S3oxZn5iZYkl1lQbF4SUwmTBSf61v8h+UG7qsFQIaHX4sC4A4SMbyIglZud0O
 Bi2houGB4iAo0JKtf9yDScdruhGQjweV6mbvdR4uLMChITHNk57dRJN0401e96Y5zYz6
 6QVBht1PUKX1zue/G8itQDkCYpc5ZWuYZOc+ZKZTvVEYSeVGQPhskIY683kmRZbzpaVG
 r1KetDel1/Kz1BgzZpij50XXMidgPm7Quo8K9iatKYzZn8a/g2p18LtHh32ChExtnoE6
 yPAw==
X-Gm-Message-State: AOJu0Yyql0DkiFSLqYOANbHk/lmDWyFIMa3lPJ7P5DWcLslh80wmbq/e
 Z5lq9m0YlwdH08LFOi++jbMjTJnX+dRUXYezXUSqEeNdTwsIv/g/3PDMhecZerf3rxJSPkA7pZh
 Z
X-Google-Smtp-Source: AGHT+IHqaMbI2akp+6F/SxlZikDBh1YfurlbmhS8rotohxwLJhtuLvbIv5QtZhErWcFtWBw4m6v+rg==
X-Received: by 2002:a17:902:a9c1:b0:1db:be98:e9a with SMTP id
 b1-20020a170902a9c100b001dbbe980e9amr5926312plr.26.1709745590030; 
 Wed, 06 Mar 2024 09:19:50 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a170902c71100b001dbb6fef41fsm12869712plp.257.2024.03.06.09.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:19:49 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 4/9] target/riscv/translate.c: remove 'cpu_vstart' global
Date: Wed,  6 Mar 2024 14:19:27 -0300
Message-ID: <20240306171932.549549-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306171932.549549-1-dbarboza@ventanamicro.com>
References: <20240306171932.549549-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The global is unused after recent changes.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ea5d52b2ef..3e12371887 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -38,7 +38,7 @@
 #undef  HELPER_H
 
 /* global register indices */
-static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
+static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
@@ -1324,8 +1324,6 @@ void riscv_translate_init(void)
 
     cpu_pc = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), "pc");
     cpu_vl = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), "vl");
-    cpu_vstart = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vstart),
-                            "vstart");
     load_res = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_res),
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
-- 
2.43.2


