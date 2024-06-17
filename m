Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F2EC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGtg-0000Gl-1z; Mon, 17 Jun 2024 14:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtV-0000CZ-Nx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtN-0006Hx-In
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OZx3RDBPKVVhAKOuoTfczOFnKvOvgl7AGFwqYvU/uPI=;
 b=PYLl2dJLchzkyiAYTb5tsqUvx3aqdocWL49BLJKGA5ELTf+K6vAYqI024M5FpiLl/iTvXq
 t2MrXOaxClaFeYgPRNBF+wHdZx2+sWrdqUqZ0yMvzkBCsc1fAd1bmmDhDW9+Qb7clnM3ir
 M8qrwdHdjaWe0mp/JxGQd2/o71YvhV0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-kpMjgFhhOsy9ctdDWnGmuQ-1; Mon, 17 Jun 2024 14:15:38 -0400
X-MC-Unique: kpMjgFhhOsy9ctdDWnGmuQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-797cde3c2f8so87855485a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648138; x=1719252938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OZx3RDBPKVVhAKOuoTfczOFnKvOvgl7AGFwqYvU/uPI=;
 b=hFhPm3AL5QKWQdcZDT3F4prpqx1scEnQzg8VRr5FNGiEx8d1dUsHf1XOKkMOsPCTXj
 KQr+O5k3GlVScoyA8iSdrK7sTDvpr/jGezVRnnyUXVV+Ll+yCtqJuMMBfOFpZzf+k33B
 g2k3Jk0P4HCMZJHeqCojjP6DnxzHLuSHdYxVrfpcHqgEYymh0nBv4m7Wm5bae1aaNyvl
 YPa4g4zUDg3zpnKnbNcxCnI50WFnexPuS1CxXBTojTjkvbtnILhcqOI/ttEFPvHcm72/
 8rQOpY9lkdF/vY6KO7lXaEoH6h1RreN+fEhH9KmNW1BSRp4hfoqddGQIG5gWseNw1yTC
 wLAQ==
X-Gm-Message-State: AOJu0YwIi1ZqzUtuJqM13n/pt2SVReq6YKLtVm5uhWWEqKfaWxMjxN+g
 3vyZpnB4uSgjRth6XWdB+M7q+8nYzT2vhP5XtmJsl1hfgOvUF4h5IZpZtxzFuwyq+jWYMqJ5kay
 boRkIS8tXjiEpPbdWRAdrH0Kq9yNyUfE8x3p/RbD8HgiNT6jewaIh8zmx7I/WhClAhzQp5djFM1
 z9rsrFK/9utw11OrPeugbMJWt2+phESx5cqQ==
X-Received: by 2002:a05:620a:260e:b0:795:c5a1:cbac with SMTP id
 af79cd13be357-798d26fa8bamr1154421085a.5.1718648137721; 
 Mon, 17 Jun 2024 11:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiJGbkS7EMWtE/1VFl+mK8g7XYo0w2+Fu3slplT/XXUDraXSrF0KkRZ8OuDBry/5GShpGA1Q==
X-Received: by 2002:a05:620a:260e:b0:795:c5a1:cbac with SMTP id
 af79cd13be357-798d26fa8bamr1154416485a.5.1718648136998; 
 Mon, 17 Jun 2024 11:15:36 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 00/10] migration: New postcopy state, and some cleanups
Date: Mon, 17 Jun 2024 14:15:24 -0400
Message-ID: <20240617181534.1425179-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

v2:
- Collect tags
- Patch 3
  - cover all states in migration_postcopy_is_alive()
- Patch 4 (old)
  - English changes [Fabiano]
  - Split the migration_incoming_state_setup() cleanup into a new patch
    [Fabiano]
  - Drop RECOVER_SETUP in fill_destination_migration_info() [Fabiano]
  - Keep using explicit state check in migrate_fd_connect() for resume
    [Fabiano]
- New patches
  - New doc update: "migration/docs: Update postcopy recover session for
    SETUP phase"
  - New test case: last four patches

v1: https://lore.kernel.org/r/20240612144228.1179240-1-peterx@redhat.com

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

Patch 7-10 adds a new test for the new state.

Comments welcomed, thanks.

CI: https://gitlab.com/peterx/qemu/-/pipelines/1335604588
    (check-dco & check-patch fail to git-fetch, but doesn't look relevant)

Peter Xu (10):
  migration/multifd: Avoid the final FLUSH in complete()
  migration: Rename thread debug names
  migration: Use MigrationStatus instead of int
  migration: Cleanup incoming migration setup state change
  migration/postcopy: Add postcopy-recover-setup phase
  migration/docs: Update postcopy recover session for SETUP phase
  tests/migration-tests: Drop most WIN32 ifdefs for postcopy failure
    tests
  tests/migration-tests: Always enable migration events
  tests/migration-tests: Verify postcopy-recover-setup status
  tests/migration-tests: Cover postcopy failure on reconnect

 docs/devel/migration/postcopy.rst |  31 +++++----
 qapi/migration.json               |   4 ++
 migration/migration.h             |   9 +--
 migration/postcopy-ram.h          |   3 +
 tests/qtest/migration-helpers.h   |   2 +
 migration/colo.c                  |   2 +-
 migration/migration.c             |  98 ++++++++++++++++++--------
 migration/multifd.c               |   6 +-
 migration/postcopy-ram.c          |  10 ++-
 migration/ram.c                   |   4 --
 migration/savevm.c                |   6 +-
 tests/qtest/migration-helpers.c   |  20 ++++++
 tests/qtest/migration-test.c      | 110 ++++++++++++++++++++++++------
 13 files changed, 223 insertions(+), 82 deletions(-)

-- 
2.45.0


