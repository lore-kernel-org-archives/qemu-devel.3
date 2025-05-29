Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E74FC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 22:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKlKj-0005VX-Sw; Thu, 29 May 2025 18:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKi-0005VG-Io
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKg-0002Ye-A5
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748556154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lNx50CKo93bIop0qsxJcDyG4nfode3KKeWXnCSJ7vI0=;
 b=K8rXCfki6XXvB8ngnEo9gm008JvXkwNNyzIXuxg6x3uy9K132XGilPKsedsGmX/8bVR5DT
 J5aK5A7CM9EziFq/GaX1XDjC6pPJkT72KNaxIi5kItxcV24RhAmByeUNVqjhn22wlGnE5h
 mDipD9/1sFTqKZCNZD1yuXjxuciH/38=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-CAsvgaR3O2i2DMTJc3Oa_A-1; Thu,
 29 May 2025 18:02:32 -0400
X-MC-Unique: CAsvgaR3O2i2DMTJc3Oa_A-1
X-Mimecast-MFC-AGG-ID: CAsvgaR3O2i2DMTJc3Oa_A_1748556152
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE5A11955E7A
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 22:02:31 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 671CF19560A7
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 22:02:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] NBD patches through 2025-05-29
Date: Thu, 29 May 2025 17:02:07 -0500
Message-ID: <20250529220228.1187563-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

The following changes since commit d2e9b78162e31b1eaf20f3a4f563da82da56908d:

  Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/armbru into staging (2025-05-29 08:36:01 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2025-05-29

for you to fetch changes up to c49dda7254d43d9e1d4da59c55f02055ba7c4c1b:

  iotests: Filter out ZFS in several tests (2025-05-29 16:40:00 -0500)

----------------------------------------------------------------
NBD patches for 2025-05-29

- Nir Soffer: Allow for larger Unix socket buffers in NBD
- Eric Blake: clean up mirror-sparse iotest issues

----------------------------------------------------------------
Eric Blake (3):
      iotests: Use disk_usage in more places
      iotests: Improve mirror-sparse on ext4 and xfs
      iotests: Filter out ZFS in several tests

Nir Soffer (3):
      io: Add helper for setting socket send buffer size
      nbd: Set unix socket send buffer on macOS
      nbd: Set unix socket send buffer on Linux

 include/io/channel-socket.h                 | 13 +++++++++++++
 nbd/nbd-internal.h                          |  5 +++++
 io/channel-socket.c                         | 11 +++++++++++
 nbd/client-connection.c                     |  3 +++
 nbd/common.c                                | 26 +++++++++++++++++++++++++
 nbd/server.c                                |  2 ++
 tests/qemu-iotests/common.rc                | 30 +++++++++++++++++++++++++++++
 tests/qemu-iotests/106                      |  1 +
 tests/qemu-iotests/125                      |  2 +-
 tests/qemu-iotests/175                      |  1 +
 tests/qemu-iotests/221                      |  1 +
 tests/qemu-iotests/253                      |  1 +
 tests/qemu-iotests/308                      |  5 +++--
 tests/qemu-iotests/tests/mirror-sparse      |  9 ++++++---
 tests/qemu-iotests/tests/write-zeroes-unmap |  1 +
 15 files changed, 105 insertions(+), 6 deletions(-)

-- 
2.49.0


