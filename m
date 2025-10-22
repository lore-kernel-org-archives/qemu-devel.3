Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F383CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTs-0002u6-Qf; Wed, 22 Oct 2025 15:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTf-0002st-RJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTX-0001QS-KO
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GfplFGCpA2V4xkGhpWVLNLKk0Wdb6bYJg/QW2c6gRa4=;
 b=AzUP67Fr14LexYr41carccvuEMgFQh0drb9DQkqUMaLT/Fp5z0IdjYEFVZ8xl9+0vYkJkk
 5dK9HZSBprX/yf+Nc9zX7xkNIn18gTAhlLF4FS5lkjAWoe7683QypNbK2WOoBJlTBB2yvJ
 WKnFRkUqgUrT31FkFISuvIwltuMvHIM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-9kR7z4CsP1aVIT8lHPfrzQ-1; Wed, 22 Oct 2025 15:26:16 -0400
X-MC-Unique: 9kR7z4CsP1aVIT8lHPfrzQ-1
X-Mimecast-MFC-AGG-ID: 9kR7z4CsP1aVIT8lHPfrzQ_1761161176
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e8bb76ee59so41824231cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161176; x=1761765976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfplFGCpA2V4xkGhpWVLNLKk0Wdb6bYJg/QW2c6gRa4=;
 b=aQIZbk/E1DszpxI2zCWDneqRXARQOLmpq67uv4D8PLwXoDFB3Bn94KPnu/q9FUWGe1
 CPRMaUIkADMSj0j5dZh8xT2rhGfcRB/F/gjrDUvWyCR1U19fDWFHORW8uvX5ggGHNp1z
 wCwGGleWUN0wLU2b9WGqDHu8f4zJocb08qY0ayc0HrRimnBr2YOuM9ORFl6vPjvVg2dl
 fui6OMu598rw5h1l0Ob03JB/AGjY/7mVmoU2k+ACgQmSYQSe0l6RJROBDkku1jCeo2WK
 5cVQ3bmrfuyLMf5kVxGnjfaogOMs2w0cwOE0jMjJUFXxd4+0RCxHehbUoXDXmiI2pNeP
 ldRw==
X-Gm-Message-State: AOJu0YyZC6Z1Ar/vTM4bvonHPgqx6lKjHDtZAtzRejph/9gLzsv5JwwP
 aHwDQ+IMTgWfs75fGOdxwmi8uqt38PLaV8O4BQRwd0tj2Z+ztGXDjqCCsPKJjdi9u7oPV+4ywSB
 05rfFbdekPlRkCRpU2TfeG1PcIb0BbrhXNdULtPSBp/bUW/4pCh/wXSPZKS9/89Wk8v1JpaxEaO
 dT2qgF46MRrZ8gSkLvjK5I9hnhDvoKJh/U+IWTuQ==
X-Gm-Gg: ASbGncu5AZUdsVUxDxNIA7WjCS4+xsX9YSlNKulleOuGMF7vk2+iuqCJ++QVDUxlji6
 feVtMGxquQyNiMKf1TJ0XirDNkwuBXgUpAfVO4wQivXI7yXa/0TYZh9RAknH/TnQokTID4DOfNU
 9lQNqIWNRX6Mf6hiw39JoAajmGKomEbEgI0u00tPT88iZWO6yhKXr+QgMFQAlLBjuga8r+xOuyS
 Gjhgn+oQKb3SxgmoVyXReQ3xyvKb0s4+jL4qk7Zlch8Zx4gl2F2GBPyIGOFVWdn4azRIWyRtJ0s
 DOhM6zGJcnE7PxHMVmSFd/wcVQDXfFQEHa5Nu87Kz+kZqK6pKEWSLW5O4n+SuMEI
X-Received: by 2002:a05:622a:1a0b:b0:4b9:6bbf:7073 with SMTP id
 d75a77b69052e-4e89d35ad07mr279079531cf.53.1761161175687; 
 Wed, 22 Oct 2025 12:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0rInUYI8Kj1Nj3EtNYdpLpumRRK/PtuiLNehcemjRLQXwb6jfdbJaQrsYIuVfL6BmMovHRg==
X-Received: by 2002:a05:622a:1a0b:b0:4b9:6bbf:7073 with SMTP id
 d75a77b69052e-4e89d35ad07mr279079031cf.53.1761161175123; 
 Wed, 22 Oct 2025 12:26:15 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 00/13] migration: Threadify loadvm process
Date: Wed, 22 Oct 2025 15:25:59 -0400
Message-ID: <20251022192612.2737648-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is v1, however not 10.2 material.  The earliest I see fit would still
be 11.0+ even if everything goes extremely smooth.

Removal of RFC is only about that I'm more confident this should be able to
land without breaking something too easily, as I smoked it slightly more
cross-archs this time.  AFAIU the best (and possibly only..) way to prove
it solid is to merge it.. likely in the early phase of a dev cycle.

The plan is we'll try to get to more device setups too soon, before it
could land.

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

It was a coroutine since this work (thanks to Fabiano, the archeologist,
digging the link):

  https://lists.gnu.org/archive/html/qemu-devel/2012-08/msg01136.html

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

After the series applied, the only leftover pieces in migration/ that would
use a coroutine is snapshot save/load/delete jobs.

Tests
=====

Default CI passes.

RDMA unit tests pass as usual. I also tried out cancellation / failure
tests over RDMA channels, making sure nothing is stuck.

I also roughly measured how long it takes to run the whole 80+ migration
qtest suite, and see no measurable difference before / after this series.

I didn't test COLO, I wanted to but the doc example didn't work.

Risks
=====

This series has the risk of breaking things.  I would be surprised if it
didn't..

The current way of taking BQL during FULL section load may cause issues, it
means when the IOs are unstable we could be waiting for IO (in the new
migration incoming thread) with BQL held.  This is low possibility, though,
only happens when the network halts during flushing the device states.
However still possible.  One solution is to further breakdown the BQL
critical sections to smaller sections, as mentioned in TODO.

Anything more than welcomed: suggestions, questions, objections, tests..

TODO
====

- Finer grained BQL breakdown

Peter Xu (13):
  io: Add qio_channel_wait_cond() helper
  migration: Properly wait on G_IO_IN when peeking messages
  migration/rdma: Fix wrong context in qio_channel_rdma_shutdown()
  migration/rdma: Allow qemu_rdma_wait_comp_channel work with thread
  migration/rdma: Change io_create_watch() to return immediately
  migration: Introduce WITH_BQL_HELD() / WITH_BQL_RELEASED()
  migration: Pass in bql_held information from qemu_loadvm_state()
  migration: Thread-ify precopy vmstate load process
  migration/rdma: Remove coroutine path in qemu_rdma_wait_comp_channel
  migration/postcopy: Remove workaround on wait preempt channel
  migration/ram: Remove workaround on ram yield during load
  migration: Allow blocking mode for incoming live migration
  migration/vfio: Drop BQL dependency for loadvm SWITCHOVER_START

 include/io/channel.h        |  15 +++
 include/migration/colo.h    |   6 +-
 migration/migration.h       | 109 +++++++++++++++++--
 migration/savevm.h          |   4 +-
 hw/vfio/migration-multifd.c |   3 -
 io/channel.c                |  21 ++--
 migration/channel.c         |   7 +-
 migration/colo-stubs.c      |   2 +-
 migration/colo.c            |  26 ++---
 migration/migration.c       |  81 ++++++++------
 migration/qemu-file.c       |   6 +-
 migration/ram.c             |  13 +--
 migration/rdma.c            | 204 ++++++++----------------------------
 migration/savevm.c          |  98 +++++++++--------
 migration/trace-events      |   4 +-
 15 files changed, 291 insertions(+), 308 deletions(-)

-- 
2.50.1


