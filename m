Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC17C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSFk-0001Mn-6I; Mon, 14 Jul 2025 19:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFi-0001LI-EV
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFg-0005Kl-HU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51WLhhtzvQLDx2fwDZYEvf7ij4Zz6Yv1oK4TX/67LF8=;
 b=NpEMj4XMro9+DdCu2JzcOuIbwRF8OP+AmJ01Q9hTIkIzOAIDF3JJe1KL19fgG04xz8zZBO
 E6lCRmsV/KOHG1XknKkTaa0kbwaHLRn3Shi8m2G18BVbLyothUdwuQ5yX7jwRg8B6NKvwR
 dxZVM/iYtSCyVDushXPzPJ1na+fRowY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-a3r1MvJdMxSoH6ndY6VILQ-1; Mon, 14 Jul 2025 19:06:25 -0400
X-MC-Unique: a3r1MvJdMxSoH6ndY6VILQ-1
X-Mimecast-MFC-AGG-ID: a3r1MvJdMxSoH6ndY6VILQ_1752534383
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so27817205e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534383; x=1753139183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51WLhhtzvQLDx2fwDZYEvf7ij4Zz6Yv1oK4TX/67LF8=;
 b=eiYYfNX82pQV3w4VyfVnpzJlfzdso7SuWsQJ6MBALi9eDjUtFdk1wXLidJTM+WeyFP
 bvyeHysqxZkyw9lvN9xp5VgWpJswpMxXgrnpYAc210hIC+hpnkUoaviTK/ilR6Y4K8xJ
 f2Trmp/0Da0KMGMsAV/ARPU3q7Dv2D+nuixIE9F/eKrAtCLunR4L9O928kNEAInhPv6+
 nP+Q49TX+4s02zs2bm8+0K4UGZw/BfltM7Eqmp3f3hXd4+iaqv1jHvz4ttwZmbXCcsge
 Wp2MCMOUpCvYfKLCk0QaKJLdo9/z648P0tTXTeZ76XNY+Mgb0rmHW9QYDyumgq1cp9qt
 wnJA==
X-Gm-Message-State: AOJu0YyPRi1XlAMpfl+qNOdi6BEvS0Kx2umEtUdtWdXqvxMgFuc7pW60
 JTbkKXcEn3ChMY0zMlhtnU+ykdtnAXy0CDjfF7u6LeKshUVzGWX97lIUSU4Y1i5pbjGkn+bgvPQ
 tnh3Ieu3HoSZhZ4XD2lC15my6QU7P9HLCkgR5DY+Fxg5iu0H9oXo0coV3/X0gIU75MjahsrAb4C
 7PPS6xAPJ4xHReFJnretRMKf8TBeLeK1FduQ==
X-Gm-Gg: ASbGncvTRvxKDEq4TIuu4kKCiUOMoVEviLxfEl6dUWlR0uJS1pS/vIVyDp0JfjoWDUn
 bkHauNdp+nNS/tv0nCybfvyd+VNRDeOFeoSzEIrvzLBkH8XAd4gqizBAaY+ogOzYc1ExZW0xHLf
 bhkOvh9Mw5pN555CB/fWiGt1WORk+sEXeogk1WOeJc8esBwcmXgCL87FUyNNnaE07I0Su4UfPBt
 1i6ixC9yOPgxTGLsC27Sw/4KVFPVTno1S9fUdvbCD+h3R1XOdXb4qlJuIWJn8on93KBYuW7Q86o
 hEYWBJtocZr9MK7IVyJfIP18J0CVcPBA
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-4561a16064fmr59346005e9.12.1752534382936; 
 Mon, 14 Jul 2025 16:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFlJEJlotEdZvsKfQW76HJh35RNxj9rvToIlF86iMr+ngxUkyhPPkHcqwf18jXjPSzi4PJsQ==
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-4561a16064fmr59345735e9.12.1752534382415; 
 Mon, 14 Jul 2025 16:06:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561323a488sm62228555e9.1.2025.07.14.16.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:22 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/97] net/vhost-vdpa: Report hashing capability
Message-ID: <14f521f491063136bb4aa282c9d29735c78ee433.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Report hashing capability so that virtio-net can deliver the correct
capability information to the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250530-vdpa-v1-2-5af4109b1c19@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/net/net.h |  3 +++
 net/net.c         |  9 +++++++++
 net/vhost-vdpa.c  | 28 ++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index cdd5b109b0..545f4339ce 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -60,6 +60,7 @@ typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
+typedef bool (GetVnetHashSupportedTypes)(NetClientState *, uint32_t *);
 typedef int (SetVnetLE)(NetClientState *, bool);
 typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
@@ -89,6 +90,7 @@ typedef struct NetClientInfo {
     SetVnetHdrLen *set_vnet_hdr_len;
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
+    GetVnetHashSupportedTypes *get_vnet_hash_supported_types;
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
@@ -189,6 +191,7 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                       int ecn, int ufo, int uso4, int uso6);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
+bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
diff --git a/net/net.c b/net/net.c
index 39d6f28158..d0ae3db0d8 100644
--- a/net/net.c
+++ b/net/net.c
@@ -573,6 +573,15 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
     nc->info->set_vnet_hdr_len(nc, len);
 }
 
+bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types)
+{
+    if (!nc || !nc->info->get_vnet_hash_supported_types) {
+        return false;
+    }
+
+    return nc->info->get_vnet_hash_supported_types(nc, types);
+}
+
 int qemu_set_vnet_le(NetClientState *nc, bool is_le)
 {
 #if HOST_BIG_ENDIAN
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 58d738945d..cb63e09453 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -252,6 +252,32 @@ static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
     return true;
 }
 
+static bool vhost_vdpa_get_vnet_hash_supported_types(NetClientState *nc,
+                                                     uint32_t *types)
+{
+    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    uint64_t features = s->vhost_vdpa.dev->features;
+    int fd = s->vhost_vdpa.shared->device_fd;
+    struct {
+        struct vhost_vdpa_config hdr;
+        uint32_t supported_hash_types;
+    } config;
+
+    if (!virtio_has_feature(features, VIRTIO_NET_F_HASH_REPORT) &&
+        !virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+        return false;
+    }
+
+    config.hdr.off = offsetof(struct virtio_net_config, supported_hash_types);
+    config.hdr.len = sizeof(config.supported_hash_types);
+
+    assert(!ioctl(fd, VHOST_VDPA_GET_CONFIG, &config));
+    *types = le32_to_cpu(config.supported_hash_types);
+
+    return true;
+}
+
 static bool vhost_vdpa_has_ufo(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -428,6 +454,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+        .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
         .has_ufo = vhost_vdpa_has_ufo,
         .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
@@ -1284,6 +1311,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .stop = vhost_vdpa_net_cvq_stop,
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+    .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
     .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
-- 
MST


