Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72439C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 19:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNyy6-0006Mh-AI; Sat, 07 Jun 2025 15:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNyy4-0006MV-NE
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 15:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNyy2-0006Q8-Qn
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 15:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749323553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t00YIjzsNIYHLmGiMhTe9V3Pql7Pt0bmSYFK730tYIg=;
 b=M9Jylb9kVGrHZvOtZ/LR6dGTUYxif6KsgA7JTMB4AbvNL2CfcdZHSeq7qhOEuaHJnSjLT3
 mY1RSUIiN6TaQqK/5mGtg3FGKNGvhdTVfjE4PIbW8fzfV1cjN0OCHd+APwqKgK/WuHu3Dj
 1/YOdOYbYV3hlpHa3+Wit00d0SNC4Ok=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176--vr29Ci7ORypv5nd2OUOng-1; Sat,
 07 Jun 2025 15:12:29 -0400
X-MC-Unique: -vr29Ci7ORypv5nd2OUOng-1
X-Mimecast-MFC-AGG-ID: -vr29Ci7ORypv5nd2OUOng_1749323548
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC39A19560A2; Sat,  7 Jun 2025 19:12:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DF93195608F; Sat,  7 Jun 2025 19:12:27 +0000 (UTC)
Date: Sat, 7 Jun 2025 15:12:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: oltolm <oleg.tolmatcev@gmail.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
Message-ID: <20250607191226.GA554948@fedora>
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cd7Vo+GLtmoVpD+Q"
Content-Disposition: inline
In-Reply-To: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--cd7Vo+GLtmoVpD+Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 11:45:04AM +0200, oltolm wrote:
> Sorry, I forgot to cc the maintainers.
>=20
> The build failed when run on Windows. I replaced calls to Unix programs
> like =B4cat=B4, =B4sed=B4 and =B4true=B4 with calls to =B4python=B4. I wr=
apped calls to
> =B4os.path.relpath=B4 in try-except because it can fail when the two paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
>=20
> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> ---
>  contrib/plugins/meson.build         |  2 +-
>  plugins/meson.build                 |  2 +-
>  scripts/tracetool/__init__.py       | 15 ++++++++++++---
>  scripts/tracetool/backend/ftrace.py |  4 +---
>  scripts/tracetool/backend/log.py    |  4 +---
>  scripts/tracetool/backend/syslog.py |  4 +---
>  tests/functional/meson.build        |  4 +---
>  tests/include/meson.build           |  2 +-
>  tests/tcg/plugins/meson.build       |  2 +-
>  trace/meson.build                   |  5 +++--
>  10 files changed, 23 insertions(+), 21 deletions(-)
>=20
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index fa8a426c8..1876bc784 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -24,7 +24,7 @@ endif
>  if t.length() > 0
>    alias_target('contrib-plugins', t)
>  else
> -  run_target('contrib-plugins', command: find_program('true'))
> +  run_target('contrib-plugins', command: [python, '-c', ''])
>  endif
> =20
>  plugin_modules +=3D t
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 5383c7b88..cb7472df8 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -33,7 +33,7 @@ if host_os =3D=3D 'windows'
>      input: qemu_plugin_symbols,
>      output: 'qemu_plugin_api.def',
>      capture: true,
> -    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
> +    command: [python, '-c', 'import fileinput, re; print("EXPORTS", end=
=3D""); [print(re.sub(r"[{};]", "", line), end=3D"") for line in fileinput.=
input()]', '@INPUT@'])

On second thought, is print("EXPORTS", end=3D"") correct? Unlike the lines
coming from fileinput, there is no line ending. I though that .def files
look like this:

EXPORTS
  ...
  ...

So maybe end=3D"" should be dropped for EXPORTS to correctly format the
=2Edef file?

(I didn't have a Windows build environment to check myself, but it
should be easy to diff the before/after files to verify whether there
are any changes.)

Stefan

--cd7Vo+GLtmoVpD+Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhEjxoACgkQnKSrs4Gr
c8iogAf9GRipI1N0/ns5re2+Y73zmIbebpGN6Lf1lXmAKegAazzRjcmaxotN3HOq
XlbtGE8dxHAKVsqsxCIS01AE22ZUUsct4M8tQXNbZX+534t4ADKrjdbqFRFSMZU6
nVrll5dw1PkG1JQxD3DmA0j2Y5pCUL8ngZ45tJLSWU14gwsNV6r7EpxfcC/B9cFJ
US0QvhGA8Cl7p093YNsJ2MoH7JHeCLHNbNoN5YfIjm93dA/LcTR3L9wDgPTnOrVY
s8Hy5Atyu3bm3ezohR0Z/trDDKYz3cBvUUuajyBSiPIH11WoJD1AdR6cbWetm8Nt
y8VawQCvAcu8FjUZr5f6mh1MAdezSw==
=imGJ
-----END PGP SIGNATURE-----

--cd7Vo+GLtmoVpD+Q--


