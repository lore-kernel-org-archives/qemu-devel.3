Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8E0C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 08:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sasnJ-0005bl-Lp; Mon, 05 Aug 2024 04:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gorg@gorgnet.net>) id 1sao8P-0008Jc-VZ
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 23:11:46 -0400
Received: from gorgnet.net ([2a01:4f9:c012:ca43::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gorg@gorgnet.net>) id 1sao8N-0007kq-Pm
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 23:11:45 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple;
 d=gorgnet.net; s=b1; x=1723432298; q=dns/txt; h=Received:
 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding; bh=12ZBLluo2
 HT3x9B1em7w3Kj1MlSenqoqprkQNsCQdhw=; b=QiRw7SIHjjTOi8jDtDhLxFbIS
 QLZ+osZQXdT9+151rpdcV4mVQXu4oNMc5bZMSUqdZBDK7LAYW45yqFFCxL+CA==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=gorgnet.net; s=a1; x=1723432298; q=dns/txt; h=Received:
 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding; bh=12ZBLluo2
 HT3x9B1em7w3Kj1MlSenqoqprkQNsCQdhw=; b=sMgmL59RND/qSHgII5nsOvLjC
 vtrX9iknOXqKMSIy+5VJRvdMeE72nwgG73PafLFLxFQwBUQOwCbvr+GK+nFsQJLA
 oAOG44MFxArzIQvkN38sCGb6wZcJqlrLSGO1KOfngQ5U4Rg/y4Fe67VgvyVFq3L4
 n/TpREoLwUY2whIPzcaijbPvLNgPK5LlIt4cEKQ8MKjeZQYuj7roOPk57sZjpgoD
 XoCkoQvaV+543TSlTla9NyjPu9oGvRZTiQMvB/BdAntBOnWsyr9LsvYPIG5x3P33
 3hAgn/J2PqziGGmMpd+2lNBcTj9kzmfjsDRVmuTpGaG/r7canIkzWo3rF80DA==
Received: (qmail 9682 invoked from network); 5 Aug 2024 03:11:37 -0000
Received: from unknown (HELO localhost.localdomain)
 (gorg@gorgnet.net@73.203.127.165)
 de/crypted with TLSv1.2: ECDHE-ECDSA-CHACHA20-POLY1305 [unknown/unknown] 
 DN=none by 0 with ESMTPSA; 5 Aug 2024 03:11:37 -0000
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 George Matsumura <gorg@gorgnet.net>
Subject: [PATCH 2/2] docs/specs/pci-ids: Fix markup
Date: Sun,  4 Aug 2024 21:10:13 -0600
Message-ID: <20240805031012.16547-4-gorg@gorgnet.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805031012.16547-2-gorg@gorgnet.net>
References: <20240805031012.16547-2-gorg@gorgnet.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:c012:ca43::1;
 envelope-from=gorg@gorgnet.net; helo=gorgnet.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Aug 2024 04:10:15 -0400
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
Reply-to:  George Matsumura <gorg@gorgnet.net>
From:  George Matsumura via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This fixes the markup of the PCI and PCIe Expander Bridge entries to be
consistent with the rest of the file.

Signed-off-by: George Matsumura <gorg@gorgnet.net>
---
 docs/specs/pci-ids.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 0de13de1e4..328ab31fe8 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -77,11 +77,11 @@ PCI devices (other than virtio):
 1b36:0008
   PCIe host bridge
 1b36:0009
-  PCI Expander Bridge (-device pxb)
+  PCI Expander Bridge (``-device pxb``)
 1b36:000a
   PCI-PCI bridge (multiseat)
 1b36:000b
-  PCIe Expander Bridge (-device pxb-pcie)
+  PCIe Expander Bridge (``-device pxb-pcie``)
 1b36:000c
   PCIe Root Port (``-device pcie-root-port``)
 1b36:000d
-- 
2.46.0


