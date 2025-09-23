Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF03CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18M8-0004WB-5z; Tue, 23 Sep 2025 15:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18Ld-0004Mo-QP
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18Lb-0004zO-46
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758654401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jLT8WlnZYF6IejL46+lC2i14Kr2kZPIxnVewAh36mzc=;
 b=JtFV77w9KKE7Bo41j3g3Y34lG6cAHe3wk/o5aGw311lJWHyaIZyO840v/3E6BmbwFzULrj
 8jbODrL+NdSWoH/JDD6YH4ivAXD5/wYKYT1o0rCqdUPjKC2mNKLkSiTLsQs9BYnTRa1B4u
 gy5upqf6g7QJCvJFLgfDngjJsQf/zFQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-thJEyRtfOdaLHC3BoqqKXg-1; Tue,
 23 Sep 2025 15:06:39 -0400
X-MC-Unique: thJEyRtfOdaLHC3BoqqKXg-1
X-Mimecast-MFC-AGG-ID: thJEyRtfOdaLHC3BoqqKXg_1758654397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE5B81956087; Tue, 23 Sep 2025 19:06:37 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43EEB1800451; Tue, 23 Sep 2025 19:06:37 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:06:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 03/16] treewide: remove unnessary "coding" header
Message-ID: <20250923190636.GJ509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NQkRc6C6Eauc/SIg"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-4-pbonzini@redhat.com>
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


--NQkRc6C6Eauc/SIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:23PM +0200, Paolo Bonzini wrote:
> The "-*- coding: utf-8 -*-" header was needed in Python 2,
> but in Python 3 UTF-8 is already the default encoding of
> source files.
>=20
> It is even less necessary in .css files that do not have UTF-8
> sequences at all.
>=20
> Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/conf.py                                   | 2 --
>  docs/sphinx-static/theme_overrides.css         | 3 +--
>  scripts/analyse-locks-simpletrace.py           | 1 -
>  scripts/modinfo-collect.py                     | 1 -
>  scripts/modinfo-generate.py                    | 1 -
>  scripts/oss-fuzz/minimize_qtest_trace.py       | 1 -
>  scripts/oss-fuzz/output_reproducer.py          | 1 -
>  scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py | 1 -
>  scripts/probe-gdb-support.py                   | 1 -
>  scripts/qapi/error.py                          | 2 --
>  scripts/qapi/expr.py                           | 2 --
>  scripts/qapi/gen.py                            | 2 --
>  scripts/qapi/parser.py                         | 2 --
>  scripts/qapi/schema.py                         | 2 --
>  scripts/qemu-plugin-symbols.py                 | 1 -
>  scripts/qemugdb/tcg.py                         | 2 --
>  scripts/qemugdb/timers.py                      | 1 -
>  scripts/replay-dump.py                         | 1 -
>  scripts/tracetool.py                           | 1 -
>  scripts/tracetool/__init__.py                  | 2 --
>  scripts/tracetool/backend/__init__.py          | 2 --
>  scripts/tracetool/backend/dtrace.py            | 2 --
>  scripts/tracetool/backend/ftrace.py            | 2 --
>  scripts/tracetool/backend/log.py               | 2 --
>  scripts/tracetool/backend/simple.py            | 2 --
>  scripts/tracetool/backend/syslog.py            | 2 --
>  scripts/tracetool/backend/ust.py               | 2 --
>  scripts/tracetool/format/__init__.py           | 2 --
>  scripts/tracetool/format/c.py                  | 2 --
>  scripts/tracetool/format/d.py                  | 2 --
>  scripts/tracetool/format/h.py                  | 2 --
>  scripts/tracetool/format/log_stap.py           | 2 --
>  scripts/tracetool/format/simpletrace_stap.py   | 2 --
>  scripts/tracetool/format/stap.py               | 2 --
>  scripts/tracetool/format/ust_events_c.py       | 2 --
>  scripts/tracetool/format/ust_events_h.py       | 2 --
>  36 files changed, 1 insertion(+), 61 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NQkRc6C6Eauc/SIg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS77sACgkQnKSrs4Gr
c8jwvgf/dFAHMxOV9e/hrAWIUVWrgb0DFUyd/nvhw8qpUgvPMCtow7HPSnnp1GrK
Liefn+uOo0R7RhWwqPLOFU0gJ75Nhf60j1tb0tHzyQKyEgqVzAmnvTy6HGDVtaTB
SlmXsbD3VBGsMhzs+CCMwUosb2G6gZKOJsakPcvxEgwEZLHQEyoHYobb7mTmBr+o
iqajS6/ts4u6AtPwOu4Rq0cu86l/CESZXA8LC+zd6aKLp+icMI18MiIbglHMjio1
Lse+/7do+jkzq2AUSMaEuxyhRqBqB/TvFABKOeiSFn2hx7y0RiuRjU8huAgAEGNH
Wt20QKz82rkHlv0L2IFKPEfS9bNIAw==
=N6Qe
-----END PGP SIGNATURE-----

--NQkRc6C6Eauc/SIg--


