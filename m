Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245F6CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18vH-00042j-4T; Tue, 23 Sep 2025 15:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18vF-00042X-JT
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18vD-0001Cn-4T
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758656609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qAbajBdGzZ92NSPYtOiCgfbZTRXNTUJfz0XMRmJnRWI=;
 b=VecQ907/h2QthHTFHB3tsNDDAEoyNX/jy4HHGztuE5W64OJ8OXgwrSu6296dmSBvze9hfm
 A/SHsZsfHeSfZqNpKLj3KUvvBJUY41FYxH5BQjAo73Bvbh5BKTLt7LS3St4WJ3ocgsi8cw
 ExvOsHqRmXahbgpTVXR0oTRtVbbfffQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-Su2hp4X7PR-gLgZ1eV8X8A-1; Tue,
 23 Sep 2025 15:43:25 -0400
X-MC-Unique: Su2hp4X7PR-gLgZ1eV8X8A-1
X-Mimecast-MFC-AGG-ID: Su2hp4X7PR-gLgZ1eV8X8A_1758656603
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7779E19560B6; Tue, 23 Sep 2025 19:43:23 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F17B91800452; Tue, 23 Sep 2025 19:43:22 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:43:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 00/16] tracetool: add Rust support
Message-ID: <20250923194321.GS509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/WMmduB2K19wYKxd"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--/WMmduB2K19wYKxd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:20PM +0200, Paolo Bonzini wrote:
> This is the result of the summer project of Tanish Desai.  It mostly
> consists of changes to tracetool, which I used to add tracepoint support
> to the pl011 device.  All the backends are supported except dtrace and
> ust; support for Linux in dtrace should be easy using the "probe" crate,
> the rest (ust, and dtrace on macOS or Solaris) less so.  For ust, the
> plan is to deprecate it, since LTTng can use uprobes.  For dtrace on
> macOS or Solaris, support would have to be added to the "probe" crate.
>=20
> Patches 1-5 are cleanups that could be committed separately.
>=20
> Patches 6-7 are tracetool patches that have been posted before, now
> rebased on top of the "make check-tracetool" series.  Their purpose
> is to simplify .h code generation for tracetool backends, and these
> simplifications translate directly to the new .rs code generation.
>=20
> Patches 8-9 add the minimal support for adding tracepoint functions
> in Rust, albeit with no content and thus no actual tracing.
>=20
> Patches 10-11 add back tracepoints to the Rust pl011 device model.
>=20
> Patches 12-16 finally add Rust code generation to the supported
> tracing backends.
>=20
> The tracetool testsuite is now part of QEMU and is extended to
> cover the generated Rust code.

Looks very close. The main issue I noticed in the Rust code is that the
dynamic state of trace events is not being checked correctly
(trace_event_get_state_dynamic_by_id()).

>=20
> Paolo
>=20
> v1->v2:
> - new patch "tracetool: fix usage of try_import()"
> - new patch "tracetool: remove dead code" [Manos]
> - new patch "treewide: remove unnessary "coding" header" [Manos]
> - new patch "tracetool: add SPDX headers" [Manos]
> - dropped patch "treewide: write "unsigned long int" instead of "long uns=
igned int""
> - merge patch "rust: move dependencies to rust/Cargo.toml"
> - gathered Reviewed-by tags
> - sort keywords for primitive C types [Manos]
> - fix incorrect string "_{name}" in "tracetool: Add Rust format support" =
[Manos, Daniel]
> - adjust for moved crates
> - add SPDX headers to generated file [Daniel]
> - add @generated tag to generated file [Manos]
> - add #[allow()] to include_trace macro, in order to pacify clippy
> - tweaks to trace/Cargo.toml [Manos]
> - fix more clippy issues in generated code
> - change include_trace! macro to not require the "trace-" prefix [Zhao]
> - rename Clock::get() and get_hz() methods to period() and hz() respectiv=
ely [Zhao]
> - drop the "..._ENABLED" symbols [Daniel]
>=20
> Paolo Bonzini (8):
>   tracetool: fix usage of try_import()
>   tracetool: remove dead code
>   treewide: remove unnessary "coding" header
>   tracetool: add SPDX headers
>   trace/ftrace: move snprintf+write from tracepoints to ftrace.c
>   rust: qdev: add minimal clock bindings
>   rust: pl011: add tracepoints
>   log: change qemu_loglevel to unsigned
>=20
> Tanish Desai (8):
>   tracetool: add CHECK_TRACE_EVENT_GET_STATE
>   tracetool/backend: remove redundant trace event checks
>   tracetool: Add Rust format support
>   rust: add trace crate
>   tracetool/simple: add Rust support
>   tracetool/log: add Rust support
>   tracetool/ftrace: add Rust support
>   tracetool/syslog: add Rust support
>=20
>  docs/conf.py                                  |   2 -
>  docs/sphinx-static/theme_overrides.css        |   3 +-
>  include/qemu/log-for-trace.h                  |   4 +-
>  include/qemu/log.h                            |  44 ++--
>  tests/tracetool/ftrace.h                      |  28 +--
>  tests/tracetool/log.h                         |  16 +-
>  trace/ftrace.h                                |   1 +
>  trace/ftrace.c                                |  15 ++
>  util/log.c                                    |   2 +-
>  hw/char/trace-events                          |  14 +-
>  rust/Cargo.lock                               |   8 +
>  rust/Cargo.toml                               |   1 +
>  rust/hw/char/pl011/Cargo.toml                 |   1 +
>  rust/hw/char/pl011/meson.build                |   1 +
>  rust/hw/char/pl011/src/device.rs              |  57 +++--
>  rust/hw/core/src/qdev.rs                      |  33 +++
>  rust/meson.build                              |   2 +-
>  rust/trace/Cargo.toml                         |  19 ++
>  rust/trace/meson.build                        |  19 ++
>  rust/trace/src/lib.rs                         |  39 ++++
>  rust/util/src/log.rs                          |   2 +-
>  scripts/analyse-locks-simpletrace.py          |   1 -
>  scripts/modinfo-collect.py                    |   1 -
>  scripts/modinfo-generate.py                   |   1 -
>  scripts/oss-fuzz/minimize_qtest_trace.py      |   1 -
>  scripts/oss-fuzz/output_reproducer.py         |   1 -
>  .../oss-fuzz/reorder_fuzzer_qtest_trace.py    |   1 -
>  scripts/probe-gdb-support.py                  |   1 -
>  scripts/qapi/error.py                         |   2 -
>  scripts/qapi/expr.py                          |   2 -
>  scripts/qapi/gen.py                           |   2 -
>  scripts/qapi/parser.py                        |   2 -
>  scripts/qapi/schema.py                        |   2 -
>  scripts/qemu-plugin-symbols.py                |   1 -
>  scripts/qemugdb/tcg.py                        |   2 -
>  scripts/qemugdb/timers.py                     |   1 -
>  scripts/replay-dump.py                        |   1 -
>  scripts/tracetool.py                          |   1 -
>  scripts/tracetool/__init__.py                 | 201 ++++++++++++++----
>  scripts/tracetool/backend/__init__.py         |  43 ++--
>  scripts/tracetool/backend/dtrace.py           |   2 +-
>  scripts/tracetool/backend/ftrace.py           |  26 +--
>  scripts/tracetool/backend/log.py              |  22 +-
>  scripts/tracetool/backend/simple.py           |  17 +-
>  scripts/tracetool/backend/syslog.py           |  17 +-
>  scripts/tracetool/backend/ust.py              |   2 +-
>  scripts/tracetool/format/__init__.py          |   4 +-
>  scripts/tracetool/format/c.py                 |   2 +-
>  scripts/tracetool/format/d.py                 |   2 +-
>  scripts/tracetool/format/h.py                 |  18 +-
>  scripts/tracetool/format/log_stap.py          |   2 +-
>  scripts/tracetool/format/rs.py                |  71 +++++++
>  scripts/tracetool/format/simpletrace_stap.py  |   2 +-
>  scripts/tracetool/format/stap.py              |   2 +-
>  scripts/tracetool/format/ust_events_c.py      |   2 +-
>  scripts/tracetool/format/ust_events_h.py      |   2 +-
>  tests/tracetool/ftrace.rs                     |  40 ++++
>  tests/tracetool/log.rs                        |  44 ++++
>  tests/tracetool/simple.rs                     |  40 ++++
>  tests/tracetool/syslog.rs                     |  40 ++++
>  tests/tracetool/tracetool-test.py             |   2 +
>  trace/meson.build                             |   8 +-
>  62 files changed, 727 insertions(+), 218 deletions(-)
>  create mode 100644 rust/trace/Cargo.toml
>  create mode 100644 rust/trace/meson.build
>  create mode 100644 rust/trace/src/lib.rs
>  create mode 100644 scripts/tracetool/format/rs.py
>  create mode 100644 tests/tracetool/ftrace.rs
>  create mode 100644 tests/tracetool/log.rs
>  create mode 100644 tests/tracetool/simple.rs
>  create mode 100644 tests/tracetool/syslog.rs
>=20
> --=20
> 2.51.0
>=20

--/WMmduB2K19wYKxd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS+FkACgkQnKSrs4Gr
c8jUIgf/WKgfLrr76IeqDIAnRsXN9AAey8rk7oPrb3GlJbiGXJYOtwnT/1MvxC0n
uIIkpoxmmn7G5MzxEqe4IIJmZMyO65RIjCbmrAIaE5kFdMystKqpaZ1HzMXfraqM
buPhzWfwxK1SUec1IhHTdD6kACDrCYmgBLwlCjUl8+OJ/D7ogaBmcAswRoSac8f7
TbMgAFibBobp/TlGwZ0kpO/n2mrn+BfVwU4iOCQ53pLvBcOA3RKOId+mY2mx7YX9
GhFOivMBtizYhrPYFsjOWiF3voRnDqBAy1iwSC3/xTiIvffS3q9tQ+s67LSosmzc
h7tt3jgxNQ8SU7jg7hJdPkCmVPBR1A==
=K4Rx
-----END PGP SIGNATURE-----

--/WMmduB2K19wYKxd--


