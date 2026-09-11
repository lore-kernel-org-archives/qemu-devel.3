Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71187C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9B-0002Fs-Tp; Fri, 11 Sep 2026 05:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x92-00027u-UY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x91-00086S-2W
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ym7KMRqUcvU4ABujQuwWyzRgxAgmuy8bm1077mgBw+A=;
 b=U2ixPvN0FxTtBdg2cFJEaS1qAu4BwluLbRg0bgAM+T8psJYftiIoMTerxqxLd0Wy25VUST
 loBlIuV08OR0vO8sg4uJNm+rZayAhv+8KvxcmO7Ne7dOacA5s49V/HIpNkWylYP1Los4it
 HB5x918fpSH/iplb0/AZb5CsLgv7dbM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-bgc80lx6OICt9u2wlmV7Sg-1; Fri, 11 Sep 2026 05:01:58 -0400
X-MC-Unique: bgc80lx6OICt9u2wlmV7Sg-1
X-Mimecast-MFC-AGG-ID: bgc80lx6OICt9u2wlmV7Sg_1789117317
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49d1a778b9dso6290095e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117317; x=1789722117; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ym7KMRqUcvU4ABujQuwWyzRgxAgmuy8bm1077mgBw+A=;
 b=sFg5b8J7W70EGr13IMFlwb+Ormmn1msHiCyDEMKUsARBbfc4xne+6eQyKR/HSvs1sF
 H2jozykjvfIcZkoWLMxuiGRzdarbpNENvq2B3Jc7YufWYdB6GjzQA5zJYCCgh8knSa5c
 P38jz82IfpKmvhDIrnWEkv/vt2bomohDOaiwyS9bPOwmgnhZyfUL8aY+WjfXF0pgFvoL
 J33IQ7xeO406bBELMNYtYW38Q8pWYlX0uAp2XtHM/ls1G8BbOnZE/Uj5tFII02By2lCc
 zjOTm4nDEETIjVdtGfW74g06MqkLwBG7Tr+rYM9z/aEfQxsXTr+sZjypJyYorSrRYacQ
 IEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117317; x=1789722117;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ym7KMRqUcvU4ABujQuwWyzRgxAgmuy8bm1077mgBw+A=;
 b=Lo9ALlHN9KtkN917Ata8B5hgfzRgvvJdHohUMDBSqrB2cVeGupSSGaIGVoZLtLS6Sh
 Kk+X2b6+Y01gIHq14yQhKaGso/oqllZfnl9XYKKkkIOBJ2AzJkBBRyiVUS42R3T7FVY1
 hNfKLOTb+ynIMb222wHesho785QUrTDZfUVYKp0Hd9LJWNcUOoT99Dlm4iM0/bYFQ85N
 uWEIlWfBd3YUrhqvv1WGLtpMMU/720JjsTwayu7t0N0iTPkfT70I5fgx/zRM5HZCEnup
 yIJeKQb1lVzQZUIVcZ3/oUnmdbERhXPnHdLEMaYH98w0ZsY58dz7KexixL3nW9kU27sb
 IA2w==
X-Gm-Message-State: AFuF++kXh4kGlTbT81FRoKih8T4Fo1GrJua5ED8bp3jdzTAq9VBftu4v
 yyVEP1EYNo76J8XRZT0ydKf/jdjMuVH5qXHficG5IpcAvhuyEjkaT2cVM4vaEeueNBcRyW0St8/
 0xCdQ7WnxIjqlkiuGPvAFHDVBOWBRkqMU93ahVLMff5RlkKaXwfO/EwXSVI02q+V77qPAyPsI+6
 25Sx4y0pNHJLcp0oIu3zK4MgrFtDTCsUNFrg==
X-Gm-Gg: AYBFou3+g1avi2Gt50Kr8HZnuPMfRYhA2vRICVzJ1fUjpeQSwOzCBdPTXOSGZS7DoCt
 ezI2QC1411Dv5pH06l8pMUMNEsWr+8A6p8krFbN0pcMqNc60k4I4fSsKFYAuj2Wm8SzWdQ7Opdi
 y2K/VIp8U1a+gsyuZxwASPD38gbLSTIgvS1bHCJuJemkx3Sc/Ho5xnB0AOQdLTbGzql76/XJ8du
 VyNkSf8CBt+pZubhJ7UoL3T1g7Za8bK6HZwVwovFAWgR8dEvRPFIbtEIcGwDMgKjHFgdXLhVBVM
 biO/mWQqkfpFmurx1nhkoIQDctfRW2bLCJowPjmUEYfzpSwzd1IqHwpJ9zxg/tJqWExgXuEj+zW
 Ri6oYBBGYnAzriPm7XH2f+ss=
X-Received: by 2002:a05:600c:4505:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49e61a03b32mr62613895e9.13.1789117316826; 
 Fri, 11 Sep 2026 02:01:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4505:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49e61a03b32mr62612785e9.13.1789117316260; 
 Fri, 11 Sep 2026 02:01:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ababd5sm80900555e9.4.2026.09.11.02.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:55 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 15/75] net/tap: QOMify tap backend
Message-ID: <e1c7f36f151c9fb06268ec75541c9a549c08b962.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We prepare for being able to migrate TAP backend. We'll need a
user change-able property for it, which can be set from machine
type. So, let's QOMify it first.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-8-vsementsov@yandex-team.ru>
---
 include/net/net.h |  7 +++++++
 include/net/tap.h |  2 ++
 net/net.c         | 14 +++++++-------
 net/tap.c         | 48 +++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 626b997948..ea07760b56 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -161,6 +161,13 @@ char *qemu_mac_strdup_printf(const uint8_t *macaddr);
 NetClientState *qemu_find_netdev(const char *id);
 int qemu_find_net_clients_except(const char *id, NetClientState **ncs,
                                  NetClientDriver type, int max);
+void qemu_net_client_setup(NetClientState *nc,
+                           NetClientInfo *info,
+                           NetClientState *peer,
+                           const char *model,
+                           const char *name,
+                           NetClientDestructor *destructor,
+                           bool is_datapath);
 NetClientState *qemu_new_net_client(NetClientInfo *info,
                                     NetClientState *peer,
                                     const char *model,
diff --git a/include/net/tap.h b/include/net/tap.h
index 6f34f13eae..268570571f 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -28,6 +28,8 @@
 
 #include "standard-headers/linux/virtio_net.h"
 
+#define TYPE_TAP_NETDEV "tap-netdev"
+
 int tap_enable(NetClientState *nc);
 int tap_disable(NetClientState *nc);
 
diff --git a/net/net.c b/net/net.c
index 1161183e18..d7fa637ce5 100644
--- a/net/net.c
+++ b/net/net.c
@@ -261,13 +261,13 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
                                        int iovcnt,
                                        void *opaque);
 
-static void qemu_net_client_setup(NetClientState *nc,
-                                  NetClientInfo *info,
-                                  NetClientState *peer,
-                                  const char *model,
-                                  const char *name,
-                                  NetClientDestructor *destructor,
-                                  bool is_datapath)
+void qemu_net_client_setup(NetClientState *nc,
+                           NetClientInfo *info,
+                           NetClientState *peer,
+                           const char *model,
+                           const char *name,
+                           NetClientDestructor *destructor,
+                           bool is_datapath)
 {
     nc->info = info;
     nc->model = g_strdup(model);
diff --git a/net/tap.c b/net/tap.c
index bfed74717e..7392344200 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -43,6 +43,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "hw/virtio/vhost.h"
+#include "qom/object.h"
 
 #include "net/tap.h"
 #include "net/util.h"
@@ -68,7 +69,11 @@ static const int kernel_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
-typedef struct TAPState {
+OBJECT_DECLARE_SIMPLE_TYPE(TAPState, TAP_NETDEV)
+
+struct TAPState {
+    Object parent_obj;
+
     NetClientState nc;
     int fd;
     int vhostfd;
@@ -86,7 +91,7 @@ typedef struct TAPState {
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
-} TAPState;
+};
 
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
@@ -413,6 +418,19 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+
+static const TypeInfo tap_netdev_info = {
+    .name = TYPE_TAP_NETDEV,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(TAPState),
+};
+
+static void tap_net_client_destructor(NetClientState *nc)
+{
+    TAPState *s = container_of(nc, TAPState, nc);
+    object_unref(OBJECT(s));
+}
+
 /* fd support */
 
 static NetClientInfo net_tap_info = {
@@ -435,6 +453,18 @@ static NetClientInfo net_tap_info = {
     .get_vhost_net = tap_get_vhost_net,
 };
 
+static TAPState *new_tap(NetClientState *peer,
+                         const char *model,
+                         const char *name)
+{
+    TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
+
+    qemu_net_client_setup(&s->nc, &net_tap_info, peer, model, name,
+                          tap_net_client_destructor, true);
+
+    return s;
+}
+
 static TAPState *net_tap_fd_init(NetClientState *peer,
                                  const char *model,
                                  const char *name,
@@ -442,12 +472,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
                                  int vnet_hdr)
 {
     NetOffloads ol = {};
-    NetClientState *nc;
-    TAPState *s;
-
-    nc = qemu_new_net_client(&net_tap_info, peer, model, name);
-
-    s = container_of(nc, TAPState, nc);
+    TAPState *s = new_tap(peer, model, name);
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -1048,3 +1073,10 @@ int tap_disable(NetClientState *nc)
         return ret;
     }
 }
+
+static void tap_register_types(void)
+{
+    type_register_static(&tap_netdev_info);
+}
+
+type_init(tap_register_types)
-- 
MST


