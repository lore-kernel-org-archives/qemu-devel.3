Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB221C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxae-0001KG-Q5; Tue, 28 May 2024 10:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBxad-0001JS-3I
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBxab-00087o-Lc
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716905648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7Ud10jNcbkX6MYTfuXp5eL+xOHOvA4Pk/yEuZidcVY=;
 b=Bu0tm+9GRWa43m2qc6ww5tHW3h48Qta5oLeq+8t48nM6kjeoKOVavoRUVVODef+KudW7SZ
 QeZYO/Lw3MH9xIWoZ7HcNaec/KuXXPlI9vczDl9eyyujHm9VIsofX3dchhfSchYxg99m+C
 nSIuczbOn32F/U0vVcAHz1/1aYKeUvg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-aCFrG2PtNHCtZN8irSNSng-1; Tue,
 28 May 2024 10:14:03 -0400
X-MC-Unique: aCFrG2PtNHCtZN8irSNSng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B30D29AA382;
 Tue, 28 May 2024 14:14:03 +0000 (UTC)
Received: from localhost (unknown [10.39.195.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEAB73C27;
 Tue, 28 May 2024 14:14:02 +0000 (UTC)
Date: Tue, 28 May 2024 10:14:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo framework
Message-ID: <20240528141401.GB993828@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-2-zhao1.liu@intel.com>
 <20240527200504.GB913874@fedora.redhat.com>
 <ZlWNk46MF5uNa+ZC@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dio/WzXmXdOFsWee"
Content-Disposition: inline
In-Reply-To: <ZlWNk46MF5uNa+ZC@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--dio/WzXmXdOFsWee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 03:53:55PM +0800, Zhao Liu wrote:
> Hi Stefan,
>=20
> [snip]
>=20
> > > diff --git a/scripts/simpletrace-rust/.rustfmt.toml b/scripts/simplet=
race-rust/.rustfmt.toml
> > > new file mode 100644
> > > index 000000000000..97a97c24ebfb
> > > --- /dev/null
> > > +++ b/scripts/simpletrace-rust/.rustfmt.toml
> > > @@ -0,0 +1,9 @@
> > > +brace_style =3D "AlwaysNextLine"
> > > +comment_width =3D 80
> > > +edition =3D "2021"
> > > +group_imports =3D "StdExternalCrate"
> > > +imports_granularity =3D "item"
> > > +max_width =3D 80
> > > +use_field_init_shorthand =3D true
> > > +use_try_shorthand =3D true
> > > +wrap_comments =3D true
> >=20
> > There should be QEMU-wide policy. That said, why is it necessary to cus=
tomize rustfmt?
>=20
> Indeed, but QEMU's style for Rust is currently undefined, so I'm trying
> to add this to make it easier to check the style...I will separate it
> out as a style policy proposal.

Why is a config file necessary? QEMU should use the default Rust style.

Stefan

--dio/WzXmXdOFsWee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZV5qkACgkQnKSrs4Gr
c8jjzwgAmRqu6LMO7NFyY9BFQPLKVffuB2cafuN/p70YeCfuoCBrd4+bgeJbkzAJ
Sx2jlUcTd+wbe5W8AxXNfcpR+2og0jMdImEpXndf3RENqj95BxHjl02kjxJw4/CJ
WnrDb2EhiAX+b6C2/aNEmwcYqQAt6+HeQFR6yIPqqPQYweva7/rgb5+mJqoyHI/l
z/yAvPfSqPWjeeqf0b069IKdwbR8xC/51UI+mKCpP8r2NUAgzr6NomgwnzbC2885
ndQJVAiUhxBek6AhwG3uRyG2eOMMY4CcpI+1Pg8btjzrwFlIzL1cUs+zKNmkBLpI
M38Poi8VAu1ushiv2A0iNr1617jSOg==
=KO2k
-----END PGP SIGNATURE-----

--dio/WzXmXdOFsWee--


