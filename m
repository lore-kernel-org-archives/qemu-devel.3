Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A08CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yhc-0005wp-Sj; Wed, 01 Oct 2025 11:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yhC-0005C1-5z
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ygs-0004KL-PY
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AtwfewC0W/5ihxSVFelh9FcsG/N3htoCqe0sofW0HB8=;
 b=CF8iK7Tbxj6fZxv6dshfqIIC37i7Y/wTq7HF8poi9PakUKtqxGXD8NHk+l32syKc4ScRVK
 y01BSWz4zb8NzGAgfnWIv3ZZsuO5B2dAWVUj37k09e3XA+qagUTw4du8eOSvc9hhGinmeE
 IiTB4KAi9BZXh4RgafzJeGvrD4LQ8zg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-g-T2S4tWNomEh72Ud7IWoQ-1; Wed,
 01 Oct 2025 11:24:13 -0400
X-MC-Unique: g-T2S4tWNomEh72Ud7IWoQ-1
X-Mimecast-MFC-AGG-ID: g-T2S4tWNomEh72Ud7IWoQ_1759332252
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 887EB18512D9; Wed,  1 Oct 2025 15:24:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79E801800447; Wed,  1 Oct 2025 15:24:02 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:24:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 00/16] tracetool: add Rust support
Message-ID: <20251001152400.GA182593@fedora>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gRmtqzq3z7nBHQW+"
Content-Disposition: inline
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--gRmtqzq3z7nBHQW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 05:49:22PM +0200, Paolo Bonzini wrote:
> This is almost the same as v1, other than:
> - more dead code removal in patches 2 and 8
> - renaming a function in patch 8, and consequent change to test vectors
>=20
> It adds Rust support to tracetool and tracepoint support for the pl011
> device.  All the backends are supported except dtrace and ust.
>=20
> Patches 1-5 are cleanups.
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
> Paolo
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
>  scripts/tracetool/__init__.py                 | 202 ++++++++++++++----
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
>  scripts/tracetool/format/log_stap.py          |   4 +-
>  scripts/tracetool/format/rs.py                |  64 ++++++
>  scripts/tracetool/format/simpletrace_stap.py  |   4 +-
>  scripts/tracetool/format/stap.py              |   2 +-
>  scripts/tracetool/format/ust_events_c.py      |   2 +-
>  scripts/tracetool/format/ust_events_h.py      |   2 +-
>  tests/tracetool/ftrace.rs                     |  40 ++++
>  tests/tracetool/log.rs                        |  44 ++++
>  tests/tracetool/simple.rs                     |  40 ++++
>  tests/tracetool/syslog.rs                     |  40 ++++
>  tests/tracetool/tracetool-test.py             |   2 +
>  trace/meson.build                             |   8 +-
>  62 files changed, 720 insertions(+), 223 deletions(-)
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

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--gRmtqzq3z7nBHQW+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjdR48ACgkQnKSrs4Gr
c8hxuAgAhcuiB5WKkhyxKQ/n9ZI3UY0Mn8L2Bd5mnjPijpdiUXYdykS5DBnlMeqH
jHjeZg7UeI3W09sQyDYce9qPqGQRDf3QeLgUqYetSy68Q1KOZN/zKTboCkqqrniO
iBWrAGVu19N0Yq0zY2UCGvdzW6FjVm+if0vpHHedeS6bEOjhippV0z0cxbe10rZs
wrUWgJbqusQJstAAdk7rSHiAPBBnKfUnOu/puh2KRRD1b+O5n46FgQ8DHD9Kmp5t
u0t/iAT/9Mno9e2rbJy2L4FvErJMc6/XwHfsSYX/EYbsUSbgilotRij7+WlHXkN+
MiE6rnQPHEdkn/bErXAXqdW9qKO6Bg==
=PFEy
-----END PGP SIGNATURE-----

--gRmtqzq3z7nBHQW+--


