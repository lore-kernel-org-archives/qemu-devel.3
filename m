Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E535105F79E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 19:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1UxP-0001Lb-0Y; Sat, 14 Mar 2026 15:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w1UxM-0001LS-S7
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 15:47:28 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w1UxJ-0000ZT-7y
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 15:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773517646; x=1805053646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mWC8Z5szmSICcQq6mTBIkH+0IPmt9wSYAYa/3qk6PI8=;
 b=jJ13Lx7rbHA5iAV8g+a84Ywf/qPX+8tJuu2euTzti3tn5mxXlKrmFtZI
 gcUVU41I9mbuJwQACG9hNX4XClPHKL4Lrp6yXTQviwGZt/NtIz0JwFZqG
 jrF0oAHzWxWBQ2l1IuxFNLr1RnEz79rSFRcoBhRmMc/UyG/+OHgvIuxOK
 IdsmqGCDBnfZU1HNeDW1mS/6k6BptIGQftfFSf8A4r3eKHSzgLyBachu/
 D6RU8dT0LrCc+EUdqn6Cp0Bk0ukl2bBewV/C8QYiv/umf9w4QaJ0El1QV
 N4Pmcx5qdJH8SXW2plHgTR8/FihydhIlqW9UM0VxmOrqyce49yVvtVCrP Q==;
X-CSE-ConnectionGUID: RLYLd1KbRZqADelRlVM3UA==
X-CSE-MsgGUID: pXmr0SADRlu50heU10FqSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="97201958"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; d="scan'208";a="97201958"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2026 12:47:21 -0700
X-CSE-ConnectionGUID: RkLFvGMrTEu4eVwJ874aQw==
X-CSE-MsgGUID: 0B3NxKaSTri4XJ+6Gx0zmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; d="scan'208";a="216242554"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2026 12:47:18 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org,
	peterx@redhat.com
Cc: stefanha@gmail.com,
	marco.cavenati@music.ethz.ch,
	junjie.cao@intel.com
Subject: Re: Call for GSoC internship project ideas
Date: Sun, 15 Mar 2026 03:47:06 +0800
Message-ID: <20260314194706.637-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <aWZk7udMufaXPw-E@x1.local>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <aWZk7udMufaXPw-E@x1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter, Marco, and QEMU community,

I'm Junjie Cao -- I graduated from the National University of Singapore
last year and am currently working at Intel. I'd like to express my
interest in the GSoC 2026 Fast Snapshot Load project.

Much of my background is in network device virtualization -- specifically
the QEMU/DPDK/Virtio-net/VHost stack (emulation and tuning). This has
given me hands-on experience with QEMU's guest memory management and
device state serialization, and helps me appreciate how practical the
problem this project aims to solve really is -- Marco's fuzzing use case
of loading snapshots frequently is a great example.

== Preparation so far ==

- Built QEMU from latest master; will be sending a small fix patch soon to
get familiar with the QEMU community workflow.

- Read Peter's original proposal and the follow-up discussion with Marco;
read mapped-ram.rst -- the fixed-offset format allows pread() of any page
by RAMBlock+offset directly from the snapshot file, which is the
prerequisite for demand paging to work.

- On the source level, focused on two paths: the uffd infrastructure in
migration/postcopy-ram.c (postcopy_ram_fault_thread,
postcopy_ram_incoming_setup, ram_block_enable_notify) to understand how
postcopy registers and handles page faults; and ram_load() in
migration/ram.c to understand RAM section deserialization during loadvm.
The intersection of these two paths is where the core changes for this
project would go.

== Implementation path as I understand it ==

The core idea: split loadvm into "device state loading" and "RAM
loading", bridged by uffd. Based on file: migration + mapped-ram:

- Modify the ram_load() path: parse_ramblock_mapped_ram() reads the
MappedRamHeader and bitmap but skips read_ramblock_mapped_ram(), building
an offset table for on-demand pread() instead. Other device states load
normally.

- Register userfaultfd (MISSING mode) on all migratable RAMBlocks.
postcopy-ram.c has similar infrastructure; the difference is we don't
need discard logic or the source-side page request protocol.

- Start vCPUs with two threads populating RAM in parallel: a background
loader doing sequential pread() + UFFDIO_COPY for bulk prefetch, and a
fault handler resolving vCPU-triggered page faults on demand. A
per-RAMBlock atomic bitmap with test_and_set coordinates the two to
avoid double-copy. Once all pages are loaded, unregister uffd. Loadvm is
complete.

Peter mentioned that the MVP could start with no multifd and anonymous
memory only -- I think that would be a great approach. Since mapped-ram
and postcopy are currently mutually exclusive in migrate_caps_check(), 
a new capability will likely be needed for this feature.

== A thought and a question ==

Some devices' load_state handlers access guest RAM during restore.
Postcopy handles this by registering uffd before device state loading
(inside the POSTCOPY_LISTEN handler, before device sections in the
CMD_PACKAGED blob). The same ordering applies here: register uffd, start
the fault handler, then load device states -- any RAM touch is
intercepted and resolved via pread().

This relies on the kernel queuing faults between UFFDIO_REGISTER and the
first poll(). I noticed postcopy_ram_incoming_setup() has a similar
window (fault thread created before blocks registered) -- is this the
same guarantee we'd rely on here?

== Next steps ==

Besides attempting a QEMU patch submission and working on my proposal,
is there anything else you'd suggest I prepare?

Any feedback or guidance would be very much appreciated!

Best regards,
Junjie Cao
junjie.cao@intel.com

