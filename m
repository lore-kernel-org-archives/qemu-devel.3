Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94994C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5O9-0006HA-FU; Tue, 07 Jul 2026 08:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5O7-0006EV-SJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5O6-0006Xv-57
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QXQf6uFkfZ9vbXnS8pHChL2YSXPD8c5J0krNsnlH5ck=;
 b=QfD60N3kPFhbHA/bh0fKUbFcxalrfyULfB+UGFmJrfnFa2nKfJfUIkTJ6cfRdaYftzv10y
 1r5kOrgDF7MDQQIuOGZPjlvEbh+CWTw22ETUzLn4JluMJKzvMV09ousbuBAVDTRXmAbytM
 N5nMTpMbVy2HMtiI9cv4Uy7UzWxu45g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-G81yt4EYPFSj5DD-kAZXaA-1; Tue,
 07 Jul 2026 08:58:54 -0400
X-MC-Unique: G81yt4EYPFSj5DD-kAZXaA-1
X-Mimecast-MFC-AGG-ID: G81yt4EYPFSj5DD-kAZXaA_1783429133
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B6D9183044A; Tue,  7 Jul 2026 12:58:53 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18E2E1956040; Tue,  7 Jul 2026 12:58:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 00/15] s390x updates (contains Linux headers update)
Date: Tue,  7 Jul 2026 14:58:32 +0200
Message-ID: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 4ee536fac748b70e6f3d8568ddd20cfbaa9cf7bf:

  Merge tag 'firmware-20260704-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-07-05 08:42:47 +0200)

are available in the Git repository at:

  https://gitlab.com/cohuck/qemu tags/s390x-20260707

for you to fetch changes up to f4b7ae0a9ee41baad3b6c1e2b55611793de013cc:

  pc-bios/s390-ccw.img: update s390x bios (2026-07-07 06:05:41 -0400)

----------------------------------------------------------------
s390x updates:
- fix some errors when IPLing from PCI devices
- a number of fixes for guest->host error handling
- add ASTFLE facility 2 support (with headers update)
- regenerate s390-ccw.img

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/sclp: reject invalid write event data headers

Christoph Schlameuss (2):
  linux-headers: Update to Linux v7.2-rc1 with
    KVM_S390_VM_CPU_FEAT_ASTFLEIE2
  s390x/kvm: Add ASTFLE facility 2 for nested virtualization

Cornelia Huck (1):
  pc-bios/s390-ccw.img: update s390x bios

Eric Farman (1):
  s390x/css: limit number of CHPIDs in description

Harald Freudenberger (1):
  target/s390x: Fix wrong address handling in address loops

Jared Rossi (3):
  pc-bios/s390-ccw/virtio.c: Fix missing break for PCI notifications
  pc-bios/s390-ccw: Verify virtio support when booting from virtio PCI
    device on s390x
  pc-bios/s390-ccw: write IPLB location for non-net virtio devices

Matthew Rosato (3):
  s390x/pci: Tighten region detection for BAR read/write
  s390x/pci: Shrink RPCIT ranges to registered window
  s390x/ioinst: Require strict length and format for SEI CHSC handler

Zhuoying Cai (3):
  pc-bios/s390-ccw: Refactor byte swapping
  pc-bios/s390-ccw: Add per-queue notification offset for multi-queue
    virtio configurations
  s390x: Enable boot menu for virtio pci device

 hw/s390x/css.c                                |  17 ++++
 hw/s390x/event-facility.c                     |   6 ++
 hw/s390x/ipl.c                                |   1 +
 hw/s390x/s390-pci-inst.c                      |  32 ++++++-
 hw/s390x/sclp.c                               |   2 +
 include/hw/s390x/sclp.h                       |   4 +-
 include/standard-headers/drm/drm_fourcc.h     |  54 +++++++-----
 include/standard-headers/linux/ethtool.h      |   3 +
 include/standard-headers/linux/pci_regs.h     |   2 +
 include/standard-headers/linux/virtio_can.h   |  78 ++++++++++++++++++
 .../standard-headers/linux/virtio_console.h   |   2 +-
 include/standard-headers/linux/virtio_gpu.h   |   9 ++
 linux-headers/asm-s390/kvm.h                  |   1 +
 linux-headers/asm-x86/kvm.h                   |   2 +
 linux-headers/linux/iommufd.h                 |  12 ++-
 linux-headers/linux/kvm.h                     |   1 +
 pc-bios/s390-ccw.img                          | Bin 95992 -> 104136 bytes
 pc-bios/s390-ccw/main.c                       |   5 +-
 pc-bios/s390-ccw/virtio-pci.c                 |  57 +++++++++----
 pc-bios/s390-ccw/virtio-pci.h                 |   5 +-
 pc-bios/s390-ccw/virtio.c                     |  29 ++++---
 pc-bios/s390-ccw/virtio.h                     |   2 +
 target/s390x/cpu_features.c                   |   3 +
 target/s390x/cpu_features.h                   |   1 +
 target/s390x/cpu_features_def.h.inc           |   3 +
 target/s390x/cpu_models.c                     |   2 +
 target/s390x/gen-features.c                   |   1 +
 target/s390x/ioinst.c                         |  20 +++++
 target/s390x/kvm/kvm.c                        |   1 +
 target/s390x/tcg/crypto_helper.c              |  12 +--
 30 files changed, 299 insertions(+), 68 deletions(-)
 create mode 100644 include/standard-headers/linux/virtio_can.h

-- 
2.54.0


