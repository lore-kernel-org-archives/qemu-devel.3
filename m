Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE01C47258
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 03:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHwZ-0003bL-6w; Sun, 28 Jan 2024 22:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwY-0003bC-0T
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwV-0002Zg-Eq
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sEHT8p/ugD2PhygK1Zn4V4empTsUuTqCfMEAWIDEu7c=;
 b=Zwd5Oqzp5LTy3g2Abuu5w9i5I0l9p0gz0sIPZly//4C4D1JQldfe6SySBwUEt994RReVTl
 x0RqEMpcCtlI2ekqD1mWW8V4/RBJQ2Sxt7TvrU18RJ/ZWrCNkWDpzl6tfXbI2K4uSSK2nZ
 WjghD+XeUWesBXZYeA6vnb9lsMoaVB4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-RgyTg1L0M1m6H9zpAtERAQ-1; Sun, 28 Jan 2024 22:04:10 -0500
X-MC-Unique: RgyTg1L0M1m6H9zpAtERAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8305383BA87;
 Mon, 29 Jan 2024 03:04:10 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 111071121306;
 Mon, 29 Jan 2024 03:04:07 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 00/14] Migration 20240126 patches
Date: Mon, 29 Jan 2024 11:03:51 +0800
Message-ID: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Peter Xu <peterx@redhat.com>

The following changes since commit 7a1dc45af581d2b643cdbf33c01fd96271616fbd:

  Merge tag 'pull-target-arm-20240126' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-01-26 18:16:35 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240126-pull-request

for you to fetch changes up to 57fd4b4e10756448acd6c90ce041ba8dc9313efc:

  Make 'uri' optional for migrate QAPI (2024-01-29 11:02:12 +0800)

----------------------------------------------------------------
Migration Pull

[dropped fabiano's patch on modifying cpu model for arm migration tests for
 now]

- Fabiano's patchset to fix migration state references in BHs
- Fabiano's new 'n-1' migration test for CI
- Het's fix on making "uri" optional in QMP migrate cmd
- Markus's HMP leak fix reported by Coverity
- Paolo's cleanup on uffd to replace u64 usage
- Peter's small migration cleanup series all over the places

----------------------------------------------------------------

Fabiano Rosas (8):
  ci: Add a migration compatibility test job
  ci: Disable migration compatibility tests for aarch64
  migration/yank: Use channel features
  migration: Fix use-after-free of migration state object
  migration: Take reference to migration state around
    bg_migration_vm_start_bh
  migration: Reference migration state around
    loadvm_postcopy_handle_run_bh
  migration: Add a wrapper to qemu_bh_schedule
  migration: Centralize BH creation and dispatch

Het Gala (1):
  Make 'uri' optional for migrate QAPI

Markus Armbruster (1):
  migration: Plug memory leak on HMP migrate error path

Paolo Bonzini (1):
  userfaultfd: use 1ULL to build ioctl masks

Peter Xu (3):
  migration: Make threshold_size an uint64_t
  migration: Drop unnecessary check in ram's pending_exact()
  analyze-migration.py: Remove trick on parsing ramblocks

 qapi/migration.json                       |  2 +-
 migration/migration.h                     |  7 +-
 migration/migration-hmp-cmds.c            |  4 +-
 migration/migration.c                     | 82 +++++++++++++----------
 migration/postcopy-ram.c                  | 16 ++---
 migration/ram.c                           |  9 ++-
 migration/savevm.c                        |  5 +-
 migration/yank_functions.c                |  6 +-
 subprojects/libvhost-user/libvhost-user.c |  2 +-
 tests/qtest/migration-test.c              |  4 +-
 .gitlab-ci.d/buildtest.yml                | 64 ++++++++++++++++++
 scripts/analyze-migration.py              | 11 +--
 12 files changed, 134 insertions(+), 78 deletions(-)

-- 
2.43.0


