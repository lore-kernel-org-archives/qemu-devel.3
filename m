Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E306DC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mkb-0006ql-CY; Thu, 10 Sep 2026 17:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWk-0006an-6G
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWK-0004ke-Dy
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWRhi/FGrwhxDDpXDBZ1js0/6fDRqICz+xroCDFuHEc=;
 b=eUpVdw0kh0Nm3/JlX8wbypTNm1FB+zKWuipg20vp8YwN6SMx2UkaGwZP9CZasCRl4hGlQv
 6JkFc/2sIGPw5ae5n/B3CLOpidtmrh1OnhjWn4R+FalSQJGly6/jiyZfkMmzItUF1tn/G5
 jpQsfBZPiDJVLK6LIS+X8PlgkLhKp48=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Btvl-lMWNLWdtv8-R6KV9A-1; Thu, 10 Sep 2026 16:12:25 -0400
X-MC-Unique: Btvl-lMWNLWdtv8-R6KV9A-1
X-Mimecast-MFC-AGG-ID: Btvl-lMWNLWdtv8-R6KV9A_1789071144
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49d156c917cso8576845e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071144; x=1789675944; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AWRhi/FGrwhxDDpXDBZ1js0/6fDRqICz+xroCDFuHEc=;
 b=gpFgtkQD6bORZCg1Rbk/LwRFkVl9rd4WvpOgqwUgKK6YR7HN2cXfJPS9aOc7/RUATH
 ngXFWDWQ8FcTqyi9wcStx99bBEpOv/Vh2ApydI9gcy061vpTp2Lujo4Yr2VjsBmLcxOz
 CNyRaKhSY6B5kWbAkeF5DD1XZO7us1VuIRi5IbmgwZYxe64rJ/PNo266/K2shKgTpuqM
 voW9QUeGyvQKJtg3ndWWmmMlJVceChJ8Qqj1aB5oZdDlXs/TdTV9YLfZKV4mMrzwVUWR
 qsx38ZckYx80PgTwnLWeIhN5IEpfaIPLA3at7Hr8m7Q3POl26INz2p6An03lbrxxIfa7
 cKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071144; x=1789675944;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AWRhi/FGrwhxDDpXDBZ1js0/6fDRqICz+xroCDFuHEc=;
 b=amM5bQCL2ss0C11GCebCY7Pl7phrxYJbksU5oeonUqw9UFcuTIbJD2UyrPA1F5cjS4
 30DI831vgKPFx9tPMwiGc/pMsUOklb3ohp/KGnBnnHRu8Og2EOwGBoUFHjGpXoElU5js
 hs9H4kiVIQdQAjuSUHJTVuqD1H6Tzjf39RLhVjf85gdS5ke8xqmFkxBxnNXx1Zwh4UON
 hrfq/rd9CCA3i9Wy3TNUMxgRT7l/xlo6lDNHFDO0oMiTC8lzkRqFc0KaZ8Wsnk47Mrkv
 nRkFZ4BVQua+P1ThwEyQnZX1KzJBWeWgv7IuycIBiwQ5TTYjpeQJ/KAC9E441IvzQsR/
 /TmQ==
X-Gm-Message-State: AFuF++leCr3h0x4d/W/sry8Ii00lp+yzj9CjEjlZBtGSm1upB7P7X43N
 drkZwV3Aj5raGxcdioq1pd7y6D2eDBYi9Ql6HpfCr+jmpzJDymJUfDz9UBgskKAmNZ7sRU72Wtx
 SsZ4GatN3bq5jHbBD9+Qp8Xel4YJQN6kXcdvRv6+ekY473tgn8bbmk2jX7VaS9VtcawRqgnVV2E
 nCggz/RzXr6Z3VsCt59T3HMwwydHY8AMEsWg==
X-Gm-Gg: AYBFou3r5LRD0QVGgccldqV9tucNIKAwEilaO9Mm5oxioRA22JaZVhkOIyZ0Q0eOvoO
 ItvFpUqGeb3SDBLuUkquKFquCn9LnN5R1D/g8PfuFBrsNbDgRPcHdv47+PeD3wCwY+5i9cdexRO
 d8N8fY9hBog80NVkRIJpGNpUZMkg9YkbGJWuFGgGif5hwJelu64Mxb8M4CRwvg3w3QSqmJSiRZA
 Mlc7MPEhJQtGfp3ar9HqLB4iyJNYydXHycdXcZN6cXpnfL3Rvn42dhkSc/a4pyQ83eGY32kcSzq
 VtFVy/CXnIqD/upuFpEzLWG7CVE/0bSzCCZ4TAGSybGk6cyVf3fSX0LcaLSycyNowuIYg0zblkN
 YmvUYsdASlpfZAUUDxwUOiGQ=
X-Received: by 2002:a05:600c:3115:b0:49d:1e79:35d6 with SMTP id
 5b1f17b1804b1-49e61094b9bmr12279795e9.14.1789071143756; 
 Thu, 10 Sep 2026 13:12:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:49d:1e79:35d6 with SMTP id
 5b1f17b1804b1-49e61094b9bmr12279205e9.14.1789071143140; 
 Thu, 10 Sep 2026 13:12:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a7a686sm6596295e9.1.2026.09.10.13.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:22 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL 24/90] net/tap: use container_of instead of DO_UPCAST
Message-ID: <2aaacce0a03705d7f69c47cc02cb9ae859b1ebef.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We are going to QOMify tap backend, which includes deriving TAPState
from Object. So "NetClientState nc" will not be a first member.
Let's parepare for this change, and use container_of(), which will
work regardless position of "nc" field.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-7-vsementsov@yandex-team.ru>
---
 net/tap.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f2b571dd11..bfed74717e 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -175,7 +175,7 @@ static ssize_t tap_write_packet(TAPState *s, const struct iovec *iov, int iovcnt
 static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
                                int iovcnt)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     const struct iovec *iovp = iov;
     g_autofree struct iovec *iov_copy = NULL;
     struct virtio_net_hdr hdr = { };
@@ -211,7 +211,7 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
 
 static void tap_send_completed(NetClientState *nc, ssize_t len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     tap_read_poll(s, true);
 }
 
@@ -271,7 +271,7 @@ static void tap_send(void *opaque)
 
 static bool tap_has_ufo(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -280,7 +280,7 @@ static bool tap_has_ufo(NetClientState *nc)
 
 static bool tap_has_uso(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -289,7 +289,7 @@ static bool tap_has_uso(NetClientState *nc)
 
 static bool tap_has_tunnel(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->has_tunnel;
@@ -297,7 +297,7 @@ static bool tap_has_tunnel(NetClientState *nc)
 
 static bool tap_has_vnet_hdr(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -311,7 +311,7 @@ static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
 
 static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
@@ -322,21 +322,21 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
 static int tap_set_vnet_le(NetClientState *nc, bool is_le)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     return tap_fd_set_vnet_le(s->fd, is_le);
 }
 
 static int tap_set_vnet_be(NetClientState *nc, bool is_be)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     return tap_fd_set_vnet_be(s->fd, is_be);
 }
 
 static void tap_set_offload(NetClientState *nc, const NetOffloads *ol)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     if (s->fd < 0) {
         return;
     }
@@ -357,7 +357,7 @@ static void tap_exit_notify(Notifier *notifier, void *data)
 
 static void tap_cleanup(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
 
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
@@ -381,14 +381,14 @@ static void tap_cleanup(NetClientState *nc)
 
 static void tap_poll(NetClientState *nc, bool enable)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     tap_read_poll(s, enable);
     tap_write_poll(s, enable);
 }
 
 static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
 
     return tap_fd_set_steering_ebpf(s->fd, prog_fd) == 0;
@@ -396,7 +396,7 @@ static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
 
 int tap_get_fd(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->fd;
 }
@@ -408,7 +408,7 @@ int tap_get_fd(NetClientState *nc)
  */
 static VHostNetState *tap_get_vhost_net(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     return s->vhost_net;
 }
@@ -447,7 +447,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
 
     nc = qemu_new_net_client(&net_tap_info, peer, model, name);
 
-    s = DO_UPCAST(TAPState, nc, nc);
+    s = container_of(nc, TAPState, nc);
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -1016,7 +1016,7 @@ fail:
 
 int tap_enable(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     int ret;
 
     if (s->enabled) {
@@ -1033,7 +1033,7 @@ int tap_enable(NetClientState *nc)
 
 int tap_disable(NetClientState *nc)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    TAPState *s = container_of(nc, TAPState, nc);
     int ret;
 
     if (s->enabled == 0) {
-- 
MST


