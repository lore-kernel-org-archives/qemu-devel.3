Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFAFCD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 07:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq6Oi-0007HJ-5d; Fri, 29 Mar 2024 03:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6Od-0007G0-DG
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6Ob-0001Ah-NH
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711696284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZQ9+jiRyU6U7jrvemCH0jWxbZPxQAANcYjVF7tsoZs=;
 b=XG6adyaFUmATChc1FizgLVT9kj8MFrkaIYiBzGOq3Rqf3iwzjosGA9UtGv5kWzjtxLsjqj
 J+Q18mP1KlpiKjQaXonvtLgEery35OjE4CI7cy9/YgadDtmPdcWuQ7t5NAg2wtQgyZQRVc
 k/rYLVkfZ0mycF1TPlNIQlKlyJ8L/18=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-TIzE-rz9MiGPjq8Wj6gbnw-1; Fri, 29 Mar 2024 03:11:22 -0400
X-MC-Unique: TIzE-rz9MiGPjq8Wj6gbnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E439B80F7E4;
 Fri, 29 Mar 2024 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0746CC423E0;
 Fri, 29 Mar 2024 07:11:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 4/5] tap-win32: Remove unnecessary stubs
Date: Fri, 29 Mar 2024 15:10:59 +0800
Message-ID: <20240329071100.31376-5-jasowang@redhat.com>
In-Reply-To: <20240329071100.31376-1-jasowang@redhat.com>
References: <20240329071100.31376-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Some of them are only necessary for POSIX systems. The others are
assigned to function pointers in NetClientInfo that can actually be
NULL.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap-win32.c | 54 -------------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 7b8b4be02c..7edbd71633 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -707,70 +707,16 @@ static void tap_win32_send(void *opaque)
     }
 }
 
-static bool tap_has_ufo(NetClientState *nc)
-{
-    return false;
-}
-
-static bool tap_has_vnet_hdr(NetClientState *nc)
-{
-    return false;
-}
-
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
-void tap_fd_set_vnet_hdr_len(int fd, int len)
-{
-}
-
-int tap_fd_set_vnet_le(int fd, int is_le)
-{
-    return -EINVAL;
-}
-
-int tap_fd_set_vnet_be(int fd, int is_be)
-{
-    return -EINVAL;
-}
-
-static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
-{
-}
-
-static void tap_set_offload(NetClientState *nc, int csum, int tso4,
-                     int tso6, int ecn, int ufo, int uso4, int uso6)
-{
-}
-
 struct vhost_net *tap_get_vhost_net(NetClientState *nc)
 {
     return NULL;
 }
 
-static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
-{
-    return false;
-}
-
-static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
-{
-    abort();
-}
-
 static NetClientInfo net_tap_win32_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
     .receive = tap_receive,
     .cleanup = tap_cleanup,
-    .has_ufo = tap_has_ufo,
-    .has_vnet_hdr = tap_has_vnet_hdr,
-    .has_vnet_hdr_len = tap_has_vnet_hdr_len,
-    .using_vnet_hdr = tap_using_vnet_hdr,
-    .set_offload = tap_set_offload,
-    .set_vnet_hdr_len = tap_set_vnet_hdr_len,
 };
 
 static int tap_win32_init(NetClientState *peer, const char *model,
-- 
2.42.0


