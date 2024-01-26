Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D3BC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 04:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTDet-0001hk-Ev; Thu, 25 Jan 2024 23:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTDes-0001fk-1F
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 23:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTDep-0004n2-8X
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 23:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706242653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jMxyAGI3qYVs5QH6kzyj5YicRDJmhNpflR+yarg5k9k=;
 b=T2hQR29Wk5kwkl4o9pPvfh/w0RHMEk42GgMO8/ZMNwWPUvIlltvZvSWImE7fOMXVBuMlAg
 tSm09yfz1P3Sk3yztWYhzYzogonC/6EDa3lLG4bCI7JvfFuiLpKokKPd/NSwGIzv1T0czz
 hg898G8BbI91LnE2Jh8ShICgpnTOXlA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Z56msUsuOPSY-r67TdFsgQ-1; Thu, 25 Jan 2024 23:17:30 -0500
X-MC-Unique: Z56msUsuOPSY-r67TdFsgQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FD65101A526;
 Fri, 26 Jan 2024 04:17:30 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38D7E492BC6;
 Fri, 26 Jan 2024 04:17:27 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 00/15] Migration 20240126 patches
Date: Fri, 26 Jan 2024 12:17:10 +0800
Message-ID: <20240126041725.124562-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:

  Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240126-pull-request

for you to fetch changes up to 24b0c2ec956ca225282f81470f7c26f5bb844885:

  Make 'uri' optional for migrate QAPI (2024-01-26 11:06:13 +0800)

----------------------------------------------------------------
Migration pull for 9.0

- Fabiano's patchset to fix migration state references in BHs
- Fabiano's new 'n-1' migration test for CI
- Het's fix on making "uri" optional in QMP migrate cmd
- Markus's HMP leak fix reported by Coverity
- Paolo's cleanup on uffd to replace u64 usage
- Peter's small migration cleanup series all over the places

----------------------------------------------------------------

Fabiano Rosas (9):
  tests/qtest/migration: Don't use -cpu max for aarch64
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
 tests/qtest/migration-test.c              |  6 +-
 .gitlab-ci.d/buildtest.yml                | 64 ++++++++++++++++++
 scripts/analyze-migration.py              | 11 +--
 12 files changed, 135 insertions(+), 79 deletions(-)

-- 
2.43.0


