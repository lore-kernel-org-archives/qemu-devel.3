Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEE0CF395D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 16:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srKUh-0003B6-RL; Thu, 19 Sep 2024 12:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srKUd-000393-Ox
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:59:00 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srKUc-0003WE-5a
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=paArsq8B/xQtWlfFSUoPzyLiRnDPR8ij/Fkfe6DhQvM=; b=K1b/ur+U6uMsc1NO
 ttY6DagmhRgsvhwyjxxBYZz+5xEVekDp+/KC5e1zOnYLnJLQgmKY8QBrkoF3LwaX0KSyOsROeZdBa
 7Ws2pmMo0heeKVABBOgic8ZbomS1DObXaA/EX7dH29SMX5MDVPFafPi2jQZ4UEIL3iLo6cVsy0q5W
 oxiQux/+8U9wx6z+cShE4dcOm0sDuInz1AMGls37rG/YNegZ5qsD4CfBy0qWfkuLP/oqS31lTB+FM
 NBgg+6g3WX5JzDuch5uhyuw1Vig6+VrE4+e1v8CU+h9MXAZD5lXpWUX0sn4sE6zjgEf6p9Raz/XF/
 5l3eaO6PDsN10UvGLA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srKUX-006SNU-2J;
 Thu, 19 Sep 2024 16:58:53 +0000
From: dave@treblig.org
To: elena.ufimtseva@oracle.com,
	jag.raman@oracle.com,
	qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] remote: Remove unused remote_iohub_finalize
Date: Thu, 19 Sep 2024 17:58:52 +0100
Message-ID: <20240919165852.322707-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

remote_iohub_finalize has never been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/remote/iohub.c         | 13 -------------
 include/hw/remote/iohub.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
index 40dfee4bad..988d3285cc 100644
--- a/hw/remote/iohub.c
+++ b/hw/remote/iohub.c
@@ -33,19 +33,6 @@ void remote_iohub_init(RemoteIOHubState *iohub)
     }
 }
 
-void remote_iohub_finalize(RemoteIOHubState *iohub)
-{
-    int pirq;
-
-    for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
-        qemu_set_fd_handler(event_notifier_get_fd(&iohub->resamplefds[pirq]),
-                            NULL, NULL, NULL);
-        event_notifier_cleanup(&iohub->irqfds[pirq]);
-        event_notifier_cleanup(&iohub->resamplefds[pirq]);
-        qemu_mutex_destroy(&iohub->irq_level_lock[pirq]);
-    }
-}
-
 int remote_iohub_map_irq(PCIDevice *pci_dev, int intx)
 {
     return pci_dev->devfn;
diff --git a/include/hw/remote/iohub.h b/include/hw/remote/iohub.h
index 6a8444f9a9..09ee6c77b6 100644
--- a/include/hw/remote/iohub.h
+++ b/include/hw/remote/iohub.h
@@ -37,6 +37,5 @@ void remote_iohub_set_irq(void *opaque, int pirq, int level);
 void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg);
 
 void remote_iohub_init(RemoteIOHubState *iohub);
-void remote_iohub_finalize(RemoteIOHubState *iohub);
 
 #endif
-- 
2.46.1


