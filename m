Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C38606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M1uhsK/2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUROG-0004C1-88; Fri, 20 Nov 2026 11:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUROD-0004AP-QB
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:23:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUROC-0000mZ-1J
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795191782;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oiKmH3vjsES5PK2aW4HiJue2/qlsBNvWLKNdgghVBc=;
 b=M1uhsK/21Q/4tTIe8k5x+q2CHC51pWukmemNhNLRcEZIUjlWhdq2dukvY0bzqkCwhs0sNW
 zHmQ24Tg7S+4/kg0H8fG8JkqDqQaHPx5nSSRozvB74xJ5aVE+L16RLblrAa0NfORA+gwIL
 cdEUr73HpRcHmf2+vHQRfek2cSgbpAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-ikglE_BvM0a27S1_qJ9Rcw-1; Fri,
 20 Nov 2026 16:22:56 +0000
X-MC-Unique: ikglE_BvM0a27S1_qJ9Rcw-1
X-Mimecast-MFC-AGG-ID: ikglE_BvM0a27S1_qJ9Rcw_1795191773
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FF0C195605E; Fri, 20 Nov 2026 16:22:53 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD79F30000E3; Fri, 20 Nov 2026 16:22:51 +0000 (UTC)
Date: Fri, 20 Nov 2026 16:22:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/10] system: add a watchdog for the Big QEMU Lock
Message-ID: <awBz2AP3W6-XNQ9U@redhat.com>
References: <20260915203455.580999-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 15, 2026 at 10:34:44PM +0200, Denis V. Lunev wrote:
> A vCPU thread reacquires the BQL on every exit that needs userspace. A
> holder that keeps it for tens of seconds stops every vCPU, the guest
> reports a soft lockup or panics, and qemu itself records nothing. The
> guest log is the only evidence, and it cannot say whether the hypervisor
> held the lock or the guest wedged on its own.
> 
> This series adds a BQL watchdog. A sampler thread watches a sequence
> counter that bql_update_status() advances on every acquire and release.
> One odd value across the whole window means one owner held the lock for
> the whole window. On expiry the watchdog names the holder and prints the
> state of every other thread:
> 
>   qemu-system-x86_64: 2026-09-15T15:53:57Z BQL held for more than 100 ms by thread 168146
>     168146  qemu-system-x86  S
>         pc 0x785a4dbcb884 liburing.so.2+0x2884
>         wchan io_cqring_wait
>     168147  call_rcu         S
>         pc 0x785a4d534acb syscall+0x1b
>         wchan futex_do_wait
>     168148  IO mon_iothread  S
>         pc 0x785a4d4ac802 libc.so.6+0xac802
>         wchan poll_schedule_timeout.constprop.0
> 
> With CAP_SYS_ADMIN the wchan line becomes the kernel stack. The pc line
> comes from signalling each thread and reading the program counter out of
> its signal frame, which is what tells a thread spinning in userspace
> from one asleep in a syscall.
> 
> The watchdog is off by default and stays quiet under a debugger. Two
> machine properties drive it: bql-watchdog-ms sets the deadline, on the
> command line or over qom-set at any time, and bql-watchdog-abort turns
> the report into a core dump for hosts where the answer is worth more
> than the guest.
> 
> Patches 1 to 6 are the pieces: a fix for bql_locked across the timed
> condvar wait, a debugger check, the per-thread state reader and its
> kernel stack and program counter extensions, and the signal reserved for
> the latter. Patches 7 to 9 are the watchdog itself. Patch 10 is a
> functional test that holds the BQL through an HMP qemu-io write to a
> null-co node with a latency longer than the deadline.
> 
> The program counter lives at a host specific offset in the signal frame,
> so patch 6 reads it through a host/include header. The Linux headers for
> aarch64, ppc64, riscv64, s390x and loongarch64 repeat what linux-user's
> host-signal.h already knows about those frames, but only the x86_64 one
> has been compiled here, and the Windows half of patch 1 has not been
> compiled either.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> 
> Denis V. Lunev (10):
>   util/qemu-thread: track bql_locked across the timed condvar wait
>   oslib: add qemu_debugger_attached()
>   oslib: add qemu_thread_states()
>   oslib: report kernel stacks in qemu_thread_states()
>   util/qemu-thread: reserve a signal for thread introspection
>   oslib: report each thread's program counter
>   system/cpus: report a BQL held past a deadline
>   system/cpus: hold off the BQL watchdog under a debugger
>   system/cpus: add bql-watchdog-abort
>   tests/functional: cover the BQL watchdog
> 
>  host/include/aarch64/host/signal-pc.h         |  20 ++
>  host/include/generic/host/signal-pc.h         |  11 +
>  host/include/loongarch64/host/signal-pc.h     |  20 ++
>  host/include/ppc64/host/signal-pc.h           |  22 ++
>  host/include/riscv64/host/signal-pc.h         |  20 ++
>  host/include/s390x/host/signal-pc.h           |  20 ++
>  host/include/x86_64/host/signal-pc.h          |  20 ++
>  hw/core/machine.c                             |  44 +++
>  include/qemu/osdep.h                          |  29 ++
>  include/system/cpus.h                         |   8 +
>  meson.build                                   |   2 +
>  qemu-options.hx                               |  11 +
>  system/cpus.c                                 | 143 ++++++++
>  tests/functional/generic/meson.build          |   1 +
>  tests/functional/generic/test_bql_watchdog.py |  60 ++++
>  util/oslib-posix.c                            | 316 ++++++++++++++++++

As a general point that doesn't fit any single patch, IMHO
it is undesirable to be putting all this logic into the
oslib-posix.c file.

It likely justifies being put into a standalone file eg a
new 'debug.c'


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


