Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED48CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMPM-0000MP-TJ; Mon, 27 Oct 2025 08:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDMOq-0008KX-F9
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:32:39 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDMOm-0005Qs-1U
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=rbPtFhv3Q5NimVYyKy2JbS1JGzSF5xEi+Jv6vNPHBQw=; b=oQMC+/2ZGQxg5+1
 AttuQtQ4iUiEnoAXf93+6oDCVqzZPYesFX7B19oKxSwLC2T37RtQqxyciE5U+JbiP1DoBOJzosyGr
 KAuuPPvjNkcxAZXYhY5sfLkEGaoHwGuUmLSbvQYoGXVoSR1N8U1rK0Za0on+zGf9r7jMQ3TBvsAkm
 7Q=;
Subject: [PATCH v2 0/3] single-binary: Prepare hw/riscv for single compilation
Date: Mon, 27 Oct 2025 13:35:09 +0100
Message-Id: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP1m/2gC/42OQQ7CIBBFr9LM2jGAhTSuvIfpAuhAJzHUQK02T
 e8u9gQmf/P+4v2/QaHMVODabJBp4cJTqqBODfjRpkjIQ2VQQmkppMZAdn5lwsIpPggdJ5tXHN+
 4SOy8vjhjjHDaQzU8MwX+HPZ7X3nkMk95PcYW+Wv/89YI7FwrDQ22VT7c6tVzitDv+/4FHCT3/
 cMAAAA=
X-Change-ID: 20251015-feature-single-binary-hw-v1-8c53b6660b5c
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

this is a small prerequisite patchset that removes target_[u]?long and
replaces a few target specific macros with target-info variants.

Next up is using the target-info style QOM filtering of boards and then
moving translation units to common code.  My current patches for this
are based on Philippes single-binary-hw-arm-rfc-v5 branch, is there some
other branch I should target here?

Changes in v2:
- Use MAKE_64BIT_MASK() in patch 2 (Richard);
- Dropped runtime TARGET_PHYS_ADDR_SPACE_BITS as it shouldn't be exposed
  to common code and is better dealt with in other ways
  (Richard, Philippe);
- Added reviewed-bys.

---
Anton Johansson (3):
      hw/riscv: Use generic hwaddr for firmware addressses
      hw/riscv: Replace target_ulong uses
      hw/riscv: Widen OpenSBI dynamic info struct

 include/hw/riscv/boot.h         | 20 +++++++++----------
 include/hw/riscv/boot_opensbi.h | 14 ++++++-------
 hw/riscv/boot.c                 | 44 +++++++++++++++++++++--------------------
 hw/riscv/microchip_pfsoc.c      |  2 +-
 hw/riscv/riscv-iommu.c          |  6 ++++--
 hw/riscv/riscv_hart.c           |  2 +-
 hw/riscv/sifive_u.c             |  2 +-
 hw/riscv/spike.c                |  4 ++--
 hw/riscv/virt.c                 |  2 +-
 9 files changed, 50 insertions(+), 46 deletions(-)


