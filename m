Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348A4CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4O0-0005U5-F6; Sun, 10 May 2026 09:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wM1r4-0003Me-KJ
 for qemu-devel@nongnu.org; Sun, 10 May 2026 06:57:50 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wM1r2-0005aB-Ue
 for qemu-devel@nongnu.org; Sun, 10 May 2026 06:57:50 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 693BF240028
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 12:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1778410666; bh=esBSPi0hDmnK7Ye2hIFKrdURpFYsmUHOwIBHHV3vzkk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=A4GFpN1H78eAR4XbK1BTWfytUdaU0xYRBsQBsQ6ODzR3zQFAZTMKV/w/4H5b35D28
 y5G+P93nGZdElndXYWAGFdwLMUF5e/P/Ishk/wCuPam4R6n5TZbRU/XR+U71U4FrKk
 8/ki/ZczIYIZCxHPZSdLdmpfWmmvq8a0di5OHkVydqX0EZWsxVWjsb/wjUXCpuvTma
 fpoHoCCkLQ7TdnHcq6sMIQVwPWnyd/YdjChuTYV2zL5g7yt1QuIMCz5xROYZEVE0Ak
 uJzCHnu5Oi4yk4MStRkUlTyQzku33gDVgZ9l6g8Gc+8RBwTh2BHTPpIETCdZYqIzD8
 3VRLDgN6QcbmQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gD0F569t3z9rxG;
 Sun, 10 May 2026 12:57:45 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	Mateusz Nowicki <mateusz.nowicki@posteo.net>
Subject: [PATCH 0/2] hw/nvme: add monitor commands for inspecting state
Date: Sun, 10 May 2026 10:57:46 +0000
Message-ID: <cover.1778409416.git.mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 10 May 2026 09:39:59 -0400
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

Add two HMP commands for inspecting emulated NVMe controllers from
the QEMU monitor without attaching gdb to the QEMU process:

  - 'info nvme'        - per-controller summary (PCI, identify
                         fields, CC/CSTS/AQA, queue counts)
  - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
                         (size, head/tail, PRP1, doorbell offset,
                         phase tag)

Useful for verifying queue setup, doorbell rings, AERs held in the
admin SQ and similar driver/controller interaction details from a
running QEMU monitor.

Mateusz Nowicki (2):
  hw/nvme: add 'info nvme' HMP command
  hw/nvme: add 'info nvme-queues' HMP command

 hmp-commands-info.hx |  28 +++++++++
 hw/nvme/meson.build  |   2 +-
 hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json    |  34 +++++++++++
 4 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 hw/nvme/monitor.c

-- 
2.53.0


