Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6705EFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJrH-0006o5-Q8; Thu, 30 Apr 2026 01:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIJrG-0006nN-AC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:22:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIJrE-0006Tl-Kx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:22:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so1945455ad.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777526559; x=1778131359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qsx1QIAc/fip1C8P9UoUWQBPMqkBxNS68mnLjoZnVdI=;
 b=Rby5tlk+87ECStdeXJHMfyN00S8YMyuYNRUA6Cr2YI8VJrN8Cyj9Bk59h9miZFSUiA
 NEoC3UKo4aqMQrzMiS3864l/yZzgQ6M/OWRU1A+XEfpnI9DIgvgQeBt2mKdpVaBDYtGQ
 t/4BrQoAkSWBPTBywkMF0yxKHHC/YFkyFYcEoX4/WXLBcOaEbSV5SU3z9J3hkXyKDRbU
 bbdQ8ZqSXcGrZEirNVzDaEctWEnt7oypI+Z+foaGyIp5HmVNBdU4+FP34UIzm5Kx5ebQ
 tPfWOtwwH7fa2mPW46Y9NKSKixM1qdBkQDs2cBh1q/0ny3KJlmEyJLazzHNm45S6m4Uk
 3vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526559; x=1778131359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qsx1QIAc/fip1C8P9UoUWQBPMqkBxNS68mnLjoZnVdI=;
 b=l74uFS78N35npgU5s4rkdMAawzINC84kfaJFHqkLy7RnrKrbFrurVZcM/Eb7XcsiEP
 DCONZHITDqHbZRLFyHMTfvNp9+enesFaCm0jgoShrG5xw8hJKeOO/8e6FgqTGPLsdgk7
 8z4XunI278AOpzFIMwa2gFPKhP0RTC8zgwE/01plzOzhIWgM9lqfYWh/Z72DtsC7AclZ
 QF85EtC/MwbFAxWoRFX5DMOj8rtOZJFAcyj6RUxRIfNAtd2ZwZUzxKvko3tbzASbtoki
 D/6F7DDxsFoe0XkRqTMUlEVYCDSVuNY7M7V/+mBWJI04G4aQFJTKDvV0UxLm2sz7A5K1
 LRFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aa+Z4m2RD5icylRzwJkWCRign7vVqsLVi+fC/9mE+1eQ1v0jaXDfh4w3etkpHwUKmCIJMjSlWQhgV@nongnu.org
X-Gm-Message-State: AOJu0YxjNher5D8zdlO8HWjXbKinu9c6wf43J05FQSb5RKZq2Vrubv+I
 +FEPlIakVUxYoVHvbcvv06KTvziXQkeUGKlK6dSyhx4lTsg2qdhADT8w5ozXqQ==
X-Gm-Gg: AeBDiev9N8NNpUrTIATkpYYYHH5IuRfhVVMw1o0YDDf7yzh0P+xP2PgvXNESNdAeVBT
 8ljygn62oKzVDiWQPBHniINrDMT/ucwm2zCtLJpE3dQSW5lPDvIer5zTavgXXozJkrrngkg0ZfH
 3R9RdrWAtkyx9ry9jQSVKXOoVMEjkSrRenPSf7q4bl3HxTTZsfkaAwSJrRJzOkGx6vZjrJT9Ufe
 trrkuB8WMUwaE7rWMpq73jJt2G2emLd5GGGNpTISh9NJhbyoiBcu4vKPLH8QRmpozIv9kydM4tZ
 +l3V4mofcLQ2tZvOYRLZ3RQi7A/+3rgrsMAY/SYWV6exyvfEEabcDDBswZ5uilx7EAMWujpqa0k
 L48xC5634nb0Dx8e//VgHiouBcCuorYcjab/jD72fuDoRRaadj/Jz7m+4Ppo+Kfk47a82DGJkDQ
 xIWJje3OD+puc/TKTvFKqCVTgefjdmeUHh4COAVXfVr9nazH0yK/nk
X-Received: by 2002:a17:902:9893:b0:2b0:7d3d:756a with SMTP id
 d9443c01a7336-2b9a2505ed1mr11932485ad.35.1777526559217; 
 Wed, 29 Apr 2026 22:22:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988985b52sm38934965ad.75.2026.04.29.22.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 22:22:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] target/riscv: Remove spike as default machine
Date: Thu, 30 Apr 2026 15:22:17 +1000
Message-ID: <20260430052218.771358-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430052218.771358-1-alistair.francis@wdc.com>
References: <20260430052218.771358-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

In QEMU 10.0 we deprecated the default spike machine, let's finally
remove spike as the default and require users to specify the machine.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst | 19 -------------------
 hw/riscv/spike.c          |  1 -
 2 files changed, 20 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 10de10dc23..f3622dcf93 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -282,25 +282,6 @@ firmware is available to boot it. It can be replaced by the
 ``ast2700fc``, another multi-SoC machine based on the newer AST2700
 SoCs which are excepted to receive better support in the future.
 
-
-RISC-V default machine option (since 10.0)
-''''''''''''''''''''''''''''''''''''''''''
-
-RISC-V defines ``spike`` as the default machine if no machine option is
-given in the command line.  This happens because ``spike`` is the first
-RISC-V machine implemented in QEMU and setting it as default was
-convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
-and having ``spike`` as a default is no longer justified.  This default
-will also promote situations where users think they're running ``virt``
-(the most used RISC-V machine type in 10.0) when in fact they're
-running ``spike``.
-
-Removing the default machine option forces users to always set the machine
-they want to use and avoids confusion.  Existing users of the ``spike``
-machine must ensure that they're setting the ``spike`` machine in the
-command line (``-M spike``).
-
-
 Backend options
 ---------------
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 35c696f891..87fe0f242f 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -341,7 +341,6 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V Spike board";
     mc->init = spike_board_init;
     mc->max_cpus = SPIKE_CPUS_MAX;
-    mc->is_default = true;
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
-- 
2.53.0


