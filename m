Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78547C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRc-0005xx-OF; Mon, 23 Jun 2025 16:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRa-0005xQ-HG
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRY-0003TM-Cc
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nM5nVkO1aSgvj4/5vT5mHHnfpl/4WA57wm/5ugXC5rU=;
 b=ZL6L68bwp4CW9diOMHPoYNDWks4emSfCWaCtuind+EdKbE37VX8vZW12f5Yh489hRyv/h3
 cUxXDG6zyurovhbJ8icjc30+ZHSCNp0GKLweAg4UlWOGvmJjjDmo2kX98yj4PlR8Q6tbsS
 LsHXg2hZRTnEBWVgaHLEQr/VBOSXB6k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-mKov9vLWM4isbdPeAP0BxA-1; Mon, 23 Jun 2025 16:07:01 -0400
X-MC-Unique: mKov9vLWM4isbdPeAP0BxA-1
X-Mimecast-MFC-AGG-ID: mKov9vLWM4isbdPeAP0BxA_1750709220
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6faca0f2677so119558646d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709220; x=1751314020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nM5nVkO1aSgvj4/5vT5mHHnfpl/4WA57wm/5ugXC5rU=;
 b=F5psPa6YBM8CWqWb8Ry9O7ZdTzBdI6YocfXDSN7OugHIPkd8IMa/gRpKZmHxqV/BPK
 SC5I4Gyy5oLRm4n3G5Ewt2/Wo3MB1BnwnOhut/HeQSe6N8b8V3843Ei2j1CfZqMsblre
 6lozSy92JUwoKpjbdnj1NJy+fZtWNlomsluA/iIzjO1E4aKSSIv3YCTbwG7C3zgvZhlF
 82/dKMRWZSCzx7T64iwKbGY6GV+vQnleKNSRKJYDkILKd0pYn13XvA5VLRVsSkJUyJdg
 k8jyB+jA/UEMCgIVethdLWp4n+eM5JoCTqLa04n2HyFZms4h+VlH5OM+Ja+0HaTCRPAw
 okOQ==
X-Gm-Message-State: AOJu0Yxgz3KekxrKwgeNIhJKzS9dHc1sA3D916KMLlxEfwuU2sLT1kAF
 CohWJY4Wyg5B12BHCm7O3AD2dS5MdE2hawOcfMOc1g70CXfW7/drRM3CUouAy2y2FUXOCWacGMz
 tNMUoIoT7HV99KXKFLp8EvrwMoCzIikes95Dhk5jpzdDpsgwKeH+tOhNYCwLvp2+xya8rFFQBG6
 849bKklt33oISEki3VQP+eSddjoD2dNtSujdByOA==
X-Gm-Gg: ASbGncvCLPbGMEZAbWf8XrOc6WZoiU8tkImfxBM0pZymTTvz1qFj3dJkgZVH4yITGrJ
 /f1m/hTZrP/2RYKo0QIvUxjHrBKcyFkSuPczhKs1WMNeDSDgeQeQKAvJISOAjU76Rylob76o2aB
 PcxowkbjvYPUYPXYrEHb9hfF3M6AQvKZ9hiRWJBekq2mIyryxflodVKWYaV6qI5vyfEsMD09byb
 BOb3+hRyAydlIcWzgeczJ6DGk5pl/R/XWySEZfV9xy8+Hh2wCCTOYx6To/Zh7J3q0VAsg7cPVnx
 HCADPe/QC8s=
X-Received: by 2002:a05:6214:390c:b0:6fa:fb25:e0f1 with SMTP id
 6a1803df08f44-6fd0a51b3ccmr210748256d6.24.1750709220043; 
 Mon, 23 Jun 2025 13:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7orxssWuWZJYQmJmhgbRVqgpSuLLICeeNtrcvD2H+UlWqmAKjSLz/J4VqFSBt2ZFn05KRhQ==
X-Received: by 2002:a05:6214:390c:b0:6fa:fb25:e0f1 with SMTP id
 6a1803df08f44-6fd0a51b3ccmr210747826d6.24.1750709219474; 
 Mon, 23 Jun 2025 13:06:59 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:06:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 00/11] Migration staging patches
Date: Mon, 23 Jun 2025 16:06:45 -0400
Message-ID: <20250623200656.1882674-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

The following changes since commit 43ba160cb4bbb193560eb0d2d7decc4b5fc599fe:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-06-21 10:00:46 -0400)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-staging-pull-request

for you to fetch changes up to 2fde3fb916079ee0ff0fc26d9446c813b1d5cc28:

  physmem: Support coordinated discarding of RAM with guest_memfd (2025-06-23 16:03:59 -0400)

----------------------------------------------------------------
Migration / Memory pull

- Yanfei's optimization to skip log_clear during completion
- Fabiano's cleanup to remove leftover migration-helpers.c file
- Juraj's vnc fix on display pause after migration
- Jaehoon's cpr test fix on possible race of server establishment
- Chenyi's initial support on vfio enablement for guest-memfd

----------------------------------------------------------------

Chaney, Ben (1):
  migration: Don't sync volatile memory after migration completes

Chenyi Qiang (5):
  memory: Export a helper to get intersection of a MemoryRegionSection
    with a given range
  memory: Change memory_region_set_ram_discard_manager() to return the
    result
  memory: Unify the definiton of ReplayRamPopulate() and
    ReplayRamDiscard()
  ram-block-attributes: Introduce RamBlockAttributes to manage RAMBlock
    with guest_memfd
  physmem: Support coordinated discarding of RAM with guest_memfd

Fabiano Rosas (1):
  tests/qtest: Remove migration-helpers.c

Jaehoon Kim (2):
  migration: Support fd-based socket address in cpr_transfer_input
  tests/migration: Setup pre-listened cpr.sock to remove race-condition.

Juraj Marcin (1):
  ui/vnc: Update display update interval when VM state changes to
    RUNNING

Yanfei Xu (1):
  migration/ram: avoid to do log clear in the last round

 MAINTAINERS                       |   1 +
 include/system/memory.h           | 110 +++++--
 include/system/ramblock.h         |  22 ++
 ui/vnc.h                          |   2 +
 accel/kvm/kvm-all.c               |   9 +
 hw/virtio/virtio-mem.c            |  83 ++---
 migration/cpr-transfer.c          |   7 +-
 migration/ram.c                   |  31 +-
 system/memory.c                   |  22 +-
 system/physmem.c                  |  23 +-
 system/ram-block-attributes.c     | 444 +++++++++++++++++++++++++
 tests/qtest/migration-helpers.c   | 530 ------------------------------
 tests/qtest/migration/cpr-tests.c |  14 +-
 ui/vnc.c                          |  12 +
 system/meson.build                |   1 +
 system/trace-events               |   3 +
 16 files changed, 688 insertions(+), 626 deletions(-)
 create mode 100644 system/ram-block-attributes.c
 delete mode 100644 tests/qtest/migration-helpers.c

-- 
2.49.0


