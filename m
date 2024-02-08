Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E651AC4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXujb-000617-Bi; Wed, 07 Feb 2024 22:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujO-0005xO-9V
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujL-0004IG-Li
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v/eMfJIioqa0tTdNDp2gc8xAH60cvubs+J5nlx1PTes=;
 b=DArZMtABKXToRHxP5HecmwIJFuoUx9atrzcdWVU2ESA4zmbFCkXU0LxWOAnVgEu6Gwb2pQ
 IklWTg3Uwrc7k1hfqBB8wfOZlE79KC88map7IVF6ZBLLtBVh4LJakr+jNFQkF9gx8d0gAa
 UV0FYbBTJRzhRwF8dh5aDLA7z/2N//A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-JOg9-jnYNbWFo0aE2_r2fA-1; Wed,
 07 Feb 2024 22:05:33 -0500
X-MC-Unique: JOg9-jnYNbWFo0aE2_r2fA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51CF13806710;
 Thu,  8 Feb 2024 03:05:33 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1BBA492BC7;
 Thu,  8 Feb 2024 03:05:30 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 00/34] Migration staging patches
Date: Thu,  8 Feb 2024 11:04:54 +0800
Message-ID: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:

  Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-staging-pull-request

for you to fetch changes up to 940bf8ff1ca82aa458c553d9aa9dd7671ed15a4d:

  ci: Update comment for migration-compat-aarch64 (2024-02-07 10:51:27 +0800)

----------------------------------------------------------------
Migration pull

- William's fix on hwpoison migration which used to crash QEMU
- Peter's multifd cleanup + bugfix + optimizations
- Avihai's fix on multifd crash over non-socket channels
- Fabiano's multifd thread-race fix
- Peter's CI fix series

----------------------------------------------------------------

Avihai Horon (1):
  migration: Fix logic of channels and transport compatibility check

Fabiano Rosas (6):
  migration/multifd: Join the TLS thread
  migration/multifd: Remove p->running
  migration/multifd: Move multifd_send_setup error handling in to the
    function
  migration/multifd: Move multifd_send_setup into migration thread
  migration/multifd: Unify multifd and TLS connection paths
  migration/multifd: Add a synchronization point for channel creation

Peter Xu (26):
  migration/multifd: Drop stale comment for multifd zero copy
  migration/multifd: multifd_send_kick_main()
  migration/multifd: Drop MultiFDSendParams.quit, cleanup error paths
  migration/multifd: Postpone reset of MultiFDPages_t
  migration/multifd: Drop MultiFDSendParams.normal[] array
  migration/multifd: Separate SYNC request with normal jobs
  migration/multifd: Simplify locking in sender thread
  migration/multifd: Drop pages->num check in sender thread
  migration/multifd: Rename p->num_packets and clean it up
  migration/multifd: Move total_normal_pages accounting
  migration/multifd: Move trace_multifd_send|recv()
  migration/multifd: multifd_send_prepare_header()
  migration/multifd: Move header prepare/fill into send_prepare()
  migration/multifd: Forbid spurious wakeups
  migration/multifd: Split multifd_send_terminate_threads()
  migration/multifd: Change retval of multifd_queue_page()
  migration/multifd: Change retval of multifd_send_pages()
  migration/multifd: Rewrite multifd_queue_page()
  migration/multifd: Cleanup multifd_save_cleanup()
  migration/multifd: Cleanup multifd_load_cleanup()
  migration/multifd: Stick with send/recv on function names
  migration/multifd: Fix MultiFDSendParams.packet_num race
  migration/multifd: Optimize sender side to be lockless
  tests/migration-test: Stick with gicv3 in aarch64 test
  ci: Remove tag dependency for build-previous-qemu
  ci: Update comment for migration-compat-aarch64

William Roche (1):
  migration: prevent migration when VM has poisoned memory

 include/sysemu/kvm.h         |   6 +
 migration/multifd.h          |  59 +--
 accel/kvm/kvm-all.c          |  10 +
 accel/stubs/kvm-stub.c       |   5 +
 migration/migration.c        |  48 ++-
 migration/multifd-zlib.c     |  11 +-
 migration/multifd-zstd.c     |  11 +-
 migration/multifd.c          | 778 ++++++++++++++++++++---------------
 migration/ram.c              |   2 +-
 tests/qtest/migration-test.c |   2 +-
 .gitlab-ci.d/buildtest.yml   |   9 +-
 migration/trace-events       |   2 +-
 12 files changed, 547 insertions(+), 396 deletions(-)

-- 
2.43.0


