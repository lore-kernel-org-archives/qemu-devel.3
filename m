Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E90C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzV-0000bL-Op; Tue, 04 Mar 2025 20:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdz3-0007Zh-I2
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:46 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdz1-0000TC-VS
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:41 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2239f8646f6so64313095ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139738; x=1741744538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3zuvc+TIwfGC7tGTY1ujp7Iyzr2eu5EHoP7COySjgo=;
 b=WPFSDxUx4+jUcygZ0u4opqdH0Cu4CjN/XgXLEH2ZSnwf5AGCOnBSMa5eNoe7GcKDHZ
 hOFHAQcXeKGmAz3NoH5wzfYOnu7U85yMaTGBnJ7s8tYj9PYgIQJj+57Xm10TQV3gPnpB
 WRWUoIQL0J3ygBe3gb7hyd1Z2nAAxgu/AFJ3xzqez8D2mz+NvQG7kh7CrSmDEEpBBK1l
 QgV2g7NhfW5TycEzxoidRMGSUIdefFD4qr+9bShWkm7j46VfQZIQ6N0i7qCIzu3QKPkN
 yHgPgGuXBcbViYaiUY9f96BwYrJ2IuWGhW/0iaDydjJvIZzoN3pww2d8/mq/kQwxk2ds
 we4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139738; x=1741744538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3zuvc+TIwfGC7tGTY1ujp7Iyzr2eu5EHoP7COySjgo=;
 b=nSpX3UNmrwzCfwtknQCVlRHQ1L/O9slrgWe3wlANNbaxyLF/vkLEao2UoAWIk2Yf2Z
 tuvn5ijpwtLSEKQKIuz4SU9qjbqINGTGoBV+xjpTjwU2RgTO56kFbrbAbdCOx4fKcbnr
 ZZEbfjG1iDVKxZjKOEwSwydMAdl/RuhKNlG6xBxE/3WL+/250yksqagnhIwbW/hg8D5P
 dYDcde9yhEXYN5qKiX/KK4NpUR7ya5uaJgUBy7VQc663GtJ94do4r0SZBrbq7HOFaDHu
 K6T/y/t0CIKwsB7E56y8OLOKotlYuiMXvF1U2abrCV7brrV7eAvSpbbgeqg0QaGrAlLt
 3Fvw==
X-Gm-Message-State: AOJu0YzIVuAi3f/XyZtRj8XUF3x0/bZrkPH6lKUMqwWnQGwvnuitQl4V
 iuRu8qrSwDdcu87nu6kf74EfweaiteRlC+0FE6ER9iPgQYst3FfFA5seuiVGuIQ=
X-Gm-Gg: ASbGncsuGYhltMLBHOJIELKP1Rlr68mAHA9RsWykw1OEwJueK82brRDYSKpeqbTTEF1
 CI0vDAsmQZoFpf4/qmjrmG5Npwo4GpDf7Ml3mTl/iKWWAI+mWxKCaPOj9Jx5XiwfCijAJ1d4i2Z
 xHzomGtdP2CY4AiChvsIG0XdKxw1Rb+BtXIESqOhAkU90RDJU/zPPviXRmdfCzTtY8CPL4dV/MB
 Kb/pkPW4COVec689KZBSq9rw9slCnzTVlt8Q7RUJgeRTpV65TdJFM3Nol3Re7K+qnWx6snmBahe
 ibivy8GN/jk6BaVMI9qPP6StI9xZQtOxgQ2mE+ZuQmhbHAGszd65gskVhm1MzYoi1bguAdULlZO
 YHrQLrEzIgn5jZ5Pq4K60dJvcHbdG7lvMUWklJjmf1ri/AkTr54E=
X-Google-Smtp-Source: AGHT+IG7niash8CzsEgFsFDPMMChksVmExG1JyYiTOo3zE3YBSCRrXqdD/rV8ReJQXOLwxWXxzTN7A==
X-Received: by 2002:a17:902:ec83:b0:223:669f:ca2d with SMTP id
 d9443c01a7336-223f1cf1fc5mr20681395ad.35.1741139738469; 
 Tue, 04 Mar 2025 17:55:38 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:38 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/59] docs/specs/riscv-iommu.rst: add HPM support info
Date: Wed,  5 Mar 2025 11:52:57 +1000
Message-ID: <20250305015307.1463560-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-12-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/riscv-iommu.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index b1538c9ead..000c7e1f57 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -82,6 +82,8 @@ Several options are available to control the capabilities of the device, namely:
 - "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for 'BARE' (passthrough))
 - "s-stage": enable s-stage support
 - "g-stage": enable g-stage support
+- "hpm-counters": number of hardware performance counters available. Maximum value is 31.
+  Default value is 31. Use 0 (zero) to disable HPM support
 
 riscv-iommu-sys device
 ----------------------
-- 
2.48.1


