Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FD1C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1pV-0003Xu-Rw; Tue, 07 Jul 2026 05:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wh1pU-0003XV-6Y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:11:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wh1pS-0002GY-QT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:10:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493c1950518so2545565e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783415457; x=1784020257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lNhqIEO4Y4/uK8KijQuDX0PHP8gR1qrz5+KexoydX0=;
 b=PSXd9LlxSU6SGBweGu+TPpbTlApyFki3k45psmS3Y7AhYsFQBK6wwy2JASQ/i0tXox
 HEl1XxrAgtvnr/f3Frc/R6ajxIH6alz6DNDAFnikBm8vemxIOOc6SU3/Z781WMw4ScPI
 c/ckmz0TwAlNDBon2yiMYqkhXIxABtGxkggNUyY1XNiLEe3HnmMm3niszLWvIMFGMNcR
 gOUhE8wgN7R87btmTOWKzklb3dFygqEL/CzegsidYRfkBY2WKnbNOzJYzLLBNLLU3Yy1
 w1ON08xm+kUplKpCiC0VGQGxGSG+TT76DgTHncn4DUfAfjaETtwVV5aftl6u/nYYns5h
 MGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783415457; x=1784020257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5lNhqIEO4Y4/uK8KijQuDX0PHP8gR1qrz5+KexoydX0=;
 b=idijoHC+DKkr1aupqtsVHEP2jG0aNRQ9Z95B8EPga8j70gM51txRTqOCegDsivTAKC
 rBCC26/OBL6S/tSMPM9Ox6xMPtIznoDYhEbI9GzNszEWJ+TK/8gQEmXainh1iIMEWHB+
 ps73a3VMRW+Di8Rg+EW+NgzgJ8PJp6nzW/acWSqzhtkO/eVj12+F6FYh9mPyOZjq3KYp
 8oIzZ8cmdCTpnsk168O0S82i3i9PK9DNo/HkT5EJHPEpq9L1rHWg1Vn+AtlwDPZElc5u
 I2zTvjGg2IoNaCQiaFZGdSYvh1emJBp1/2LQlT7SxTvJh9ASOV9Y8iYhd3Q5RrN5xJ33
 5neA==
X-Gm-Message-State: AOJu0YyaypqBSXzZ4bKIGFwj7M8Lkh2x+Seqa5PFv6IL3Dg/xJnnnEsG
 uozmQwkMj1daGQvY5D2skiA9B5qiQGUhFpcHZRme6NynCDW1btdz/AOvAq7mhUrsH1xPLvyhmhD
 PweRuUWATMpPdAPIFBU0TfOObetxb6fFWAxj/+hOWABuwzJDrdeki94rnOF/iz8eXTdpovAuAzz
 2Sn0QAl70BLbAWJCbjjHkVxPvE3Ap4poRy57QPLzTxCrvS1//S
X-Gm-Gg: AfdE7ckc+YrOyC90yca+r0T++/Vtwvg2Prbd4dvaD/roxpJHjTsywcIhRRpTp7bwp/X
 y47scm8N1MSVXyLC8DhuMbeh5Q1lMnNJqZPt95GVBYkrc+g8+0X7PxZoc75PQXwL0wTiNisehaU
 Xma7L9U9QE0rqLh8+OB6tEnWbs0M+WYhTgdzrF8QlICdKVfykDPzN1LAKKLIGk18UVdcHtmWMMw
 lsUdj5d3zkcQUFVO7uSA06Dq/K/1wPk8LWP+cg5M2w3quZysxfWcUxweI//CrxQ4CG2u4zrsChZ
 0DO8BqxSTJ73Gx3qC2vIQtoQ4ayDJmuuboR8ndy6TVkUCBmPLW/WH+7Tti97n0+bJujkZrA+0XE
 rQxdmEk10f4SKaCwGfvdm7ilbQ3044EWML+4ShGbNBR0hmfl0e3ZCuLkGuLd74FQggjBOXM6IiM
 KCVUawDCLsZDen5Zls5Xk6QqPnpstHlDhAyFkGxvI=
X-Received: by 2002:a05:600c:8010:b0:493:d117:18a8 with SMTP id
 5b1f17b1804b1-493e1011e8bmr17829465e9.9.1783415457146; 
 Tue, 07 Jul 2026 02:10:57 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f32660sm41004665e9.2.2026.07.07.02.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:10:56 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 2/6] target/riscv: Support raising misaligned exceptions
 for scalar loads/stores
Date: Tue,  7 Jul 2026 17:10:35 +0800
Message-ID: <20260707091039.2574638-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707091039.2574638-1-frank.chang@sifive.com>
References: <20260707091039.2574638-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=frank.chang@sifive.com; helo=mail-wm1-x334.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from scalar load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index e47b16a7fa2..cc1b5dbbadc 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -413,6 +413,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
@@ -524,6 +527,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
-- 
2.43.0


