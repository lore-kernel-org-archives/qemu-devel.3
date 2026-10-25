Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693F606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DPzlz2/0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKyiM-0002MQ-FW; Sun, 25 Oct 2026 09:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyi6-0002M7-IO
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:56:32 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyi4-0006Xr-Qo
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:56:30 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-36681e85e87so575105eec.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792936586; x=1793541386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EaTFik+nDqTPSItgReBEqOy/t+FbqxO/TOcAMbZtU9U=;
 b=DPzlz2/0gtF6t7dHugCfFdjEStvHdB8NbhHG0tGVHVuRjN+p5EUaMPkv3J2+qPRUYa
 GvQtq3xRI94zMqJ/5Jvn4PEP7B72+ejV5RMfJcYHLDwrVV1aWMnsFrhfZl7UfrKz3cs/
 +aldU4XBjTRUz2ZSt+FUKzVD5sELQ9WuQNHPfGYwRRBw+ihHyYniae5Z/mBdRuO2jmaH
 MXwl5cqAB5kZuHdq8lZmv0GxgDxm8Jt53jXlgq/9wXM2BsujgJ3n8XiovhyB6x8/VYIO
 p3hY48+vLD9DwHjQDyVOpJuT3XaD4SqYpVD+EVaN4vMxcf/+aFWk9+QEAVoGDzrzJrfV
 90mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792936586; x=1793541386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EaTFik+nDqTPSItgReBEqOy/t+FbqxO/TOcAMbZtU9U=;
 b=QNsbYWN6h2F8fxuv6w5Y1CKmvo18Zv9EvinKecOoskWkbVJilmNTA4L8muCgPi+sDq
 /DObr8GPOy0RC+/WiQW50ESU+iEIwZdyctZ2tx+SatUnpzWxNMiMwXGeNjVtswSCTLac
 dy9ht9h/yHvjyjQLxnqEWYy5s+2+THjAHpfd3AdPdxGRf2JPU76EMl90302Ltms9Wrhj
 dlPmQJtWQem9AiDce9fb9D/EURXrYHCjs0jp0AaDYQqgRIzVdkRMEsVdwGKAh5FyMiM3
 GZhVW74BzQdUj+Iu9etBpezQgE+JSxhELt7Ikr0fTQcvM0EFZj+SyAOPYVGUFiwG4pXi
 z5JQ==
X-Gm-Message-State: AFq9FYIql+aYK4aG55uAYr6ui7KK19RM7A3Pbqzi+sKFkqBDIs5hT/jJ
 hcKFNcDEhDL8CuSONzIJvpH8MGNzbZMsYqpeG3BPVxbjfirMW3zQIDV2u8r+AuEI
X-Gm-Gg: AYBFou2oXFAcZk4UUYvnPXdauvF/GAOOcwBb3wiVqyf01ojio2TyPgUunrD6cig0jcA
 cXrvKLji/9gXlQ9ZxoglHg2qbfvlvLG90pDQdD4s91lw93I0MtuRbgf08zPD4UmHuvyvKRQw1rw
 fcXgvEfg9w17/g0dsRxDqNh/6Q50Ro0pK9lt1okm1jXrle0kON2kEHrw2z6jwkDyXnQLsWba1IZ
 pIBizvceW73vXANogJjCBTAmt+wYeelyqOfLyqeyt7MgmmL7YtJhqbDRu1IyTBX7szrUkf0Y9m6
 CmIdr1Kvl1SfUqR6eReQa4jdEXALq1Ryac///zWDUpBexWitdupArOT+mbdHAKCS23nOHELvbkP
 RTrz5TPzjg0hzQKAytMMZPN8GOJhafMcC3guZQuG3etKbOcGuvBPOA/SisjvSaZb4gs93dAa+IF
 XPVuyhmVxvdcP0X2DLuBhVTjnPKin8M1uPaU1nhI7VkIn2cqZYSnx/Vh097Fb1+ThZy2J7Uwg8G
 3KpR+zB/aUwlupIWOlvjfD0MR99F4mboh9jXeV4Ie9bhtKpGBtNU1JC3Ri2
X-Received: by 2002:a05:693c:4018:b0:369:f05d:6c5c with SMTP id
 5a478bee46e88-369f05d6f61mr4667481eec.28.1792936585859; 
 Sun, 25 Oct 2026 06:56:25 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d845ddsm16795724eec.11.2026.10.25.06.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 06:56:25 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, waysorrypub@gmail.com
Subject: [PATCH v5 0/5] hw/loogarch: Fix UART ACPI properties and FDT
Date: Sun, 25 Oct 2026 21:55:54 +0800
Message-ID: <20261025135559.236356-1-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=waysorrypub@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes the UART description for LoongArch virt.

The ACPI _DSD property built for the UART has three problems: the
property name is misspelled, the key and value order is reversed, and
it describes a 100 MHz clock that does not match the device model.
The property can be dropped directly because the UART model's input
clock matches the Linux 8250 PnP driver default of 1,843,200 Hz, so no
_DSD override is needed.

The _CCA property is also unnecessary.  _CCA describes a device's DMA
cache coherency attribute, and this UART does not support DMA, so there
is no reason to declare it.

The UART clock frequency in the FDT is corrected to 1,843,200 Hz, and
the expected ACPI tables are updated accordingly.

pillow (5):
  bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
  hw/loongarch/virt-acpi-build: Drop invalid _DSD UART clock property
  hw/loongarch/virt-acpi-build: Drop UART _CCA declaration
  hw/loongarch/virt: Fix UART clock frequency in FDT
  tests/data/acpi/loongarch64: Update expected DSDT.*

 hw/loongarch/virt-acpi-build.c                |  11 -----------
 hw/loongarch/virt-fdt-build.c                 |   2 +-
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4351 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5572 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4357 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4653 bytes
 6 files changed, 1 insertion(+), 12 deletions(-)

-- 
2.56.0


