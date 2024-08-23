Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BB2C5320E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 00:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shIEO-0003JG-N6; Thu, 22 Aug 2024 20:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1shIEN-0003II-PN; Thu, 22 Aug 2024 20:32:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1shIEM-0006GV-67; Thu, 22 Aug 2024 20:32:43 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-202508cb8ebso10451925ad.3; 
 Thu, 22 Aug 2024 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724373159; x=1724977959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eVzlHo28SvcRqidT+WXmfYjstBlQbtXfW2i88eMT/lE=;
 b=kUdHEWgCOCu5wajsVD2ZD+DoQzIeazZ+TxqO0YLyNDlZmr0wWQvyNKzA79ObdIuwg9
 +3XS1uapdKvBMlp51vI/n2MS+chxryXbWq4lQkXMNGPzDJK2Cm0xea0yOTDYTTh6+YJd
 DAZex25+Hbt/Euq03VOmrHWEXfHPyl6H08cctKtHkcpMV1Fm0/4KHqwEDLHL7aLhckSS
 Hm5LvdzlW7qTseFeDFHAaiAuq4bFg6/ASncrHUt0dj2x/aDgZ8hv9i40Waq8cxyI4y/L
 20aS9B0xABv9gye313znM5vVeb6H2XEGpkkRGq+MTHaRcvTiyE+AGm6KAHH7E1sKHD1P
 fORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724373159; x=1724977959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eVzlHo28SvcRqidT+WXmfYjstBlQbtXfW2i88eMT/lE=;
 b=bT9fdPcRnAgZRx4EcY13clg9bMjUkq1jbv0ov9KSCjmNuYoKU6+hGmYcXOMX8zcTTe
 3jHQtHK25JqiRpfSSe8HRmQYbkRXZs169N+MuI8YaQWKdDBsidAtu/t+beISbIGrSI5H
 Csh/Q3nyN/xyqM2CnX1OJujD6KJHwsQhNNaXqAow0HQllmv2GYduT6s1TThDtABJU7rE
 kjqpjrsgjt2gXCqyRRTqRYJbSoLF9uhWspOdRUwpFlsQmCi7bAxd0ZgvJGOZaQdv2DOb
 uoz1nWBcxBKAd38qRRzZarO0SVbga4jY4wBqjjNX++qkeFseuW0hhQjwjL6ALPVbT06t
 9KUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuTS6XtXMsJI4c0wdXIXl6S9sEywAIeA0dro0dbL1sEDSgjYIhSHvWDxo1m7edvUXhUqIkb7YnzWTi@nongnu.org
X-Gm-Message-State: AOJu0Yz/2ll3u/opgqhtElhXlw3PfOFsEyBV5/u6LIgIkSGHEIt1QIpH
 2bKtaZvua/ubIe2Qh+2U5c7TGTIO6sCu262J16DXpuRBEMMyvxWmwba26A==
X-Google-Smtp-Source: AGHT+IFkZEQEIW1nN0sUbbsJzOQ06hVkebtK++gQt+Zog4ix6gLv+mRWGyfCNcgXWOcPWskT58w4ZA==
X-Received: by 2002:a17:902:fa0f:b0:202:244e:a0cc with SMTP id
 d9443c01a7336-2039e5595eamr5576355ad.45.1724373159327; 
 Thu, 22 Aug 2024 17:32:39 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855665d4sm18175755ad.22.2024.08.22.17.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 17:32:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: liwei1518@gmail.com, atishp@rivosinc.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 dbarboza@ventanamicro.com, Alistair Francis <alistair.francis@wdc.com>,
 alistair23@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target: riscv: Enable Bit Manip for OpenTitan Ibex CPU
Date: Fri, 23 Aug 2024 10:32:31 +1000
Message-ID: <20240823003231.3522113-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The OpenTitan Ibex CPU now supports the the Zba, Zbb, Zbc
and Zbs bit-manipulation sub-extensions ratified in
v.1.0.0 of the RISC-V Bit- Manipulation ISA Extension, so let's enable
them in QEMU as well.

1: https://github.com/lowRISC/opentitan/pull/9748

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3ba..7e13fb2c0f 100644
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


