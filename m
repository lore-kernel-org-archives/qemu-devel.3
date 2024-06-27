Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279ACC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxK-0006i8-AM; Thu, 27 Jun 2024 06:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxI-0006Yb-9x
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:16 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxG-0001ii-Lh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:16 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70698bcd19eso2194700b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482532; x=1720087332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsLiAHFyCsutJDc2599A4Vu0YvGo61TqCblpFBlIdck=;
 b=U69pmD2lBQfTcJozBSpCx1h2CJkKbJy3R8xznx2YmnodboNo5s0SoXFeJNs5Ipr+K1
 Jp0ehn/fxbhk9oZr7MfW5KwGlziWYoyjeeNOD2clC2yyF2N08WGI/0ES4MlYxUytPgKa
 5j/fNaU+lTJBNcI4oc3l3U6jEdBueK6buRwjJuSyk8IPW4B717jx5xhOIsuOcFfmKawJ
 5ZZtvcFskASerC5J13bncOjQEHLtwC0bXuUBsgx+pKDUR31XDtEGJuxofqQe5Fn580ZY
 64IwSoI5r3Ra5l01Y9kRkz3Iu7acjJF7obMVqaYkobwTVZAgiTOTe30DycZTenhhHixN
 PXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482532; x=1720087332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EsLiAHFyCsutJDc2599A4Vu0YvGo61TqCblpFBlIdck=;
 b=xMUMSez3g3vDgXnhtGaGNhl6YZk/WGkOdlXapQKMzFBRxzqnjD+dFxm6r3K8tDra5y
 xuwoZKdJh4eL77OB4BGyEybOKwYl6pEHkDfHTqYfXb8BDjkYF5c/5nv6njdZW9qhXVcW
 neeY7PB63mKEX14LC7Pw+Vrk8adxTF89TJPVwatyFBZfvVwVo4ENC9rpwGhaEoM8O9kC
 WLayy/rPIqsqBWuahlqFNc59fCpJ6VhLOLqOWu4hn061OjSJfdaCWWpy9pNOni8lGkjG
 0OnbxNnEsVjN6IGUScn2527v5ekVOmAfrSgN1hV+xnhviF033mUlFGuOO7zq+V6XwDFp
 lx0A==
X-Gm-Message-State: AOJu0YxsCzi3xqNtpYcObGlkqvSavrJQx2nLH/V/ST+dvLFqKPMq/qmA
 NhYdxp4vbHTIJzbIxHY6ASxJkB1lqHi0xdsHYZ1hYrquhC/XSzmQMJQuV1Y+
X-Google-Smtp-Source: AGHT+IH9IJrxKTJsMDGKvGKulwVzNLPAtUGlNCLckZC5UBnfGaMyeLlO1z0jX7uz1WFsxeAX4C6ZqA==
X-Received: by 2002:a05:6a00:2195:b0:706:6c38:31f3 with SMTP id
 d2e1a72fcca58-706745830e0mr14179622b3a.8.1719482532046; 
 Thu, 27 Jun 2024 03:02:12 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 21/32] hw/riscv/virt.c: Make block devices default to virtio
Date: Thu, 27 Jun 2024 20:00:42 +1000
Message-ID: <20240627100053.150937-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: Sunil V L <sunilvl@ventanamicro.com>

RISC-V virt is currently missing default type for block devices. Without
this being set, proper backend is not created when option like -cdrom
is used. So, make the virt board's default block device type be
IF_VIRTIO similar to other architectures.

We also need to set no_cdrom to avoid getting a default cdrom device.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240620064718.275427-1-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9b648540e6..bc0893e087 100644
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
2.45.2


