Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6FAC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wom6T-0004Qw-Tm; Tue, 28 Jul 2026 14:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wom6S-0004QN-Hv; Tue, 28 Jul 2026 14:00:32 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wom6Q-0001WS-UZ; Tue, 28 Jul 2026 14:00:32 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 2C924EC03EB;
 Tue, 28 Jul 2026 14:00:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 28 Jul 2026 14:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785261630; x=
 1785348030; bh=0UxCNZQ9F7PlpoN+MQGsJgZorVksKnCQBGgUNpiTpCM=; b=F
 +GwSO3NcxyopVwHYgMfUHr0j4KDe/4RlvRzy6dbIa7Qm6btrgz/HOdJ947bMOjLJ
 6x0PuCB/QQMmJRn8GlLZN6su1zvvzs2jgebvXnJCuXlvT09wOd/XoolEep0fspS/
 13uYsrLk2idKRvpJq9nph9QgKcj68DLGQK2PYjd6JniJ5kH1Q8QNX5k6B2glcCec
 Q+Ple6vTsqcEc4+ppN75o5RGd7uMDkuU6Yw/UXmSWXGFuMZEijgQvhS5gBjqMY2d
 pSH0p+DE1T8ydAJJd64pGfg96q3Ymg9ECIQeQ8/tthfVkb8J3WDh/wjRGsOSCfBn
 reNUVVEsTRXEycgNltqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1785261630; x=1785348030; bh=0
 UxCNZQ9F7PlpoN+MQGsJgZorVksKnCQBGgUNpiTpCM=; b=RZ2gjOEf853HizKN3
 esewiRQfTpSH7SVuu702WDergkRkzfdDcf0qC6K42SGVv4Kub6vyKQozkHSZfJe8
 w5dMYktAmjlfye0Ur8h5ur15Z52QBLll6rstX0yCYVKfjenPqpwJEitB7mm6Mk0i
 s6AcAwcMJBa8H0y0Zyv6OxCkVxWV7kAF3gTArkBieSuM8LDSIX/mBK1YFLDzpdUg
 OK1pUUDGQBHeSFkBWrujcVwhFSSfKC+poEL8tcwWQQcFZnb+x5nWqnARPyOzqHJQ
 1DIeoZfbIeuNZKf9bpGMOTju9dhtKCTMtIrJFlDc2dYXW4ma170nlS2pwYiFgJnw
 d4Ndw==
X-ME-Sender: <xms:Pu5oai01GXEHJzt3TsbR5OpC9PyXHtGAjA3Ovy1OZYdXxXpsQ2g7wA>
 <xme:Pu5oavJxSytpxGDTCVHRZL0y1B_Z2aUYPVMNGjQAL0GthLOVQ9BqDm53ayfU6LCjI
 yOhdamjPKCJni90iKtX6Q6z2Wwwgj0xLeoeZZgzcXOtpiQv0iJZsv8>
X-ME-Received: <xmr:Pu5oaqxLcZIdE55m_QADd1pYlnnLSMlb308Ww-Yb8pPkw6UU0ssQ7Fba_KDpflsdpVy2fbYrGa8yUU9pv-_MizqNkekswTia3O0giLnS12GfFsf1QOtavMw1aA>
X-ME-Proxy-Cause: dmFkZTGovHU/Jy6CaBk54R1jIRhdXQCresAX0TH0VZyvhNaiVWlMPM4rPBCdSOqWvkbaIG
 Tp7zicu7DdDOjRz1mKYuyOPyDUqaAeSVRg19DOStxJypRIygut5dT7XVtGw9uEcM/C78WV
 y2ctbyIIq/ryoYwSHEGyiStrj4fCgd8yMV0fASQFl1bE2dnVe8iW5tPSEoZA/fMzM23oyP
 St1TE3aXfu0mb2XYfELsXBtOIn6dpk8qrIODShZv1vCpqd97o2CzeBzY4znLZrWJdDEU37
 CiT1d9w01x23+5FJKc4nck5OislmpYR+YOrwfddyRgXQlRyQBBF3CmidaJdwHe7RWSsRZT
 mVcV/LCjK3pd4s30j8xobyBZk5C1wfU4/DoSZB409UDHiL8rvwM3b5eLPHgA7hj6R/XKK2
 dHen/1oCIUOQU3jqX8pB6e8GACv5ZxAdRP+h+CN2Y6i19mqdmBF48LVrBJmqeyXfxxUYDk
 j1YrsVG6DTJli+fC7HzT3ZLFWBXhIul2J04F//Vb1ONghEQbSxmDOFWweifL6rrouJMBt0
 npOcjDY4jZWjLlu6r7hQiptUE0C/DpibELUcJCUfrG2wL08MAFXbmc6KrpXSghYnsUQ9IT
 5y31DkjwXrkkLQez1P5TylnZa3QSyMBSOVRX66xxjDg1xuLm1FYDzZJzt8DA
X-ME-Proxy: <xmx:Pu5oalW7Mp0LFxBO619CeWwdk_3lbXzgZ5OAuGf7mWuHxYV8_KjBQQ>
 <xmx:Pu5oaijf0H5asVZuL2mUGirjtqAhY3BlbYqpFGLMH52qMOA2RL6ySQ>
 <xmx:Pu5oatARNoV8zE64yzqCMsDcg_EU0ndTeI14QZt1IM_LvqxnlyMDpg>
 <xmx:Pu5oagsEBUBWcfTiEwS2LaJlM-V_dUemyBKbpKCu3dYDqw9H4zwlQA>
 <xmx:Pu5oamYIYikhiYsWg-H13lDFPXcfYqxyT192DlrJqQKIKGFCHR7OLZbt>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:00:28 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Paziyski <danielpaziyski@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 2/4] hw/nvme: fix assertion failure on subregion removal
Date: Tue, 28 Jul 2026 20:00:16 +0200
Message-ID: <20260728180018.3574-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728180018.3574-1-its@irrelevant.dk>
References: <20260728180018.3574-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.146; envelope-from=its@irrelevant.dk;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Daniel Paziyski <danielpaziyski@gmail.com>

When a controller is created with a MSI-X exclusive BAR, the bar0 memory region
is not used at all, and so, the iomem region is not added as a subregion of it.
However, when removing a NVMe controller, the iomem region is unconditionally
removed as a subregion of bar0, causing an assertion failure. Remove the iomem
memory region as a subregion of bar0 only if not using a MSI-X exclusive BAR.

QEMU options (requires a hotunplug-aware OS):

        -M q35 -device pcie-root-port,id=rp0 \
        -device nvme,serial=ctrl0,id=ctrl0,bus=rp0,msix-exclusive-bar=on

In the QEMU monitor, or by causing an ejection from the OS:

        device_del ctrl0

Message in stderr:

qemu-system-x86_64: ../system/memory.c:2617: memory_region_del_subregion: Assertion `subregion->container == mr' failed.

Fixes: fa905f65c554 ("hw/nvme: add machine compatibility parameter to enable msix exclusive bar")
Fixes: 9162f1012576 ("hw/nvme: fix msix_uninit with exclusive bar")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4090
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 086048b689d3..e1639b3839f7 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9703,10 +9703,9 @@ static void nvme_exit(PCIDevice *pci_dev)
         msix_uninit_exclusive_bar(pci_dev);
     } else {
         msix_uninit(pci_dev, &n->bar0, &n->bar0);
+        memory_region_del_subregion(&n->bar0, &n->iomem);
     }
 
-    memory_region_del_subregion(&n->bar0, &n->iomem);
-
     migrate_del_blocker(&n->migration_blocker);
 }
 
-- 
2.53.0


