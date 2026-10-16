Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1632CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWNv-0002R0-H0; Thu, 15 Oct 2026 21:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLq-0000K6-Td
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWLo-0004Eu-9d
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2e940d5d2beso10060885ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112591; x=1792717391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YNC9KovvsCcPFhw1oKBW9JKFDxmX8NTxlxV0Y0y94Tk=;
 b=quwKf8UpeWlsK5IT478K5wSFxMPJAnSSCPA5enErQYzG6S0HJKz8m1mAEo9dvdUhGt
 H14RID+/z9gp2uPIkTVD9wAyJwUiMhZhZL3JMLiKOypgkqH+OaHiP3/WOAFeRAGj1ByU
 vMjFxLaJqnTyxAeBE6tlAsmZLSz+yEAxuwbZszQ1EGXZspYZa7s3eQnv87XDfaMXTgD6
 EEprjak5FO/2RFHYB7igDZoSSWYzQ6kbXqG4e1Uh/dkFdE+a71apx84GwAYINLVXmdzC
 FstRnF5lvsUm87T1B0KM2l9TAcgT1WAGsjsc+L1KmsGmg02Q90fkk67jGxhLNlvhmXOB
 I66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112591; x=1792717391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YNC9KovvsCcPFhw1oKBW9JKFDxmX8NTxlxV0Y0y94Tk=;
 b=PBHnTYew00h2oK3inycJ90j5+B9zSLWOBiYETgRP/ukHVmrGqRFqcazxt2ASLk+36e
 FY8r8PMeeWp7xZGM8BMQKBzdSBezkpLe8EQ8bM19/Y69KVTlfwtUGqHPfHh62kZJ+qDD
 mJtDOHNuaNcBl4XzI0YO3qxJGz1LDGgG44VOBm4jMvQ/8zJFYAPuGSemAWxLH0bI0gKe
 yOagUYd0GIcnIy5JZ9Q+TPfX9/wAoWsUkqPlfXcVZTB8BuLvcjSNORxJ0if5w9VpoYg6
 1C+ffQJJ4JkcEfW86kZAqICrzTbyJIOyRhAY+K9xwpSbMj8b2UQuuNSyEOkJxbRP7Z5c
 Aefg==
X-Gm-Message-State: AFq9FYJGGQaqcbGUpeRZ1yHtdSjsPV8jCMOx20Wj7k1pgfQs1+NS4l8J
 mW15hoWDIuLyAFofOFq3haa7sE2+XCWvudAt8bcMFy0ut8HUbfNacvuWLqkXzg==
X-Gm-Gg: AYBFou2Ksq4TyOFz7AeAz+L68mBbUFYQBQlUzdv5ZzLsIDRkFE74u7lD1hwgEht2ogI
 VjS0USK1HORN7Xk8AAcryfMkuHKha5O4bLDFf6Jk6zhdTwGiBcxFEPxwBfrAUrzyJTBfdXPpUw5
 HkfCQwKknZOnkO4nyfVkTgwyXcGbkh3lwRgOYvEhNiQ5aZGCOKDggKpxvApOvN3U9PUUKq1yaQ5
 wX6PINHsvDudEmjeW+bCWkRLGwbXBWrdhPhif4fwTP55eZZOggD0f9rX1j7AALCohZrHYHKTwB8
 +QxIx3ONoyDCmn+ku5zHMCcNKyTcZQu03h0MRIIE8/8/xefpH4jbYsCY1f4YkQSoUGtN4GTRHk/
 VCWNleynXMdSoaHR3EWEsdUNfv20lGDLlwHhSJqEthTJ3AN65IeiN61UkRQnQrBYosdZOa+2ebt
 kq4AaosSsNPNgsQ7kxUIHNr3J/7NoMadrozuH+HuTz7gzP5HeqZ0O7ezV0GkNH630oBZD+BKM7d
 F+BOBSxwKzfXfj5
X-Received: by 2002:a17:902:ce91:b0:2e2:e0f8:e57c with SMTP id
 d9443c01a7336-2e842f20970mr172447905ad.70.1792112590800; 
 Thu, 15 Oct 2026 18:03:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 08/50] target/riscv/kvm: Preserve VCSR across migration
Date: Fri, 16 Oct 2026 11:01:55 +1000
Message-ID: <20261016010237.1102834-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

The vector state sync handles vstart, vl and vtype, but leaves vcsr
behind.  vxrm and vxsat in the migration stream are therefore stale,
and the destination does not restore the values held by KVM.

Read vcsr when collecting vector state and split it into vxrm and
vxsat.  Rebuild it from those fields when writing vector state back.

Fixes: 3ca78c0689d5 ("target/riscv/kvm: add RVV and Vector CSR regs")
Cc: qemu-stable@nongnu.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260831074106.1798671-4-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1993bd446b..45ad5e1525 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -910,6 +910,13 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
     }
     env->vtype = reg;
 
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->vxrm = (reg & VCSR_VXRM) >> VCSR_VXRM_SHIFT;
+    env->vxsat = (reg & VCSR_VXSAT) >> VCSR_VXSAT_SHIFT;
+
     if (kvm_v_vlenb.supported) {
         ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
         if (ret) {
@@ -966,6 +973,13 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
         return ret;
     }
 
+    reg = (env->vxrm << VCSR_VXRM_SHIFT) |
+          (env->vxsat << VCSR_VXSAT_SHIFT);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
+    if (ret) {
+        return ret;
+    }
+
     if (kvm_v_vlenb.supported) {
         reg = cpu->cfg.vlenb;
         ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
-- 
2.55.0


