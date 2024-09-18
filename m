Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C38CCCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 09:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqrGt-0006u1-T5; Wed, 18 Sep 2024 05:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqrGe-0006tO-A5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 05:46:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqrGc-000684-Kc
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 05:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=iNsIw6xK1apqOO3e6p8R3cdgDHbBV2u8JXYlGWQIFvQ=; b=dWGjcsn+U9egzLt5NXLJjKtTF3
 HZtfBNvMjyYyUMb2kYsfqUIH4LOBGslNIPrIMuFrOYmyG2duf8hMOnVcS7uzLHPKuZu4ibJPXOLtS
 OV0QD83fPFhoBSlEWcGJsNmm5YDrKo+2oDHCoV1nKLYz6c24fUpyOEeP3/DmqtRDJi1zS1oEQ5yej
 PcV65/HC9atvoKTzeAvkt3tFZewmYNwlep/b11QJlj5OlO4SM2FpK0B8it+MgWlbtT0TnHZJFtosH
 ntvJD6QZEIzRP3qkr/4lJcncxkpVnU5sNHid2iru7q70aL8Vqf6Kb5jjX4TCmtABCAIR9rbJsA1zT
 kHxKwq6fOf2w+mSaC7DqRJPz/+aACjdeoLJGDl43mvJj1wnacPxCzdi8up3Mk1UNUhDFrj3tZvbC6
 6Qp27tiyjZnPBQCNJadsXKTxLN7eGkrQJiNwdBNyOxatdJmhMcJYdTNZH30qVnoMgBzagHUspoPhC
 7dCJ9c9WPppl2f7GGLkNIRxnH23DDv/Bk/6zJqa4nNsgrH2jPBvh8I+i92xZO4ayvPwHfNbXFDNbq
 c5IT70p7LVJS+U9YMnOy4CBo6pJNcMkDHkXr/hlJBBJobX5hfXk56MSYN/mCAbMrX8mk5IQpqg4OG
 DOKf7sLb1WVPCznEuJCGeRMGZAQd41kz/LAfHw6C8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqrGS-000BB2-Vz; Wed, 18 Sep 2024 10:46:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Wed, 18 Sep 2024 10:46:23 +0100
Message-Id: <20240918094624.938242-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/1] qemu-macppc queue 20240918
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
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

The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22bd5:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-09-17 14:02:18 +0100)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-macppc-20240918

for you to fetch changes up to 2d0a071e625d7234e8c5623b7e7bf445e1bef72c:

  mac_dbdma: Remove leftover `dma_memory_unmap` calls (2024-09-18 09:31:56 +0100)

----------------------------------------------------------------
DMA fix for macio IDE device

----------------------------------------------------------------
Mattias Nissler (1):
      mac_dbdma: Remove leftover `dma_memory_unmap` calls

 hw/ide/macio.c             | 6 ------
 include/hw/ppc/mac_dbdma.h | 4 ----
 2 files changed, 10 deletions(-)

