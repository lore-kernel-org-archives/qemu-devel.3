Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC64C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfjcm-0003wr-Mf; Fri, 03 Jul 2026 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wfjcl-0003wV-AY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:32:31 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wfjcj-0000uy-RS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:32:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2917660051;
 Fri,  3 Jul 2026 19:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B96E1F000E9;
 Fri,  3 Jul 2026 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783107147;
 bh=X/ngNA3l6PCS3cXbpJEOoXs4pXU0fhIiUKiC7QR5QIg=;
 h=From:To:Cc:Subject:Date;
 b=ioEXFQnXVDnToq8/iBx+3cvZXu9n9FeHYe6JUer+x/HCxgqSzJAguFmWdkTZGALLA
 kH34k4bEexB8dtAf6UgrzPTb05YzaPu3bySFesyf/JW3k2AUwGhF7VvxQMghUriwtd
 scC3JlGwd91vQodWla5fYzmaCquj+43i8y1KMJWFCG5f5s9aNpzMb/q5obclpQM7c1
 syyvGqxanlo9rVi3KHhvrMULhx6VhZ1S/vnJ3zmAEBd7ldCCBJYyx1DbEBkNmKhl4i
 6JGXqMAjjJ7SUM6BagbvbyXfD1ieWDsJGH0xd70PCmup1NlsDPRciC8ddmRcylUp34
 9sBNrpl3WkuNg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 0/4] Updates for hppa architecture
Date: Fri,  3 Jul 2026 21:32:20 +0200
Message-ID: <20260703193224.33135-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

A few patches to fix TLB for HP-UX 9, and a lasi irq fix,
as well as a new SeaBIOS-hppa v25 firmware.

Please review.
Thanks!
Helge

Helge Deller (3):
  target/hppa: Work-around for Fast TLB insert instruction on HP-UX 9
  target/hppa: Delay MMU update until TLB protection bits were set
  target/hppa: Update SeaBIOS-hppa to version 25

Keith Monahan (1):
  hw/misc/lasi: derive IRR from pending and unmasked requests

 hw/misc/lasi.c              |  25 +++++++++++++++++++------
 pc-bios/hppa-firmware.img   | Bin 632780 -> 633992 bytes
 pc-bios/hppa-firmware64.img | Bin 665208 -> 666392 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/insns.decode    |   2 ++
 target/hppa/translate.c     |   4 ++--
 6 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.54.0


