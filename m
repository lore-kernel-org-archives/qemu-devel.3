Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACDFD39428
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILV-00005U-Bs; Thu, 02 Apr 2026 09:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8IL1-0005fW-7q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:43:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXi-0008Ow-H4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:53:04 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35c206f0481so737300a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134375; x=1775739175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wv2cHy7FNj/Jt5mfYVBliMRRNPmZvnmReUwKn4NRq8I=;
 b=nW50EdzBygjVVIt7rAoLADwdFPXjrT2KAOfJI45F4ib1vby3r8mO9Lo69unqikv9md
 cgDaaGfxGTUUb2rL+Tqj8G3ct9cez1WKmqRWWqDQg9iChXTVmGkRqcmPNr1RGf7SoP28
 5KBa5djS63X9mYHlAZOOjFP/2YUsGDzeOYSPxcGyW/c75gR875D+26aKleELR9qY7ziw
 soT+vgZpPevMT1Lm4dje1zhOr7fbVJhm9MnmVCPoc30beCE2hP8/dw7IBz9VDLGwNBia
 1y7Z63inigk9GGmmezaFwDu0emSJr7imf2S95Mc0i8vqBwW1dkouU+UPSWWIf/MyLHnS
 9TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134375; x=1775739175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wv2cHy7FNj/Jt5mfYVBliMRRNPmZvnmReUwKn4NRq8I=;
 b=XJCclIIev0Lbs+KzGTyS9MC68w2CkL9GmkxxbcfslKcncEgG49f/yrsNOUwa7DSYQZ
 BcbZz1iLWBZljKGiu8QzBD0x3DA+dVIKzZDbK/uIHdq3Jm1qrg5z4Sp4OkFc+zDptYVp
 XzEgiGcuBWP7fdBWmiByoqdoaEAi3zqXkw5xj13tJ6Z5rjoBJDbbUCBvpeX0urwY7Po8
 sTtHSyGcaWBMP9w7PT67MLF26JWZFV1dyIGJhbPCfZivBe4d+D5UTZR8N5CH3GjC1E6B
 8FItbZm+V3UJkq8BHIIbzZ/NExPHSKNwmOIxGmijKLtN4zWmjnEkJWzOsvNio4KWSRlg
 ZuBA==
X-Gm-Message-State: AOJu0Yy9dEPdpezSwO497A4A9jYxBYqcsbC+jLT/4Wdb2ridhqIhqrFk
 D13YuODe7qUSmVaPOLnVvHc6MWxpovzifdwikgyXPXB6xAJMqBNu0X+GwKQuV28iMOYi4I+n2V2
 uNEKOaGeQjk+RKWsjj04XCyzNcNEnwVFwoZlNOBo8y8gIJ+Q/662AYTaOHEAewmjqHpULy3f5S3
 3PKmO0Pa2Ki67goNxVuxo4RxPeDhL7OM3arLxAd3I=
X-Gm-Gg: AeBDietb9jHKWMD5bz2oPYnRgJv3DrdGverYJSBE1VKUjPhD4ue8RvLIl1p5J4JWiSu
 V6k7X07DXuDJTmYHd+PvocQUHzoJ6lwh646l06s78YSyCKW4nwaStv5Sa30jKwnEYv2Edrxhws7
 y4oBJMhBamduM+nMWtHBd3D1qCzRF1r0pCBqDnjGlyThRxpCx9q3qbRgchKcg208buH46TsZBEn
 uTVE3AmEiiohzIukC+rkdcmRRcvuKCf9cgkZJxHGn+GN76b0Gzb+kdluLqFiT4toICeYAG7SKxB
 7CesaYvTmCxznoE+r2eqzxRrd9XHDtku0Fc0sw2cz0FVnPzfd03oD2Ojstx2vc1FB5hd1JMkzoZ
 ic+OQe5FpgnLikMX6a8lCbTzKd+VGE3AeOMOt6vcoi6O2rYZ9yfBVNrdyJHbqeS8lVBwocAw8Qw
 4Of7t8rF6hNRZhm7xxYFUhBrEMDQR6XGtoTL1GVPkJ6z0s8Usi6mKFF5u9bMmR0gkWv+WmYJhsj
 gmcvg+OYUULKao1ppeIZLoymLU=
X-Received: by 2002:a17:90b:2783:b0:35d:974d:8f7 with SMTP id
 98e67ed59e1d1-35dd40208f3mr2899371a91.1.1775134374758; 
 Thu, 02 Apr 2026 05:52:54 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:52:54 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 6/9] target/riscv: Introduce altfmt into DisasContext
Date: Thu,  2 Apr 2026 20:52:31 +0800
Message-ID: <20260402125234.1371897-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9a7706431f..551581b8d8 100644
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
@@ -1310,6 +1311,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
+    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
 
     ctx->pc_save = ctx->base.pc_first;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
@@ -1329,6 +1331,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
+    ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
     ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
-- 
2.52.0


