Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D0FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOmM-0001Pw-Db; Tue, 23 Apr 2024 18:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmK-0001PY-JA
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmI-000658-QL
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WR9tzZjpJbU/j12hvv4ER+Qhum9sJQt4Y+15bRyr+hY=;
 b=YsJnUFNlIhzi2OVOSKRp2130fi6NM9DqwV6ve/q7Dw4lv52Ct4XW1jXkNorYU5AB+S7YnW
 MtzgymE6C+g/qKtYfFGugT+oU+6x92z1OLAk7oXHwqzIU/AcCDeX1DRRMM8b741VSDjlyF
 lTrBCFUBWaXDcpXBa/xPVVwqwszxXE8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-f8l81ES6NLC4Q3XrOyGjtA-1; Tue, 23 Apr 2024 18:38:16 -0400
X-MC-Unique: f8l81ES6NLC4Q3XrOyGjtA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a05461964cso18604376d6.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911896; x=1714516696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WR9tzZjpJbU/j12hvv4ER+Qhum9sJQt4Y+15bRyr+hY=;
 b=BZntYSzhSmvsp7I4R2X4n5roZuUYUAVmGO7WJhVeIFgpaaVPE7X9cZW1aY/q0cjktV
 jwNA+NAQ4rA/gO+XTzdMwTkdg0fq3xwLAygwJbyBTB4YW1O7s6worHhtq6A4eqeUeDGV
 dHO/HEyHrME4T58BrT9+Nq1WOZ3tCfJvaUIaB1I1dRu/lQM3kZXYADpRc0d1p9EISSV1
 2yKi0D1HiTK6KxsJEImnukozcvLvrEWNfDDXeGECgLNQFdeTeVikVajKEpm9MiUJgdh7
 FBxOMAhKEyoetTT9uFSm8Dj7dQMBzXDSQyw1lIsFT7oKxvvXmxHO/N9VDb6RyB3aZv4Y
 /o5w==
X-Gm-Message-State: AOJu0YzTOCk3UN6u6wL9n1g8RMIXAhKQxxM0y0wyvBI9QZ+eBBK4VHCU
 MhRZKIUkasmCD73gzkmrGKi7d+CyInfAjrdZvttIW+D/iUycVQqoyo9FCscXYbpXOr385BCr/U3
 UuXzN14frzw/KgRkFxvNE/21zz/3SXfyQNGoODv9sR8Y+kd6SOsvr52zuz4yJjNB1NIByeNhuP1
 ns8SosVv1Z472SIq7nxrWsJTYSkctyRh61Sw==
X-Received: by 2002:a05:620a:4612:b0:78e:c79a:ae37 with SMTP id
 br18-20020a05620a461200b0078ec79aae37mr983932qkb.6.1713911895682; 
 Tue, 23 Apr 2024 15:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwyY4WhQYTAm60plXoSB9UwE5PSxK8KvTMl2MDv40/SEPsTqXSw6OMdhkewSIy+pUc053qJQ==
X-Received: by 2002:a05:620a:4612:b0:78e:c79a:ae37 with SMTP id
 br18-20020a05620a461200b0078ec79aae37mr983899qkb.6.1713911894924; 
 Tue, 23 Apr 2024 15:38:14 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 00/26] Migration 20240423 patches
Date: Tue, 23 Apr 2024 18:37:47 -0400
Message-ID: <20240423223813.3237060-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

The following changes since commit c25df57ae8f9fe1c72eee2dab37d76d904ac382e:

  Update version for 9.0.0 release (2024-04-23 14:19:21 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240423-pull-request

for you to fetch changes up to 2cc637f1ea08d2a1b19fc5b1a30bc609f948de93:

  migration/colo: Fix bdrv_graph_rdlock_main_loop: Assertion `!qemu_in_coroutine()' failed. (2024-04-23 18:36:01 -0400)

----------------------------------------------------------------
Migration pull for 9.1

- Het's new test cases for "channels"
- Het's fix for a typo for vsock parsing
- Cedric's VFIO error report series
- Cedric's one more patch for dirty-bitmap error reports
- Zhijian's rdma deprecation patch
- Yuan's zeropage optimization to fix double faults on anon mem
- Zhijian's COLO fix on a crash

----------------------------------------------------------------

Cédric Le Goater (15):
  s390/stattrib: Add Error** argument to set_migrationmode() handler
  vfio: Always report an error in vfio_save_setup()
  migration: Always report an error in block_save_setup()
  migration: Always report an error in ram_save_setup()
  migration: Add Error** argument to vmstate_save()
  migration: Add Error** argument to qemu_savevm_state_setup()
  migration: Add Error** argument to .save_setup() handler
  migration: Add Error** argument to .load_setup() handler
  memory: Add Error** argument to .log_global_start() handler
  migration: Introduce ram_bitmaps_destroy()
  memory: Add Error** argument to the global_dirty_log routines
  migration: Add Error** argument to ram_state_init()
  migration: Add Error** argument to xbzrle_init()
  migration: Modify ram_init_bitmaps() to report dirty tracking errors
  migration: Add Error** argument to add_bitmaps_to_list()

Het Gala (9):
  tests/qtest/migration: Add 'to' object into migrate_qmp()
  tests/qtest/migration: Replace connect_uri and move
    migrate_get_socket_address inside migrate_qmp
  tests/qtest/migration: Replace migrate_get_connect_uri inplace of
    migrate_get_socket_address
  tests/qtest/migration: Add channels parameter in migrate_qmp_fail
  tests/qtest/migration: Add migrate_set_ports into migrate_qmp to
    update migration port value
  tests/qtest/migration: Add channels parameter in migrate_qmp
  tests/qtest/migration: Add multifd_tcp_plain test using list of
    channels instead of uri
  tests/qtest/migration: Add negative tests to validate migration QAPIs
  tests/qtest/migration: Fix typo for vsock in SocketAddress_to_str

Li Zhijian (1):
  migration/colo: Fix bdrv_graph_rdlock_main_loop: Assertion
    `!qemu_in_coroutine()' failed.

Yuan Liu (1):
  migration/multifd: solve zero page causing multiple page faults

 include/exec/memory.h                 |  10 +-
 include/exec/ramblock.h               |   2 +-
 include/hw/s390x/storage-attributes.h |   2 +-
 include/migration/register.h          |   6 +-
 migration/ram.h                       |   1 +
 migration/savevm.h                    |   2 +-
 tests/qtest/migration-helpers.h       |  10 +-
 hw/i386/xen/xen-hvm.c                 |   5 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/s390x/s390-stattrib-kvm.c          |  12 +-
 hw/s390x/s390-stattrib.c              |  15 ++-
 hw/vfio/common.c                      |   4 +-
 hw/vfio/migration.c                   |  29 +++--
 hw/virtio/vhost.c                     |   3 +-
 migration/block-dirty-bitmap.c        |  34 ++---
 migration/block.c                     |  17 ++-
 migration/colo.c                      |  18 +--
 migration/dirtyrate.c                 |  13 +-
 migration/migration.c                 |  33 ++++-
 migration/multifd-zero-page.c         |   4 +-
 migration/multifd-zlib.c              |   1 +
 migration/multifd-zstd.c              |   1 +
 migration/multifd.c                   |   1 +
 migration/ram.c                       | 110 +++++++++++-----
 migration/savevm.c                    |  57 ++++----
 system/memory.c                       |  44 ++++++-
 tests/qtest/migration-helpers.c       | 158 +++++++++++++++++++++-
 tests/qtest/migration-test.c          | 180 ++++++++++++++------------
 28 files changed, 558 insertions(+), 216 deletions(-)

-- 
2.44.0


