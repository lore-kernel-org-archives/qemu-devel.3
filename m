Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F38CD128D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 07:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq6OX-0007BS-QY; Fri, 29 Mar 2024 03:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6OU-00079O-8h
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6OR-00017h-FY
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711696274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=erMzH2C7dqi8cQZRpUJ9yFqYNN6m+5y/bN81/70Nv94=;
 b=eCYL13dvlKpX3bcj3gpamVmaigo4vamLijRYQ4VXbCV4nEt2RPyZm2B0u/7bDMwTx4ib4t
 l8TQAINqtmtNC+5exQhg+VOgqSXufdkNmWqcd+yR6anO6xLu1vmKHB5SmoJQ2/mYujfibN
 llRcXPHpegfP1CBTZjMbxkHXxMf0Gho=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-Vnoqhr8rMhOpiHxjgkLHaQ-1; Fri,
 29 Mar 2024 03:11:11 -0400
X-MC-Unique: Vnoqhr8rMhOpiHxjgkLHaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69F183C0254B;
 Fri, 29 Mar 2024 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAAAAC423E0;
 Fri, 29 Mar 2024 07:11:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/5] Net patches
Date: Fri, 29 Mar 2024 15:10:55 +0800
Message-ID: <20240329071100.31376-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:

  Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to d9b33018a0da51eddceb48c42345cfb351065f3e:

  Revert "tap: setting error appropriately when calling net_init_tap_one()" (2024-03-29 14:59:07 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmYGZ7EACgkQ7wSWWzmN
YhHvxgf/SDEYYMlxU7PA1SfwlIYtUG8K1zQnwLXNY6ySCJuCn1IdVoITaUt3BtE5
OtrhKI8cW5WwL4qzkElWlL431vyqomGdmJQedF8agwoR2aIo24i/Ue09MHxJxXUB
ONEOv3bizDCYWUjz+PMHRdIbo0AiSNaUDnB8iY59yD6HZqSLVMDx8Ia2KVrzUKwc
nMuqkDsVIc3gwqFNPbTl3yqVt6k1x+vBCGQUg9BiKE3pkUcONhsJpBYYj4hlY9mn
/BPlQBcRUoLHQD7KGSUKVFSODHPYzDg7BsSz2+EpuZucRRI3VEyHlcB5A6LIVhrK
fpqd+80Fb7VE9CAxA2gFj7gh5uPJ1A==
=shO6
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Akihiko Odaki (5):
      virtio-net: Fix vhost virtqueue notifiers for RSS
      ebpf: Fix indirections table setting
      hw/net/net_tx_pkt: Fix virtio header without checksum offloading
      tap-win32: Remove unnecessary stubs
      Revert "tap: setting error appropriately when calling net_init_tap_one()"

 ebpf/ebpf_rss.c         |  9 +++++++--
 hw/net/net_tx_pkt.c     |  1 +
 hw/net/virtio-net.c     |  4 ++--
 include/net/vhost_net.h |  3 ---
 net/tap-win32.c         | 54 -------------------------------------------------
 net/tap.c               | 22 +++++---------------
 6 files changed, 15 insertions(+), 78 deletions(-)


