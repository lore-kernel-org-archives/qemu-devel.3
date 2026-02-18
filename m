Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0901EE9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnUk-0008BW-03; Wed, 18 Feb 2026 14:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vsnUf-0008AG-Rw
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:45:55 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vsnUb-0001vo-9N
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=OEI/CPt0rXBbUcqbP7Zb9ZnDlP7RuRsnTZ+m6rdHDSY=; b=ro8UjcuuHhiZsH8
 aNCQKU2OInNRUN8jvMNvzJLFErBR+LbAIk8dhxpfnNm+uhsW3hvJm2DlYvUF8d9w3gCWhnwBr+qFx
 4tuPmIERFFstKk35xm0g9jCLE3uCl/A9GLnE8LNDXcq149/qgmasdC1POYx+xBtabG/7AiDMdpeWL
 08=;
Subject: [PATCH v3 0/4] hppa: Add simple C3600 machine with PA-8600 CPU
Date: Wed, 18 Feb 2026 20:48:57 +0100
Message-Id: <20260218-hppa-c3600-v3-0-b37ad58a20dd@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPQQ6CMBREr0K6tua3UAqsvIcxppZf6AZqi42Ec
 HcrJLrR5UzyXmYWEtBbDKTJFuIx2mDHIYX8kBHdq6FDatuUCQdeAmdAe+cU1XkJQE0FlZSASgh
 JEuA8GvvcZOfLnj3eH8k57eVX2WRJKBiDgrp+DlfVtp7ewBQSVQ6sUE0syNvR2zCNft72RbZJf
 k2JjAJVTKIWlQGRm1M6cxy6zRH5f44nrtYKal2mK4x/uHVdX+/EEsMdAQAA
X-Change-ID: 20260210-hppa-c3600-f808770ea557
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771444170; l=2483;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=W+nV1VrVAL5I2eH1GBCRVyz//GMlUMY90+lWD5vzsSY=;
 b=m5nmN81Lj140Il3XDBgW2tr3IMO1Ln9JGUd4tulhOonf67L1qD4wgcCi4f70ych89TEk+TDS2
 tbPR9SmT3KtC01lkizsLHQaSnyZWlqQi5ZnqPSzZIgvcJZyQvVinvnO
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset tries to address a discrepancy between the C3700 machine
in QEMU/SeaBIOS and the documentation (chapter 5)

  http://ftp.parisc-linux.org/docs/whitepapers/PA-8700wp.pdf

where 40 bits of physical address space are used in SeaBIOS compared
to the 44 bits specified in the documentation.

A PA-8600 CPU with 40 bits of physical address space is added along with
a C3600 machine using it by default.  AFAICT there are no major
differences from QEMUs side between the PA-8600 and 8700 aside from the
physical address space size.  The PA-8700 machine can then be
moved to using 44 bits.  To account for the discrepancy with SeaBIOS, the
functional tests now run a C3700 but with a PA-8600 CPU.

CPU model definitions now inherit from a TYPE_HPPA_CPU base class and
use a HPPACPUDef struct to provide model specifics, similar to the SPARC
and RISCV targets.  This hopefully makes it easier to add other models,
such as the 8800/8900.

Based on:
  [PATCH v6 0/8] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
  (20260218-phys_addr-v6-0-a603bf363218@rev.ng)

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v3:
- Fixed spelling in commit message/comment
- Rebased
- Dropped if statement in hppa_cpu_class_base_init() (patch
  "hppa: Introduce HPPACPUDef").  Not needed as it will simply
  be set to NULL for the abstract base class anyway.
- Link to v2: https://lore.kernel.org/qemu-devel/20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng

Changes in v2:
- Missed a reference to the old "hppa" CPU model, updated to
  "pa-7300lc".
- Link to v1: https://lore.kernel.org/qemu-devel/20260210-hppa-c3600-v1-0-a17ec58f053f@rev.ng

---
Anton Johansson (4):
      hppa: Prepare for additional CPU models
      hppa: Introduce HPPACPUDef
      hppa: Get physical address space bits from HPPACPUDef
      hppa: Add C3600 machine with PA-8600 CPU

 target/hppa/cpu-qom.h                 |  8 ++++-
 target/hppa/cpu.h                     | 35 +++++++++++++++----
 hw/hppa/machine.c                     | 64 +++++++++++++++++++++++++++--------
 hw/pci-host/astro.c                   |  2 +-
 linux-user/hppa/elfload.c             |  2 +-
 target/hppa/cpu.c                     | 50 ++++++++++++++++++++-------
 target/hppa/mem_helper.c              | 40 +++++++---------------
 tests/qtest/machine-none-test.c       |  2 +-
 tests/functional/hppa/test_seabios.py |  3 ++
 9 files changed, 141 insertions(+), 65 deletions(-)


