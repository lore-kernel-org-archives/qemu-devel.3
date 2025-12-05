Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680BDD339B9
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 18:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRamJ-0003HI-1z; Fri, 05 Dec 2025 13:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRamH-0003Gn-89
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:43:37 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRamF-0002TD-07
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:43:36 -0500
DKIM-Signature: a=rsa-sha256; bh=kAde7XxRCHgMXMxz+/cY/usdYPR6Tnh5CaGvxuN3Kqc=; 
 c=simple/simple; d=git.sr.ht; h=From:Date:Subject:Reply-to:To;
 q=dns/txt; s=20240113; t=1764960213; v=1;
 b=UQLGOzBcCPThkHVZJMvth0qvapQVGIt4rYU8k15hT21R5ZBQYnjkx8DcwtsEX8Egzlo8aEwN
 xGv2MaC6rlTW96Tax8ZDkvyvfzdQYiC7sDlmHLOh4pnFN/D9F3btb6C29OxHmERLVIUpfTfpw+z
 zryedamiYscOCLLILEeazRLp5wPIKtSECGf0HVCPgaTl63RgC+fwpSYT7VlyA/G5uqD7u50ewjn
 pr7T5hqfSY4PEA35pYFtfMfje6tmvUv4874hGQnLJX4uj3+KDceuVJwyKC5ETaDauK4AXC/wlN2
 0D3BYQnGjEl95woHNOB7LL3oY7L2zAgtwKef4BBlW0gIA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 55B46243C6
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 18:43:33 +0000 (UTC)
From: ~katharine_chui <katharine_chui@git.sr.ht>
Date: Fri, 05 Dec 2025 18:43:33 +0000
Subject: [PATCH qemu 0/1] hw/input/virtio-input-hid: remove mouse buttons on
 virtio-multitouch-pci
MIME-Version: 1.0
Message-ID: <176496021331.28461.6801034554708153621-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~katharine_chui <kwchuiaa@connect.ust.hk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Having mouse buttons on the multitouch devices causes ui mouse button
events to get routed to the multitouch device, despite having better
options such as a single point tablet or a mouse.

This change fixes Android guests behavior when having both a mouse and a
multitouch device present.

Katharine Chui (1):
  hw/input/virtio-input-hid: remove mouse buttons on
    virtio-multitouch-pci

 hw/input/virtio-input-hid.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.49.1

