Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460E6F5A8BB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEv6s-00061K-Uw; Mon, 20 Apr 2026 16:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6r-000605-6A
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:45 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6n-0006OB-Pz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 76E14C01B9;
 Mon, 20 Apr 2026 23:20:40 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XKYwe10MOSw0-PLmp6qr4; Mon, 20 Apr 2026 23:20:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776716439;
 bh=AdsEQBGwBfFwazXQMva35ewY0KaErdEqggC3bArJp8o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FwiB+2VcqbqwsvBO23y46V8eCv8rUBrbKp6AXXnOvKpC+Ha5gUJiLL1tqJZkbib6f
 W/Xuy3p4yJ/h8WuDQ6KUh9+e9pdPFQ/RXs+ZiY5ECja/6SLNrPbJMQQAPFxMzgo1Ro
 g2DuDpXcvkIoTS1MBUdjMKaC8fxHRYABfEyVs8/M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v2 03/10] vhost: rename vhost-backend.c to vhost-kernel.c
Date: Mon, 20 Apr 2026 23:20:24 +0300
Message-ID: <20260420202032.714884-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420202032.714884-1-vsementsov@yandex-team.ru>
References: <20260420202032.714884-1-vsementsov@yandex-team.ru>
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

This file is totally about vhost-kernel implementation, not generic
code. Let's finally give it corresponding name.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/meson.build                         | 2 +-
 hw/virtio/{vhost-backend.c => vhost-kernel.c} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/virtio/{vhost-backend.c => vhost-kernel.c} (99%)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index adc3a4f748a..fbc1b1ad121 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -14,7 +14,7 @@ system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
   system_virtio_ss.add(files('vhost.c'))
-  system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
+  system_virtio_ss.add(files('vhost-kernel.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     system_virtio_ss.add(files('vhost-user.c'))
     system_virtio_ss.add(files('vhost-user-base.c'))
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-kernel.c
similarity index 99%
rename from hw/virtio/vhost-backend.c
rename to hw/virtio/vhost-kernel.c
index caeadd069b0..3390b48c6f1 100644
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


