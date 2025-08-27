Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C2FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNFw-0006pb-K8; Wed, 27 Aug 2025 17:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFd-0006it-Di
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFX-0006eu-7j
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YB2K/QGbBLwpy4qMrRI2pJP1Bv9nAGswn8diB9bg8SA=;
 b=QmPKS6FMoaCWkYpudd7mA1rUe7+Z9js5SioxEX+efSYc2n5BUthzrlLJ+PX85OpZT424fc
 qw84Y2IRR/ROV9HKTtqDC6YZnhwolY8y/wYSFFmWwtd4nS/bY07qBw5Lxn9yGHMO5S4E/y
 yqrf/gO/aBOnF8UJmm1S/r0mNY9jDI0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-NI54rty5O1iq6Ee1wP2TEA-1; Wed, 27 Aug 2025 16:59:53 -0400
X-MC-Unique: NI54rty5O1iq6Ee1wP2TEA-1
X-Mimecast-MFC-AGG-ID: NI54rty5O1iq6Ee1wP2TEA_1756328393
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e96e5521af4so199123276.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 13:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328392; x=1756933192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YB2K/QGbBLwpy4qMrRI2pJP1Bv9nAGswn8diB9bg8SA=;
 b=mGAepAtcw9abZ80kzyQFhThHwj+B0I6A4S6GtAk8PYTX172T8G69qLJ8vO9YI7CImu
 HpmIKGQWTMZOtWmld6ogkLLKfBdVqIfTkHL4TSLrs1Y+cothubucxoLDUO3osy3hNglF
 WmwnvY0kCvpbZbxTL8yB+ccfBhxYMTIGK/MzZdwoPMH5UJKmk0cPIQLWBSEaDNSEc5r5
 Pf7qpXg9cb3yIy83U7g+hL5G+RkC9I+rxdsMnDEpXZeOYwvNoL5xoAVMorWJCTtZ4yI3
 Xe278SBhdlxIh3MkBUuDHK/q+CXcdE+iByfe5cWOWAIK+5YxnplmzjmGNLgkNa/2ue3Q
 pu2w==
X-Gm-Message-State: AOJu0YwXRt7ltxjAp/BjKokknp7y4v38+XJxJg/l4lwriVY0jDcyRDq/
 yT8sgP04zsGX0xP85Vbr15GmJJb63Wl52sV+Fqw6OZ+fjLIaEFPnLr+848bYDmel+r1KJtSvVJx
 y8z6r2I0mtzy/1LGi61R4EyOW4Gb7jei+20xpORPKmLirjzvlcn0gPY+Ruo4I66CzZTqNXTecBp
 4X4Wyk9jamn6ygPxOhJylqKaK8areL4GGLdyNXag==
X-Gm-Gg: ASbGncvuQT405jGF3e+saVAtmX/pVsM9OVHpS6raZNBji4NEkPUVuH29LgJAaV55OYL
 k0w8Hk5qOzxDesL7iMLQF6X9qQWpm2oFH+O14GWa+7kh7Bojah99j9o4LmcwfEWzUr4MVrRV1jU
 ekeoXm4b43onCZ1DmzLg6ADUfz0sXO3RUSz05k6CfHxc2F/ZLgIxj1PykpMFAb6Vdv2M6iRUWEv
 FRbqirGQjeWbOXOM//Mp1cjQb15on4rVt1K5tAq+qIckosuWHF+GQZ0Bg+Ofm5Pqe2OJx26En7A
 06ZD3lWvBVT8zLLKN5PKQ3kXSTkov/gxPh5HpaENE3QDdtB3JsLEBB7DWPSuXpRO1zo2DU1Ajy4
 QH4dQ1bKvoedcJZbWfhQ=
X-Received: by 2002:a05:6902:4484:b0:e93:48ae:fdaa with SMTP id
 3f1490d57ef6-e951c3af2e0mr22321162276.28.1756328392510; 
 Wed, 27 Aug 2025 13:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlu0mzEgz/e/1WLH1tDnNiERiL1AIzQWkfF1xUcPWpzjH740xd9jk0lKOzjH8PkulrQrNP9g==
X-Received: by 2002:a05:6902:4484:b0:e93:48ae:fdaa with SMTP id
 3f1490d57ef6-e951c3af2e0mr22321109276.28.1756328391925; 
 Wed, 27 Aug 2025 13:59:51 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.13.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 13:59:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC 0/9] migration: Threadify loadvm process
Date: Wed, 27 Aug 2025 16:59:39 -0400
Message-ID: <20250827205949.364606-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[this is an early RFC, not for merge, but to collect initial feedbacks]

Background
==========

Nowadays, live migration heavily depends on threads. For example, most of
the major features that will be used nowadays in live migration (multifd,
postcopy, mapped-ram, vfio, etc.) all work with threads internally.

But still, from time to time, we'll see some coroutines floating around the
migration context.  The major one is precopy's loadvm, which is internally
a coroutine.  It is still a critical path that any live migration depends on.

A mixture of using both coroutines and threads is prone to issues.  Some
examples can refer to commit e65cec5e5d ("migration/ram: Yield periodically
to the main loop") or commit 7afbdada7e ("migration/postcopy: ensure
preempt channel is ready before loading states").

Overview
========

This series tries to move migration further into the thread-based model, by
allowing the loadvm process to happen in a thread rather than in the main
thread with a coroutine.

Luckily, since the qio channel code is always ready for both cases, IO
paths should all be fine.

Note that loadvm for postcopy already happens in a ram load thread which is
separate.  However, RAM is just the simple case here, even it has its own
challenges (on atomically update of the pgtables), its complexity lies in
the kernel.

For precopy, loadvm has quite a few operations that will need BQL.  The
question is we can't take BQL for the whole process of loadvm, because
that'll block the main thread from executions (e.g. QMP hangs).  Here, the
finer granule we can push BQL the better.  This series so far chose
somewhere in the middle, by taking BQL on majorly these two places:

  - CPU synchronizations
  - Device START/FULL sections

After this series applied, most of the rest loadvm path will run without
BQL anymore.  There is a more detailed discussion / todo in the commit
message of patch "migration: Thread-ify precopy vmstate load process"
explaning how to further split the BQL critical sections.

I was trying to split the patches into smaller ones if possible, but it's
still quite challenging so there's one major patch that does the work.

After the series applied, the only leftover pieces in migration/ that would
use a coroutine is snapshot save/load/delete jobs.

Tests
=====

Default CI passes.

RDMA unit tests pass as usual. I also tried out cancellation / failure
tests over RDMA channels, making sure nothing is stuck.

I also roughly measured how long it takes to run the whole 80+ migration
qtest suite, and see no measurable difference before / after this series.

Risks
=====

This series has the risk of breaking things.  I would be surprised if it
didn't..

I confess I didn't test anything on COLO but only from code observations
and analysis.  COLO maintainers: could you add some unit tests to QEMU's
qtests?

The current way of taking BQL during FULL section load may cause issues, it
means when the IOs are unstable we could be waiting for IO (in the new
migration incoming thread) with BQL held.  This is low possibility, though,
only happens when the network halts during flushing the device states.
However still possible.  One solution is to further breakdown the BQL
critical sections to smaller sections, as mentioned in TODO.

Anything more than welcomed: suggestions, questions, objections, tests..

Todo
====

- Test COLO?
- Finer grained BQL breakdown
- More..

Thanks,

Peter Xu (9):
  migration/vfio: Remove BQL implication in
    vfio_multifd_switchover_start()
  migration/rdma: Fix wrong context in qio_channel_rdma_shutdown()
  migration/rdma: Allow qemu_rdma_wait_comp_channel work with thread
  migration/rdma: Change io_create_watch() to return immediately
  migration: Thread-ify precopy vmstate load process
  migration/rdma: Remove coroutine path in qemu_rdma_wait_comp_channel
  migration/postcopy: Remove workaround on wait preempt channel
  migration/ram: Remove workaround on ram yield during load
  migration/rdma: Remove rdma_cm_poll_handler

 include/migration/colo.h    |   6 +-
 migration/migration.h       |  52 +++++++--
 migration/savevm.h          |   5 +-
 hw/vfio/migration-multifd.c |   9 +-
 migration/channel.c         |   7 +-
 migration/colo-stubs.c      |   2 +-
 migration/colo.c            |  23 +---
 migration/migration.c       |  62 ++++++++---
 migration/ram.c             |  13 +--
 migration/rdma.c            | 206 ++++++++----------------------------
 migration/savevm.c          |  85 +++++++--------
 migration/trace-events      |   4 +-
 12 files changed, 196 insertions(+), 278 deletions(-)

-- 
2.50.1


