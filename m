Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1546C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x55gW-0005QD-0r; Fri, 11 Sep 2026 14:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gP-0005Oo-8u
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:05 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gL-0000Ga-IJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id D2D50C0B5A;
 Fri, 11 Sep 2026 21:08:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:641::1:4])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id u8VTLcTagiE0-r7jfOqqL; Fri, 11 Sep 2026 21:08:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789150138;
 bh=bDBpFtIKDIsDfvNAayyEq2eJ3vPvRyYwUiWc7/ztv1E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=hgG/Y3qHGim6p6REkO685o2LAsbXDioZdTBlX0TFpsT+xaV33G8lPG+7vpYEfXgLG
 a48kjDYSCytkLYOffEKL7HQbZfzu0AbRz80NZFQKzb2bAnxk/AbTWtbdsbzQnHgUAa
 KyW8qTQYOUsQnbZ5VXsxmeWfGPhXJJHGqbZGuhRg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, sgarzare@redhat.com,
 mst@redhat.com, jag.raman@oracle.com, elena.ufimtseva@oracle.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/4] remote/iohub: stop  set event notifiers to -1
Date: Fri, 11 Sep 2026 21:08:52 +0300
Message-ID: <20260911180854.123969-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911180854.123969-1-vsementsov@yandex-team.ru>
References: <20260911180854.123969-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

No reason to do it, the notifiers are zeroed out, so fd getter
will report -1 correctly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/remote/iohub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
index 988d3285ccc..58a6e5b4280 100644
--- a/hw/remote/iohub.c
+++ b/hw/remote/iohub.c
@@ -28,8 +28,6 @@ void remote_iohub_init(RemoteIOHubState *iohub)
     for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
         qemu_mutex_init(&iohub->irq_level_lock[pirq]);
         iohub->irq_level[pirq] = 0;
-        event_notifier_init_fd(&iohub->irqfds[pirq], -1);
-        event_notifier_init_fd(&iohub->resamplefds[pirq], -1);
     }
 }
 
-- 
2.43.0


