Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4C2CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNS-0001lI-4D; Thu, 21 May 2026 20:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNQ-0001k9-Ha
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:32 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNN-0003P3-LY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:31 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ba1e9d3687so43975595ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408267; x=1780013067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fqcdit+PUKxccRcVTft913zAmTljnBCDO4kQsS13OPk=;
 b=WSKq9JfYg2G53L4e5ItrhLv67gcwvEprhfH9r5JSjoU6QnHjf2mx4C7//BdaCLGbnC
 NBsx6XOnhPazK6jb7H4aVEnwT8p3bvUPlQe9KGVBFMsbB+JD5XnKwvmVOIgU35UtZWOe
 ViMY8RIiFHfASKMSTafEFxRMxnWbQNQsxvfQ/vqs2KYag1cWGDRYokVGgaZaqRfboJl9
 FbJ3/Tyzbs4B+hNlfCUvTIar/MmgJGgSv3c5qJ9qtiyLAFJtoQg4YjoqcshbIe0yiDkl
 hSNEz3k8vqcUR2nGwfXfSHO6iViONOMKb1DLPi97SXkc1hO31yuZ9O/5avj5Mp6DV7aL
 LaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408267; x=1780013067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fqcdit+PUKxccRcVTft913zAmTljnBCDO4kQsS13OPk=;
 b=RedEdCWnGS7IVznZ6zFNhPFbWB1MqN7dLw3uA/qBIWvwfGRezVIMMzfqm8T3nhZJgU
 8RWdPcjhFP6xZum+7/eHLODzRJ0pPSOkARwhLF3hHBbkxBo/DflUM6or2rbK5lcxNefD
 w/gMKZ9X97NpWeawXRmR6aqu4CenO0M6l0w17bwNgyc/ejI/NCfVmLDAVs/DJf1emkJQ
 TCpS75F1pKR6iT9RnzEFB+bDw7Tx2HkzGUt+ONONPoYXdgi5Di4Kh52E9U3TNbzjgnuR
 1eoum7e5dFXa1Gh+9z2WqBNr2cQCTrQdXFoIreCQo8CiZABQdTAGaoZPEyk8kRBeKJ/d
 4FcA==
X-Gm-Message-State: AOJu0Yz7ksjVkvEzF/n5jNfUjtHXpAXw44VdzGI0piFUFr6jhF1CXAD+
 zL84hmGPswRQFkupStIo5Gscr9t0VHJlURp7Z7ySk3PxAreLjzQALeLjYhMnTK8X
X-Gm-Gg: Acq92OHKUBU1kfZG51k/9fjmEwpDIufCIIT8GBS8r55Kz7Bd+HBTvshMSj/iJmLqh0h
 YXfWHhkzUcHnP3ZmhPaGkr4GrA81R7EjyDARieyJgvu47OTqvpJsg4c7MM+ppYEDnMu8b9oyEpk
 Q9mG9EYb3zR9PrRUunPeww8MDJNNttzVYaxNjvJ6TiDgCSPzqlpmb2G3EexbGzGpjHP/xLgLL00
 TeWp1IJ1Xl8SgHsELe4lVYlC7QzhwD+pxZu0Os2xUIVy0XnM920PYFfag612XBEJxabxEiFVNGE
 K032q7MDfmoY2F2RjpqmMHpmiTbHheVcpcWnc3VXIyzlBBDseOez0eWLOtyq3RGTQZWni6TpOT1
 okFqm/5QEkqXO1doTPI42WJwkatek/ZYt35jF9ASXxv5IMBvt3D60y2he4DrTrsvCnRsxRkMCpl
 btYibHmYPNoU/o8xyPpzhTV0BH+W+91+byYgXyEJD7Vg==
X-Received: by 2002:a17:902:ef11:b0:2bd:d7b5:83ed with SMTP id
 d9443c01a7336-2beb07001camr11377495ad.39.1779408267352; 
 Thu, 21 May 2026 17:04:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/48] target/riscv: Fix missing CDE check for scountinhibit
Date: Fri, 22 May 2026 10:02:52 +1000
Message-ID: <20260522000324.23255-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Zishun Yi <vulab@iscas.ac.cn>

According to the RISC-V smcdeleg specification: "When menvcfg.CDE=0,
attempts to access scountinhibit raise an illegal-instruction
exception."

The current implementation of scountinhibit_pred() only checks the
hardware extensions (ext_ssccfg, ext_smcdeleg) and virtualization
status, but completely misses the runtime environment configuration
check (menvcfg.CDE).  This allows S-mode to access scountinhibit even
when the M-mode has explicitly disabled counter delegation.

This issue was discovered by the SpecHunter tool
(https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2571/qemu.txt).

Fixes: 6247dc2ef70b ("target/riscv: Add counter delegation/configuration support")
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260508174917.371667-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e041f5c16e..7ba4f0383c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -398,6 +398,10 @@ static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    if (!get_field(env->menvcfg, MENVCFG_CDE)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
     if (env->virt_enabled) {
         return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
     }
-- 
2.53.0


