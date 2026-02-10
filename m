Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6E0EA8109
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnNj-0003ry-Tc; Tue, 10 Feb 2026 08:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpnNg-0003pv-3Z
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:02:16 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vpnNe-0002qi-51
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=CxwoWwzNFts9tCKaL8KWuZE5RrhF0Ge+Q40rP9nP6as=; b=bx8MkPHvdTJK9NL
 /cSPEYWm37YEDiiytE1YMaAzuMQYkPNOqozXITMrghs7W3FTjOLrQfSn1kRssl3BYwUfGvPFt0M24
 uUG1KXujXX4MTOIlEzLe+NC5mRpDOvf+A8gJLv8rivPRP5zTs38VIha0jhHSvHqzgT+qkm9XztNSr
 Gc=;
Subject: [PATCH 0/4] hppa: Add simple C3600 machine with PA-8600 CPU
Date: Tue, 10 Feb 2026 14:04:54 +0100
Message-Id: <20260210-hppa-c3600-v1-0-a17ec58f053f@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XMQQ7CIBCF4as0s5ZkoFAarmIaM5ZB2FQEbTRN7
 y6xC5f/S963QeWSuILrNii8ppruSwt56mCOtNxYJN8aFKoBlUQRcyYx9wOiCCOO1iKTMRbaIRc
 O6f3DztPRhR+vZj6P8U+6roFGStQix0+9kPdFXDFoy9Sj1ORWDdO+fwHfPbbCoAAAAA==
X-Change-ID: 20260210-hppa-c3600-f808770ea557
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
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

where 40 bits of physical address space are used in SeaBISO compared
to the 44 bits specified in the documentation.

A PA-8600 CPU with 40 bits of physical address space is added along with
a C3600 machine using it by default.  AFAICT there are no major
differences from QEMUs side between the PA-8600 and 8700 aside from the
physical address space size.  The PA-8700 machine can then be
moved to using 44 bits.  To account for the discrepancy with SeaBIOS, the
functional tests now run a C3700 but with a PA-8600 CPU.

CPU model definitions now inherit from a TYPE_HPPA_CPU base class and
use a HPPACPUDef sturct to provide model specifics, similar to the SPARC
and RISCV targets.  This hopefully makes it easier to add other models,
such as the 8800/8900.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Anton Johansson (4):
      hppa: Prepare for additional CPU models
      hppa: Introduce HPPACPUDef
      hppa: Get physical address space bits from CPUHPPADef
      hppa: Add C3600 machine with PA-8600 CPU

 target/hppa/cpu-qom.h                 |  8 ++++-
 target/hppa/cpu.h                     | 35 ++++++++++++++++----
 hw/hppa/machine.c                     | 62 +++++++++++++++++++++++++++--------
 hw/pci-host/astro.c                   |  2 +-
 target/hppa/cpu.c                     | 52 ++++++++++++++++++++++-------
 target/hppa/mem_helper.c              | 40 +++++++---------------
 tests/qtest/machine-none-test.c       |  2 +-
 tests/functional/hppa/test_seabios.py |  3 ++
 8 files changed, 140 insertions(+), 64 deletions(-)


