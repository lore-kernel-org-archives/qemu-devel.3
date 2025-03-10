Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F71BC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trc9x-0005g9-KG; Mon, 10 Mar 2025 08:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trc9m-0005dX-M7
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1trc9k-0004w0-Nx
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741609370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rfbkRTKHrJ9RysW18PIFmpIXF0/iB0m/TtNUOoHpQdo=;
 b=VSDROa5f7SyUOoasba6WQNguCB7bx51zAGmB4tMKmQirGTvXzlwPWagMyC169vwTs3KCSJ
 py7xF3F8u4a/AcOa8Q10dW+MHTnUVs8fbsFdfbezzV87t0JLP2U4SNK6p/CGNLgD5btics
 xQ5bCNskkKEZy2oEn0ojjD5A0vdkPm8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-y9VSIN3pPySRNROo4F83PA-1; Mon,
 10 Mar 2025 08:22:49 -0400
X-MC-Unique: y9VSIN3pPySRNROo4F83PA-1
X-Mimecast-MFC-AGG-ID: y9VSIN3pPySRNROo4F83PA_1741609368
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E8EB1956083
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7721118001E9; Mon, 10 Mar 2025 12:22:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/5] Net patches
Date: Mon, 10 Mar 2025 20:22:35 +0800
Message-ID: <20250310122240.2908-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit d9a4282c4b690e45d25c2b933f318bb41eeb271d:

  Merge tag 'pull-tcg-20250308' of https://gitlab.com/rth7680/qemu into staging (2025-03-09 11:45:00 +0800)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to ac2ff9b840ce82cc7d5fd9ce4fd3019a434d7dc9:

  tap-linux: Open ipvtap and macvtap (2025-03-10 17:07:16 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmfO1zkACgkQ7wSWWzmN
YhET+wf+PkaGeFTNUrOtWpl35fSMKlmOVbb1fkPfuhVBmeY2Vh1EIN3OjqnzdV0F
wxpuk+wwmFiuV1n6RNuMHQ0nz1mhgsSlZh93N5rArC/PUr3iViaT0cb82RjwxhaI
RODBhhy7V9WxEhT9hR8sCP2ky2mrKgcYbjiIEw+IvFZOVQa58rMr2h/cbAb/iH4l
7T9Wba03JBqOS6qgzSFZOMxvqnYdVjhqXN8M6W9ngRJOjPEAkTB6Evwep6anRjcM
mCUOgkf2sgQwKve8pYAeTMkzXFctvTc/qCU4ZbN8XcoKVVxe2jllGQqdOpMskPEf
slOuINeW5M0K5gyjsb/huqcOTfDI2A==
=/Y0+
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Akihiko Odaki (3):
      util/iov: Do not assert offset is in iov
      Revert "hw/net/net_tx_pkt: Fix overrun in update_sctp_checksum()"
      tap-linux: Open ipvtap and macvtap

Eugenio Pérez (2):
      net: parameterize the removing client from nc list
      net: move backend cleanup to NIC cleanup

 hw/net/net_tx_pkt.c |  4 ----
 include/qemu/iov.h  |  5 +++--
 net/net.c           | 44 ++++++++++++++++++++++++++++++++++----------
 net/tap-linux.c     | 17 ++++++++++++++---
 net/vhost-vdpa.c    |  8 --------
 util/iov.c          |  5 -----
 6 files changed, 51 insertions(+), 32 deletions(-)



