Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAA9C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDPe-0004Zf-JE; Tue, 07 Jul 2026 17:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1whDPX-0004ZI-Fy
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:33:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1whDPV-0000Uo-TX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=1Gp/OJ8/oK0S2Fx5MrVPXv9a9x8B+D2dNxmTnzxuqYQ=; b=aMQfkUV5Y1ndKJlru9dId9ePOk
 +uTwOiSCRDWzkXM7vn/YBbaG/nwegDpM5Wr4xnchkm5udflvVFLjODOyOP0f0tJniNKul7bHpngnd
 BATllZyQ/COGW1kwKwTCO23gUXVamkJTY7cPHvUR6WPsBIcjMvTQ38do7v5UZOxHPA6NCC29lIF1R
 fyMlrq59+VVWpp0h5W+aajFp54Z8N5qph2KqiwSGvv3h7mvinpGqFmTLERNjjAJ5XIddOnIvJ4DFT
 gp/D5/Xlsv2juNXXQ9VB0JKF+QhiLFK4knULXqAaXMGcJKsWc5wXdUaBL7c39SCm8tgaS8mfLO5wV
 lEBmnm+H8NwTbZNAgaSpKiO0rp8UKUlEnziq5+PDE3JI5WWEkaucCrQysSLPTPzMKFtzecf4NISZP
 XakIrdx0sB1LyK0FSBVOIAmVbXHdMOWEOF+dW2XKYZlLQAhTndb98Oir5Hp64g3SlsCBbBtrjgBP9
 Q+PcavtVvVU0wegjqV8isl4hthJqyfqgzgZdFSMDRleIunFVzizcGjCOZ6YOshRdzng3Kke/A3dai
 q2np+zIutRPIVAT/KZK0/+gdqZbvtTAb5KmaZMu7fah3CSQSb5KFfiS+Pcp+BWMB1VY7qSnAeP+O0
 fNwMT+79MzEl6PO0SNKQOo25fxcWyXSomPY5SppLc=;
Received: from [2a02:8012:2f01:0:c7db:c036:80a0:714]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1whDPN-001Zrk-K8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 22:32:49 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Tue,  7 Jul 2026 22:32:05 +0100
Message-ID: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:c7db:c036:80a0:714
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/1] qemu-openbios queue 20260707
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 916ab315cc2b3a3825ebb399d83339660144d5bd:

  Merge tag 'pull-nvme-20260707' of https://gitlab.com/birkelund/qemu into staging (2026-07-07 07:09:38 +0200)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-openbios-20260707

for you to fetch changes up to 9e3508dce0045de26ec8cab064443c92fdd15288:

  Update OpenBIOS images to e5ac46dd built from submodule. (2026-07-07 22:07:16 +0100)

----------------------------------------------------------------
qemu-openbios queue

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to e5ac46dd built from submodule.

 pc-bios/openbios-ppc     | Bin 677200 -> 673104 bytes
 pc-bios/openbios-sparc32 | Bin 382080 -> 382048 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)

