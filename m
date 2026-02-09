Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEDAE7C706
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrs-0000qe-TY; Mon, 09 Feb 2026 02:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrh-0000nA-0Q
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:27 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrb-0004fc-CK
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:23 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 65F868075A;
 Mon, 09 Feb 2026 10:39:15 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-eKWgaYqz; Mon, 09 Feb 2026 10:39:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622755;
 bh=2+BGCbjgcTW3vo09EmDCFSrvobdDCXvLg87DyZZkk4Y=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nUC/JHL+NWxmAmNI82xlWNLA2EsTZQiZAvF7dPySJW1YU/SwKtNehG2tfuSxvGYsJ
 N+Cm1gF90UlW08d/X1v1zHj0MmOFPtzhj4EYHDyRaGnpdS8g6QqRlRYTqlJPZzUfra
 YYPZqeJSDKb2obceEjlG1MtBC8qMunTk9M2C+zlY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 03/10] vhost: rename vhost-backend.c to vhost-kernel.c
Date: Mon,  9 Feb 2026 10:39:00 +0300
Message-ID: <20260209073908.2125178-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

This file is totally about vhost-kernel implementation, not generic
code. Let's finally give it corresponding name.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/meson.build                         | 2 +-
 hw/virtio/{vhost-backend.c => vhost-kernel.c} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/virtio/{vhost-backend.c => vhost-kernel.c} (99%)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 6675b63ce6..9506a2185c 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -15,7 +15,7 @@ specific_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
   system_virtio_ss.add(files('vhost.c'))
-  system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
+  system_virtio_ss.add(files('vhost-kernel.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     # fixme - this really should be generic
     specific_virtio_ss.add(files('vhost-user.c'))
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-kernel.c
similarity index 99%
rename from hw/virtio/vhost-backend.c
rename to hw/virtio/vhost-kernel.c
index caeadd069b..3390b48c6f 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-kernel.c
@@ -1,5 +1,5 @@
 /*
- * vhost-backend
+ * vhost-kernel
  *
  * Copyright (c) 2013 Virtual Open Systems Sarl.
  *
-- 
2.52.0


