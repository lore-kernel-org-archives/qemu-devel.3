Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FABC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 14:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURkl-0001Ok-LY; Thu, 18 Jul 2024 10:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1sURkU-0000UE-IX
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 10:04:48 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1sURkQ-0000Np-WB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 10:04:46 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2DCE845409;
 Thu, 18 Jul 2024 16:04:27 +0200 (CEST)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] guest-agent: document allow-rpcs in config file section
Date: Thu, 18 Jul 2024 16:04:07 +0200
Message-Id: <20240718140407.444160-1-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

While the `allow-rpcs` option is documented in the CLI options
section, it was missing in the section about the configuration file
syntax.

And while it's mentioned that "the list of keys follows the command line
options", having `block-rpcs` there but not `allow-rpcs` seems like
being a potential source of confusion; and as it's cheap to add let's
just do so.

Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 docs/interop/qemu-ga.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index 72fb75a6f5..dd4245ece8 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -131,6 +131,7 @@ fsfreeze-hook  string
 statedir       string
 verbose        boolean
 block-rpcs     string list
+allow-rpcs     string list
 =============  ===========
 
 See also
-- 
2.39.2



