Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42894C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 19:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk6D1-0007jR-CX; Thu, 07 Aug 2025 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk6Cw-0007g9-0B
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk6Cr-0004UA-Ug
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754594595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uQtz4uDUhH2RW2kBoWjTCSOiZX/tYKTy5oSbhaLMAK0=;
 b=abqOS3MmYJPLudl3qdCKVbwH2tpcU9dR+eVdDl7Y/VmDZZPDgUMtnUJHBOx3fbhqjVQjgF
 ZEdTpwJynn04jHWUhg4eqBD75EnhFIAtykkZ54IdimXEEUE8uD50xn0mr3UgIOA+t/I9Tx
 ocLmLfe7nO2vzEdrkaEOiMfx4Rm034o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-Ml5HBynEP6yu-cj_gbaqLQ-1; Thu,
 07 Aug 2025 15:23:12 -0400
X-MC-Unique: Ml5HBynEP6yu-cj_gbaqLQ-1
X-Mimecast-MFC-AGG-ID: Ml5HBynEP6yu-cj_gbaqLQ_1754594591
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2254180035B; Thu,  7 Aug 2025 19:23:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 870D6180035C; Thu,  7 Aug 2025 19:23:10 +0000 (UTC)
Date: Thu, 7 Aug 2025 15:23:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
	Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH v2 1/2] tracetool: add CHECK_TRACE_EVENT_GET_STATE
Message-ID: <20250807192307.GD51368@fedora>
References: <20250806150539.2871-1-tanishdesai37@gmail.com>
 <20250806150539.2871-2-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oz0zCcGOFf62cnba"
Content-Disposition: inline
In-Reply-To: <20250806150539.2871-2-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--oz0zCcGOFf62cnba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 03:05:38PM +0000, Tanish Desai wrote:
> New attributed added in backends
> CHECK_TRACE_EVENT_GET_STATE which when
> present and is True wraps the code generated
> by generate function in check_trace_event_get_state
> check else it is outside the conditional block.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/__init__.py         |  1 -
>  scripts/tracetool/backend/__init__.py | 26 ++++++++++++++++-------
>  scripts/tracetool/format/h.py         | 30 ++++++++++-----------------
>  3 files changed, 30 insertions(+), 27 deletions(-)
>=20
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 2ae2e562d6..d0a02c45d7 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -332,7 +332,6 @@ def formats(self):
>          return self._FMT.findall(self.fmt)
> =20
>      QEMU_TRACE               =3D "trace_%(name)s"
> -    QEMU_TRACE_NOCHECK       =3D "_nocheck__" + QEMU_TRACE
>      QEMU_TRACE_TCG           =3D QEMU_TRACE + "_tcg"
>      QEMU_DSTATE              =3D "_TRACE_%(NAME)s_DSTATE"
>      QEMU_BACKEND_DSTATE      =3D "TRACE_%(NAME)s_BACKEND_DSTATE"
> diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/ba=
ckend/__init__.py
> index 7bfcc86cc5..4194719e52 100644
> --- a/scripts/tracetool/backend/__init__.py
> +++ b/scripts/tracetool/backend/__init__.py
> @@ -23,6 +23,8 @@
>  Attribute Description
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>  PUBLIC    If exists and is set to 'True', the backend is considered "pub=
lic".
> +CHECK_TRACE_EVENT_GET_STATE    If exists and is set to 'True', generate =
function
> +emits code inside check_trace_event_get_state check.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

The '=3D' table formatting is broken. Further down in the file there is an
example of a wider first column and how the second column cells wrap:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Function                        Description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
generate_<format>_begin(events) Generate backend- and format-specific file
                                header contents.

Please follow that style for consistency. You could also check reST
markup syntax alternatives like an unordered list if tables are too
clumsy.

> =20
> =20
> @@ -101,22 +103,32 @@ class Wrapper:
>      def __init__(self, backends, format):
>          self._backends =3D [backend.replace("-", "_") for backend in bac=
kends]
>          self._format =3D format.replace("-", "_")
> +        self.check_trace_event_get_state =3D False
>          for backend in self._backends:
>              assert exists(backend)
>          assert tracetool.format.exists(self._format)
> +        for backend in self.backend_modules():
> +            check_trace_event_get_state =3D getattr(backend, "CHECK_TRAC=
E_EVENT_GET_STATE", False)
> +            self.check_trace_event_get_state =3D self.check_trace_event_=
get_state or check_trace_event_get_state
> =20
> -    def _run_function(self, name, *args, **kwargs):
> +    def backend_modules(self):
>          for backend in self._backends:
> -            func =3D tracetool.try_import("tracetool.backend." + backend,
> -                                        name % self._format, None)[1]
> -            if func is not None:
> -                func(*args, **kwargs)
> +             module =3D tracetool.try_import("tracetool.backend." + back=
end)[1]
> +             if module is not None:
> +                 yield module
> +
> +    def _run_function(self, name, *args, check_trace_event_get_state=3DN=
one, **kwargs):
> +        for backend in self.backend_modules():
> +            func =3D getattr(backend,name%self._format,None)

Spaces are missing on this line: getattr(backend, name % self._format, None)

> +            if func is not None and (check_trace_event_get_state is None=
 or
> +                    check_trace_event_get_state =3D=3D getattr(backend, =
'CHECK_TRACE_EVENT_GET_STATE', False)):
> +                    func(*args, **kwargs)
> =20
>      def generate_begin(self, events, group):
>          self._run_function("generate_%s_begin", events, group)
> =20
> -    def generate(self, event, group):
> -        self._run_function("generate_%s", event, group)
> +    def generate(self, event, group, check_trace_event_get_state=3DNone):
> +        self._run_function("generate_%s", event, group, check_trace_even=
t_get_state=3Dcheck_trace_event_get_state)
> =20
>      def generate_backend_dstate(self, event, group):
>          self._run_function("generate_%s_backend_dstate", event, group)
> diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
> index ea126b07ea..0ceb49eef5 100644
> --- a/scripts/tracetool/format/h.py
> +++ b/scripts/tracetool/format/h.py
> @@ -59,33 +59,25 @@ def generate(events, backend, group):
> =20
>          out('    false)')
> =20
> -        # tracer without checks
>          out('',
>              'static inline void %(api)s(%(args)s)',
>              '{',
> -            api=3De.api(e.QEMU_TRACE_NOCHECK),
> +            api=3De.api(),
>              args=3De.args)
> =20
>          if "disable" not in e.properties:
> -            backend.generate(e, group)
> -
> +            backend.generate(e, group, check_trace_event_get_state=3DFal=
se)
> +
> +        if backend.check_trace_event_get_state:

This line can be indented...

> +            if "disable" not in e.properties:

=2E..and this duplicate "disable" check can be dropped.

> +                event_id =3D 'TRACE_' + e.name.upper()
> +                cond =3D "trace_event_get_state(%s)" % event_id
> +                out('    if (%(cond)s) {',
> +                        cond=3Dcond)
> +                backend.generate(e, group, check_trace_event_get_state=
=3DTrue)
> +                out('    }')
>          out('}')
> =20
> -        cond =3D "true"
> -
> -        out('',
> -            'static inline void %(api)s(%(args)s)',
> -            '{',
> -            '    if (%(cond)s) {',
> -            '        %(api_nocheck)s(%(names)s);',
> -            '    }',
> -            '}',
> -            api=3De.api(),
> -            api_nocheck=3De.api(e.QEMU_TRACE_NOCHECK),
> -            args=3De.args,
> -            names=3D", ".join(e.args.names()),
> -            cond=3Dcond)
> -
>      backend.generate_end(events, group)
> =20
>      out('#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
> --=20
> 2.34.1
>=20

--oz0zCcGOFf62cnba
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiU/RsACgkQnKSrs4Gr
c8hXMgf/cZO9uczbDQVTdCLdiI7ca0LNFVsa+udoFWIY+58peOxNT34V+wG2J27B
eaSfjC/ZWE/gcpP/qFW3+nc/0KZCdIFoHvlQWXetCVry6ZSHZihsqFNsTh98d47Z
mmoZohUFohx+2n6JMuWSUMzP86sIsemA04lIViCrEq9Re9BitfCg1Tk5OZhqWA6R
ot9wQrv/2fD8P993OMQfrKpqF3R8zdmpru/xXqXSWyN5ONbzAnrraGlMpBIoB6Qz
B/9X0cxloDsvfS2DlH75sunKk3wRBLFDaxZx/f8MDSFmadWQoTMZmEyJr5yz9B9o
UDgXnyr/M0X4HY31uuqVYp/zll61Ag==
=cHHP
-----END PGP SIGNATURE-----

--oz0zCcGOFf62cnba--


