Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6ECC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngG-0000AV-Fn; Mon, 11 Mar 2024 17:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngF-00009z-7k
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngB-0003xD-0j
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uMS+nCF2NuJY5wFKbMCyMEHpALuR7K278nrHqjHzHBY=;
 b=S9AzYOnnD4ZIPIRvpDkl/obrFXp5ivZexF9OYpP0WGG1WqOlw3SOrhyhzJZ2fZ1EbEAdPP
 i2ADUIGQNQV55j3gcsAcWY8QC5EvmR2bQR/rpLJlfWZVRBzq7OyDJpBGF222IHutwCeBDC
 8yC/fvzWwue5B6k1+gDcV9UnP/3D8Vo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-EWVrUBjyOamtsevBRwcUMw-1; Mon, 11 Mar 2024 17:59:28 -0400
X-MC-Unique: EWVrUBjyOamtsevBRwcUMw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6e4e54fb7b4so2273591a34.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194368; x=1710799168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uMS+nCF2NuJY5wFKbMCyMEHpALuR7K278nrHqjHzHBY=;
 b=FKkigx1g+Z16/R/R5UlHuJH5xSJHihWEP0FGSGk5Ki5kqmb8YSFDqFJAEDudWuSG60
 ze/SqEHbCeo33acW4pA90DAtyIMr2B848fmIrs02N3KJe577N8NACoLaS0REogXvnrnn
 w7DiEl5fiZYGzmL5mkL4sX3QbrGaAr+CvAUKNUZ9trfIGJ2qsw8BgwAmgQxHh0tNdZfL
 GYshP/UWT5qMIegO68OmMatxIgEdjOeoBaWAKkBJZHIZdjGC9AoqU5/8yy9LHz8GHp5h
 1Kwl77d972AQOncZLn4/k80b9Ce5oYpK41VzHJVoUv/AYYyuyt7YvZxX6wiX2UOhMqU9
 f6hw==
X-Gm-Message-State: AOJu0Yw1Y4ijPgGojYszaZhCo/stK09h2OzeZWIEGdLAwvlZCki2rkbQ
 fm2V4eT4MpqRwGKGb4TLCeP8RnJQiQ8EbQ8N3vP614xxXn4QJWlvIDeT/Nld40aeamcmrOVSJBH
 8U6S0ixRV/Kl/NMIVBt/w0NPiyQSAJsfKSwkUcpjWtfZTff0MSk/yJWll0la7R36jgZqwOeUzjR
 zvkE6x38omatyMUA3MwHt1ByrMlrKoiv5vSA==
X-Received: by 2002:a05:6808:178c:b0:3c2:4a71:7084 with SMTP id
 bg12-20020a056808178c00b003c24a717084mr282192oib.2.1710194367777; 
 Mon, 11 Mar 2024 14:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEeVDP6mIlrm2uMldGt/xygLxLZ7+vY5V/rVXG/lGErvYmO1SzfMW7NA89yxgL2kM2N67guQ==
X-Received: by 2002:a05:6808:178c:b0:3c2:4a71:7084 with SMTP id
 bg12-20020a056808178c00b003c24a717084mr282174oib.2.1710194367314; 
 Mon, 11 Mar 2024 14:59:27 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:27 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 00/34] Migration 20240311 patches
Date: Mon, 11 Mar 2024 17:58:51 -0400
Message-ID: <20240311215925.40618-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:

  Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240311-pull-request

for you to fetch changes up to 1815338df00fd0a3fe25085564c6966f74c8f43d:

  migration/multifd: Add new migration test cases for legacy zero page checking. (2024-03-11 16:57:09 -0400)

----------------------------------------------------------------
Migration pull request

- Avihai's fix to allow vmstate iterators to not starve for VFIO
- Maksim's fix on additional check on precopy load error
- Fabiano's fix on fdatasync() hang in mapped-ram
- Jonathan's fix on vring cached access over MMIO regions
- Cedric's cleanup patches 1-4 out of his error report series
- Yu's fix for RDMA migration (which used to be broken even for 8.2)
- Anthony's small cleanup/fix on err message
- Steve's patches on privatize migration.h
- Xiang's patchset to enable zero page detections in multifd threads

----------------------------------------------------------------

Anthony PERARD (1):
  migration: Fix format in error message

Avihai Horon (3):
  migration: Don't serialize devices in qemu_savevm_state_iterate()
  vfio/migration: Refactor vfio_save_state() return value
  vfio/migration: Add a note about migration rate limiting

Cédric Le Goater (4):
  migration: Report error when shutdown fails
  migration: Remove SaveStateHandler and LoadStateHandler typedefs
  migration: Add documentation for SaveVMHandlers
  migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error

Fabiano Rosas (3):
  migration/multifd: Don't fsync when closing QIOChannelFile
  migration/multifd: Allow zero pages in file migration
  migration/multifd: Allow clearing of the file_bmap from multifd

Hao Xiang (5):
  migration/multifd: Add new migration option zero-page-detection.
  migration/multifd: Implement zero page transmission on the multifd
    thread.
  migration/multifd: Implement ram_save_target_page_multifd to handle
    multifd version of MigrationOps::ram_save_target_page.
  migration/multifd: Enable multifd zero page checking by default.
  migration/multifd: Add new migration test cases for legacy zero page
    checking.

Jonathan Cameron (4):
  physmem: Rename addr1 to more informative mr_addr in
    flatview_read/write() and similar
  physmem: Reduce local variable scope in flatview_read/write_continue()
  physmem: Factor out body of flatview_read/write_continue() loop
  physmem: Fix wrong address in large
    address_space_read/write_cached_slow()

Maksim Davydov (1):
  migration/ram: add additional check

Steve Sistare (12):
  migration: export fewer options
  migration: remove migration.h references
  migration: export migration_is_setup_or_active
  migration: export migration_is_active
  migration: export migration_is_running
  migration: export vcpu_dirty_limit_period
  migration: migration_thread_is_self
  migration: migration_is_device
  migration: migration_file_set_error
  migration: privatize colo interfaces
  migration: delete unused accessors
  migration: purge MigrationState from public interface

Yu Zhang (1):
  migration/rdma: Fix a memory issue for migration

 docs/devel/migration/main.rst       |   3 +-
 qapi/migration.json                 |  38 +++-
 include/hw/qdev-properties-system.h |   4 +
 include/migration/client-options.h  |  25 +++
 include/migration/misc.h            |  18 +-
 include/migration/register.h        | 267 +++++++++++++++++++++++++---
 include/qemu/typedefs.h             |   2 -
 migration/migration.h               |   7 +-
 migration/multifd.h                 |  23 ++-
 migration/options.h                 |   7 +-
 migration/ram.h                     |   3 +-
 hw/core/machine.c                   |   4 +-
 hw/core/qdev-properties-system.c    |  10 ++
 hw/vfio/common.c                    |  17 +-
 hw/vfio/container.c                 |   1 -
 hw/vfio/migration.c                 |  24 ++-
 hw/virtio/vhost-user.c              |   1 -
 hw/virtio/virtio-balloon.c          |   2 -
 io/channel-file.c                   |   5 -
 migration/colo.c                    |  17 +-
 migration/file.c                    |   4 +-
 migration/migration-hmp-cmds.c      |   9 +
 migration/migration.c               |  67 ++++---
 migration/multifd-zero-page.c       |  87 +++++++++
 migration/multifd-zlib.c            |  21 ++-
 migration/multifd-zstd.c            |  20 ++-
 migration/multifd.c                 | 120 ++++++++++---
 migration/options.c                 |  32 +++-
 migration/qemu-file.c               |   5 +-
 migration/ram.c                     |  62 +++++--
 migration/rdma.c                    |   2 +-
 migration/savevm.c                  |  23 +--
 net/colo-compare.c                  |   3 +-
 net/vhost-vdpa.c                    |   3 +-
 stubs/colo.c                        |   1 -
 system/dirtylimit.c                 |  13 +-
 system/physmem.c                    | 260 +++++++++++++++++----------
 system/qdev-monitor.c               |   1 -
 target/loongarch/kvm/kvm.c          |   1 -
 target/riscv/kvm/kvm-cpu.c          |   4 +-
 tests/qtest/migration-test.c        |  52 ++++++
 tests/unit/test-vmstate.c           |   1 -
 migration/meson.build               |   1 +
 migration/trace-events              |   8 +-
 44 files changed, 981 insertions(+), 297 deletions(-)
 create mode 100644 include/migration/client-options.h
 create mode 100644 migration/multifd-zero-page.c

-- 
2.44.0


