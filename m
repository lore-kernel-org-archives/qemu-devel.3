Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7E8D13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6m-00012Y-Nc; Mon, 26 Jan 2026 20:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6j-0000ze-9P
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:07 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6h-0008Db-4S
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:04 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-352e3d18fa7so3582409a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478182; x=1770082982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LqRVTTLSQIfLRcsKC40rP2GDym2u9VIjpNXYFN+iQs=;
 b=lUItmpkqKNysZpAEGhqic1s3wdDnKED6AWFz95FrNrjHdUKWdD58roKFF64WEfyuSC
 AyJxBP9hWZNLugFy3kjDOaCsZx0f/N2+2rUjYjiiOUhGfCODqMOCKaoIhVUTQnH6taXU
 Qh4KhHGlZUB0tXi6KitO9oBZ1XypFbJOcRARTBSxWaY0lNQCKt4qcfH76BFm6KqN2Lpu
 eM3W5HgXiQXpIwn2ju4JqBGa7z6cuW622vzLummrg1IGxqh42IXeGJx9m4YQuOGf0Cuw
 RPiXYceuqsXB3j6ssQHkQWem8Q2QUOoE8A6mCg4AxQD0uJB2sZ34Mz9nk7o3cvNBFXOi
 hwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478182; x=1770082982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4LqRVTTLSQIfLRcsKC40rP2GDym2u9VIjpNXYFN+iQs=;
 b=fwbW9ZAQgvobNg9E5XnXSlgsEBvv9Ay5n8DvljvtGHcKetGUnJ4/vJmDo8URdWI4q8
 lgFq5m5luiVUSR1IMnlzxIc8ZsMuRVEg8ozj/7/IqmYMan33fQ+yPPMRWLyEX30Wk9jX
 EfePQAHgknjEYQh787IvJqv9UjNqPS0jGNFLJ1ba3ovtRRxYrLtngRFKrgpTZphhn6EG
 /E/EmjciBmPUULG6FzW3OEj2GBZAhRZS85y74O54Ujo4eSfjNYoOOv69oTgz9MdnUMMV
 r3Edakmr50ImTVfYm39prm28C6JJbydW+YKth5mmbBSy0m8Y2JAT2IqVK/uwlX7RyJ2q
 fPuw==
X-Gm-Message-State: AOJu0YwPm5+PQfQf1BGJf/rMHZuc2E6zuLXjkGlJJBB7x7fgO3UOmoPF
 8aYE+MdZV8OXk/Cgg+RWGnvB8RPps1jTc60u9O8pYKTH/6RI0hC0j/qjBgLdHQfgs9K82Uk+E/g
 Gr+/I0mr8Kb7rOVw5KA3vJZPWTS5zMJuwgX2v3aKQeGrXJmpcSkZigW2hDjhIghVhkJ95KzB2vN
 nYTSXeSfw9j4UV8pO+s+1PQ15TU6r0168VUhzNdXRumg==
X-Gm-Gg: AZuq6aIjhAci9sQ3RKOWYV+2cBgtsrKOKvrhsUwxyf8jESgBW8icgoDVdhNpXbFHv1p
 y1CmD60PAITUgWes1+xS+qO18FY6CDiTkdmTOIR+nOFx5b3KbuQ0CfQfuxSkkRs34xPK9E3NiOA
 6oNwiKt9iqzbB7Y780c7RedBSLzIpXp3ksB9X8m/B3CtiOzjytmqV9XQlCpw+Iokg0jjIenn09h
 1oGmcJMA+bEP77Ga86eDVMIQfSM6L/mkY+4y36EJ8kD/FX9qCyhNR25UD2esOCeouTN1xI3LhQN
 94xO7rOzYahX3ZjYb7u8JSCQ6L77km58cBfcjRjO/RpmwYIZq/6IZUECtUXxhINhHeVsWgcbYJF
 epsKNZp3+ZfAy/Jksv8xHhsrK0HQe21+0VG1pxqQ+/TU00TIxonXsCxyRWAyi1NCpyfSyCB90p2
 SE9/FmAn2SvGnarsalt7lOby75ivxNVNKuU1451HhKNNqo9aCK4IkbmmLswc0tPO4oHGoHebtGl
 fK+YlMt/Z84zF8=
X-Received: by 2002:a17:90b:586e:b0:353:49f2:1e7c with SMTP id
 98e67ed59e1d1-353fed9b2afmr185534a91.30.1769478181619; 
 Mon, 26 Jan 2026 17:43:01 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:43:01 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 6/9] target/riscv: Introduce altfmt into DisasContext
Date: Tue, 27 Jan 2026 09:42:24 +0800
Message-ID: <20260127014227.406653-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127014227.406653-1-max.chou@sifive.com>
References: <20260127014227.406653-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1034.google.com
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
2.52.0


