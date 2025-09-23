Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FACCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v147x-00033L-Po; Tue, 23 Sep 2025 10:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v147t-00031w-12
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:36:18 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1v147q-0002mf-Ka
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:36:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C482843C05;
 Tue, 23 Sep 2025 14:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AFBC4CEF5;
 Tue, 23 Sep 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758638168;
 bh=jmy6aIjFGD3f57e90WPumKX2dq3ZPrvC07Lu6nuPVz4=;
 h=From:To:Cc:Subject:Date:From;
 b=Nz6M05Mw40A2ykzGXSZD9JPtCUjil7xV3AnGkEyopqefGteetSgEHwOhqlQrTyZBq
 OI3O2E/cH7az7Hgd/Xgg28jB1rM+3RH5Rzy2MYlCmz2xW/iQOFVL5RGe89xQvTq07I
 NpLDSKIpWVhz1nVv9skImXqrGcC3vPGoXMIgD0I0jJdUvsLOs6XCSOfCwiHqOB9+lj
 Cy4bnL5YrNzhPHCIG/7qMzB8mzFyY+REjatkE2ga5gY+TRaklOawWS8rJfEx1UGroP
 mfUcT7DTDL19XP+tqZVlRLaeFl0v+6luqEEEsLrcVGf7drTUpVegNFptEk+7Gh8Skp
 i6P4Zb+/KgtpA==
From: Huacai Chen <chenhuacai@kernel.org>
To: Bibo Mao <maobibo@loongson.cn>,
	Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <git@xen0n.name>,
 qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 0/3] LoongArch: Align VIRT_GED_CPUHP_ADDR
Date: Tue, 23 Sep 2025 22:35:39 +0800
Message-ID: <20250923143542.2391576-1-chenhuacai@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=chenhuacai@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Align VIRT_GED_CPUHP_ADDR to 4 bytes to avoid ACPI errors during boot.

Huacai Chen (3):
 bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
 hw/loongarch/virt: Align VIRT_GED_CPUHP_ADDR to 4 bytes
 tests/data/acpi/loongarch64: Update expected DSDT.*

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/hw/loongarch/virt.h                    |   6 +++---
 tests/data/acpi/loongarch64/virt/DSDT          | Bin 4603 -> 4603 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp    | Bin 5824 -> 5824 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem  | Bin 4609 -> 4609 bytes
 tests/data/acpi/loongarch64/virt/DSDT.topology | Bin 4905 -> 4905 bytes
 5 files changed, 3 insertions(+), 3 deletions(-)
--
2.7.0

