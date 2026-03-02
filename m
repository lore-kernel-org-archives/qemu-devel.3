Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06665E9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1qY-0000xd-T3; Mon, 02 Mar 2026 06:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vx1qT-0000wT-OG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:53:54 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vx1qQ-0007im-NJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=lO5+4qNX7Iaa4LAQ34FflRaokiL3Itolfv0cdH/RvcA=; b=hxNcPfQQn/eKr4+
 0zIdISyh8Zk753OM+L9tIZEVtWpIokMHkAGatBnFgCYavMlDz3uUOtNFugTfxGwhsk+8Z7LSfPqHa
 0fKsyXMtVCJFfHZrGw29DjE2kDOL/DczztpRJeoVaLiMNHTrFTvBC7FI7iyM+ZmLhwA41zAstRf+d
 +I=;
Subject: [PATCH v4 0/4] hppa: PA-8700, use 44 bit physical addresses
Date: Mon, 02 Mar 2026 12:56:42 +0100
Message-Id: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPy2rDMBREf8VoXYWrl6V41f8oodxIV7E2jiulI
 iH436s4kDTQLmfgHGaurFBOVNjQXVmmmko6Ti3ot475EacD8RRaZhJkD1IAH+cZuVc9AI8OnLV
 AaIxlDZgzxXReZR+7e8709d2cp3v5VA5dExohQPN5vJRPDCHzPURtCRUIjUPV7OYYUzkd82XdV
 8Uq+WtKFRw4CkveuAhGxfd2ZjMdVkeV/3OycVuPsPV9uyLkC6d+c+6FU43bK4vBOJQQwoNbluU
 Hr5Rn5VUBAAA=
X-Change-ID: 20260210-hppa-c3600-f808770ea557
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772452649; l=2598;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=PYG/XTDi45BuHpZ+GKzf/Z//yvWvXFhTVVRe6Y9NQs0=;
 b=ClVg9RNU4au+YebRWtvLvS7qSlENB7M9WC6rh08RmrAvtRiRWvpIkEc+03e+NbnnsxL3xqHnu
 cdVUr8gje53B7Yt6TJLBzxJhlffsLWv9Yz11qPQ1Xe827TACce4rrJP
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A PA-8500 CPU with 40 bits of physical address space is added to be
used with the A400 machine.  AFAICT there are no major differences
from QEMUs side between the PA-8500 and 8700 aside from the physical
address space size.  The PA-8700 machine can then be moved to using
44 bits.  To account for the discrepancy with SeaBIOS, the functional
tests now run the A400.

This series introduces a small restructuring to the HPPA CPU class
heirarchy. CPU model definitions now inherit from a TYPE_HPPA_CPU base
class and use a HPPACPUDef struct to provide model specifics, similar
to the SPARC and RISCV targets.  This hopefully makes it easier to add
other models, such as the 8800/8900.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v4:
- Add PA-8500 instead of PA-8600 and use the now upstreamed A400
  machine.
- Link to v3: https://lore.kernel.org/qemu-devel/20260218-hppa-c3600-v3-0-b37ad58a20dd@rev.ng

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
      hppa: Restructure CPU Class heirarchy
      hppa: Introduce HPPACPUDef
      hppa: Get physical address space bits from HPPACPUDef
      hppa: Use 44 bit physical addresses for PA-8700

 target/hppa/cpu-qom.h                 |  8 +++++-
 target/hppa/cpu.h                     | 35 +++++++++++++++++++-----
 hw/hppa/machine.c                     | 25 +++++++++++-------
 hw/pci-host/astro.c                   |  2 +-
 linux-user/hppa/elfload.c             |  2 +-
 target/hppa/cpu.c                     | 50 ++++++++++++++++++++++++++---------
 target/hppa/mem_helper.c              | 40 +++++++++-------------------
 tests/qtest/machine-none-test.c       |  2 +-
 tests/functional/hppa/test_seabios.py |  4 +--
 9 files changed, 105 insertions(+), 63 deletions(-)


