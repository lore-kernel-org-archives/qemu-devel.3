Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338DDC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMDcO-0004mN-Cu; Mon, 02 Jun 2025 18:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDcM-0004kl-7e
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMDcJ-0003va-QY
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 18:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748903211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xBEGJqbH2+Z70g5MnEbjmNOetcpQfGIVk5i4aPi6Dw=;
 b=Bdawcw8QmyJ9vh774BneX9ta4pqzHxQc+8NF204s46cnG/lnU6PR0LgYxRfCQWM6RtUpJw
 K6FfzFeqI2y+GVMbvuR9Wci7baUonuymBBcdkWLHilZ+W6j1W4lAvEhUNsRp+Yvcjj7B+i
 MR23iz4DQIBCUZuYzMaOM/1C0DZnaZo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-uIicL1rIMfuUIwblQ1ReHg-1; Mon,
 02 Jun 2025 18:26:47 -0400
X-MC-Unique: uIicL1rIMfuUIwblQ1ReHg-1
X-Mimecast-MFC-AGG-ID: uIicL1rIMfuUIwblQ1ReHg_1748903206
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 931991954B2B; Mon,  2 Jun 2025 22:26:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.84])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2914319560AB; Mon,  2 Jun 2025 22:26:46 +0000 (UTC)
Date: Mon, 2 Jun 2025 18:01:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
	Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 1/3] trace/syslog: seperate cold paths of tracing functions
Message-ID: <20250602220119.GA320269@fedora>
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-2-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P/DWvKMc37UQ36TR"
Content-Disposition: inline
In-Reply-To: <20250601181231.3461-2-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--P/DWvKMc37UQ36TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 01, 2025 at 06:12:29PM +0000, Tanish Desai wrote:
> inline: move hot paths from .c to .h for better performance
> Moved frequently used hot paths from the .c file to the .h file to enable=
 inlining
> and improve performance. This approach is inspired by past QEMU optimizat=
ions,
> where performance-critical code was inlined based on profiling results.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/syslog.py | 36 +++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 7 deletions(-)

This commit description doesn't match what the patch does.

What is the purpose of creating a _syslog_trace_foo() function in the .c
file instead of calling syslog() directly from the .h file?

>=20
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/back=
end/syslog.py
> index 012970f6cc..52b8ff65ea 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -21,8 +21,12 @@
> =20
> =20
>  def generate_h_begin(events, group):
> -    out('#include <syslog.h>',
> -        '')
> +    out('#include <syslog.h>')
> +    for event in events:
> +        out('void _syslog_%(api)s(%(args)s);',
> +            api=3Devent.api(),
> +            args=3Devent.args)
> +    out('')
> =20
> =20
>  def generate_h(event, group):
> @@ -37,17 +41,35 @@ def generate_h(event, group):
>          cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event.name.up=
per())
> =20
>      out('    if (%(cond)s) {',
> -        '#line %(event_lineno)d "%(event_filename)s"',
> -        '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
> -        '#line %(out_next_lineno)d "%(out_filename)s"',
> +            '       _syslog_%(api)s(%(args)s);',
>          '    }',
>          cond=3Dcond,
>          event_lineno=3Devent.lineno,
>          event_filename=3Dos.path.relpath(event.filename),
>          name=3Devent.name,
>          fmt=3Devent.fmt.rstrip("\n"),
> -        argnames=3Dargnames)
> -
> +        argnames=3Dargnames,
> +        api=3Devent.api(),
> +        args=3D", ".join(event.args.names()))
> +
> +
> +def generate_c(event, group):
> +        argnames =3D ", ".join(event.args.names())
> +        if len(event.args) > 0:
> +            argnames =3D ", " + argnames
> +        out('void _syslog_%(api)s(%(args)s){',
> +        '   #line %(event_lineno)d "%(event_filename)s"',
> +        '            syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);=
',
> +        '   #line %(out_next_lineno)d "%(out_filename)s"',
> +        '}',
> +        '',
> +        event_lineno=3Devent.lineno,
> +        event_filename=3Dos.path.relpath(event.filename),
> +        name=3Devent.name,
> +        fmt=3Devent.fmt.rstrip("\n"),
> +        argnames=3Dargnames,
> +        api=3Devent.api(),
> +        args=3Devent.args)   =20
> =20
>  def generate_h_backend_dstate(event, group):
>      out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
> --=20
> 2.34.1
>=20

--P/DWvKMc37UQ36TR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg+Hy8ACgkQnKSrs4Gr
c8iVKAf/fqaZeSH/UyLZHTFstVFT+bja5eANwON+4sWxsRqE0XnMrpmapIspWsK9
99DH/bg0kYxnL7hmzMs7LNJ+2xasHAAC33ZHNkSZL7/Ovi8E8oy5M3lVfNYNRZOw
ot5QE1yxgqguYPE8mDkfJirmzDyn5igQYKWVQzZ8DHFcaNXUxtQB8QjiHPLdkWrt
exnjx4FxGfvTCe0VPWc4DIy0wtY3TC107hpnoaahjba7lR/gxLqS/7/Cd4eez2D1
W6mBI+78R3ANMcnqmjNd5Ve0iItKpdx3+0vIgcqHnxu08gU7koALBSW45+ifHNwT
XSoJBobpBhQnsE+1wvcEYj08Vd8wNQ==
=YBPj
-----END PGP SIGNATURE-----

--P/DWvKMc37UQ36TR--


