Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A1B106ACE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0mOn-0004eA-PS; Thu, 12 Mar 2026 16:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w0mOk-0004af-TL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:12:47 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w0mOj-0006Xe-9G
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:12:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 859A360054;
 Thu, 12 Mar 2026 20:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51996C4CEF7;
 Thu, 12 Mar 2026 20:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773346362;
 bh=5DuPXgjgqVoB+oVIWF2ZXP1co8XBDRfg+kmgRkabipo=;
 h=From:To:Cc:Subject:Date:From;
 b=sI7gdcqo82eFaCc2iOycclNmzuto7WQvsXTzUZ31AfEl1RgZIlFQWR9zr2OXTJ3PO
 BEBHKTvU8Yztac+62+zsR5ddC1nOhKahpMjN4BnSb10A7bSSk5tmFf8asUEfbMfmd+
 G961ije61z2PCwNpmEeyHfvJdhp8o51dA5SlOR2OromSYhK9FW6aWpFFz745URj8C5
 Gz64ndfS/L04nvjdCXfWDl9jJ/6wEoWAcX/YVAL3KGAKx/93eYMDBGkuhiH9nVPevH
 aqPITVJCXF+TiD+2ViAIrF2axkVvYqnQ5SO2THmqFO09awqmzu+eBX2rjCyMbecbj9
 nal0XRcakyg/g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 0/2] Two linux-user patches
Date: Thu, 12 Mar 2026 21:12:37 +0100
Message-ID: <20260312201239.2976-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Two linux-user patches from Razvan Ghiorghe.

They were sent to the mailing lists but were lacking review.
I think they are OK, if other people want to review too, it would be good.

Helge

Razvan Ghiorghe (2):
  linux-user: Fix zero_bss for RX PT_LOAD segments
  linux-user: fix mremap with old_size=0 for shared mappings

 linux-user/elfload.c | 37 +++++++++++++++++++------------
 linux-user/mmap.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 14 deletions(-)

-- 
2.53.0


