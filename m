Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B4606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RY3HDwSz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mBI4Hlnu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Ik-0007rB-1x; Wed, 28 Oct 2026 13:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HW-0003wj-3u
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HT-00044O-Lr
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1kyZtg6045VLnXwsU/EbaSQUHp0u8UfFjoHPpYs775Y=;
 b=RY3HDwSzMSHGdsyDsD0kWjx9qRoAwrjlCIT/v9DaOMkEl22xdZEvzvMAV737/Mu3SzulJ9
 E9MduxbHoXiGJn6uRO84SB8r6QLsePcbnfaWfdGlrjUD+9eAblP3OOvcaCDzh9sFKQh/VL
 5hiA6TRmNlpab9pa5rPzeKYKn/lL6Tw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-hAaxDm8IP6mvcndFSV00jg-1; Wed, 28 Oct 2026 13:17:41 -0400
X-MC-Unique: hAaxDm8IP6mvcndFSV00jg-1
X-Mimecast-MFC-AGG-ID: hAaxDm8IP6mvcndFSV00jg_1793207860
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e1d839ddaso799786f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207860; x=1793812660; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1kyZtg6045VLnXwsU/EbaSQUHp0u8UfFjoHPpYs775Y=;
 b=mBI4HlnuDn4qMDGy1q7bdcdAVeIWOTN6Wp3y+ZU7d2ekU1YF9Sb3rmL6RZZj9pIT8e
 E/LiBBtaoiOfiUobgnOjKD0yFfr6ZsbMo6YJRK51W/S9+zPJkc3jyXNe9aIeKx4BuyNp
 qe/bsQkVB5M2RYId2V2g/zMRg/W85AwovCXuALFUCBkDJDkY8emryhM7TXbR5Zu7Mv1Y
 /J4C5rsUi6PTlf9kQXDInNemiLd4szP9RQxL5NEO2I2y5mT1yFY9bw7lxaRbIVQBHbx/
 aSZKWlHGdB/KXdCJbM8LYP+H2uyZ6PWAN74iJc2TbJqie8ri974RchvfO59JG2T1x9ok
 YylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207860; x=1793812660;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1kyZtg6045VLnXwsU/EbaSQUHp0u8UfFjoHPpYs775Y=;
 b=IUyPlZ9vPa3fCcsoNcqtenKo0bWDI7W24FDvcLnv6oH+WoIJaEIV/W8N6D69LVHqTQ
 3VOSmZr13/wFEUdmxdBJXk+ZrETDkss0FsmVWZt4jP13/CB58buOLdH/HYIbDauUyw28
 IEzIDqCt3WRj67IAjcZb6WkMgdajqHz7oVM+U284WuUYBCKBAwplYBPpFOW/NLXJAfQU
 SbActMN4VRMQg4tTE4M1xxe5222jgoIY1e0vsy5GsRuc2IA73BaMFjb2B4mULRR3hUmU
 nAKZUUv6Nq4gL2F19kk3ujTzNwL34aJgNxF2lvktYFNwyTTTx5cz9XyxFAx1Ou4gznRC
 x3DQ==
X-Gm-Message-State: AFq9FYJEaj8bedlOTxbazY/2wz5fw5fVcPvQjrP3FtNPTYDhXtNHxuaW
 ogwn7r1ST70t49Er+eoz02++Dp5GciYSv2OvK2CJJF2V1dDOJWyCCaPzMsz7GB6WDFeB23HNFUw
 ELqlG0gQNJF1GI8zwzfnzqitkLoL+/aBsus5geHH1SMtoXLQibmzpAf3bWGMtun8l/AQCXT+nkE
 EG39crGAMZaU7dSKcAfoUapBOPdg4WBgqqJA==
X-Gm-Gg: AYBFou0sAwsQz1u6mYYM9j1nGNyk4fOJGX+uS/QiRSdewwJqAiKFlZ9Zw/6MvqZ7HXw
 YETwH45azezlwcsargG2R+tUIc5tyAP9VsfPOzmJcOeHS2klwJMpdUqWjUW7rAIdLBBhin+Z/qO
 1cfZsX4u1lvKrP+TY99Pb5mGzLSBO+ZiUUL84MKm4KNInBQJ6trO2fg7+TWhIipmgidj/8yaPvd
 ctmihXi6QWuLPmLfWFukSCDobTajAtF8gnPdjaD9rXkGF7Ats6DOZ7kZHXBfIE0HZKm9k+dYZlF
 FONs5tqx6/CeM836ADOs93EcetPGioAJFOqktuC2xitvSzvJC1BN84gq69Irhj0Q2VT1mwvvTA2
 5NYs4vY1TCNOBkozE42soem5QmnVdU2bmk+x20TQ7
X-Received: by 2002:a05:6000:981:b0:48e:63fc:25d9 with SMTP id
 ffacd0b85a97d-48e63fc2670mr1508366f8f.38.1793207859999; 
 Wed, 28 Oct 2026 10:17:39 -0700 (PDT)
X-Received: by 2002:a05:6000:981:b0:48e:63fc:25d9 with SMTP id
 ffacd0b85a97d-48e63fc2670mr1508264f8f.38.1793207859263; 
 Wed, 28 Oct 2026 10:17:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm35268435f8f.44.2026.10.28.10.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:38 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:17:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nariman Sayed <narimansayed28@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 78/78] virtio-net: add mtu-from-tap property for automatic MTU
 detection
Message-ID: <c155e7e9e025b60ce17e26a7c382d86f3f9c9fee.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently, exposing the host tap device's MTU to the guest via
VIRTIO_NET_F_MTU requires manually specifying host_mtu= on the
virtio-net-pci device, duplicating the MTU already configured on
the host's tap interface.

Add a new mtu-from-tap boolean property (default off, preserving
existing behavior). When enabled, the netdev peer's MTU is queried
via the generic qemu_get_mtu() and used to set net_conf.mtu and
enable VIRTIO_NET_F_MTU, regardless of the backend's type.

This detection must happen in virtio_net_device_realize(), before
virtio_net_set_config_size() computes the virtio config space
size from host_features. Performing the detection later (e.g. in
the get_features_ex() callback, which runs after the NIC and its
config space are already sized) results in the mtu config field
falling outside the sized config space, and the guest reading
back an unmapped garbage value (0xffff) instead of the intended
MTU.

Since qemu_new_nic() has not yet been called at this point in
realize(), the peer is accessed via n->nic_conf.peers.ncs[0]
(populated during property parsing, before realize() runs, via
the netdev= property) rather than through n->nic.

Signed-off-by: Nariman Sayed <narimansayed28@gmail.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261007050718.926-4-narimansayed28@gmail.com>
---
 include/hw/virtio/virtio-net.h |  1 +
 hw/net/virtio-net.c            | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 8c967760c2..fed37245be 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -52,6 +52,7 @@ typedef struct virtio_net_conf
     uint16_t rx_queue_size;
     uint16_t tx_queue_size;
     uint16_t mtu;
+    bool mtu_from_tap;
     int32_t speed;
     char *duplex_str;
     uint8_t duplex;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4794496b96..54e42cfec9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4006,6 +4006,15 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+    if (n->net_conf.mtu_from_tap) {
+        NetClientState *peer = n->nic_conf.peers.ncs[0];
+        int mtu = qemu_get_mtu(peer);
+        if (mtu > 0) {
+            n->net_conf.mtu = mtu;
+            n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
+        }
+    }
+
     if (n->net_conf.duplex_str) {
         if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
             n->net_conf.duplex = DUPLEX_HALF;
@@ -4386,6 +4395,7 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_size,
                        VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
+    DEFINE_PROP_BOOL("mtu-from-tap", VirtIONet, net_conf.mtu_from_tap, false),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
-- 
MST


