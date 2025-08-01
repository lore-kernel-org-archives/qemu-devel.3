Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DD6C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnv-000072-19; Fri, 01 Aug 2025 10:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhM-0005Qa-Qo
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhF-0002eq-1k
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q969NkzaQmllQbxw1VC2F9uXj/0NwIk7LvKmAGmz3/o=;
 b=a284dMfnClrTOjDECFKTGImnakOBDJUKQcOLCXs2xWtI4YFQ9FFwOrAi/T5CCJctPWXPvm
 WreqAZHvkxEpiDZpSnWSEcGJsyMQSpsiY+ZQP8ip1GGi62GsxCDEaP4UwinzvaZ6cvtMy1
 Dd1sWnhkig4U4hMJgw9FJ9uAvCNnDcA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-d5zIqHKhOS67unlgG0DIxg-1; Fri, 01 Aug 2025 10:25:14 -0400
X-MC-Unique: d5zIqHKhOS67unlgG0DIxg-1
X-Mimecast-MFC-AGG-ID: d5zIqHKhOS67unlgG0DIxg_1754058313
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b785d52c19so470178f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058313; x=1754663113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q969NkzaQmllQbxw1VC2F9uXj/0NwIk7LvKmAGmz3/o=;
 b=nbwx1UhBtw5yJYr+gsQ8yr3eYUzrkaR5Ot0AbqD5Z/1KpBpaZ8I2VUU5aJgNHntMIY
 4igWCuHoHaOZhBI7DYAJzxZrbMCBFxXJM/tEtxnzjSWiZOIfEPRvFcHSFcRRa2+yzM2h
 aiB88h9RESPB8pAqjmWjz3hF7mS27llhZ6AcENbvvMFNg9XBHhbPyKTW8lFetMR2XJJx
 xtEMyQQLm2fqslKg7GkZkvZgpG6HDJ959OuxuqU1rTTtXs0zM0RKVmFIIGU7XOvZARbD
 x9zT2hLcnCB1LvQCqyx1MG6Rcjx4iofM7WmueQYnAUCssrn7Y9dzXc7noSK9Uq/ZRpRg
 tKKw==
X-Gm-Message-State: AOJu0YyvZZM0L8vE05hfC3c22Le6vkcEEwAFWePgqs/Q+xX1AJ/1Z5qc
 ZNNqbPaEpLrU3dJXPbFRcN7EcLT/S2CP6t5Fvj+nUX57zI6bbsUDW/go00h4nmPKkK/EaqSw7se
 HPqHHTCzu32bfYDOGdl53LiPGIhSNKO6P6Pl/PqeKXUMJaA2Pzp5Ztbdic/PukCbWvDJevOpkyI
 pcfEXlNfTZChoz8+SkkSZ8hAhhOBW1v506wQ==
X-Gm-Gg: ASbGncvu8pidTfv4lPvzfL8yAYfit4zim3vLXGPKgouwVLFbNqSOANGfGDYnfE6RZe7
 GK+YqrZ+v+H0If6RRPezwjInrzoGDfqkXAU8PqvrTEhkEICPHrnFHRw89IgaREAa1mBM9DhKBGn
 3KBWwHRL/bA0GpAYxSb/sgmIRAxHiPRcaa+czAzlRfx8L92fahqbzfQCRJCTyXtMUusY3XkJMgC
 0z08HnUyEuEIX9HGPFkdZQkP2mCmucxnTTv6BOB3sIago5+EMTLZtgmRcehrbVhgxv/TnCrDhca
 h8k236sF9T9r879cP/CoATj1Gva9nBiX
X-Received: by 2002:a5d:64e5:0:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3b794fd57f8mr9473823f8f.13.1754058312620; 
 Fri, 01 Aug 2025 07:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2h8ZAWovBjWNmgt9YLv6mW5oh5cIoqRXN20jp3dfuH+kf3W5ViTdkZ8ajjOiYRNvkX4FskA==
X-Received: by 2002:a5d:64e5:0:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3b794fd57f8mr9473786f8f.13.1754058312077; 
 Fri, 01 Aug 2025 07:25:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abf33sm6065349f8f.7.2025.08.01.07.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:11 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-stable@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 04/17] virtio-net: Fix VLAN filter table reset timing
Message-ID: <6071d13c6a37493a6b26e1609b09a98aa058038a.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Problem
-------

The expected initial state of the table depends on feature negotiation:

With VIRTIO_NET_F_CTRL_VLAN:
  The table must be empty in accordance with the specification.
Without VIRTIO_NET_F_CTRL_VLAN:
  The table must be filled to permit all VLAN traffic.

Prior to commit 06b636a1e2ad ("virtio-net: do not reset vlan filtering
at set_features"), virtio_net_set_features() always reset the VLAN
table. That commit changed the behavior to skip table reset when
VIRTIO_NET_F_CTRL_VLAN was negotiated, assuming the table would be
properly cleared during device reset and remain stable.

However, this assumption breaks when a driver renegotiates features:
1. Initial negotiation without VIRTIO_NET_F_CTRL_VLAN (table filled)
2. Renegotiation with VIRTIO_NET_F_CTRL_VLAN (table will not be cleared)

The problem was exacerbated by commit 0caed25cd171 ("virtio: Call
set_features during reset"), which triggered virtio_net_set_features()
during device reset, exposing the bug whenever VIRTIO_NET_F_CTRL_VLAN
was negotiated after a device reset.

Solution
--------

Fix the issue by initializing the table when virtio_net_set_features()
is called to change the VIRTIO_NET_F_CTRL_VLAN bit of
vdev->guest_features.

This approach ensures the correct table state regardless of feature
negotiation sequence by performing initialization in
virtio_net_set_features() as QEMU did prior to commit 06b636a1e2ad
("virtio-net: do not reset vlan filtering at set_features").

This change still preserves the goal of the commit, which was to avoid
resetting the table during migration, by checking whether the
VIRTIO_NET_F_CTRL_VLAN bit of vdev->guest_features is being changed;
vdev->guest_features is set before virtio_net_set_features() gets called
during migration.

It also avoids resetting the table when the driver sets a feature
bitmask with no change for the VIRTIO_NET_F_CTRL_VLAN bit, which makes
the operation idempotent and its semantics cleaner.

Additionally, this change ensures the table is initialized after
feature negotiation and before the DRIVER_OK status bit being set for
compatibility with the Linux driver before commit 50c0ada627f5
("virtio-net: fix race between ndo_open() and virtio_device_ready()"),
which did not ensure to set the DRIVER_OK status bit before modifying
the table.

Fixes: 06b636a1e2ad ("virtio-net: do not reset vlan filtering at set_features")
Cc: qemu-stable@nongnu.org
Reported-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Message-Id: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c4c49b0f9c..6b5b5dace3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -929,8 +929,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0xff, MAX_VLAN >> 3);
+    if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
+        bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
+        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
     }
 
     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
@@ -3942,6 +3943,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
     n->vlans = g_malloc0(MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, MAX_VLAN >> 3);
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
@@ -4041,7 +4043,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
     memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
     memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
     qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
-    memset(n->vlans, 0, MAX_VLAN >> 3);
 
     /* Flush any async TX */
     for (i = 0;  i < n->max_queue_pairs; i++) {
-- 
MST


