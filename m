Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83ACC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzE82-0006Bh-8B; Mon, 31 Mar 2025 08:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzE7x-0006B7-3p
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzE7p-0005Gq-8Q
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743423616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRakDc7PqzvR6cPiRlYWPeF36XguxfG77r5itvmH1Js=;
 b=PZ6yhOx9C1XycX4e1iUYUG5Y0Prg9XwPr2o5371r6JgImFkMg7Qc7lvaV/HEi/WjJ08FrW
 0Y60tYfBEh6bvO3Le2JiIpLgBMvEZ9bR4PAnlUTpm9fzpt2jdfUCC9gtuhJ25s2ZlhPRF0
 qmmOLTgpJ9MSrpf5WFShwC0PkrlrFew=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-RMo1IX2kPyq0ehHLdWCLJg-1; Mon,
 31 Mar 2025 08:20:13 -0400
X-MC-Unique: RMo1IX2kPyq0ehHLdWCLJg-1
X-Mimecast-MFC-AGG-ID: RMo1IX2kPyq0ehHLdWCLJg_1743423611
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF6DA195608A; Mon, 31 Mar 2025 12:20:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE5571956094; Mon, 31 Mar 2025 12:20:09 +0000 (UTC)
Date: Mon, 31 Mar 2025 08:20:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Rust VMM <rust-vmm@lists.opendev.org>,
 QEMU Devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 VirtIO Dev List <virtio-dev@lists.linux.dev>,
 Bill Mills <bill.mills@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matias Vara Larsen <mvaralar@redhat.com>, Sergio Lopez <slp@redhat.com>
Subject: Re: Central repo for VirtIO conformance tests?
Message-ID: <20250331122008.GA190936@fedora>
References: <87semtpjrt.fsf@draig.linaro.org>
 <CAJSP0QXX-hpOJ_E1oaR6NcyvBnC2mVAwfd8NYUWTDqPrtctAuQ@mail.gmail.com>
 <Z-qHKUveoHc85koj@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1UzjfE4LHL1iuGco"
Content-Disposition: inline
In-Reply-To: <Z-qHKUveoHc85koj@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
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


--1UzjfE4LHL1iuGco
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 01:14:33PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 31, 2025 at 07:52:33AM -0400, Stefan Hajnoczi wrote:
> > On Mon, Mar 31, 2025 at 6:39=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> > > So what do people think? Where would be a good place for common test
> > > repository to live?
> >=20
> > Maintaining the tests alongside the VIRTIO spec seems like a good fit
> > to me. Here is information on how to create a GitHub repo under the
> > OASIS VIRTIO Technical Committee:
> > https://www.oasis-open.org/open-repositories/
> >=20
> > I don't see a reason to maintain the tests under QEMU or rust-vmm
> > unless they provide some unique project infrastructure that an
> > independent project would lack or need to reinvent.
>=20
> IMHO opening that very link above illustrates the reason why *NOT* to
> host this under OASIS. Any potential contributor is faced with a 4 page
> long blurb of all sorts of rules & legal requirements, including
>=20
>   "Each TC Open Repository shall be subject to a Contributor
>    License Agreement (=E2=80=9CCLA=E2=80=9D) by which all persons making =
repo
>    contributions into it are bound."
>=20
> Hosting anywhere else would be better from the POV of removing barriers
> to potential contribution.

I didn't notice the CLA requirement. I agree, it's better to host it
elsewhere.

Stefan

--1UzjfE4LHL1iuGco
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfqiHgACgkQnKSrs4Gr
c8imawgAupoyqxCLxGFaH4fb9FOtzqOvMBpqPWfWZ+2v3WsDyUGU2aVaWS01EwUp
nGP8qqrN7OO0ykPLqKPlLdNi5KT4reRDC00lZMU5dSmRUjiWpns8GzTvTsI2VLof
9vih/PdJ5NUPpSvpWfSHVJh6WGKeaqWb1lm03hDx/c4Ce9GUpTbGiGOqlkrDGcNK
YDe0f9qjGnpHAZB3aa2OPGWj6AAFrRuJn+DLFGsAsi8qJRdZk5ExEkys2s9QjL6y
l9V697MvY1v6qqUau5maQqUu0+tlIXRST2Y22xJRexwlguivjWDpuJEwGuMS6eBE
S84Y9haeM5aG78cmjMmBDLJCn01nWw==
=l7dj
-----END PGP SIGNATURE-----

--1UzjfE4LHL1iuGco--


