Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91253C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Th-0003Fm-9k; Tue, 27 May 2025 19:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tf-0003FQ-2G
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tb-0001Bx-Vk
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/3ehStmnkcbTbF7/WcTkFV+ja71FxZ32zLdEx2nhK1M=;
 b=DdY66j+FGyzeZibtBI1p6HuDyoH8MiRyIqGBihniR929Ux3smJBanbJH/WUG0e5puoMaUy
 fXIgpGgNiP+e2WIYB7AGhmb+vrEIeqXEB4PpIutS3hIdZfXDRMNAZriqpPtXtFv+5t9APb
 xJOTQK1y0FEi8H94DQeRCgvrhtOM6x4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-wHLwcEiONqSthKMt5Iu8iA-1; Tue, 27 May 2025 19:12:53 -0400
X-MC-Unique: wHLwcEiONqSthKMt5Iu8iA-1
X-Mimecast-MFC-AGG-ID: wHLwcEiONqSthKMt5Iu8iA_1748387573
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c7c30d8986so1180542085a.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387573; x=1748992373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/3ehStmnkcbTbF7/WcTkFV+ja71FxZ32zLdEx2nhK1M=;
 b=Xv/46zT2s1/GHN8Nk68txWrEw69h4DQHr5iA2TrzVMvVU8rXJxqTd5c5pHlRMYKUso
 RmYIXB/nupHK44Wnfqk7FOLL4Wp5VRJ+nHh+eGtOgVGSjh++o//KU7RmUL6zxLr7kEiz
 SySTGDsKH/v1hdVUKgxeQ1+a15U+KIH6hbCVeXgl0QjmnmnmtrQZKNJZ0mFA+X6TABu8
 b04KhQ5Pm8L0DoVFrLjSexOi1iL2UciQUZHEa6vpmKAdgfyO2CZ6sx3bauJWNRa0QL6P
 4GBy9UV0AuBSXPlxPZUKqDpngNk4f9Qf2p5B2w9Tz4YH+slkQ7Ub9N28c1qXblgeDOvk
 GvWQ==
X-Gm-Message-State: AOJu0YwARDsDZBd+UAEN5IeAhUOG9JiucRDLBWglPiF3+OauUtFM0GTE
 hvzHTYhp11NxDfJXW/fxCELlzwlIJxwNdj+MrIBU7yHvFsSik/0/G9pxjzPRiXJVkEfrkKMhyx4
 A4g7X0lrGcoxf4rugTcFt+QRSc9gLgahiXawbMSUjBHuLnQ9n/HTPSfCheWmRu7KZrGAXfiltE7
 Lg1ck2dv7rtZE03LfgFsxMEd9U4muokIKCp8wMBA==
X-Gm-Gg: ASbGncvLZ2rxs9awjrzBtypV8Bff1Sra4zaCabKXd13/HPqS+a98PsGbB76HE8F7ZMC
 b2O3fU1hO2oYGwEzwJY0V0lRmvMUD+IeC5f61+50pksxTgsgyVkTy7bTrlp0VFUAhUZoD4llMOM
 3U9FuyvGcqm4AGO9M5wcZgtvXqOJXM22p1EbjSi/bbdXtPeXaN2CPBYrqXQFNdYcOrqKnw/Tfhs
 McEpEirwO0zBTEBZwAyjpA/pXdS4yEWPNLpWEjOnrXOndHbIieiIyf///CEk0VSlP1+ByKvaRi6
X-Received: by 2002:a05:622a:2b48:b0:48b:42ca:13d6 with SMTP id
 d75a77b69052e-49f4624fad6mr202753121cf.7.1748387572621; 
 Tue, 27 May 2025 16:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJaJAuu/4NqsLy6FaZH5qD6OeW20nUshS8ft4Yw6fJC+cWbuZGLkqr/U4elVz1/AGTAGiTWw==
X-Received: by 2002:a05:622a:2b48:b0:48b:42ca:13d6 with SMTP id
 d75a77b69052e-49f4624fad6mr202752771cf.7.1748387572214; 
 Tue, 27 May 2025 16:12:52 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:12:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 00/13] migration/postcopy: Blocktime tracking overhaul
Date: Tue, 27 May 2025 19:12:35 -0400
Message-ID: <20250527231248.1279174-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series is based on the other series I posted here:

Based-on: <20250527215850.1271072-1-peterx@redhat.com>
https://lore.kernel.org/r/20250527215850.1271072-1-peterx@redhat.com

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
 migration/migration-hmp-cmds.c        |  75 ++--
 migration/migration.c                 |  24 +-
 migration/options.c                   |   2 +
 migration/postcopy-ram.c              | 518 ++++++++++++++++++++------
 tests/qtest/migration/migration-qmp.c |   4 +
 migration/trace-events                |   8 +-
 9 files changed, 497 insertions(+), 158 deletions(-)

-- 
2.49.0


