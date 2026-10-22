Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1D606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p9GZQIof
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJn8y-0001Je-7P; Thu, 22 Oct 2026 03:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn8v-0001IY-Co
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:18 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn8t-0008N8-RP
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:17 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8a06c60065fso1032469b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792653793; x=1793258593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5TRmtBcPVK6BmP5QAdS7eiOXvzSuqDjeQFOQaRqRR6E=;
 b=p9GZQIofLIuB0a9w+WSq0BsFBDDXUtmbvaWEarjL2UsQ1jx8e/CH5unPcNoItKdu8H
 kfS0D4/LRXLRSf0Ykdr2CUqMmebojPs9/6LhhewigsADgF0Hr8cDLSYEN2O9WlfXhurO
 1B9kvsKs37Kytg/8eJOM8/l4wyhPn9WboQ+1q455TX1WPJfQ56yqLKw6PU8zsUjEZngB
 /0Su6EffuQi7C2RVaOe3Ihu6GSqhGsy0u920WC/8T1o0PQHbpDSFOvAT/rI81XUE8m7Y
 ipPBwPWXxpX4PCtiDI0b5cY+JKvD7Gtv1POky21IxCXKQ1YMvKN/NuFr4HhWlV7FGPFY
 FSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792653793; x=1793258593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5TRmtBcPVK6BmP5QAdS7eiOXvzSuqDjeQFOQaRqRR6E=;
 b=Om0tldcJtb0xmAkFXnLElarggRNQ2qoiZSO2IV44GzCVvEzE98vzNC3TrwWYw6wHCN
 5VgkXbmmzTD9ujPc6QswK/UEag2zPAH6ocjTg2vL7xsUydIBMvUoikX16/cKxWKNU9Se
 SoX7woRK1Qe/4u3VCCTZO/gtj2x7pdg+fa2kDGqyoKxjfarAQCEnXnLoT/RqZOgcuEzI
 Wm2iIbXbbYwt+ZvNwi1glhCVljTK3K3Lxv8urldvR1WJJB4rp8xIbW4VnnxsTKlHPOHA
 EqOpkDoe1dRMP0i0DKNGXVRy8VD3ISqRPQYFiNjLpSgBdmYKuCByS1w9Z3dzLlG3gqIu
 gIIQ==
X-Gm-Message-State: AFq9FYITYuliytXbXCrw37XaqPxgXD8anbh3rg9zplqX3BMK/zBQa3ip
 WYibq2QkBiJCffPF99Hp2gKZ4OGddaG8Ly/NApZPit3ezZnthfyzVdJJzuWluOi8WRI=
X-Gm-Gg: AYBFou1gU4sUJFkiREaVzCYCZTJdP0+nHvBWyOsLbHrllTGb2ObzAgADu/J25PughNK
 xf1+RfOv6dm1EyVwnVBZdGMnibdiRsEzR/DlfKN3B7u9lE5x0TV6IqnmOhS7y6pBlvS/ASVLjfG
 iX0NAF3vtEy0EiHbXgcQp/aEJ9wob9qmamh6HxeCIs3Qc6vmIug16GkNWQAgdmBM9iXJvi0zHe4
 46B/Mfvm8uWgiavI3VrOli07f7DLG3Iwj4hP+vUIjCs7XXw7q/1uJFpskqeCGelCFC24g7ETQcu
 cEYL6M4XeeOu6/fgqiZeJ27RRhFdBZPToCfhL0thyGnA4XpNQgIxVeS4WjlGpnwclnBIXSlrlf0
 vXZpu0HT1rtrdc/U8XoLZCUD2jnVAA3n14qK1FebL1x8/eeyiqu15qpnkYg4/hX8p29Pl+YYLjz
 5wdqwC1xG11h8X+M5MuiHhP3VQFn6hUkUCJSvsAb93npHb8TxKLssJM+sxC1AaLkzEndxD0hfca
 ktYA1yhM4+By62bceKiYPvPym9TZ+nxgVqOqnhNOKUQiNBhSNhQHlcluH3x
X-Received: by 2002:a05:6a00:3392:b0:8a0:1a6b:59fa with SMTP id
 d2e1a72fcca58-8a089d264d5mr3389520b3a.37.1792653792698; 
 Thu, 22 Oct 2026 00:23:12 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0894b49dcsm1699776b3a.16.2026.10.22.00.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:23:12 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH v4 0/4] hw/loongarch/virt: Fix UART ACPI and FDT
Date: Thu, 22 Oct 2026 15:22:34 +0800
Message-ID: <20261022072238.319308-1-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=waysorrypub@gmail.com; helo=mail-pf1-x429.google.com
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

This series removes the UART _DSD clock property and _CCA, adds
_STA = 0x0f, and updates the expected DSDT blobs.

It also changes the FDT clock-frequency from 100000000 to 1843200 Hz
to match the emulated UART model. The FDT clock property is retained.

Changes since v3:
- Add a separate patch to correct the FDT UART clock frequency.
- Carry Bibo Mao's Reviewed-by for the ACPI change.
- Clarify the ACPI commit message.

Testing:
- All five LoongArch ACPI bios-tables-test subtests pass.
- The generated DTB reports clock-frequency = 1843200 for all four
  UART nodes.

pillow (4):
  bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
  hw/loongarch/virt-acpi-build: Drop UART _DSD clock and add _STA
  tests/data/acpi/loongarch64: Update expected DSDT.*
  hw/loongarch/virt: Fix UART clock frequency in FDT

 hw/loongarch/virt-acpi-build.c                |  12 +-----------
 hw/loongarch/virt-fdt-build.c                 |   2 +-
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4379 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5600 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4385 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4681 bytes
 6 files changed, 2 insertions(+), 12 deletions(-)


base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
-- 
2.56.0


