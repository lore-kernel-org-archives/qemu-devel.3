Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9FEC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 14:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u29hc-0005Fq-4a; Tue, 08 Apr 2025 10:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u29hb-0005Fi-68
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u29hY-00064c-RZ
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744121598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHiNrwMuWg4UkdQtFcMWiRQPjdHzDVzNyEUjeNNQ14w=;
 b=GfFEgP5Bq1KmTrOYzjXiagBrV18QFW081eCW6lTknIDoEO7fINXtFm/xIy6kxrF8/KZymj
 vSU6u3leUlnfwVX8kVf6eczpP3DOuoLbBbByBddT1NcI5rpQ2Decry5o9opyHVkvusX3fS
 yrUhAMcKCHletcc9KxYhwMYiKZqwz0g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-fseex5jKPdSkhs2knPmVjA-1; Tue,
 08 Apr 2025 10:13:12 -0400
X-MC-Unique: fseex5jKPdSkhs2knPmVjA-1
X-Mimecast-MFC-AGG-ID: fseex5jKPdSkhs2knPmVjA_1744121591
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC5CD18007E1; Tue,  8 Apr 2025 14:13:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.136])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 324A01801747; Tue,  8 Apr 2025 14:13:10 +0000 (UTC)
Date: Tue, 8 Apr 2025 10:13:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
Message-ID: <20250408141309.GA549046@fedora>
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
 <c82ea7ec-7f53-4113-a4ee-95d215522d4d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CdWMuD4P744o+Y+M"
Content-Disposition: inline
In-Reply-To: <c82ea7ec-7f53-4113-a4ee-95d215522d4d@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--CdWMuD4P744o+Y+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 07:24:59AM +0100, Thomas Huth wrote:
> On 23/03/2025 22.35, Daan De Meyer wrote:
> > We have to make sure the array of bytes read from the path=3D file
> > is null-terminated, otherwise we run into a buffer overrun later on.
> >=20
> > Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support lo=
ading OEM strings values from a file")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879
> >=20
> > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > ---
> >   hw/smbios/smbios.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index 02a09eb9cd..ad4cd6721e 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
> >               g_byte_array_append(data, (guint8 *)buf, ret);
> >           }
> > +        buf[0] =3D '\0';
> > +        g_byte_array_append(data, (guint8 *)buf, 1);
> > +
> >           qemu_close(fd);
> >           *opt->dest =3D g_renew(char *, *opt->dest, (*opt->ndest) + 1);
>=20
> Please make sure to put the maintainers on CC: (done now, for the next ti=
me
> please see the MAINTAINERS file or use the scripts/get_maintainers.pl
> script), otherwise your patch might go unnoticed.

Michael, Igor, Ani: This patch is needed for QEMU 10.0. You are the
maintainers, please review this patch.

Thanks!

Stefan

--CdWMuD4P744o+Y+M
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf1LvUACgkQnKSrs4Gr
c8g8/wf9H48jlbHTCPIXmjB0g55GYI4AkLGfRDx9KIslnOuO1ViJuYddtR9JPTiK
xQrcruqQPktzRuZy6cS32+WO0eqJdtsGiMMPUzVRvbDymm1BHBfuFiUYr2bmbjtb
/5uea0TKNF12P0/XaFW8gP0atdhWpif1Yjf/9L5yO3QmUN7VyIB0f/tEh+Qympn5
pBBVw+f8e3q4x+nkv9DqfqQSA2zWrHFqANQ6SnaDx5T/SOtgAAHPDpyQe5ANf87y
x7MSuJVQGkGupUkj8SPlWFHBZpTTU1GL3+GBXT5X1vwhXtS8plaxjeyH7qhGIHR0
mUJSNnAdIfjJic2xcXQzmglbYKoQew==
=PB0M
-----END PGP SIGNATURE-----

--CdWMuD4P744o+Y+M--


