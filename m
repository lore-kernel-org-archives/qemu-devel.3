Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E15C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pS-0001of-IN; Wed, 19 Jun 2024 18:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pR-0001oI-7r
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pP-0008Os-Ef
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tUXepmqjv4T+w5M3EORwUdyerwo6fhzNAvCWsOnkK2M=;
 b=SoM/VInsW93SJYc6WqPrS5tv8yeH69i/vR1ZGP7NfY3hdzw3ca/6zemIUDuk2IN11C3xoJ
 /aHv5g0GQR/x4noy7XkMrgu0NoSQATjdpIYVrQz7doVtnlzdajwzUr5F3OGHye8xox0hAb
 5Vpwxir/1FqZMxu1dppYRBPow3BKR2g=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-20Bx2ncZMLWj-ztrVB53rg-1; Wed, 19 Jun 2024 18:30:51 -0400
X-MC-Unique: 20Bx2ncZMLWj-ztrVB53rg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dff2e22678dso51450276.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836249; x=1719441049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tUXepmqjv4T+w5M3EORwUdyerwo6fhzNAvCWsOnkK2M=;
 b=KIim4k0bjIvYM7gWPFTnn7pmrK6jaUBAsJ2fDLmyYaxjVZ7gk9N+dVRnFZIEvj5a0n
 RidJYXuPkIsKiUnNB2W0Ch8Mz/7/vxmzdRIQy9ISUVPcLsfQDOUsBzEq2H/LDNoZiIfV
 CD0DDy1TEywJsqAAvDGUiF+uLB770zNUR6DpITCEUDSUwoVPtqVZK2JCmvwaDS9ZYLO1
 tA6sC5l6E1F0iKvr3WjorXNzWH/j8sbbfsW4RwIMjuLHPEGnVzbWROtziv0G8nR20Tp2
 y2z1+2hC4swoiw/X/1lEf7HHAxqmPrN3LT4n2bHuyexIXoLa9a8a5PE/LSTuFyd1t2Uj
 uTcQ==
X-Gm-Message-State: AOJu0YwT1uk5ldRZLQNWOmL6TkXKz/4W584LxLP4AcBLmH5W4wsk/qQ1
 volDOlk8ZF+jPdjJ+MtQyXP915dKHzfARXUJxyGmSF2Tpe2276BKGrSsBuDjoB4pFU7Ha/PDB0o
 Bgp1mAOhaZ8BrHY+S0z+wFa7pJOHgo6/uqk7tfnPNKnZi5zaKNblfLI0KEkph0lVdy4ephoIiiT
 hITt/OMsgOvfrquy0U5tiPmiN3vGfoIpVy6Q==
X-Received: by 2002:a25:d882:0:b0:e02:575b:4883 with SMTP id
 3f1490d57ef6-e02be25d91cmr3540650276.5.1718836249203; 
 Wed, 19 Jun 2024 15:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDHnGByRzm4FjtqcxqcaZnycbFh5WaiS+uQ3fkqK73T9ESU8+/++KynFUqlY5iC4bWYSWRLA==
X-Received: by 2002:a25:d882:0:b0:e02:575b:4883 with SMTP id
 3f1490d57ef6-e02be25d91cmr3540621276.5.1718836248454; 
 Wed, 19 Jun 2024 15:30:48 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:30:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 00/11] migration: New postcopy state, and some cleanups
Date: Wed, 19 Jun 2024 18:30:35 -0400
Message-ID: <20240619223046.1798968-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Based-on: <20240617185731.9725-1-farosas@suse.de>

v3:
- Added one comment in patch 8 explaining why migrate_incoming_qmp() needs
  to keep enabling "events" capability.
- Split patch 9 into two patches, which makes migration_event_wait() to be
  used also in migrate_incoming_qmp()
- Rename the tests in last patch, and a spell fix
- Rebased to "[PATCH v3 00/16] migration/mapped-ram: Add direct-io support"

v1: https://lore.kernel.org/r/20240612144228.1179240-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20240617181534.1425179-1-peterx@redhat.com

The major goal of this patchset is patch 5, which introduced a new postcopy
state so that we will send an event in postcopy reconnect failures that
Libvirt would prefer to have.  There's more information for that issue in
the commit message alone.

Patch 1-2 are cleanups that are not directly relevant but I found/stored
that could be good to have.  I made it simple by putting them together in
one thread to make patch management easier, but I can send them separately
when necessary.

Patch 3 is also a cleanup, but will be needed for patch 4 as dependency.

Patch 4-5 is the core patches.

Patch 6 updates doc for the new state.

Patch 7-11 adds a new test for the new state.

CI: https://gitlab.com/peterx/qemu/-/pipelines/1339544694

Comments welcomed, thanks.

Peter Xu (11):
  migration/multifd: Avoid the final FLUSH in complete()
  migration: Rename thread debug names
  migration: Use MigrationStatus instead of int
  migration: Cleanup incoming migration setup state change
  migration/postcopy: Add postcopy-recover-setup phase
  migration/docs: Update postcopy recover session for SETUP phase
  tests/migration-tests: Drop most WIN32 ifdefs for postcopy failure
    tests
  tests/migration-tests: Always enable migration events
  tests/migration-tests: migration_event_wait()
  tests/migration-tests: Verify postcopy-recover-setup status
  tests/migration-tests: Cover postcopy failure on reconnect

 docs/devel/migration/postcopy.rst |  31 ++++----
 qapi/migration.json               |   4 ++
 migration/migration.h             |   9 +--
 migration/postcopy-ram.h          |   3 +
 tests/qtest/migration-helpers.h   |   2 +
 migration/colo.c                  |   2 +-
 migration/migration.c             |  98 +++++++++++++++++--------
 migration/multifd.c               |   6 +-
 migration/postcopy-ram.c          |  10 ++-
 migration/ram.c                   |   4 --
 migration/savevm.c                |   6 +-
 tests/qtest/migration-helpers.c   |  32 ++++++---
 tests/qtest/migration-test.c      | 116 +++++++++++++++++++++++-------
 13 files changed, 229 insertions(+), 94 deletions(-)

-- 
2.45.0


