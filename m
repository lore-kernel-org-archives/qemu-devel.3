Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58909C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDcR-0004vr-Li; Mon, 02 Jun 2025 18:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDcO-0004oh-TS
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDcN-0003w4-67
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748903214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLn7ssdx8BCX2BCzpgIflQm/+Ee1to3sun7sZPDYLMw=;
 b=KrKUq+Y3mes7Cy6KBIAhijK5/Z++fJ/KSkgun0ieJ95WiqiQvWWp6gxDRurSTX1z9qfvPq
 cBCisqVPBCsOBo1lFJOqEtBHHkMKPa5EUe35pwbl715ZrV57K6Ad8/wogSAW3xEHu9DNLH
 nmip2CRCSgqz/EtJjF7L5ocQAerouuU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-q4GiK-iaMKG0aehQsEeHSQ-1; Mon,
 02 Jun 2025 18:26:49 -0400
X-MC-Unique: q4GiK-iaMKG0aehQsEeHSQ-1
X-Mimecast-MFC-AGG-ID: q4GiK-iaMKG0aehQsEeHSQ_1748903209
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABA7D1955DAB; Mon,  2 Jun 2025 22:26:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.84])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA8F330002C4; Mon,  2 Jun 2025 22:26:47 +0000 (UTC)
Date: Mon, 2 Jun 2025 18:24:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
	Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
Message-ID: <20250602222434.GB320269@fedora>
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-3-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gYZTh8ptLLO3NZd5"
Content-Disposition: inline
In-Reply-To: <20250601181231.3461-3-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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


--gYZTh8ptLLO3NZd5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2025 at 06:12:30PM +0000, Tanish Desai wrote:
> Moved rarely used (cold) code from the header file to the C file to avoid
> unnecessary inlining and reduce binary size.

How much of a binary size reduction do you measure? Most trace events
are only called once, so the difference in code size is likely to be
small.

> This improves code organization
> and follows good practices for managing cold paths.

It's easier to understand the code generator and the generated code when
each trace event is implemented as a single function in the header file.
Splitting the trace event up adds complexity. I don't think this is a
step in the right direction.

>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/ftrace.py | 44 +++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>=20
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/back=
end/ftrace.py
> index baed2ae61c..c9717d7b42 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -23,6 +23,10 @@
>  def generate_h_begin(events, group):
>      out('#include "trace/ftrace.h"',
>          '')
> +    for event in events:
> +        out('void _ftrace_%(api)s(%(args)s);',
> +            api=3Devent.api(),
> +            args=3Devent.args)
> =20
> =20
>  def generate_h(event, group):
> @@ -30,26 +34,42 @@ def generate_h(event, group):
>      if len(event.args) > 0:
>          argnames =3D ", " + argnames
> =20
> -    out('    {',
> +    out('        if (trace_event_get_state(%(event_id)s)) {',
> +        '           _ftrace_%(api)s(%(args)s);',
> +        '        }',
> +        name=3Devent.name,
> +        args=3D", ".join(event.args.names()),
> +        event_id=3D"TRACE_" + event.name.upper(),
> +        event_lineno=3Devent.lineno,
> +        event_filename=3Dos.path.relpath(event.filename),
> +        fmt=3Devent.fmt.rstrip("\n"),
> +        argnames=3Dargnames,
> +        api=3Devent.api()
> +        )
> +
> +
> +def generate_c(event, group):
> +        argnames =3D ", ".join(event.args.names())
> +        if len(event.args) > 0:
> +            argnames =3D ", " + argnames
> +        out('void _ftrace_%(api)s(%(args)s){',
>          '        char ftrace_buf[MAX_TRACE_STRLEN];',
>          '        int unused __attribute__ ((unused));',
>          '        int trlen;',
> -        '        if (trace_event_get_state(%(event_id)s)) {',
>          '#line %(event_lineno)d "%(event_filename)s"',
> -        '            trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
> -        '                             "%(name)s " %(fmt)s "\\n" %(argnam=
es)s);',
> +        '       trlen =3D snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
>          '#line %(out_next_lineno)d "%(out_filename)s"',
> -        '            trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);',
> -        '            unused =3D write(trace_marker_fd, ftrace_buf, trlen=
);',
> -        '        }',
> -        '    }',
> -        name=3Devent.name,
> -        args=3Devent.args,
> -        event_id=3D"TRACE_" + event.name.upper(),
> +        '                       "%(name)s " %(fmt)s "\\n" %(argnames)s);=
',
> +        '       trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);',
> +        '       unused =3D write(trace_marker_fd, ftrace_buf, trlen);',
> +        '}',
>          event_lineno=3Devent.lineno,
>          event_filename=3Dos.path.relpath(event.filename),
> +        name=3Devent.name,
>          fmt=3Devent.fmt.rstrip("\n"),
> -        argnames=3Dargnames)
> +        argnames=3Dargnames,
> +        api=3Devent.api(),
> +        args=3Devent.args)
> =20
> =20
>  def generate_h_backend_dstate(event, group):
> --=20
> 2.34.1
>=20

--gYZTh8ptLLO3NZd5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg+JKIACgkQnKSrs4Gr
c8hvXwf/ctvTjpu8D0tZ2kzM2JqLlCschu73gHxKLuWahVjiqh0cdDv1T0a8T550
2fRgvRai2gqd8c0w7vabB8NdSsNqpwdnN9aJ1vJZjtYb3ZCRMnFxB9aj8kuDZOIJ
7i9OgaMW94borNSIWQQGwf0cWvCeh4CiIDF1IjYdsC04ujblsWUVX3NE9j6coN5u
J5prOkOt67XdNYd07zWux0029Hhwbj4WFU60SP6I8apkpiXof6Ueb93M7nhlcp8A
wNQJFoIPRZPoEV7879FioDn/arnlZdthvZeQk+W6I1tiK4wMY82V9H3meqqb86/O
ttMgB0h6fu+j+KnfHZCyjepizfqlCQ==
=C68M
-----END PGP SIGNATURE-----

--gYZTh8ptLLO3NZd5--


