Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D0606A33A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=gJK4BrEi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1As-00071N-2j; Thu, 05 Nov 2026 12:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Ap-00070q-ER
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:51 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1An-0007f1-BV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:51 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso17475415e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793899367; x=1794504167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xsIvYpsSHc/l/pCQsHSKYawUUdT/uLOsS9sEu5gjWD4=;
 b=gJK4BrEi77DUguAvCvPGtPCeWvZboFoh5ClTlXqPMnvx0wMDBp3FmlZiSdq7hfr+3Y
 hJE6frk5avBeBNjzbp7E9Ib9k4T15KhgqvLEBjpr0jqvDPo1NU7JCjhO7CbqLs1cZ/uJ
 VkheAYHlZ9VSmUr9LyDULb/mliRX89R4I5MIav1sUZ8lHbgA3pLeyJJ+6bsY08C6gkDg
 92ZUYyWB776xVYSI0sxKj/Foy+w6MJ/+gB0WTLIRL4blNBmF/vFd2pAHAnVRau46Uf2P
 Upjm44agkv5y3FjfBBjvkD+VAGZjwEMw75JDT69hC9CLycmuk3CrVAcck7bximqr5F28
 ljNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899367; x=1794504167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xsIvYpsSHc/l/pCQsHSKYawUUdT/uLOsS9sEu5gjWD4=;
 b=oyhPRlTWqCn74iaeuGcdUkzSOrN3jHDdMJrF7JA1qjK99BU6GdqEn0jwcqIwZvXtW3
 I7n51Ybi1QZgvOTV2KmmTpJxxeyB7dlR5yaPypJb6TDXBTQJiVZeTOh7TgdXgY5ar95W
 KipSsUySFfC9eoTs8CwOvvHemB57sKsCsCNANd75yGmRkSPK5wLOyNLxZmR/9FkWrkMu
 ixnQGxrKo1LLyzTabanJyTcFYHt9AT7oAHQs6AwAr5U42QwBvpvOx3eu8gykFpoqulp2
 my5hVsLMh5/VOI2XH8gRR6f/phnKq7VvEaKUZO2uniOK662IntM0FcdOQUCF3del6wFD
 o/Kg==
X-Gm-Message-State: APuU4Z9W99r7Wqomlale/LWJ7Y6xYK2prB50uaZBEKEM5pvhT47HLrsN
 1QE+1+tKf+YW7RWt/zCnUH97KlRIRuqWWalR7PlCADOULhe7D7U0aGyWc3RO55mrjiLG/XSKkQs
 74Tkb
X-Gm-Gg: AYBFou0olwrEGKwAw4/JDoiYj2frtKx7ceRBS3lds275i0za7dXEdfu+7sSkFbKor6O
 E7Pherjb+ZV29zIS8yCQ2DN1HXZVnOxa8P50g3sJHYY5E3lG6Q5TLEBXLIXqYFlvNlTvj3WfS4+
 lAb7IMPbDS9TpnJUYD7ua8mdAmQDwjvcEVSYzmmeLqdXXLpRncKFI6aXe/tPSXHXAx9UMBIsd1A
 Y2beaAIPcHcIdD1CIDFFlj5HfSEA/dqmXKcpuTIcJ/aehCk92qwuJGwiNuTdr9y9h6EH8I/SHJ2
 2qMJrMfSXrcmkjYRLAyQEalUANJWIxtno0UFcBslqgUi6hTExA9Bbn50NdNPQwSlKKOEpQS2Wh4
 xCTSkQ47qyGpNEXBlfYuftnNTEPPrsbtNlhTAudD8iH6/LZuxp8MloFHyUG72LP+iBQWpIMty8m
 3gH/neBbXDK2ez99ggO3wO2VtVhWTogC2ckmWu9F1qhV6WyHC+dJ4iHmbZq5KKEznTpYn43kV53
 3Tpjo/bjSfa2t62fpSjmv+Ypb+4+6fokgZ2RKzKcaBHxggiKA9s6qLEM4kAPc1MyS0+wC3AuGlm
 +kpETIIGYqfCilJc+weyt9y/edA=
X-Received: by 2002:a05:600c:354c:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4ac18c7389amr447705155e9.34.1793899367449; 
 Thu, 05 Nov 2026 09:22:47 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm130632255e9.3.2026.11.05.09.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:22:47 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH v2 0/6] migration: cut destination-side downtime on a big guest
Date: Thu,  5 Nov 2026 18:22:38 +0100
Message-ID: <20261105172244.2804598-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=den@openvz.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v1 deferred the Hyper-V SynIC post_load so that it stopped forcing a
flatview rebuild per vCPU. Measuring it showed the rebuild itself was
the larger target: most of it is building the dispatch tree, which
nothing translates through until a vCPU runs. Patches 1 to 3 stop
building trees until the machine is about to run, for machine creation
and an incoming stream alike. Patches 4 to 6 are v1 reworked after
Peter's review: a device gets a separate post_load_mr_update callback
which only maps or unmaps its regions, and a load batches those calls
into one memory transaction after the device state has been read and
before the guest can start.

The split is a correctness fix, not only an API change. v1 deferred the
whole SynIC post_load, including the control bit VMBus reads in its own
post_load to decide whether a SINT route gets a GSI. With a vmbus-bridge
the destination would create the route without one, and the guest would
get no further VMBus interrupts. Patch 5 separates state from mapping,
patch 6 batches only the mapping.

The batch spans the whole load rather than one device, the alternative
Chuang's series and the ToDo item point towards: a remap which repeats
per vCPU sits in a per-vCPU section, so per-device batching would still
rebuild once per vCPU. Unlike that series, the stream is not loaded
inside the transaction: only callbacks which by contract resolve nothing
share it, so no loader sees a stale view.

Measured on a 24-core EPYC 7443P restoring a captured stream of a
Windows Server 2022 guest, median of three interleaved rounds. The
metric is the sum of vmstate_downtime_load over the non-iterable
sections plus everything deferred past the last section, so work moved
to the end is not mistaken for work removed:

                        64 vCPU, 65 ports    4 vCPU, 16 ports
  upstream                    175 ms              25 ms
  after patch 3                50 ms              10 ms
  after patch 6                29 ms               9 ms

Patch 3 helps every guest; its saving tracks device count. Patch 6
scales with vCPUs: 21 ms on the large guest, 1 ms on the small one.
Both guests map only the SynIC message page; one which also maps the
event page saves about twice as much.

Patches 1 to 3 rest on no vCPU having run, so only the thread creating
the machine or loading the stream, under the BQL, can reach a view
without a tree; building one asserts the BQL. Postcopy starts the guest
through vm_prepare_start() like any other start.

Tested on x86_64 with make check-unit, check-qtest-x86_64 and
migration-test --full under KVM and forced onto TCG, where the subpage
path runs; both include the postcopy cases. A guest which programs the
SynIC from its boot sector comes back from save and restore with both
pages mapped where they were.

v1: https://lore.kernel.org/qemu-devel/20260911142345.3999518-1-den@openvz.org/
Chuang Xu: https://lore.kernel.org/r/20230317081904.24389-1-xuchuangxclwt@bytedance.com
ToDo: https://wiki.qemu.org/ToDo/LiveMigration#Optimize_memory_updates_for_non-iterative_vmstates

Changes in v2:
 - added patches 1 to 3, the dispatch-tree work; the batch runs inside
   the window patch 3 opens
 - post_load_deferrable replaced by post_load_mr_update, a callback for
   region updates only (Peter)
 - SynIC post_load split, patch 5, so VMBus still sees the SynIC state
 - postcopy covered: the batch is made in the POSTCOPY_RUN handler
   before the bottom half which starts the guest is scheduled (Peter);
   the listen thread is not batched
 - snapshot and xen loads batched the same way, COLO checkpoints not
   (Peter)
 - the callback cannot fail; the abort on a failing hook is gone (Peter)
 - documentation says the batch is one transaction and a lookup during
   it sees the old topology (Peter)
 - APIC example dropped; the new callback cannot carry cross-thread work

CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Philippe Mathieu-Daude <philmd@oss.qualcomm.com>
CC: Zhao Liu <zhao1.liu@intel.com>
CC: Marcelo Tosatti <mtosatti@redhat.com>
CC: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>

Denis V. Lunev (6):
  memory: publish a dispatch tree only once it is complete
  physmem: pass the FlatView to address_space_translate_internal
  memory: stop building dispatch trees before the machine runs
  migration: add post_load_mr_update to batch region remaps on load
  hw/hyperv: split the SynIC page mapping from its state update
  target/i386: batch the Hyper-V SynIC page remaps on load

 hw/hyperv/hyperv.c            |  70 ++++++++++++++------
 include/hw/hyperv/hyperv.h    |   3 +
 include/migration/vmstate.h   |  30 +++++++++
 include/system/memory.h       |  19 ++++++
 migration/savevm.c            |  22 +++++++
 migration/vmstate.c           |  50 ++++++++++++++
 system/memory-internal.h      |  17 ++---
 system/memory.c               | 119 +++++++++++++++++++++++++++++++---
 system/physmem.c              |  78 +++++++++++++++-------
 system/runstate.c             |   3 +
 system/trace-events           |   1 +
 target/i386/kvm/hyperv-stub.c |   8 +++
 target/i386/kvm/hyperv.c      |  16 ++++-
 target/i386/kvm/hyperv.h      |   2 +
 target/i386/machine.c         |   8 ++-
 tests/unit/test-vmstate.c     | 109 +++++++++++++++++++++++++++++++
 16 files changed, 489 insertions(+), 66 deletions(-)

-- 
2.53.0


