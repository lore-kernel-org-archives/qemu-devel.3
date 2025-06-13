Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967E5C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59M-00043R-Qo; Fri, 13 Jun 2025 10:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59E-0003vl-Nn
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002If-Py
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nqSSpxIohRg2NhWZf9VXjEXc2pigBlW1DvzrAV4Vz/8=;
 b=VdIiLwNwJzC+52asA71P2iyZgqvlGL81mE0s7lqsloQEFQH8KQIrVPZ7mlCzMksyBgitpp
 qBszPugYl8n6mDy51AHoPP01lcgL5y7i46WqCzyFRXME++FWIAaOMjmK7fKpqybNJRwWDC
 YDCrylkCwQ9OZsJNwehTrCOEdz8dExQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-apn7Nxb7MAWyl8SGmmOECg-1; Fri, 13 Jun 2025 10:12:22 -0400
X-MC-Unique: apn7Nxb7MAWyl8SGmmOECg-1
X-Mimecast-MFC-AGG-ID: apn7Nxb7MAWyl8SGmmOECg_1749823941
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a57fea76beso44146881cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823941; x=1750428741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nqSSpxIohRg2NhWZf9VXjEXc2pigBlW1DvzrAV4Vz/8=;
 b=YP/sy+dSonZcu7i8yCmXiSSPX5UrspCzyWrLUzbfM+G3rcGHvnSbXP02DpuKQ42H7S
 Sdz34yPtoVj0SVvZDuTzqk1zpyBR1wkhgftjHeOy7QasFQZ06veOLUlQW9Lco+wKWx8I
 NmtuSSRJZCbhWd10+ytAtwoxKEAmfwGLEQLO13hL/p2wi0eCrHP+47RQ+MoNDFSTwMER
 VrxwXBo0h7zxynFtMd9z2ZJcnHgKMGnqDyG1K96+NLjzl3eCiL6BPaqX9FaNz/EFIrS+
 UMSqwxndNA9hGstyYJ2g2Uhh+9sLe+LEaoGisQYN3ceb4kq6M5OktwY5i6IdnErJw6hs
 tsTQ==
X-Gm-Message-State: AOJu0YzRA6HXGbRnIXPXJmA5vkRS5PR6YvRyEVaDFlLZjALZiZ0USc6u
 rlrhXExokh5m9rwrnDxRcMO/hBkXAwyLbbZML2gMrs/WczHjcMEgeCllTB/dyBhK9oFJ2i8Z2gU
 WEk+KTGCIl+wEpYhKEQZzOzQ21mj4wInqBxvmJ/rv1fXO4wvRh7z+9a1Z5GogE5CKHMVpK0U7VC
 M3ethU6NiiwMX19O4z7n1kszMS6yRQ+QVbcI5P+w==
X-Gm-Gg: ASbGnctEH910QjAmt3SwPv/Xyj6m952KUq/HD3nQ+En6G/bZ5zuQywapaVpy8z4eG1f
 OY+tSO6GjXBtHwFi7+19uK+aw/HH+v9Sjo3NLx8FPtlZgT6QLo9ZTctC5Win4G5NKUjPl+Rs4Br
 7EUpUYzaVIeaeOHUagQFeYNfAIo03tr52Ma6IE6x13mCrrP37pRrF2uyPSylihiO3odf/YIoqOP
 qGHEJav5sHr+AareRc2s6f2yGZ7aHrvM2769hvYJeMwfCswCKRgMgOkBNvXNhPctheRS2FhOYdx
 vLs39ekK6MI=
X-Received: by 2002:a05:622a:580e:b0:4a6:eac8:58c6 with SMTP id
 d75a77b69052e-4a72fe7ac63mr65121261cf.13.1749823941126; 
 Fri, 13 Jun 2025 07:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwn2bY+mx5B4ehm2hhD+NqntNYAhfRkVAQ4HubpkQH8ouRrBWMIsPWmc8m5LCx2kwcYWNX2g==
X-Received: by 2002:a05:622a:580e:b0:4a6:eac8:58c6 with SMTP id
 d75a77b69052e-4a72fe7ac63mr65120891cf.13.1749823940667; 
 Fri, 13 Jun 2025 07:12:20 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 00/14] migration/postcopy: Blocktime tracking overhaul
Date: Fri, 13 Jun 2025 10:12:03 -0400
Message-ID: <20250613141217.474825-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

v1: https://lore.kernel.org/r/20250527231248.1279174-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20250609191259.9053-1-peterx@redhat.com

v3 changelog:
- Switch to nanoseconds across for the whole patchset [Dave]
  NOTE: many patches need small touch ups on the conversion of units and
  rebase, I kept the tags.
- Mark all new blocktime fields experimental in QMP
  The expected use case is having mgmt query the results and dump them into
  log only for debugging purposes (rather than parsing them, as of now).
  Chose this way to suggest userapp not parsing them, meanwhile more flexible.
- Added the other patch to add latency buckets into this series
- Fixes spots on checkpatch issues
- Added Tested-by tags for Mario for relevant patches

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

  Do this almost to support nanoseconds trackings (which used to be in
  milliseconds).  Note this does not change existing results reported in
  QMP in the past because it is ABI, however we'll use nanoseconds for any
  new results to be reported later.

- Added support to report fault average latencies (globally, per-vCPU,
  non-vCPU), results are in nanoseconds.

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

- Added latency distribution in power-of-two buckets

  It's the last patch, it's collected from a separate post from:
  https://lore.kernel.org/all/20250609223607.34387-1-peterx@redhat.com/

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

Comments welcomed, thanks.

Peter Xu (14):
  migration: Add option to set postcopy-blocktime
  migration/postcopy: Push blocktime start/end into page req mutex
  migration/postcopy: Drop all atomic ops in blocktime feature
  migration/postcopy: Make all blocktime vars 64bits
  migration/postcopy: Drop PostcopyBlocktimeContext.start_time
  migration/postcopy: Bring blocktime layer to ns level
  migration/postcopy: Add blocktime fault counts per-vcpu
  migration/postcopy: Report fault latencies in blocktime
  migration/postcopy: Initialize blocktime context only until listen
  migration/postcopy: Cache the tid->vcpu mapping for blocktime
  migration/postcopy: Cleanup the total blocktime accounting
  migration/postcopy: Optimize blocktime fault tracking with hashtable
  migration/postcopy: blocktime allows track / report non-vCPU faults
  migration/postcopy: Add latency distribution report for blocktime

 qapi/migration.json                   |  38 ++
 migration/migration.h                 |   2 +-
 migration/postcopy-ram.h              |   2 +
 migration/migration-hmp-cmds.c        | 104 ++++-
 migration/migration.c                 |  25 +-
 migration/options.c                   |   2 +
 migration/postcopy-ram.c              | 563 ++++++++++++++++++++------
 tests/qtest/migration/migration-qmp.c |   5 +
 migration/trace-events                |   8 +-
 9 files changed, 593 insertions(+), 156 deletions(-)

-- 
2.49.0


