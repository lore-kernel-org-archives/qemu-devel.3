Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6D3D185F3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq2T-0000xs-Hh; Thu, 08 Jan 2026 08:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2S-0000tb-Mp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:56 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2R-0003WO-4m
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:56 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c3e921afad1so1425758a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767878813; x=1768483613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8u/q2e1Rfp47UNW5CHZAz53PMC7FasnQwjb4yxYc8o=;
 b=YtfBcekLmP20Qepo/jKZ/UWC5LSOna9gMUvxuTfOIFP3oJCT8RJJEHhtPsnz2ATcA6
 LoWMztyvmW85hjTsefkQsfYyp8IZyVF57Y6Mk1PKxZTK8qXzJOxL+mqTafNM1CHnY//Y
 1mbCdnv0ySQAcFJdEFyu1OW0Dc8XXOo0a+Rp/60xHFYa+/cO5bslRLSzzq7zhMlJWbBu
 ljugM12pfbW67aV6Va/mLTcOVbvIc3l9RJyrZiodWV65noktfbht4JsPIFDE9WY1V8Sa
 oH+AoERz3nHkKCAiToS0CkoLAYBcUy73LRHGhA/0MDgLCWXvZEszg1pyGkF7m9FDgXL+
 epYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878813; x=1768483613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r8u/q2e1Rfp47UNW5CHZAz53PMC7FasnQwjb4yxYc8o=;
 b=BgDRs1MsyY/zpyQqUo+vcFpt7X5WTn6mu6LgO/F6pyTrQ9zr7R6cuZZPRD1cTFWK74
 VapH06+0PoMTaJOGyfdOtvLmaE5RHEUJCFmZG5vmecPeDARTdRNXwIcYny/CufRF4Arq
 OtjIGWpWlDp21vHa7ZVfz/USKS6JBNSDEwSF7URvfOBbseGA6Er1uWSTvgZ5hB4P7Y59
 a2erPipjCpN2GSDCFzNTp9OK6cllnr0gkhbu68qe1TY0J/YjAj73GUgtHCUTJL0OTMrD
 kZDtg9OjX5BbvTLL3q1fIMxdTdI0azEfIGm4QDo9SO7EnZRkv/vV0sJAfMnOTOW+au++
 ZiKg==
X-Gm-Message-State: AOJu0YyRAA/mzpjUOYw6+8Vfz7jvjDI0XJ+44xWFe2cuWrBD9WXtGbDR
 7qildWA0ojdZUn3/2nLHbVpLSCWYSLcTNs1lc2yyKtaV3vn+fn9vEykoUNqwgMIsaaDZof3dT3K
 +d5cIIaQ8AoGYXAmA1J8HzsuVwrp3gIAktl3DSL1YvyueU6HCj7dNgzbPPlkbMS0JmDTQNh09p+
 d2qJ/vV8fjUmL5KM9KZqdRx3o5QU1Mslu3MoVeuP8=
X-Gm-Gg: AY/fxX4hdWL8s8xWM8mg6sMWha5oC9oHE+VhuxSmdO1aJcCEKE2H2NVyUANnIJWfPCc
 5g+jtr+NqrWiy360HMCf+dkRDO+B3FayNYz0cDDxmgSUOkPRY4fJI2jQkdkftoy+v7A24CvR61n
 LEdcNNHra7qKzQ4KygUfuAPzVwLRH1mz4uQ/aQ3D9U5Uz3nJn7mTAuOGkB+Q2GPt0xVDxGPD5Y4
 etub4rctlLhkvTL0sBRenvcR9YA7aOdKLiWfsAEbvTrFynAh/gP7egvJ1GFgSOOe5bukl3GagCk
 Qqz15Sm+AhA5L9o8fW3vExDLn0QyKRT3W+Tfrs3ThkE/p5QQU4e/q1DTOnaa7ovobKSDojLqLoY
 bNsGrOrq+/ZrR78p0LwW94hfrg3XxMbWNWxx2oIs5B4Cwhk8jYMGYysNutCRyflySepC88XlDFk
 6hZpIoqmKqvJNGEoB2zGLQo22emLjjxV4zAAGKrIJHkBP3133XwPUT36g=
X-Google-Smtp-Source: AGHT+IGpUX4lVjo/p4cLGmGAGJtnXL7h49JQ+AOxbDh553PmCc++ArArd4hPNCJoBoFtxXczr1tAgQ==
X-Received: by 2002:a17:90b:4ecc:b0:340:7b2e:64cc with SMTP id
 98e67ed59e1d1-34f68b67ceemr6642253a91.15.1767878813218; 
 Thu, 08 Jan 2026 05:26:53 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm2298787a91.0.2026.01.08.05.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:26:52 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 6/9] target/riscv: Introduce altfmt into DisasContext
Date: Thu,  8 Jan 2026 21:26:27 +0800
Message-ID: <20260108132631.9429-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108132631.9429-1-max.chou@sifive.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f687c75fe4..911d3932f9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -101,6 +101,7 @@ typedef struct DisasContext {
     bool cfg_vta_all_1s;
     bool vstart_eq_zero;
     bool vl_eq_vlmax;
+    bool altfmt;
     CPUState *cs;
     TCGv zero;
     /* actual address width */
@@ -1302,6 +1303,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
+    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
 
     ctx->pc_save = ctx->base.pc_first;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
@@ -1321,6 +1323,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
+    ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
     ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
-- 
2.43.7


