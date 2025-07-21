Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF046C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjZR-0008HT-7x; Mon, 21 Jul 2025 02:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjYu-0008Ao-QL
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjYq-00065h-Ut
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SWwn/nYe/GmEuGy8KuW6M8dATKb5NoW+5cpMla73H9o=;
 b=FQFfsci13BxqpR8IR2G2ejGCCQ/J5u6ZQdIZhQmy2DXxx+/+ewRyrmvuoYXKiDuON+diHB
 U4Qyzm5YgJqiq/E7ZqzpjeSvkQszZMRVmRAbfJyxauy5OWegxi9f/aJkN/EmhJhYCkQHQQ
 RqEZVa4+Rl8zmwwG2/k942mTn8oQEik=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-eDsblP4CPsyNZyoubkCzeQ-1; Mon,
 21 Jul 2025 01:59:35 -0400
X-MC-Unique: eDsblP4CPsyNZyoubkCzeQ-1
X-Mimecast-MFC-AGG-ID: eDsblP4CPsyNZyoubkCzeQ_1753077574
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D8F1195608B
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 05:59:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8957919560AD; Mon, 21 Jul 2025 05:59:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/12] Net patches
Date: Mon, 21 Jul 2025 13:59:15 +0800
Message-ID: <20250721055927.75951-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit e82989544e38062beeeaad88c175afbeed0400f8:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-07-18 14:10:02 -0400)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to ae9b09972bbf8ff49ae0edf3241fb413391b15ce:

  net/vhost-user: Remove unused "err" from chr_closed_bh() (CID 1612365) (2025-07-21 10:23:17 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmh91p0ACgkQ7wSWWzmN
YhG+2wgAqw3G2TGRPT29ObyYDcd2Z54jdnNpX5gEND/UnqENprXfdD3PR58bnxe3
uJGPRkMXgkIDit61lshsb8DF8x9ZEIlm/Ax5FM0ksBczWDYHiyEuXoyt2Uai1kWY
fLBkVfjFqCu1AGniboCZiC4ZawZXIqkx/+DI3J/XRqa+bSCQ18I15dsLD/yxU/pp
Hwxp07/d+UayANdxs0mZ5Lr7a1ktTgytCt0O2jQNHlMzfOvdBbVbF/WGclMWfNgI
68HWPY7P8k8jRTRFx3H/0LyYQrPyseTpa3zHC+zW9jNskkPkhCwlAY4UDC8x8LII
OjsDc/0nre626rNCiJlifD3UJ7t86A==
=xj23
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Laurent Vivier (6):
      net/passt: Remove unused "err" from passt_vhost_user_event() (CID 1612375)
      net/vhost-user: Remove unused "err" from net_vhost_user_event() (CID 1612372)
      net/passt: Remove dead code in passt_vhost_user_start error path (CID 1612371)
      net/passt: Check return value of g_remove() in net_passt_cleanup() (CID 1612369)
      net/passt: Initialize "error" variable in net_passt_send() (CID 1612368)
      net/vhost-user: Remove unused "err" from chr_closed_bh() (CID 1612365)

Peter Maydell (4):
      hw/net/npcm_gmac.c: Send the right data for second packet in a row
      hw/net/npcm_gmac.c: Unify length and prev_buf_size variables
      hw/net/npcm_gmac.c: Correct test for when to reallocate packet buffer
      hw/net/npcm_gmac.c: Drop 'buf' local variable

Steve Sistare (1):
      tap: fix net_init_tap() return code

Vladimir Sementsov-Ogievskiy (1):
      net/tap: drop too small packets

 hw/net/npcm_gmac.c | 26 ++++++++++++--------------
 net/passt.c        | 22 +++++++---------------
 net/tap.c          |  9 +++++++--
 net/vhost-user.c   |  9 ---------
 4 files changed, 26 insertions(+), 40 deletions(-)


