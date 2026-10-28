Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E1606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ByLU8HYe;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cm1hM0rg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7IV-0006kt-5z; Wed, 28 Oct 2026 13:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HZ-00043S-Cs
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HX-000455-M7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq27nGz6U59cZ8z/MigVLWJ0iHvfYau8t3QgSo7dDnM=;
 b=ByLU8HYesnEQaHfd15GyEH8rJ7AQwu0lw8wbnqnb4cjraALEZ9+FlV6m2Jt5T7mBOsHUGF
 Q1UODzqubWCAvTdqgvzRu04vtgdvhbrAwGKhuG5rxsbXgeZDN7g5TyAwl0YnBDQNEDji8i
 nH1qZb1/RtZVkRKmVgxzU6cyItGnu7k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-XgIJhmSgOsSPMN9_2YhEvw-1; Wed, 28 Oct 2026 13:17:39 -0400
X-MC-Unique: XgIJhmSgOsSPMN9_2YhEvw-1
X-Mimecast-MFC-AGG-ID: XgIJhmSgOsSPMN9_2YhEvw_1793207858
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a2065a2ef9so11368845e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207858; x=1793812658; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rq27nGz6U59cZ8z/MigVLWJ0iHvfYau8t3QgSo7dDnM=;
 b=cm1hM0rgR+4z9zY9xeI7cGPNUBh/EE221zfA9bZQ+195M72qSg4Wvmez2qAkCu/7nf
 aa+fwb1vjkNOwVlBgY5SZP98vHxsZL9Afk3NVovVjdjJVsG1EzXQPfjmozfZ9bnbHvPe
 PeW2GXTOTI+2eOvje3RkRo5mq8fk5I/WKOnJrfDT0JAV2TTv7XALdfw7BejRdJ8dx2r0
 hxubwRgr9gbeElZcajOAzoNL4VmiFiL7QA0DpOGo3cXsRkHgRwOOscoN6FSBkftASZxs
 g0H0bzT865biy6co96QZI9hnazEyznQhfy9ub+GJHlPFBK6E6nxY374f5SoobR+nvMU+
 tDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207858; x=1793812658;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rq27nGz6U59cZ8z/MigVLWJ0iHvfYau8t3QgSo7dDnM=;
 b=PX5ZWEhRFdnZ6w+p5+3q8NWSp171sNMBDx70RaVfbn1RISWP3D22nZBFmZfX+KQ/1Y
 jmI0iSRfce1BGrQumtulgI8LPMlSPV4HYlLHbP61EIJfN6qwxID+Ss8WMW2kASFdrqFV
 4UNSrMOT3okWQCHaZy/4O9ljtxBdEAzNocis6FepdlYIYej7KM2Xp3LuYv3b6+Tvk8c2
 o9sNebhDJ+cUASvxSo0XBYVI/acqXEwATFLcSwocbytlaJ9XgER4mR1Lz5n5VDpsAZLR
 MOGDcmVv91yjXPFiKRPTwYTN6vRhiNh1rtDWU+6bzGpJY83NEcjPeFrz7IXgVgN3B7jP
 c8Cw==
X-Gm-Message-State: AFq9FYJT0FoY3fbyTlqsg1YJAG6RZsxlxJnsSKAroK0xi43N3+GA+REK
 r4pnnDe3Jv4Tj1+Z7EyvBCS4gj5IYGVerUI01Dkr3tv/WIVnbjaz/wO2TRGC5Q3+fMcw9ISua54
 cYayEbkveao4JZ74zx8/o7MMLkbscIfMerPIz3Pftt0i2YO+G6tj17lIlBcDkZOMo9rdCEq9oGY
 CPo11goVwNCAad5l1da0eih/SeDF7CDVEIoQ==
X-Gm-Gg: AYBFou0Fn1m9zzNG8P9nf4XF3T4X6xxr8RW+i6v5GDOIFRaWepOeKJ5e8I9HX2+lWEC
 C9u0IrOq0m7ip2VsFrLnNmZ6PbDg7gK1jdIhE6gFN3V8CAmKjVCdW+aTGTn65ohAyOmzSuh31Vq
 qLWoR9M3PgzxAHuGe4Uu81XJffUjYeweeTzqy0TQ1ICtAOjV8QBO1hop+dcQWfoGvoiXFUxNfvi
 E64UAgPghUs+NhTnVjgvCPs8LVp4hNRhTec54uiVmpsRyRsrV34lqo3PmRrMkQJcKQuoGKGi4sL
 HFHdScPjQnFM/nraj8NYTimoPpvjsup7vMEc+Fjlx9Nc4XecA8gHg8QAkLdAHo5tgvfP8ZsDWb4
 BYAKR7ZqPZ89uC3p2dAtyY42OVhorMLbKU+LLBT6C
X-Received: by 2002:a05:600c:4ece:b0:4a2:1960:6db with SMTP id
 5b1f17b1804b1-4a9677ca10emr69467035e9.26.1793207857678; 
 Wed, 28 Oct 2026 10:17:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:4a2:1960:6db with SMTP id
 5b1f17b1804b1-4a9677ca10emr69465475e9.26.1793207856377; 
 Wed, 28 Oct 2026 10:17:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa820492cesm5656565e9.13.2026.10.28.10.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:35 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:17:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nariman Sayed <narimansayed28@gmail.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 77/78] net: add generic get_mtu NetClientInfo callback
Message-ID: <d3c5277cc401ff656d2ddf81779b15b171044a66.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nariman Sayed <narimansayed28@gmail.com>

Add a get_mtu callback to NetClientInfo, along with a qemu_get_mtu()
wrapper following the existing qemu_has_ufo()-style pattern, so that
device models can query a netdev backend's host MTU generically
without needing to know or check its backend type.

Wire this up for the tap backend via tap_get_mtu(), which is now
static and only referenced through net_tap_info.get_mtu, matching
the existing pattern used by tap_has_ufo() and similar callbacks.

This allows other backends (e.g. vhost-user, vhost-vdpa) to
implement get_mtu in the future without requiring changes to any
code that calls qemu_get_mtu().

Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>
Signed-off-by: Nariman Sayed <narimansayed28@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261007050718.926-3-narimansayed28@gmail.com>
---
 include/net/net.h | 3 +++
 net/net.c         | 9 +++++++++
 net/tap.c         | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index fdf6a2ddd4..de4f03c301 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -73,6 +73,7 @@ typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef void (SetOffload)(NetClientState *, const NetOffloads *);
 typedef int (GetVnetHdrLen)(NetClientState *);
+typedef int (GetMtu)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
 typedef bool (GetVnetHashSupportedTypes)(NetClientState *, uint32_t *);
 typedef int (SetVnetLE)(NetClientState *, bool);
@@ -113,6 +114,7 @@ typedef struct NetClientInfo {
     NetCheckPeerType *check_peer_type;
     IsWaitIncoming *is_wait_incoming;
     GetVHostNet *get_vhost_net;
+    GetMtu *get_mtu;
 } NetClientInfo;
 
 struct NetClientState {
@@ -214,6 +216,7 @@ bool qemu_has_uso(NetClientState *nc);
 bool qemu_has_tunnel(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
+int qemu_get_mtu(NetClientState *nc);
 void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
diff --git a/net/net.c b/net/net.c
index d7fa637ce5..bf7e5d9b12 100644
--- a/net/net.c
+++ b/net/net.c
@@ -514,6 +514,15 @@ bool qemu_has_ufo(NetClientState *nc)
     return nc->info->has_ufo(nc);
 }
 
+int qemu_get_mtu(NetClientState *nc)
+{
+    if (!nc || !nc->info->get_mtu) {
+        return -1;
+    }
+
+    return nc->info->get_mtu(nc);
+}
+
 bool qemu_has_uso(NetClientState *nc)
 {
     if (!nc || !nc->info->has_uso) {
diff --git a/net/tap.c b/net/tap.c
index acccabca56..665dee800d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -446,6 +446,13 @@ int tap_get_fd(NetClientState *nc)
     return s->fd;
 }
 
+static int tap_get_mtu(NetClientState *nc)
+{
+    TAPState *s = container_of(nc, TAPState, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+    return tap_fd_get_mtu(s->fd);
+}
+
 /*
  * tap_get_vhost_net() can return NULL if a tap net-device backend is
  * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
@@ -607,6 +614,7 @@ static NetClientInfo net_tap_info = {
     .set_steering_ebpf = tap_set_steering_ebpf,
     .is_wait_incoming = tap_is_wait_incoming,
     .get_vhost_net = tap_get_vhost_net,
+    .get_mtu = tap_get_mtu,
 };
 
 static TAPState *new_tap(NetClientState *peer,
-- 
MST


