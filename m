Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C486BCC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiAU-0001qf-3X; Tue, 13 Oct 2026 15:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAR-0001ph-Op
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGiAQ-00087A-5g
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=KsKfyXN3yxPWIIUU6+sW9kEd1sytQVFzph7gQBLDong=; b=c5FaVRcEFc7/fWYLwqImCJhWwE
 onGvhxN+IICwLdedfyxg618KahLGsBUCttjnYRoi3t9+g1Ww+tQQlUH53UBGkyFlZpOpbbQD7HKai
 LW2VlG1MOwS5osh20oQiV5DG+jtnEYPQ5Xkwmr24Y6UDCvUKvbWt8xugXDH6puXA1AOynC2i77ycG
 GDWvtx+XTN/VvHJTLFsgWCjHNmfO5V+aUUIPk/YVkzxMeV8dxFCXngIHkCSQwQZvvsotGnehLe1hq
 X0mhqk/B2pIZUeMgMZNJymFrfV4Qs9KvAXRiERxJmO+Av1c4b7R6T9uX4qU/4ggP7tjmcOJnO8cX1
 A4dNT3AYlU7h/k6VWSVJq6x7UB9S7VrWMBaRSsNbmGyEIWsR0dIfOfs8R3GqZo0ZbaDjyzrV5MsFn
 J7lu9GT+K4KTYrdS43lIY4WazfDbLsCNFRlaSJfsimMuyPIiMsyRTImpsxDJB27GBwzOPnRt5T8RS
 2MUT/I0S1wvic1PDUVOQyCS/jLoRvSi+ArzDZSvZbqTFL6kjjeprCuEjyUPcfa38sAjP1rhoJ/4V3
 SHnv8leKhO8DD2x2pTVxjUKT4Y5d2EuqzXeXb6QNR23O3FcScRMRu0S5SDbjw195KIlzc9UDKUEz6
 eXhWapMLYkoDJhmUKh1geIkkIMzmUNJwypLDvh8DI=;
Received: from [2a02:8012:2f01:0:b2a5:667b:71e2:6751]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xGi9i-001aAM-O8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:27:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Tue, 13 Oct 2026 20:27:32 +0100
Message-ID: <20261013192751.196204-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:b2a5:667b:71e2:6751
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/5] qemu-macppc queue 20261013
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

The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-macppc-20261013

for you to fetch changes up to 32d0ad97a528dd6c667e7f60d62de27328b00247:

  tests/functional: Boot OpenBSD on mac99 (2026-10-13 06:26:28 +0100)

----------------------------------------------------------------
Fixes to allow OpenBSD to boot on the mac99 machine.

----------------------------------------------------------------
Kirill A. Korinsky (5):
      openpic: Preserve IRQs masked by CTPR
      ppc: Raise decrementer IRQ on zero write
      cuda: Include command in successful ADB replies
      cuda: Make shift register delay configurable
      tests/functional: Boot OpenBSD on mac99

 hw/intc/openpic.c                    | 10 ++++----
 hw/misc/macio/cuda.c                 |  8 ++++---
 hw/ppc/ppc.c                         |  7 ++++++
 tests/functional/ppc/meson.build     |  2 ++
 tests/functional/ppc/test_openbsd.py | 46 ++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 7 deletions(-)
 create mode 100755 tests/functional/ppc/test_openbsd.py

