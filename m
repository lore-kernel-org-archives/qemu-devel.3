Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34058C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGw4-0000JR-CW; Mon, 01 Jul 2024 09:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sOGvq-0000Az-IL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:18:58 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sOGvc-0007tG-SN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=8xAKxtEppAGTrzSC7hkh2NY6ILtcWHOkPPKuetf/ogM=; b=E48/+u9bo1hdCrtB6RM0TwoNrH
 i3kYaf76WGDdto0mbIAStw0T/nG5eHyVpX5UigxiuJjPcFcXgtwVJlpniomkU/OG+U81M3ot9wohP
 dbjgOYjJ70qCXECJKfigSif7a+hhKyz38zKDB6K/iuE8szhsFXbHxkByTSLW6mlMicOg=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sOGvZ-0006nc-Iq; Mon, 01 Jul 2024 13:18:41 +0000
Received: from lfbn-lyo-1-451-148.w2-7.abo.wanadoo.fr ([2.7.43.148]
 helo=l14.home) by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sOGvZ-0000WF-75; Mon, 01 Jul 2024 13:18:41 +0000
From: anthony@xenproject.org
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>
Subject: [PULL 0/3] xen queue 2024-07-01
Date: Mon,  1 Jul 2024 15:18:30 +0200
Message-Id: <20240701131833.29486-1-anthony@xenproject.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Anthony PERARD <anthony@xenproject.org>

The following changes since commit b6d32a06fc0984e537091cba08f2e1ed9f775d74:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-06-30 16:12:24 -0700)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20240701

for you to fetch changes up to 410b4d560dfa3b38a11ad19cf00180238651d9b7:

  xen-hvm: Avoid livelock while handling buffered ioreqs (2024-07-01 14:57:18 +0200)

----------------------------------------------------------------
Xen queue:

* Improvement for running QEMU in a stubdomain.
* Improve handling of buffered ioreqs.

----------------------------------------------------------------
Marek Marczykowski-Górecki (2):
      hw/xen: detect when running inside stubdomain
      xen: fix stubdom PCI addr

Ross Lagerwall (1):
      xen-hvm: Avoid livelock while handling buffered ioreqs

 hw/i386/xen/xen-hvm.c        | 22 +++++++++++++
 hw/xen/xen-host-pci-device.c | 76 +++++++++++++++++++++++++++++++++++++++++++-
 hw/xen/xen-host-pci-device.h |  6 ++++
 hw/xen/xen-hvm-common.c      | 26 +++++++++------
 include/hw/xen/xen.h         |  1 +
 system/globals.c             |  1 +
 6 files changed, 122 insertions(+), 10 deletions(-)

