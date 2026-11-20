Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3AE606A333
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A629U9Xl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUP0u-0004H9-BH; Fri, 20 Nov 2026 08:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@amutable.com>) id 1xUKh5-0000xa-Dz
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 04:14:07 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex@amutable.com>) id 1xUKh3-0003NU-D7
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 04:14:07 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c5126505cb3so97221666b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 01:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795166043; x=1795770843;
 darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qmTWnPiha50atRJZLd6Dio/J7d+9bYvjQFHLyBlKNp8=;
 b=A629U9XlLyi02trx2SzSvtAHDCkNn/tvaZom8F8SS/5/GTYYwK/pKqKvhi/vyq6Gyx
 ecWywEOAmW2zACcBrBqIUXNSKDURjLcYJHvDEFKChLqHig2yK6ou9i8Ll2X5ezwpuS9s
 lw1Mdr1zxEBtami5Ot4+FpkpQLGp/lIPxsBfv1aCcoofwg3a87/GqYN5wdEe15nossu9
 eHUnK+RxS+1f0w22yjB8jtKbXyS0mXTuH1R+pFNmLETACLULr7JZjtqDFqVCcZxrlFH3
 2JodbxHvWEAspCYQdWY9s5rdKKptMA1AJBNeqo2bAnAQXyRQ65rbFVgSgAvrAVLENttZ
 WVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795166043; x=1795770843;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qmTWnPiha50atRJZLd6Dio/J7d+9bYvjQFHLyBlKNp8=;
 b=X/2pmcI+A9EXi0sbqQh5yAFUX5KZ0ABArZ9Vb4EFNXgeGI7/thgutuC0dd8KL+Iekv
 Y7AIRz3D7F6uht31wtxx8MROLZ1SxvyMgmnefX33KeW2lnWechQQiFClPMNKwyizHsbw
 0Arsd/lIHHckuGBFGQjP9RCcpQytW4fORwy/TlPelLZSqml4b6iAqg9gT8DXT8Xsl/dI
 zvBybC0zLL1kiqN1lZCEIOr+2+MuOIA0MNE/xG65SCfxGGy9gwvThfQqXMyz5XcglkZh
 1jBgiiWKqsXOeLKYHXU4tGJUCrvw3qOTW7YU/gnw8OO/pS+Dnzmi/S52eKcPFt6Bxt/Q
 nCSw==
X-Forwarded-Encrypted: i=1;
 AL+hErFi671dakVX4UoXfDJLDydZSZHGypQRjZpxYtXuaL7u/vqoA6hPbauEILlfKm2d8kkJZuN35Y0NqQ2z@nongnu.org
X-Gm-Message-State: APuU4Z8qwCnUf92TpP08Nuj0MDDJ5Cngo8QsPZFLldMHYtQPb4RoWx7E
 Cx4FWyCsEKMDuKlAdlemg7YX6W1oza8xYGOEh6UfanH6Nl7KfbiHSG1Id+6okj2m9ovc
X-Gm-Gg: AYBFou3XM2WOjhwrc6DQaJ79/b8u24cU1/tPSjP0P+9uf8roc0E0xSeYUov8V875gHZ
 8a+jnM/EbyhJ0WZm5r8r5HZaKfEIRt0SuTw5Wb46VfEjXTDLYbyM4K85H/qsd9iuabMh+G2Im9a
 +7U9/74ZHWENlQn51tpC4ME+gCow4qM5nXgl8/qyXiHrBNa2l6VHHkZYCmdPlj4YUvQYwxqB8Y0
 TLfr0VMbcwJga0SqiMi4VtKeV+qzgIDTGB4iB0ZsndPg33d+WNUDKoaOMtjzpxax+ro05WvCyHo
 bmHmgalUyitWI4LKEd4IUq3IsffxBhWiL3rjKl75IZfILjJAFM27pWfnavqwPajlrZ0YVsftTvb
 UvzuNzpX3aWdRZUs/m1jclBZJDnQ62rQnx9sBulIsO3LDo+5ycr6qjtQD7z1e6IRzO7xFRe6Zgr
 qemTl0yHmFN/A3Hb3loHcc37mtOnjgCn25gU5fXWhK7uoZU4j0ygNa/+neWZjAzlPqdwUSDC6Je
 mlujPxciull5Xx5PMpazIDPtWkwK0PYLiLaNT3ra5Kiq2Y31L+1BFvlu9LDxPHIDaaFVDm+MbFo
 +GV72axzzzk3xyGYc6xzWPkLC35Bsq1V0BwmcQK1IQSV/bHDToxIMg24pjxDLza7rsN5tWSg/OQ
 k9uRobAjYCeo=
X-Received: by 2002:a17:906:c10e:b0:c41:5e31:5184 with SMTP id
 a640c23a62f3a-c513a99abe6mr240332266b.13.1795166043196; 
 Fri, 20 Nov 2026 01:14:03 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com.
 [80.187.84.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afec177sm76505466b.72.2026.11.20.01.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 01:14:02 -0800 (PST)
Message-ID: <2ca9134951ab6f43be86be07f3721e52c2b3a25f.camel@amutable.com>
Subject: Re: [RFC PATCH] tests/functional: add migration diagnostics and
 pace nvme activity (HACK!)
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Peter Xu <peterx@redhat.com>, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:nvme" <qemu-block@nongnu.org>
Date: Fri, 20 Nov 2026 10:14:01 +0100
In-Reply-To: <av9FeuY9pnYHXblq@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260921190345.1709227-1-alex.bennee@linaro.org>
 <asZIy2Rm8QF4TSca@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxJF4tgfRYrm27rGivP-HyLUX=YCNUiaFqq4nDq0a5pQ@mail.gmail.com>
 <as6RsuZP6jkZ8twC@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrpQLJtXptSURtnT4xo4LJTduhksqAKnoPHCHbbfdVhW0w@mail.gmail.com>
 <as_rOWkhyPnWsMfL@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAJqdLrqxmTQeSUziBAtuhb94mVEjU1G_oEx1N1sLwKT3O=gDTA@mail.gmail.com>
 <av9FeuY9pnYHXblq@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex@amutable.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Nov 2026 08:50:47 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-19 at 13:52 -0500, Peter Xu wrote:
> On Wed, Oct 21, 2026 at 06:06:46PM +0200, Alexander Mikhalitsyn
> wrote:
> > Am Mi., 14. Okt. 2026 um 22:51 Uhr schrieb Peter Xu
> > <peterx@redhat.com>:
> > >=20
> > > On Wed, Oct 14, 2026 at 10:18:45AM +0200, Alexander Mikhalitsyn
> > > wrote:
> > > > > - for this test, should we remove snapshot=3Don but instead
> > > > > create an
> > > > > =C2=A0 explicit overlay that will be used on both src/dst qemu?
> > > >=20
> > > > This should solve the issue too, at the same time if test is
> > > > R/O I'm
> > > > not sure if we really need this.
> > >=20
> >=20
> > Dear Peter,
>=20
> Hi, Alexander,

Hi Peter ;-)

>=20
> >=20
> > sorry for such a long delay with reply. Was busy plumbing some
> > other stuff :-(
>=20
> Same here. :(
>=20
> Let's fix this first, or it'll be forgotten!

I agree!

>=20
> >=20
> > > Then.. maybe no need to bother. :)
> > >=20
> > > I think we should better remove snapshot=3Don no matter what, then
> > > whoever
> > > sends a patch add migration blocker for it won't fail this test.=C2=
=A0
> > > Seems the
> > > /tmp mount is still needed then.
> >=20
> > Yeah, if we really gonna make snapshot=3Don to be a migration blocker
> > (which seems
> > like a clean way to protect users from doing weird stuff like I
> > accidentally did in my test :-D).
> >=20
> > I need to look on the option you've earlier suggested with
> > "explicit
> > overlay that will be used on both src/dst qemu".
> > I'll get back to you ;-)
> >=20
> > Btw, does my fix with mounting tmpfs actually solves the problem
> > for
> > you? I'm just curious,
> > because I wasn't able to reproduce the problem locally tho... And
> > if
> > so, then probably we should
> > land this tmpfs-mount change for now, while we can prepare a better
> > and generic fix to get rid of snapshot=3Don,
> > add migration blocker for it and so on. WDYT?
>=20
> I agree.
>=20
> I tested your patch, it works for me, used to fail almost certainly
> but now
> it passes in a seq of runs.=C2=A0 I just thought it wasn't a good enough
> fix,
> but considering my poor speed on reply (which is this one me to
> blame), I
> think we should fix it first.
>=20
> You can send a formal patch and attach:
>=20
> Tested-by: Peter Xu <peterx@redhat.com>

Sure, let me send a patch on the weekend then ;-)

P.S. Then we can plan to do some more work to add a migration blocker
for "snapshot=3Don" case you've mentioned. But I'll certainly need some
guidance to do it right, cause I'm not that yet familiar with the code.

Kind regards,
Alex

>=20
> Thanks,

