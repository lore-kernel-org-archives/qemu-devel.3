Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1639C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCOIN-0000zv-9g; Wed, 29 May 2024 14:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sCOIG-0000yf-ME
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sCOIF-0003fQ-0v
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717008298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDX3pah61y85ioBhwYqJPUZ3XqtpW/DrPtryXFXyVJA=;
 b=b8BR72dKXsPIY5j/pmLdISNCXtsPst0JaA9t3AU1aWe71GS4U1NCo/++a1COC6/rE6ay4D
 /g3DTjo8PoOdVe3wJXZ5VN8M4ZseQrFzJ7c820NdXOElleNmFlXVgRaTq6/ZzQo15YU7pO
 szxsOl1lrVIbKSwRM8Oo9hpDWej0zFQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-qulgZNRhNpqh5qUie8-cDg-1; Wed, 29 May 2024 14:44:52 -0400
X-MC-Unique: qulgZNRhNpqh5qUie8-cDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C87E6185A780;
 Wed, 29 May 2024 18:44:51 +0000 (UTC)
Received: from localhost (unknown [10.39.192.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44C05C15BB1;
 Wed, 29 May 2024 18:44:50 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQIC4gQmVycmFuZ++/vSI=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
Message-ID: <20240529184449.GE1203999@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527195944.GA913874@fedora.redhat.com>
 <ZlV+Su4hziCFymVt@intel.com>
 <20240528130518.GA993828@fedora.redhat.com>
 <D9370410-E32D-4235-8CF0-87E620398246@ynddal.dk>
 <Zlc3ONhFa90wdcQp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WI2LdRIDkH91IqDm"
Content-Disposition: inline
In-Reply-To: <Zlc3ONhFa90wdcQp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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


--WI2LdRIDkH91IqDm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:10:00PM +0800, Zhao Liu wrote:
> Hi Stefan and Mads,
>=20
> On Wed, May 29, 2024 at 11:33:42AM +0200, Mads Ynddal wrote:
> > Date: Wed, 29 May 2024 11:33:42 +0200
> > From: Mads Ynddal <mads@ynddal.dk>
> > Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
> > X-Mailer: Apple Mail (2.3774.600.62)
> >=20
> >=20
> > >> Maybe later, Rust-simpletrace and python-simpletrace can differ, e.g.
> > >> the former goes for performance and the latter for scalability.
> > >=20
> > > Rewriting an existing, maintained component without buy-in from the
> > > maintainers is risky. Mads is the maintainer of simpletrace.py and I =
am
> > > the overall tracing maintainer. While the performance improvement is
> > > nice, I'm a skeptical about the need for this and wonder whether thou=
ght
> > > was put into how simpletrace should evolve.
> > >=20
> > > There are disadvantages to maintaining multiple implementations:
> > > - File format changes need to be coordinated across implementations to
> > >  prevent compatibility issues. In other words, changing the
> > >  trace-events format becomes harder and discourages future work.
> > > - Multiple implementations makes life harder for users because they n=
eed
> > >  to decide between implementations and understand the trade-offs.
> > > - There is more maintenance overall.
> > >=20
> > > I think we should have a single simpletrace implementation to avoid
> > > these issues. The Python implementation is more convenient for
> > > user-written trace analysis scripts. The Rust implementation has bett=
er
> > > performance (although I'm not aware of efforts to improve the Python
> > > implementation's performance, so who knows).
> > >=20
> > > I'm ambivalent about why a reimplementation is necessary. What I would
> > > like to see first is the TCG binary tracing functionality. Find the
> > > limits of the Python simpletrace implementation and then it will be
> > > clear whether a Rust reimplementation makes sense.
> > >=20
> > > If Mads agrees, I am happy with a Rust reimplementation, but please
> > > demonstrate why a reimplementation is necessary first.
> > >=20
> > > Stefan
> >=20
> > I didn't want to shoot down the idea, since it seemed like somebody had=
 a plan
> > with GSoC. But I actually agree, that I'm not quite convinced.
> >=20
> > I think I'd need to see some data that showed the Python version is ina=
dequate.
> > I know Python is not the fastest, but is it so prohibitively slow, that=
 we
> > cannot make the TCG analysis? I'm not saying it can't be true, but it'd=
 be nice
> > to see it demonstrated before making decisions.
> >=20
> > Because, as you point out, there's a lot of downsides to having two ver=
sions. So
> > the benefits have to clearly outweigh the additional work.
> >=20
> > I have a lot of other questions, but let's maybe start with the core id=
ea first.
> >=20
> > =E2=80=94
> > Mads Ynddal
> >
>=20
> I really appreciate your patience and explanations, and your feedback
> and review has helped me a lot!
>=20
> Yes, simple repetition creates much maintenance burden (though I'm happy
> to help with), and the argument for current performance isn't convincing
> enough.
>=20
> Getting back to the project itself, as you have said, the core is still
> further support for TCG-related traces, and I'll continue to work on it,
> and then look back based on such work to see what issues there are with
> traces or what improvements can be made.

Thanks for doing that and sorry for holding up the work you have already
done!

Stefan

--WI2LdRIDkH91IqDm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZXd6EACgkQnKSrs4Gr
c8jhjQf8DEZ0OynlIzlgRoS73t60VxKt2NPNpdLUDwbNrX1T2Ge+07ipc1PzeTgi
rodfOWz/CWMWxSRU59JWCZnglBXayVJduKEBrUz0BmVj5cuqAPgQea3PG7GiU6gx
iXka3gH4Y2HwXj/mxm96KIDGyctcaOsh52Ani/mq33P7EbdUH5b0MzB3JYxxnVyP
scJ0WJ3V85GLoYq7lniElRGUF/TrFjUhAgeXtlijgzlt3nTx1l9yiiXTIrLGm5iM
4/s9sQSeY3Lhfjt0pmsRrhbMWoz5l2/q6Xig02lw1Pe91otWxPFsuDGkI0EU5nEj
ZcJEz2e0Jvi5F4tGWxu3cb+hdFtcFA==
=QUar
-----END PGP SIGNATURE-----

--WI2LdRIDkH91IqDm--


