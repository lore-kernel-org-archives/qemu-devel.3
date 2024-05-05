Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68E5C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 07:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3WDT-0001l4-Db; Sun, 05 May 2024 03:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1s3WDQ-0001jt-I1
 for qemu-devel@nongnu.org; Sun, 05 May 2024 03:23:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1s3WDO-0000ku-IL
 for qemu-devel@nongnu.org; Sun, 05 May 2024 03:23:19 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f453d2c5a1so999827b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714893797; x=1715498597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nHvPCtJeXFWgQnE1sqQToo1Un8BEUUeJZwEkr3/R6AY=;
 b=dAZdVGZq0Xyi7RAIyK6XViTOonRoZb4sd7O4EuapFcWiPdmvihXRF5eMdxJ95iWzQT
 yokUQz9PDtM0gVhgTpYeZjuPtD2EHN22aUWjByJTlBU9Wdnl7EfJLrWiJMB+MZFUx7Qi
 qV93dHlsVXoY2rvCgbMyhXAafHU1FzRyLoD3UOY9jyPELLn9iBcLt+o99nxzGqMKn2kD
 l5DtLWV1qNbiVjW6iwad44g63S0XuTkLFH4pgM0LDFbFdfNWJwA66zujxTeR3IRwpEMo
 dKTC6bhhIzad/C3R3yrXUMvSi8Ss6/520Za+v67gD2kKuIscdZQDMC77Mf7/Iv2Bj6ev
 KcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714893797; x=1715498597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nHvPCtJeXFWgQnE1sqQToo1Un8BEUUeJZwEkr3/R6AY=;
 b=cKScIndbstpwLJzMgnRNImrDVkb9/ywEVqEMPpfHaA5RMV79kGUsB77KPhlp1Wm93Y
 zgydHM+Ac+yYJP6t7oGrB4UsnreLD/RLUJc+elj/vTYqQTNq04kcDTfuTRR0bmCoXTg1
 NgHLRk5S/gZ9TwARdRKBTfNNW10sRt2+o5U/RcCBzw6udg6xN9BsX2QWYQctO5qHSuRM
 irKURc/YYMSaoi9yvsUN/OJCP5YJDeJjl+qtcMWKdwg+n/pQc4Ie4WQDNUneq7EtYq8J
 PyTKM3QlxtnKHdr4Oi35xjEyvhnGWL1Un5CzAOWtVGkJhLUw5d6i/JOCxuAlS9GkFePT
 6xow==
X-Gm-Message-State: AOJu0YzmDBrSs0qp/VHB8ZV8iv6RzMhic6Uk09zNgDygAQaitUKB7jgE
 4jxhG7RrMzwqp0yjIp7dFPj5nI9O3FoHIcl+t8wUv4HEuk/lHI+DiFPQ2g==
X-Google-Smtp-Source: AGHT+IFsXJKF+aOxBV7zzGGKdcbjjrbsFcCCflmtaTQ1UdNMDG8tjpuxMw9X7ReJltILLIqtWmG/fQ==
X-Received: by 2002:a05:6a20:dd83:b0:1af:a49f:9826 with SMTP id
 kw3-20020a056a20dd8300b001afa49f9826mr2543674pzb.12.1714893796454; 
 Sun, 05 May 2024 00:23:16 -0700 (PDT)
Received: from ubuntu.. ([149.28.154.72]) by smtp.gmail.com with ESMTPSA id
 w11-20020aa7858b000000b006eceb4cb828sm5651005pfn.180.2024.05.05.00.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 00:23:16 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: qemu-devel@nongnu.org,
	Alistair Francis <alistair.francis@wdc.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng.cn@windriver.com>
Subject: [PATCH v2] MAINTAINERS: Update my email address
Date: Sun,  5 May 2024 15:23:12 +0800
Message-Id: <20240505072312.2776074-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.998 autolearn=no autolearn_force=no
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

From: Bin Meng <bin.meng.cn@windriver.com>

The old Wind River email address (bin.meng@windriver.com) is no longer
available due to an internal infrastructure change within the company.
While a new email address (bin.meng.cn@windriver.com) has been assigned
to me, I am unable to find a way to send this patch directly from the
new address. Presumably, the basic authentication with client submission
(SMTP AUTH) [1] has been disabled by the company's IT.

Switch to use my personal email address instead.

Signed-off-by: Bin Meng <bin.meng.cn@windriver.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

[1] https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365

---

Changes in v2:
- Provide more background info for the email address change

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f08cc528e..d3282ee29f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -319,7 +319,7 @@ F: tests/tcg/ppc*/*
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
@@ -1602,7 +1602,7 @@ F: include/hw/riscv/opentitan.h
 F: include/hw/*/ibex_*.h
 
 Microchip PolarFire SoC Icicle Kit
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
@@ -1629,7 +1629,7 @@ F: include/hw/char/shakti_uart.h
 
 SiFive Machines
 M: Alistair Francis <Alistair.Francis@wdc.com>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 M: Palmer Dabbelt <palmer@dabbelt.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -2125,7 +2125,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
-- 
2.34.1


