Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0436C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJM8-0006Tq-1S; Thu, 03 Jul 2025 08:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXJLj-0005ZC-1y; Thu, 03 Jul 2025 08:47:35 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXJLc-0006nf-Kh; Thu, 03 Jul 2025 08:47:34 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a1:0:640:2691:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9190C60CB6;
 Thu,  3 Jul 2025 15:47:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:73d::1:28])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HlbMgQ0FgSw0-lL0VE4wy; Thu, 03 Jul 2025 15:47:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1751546838;
 bh=hq6V6uflMOSBGjAJUQvVdn0SrJXvUbjye4yUVj6zCpM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Ez0YO6VJkLsVfvxOYqr7NsIa5y6EwLpUhjZ51NG/M0PfCAQgPKQW079+/geNLraXq
 PGPJjp4zZbV1MVkHtUwISZC3eLYW9wvtowMrM9Dv70/Mt1kt52AYtxlXudT5YZsbDx
 idkQt+RB31jv1KDlCN7MN1R7qN85IGcW0tny5x3I=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: qemu-block@nongnu.org, fam@euphon.net, pbonzini@redhat.com,
 jasowang@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 sgarzare@redhat.com, raphael@enfabrica.net,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 0/4] vhost: drop backend_features
Date: Thu,  3 Jul 2025 15:47:08 +0300
Message-ID: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

This field is mostly unused and sometimes confusing (we even have
a TODO-like comment to drop it). Let's finally do.

Vladimir Sementsov-Ogievskiy (4):
  vhost: introduce vhost_ops->vhost_set_vring_enable_supported method
  vhost-user: stop use backend_features
  vhost_net: stop use backend_features
  hw/vhost: finally drop vhost_dev.backend_features field

 hw/block/vhost-user-blk.c         |  1 -
 hw/net/vhost_net.c                | 14 ++++++--------
 hw/scsi/vhost-scsi.c              |  1 -
 hw/scsi/vhost-user-scsi.c         |  1 -
 hw/virtio/vdpa-dev.c              |  1 -
 hw/virtio/vhost-user.c            | 25 ++++++++++++++++---------
 hw/virtio/vhost.c                 | 15 ++++++---------
 hw/virtio/virtio-qmp.c            |  2 --
 include/hw/virtio/vhost-backend.h |  2 ++
 include/hw/virtio/vhost.h         |  7 -------
 10 files changed, 30 insertions(+), 39 deletions(-)

-- 
2.48.1


