Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667EED5CCB9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B4t-0003WH-40; Wed, 30 Oct 2024 11:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4q-0003Vc-QI
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4o-0007kX-Cz
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G1yNXxsh8dTvITSx4+B06H/+QaPAvo9R+7WdzcB0NcI=;
 b=EPQ4R1BmC4fC8nuacrJ7sR3r0RXKR+QMzFl8/gk4lPNfN5zvlKWl1YJqJirLLWm7w8/L29
 ZVYjbmHBDDjiCk1GF0E0YRKTNvBHR8/Q/gFKGnHiJ3loNse7EUGCt8yKvmNMveLp9Es6QG
 250uNo4Dr2vHJYqHUWri2M9nmhXV210=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Ay1XWW5sMxSp-OPi81BmtA-1; Wed, 30 Oct 2024 11:57:38 -0400
X-MC-Unique: Ay1XWW5sMxSp-OPi81BmtA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbd2cb2f78so391406d6.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303856; x=1730908656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G1yNXxsh8dTvITSx4+B06H/+QaPAvo9R+7WdzcB0NcI=;
 b=Hpfg0vpN1hNA5TTEQUeST0fD0CHzR906hHtEJgnulDCvLcCH91o5qOF3VyPSsQgDMu
 pK41QgadsETQpBoCDzNBY1hI46R49eixGjRogfLfSISeMJloJg6s69AlPL7HD8Zx+3tp
 hBg9O1hM8VDGbiCX1ZQsK9v8TXhT9KNlP/UvXIq8bKSclvmH1tne7Cyj4gpopxYmcKhA
 s41gkhskNXCyt2T6yakZjz+D+sRyaLFU73QXmWayrKDP/mVo18NS4MnuUSVizTTz3jpJ
 /Ri7CBdOk4/FeBb+LcEj0dojenOASmicLI9lal6IrmIiWVdBGfu6h+iRU+S9etZ/1rce
 LPiA==
X-Gm-Message-State: AOJu0YwJ5l8voykq/WFL/QMKEhVBziVBeQQ56pTgsbK80OvJ5h58HskT
 rLjOe3JQ2feM6IvalagYk6V+F2boUHXgxi4SaGH+vWQugBopengM21ebYBLjX3OQYwAJ2eqREbK
 dg4HLaZkGP8hBjGTrJa4JfusWxZqwYejnPt9qJqbPhVnCjutEcAv871xW/eTRP9As/e1AthrdFJ
 sji0oXXNFGzafvtSd65MjSVCSzC4+aaldP8g==
X-Received: by 2002:a05:6214:5690:b0:6cc:255:2038 with SMTP id
 6a1803df08f44-6d2d91a53f2mr88763346d6.4.1730303856363; 
 Wed, 30 Oct 2024 08:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuiw55GRoIrPM+ou+c3z4K9pNheyGVO/c5c+UzxQ4cDlEQ+WdPJTxScliHxDrC8jkhuM6gyA==
X-Received: by 2002:a05:6214:5690:b0:6cc:255:2038 with SMTP id
 6a1803df08f44-6d2d91a53f2mr88762986d6.4.1730303855916; 
 Wed, 30 Oct 2024 08:57:35 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 00/18] Migration 20241030 patches
Date: Wed, 30 Oct 2024 11:57:16 -0400
Message-ID: <20241030155734.2141398-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The following changes since commit cc5adbbd50d81555b8eb73602ec16fde40b55be4:

  Merge tag 'pull-tpm-2024-10-18-1' of https://github.com/stefanberger/qemu-tpm into staging (2024-10-18 15:45:02 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20241030-pull-request

for you to fetch changes up to 53a60118d2654dd8e595e61f4e767ff747fd0b69:

  migration/multifd: Zero p->flags before starting filling a packet (2024-10-30 11:32:41 -0400)

----------------------------------------------------------------
Migration pull request for softfreeze

NOTE: checkpatch.pl could report a false positive on this branch:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  #21:
   {include/sysemu => migration}/cpu-throttle.h | 0

That's covered by "F: migration/" entry.

Changelog:

- Peter's cleanup patch on migrate_fd_cleanup()
- Peter's cleanup patch to introduce thread name macros
- Hanna's error path fix for vmstate subsection save()s
- Hyman's auto converge enhancement on background dirty sync
- Peter's additional tracepoints for save state entries
- Thomas's build fix for OpenBSD in dirtyrate.c
- Peter's deprecation of query-migrationthreads command
- Peter's cleanup/fixes from the "export misc.h" series
- Maciej's two small patches from multifd+vfio series

----------------------------------------------------------------

Hanna Czenczek (1):
  migration: Ensure vmstate_save() sets errp

Hyman Huang (6):
  accel/tcg/icount-common: Remove the reference to the unused header
    file
  migration: Stop CPU throttling conditionally
  migration: Move cpu-throttole.c from system to migration
  migration: Remove "rs" parameter in migration_bitmap_sync_precopy
  migration: Support periodic RAMBlock dirty bitmap sync
  tests/migration: Add case for periodic ramblock dirty sync

Maciej S. Szmigiero (2):
  migration/ram: Add load start trace event
  migration/multifd: Zero p->flags before starting filling a packet

Peter Xu (8):
  migration: Cleanup migrate_fd_cleanup() on accessing to_dst_file
  migration: Put thread names together with macros
  migration: Deprecate query-migrationthreads command
  migration: Take migration object refcount earlier for threads
  migration: Unexport dirty_bitmap_mig_init()
  migration: Unexport ram_mig_init()
  migration: Drop migration_is_setup_or_active()
  migration: Drop migration_is_idle()

Thomas Huth (1):
  migration/dirtyrate: Silence warning about strcpy() on OpenBSD

 docs/about/deprecated.rst                    |   8 ++
 qapi/migration.json                          |   7 +-
 include/migration/misc.h                     |   9 +-
 {include/sysemu => migration}/cpu-throttle.h |  14 ++
 migration/migration.h                        |  19 +++
 migration/ram.h                              |   1 +
 accel/tcg/icount-common.c                    |   1 -
 hw/vfio/common.c                             |   2 +-
 hw/virtio/virtio-mem.c                       |   2 +-
 migration/colo.c                             |   3 +-
 {system => migration}/cpu-throttle.c         |  72 +++++++++-
 migration/dirtyrate.c                        |  11 +-
 migration/migration.c                        | 130 ++++++++-----------
 migration/multifd.c                          |   8 +-
 migration/postcopy-ram.c                     |   6 +-
 migration/ram.c                              |  21 +--
 migration/savevm.c                           |   3 +-
 migration/vmstate.c                          |  13 +-
 net/vhost-vdpa.c                             |   3 +-
 system/cpu-timers.c                          |   3 -
 system/qdev-monitor.c                        |   4 +-
 tests/qtest/migration-test.c                 |  32 +++++
 migration/meson.build                        |   1 +
 migration/trace-events                       |   5 +
 system/meson.build                           |   1 -
 system/trace-events                          |   3 -
 26 files changed, 257 insertions(+), 125 deletions(-)
 rename {include/sysemu => migration}/cpu-throttle.h (87%)
 rename {system => migration}/cpu-throttle.c (64%)

-- 
2.45.0


