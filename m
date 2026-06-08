Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28687CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdD2-00011f-Qx; Mon, 08 Jun 2026 12:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdD1-00010o-6i
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdCz-0007Nh-9N
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780937536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XE/w4YYgZVCNap+M+qldMZghXJZueJKo0+JlEzdR+AE=;
 b=H3rGQmJd80evS/k0xOYNBh8VEFjl/hZNS0sKILRF58JgC0Xw5R3GritVKks/dcBUriUZOA
 AtUUeOwwOUGDzBKV+ZDGz6KghHR4pJdaomNyzbAhRStdoijFyFEQdKBqePUn2TAEGtV8Ka
 UbIp/2DILwiPnqv1LdM85zoVRbE8Ql8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-3qRl82fqMV29IX95qWNtgQ-1; Mon,
 08 Jun 2026 12:52:13 -0400
X-MC-Unique: 3qRl82fqMV29IX95qWNtgQ-1
X-Mimecast-MFC-AGG-ID: 3qRl82fqMV29IX95qWNtgQ_1780937532
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55AD318007EA; Mon,  8 Jun 2026 16:52:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.50.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A3A219540CD; Mon,  8 Jun 2026 16:52:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/8] Block layer patches
Date: Mon,  8 Jun 2026 18:51:59 +0200
Message-ID: <20260608165207.307488-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit cc329c491768b2d91eb0b0984f3baa0bf805776d:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-06-08 09:30:30 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 296b66d05bac7eb2b86600febdbd2bd8d410f026:

  qed: Don't try to flush during incoming migration (2026-06-08 17:00:47 +0200)

----------------------------------------------------------------
Block layer patches

- qcow2: Fix data loss on zero write with detect-zeroes=unmap
- qemu-img bitmap: add sub-command --remove-all
- export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
- virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)
- qed: Don't try to flush during incoming migration
- iotests/136: Test stats-intervals with -blockdev/-device

----------------------------------------------------------------
Denis V. Lunev (1):
      qemu-img: add sub-command --remove-all to 'qemu-img bitmap'

Fabiano Rosas (1):
      qed: Don't try to flush during incoming migration

Fiona Ebner (3):
      block/export/fuse: use struct fuse_init_in
      block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
      iotests: test shared mmap for fuse export

Kevin Wolf (1):
      iotests/136: Test stats-intervals with -blockdev/-device

Stefan Hajnoczi (1):
      virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)

Thomas Lamprecht (1):
      qcow2: Fix data loss on zero write with detect-zeroes=unmap

 docs/tools/qemu-img.rst                       |  10 ++-
 block/qcow2.h                                 |   4 +
 block/export/fuse.c                           |  69 +++++++++++++----
 block/qcow2-cluster.c                         |  10 +--
 block/qcow2.c                                 |   8 +-
 block/qed.c                                   |  16 ++--
 hw/block/virtio-blk.c                         |   8 +-
 qemu-img.c                                    |  55 ++++++++++++--
 tests/qemu-iotests/046                        |  23 ++++++
 tests/qemu-iotests/046.out                    |  10 +++
 tests/qemu-iotests/136                        |  87 +++++++++++++++++++---
 tests/qemu-iotests/136.out                    |   4 +-
 tests/qemu-iotests/tests/fuse-mmap-shared     | 103 ++++++++++++++++++++++++++
 tests/qemu-iotests/tests/fuse-mmap-shared.out |   5 ++
 tests/qemu-iotests/tests/qemu-img-bitmaps     |  24 ++++++
 tests/qemu-iotests/tests/qemu-img-bitmaps.out |  46 ++++++++++++
 16 files changed, 430 insertions(+), 52 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/fuse-mmap-shared
 create mode 100644 tests/qemu-iotests/tests/fuse-mmap-shared.out


