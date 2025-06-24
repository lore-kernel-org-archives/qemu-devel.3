Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89C8C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4lv-0003ZK-FY; Tue, 24 Jun 2025 10:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU4ls-0003VU-SV
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU4lp-0006p2-QV
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750775827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrgdCSOY0/ENgFs0SBOvzqtFAlOdUu37x4+Vh9AvB0Q=;
 b=jLMT0TYWp66VlAhBqjmaPplYd45qYzh2btmAlT6/IbnmIL2fr/HH6L+0ACzjWtCKekh2pn
 CUETLkT11olbAptCyMpEYMHxKbrNOfZSvzhUJ67l8K9NB04Friq4UJq+D1kF1A1ztj2Dbv
 7611VfFHxr5Lgnr4qh7PgoIQjMHNJpQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-qO2DG8FSMd2E9C9RiYfRVg-1; Tue,
 24 Jun 2025 10:37:04 -0400
X-MC-Unique: qO2DG8FSMd2E9C9RiYfRVg-1
X-Mimecast-MFC-AGG-ID: qO2DG8FSMd2E9C9RiYfRVg_1750775823
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F387D1809C8C; Tue, 24 Jun 2025 14:37:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71126180035C; Tue, 24 Jun 2025 14:37:02 +0000 (UTC)
Date: Tue, 24 Jun 2025 10:37:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH v2 2/3] tracetool: introduce generate_unconditional
Message-ID: <20250624143701.GA5519@fedora>
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
 <20250620143720.3143-3-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JCvKJgVdPyxHWdSd"
Content-Disposition: inline
In-Reply-To: <20250620143720.3143-3-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--JCvKJgVdPyxHWdSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 02:37:19PM +0000, Tanish Desai wrote:
> diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
> index ea126b07ea..89d54b9aff 100644
> --- a/scripts/tracetool/format/h.py
> +++ b/scripts/tracetool/format/h.py
> @@ -76,13 +76,17 @@ def generate(events, backend, group):
>          out('',
>              'static inline void %(api)s(%(args)s)',
>              '{',
> -            '    if (%(cond)s) {',
> +            api=3De.api(),
> +            args=3De.args)
> +       =20
> +        if "disable" not in e.properties:
> +            backend.generate_unconditional(e, group)
> +
> +        out('    if (%(cond)s) {',
>              '        %(api_nocheck)s(%(names)s);',
>              '    }',
>              '}',
> -            api=3De.api(),
>              api_nocheck=3De.api(e.QEMU_TRACE_NOCHECK),
> -            args=3De.args,
>              names=3D", ".join(e.args.names()),
>              cond=3Dcond)

Two thoughts:

1. nocheck isn't necessary anymore. The body of nocheck could be inlined
   here instead to simplify the generated code.

2. "if (%(cond)s) {" is only useful for backends that implement
   .generate(). For example, if only the dtrace backend is enabled then
   "if (trace_event_get_state(...)) {}" will be emitted unnecessarily.

Maybe backends should have a .condition() interface so that
scripts/tracetool/format/h.py:generate() can first collect a dict[cond]
-> backend. Then it iterates over the map, calling backend.generate()
within "if (%(cond)s) { ... }". That way only the conditions that are
actually needed are generated and multiple backends that have the same
condition will share the same if statement.

Stefan

--JCvKJgVdPyxHWdSd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhauA0ACgkQnKSrs4Gr
c8iOVggAmJjT4Tt4KFXR8/6a8dJesDwd4YEmHiFzqBTbMQWEEVRww1yve4uV/L/j
/Ub2CS7dn9GYiy43ReUW0AEhIlaEbAtFKyX3WKZFGdfXHqNvkv6WDXaex6aRP5vK
gU9c1N8jc6nl3ZPm0GdY7bvSHI2+/Tgow2QFB8U5SILhJoZmxWt02r6fL8GFcTqu
ai266GW7oMHnQDT2JJoYwcLw3e5R0YxDcV5e6JXQodGMatR1wYr89va8458rHyKv
joMtPq1H6GG2cFNwa24qtogOGmKMkWVF+dBvDeRmK98u9L3xgIHrdfkpOUexHu2s
230m/0dO5vn+cY3b5GPOowrg4fetrw==
=X9WX
-----END PGP SIGNATURE-----

--JCvKJgVdPyxHWdSd--


