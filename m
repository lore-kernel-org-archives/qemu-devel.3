Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77184C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYj-0001Rd-KM; Mon, 24 Aug 2026 01:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYH-0001Fm-2v
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:59 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYF-0001oB-Iu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so2590162a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550534; x=1788155334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JtX66qmQh5hGei4ld9cb4CgJsixrU426wPgSFrendcA=;
 b=R7uQ1FUArodN6dPBLznR+KqZ7iNXjZNHF/z3vNbmY+iLJlLH2BfFCnqGjKhTrYiqwC
 c/glh9qkhpaIqUdJq2WBF9DyWtZercq9R1ss8Oe+Pn7CsClOHQEU3pzxjlXJdkeUFbbg
 6PgtkxoMe5dJg8eWkv7BJuKgMdDSq5WF8WA/RuSzLooFJMJcz9wQSr4ECJYmA+9DAaLM
 lFqNOJ1Gir6oR5k4wWU1tTMElautxniCkFGgNrYhi2K5GtESPMA3SCvuw20U77trFUr1
 sN5iMyZxAaUTFjHI7OJiq9Ww40ynXNHpxarcGXcC/sJm1ES1f4L8Qp5SEHA41a1AyOhs
 b5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550534; x=1788155334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JtX66qmQh5hGei4ld9cb4CgJsixrU426wPgSFrendcA=;
 b=h9Rc1zu31Xr6Ez2l/ifDrtq2bV3CmP5wIZfgEKjBqoYllRuBt1T+KVB0dGGiKE8RR2
 U8JAog93rxCV6qI1qfElO/klrXvgucgkFyBJygREYe35X0q/0HAF4rg/UvuN5PrLOsl+
 9bRmOcCP3CHTCG7J6MAELj4m/iWfSxYAWJVpBEY3Yltirql2I2tuODLVGbeMWD0UlrQO
 et5YaFynv60DegBIFl4P/LVd1a9qQdbNAFnTeRn3YFJkNL7c/SRvp5JOfm5mDTSYgtpj
 rk8MlHE7xDSEaTRMwJ5fAen+QRYLzikUUApeiD2tpPR26J7xCKuMYuBeCKM30xbeKUNc
 5M7Q==
X-Gm-Message-State: AFuF++l2ombWjqUg94ukuSFSCJKBwqSzZX1KUzpW9XaBCQycOSCIc+sx
 t3lEnBYUwQrba3HEiAB+W08sIcQEaF8xgK8tqCf9VnLTi8vjg/fFX1fn+MYs0w==
X-Gm-Gg: AR+sD10sf7r7/OCjlfpbrAL7+n9i/Ya47zld8c083oYC0V2Hge5dVkai4bQP0jx3QXi
 4LQzqf55hccwUd0wCQAff7Kn5eXijdIFZsCrLLqSZ+tLxps91PYBr9o/4sbz4H+BlK+hw6s5NCA
 Mb3Kd2ITOTvFTOy1C79xlIV3ejjpZEALrCkSuGNvObzaURZXducfz3eoDGZRPTUjt6ZQhFsK8e2
 W8XLVbaAfTGEDvfvlOpYM99vhWkFPEu1I4u4iv+X0LWmvGIHbzK5FLLzBKscNgPy04IT75b/Oxw
 e6KbXWVAYn1QQ6WrN8bRADp/G+lCupt/rIoslk0dh6ufZMOLJTbFh1CZDnQkILe27HZyCPPuuNi
 DfzjSen0IR/tzdVco7VJ/03GhpwWz6jZ0s87q1TH5W+fwreuTipQYPVtFH3RJ+Y/L0/IfOwT2xG
 kYJYO/n2CtpzUzY2KbKbtouAN/yrqVR9GyJa5dYLW8jPivvgfbeT0iqkQP+jPEw60KVUKr8zN6f
 i5qIA==
X-Received: by 2002:a17:90b:4484:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-395c3552988mr36242089a91.14.1787550533890; 
 Sun, 23 Aug 2026 22:48:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 11/96] target/riscv/kvm: Synchronize privilege mode
Date: Mon, 24 Aug 2026 15:46:41 +1000
Message-ID: <20260824054806.2790041-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Xie Bo <xb@ultrarisc.com>

The KVM core register synchronization currently omits the vCPU privilege
mode. As a result, env.priv can be stale when the migration stream is saved
and the destination can restore the vCPU in the wrong mode.

Read and write the KVM core mode register together with the other core
registers. The generic RISC-V CPU VMState already carries env.priv, so no
migration format change is required.

Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260808125157.1220511-2-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 97069bf597..f6ddd0db9b 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -603,6 +603,12 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
     }
     env->pc = reg;
 
+    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(mode), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->priv = reg;
+
     for (i = 1; i < 32; i++) {
         uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         ret = kvm_get_one_reg(cs, id, &reg);
@@ -628,6 +634,12 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
         return ret;
     }
 
+    reg = env->priv;
+    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(mode), &reg);
+    if (ret) {
+        return ret;
+    }
+
     for (i = 1; i < 32; i++) {
         uint64_t id = KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CORE, i);
         reg = env->gpr[i];
-- 
2.54.0


