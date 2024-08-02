Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED0BC49EA1
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZipf-0003JH-6d; Thu, 01 Aug 2024 23:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipZ-0002xl-Sz
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sZipX-0008Oz-IB
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722568780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ccd4s7iwbWOKtW0SpDviy/9Cbrs1GGfNAcJzWV216ew=;
 b=cqkAp6hQ1yArFV6MaufeWs+g6XsH4VzTXMqio842RaVlreocOimDzzq/bWm9iq3a/8P6xn
 LgeO79t+HEzMhZRG96YrG+6ieaqbIJ45Yb7O3Jq7KZlARpTlAjps2WM+fAo37b4h8avTZl
 eUrB/07oo10OtPo4Bn8h0ssoXFHlx/I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-vEvKvF95PVi_a_or7gRgbA-1; Thu,
 01 Aug 2024 23:19:37 -0400
X-MC-Unique: vEvKvF95PVi_a_or7gRgbA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 303001955D54
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2024 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.229])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6166D300018D; Fri,  2 Aug 2024 03:19:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/8] Net patches
Date: Fri,  2 Aug 2024 11:19:21 +0800
Message-ID: <20240802031929.44060-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 31669121a01a14732f57c49400bc239cf9fd505f:

  Merge tag 'pull-target-arm-20240801' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-08-02 08:18:37 +1000)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 64f75f57f9d2c8c12ac6d9355fa5d3a2af5879ca:

  net: Reinstate '-net nic, model=help' output as documented in man page (2024-08-02 11:09:52 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmasTgwACgkQ7wSWWzmN
YhFUtAgAq45v7fQJ7cKKwRam/VrIkxT5cM59ODwzLSL9kPWfL6f/bJ7xM/zvLyvn
LNBXFWWu+eNKA73f95cckZwaqZ4U6giGbiesCACn1IpgVtieLS+Lq78jsifKIAsR
yxFvbT9oLhU0dZ1Up3+isc6V+jeAE4ZYu4KOiIt7PscTEzkJl+vSUjN4X9rRVtUD
PzONUacL6MoTJtX8UZJZXNzLN9JTsN39Gx+LSDGQ27MDmDvE3R9BW+T0ZgF9JQZ7
wnrL5sharqF3gxa7X55fPBI1qwY5gWcH0yyJpRdM8guA13vhtvlrhNSypip9eKWi
HtPHUTKEB5YOvF236WRiuQPIm/GNpA==
=7HGN
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Akihiko Odaki (1):
      virtio-net: Ensure queue index fits with RSS

David Woodhouse (1):
      net: Reinstate '-net nic, model=help' output as documented in man page

Hans (1):
      rtl8139: Fix behaviour for old kernels.

Laurent Vivier (4):
      net: update netdev stream/dgram man page
      net: update netdev stream man page with unix socket
      net: update netdev dgram man page with unix socket
      net: update netdev stream man page with the reconnect parameter

thomas (1):
      virtio-net: Fix network stall at the host side waiting for kick

 hw/net/rtl8139.c           |   6 +-
 hw/net/virtio-net.c        |  31 ++++----
 hw/virtio/virtio.c         |  64 ++++++++++++++-
 include/hw/virtio/virtio.h |  19 ++++-
 net/net.c                  |  25 +++++-
 qemu-options.hx            | 189 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 310 insertions(+), 24 deletions(-)



