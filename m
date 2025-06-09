Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80501C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhvk-0006LP-Tf; Mon, 09 Jun 2025 15:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvh-0006Kg-06
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhve-0000ob-RQ
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U8CTxz+21qcNLENbNka1N6PoXA41RrpTkAYYixXhEq4=;
 b=MP3XuzjMlJeQHhP+5GQL3ttBmo155AShUo36lR/0oIkvMXtts8AQMTnaDJjFil+3A6go7T
 ZHVNpZO43oojJU9hi4rWHxwoOAv7eShLqWnbqzq4bsEVXHWU11nItYzQZ9FNgiogFlIEtD
 PJSVkxeUJHlM97SaKVddlBB94XnsRHM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-DJK1UVaROgqq2UYIVaBcFA-1; Mon, 09 Jun 2025 15:13:04 -0400
X-MC-Unique: DJK1UVaROgqq2UYIVaBcFA-1
X-Mimecast-MFC-AGG-ID: DJK1UVaROgqq2UYIVaBcFA_1749496384
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fad5f1e70fso88543456d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496383; x=1750101183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U8CTxz+21qcNLENbNka1N6PoXA41RrpTkAYYixXhEq4=;
 b=FU8ZDNThHp7XPtmSb97XFuEpRLsXxthvkE1avdusKWeQh9nVn9+lFHpsGpToV1PxbA
 Y+fIbBAZ6ppRDyqYdBulzwEFFv1XNk9JnUuCqiXvodkHGOQR43KoVXzYCwLN2ONA3Htp
 Z/lVOm1dKsKzCkmC9utSmrF0Tym47F4+lghOX4X6sGZ96tfVA/FtXtv0cwX1nVVsoHnQ
 iCMymvuVxzQizVsDyKjO/FrsH6eorqh1/AqmxCbfZqpgWreGwoXxEODkp6eJDKa7CgZ4
 QKdahDJg6zocc11fdworeqxuZ5Er4Vo1CVOrIyPOc2Y6tLjOn6cZrhj7LV4uqleQYukD
 btKw==
X-Gm-Message-State: AOJu0YyWQM5S3Er1+Jy5DRP+ZuQGkle6gXWEMCyw5RWuxxSgoloYHTAl
 5SBazJ1tt0DfdkvnWHqg8jhDfUB3QTrc3IlPqiV3nAF8W28sEYVh+IlFNFsusX5IPBQJMAr0Ezk
 hew3JGlcaiBWe3ziYfQnSVD/3P8cooj6/r1ne431KS5k23BZUmS0/UGDfdeLjQS2l8AVP88Uv1v
 gxv1RTRTyuk9EM3iWO1I9cQMaoWorAcU91yEbLZw==
X-Gm-Gg: ASbGnctpdqpcF9yrcJAk5NZLyPM8//VhIUqO9Zal1VTdd7nt1LsHjnxuM2Jtqq3MZ7J
 mUTXM3/Rrf6eLEvpo3itw2DJNDQwnZdpMg0L3Tj8nNoBtWte77RRJ4Dj1vSUj0IEEeV0NPAgQTL
 0NfzB6BwitESh4BfVDUgDI4g7DUu+898mP6kDJ0IdRm900lOuqCq2kdcm5YTCQLc3xDADmRAuXz
 jV9k44EhJFB4ZxzhHW1xgWhVvB7FH4RwQCXxPfCmCZ7iCbnX6ImfLe0CfvpQSwXu2hHJJxNkVxi
 XDCBKSdGgshxyA==
X-Received: by 2002:ad4:5f4a:0:b0:6f8:997d:fc82 with SMTP id
 6a1803df08f44-6fb08f69daamr220189886d6.3.1749496383246; 
 Mon, 09 Jun 2025 12:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+6jULIkQNGrusXm1u9+YBVB83drIGj+Plmf5lDwbZ+148bw1S4Lkjw2uTWWT7qSWz/Hl62A==
X-Received: by 2002:ad4:5f4a:0:b0:6f8:997d:fc82 with SMTP id
 6a1803df08f44-6fb08f69daamr220189316d6.3.1749496382717; 
 Mon, 09 Jun 2025 12:13:02 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 00/13] migration/postcopy: Blocktime tracking overhaul
Date: Mon,  9 Jun 2025 15:12:46 -0400
Message-ID: <20250609191259.9053-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series is based on the other series I posted here:

Based-on: <20250609161855.6603-1-peterx@redhat.com>
https://lore.kernel.org/r/20250609161855.6603-1-peterx@redhat.com

v2:
- Collect tags
- Use two spaces always in qapi/ documentations for patch 8/13 [Markus]
- English error fix (s/system-wise/system-wide/) [Fabiano]

Overview
========

This series almost rewrites the blocktime feature.  It is a postcopy
feature which can track how long a vCPU got blocked, and how long the whole
system got blocked.  I'm wildly guessing most people are not aware of it,
or tried to use it.

Recently, when I was doing some postcopy tests using my normal scripts for
traps, I remembered once again that we have the blocktime feature.  I
decided to bite the bullet this time to make this feature more useful.

The feature in general isn't extremely helpful before.  One major reason
might be the existance of KVM async page fault (which is also on by default
in many environments).  KVM async page fault allows guest OSes to schedule
some guest threads out when they're accessing a missing page.  It means the
vCPUs will _not_ be blocked even if they're accessing a missing page.
However blocktime reporting all close to zeros may not really mean the
guest is not affected: the workload is definitely impacted.  That's also
why I normally measure page fault latencies instead for most postcopy
tests, because they're more critical to me.

Said that, the blocktime layer is actually close to what we want to do
here, on trapping fault latencies too.  So I added it in this series.  Also
I added non-vCPU threads tracking too, so that at least the latency results
are valid even if KVM async PF is ON.

When at it, I found so many things missing in this feature.  I tackled
every single one of them with separate patches.  One can have a quick look
at what has changed in the follow up section.

Major Changes
=============

- Locking refactor: remove atomic ops, rely on page request mutex instead

  It used to rely on atomic ops but probably not correct either..  I have a
  paragraph in patch "migration/postcopy: Optimize blocktime fault tracking
  with hashtable" explaining why it is buggy.

- Extend all blocktime records internally from 32 bits to 64 bits

  Do this almost to support microsecond trackings (which used to be in
  milliseconds).  Note this does not change existing results reported in
  QMP in the past because it is ABI, however we'll use microseconds for any
  new results to be reported later.

- Added support to report fault average latencies (globally, per-vCPU,
  non-vCPU), results are in microseconds.

- Initialize blocktime reliably only when POSTCOPY_LISTEN

  Rather than hack-init it when creating any userfaultfd..

- Provide tid->vcpu cache

  Add a quick cache for tid->vcpu hash mapping.  It used to be a for loop
  looking for the CPU index, which is unwanted.

- Replace fault record arrays with a hashtable

  This is an optimization for fast inject/lookup of fault records.

  Again, it used to be yet another array keeping all vCPU data.  It's not
  only less performant when vCPUs can be a lot (especially on the lookups,
  which is another for loop..), but also buggy.  It's because in reality
  each vCPU can receive more than one fault sometimes.

  Please see the patch "migration/postcopy: Optimize blocktime fault
  tracking with hashtable" for more information.

- Added support for non-vCPU fault trackings

  This will be extremely useful when e.g. KVM async page fault is enabled,
  because vCPUs almost never block.

Test Results
============

I did quite some tests with the feature after the rewrote.  It looks pretty
well so far and I plan to throw my scripts away until proven more useful.

I was testing on a 80 vCPUs VM with 16GB memory, best I can find at hand.
The page latencies overhead is almost negligible:

  Disabled:
  Average: 236.00 (+-4.66%)

  Enabled:
  Average: 232.67 (+-2.01%)

It was average results out of three runs for each.  Enabling the feature
even makes the latency to be smaller?  Well that's probably noise..

Surprisingly, I did also try the old code, the overhead is also almost not
mesurable comparing to the faults.  I guess it's because a few "for loop"s
over some arrays of 80 elements isn't much of a hurdle when the round trip
is still ~200us.  But still, it's not only about perf, but other things
too, on such rewrites.  For example, arrays won't be able to trap non-vCPU
faults.  The hash is still pretty much needed, one way or another.

I think it means we should be able to enable this feature altogether with
postcopy-ram if we want, and unless the VM is extremely huge we shouldn't
expect much overhead.  Actually I'd bet it should work all fine even with
hundreds of vCPUs especially after this rewrite.  If add preempt mode into
picture, I think one should enable all three features for postcopy by
default at some point.

TODO: we may also add buckets to provide better statistics for the latency
report, e.g. how many faults were resolved in (2^N, 2^(N+1)) us window, etc.

Comments welcomed, thanks.

Peter Xu (13):
  migration: Add option to set postcopy-blocktime
  migration/postcopy: Push blocktime start/end into page req mutex
  migration/postcopy: Drop all atomic ops in blocktime feature
  migration/postcopy: Make all blocktime vars 64bits
  migration/postcopy: Drop PostcopyBlocktimeContext.start_time
  migration/postcopy: Bring blocktime layer to us level
  migration/postcopy: Add blocktime fault counts per-vcpu
  migration/postcopy: Report fault latencies in blocktime
  migration/postcopy: Initialize blocktime context only until listen
  migration/postcopy: Cache the tid->vcpu mapping for blocktime
  migration/postcopy: Cleanup the total blocktime accounting
  migration/postcopy: Optimize blocktime fault tracking with hashtable
  migration/postcopy: blocktime allows track / report non-vCPU faults

 qapi/migration.json                   |  20 +
 migration/migration.h                 |   2 +-
 migration/postcopy-ram.h              |   2 +
 migration/migration-hmp-cmds.c        |  73 ++--
 migration/migration.c                 |  24 +-
 migration/options.c                   |   2 +
 migration/postcopy-ram.c              | 518 ++++++++++++++++++++------
 tests/qtest/migration/migration-qmp.c |   4 +
 migration/trace-events                |   8 +-
 9 files changed, 496 insertions(+), 157 deletions(-)

-- 
2.49.0


