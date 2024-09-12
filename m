Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112F2EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPU-0000gx-4I; Thu, 12 Sep 2024 01:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPR-0000XO-Bn
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPP-0002zl-Hh
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:25 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d606726cso313550b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119022; x=1726723822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xl2u8VSlAsDXatryQRsLfhflFKGJFdFrYq4cRLhSKls=;
 b=GciZP3ue3ve8iLqrOTH8D1bA0YFTY/H+C35eTMMtCJrYj7v0r2Izih/2D9/Yikmw16
 vRopy2LOZqQ49/gR5Io57TuFzCeP6vmm1DlN1qqf671Q+k75GKQWzxJ/PquSU92Ow9D6
 lUDkfCRmtpDysnrtIltnkGfA/cWec+Xuz6qpuuawtMdmr9hBZD8vXZp8bBlsoJXryuU8
 zm2yM8d3xLS4ijOLT0eMSa/CbOEFz6HUuQ+NHTOPC1MlwnfFJIESbtKQUaGOqtzlZNkj
 lS0665NAid4mZstxnVnHyJFxO2AJvuk4BALYiLfr/gDQdTi25N2rA5ojSIByaT0WlXHu
 w5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119022; x=1726723822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xl2u8VSlAsDXatryQRsLfhflFKGJFdFrYq4cRLhSKls=;
 b=ZbAEdmMZQ6sApbCoawbGr9bXRBZ3FaWSBUhTBu9IkE0lFW2/DFVev8NwrnIb+UTCUi
 kdSh08Hhqwhv5CPQXxw3nVr7ryahlfCbva/EgZObGrTusZWNTuJxTpg4FtqEh0cSRN5P
 gWqbCIGM+hSSavoFWLMK5Y5dzuiAFtmS2rA9dqNMhLra7LCoR9zqBhC5slS50eEzWTfa
 VzdviJEu4/MiuP8TZXFUIlKL/eBulMuzIMfBivvh/xQ7wDR38yIxfBYklT619ep4TtEQ
 amEpSROkylqKcm5DWzv+mH6gNrOj/V3mTnQSn9eID28xuokjFr6HnPMi5unj8/TYx8Jh
 +3KQ==
X-Gm-Message-State: AOJu0YzVAMSzXgkMFjtOPKtgn2FCLk3jrgQB+HJWPfuo36lHXDbunwf8
 v7dgKmGDQNg5Rj2uG7lwA6mv8T3eYl7VwbSdZX95mEMAvsFaUWwfZdqGow==
X-Google-Smtp-Source: AGHT+IFO2Kb3C6kauazbiL2J/6MLPd4fk7ySnx++j35LzCP4/rGP+jzuuR1/CJY6/cVwxp9ju3DHfA==
X-Received: by 2002:a05:6a21:3305:b0:1cf:3996:744e with SMTP id
 adf61e73a8af0-1cf761e559cmr2048548637.39.1726119021323; 
 Wed, 11 Sep 2024 22:30:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 07/47] target: riscv: Enable Bit Manip for OpenTitan Ibex CPU
Date: Thu, 12 Sep 2024 15:29:12 +1000
Message-ID: <20240912052953.2552501-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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

From: Alistair Francis <alistair23@gmail.com>

The OpenTitan Ibex CPU now supports the the Zba, Zbb, Zbc
and Zbs bit-manipulation sub-extensions ratified in
v.1.0.0 of the RISC-V Bit- Manipulation ISA Extension, so let's enable
them in QEMU as well.

1: https://github.com/lowRISC/opentitan/pull/9748

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240823003231.3522113-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f93bf9c221..fc3f75e826 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -701,6 +701,11 @@ static void rv32_ibex_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
     cpu->cfg.ext_smepmp = true;
+
+    cpu->cfg.ext_zba = true;
+    cpu->cfg.ext_zbb = true;
+    cpu->cfg.ext_zbc = true;
+    cpu->cfg.ext_zbs = true;
 }
 
 static void rv32_imafcu_nommu_cpu_init(Object *obj)
-- 
2.46.0


