Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84573C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 05:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtJ03-00040B-WE; Mon, 10 Aug 2026 01:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtJ00-0003zm-SB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:36 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wtIzz-0007mV-8O
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 01:56:36 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso993566a12.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786341394; x=1786946194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l24jeh6mL402UPS1PQ1PqKY5L+GWjbvAW1P9ttSr/yU=;
 b=gQxjND09LgyaEykbCylVlncdSJIEbovSbXlsd0JGu3m+4I80vX6+qUgizGYXSxUYLK
 a2fPb5pcuEbnlziRuWCbyvgyvmcvp5Bwcpj4YUhSsKLkrjRRuyTlQNej0EdaDfGvUhDX
 FOjfnLct1IDR1LAFkywpmtSI3vW7YlXlkOxqN7jvpp3CBa7XQ4bsv8eLd7SeDde3BBBD
 KLeOQnBpcou6mrYvwX645uaM3pElN0c7b+mgrNvRLWKzVzaST6wwph9OV5oN0KO1iZFc
 MmfOpk0IsVzH4CKVRaSrXyx6yJXy7Z3p+GXdYpSnhKWUJE3SQevwtih7EOP6fc8dqHmL
 Swow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786341394; x=1786946194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l24jeh6mL402UPS1PQ1PqKY5L+GWjbvAW1P9ttSr/yU=;
 b=mBodtBB4O/wUWqTE9AgBggfjOjuNNGfpKQ5AXBmzWycWjqJbBQdkiNtfuI2uM9DVyJ
 9puQZX8AZp3FFsdE+UddXa3XMXt6q+minl7A+NSn07SY18RojCuNjNRDFglR/vC22OOS
 sVzAsH6A0y0wRxEeWgEA3lF9SHmumXL/9heqEjnWTu5T0+0BoGJWgH+F8QcP0OtcLVxl
 rJe21yaBpIyIGJR/yHxXFA1I3kp3TqFBul52I88sfUuvgupgYv/h20/H6lvFrRgY5r2h
 UsulKSpZmjjFkD6AbGnh+I2yBQybBDXuaVwQQPaPcx0grDxO9ACsywxIYdXcdF17wngQ
 /R/Q==
X-Gm-Message-State: AOJu0Yx0TF5bA7YEHSbNJGl8yLUmFgduvFYIfPZw6BweC4oTvzBnPUD8
 l659k7fun6Bra4y1XAn02Y7qEcl6riBZz4AohWz4rz9Qh9838QXlK6nzjBNH/Vt4qNBwAvpfSRt
 LuetKZyzf6DwuKQYGsA3OKGFCSrevW/S0w6mVzKB2GREbpQSLvhCSE1u+/3ngbUOcZqJ/mQaSbc
 cP6QLavoa3fuOhSikKcrbrKdsZQvqB6eX23+9T70i8ezwUeHPR
X-Gm-Gg: AR+sD11gTvTUaSjETNtyW1JZXqf0XDdtNTn5Xdl2qosULnz1hfpTbcJoLB9QKxrNM/h
 Bpw5pchAqflPQrVCS0M6dAm3tcZUFGlM+1T0E1wiODhxPw2gyLmyqd09dqo627DcmJRo9Vm0kcn
 sR/QI/JlhiKljuVN4MfVY9SwK1L3KBOShlD+CRsHSXF2on26ZY2HD4wnIcTgszhXxgl2MkmJQrf
 8wMRe8FclA6Il3yhFE6OzrHphTmsYc/bXK+XvdWCIbb6wfJew/6Wih8iF7c4y0mgC0VOs5pEnAm
 A9MADhcD8cH7oYv/bKUvfu0WQ8EmxbfPmg+hGUnV4hFsbDGwXuSg1izsH3+iqQzi0+1EAoyhult
 PWLUIW9SUtjCKqemYrrzMnFqyufFBYKmE+C0P11KRTJTTx230x1MobJqZdyLToc5DD2IEscKIzj
 Rko/IhOjpfOI2n+KBMySgkl+z9VERO6NflxZn+5+ybvRV0fnkipRvwRGelpM8S33sHG5iyUBmDp
 GG2bLYkx9fL+C8=
X-Received: by 2002:a05:6a20:e347:b0:3bd:3800:7538 with SMTP id
 adf61e73a8af0-3cb85ffdacamr43281927637.33.1786341393697; 
 Sun, 09 Aug 2026 22:56:33 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm39172122eec.1.2026.08.09.22.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 22:56:33 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 3/7] target/riscv: Support raising misaligned exceptions
 for scalar loads/stores
Date: Mon, 10 Aug 2026 13:56:14 +0800
Message-ID: <20260810055618.1175500-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810055618.1175500-1-frank.chang@sifive.com>
References: <20260810055618.1175500-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index e47b16a7fa2..cc1b5dbbadc 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
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


