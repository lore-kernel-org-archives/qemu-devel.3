Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E7F5A8B9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEv74-00064D-1W; Mon, 20 Apr 2026 16:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6u-00061q-DA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:48 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6s-0006PC-M6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 506098065E;
 Mon, 20 Apr 2026 23:20:44 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XKYwe10MOSw0-5C25wX48; Mon, 20 Apr 2026 23:20:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776716443;
 bh=lPTm4lB1KMVIObdOQC42DUGkZOA7pP1fBuHvzYw7yJ8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZHKU8b3MH1jNXp3ZXrAr4+jEjHK1A3nlyzK8ihyzGZEull7QfnjMwwnm5MSagvABZ
 8ZB3khvjBsXK+kvNaQPTEX9eMM/oQ+lYC71ql7+/RPyOIyljrGFxL9e+UUchCcqj6Q
 Kum86iGkIlN0Xv+MXZKFbXG3Gs5Z0TTi9/hvYmds=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 06/10] qapi: remove user addresses from
 x-query-virtio-vhost-queue-status
Date: Mon, 20 Apr 2026 23:20:27 +0300
Message-ID: <20260420202032.714884-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420202032.714884-1-vsementsov@yandex-team.ru>
References: <20260420202032.714884-1-vsementsov@yandex-team.ru>
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

Semantics of these (actually, internal) fields is not simple, they may
contain either virtual or physical addresses. We are going to change
this to simplify the logic. Keeping this logic only for unstable
info command seems too much. Changing semantics of info fields doesn't
seem to make real sense too. So, let's just drop them. We can dot it,
as command is experimental.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-hmp-cmds.c |  3 ---
 hw/virtio/virtio-qmp.c      |  3 ---
 qapi/virtio.json            | 15 ---------------
 3 files changed, 21 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 4bf9a3109d4..a91bb7dbeda 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -203,15 +203,12 @@ void hmp_vhost_queue_status(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "  call:                 %"PRId64"\n", s->call);
     monitor_printf(mon, "  VRing:\n");
     monitor_printf(mon, "    num:         %"PRId64"\n", s->num);
-    monitor_printf(mon, "    desc:        0x%016"PRIx64"\n", s->desc);
     monitor_printf(mon, "    desc_phys:   0x%016"PRIx64"\n",
                    s->desc_phys);
     monitor_printf(mon, "    desc_size:   %"PRId32"\n", s->desc_size);
-    monitor_printf(mon, "    avail:       0x%016"PRIx64"\n", s->avail);
     monitor_printf(mon, "    avail_phys:  0x%016"PRIx64"\n",
                    s->avail_phys);
     monitor_printf(mon, "    avail_size:  %"PRId32"\n", s->avail_size);
-    monitor_printf(mon, "    used:        0x%016"PRIx64"\n", s->used);
     monitor_printf(mon, "    used_phys:   0x%016"PRIx64"\n",
                    s->used_phys);
     monitor_printf(mon, "    used_size:   %"PRId32"\n", s->used_size);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 51e3a42c4c4..ae9be0a00f4 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -794,9 +794,6 @@ VirtVhostQueueStatus *qmp_x_query_virtio_vhost_queue_status(const char *path,
     status->name = g_strdup(vdev->name);
     status->kick = hdev->vqs[queue].kick;
     status->call = hdev->vqs[queue].call;
-    status->desc = (uintptr_t)hdev->vqs[queue].desc;
-    status->avail = (uintptr_t)hdev->vqs[queue].avail;
-    status->used = (uintptr_t)hdev->vqs[queue].used;
     status->num = hdev->vqs[queue].num;
     status->desc_phys = hdev->vqs[queue].desc_phys;
     status->desc_size = hdev->vqs[queue].desc_size;
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 671f1ad793c..1fc4e38a44d 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -650,12 +650,6 @@
 #
 # @call: vhost_virtqueue call
 #
-# @desc: vhost_virtqueue desc
-#
-# @avail: vhost_virtqueue avail
-#
-# @used: vhost_virtqueue used
-#
 # @num: vhost_virtqueue num
 #
 # @desc-phys: vhost_virtqueue desc_phys (descriptor area physical
@@ -678,9 +672,6 @@
   'data': { 'name': 'str',
             'kick': 'int',
             'call': 'int',
-            'desc': 'uint64',
-            'avail': 'uint64',
-            'used': 'uint64',
             'num': 'int',
             'desc-phys': 'uint64',
             'desc-size': 'uint32',
@@ -720,12 +711,9 @@
 #              "avail-size": 2054,
 #              "desc-size": 16384,
 #              "used-size": 8198,
-#              "desc": 140141447430144,
 #              "num": 1024,
 #              "call": 0,
-#              "avail": 140141447446528,
 #              "desc-phys": 5216108544,
-#              "used": 140141447448640,
 #              "kick": 0
 #          }
 #        }
@@ -744,12 +732,9 @@
 #              "avail-size": 262,
 #              "desc-size": 2048,
 #              "used-size": 1030,
-#              "desc": 140141413580800,
 #              "num": 128,
 #              "call": 0,
-#              "avail": 140141413582848,
 #              "desc-phys": 5182259200,
-#              "used": 140141413583168,
 #              "kick": 0
 #          }
 #        }
-- 
2.52.0


