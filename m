Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E91C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 05:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubBpp-0000yX-M6; Mon, 14 Jul 2025 01:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubBpl-0000sH-KD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 01:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubBpi-00035Y-Ve
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 01:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752471272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oDFNxz0G8u9zSJ7bzYR4x99zE7Z26BqUHaPXQJuctv0=;
 b=T/6/BuYGpc5PfSBg0j+JkrcNKSFmndUKHBTHOb7fIvSC7l7RX5Pg9HHf1JjhAA+Rthn4A3
 Gg70UmvhA50aynltPSS40IZEM33cR16iIo7ND40VZXUQmuFE5RMGFYEyUc+18KXC7MhekT
 T85PIcL9p2Ugmw3y7AiG7C8AXRk2k7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-A2m2B040PgKwzjIgHx4OEw-1; Mon,
 14 Jul 2025 01:34:30 -0400
X-MC-Unique: A2m2B040PgKwzjIgHx4OEw-1
X-Mimecast-MFC-AGG-ID: A2m2B040PgKwzjIgHx4OEw_1752471270
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED9CE1808993
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.55])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6302C19560A3; Mon, 14 Jul 2025 05:34:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/13] Net patches
Date: Mon, 14 Jul 2025 13:34:10 +0800
Message-ID: <20250714053423.10415-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to da703b06a52bfb5fe1a77b0eddbb8d68d3f70762:

  net/passt: Implement vhost-user backend support (2025-07-14 13:27:09 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmh0lXsACgkQ7wSWWzmN
YhGvVwf+OxTtnr84VdsEckqNVuzVkMHk3PAuSlxpvfjHXnwwo5Efto9lA4h4BUSX
As9sYpF3qXZdh95QYB/49CvVdizsI/KW1wPEx4ryVqCi7kcdOrzNB/MMMXBrrJE+
86xtc2a53CHHcctUIvkBr/GVzhay/gm6VHjnPEB/B0Tv+rTKpIBr/nJzVlG+8uX9
O/XRI0aqnCPlsWDQFR2TbyE4TSSmTw5oXru0I12tPfxt2ed6b+izKubHmqgeLCyH
ne+qEy2ds40eBZ4YMDDIsxYKY8RlWIdUY0Dnz6wSjC00BNo5yLu7cirL0Ozd6AsI
pK5eqQGZGGQIGV/KD+M7WwKWVltBJg==
=rS9w
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Akihiko Odaki (1):
      virtio-net: Add queues for RSS during migration

Anastasia Belova (1):
      net: fix buffer overflow in af_xdp_umem_create()

Laurent Vivier (11):
      net: Refactor stream logic for reuse in '-net passt'
      net: Define net_client_set_link()
      vhost_net: Rename vhost_set_vring_enable() for clarity
      net: Add get_vhost_net callback to NetClientInfo
      net: Consolidate vhost feature bits into vhost_net structure
      net: Add get_acked_features callback to VhostNetOptions
      net: Add save_acked_features callback to vhost_net
      net: Allow network backends to advertise max TX queue size
      net: Add is_vhost_user flag to vhost_net struct
      net: Add passt network backend
      net/passt: Implement vhost-user backend support

 docs/system/devices/net.rst   |  50 ++-
 hmp-commands.hx               |   3 +
 hw/net/vhost_net-stub.c       |   3 +-
 hw/net/vhost_net.c            | 145 ++------
 hw/net/virtio-net.c           |  47 +--
 hw/virtio/virtio.c            |  14 +-
 include/hw/virtio/vhost.h     |   5 +
 include/hw/virtio/virtio.h    |  10 +-
 include/net/net.h             |   3 +
 include/net/tap.h             |   3 -
 include/net/vhost-user.h      |  19 --
 include/net/vhost-vdpa.h      |   4 -
 include/net/vhost_net.h       |  10 +-
 meson.build                   |   6 +
 meson_options.txt             |   2 +
 net/af-xdp.c                  |   2 +-
 net/clients.h                 |   4 +
 net/hub.c                     |   3 +
 net/meson.build               |   6 +-
 net/net.c                     |  36 +-
 net/passt.c                   | 753 ++++++++++++++++++++++++++++++++++++++++++
 net/stream.c                  | 282 ++++------------
 net/stream_data.c             | 193 +++++++++++
 net/stream_data.h             |  31 ++
 net/tap-win32.c               |   5 -
 net/tap.c                     |  43 ++-
 net/vhost-user-stub.c         |   1 -
 net/vhost-user.c              |  60 +++-
 net/vhost-vdpa.c              |  11 +-
 qapi/net.json                 | 118 +++++++
 qemu-options.hx               | 153 ++++++++-
 scripts/meson-buildoptions.sh |   3 +
 32 files changed, 1584 insertions(+), 444 deletions(-)
 delete mode 100644 include/net/vhost-user.h
 create mode 100644 net/passt.c
 create mode 100644 net/stream_data.c
 create mode 100644 net/stream_data.h


