Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE3606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xm00r9tJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cE-0006L0-UT; Mon, 02 Nov 2026 22:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cD-0006KE-Ay
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cB-0000ZD-JF
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QB08HgOYMFR/gCayoBbYlzATRderczz0DMs+ZIojE5g=;
 b=Xm00r9tJ/pVdUD0ymG4gi0e1FhuTa6V0CuNArrjbYn9hV94UcND//t8+ta/GiZDN+p9PHR
 8fB8sxaqwWwtvDW8aLLtrRB+pjStWQQe9JEb+Fi+MoyrUYHYf15/YQPU2prVfmIop0d6Qk
 Q+0UtgiU01ILCUg2mOf2pT4XBBDMaYc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-s5jw__w9P7-lJ0W7rrH52g-1; Mon,
 02 Nov 2026 22:55:12 -0500
X-MC-Unique: s5jw__w9P7-lJ0W7rrH52g-1
X-Mimecast-MFC-AGG-ID: s5jw__w9P7-lJ0W7rrH52g_1793678111
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9145A1955F12
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 03:55:11 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E29D7E8
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 03:55:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] block patches through 2026-11-02
Date: Mon,  2 Nov 2026 21:54:11 -0600
Message-ID: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 1c1f512972b25229d4b69ae7a3a7e5d7df30a6a6:

  Merge tag 'mips-20261102' of https://github.com/philmd/qemu into staging (2026-11-02 08:54:24 -0800)

are available in the Git repository at:

  https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-11-02

for you to fetch changes up to dd3efac4c2416a38bc7f92881c2a1f6b3ec053fd:

  block/block-copy: coalesce write-zeroes tasks (2026-11-02 21:37:20 -0600)

----------------------------------------------------------------
block patches through 2026-11-02

- Denis V. Lunev: honor block size change on scsi child
- Denis V. Lunev: cheaper zero handling in backup/commit

----------------------------------------------------------------
Denis V. Lunev (16):
      block: notify the parent when a replaced child has a different size
      scsi-disk: refresh the cached capacity from the resize callback
      tests/qtest/virtio-scsi: cover a replacement that changes the size
      tests/qemu-iotests/qom-set-drive: replace with a differently sized node
      block/commit: pass BDRV_WANT_PRECISE to block-status
      iotests/040: cover large and fragmented commit runs
      block/commit: batch block-status queries
      iotests/124: cover backup of zero clusters and holes
      block/block-copy: extract block_copy_set_task_method()
      block/block-copy: track known-zero source clusters
      block/backup: pre-fill zero_bitmap for full/bitmap
      block/block-copy: rename block_copy_is_cluster_allocated()
      block/block-copy: merge the two backup scan steps into block_copy_prescan()
      block/block-copy: replace zero_bitmap_valid with scan_done
      util/co-shared-resource: skip the mutex for an empty request
      block/block-copy: coalesce write-zeroes tasks

 qapi/block-core.json                       |   4 +-
 include/block/block-copy.h                 |   6 +-
 include/block/block_int-io.h               |   3 +
 block.c                                    |  13 ++
 block/backup.c                             |  88 +++++---
 block/block-copy.c                         | 326 +++++++++++++++++++++------
 block/commit.c                             |  60 ++++-
 hw/scsi/scsi-disk.c                        |  16 +-
 tests/qtest/virtio-scsi-test.c             |  63 ++++++
 util/qemu-co-shared-resource.c             |   8 +
 tests/qemu-iotests/040                     | 102 ++++++++-
 tests/qemu-iotests/040.out                 |   4 +-
 tests/qemu-iotests/124                     | 347 ++++++++++++++++++++++++++++-
 tests/qemu-iotests/124.out                 |   4 +-
 tests/qemu-iotests/tests/qom-set-drive     |  14 +-
 tests/qemu-iotests/tests/qom-set-drive.out |   2 +
 16 files changed, 935 insertions(+), 125 deletions(-)

-- 
2.56.0


