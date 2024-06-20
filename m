Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C57BC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 06:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKBa4-0002Ur-W6; Thu, 20 Jun 2024 02:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKBa3-0002Ub-Nb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 02:47:35 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKBa2-0004Jo-6b
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 02:47:35 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b4fdf56903so2426046d6.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 23:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718866053; x=1719470853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XXZPwB/KCQGzcH47VzVAAPMuBPHuKn5n1lAk8lM+KDo=;
 b=LpVSwcwMNp664QQbV5wDaP7RPtS18XGnGfwZS1MHIRbDSAhf7guKJPqy91rfSK3M/C
 vNg2c5RDVnYMHR2pX2fwBGEY84xVyzQZAN/exO8hP9U4aOwvKit3/xAR03CvJu3SeBSO
 Tpyxmlx4mVq8JjtQ1Y9nAdO99zdKq5Y/0c1BXaoMKrAy2cFt8+qadxhm5w6BsBNu08Rs
 pYfCGkYCxDB1IF3OAhiAh9XCdu8NAumdLnSU5Cu1vg9xTUEcUbAFUdr1lv/9GJdz4b48
 GsuAs6UvtJ1Rp0zWV8JuU2jtRfRyZ+vZFat0lOU+OsuiQXv/wLOoMN8MUtr5ZyHsZSQi
 uh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718866053; x=1719470853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XXZPwB/KCQGzcH47VzVAAPMuBPHuKn5n1lAk8lM+KDo=;
 b=QXDJTeDguuJ9as7WRLnzrZvJAGzHo+rR8aB4zvHm1SyTZUplUvEybINyHuJSH/yfKz
 ri5Lk/AYjqBrS8Ugex9dP5JwFFKwITjzHEl4mPGNRefIfBGp+8YOv3S8PEgXXH3yL3zc
 ZjoML/+MjO4YsaEykhxaNexkFizXpFzowy/bKRNT34p7evAqVVQBccdKxNMiYEDUCCFW
 KNaIja6fwbdBJj/ilC9QzKZmvcWCczrCrW+vUdtVWDPZ96VdTu2NA9j02VSKIGk+vwUH
 QcFGErXuYlvI/quPfqSPxe/tD2+33y9H0VAyS7xUrvcUuamfXE/KRqTeW53NARVZT4tq
 7Xjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcH1JBV77QFFGEGbSEco9FjzD860dVIkdUC20iPoSgpVPSBHgY/TfaaXPj8U69evqs7nx7/8zyoHP54aP+LtQano/+rKo=
X-Gm-Message-State: AOJu0YzHp1ot9I0QNv6QmNwpycyreTmjp8OkyO5jb8fO+cC798SAuHqH
 yM2FAIs/1taH86uFuGtQRpEREk9S1cgBHWGGa/wzjvuV0osPb2I0xddztj4eQro=
X-Google-Smtp-Source: AGHT+IGjryhrJtkn68tTwP2D3tYbf6mUBAftzPdslhAA2r+4zgccBimycDAs8kMEBambnXWWk1s8vQ==
X-Received: by 2002:ad4:5749:0:b0:6b0:8abb:2f29 with SMTP id
 6a1803df08f44-6b501e9cd38mr68600136d6.44.1718866052910; 
 Wed, 19 Jun 2024 23:47:32 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c68ff3sm85144666d6.74.2024.06.19.23.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 23:47:32 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] hw/riscv/virt.c: Make block devices default to virtio
Date: Thu, 20 Jun 2024 12:17:18 +0530
Message-Id: <20240620064718.275427-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

RISC-V virt is currently missing default type for block devices. Without
this being set, proper backend is not created when option like -cdrom
is used. So, make the virt board's default block device type be
IF_VIRTIO similar to other architectures.

We also need to set no_cdrom to avoid getting a default cdrom device.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8675c3a7d1..b0871b7f81 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1764,6 +1764,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->block_default_type = IF_VIRTIO;
+    mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
-- 
2.34.1


