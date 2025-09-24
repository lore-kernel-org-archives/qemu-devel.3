Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A35CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Tx1-0000ep-H9; Wed, 24 Sep 2025 14:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v1Twx-0000eV-I9
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v1Twr-0001ah-2s
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758737430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oB5S7zxoTpmKsw54HjwSOc2fBSbL6GF/Mfg/lQF1PF8=;
 b=d94H9ny4MJFQFHjYvLk1yh++vR95BFnxFjaZy77kO+LybT2OIoDzkZikc5IQMPFBkhAXBG
 w1a6YuHp0f6QRkn58aTtSUXsPqDl8WWV4Ew2Zz1zOjAh2lPdTimLhB2dGQ1eUZfYtSI14L
 k0kXHm2ERng7/bSqyNpoJsbC0XxuWSM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-5ZV6OmCOODmgBSXXSDw6Jg-1; Wed,
 24 Sep 2025 14:10:27 -0400
X-MC-Unique: 5ZV6OmCOODmgBSXXSDw6Jg-1
X-Mimecast-MFC-AGG-ID: 5ZV6OmCOODmgBSXXSDw6Jg_1758737426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFB8F19560B1; Wed, 24 Sep 2025 18:10:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.176])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42B3D300018D; Wed, 24 Sep 2025 18:10:25 +0000 (UTC)
Date: Wed, 24 Sep 2025 14:10:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
Message-ID: <20250924181024.GB6015@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0eB/xxbpwEBxTWWE"
Content-Disposition: inline
In-Reply-To: <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--0eB/xxbpwEBxTWWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 09:13:15AM +0200, Paolo Bonzini wrote:
> On 9/23/25 21:23, Stefan Hajnoczi wrote:
> > > +    out('// SPDX-License-Identifier: GPL-2.0-or-later',
> > > +        '// This file is @generated by tracetool, do not edit.',
> > > +        '',
> > > +        '#[allow(unused_imports)]',
> > > +        'use std::ffi::c_char;',
> > > +        '#[allow(unused_imports)]',
> > > +        'use util::bindings;',
> > > +        '',
> > > +        '#[inline(always)]',
> > > +        'fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {',
> > > +        '    unsafe { (trace_events_enabled_count !=3D 0) && (_id !=
=3D 0) }',
> > > +        '}',
> >=20
> > This was translated to Rust from:
> >=20
> >    /* it's on fast path, avoid consistency checks (asserts) */
> >    #define trace_event_get_state_dynamic_by_id(id) \
> >        (unlikely(trace_events_enabled_count) && _ ## id ## _DSTATE)
> >=20
> > The _id !=3D 0 expression is incorrect. The purpose was to check whether
> > the trace event is currently enabled (i.e. dynamically at runtime).
>=20
> The expression is correct, but the function and argument names are not. It
> should be
>=20
> fn trace_event_state_is_enabled(dstate: u16) -> bool {
>      unsafe { trace_events_enabled_count } !=3D 0 && dstate !=3D 0
> }

The generated code is missing DTrace's SDT semaphore (see
generate_h_backend_dstate() in scripts/tracetool/backend/dtrace.py). The
conditional must be taken when a tool like SystemTap or GDB sets the SDT
semaphore. Right now it will not be taken because the conditional only
looks at _ ## id ## _DSTATE and not the SDT semaphore.

Stefan

--0eB/xxbpwEBxTWWE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjUNBAACgkQnKSrs4Gr
c8jytQf/Zf1cLvAmyM8YgtlQLYMevxz8WiWTRYkYMHh8MY+Il18whneNPwuWgpOz
jzPYnFpZWLEqoc9TdR38tRwms9ZvciV6yGDc6yZSr5ltaIVues/b+cowa24osEKr
WMHwjLkurIiPfKN7v/2mhlhCz1TTWzsvzJstGc0+KG5Jbcom2RGr8ULUh54nZCQD
ruPnTollGgsxDoScmK9S1ydmdfTSVWgKPmkjBjAGmmbck3HrduMFb4B07JSparnf
JYgEgVEqRO9v+gpxOzX5R9GUoVWL2QUPusDrVRyXbCF8UU9P3jCF6iiOArVgPwLC
8xMao3Unj78l/xeEF6f6v+IzuBwqow==
=L1kG
-----END PGP SIGNATURE-----

--0eB/xxbpwEBxTWWE--


