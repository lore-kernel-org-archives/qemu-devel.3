Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E2606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XZfEDAok
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNxHL-0001ov-84; Mon, 02 Nov 2026 14:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHI-0001oU-UI
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHG-00089n-RX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793646065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJ7IrRSP6DFeDa0p+sMMGFswrCdmszjAHQbyAwuBgEc=;
 b=XZfEDAokgmdFZRf3Mhj3i1qFCpYxC+tjroL+LWdw9uIQa42i0DWYxIcgP0vwMUqHwvo1bz
 dabigs6m7fU2K/QVQChT95/pt/hKuxCONHUeMSyxGtwpjSm0hu8T+DR63QtvU46swaNV9W
 ftk7pT2ekggrJCAZHM7gY2lSHdrXY8s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-TslOzLWwNUSvrjLyCe67EA-1; Mon,
 02 Nov 2026 14:01:03 -0500
X-MC-Unique: TslOzLWwNUSvrjLyCe67EA-1
X-Mimecast-MFC-AGG-ID: TslOzLWwNUSvrjLyCe67EA_1793646063
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8C831954B19
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 19:01:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54CCD1955F43; Mon,  2 Nov 2026 19:01:02 +0000 (UTC)
Date: Mon, 2 Nov 2026 13:53:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/25] trace: bugfixes, cleanups and optimizations
Message-ID: <20261102185310.GA1738758@shajnocz.csb>
References: <20261102142844.3464712-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102142844.3464712-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 02:28:19PM +0000, Daniel P. Berrangé wrote:
> This series started off with fixing some compile failures seen
> with dtrace and ust backends, and got somewhat out of hand as
> I looked more deeply at the trace code. So it ended up doing
> various bits of code cleanup and memory usage optimizations.
> 
> The optimizations aren't huge against each individual binaries.
> There are too many scenarios to show the full set, but here
> are some binary size examples
> 
> The current git master baseline for different enabled
> backends  on the x86_64 emulator:
> 
>   nop 88546360
>   dtrace 90604496
>   ftrace 93265944
>   log 93799528
>   syslog 93962704
>   simple 97064528
>   ust 162999944
>   dtrace,ftrace,log,syslog,simple,ust 174438088
> 
> 'ust' has insanely high overhead in terms of binary sizes,
> inexplicably insane.
> 
> 'ftrace/log/syslog' are all similar because their overhead
> is dominated by the printf() format strings which are
> identical in all.
> 
> 'simple' is a bit worse because of the helper functions we
> must generated for each probe
> 
> After this series is applied the results for x86_64 are
> 
>   nop 88510248
>   dtrace 90576160
>   ftrace 93156320
>   log 93735064
>   syslog 93853480
>   simple 97050856
>   ust 162957256
>   dtrace,ftrace,log,syslog,simple,ust 174431128
> 
> IOW, for 'dtrace', we save 28k, for 'log' we save 62k
> 
> For the aarch64 binary, we see bigger saving in some
> cases:
> 
>   baseline dtrace 127610144
>   baseline log 131050320
>      trace dtrace 127459264
>      trace log  130998872
> 
> IOW, for 'dtrace' we save 150k, for 'log' we only save
> 50k. No clue why the saving is not so significant for
> the 'log' backend but not a big deal.
> 
> Changed in v4:
> 
>  * Fix hex printing in hppa trace events
>  * Remove more docs mentions of 'disable'
> 
> Changed in v3:
> 
>  * Include QEMU log mask check in Rust generated code too
>  * Eliminate duplicate state checks in DSTATE macro
> 
> Changed in v2:
> 
>  * Improve some commit messages
>  * Updated tracing.rst docs
> 
> Daniel P. Berrangé (25):
>   osdep: add 'ignore_value(x)' macro
>   trace: use 'ignore_value()' instead of a dummy variable
>   trace: fix handling of char** in UST backend
>   hw/xen: replace "long unsigned int" with "unsigned long " for dtrace
>   trace: block use of "long int" for dtrace
>   trace: drop unused trace_event_set_state_dynamic_init()
>   trace: remove obsolete references to vcpu property
>   trace: drop 'id' from TraceEvent struct when not required
>   trace: change "DSTATE" variables from uint16_t to uint8_t
>   trace: add testing of 'nop' trace backend
>   trace: don't emit TraceEvent structs when 'nop' backend is used
>   trace: add test of generation with all backends enabled
>   trace: remove redundant headers from simple trace backend code
>   trace: include probe name in Rust format strings
>   trace: add missing newline in ftrace Rust format string
>   trace: eliminate dupe trace_event_get_state_dynamic_by_id() calls
>   audio: remove mistaken use of trace_event_get_state()
>   hw/ppc: remove mistaken use of trace_event_get_state()
>   monitor: remove mistaken use of trace_event_get_state()
>   trace: include qemu_loglevel_mask(LOG_TRACE) in guard
>   target/hppa: use PRIx64 in trace-events
>   trace: remove "disable" property from trace files
>   trace: stop tracking static disabled state
>   trace: remove parsing of "disable" event property
>   trace: remove 'trace_event_get_state' wrapper
> 
>  audio/audio-mixeng-be.c                      |   2 +-
>  docs/devel/tracing.rst                       |  27 +----
>  hw/display/trace-events                      |   2 +-
>  hw/ppc/vof.c                                 |  13 +--
>  hw/xen/trace-events                          |   4 +-
>  include/qemu/osdep.h                         |   8 ++
>  monitor/qmp.c                                |   4 +-
>  qapi/trace.json                              |   5 +-
>  scripts/tracetool/__init__.py                |  32 ++----
>  scripts/tracetool/backend/__init__.py        |   7 +-
>  scripts/tracetool/backend/dtrace.py          |   2 -
>  scripts/tracetool/backend/ftrace.py          |   8 +-
>  scripts/tracetool/backend/log.py             |  22 ++--
>  scripts/tracetool/backend/simple.py          |   9 +-
>  scripts/tracetool/backend/syslog.py          |   6 +-
>  scripts/tracetool/format/c.py                |  74 +++++++-------
>  scripts/tracetool/format/d.py                |   3 -
>  scripts/tracetool/format/h.py                |  48 ++++-----
>  scripts/tracetool/format/log_stap.py         |   3 -
>  scripts/tracetool/format/rs.py               |  30 +++---
>  scripts/tracetool/format/simpletrace_stap.py |   3 -
>  scripts/tracetool/format/stap.py             |   3 -
>  scripts/tracetool/format/ust_events_c.py     |   3 -
>  scripts/tracetool/format/ust_events_h.py     |   7 +-
>  stubs/trace-control.c                        |   6 --
>  target/hppa/trace-events                     |  28 +++---
>  tests/tracetool/all.c                        |  61 +++++++++++
>  tests/tracetool/all.d                        |  10 ++
>  tests/tracetool/all.h                        | 100 +++++++++++++++++++
>  tests/tracetool/all.log-stap                 |  15 +++
>  tests/tracetool/all.rs                       |  98 ++++++++++++++++++
>  tests/tracetool/all.simpletrace-stap         |  16 +++
>  tests/tracetool/all.stap                     |  14 +++
>  tests/tracetool/all.ust-events-c             |  14 +++
>  tests/tracetool/all.ust-events-h             |  56 +++++++++++
>  tests/tracetool/dtrace.c                     |  10 +-
>  tests/tracetool/dtrace.h                     |   6 +-
>  tests/tracetool/dtrace.rs                    |   6 +-
>  tests/tracetool/ftrace.c                     |  10 +-
>  tests/tracetool/ftrace.h                     |  14 ++-
>  tests/tracetool/ftrace.rs                    |  10 +-
>  tests/tracetool/log.c                        |  10 +-
>  tests/tracetool/log.h                        |  26 +++--
>  tests/tracetool/log.rs                       |  12 ++-
>  tests/tracetool/meson.build                  |   4 +-
>  tests/tracetool/nop.c                        |   7 ++
>  tests/tracetool/nop.h                        |  25 +++++
>  tests/tracetool/nop.rs                       |  51 ++++++++++
>  tests/tracetool/simple.c                     |  12 +--
>  tests/tracetool/simple.h                     |  10 +-
>  tests/tracetool/simple.rs                    |   6 +-
>  tests/tracetool/syslog.c                     |  10 +-
>  tests/tracetool/syslog.h                     |  14 ++-
>  tests/tracetool/syslog.rs                    |  10 +-
>  tests/tracetool/tracetool-test.py            |  12 ++-
>  tests/tracetool/ust.c                        |  10 +-
>  tests/tracetool/ust.h                        |   6 +-
>  trace/control-internal.h                     |   8 +-
>  trace/control-target.c                       |  29 ------
>  trace/control.c                              |  19 +---
>  trace/control.h                              |  49 +--------
>  trace/event-internal.h                       |  19 +---
>  trace/ftrace.c                               |   3 +-
>  trace/qmp.c                                  |  47 +++------
>  trace/simple.c                               |   9 +-
>  65 files changed, 750 insertions(+), 457 deletions(-)
>  create mode 100644 tests/tracetool/all.c
>  create mode 100644 tests/tracetool/all.d
>  create mode 100644 tests/tracetool/all.h
>  create mode 100644 tests/tracetool/all.log-stap
>  create mode 100644 tests/tracetool/all.rs
>  create mode 100644 tests/tracetool/all.simpletrace-stap
>  create mode 100644 tests/tracetool/all.stap
>  create mode 100644 tests/tracetool/all.ust-events-c
>  create mode 100644 tests/tracetool/all.ust-events-h
>  create mode 100644 tests/tracetool/nop.c
>  create mode 100644 tests/tracetool/nop.h
>  create mode 100644 tests/tracetool/nop.rs
> 
> -- 
> 2.56.0
> 

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan


