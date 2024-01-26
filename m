Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB704C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTN6s-0006L6-2t; Fri, 26 Jan 2024 09:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rTN6p-0006Kj-Jk
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:23:07 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rTN6k-0005cF-SO
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:23:07 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 10E853200AFE;
 Fri, 26 Jan 2024 09:22:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 26 Jan 2024 09:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1706278978; x=1706365378; bh=wf0+TzwLLl
 fXB8rCG0Q8tZJ2VI+KFGaKxd+Fw2GpkYE=; b=G+b2Q3PznBdTsOWKaR60ETeYu6
 8RAwGxuILsYI8vMU5bMm777gQ7SubLa48m9cV9ixZuxlA7CJIVelNMwqXa9MUcF5
 bYKaD3O9ZGfmHf5DNNg7MfDSfPdQQ144oWlDegykdHfQ1Nutld+viwBrp7L62ni7
 Zx7F0j/e85LKVXxY20XCo5YVx+2ja1PO1ozQa0jEfIm3dYY/qKkOp8TJVBIIDgwt
 rp7K7Cv5D/kO5lJYRsd/u4YgXbPKbn1jrF68GhQ3S4YgFpToFRYOrBiHzYsHWSsh
 sqf2P8GMQm8+WjlENsW8NAdh4Qact+A0JkDMJGyN2/AwK9MPMUCVW+CWJAcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1706278978; x=1706365378; bh=wf0+TzwLLlfXB8rCG0Q8tZJ2VI+K
 FGaKxd+Fw2GpkYE=; b=Znem3q1N5jvgOFugJ3TCz/avhg409Yee0yyBfqNkwgK0
 Vw0CJT3RSA3e1MVV7koSxc7P0pvgCIDR5gl+1XSraANlSUfAkv2C6Wa5slO64ljd
 987I/LZmjnr4yw6WPH/Jmb/AZGQYxyikjSVHptSt10DL5VhNpSaAXyTNLGi0w958
 QtYr495Oh5rnGyrhW/47KnrCbZlyAtRqH9ICmacyy2Km/9YZ4/O8XoGtie+kvZ+q
 AtXVrdkwbb7TmAuY4dU4hQTPi1mSwcNMO1c0WXrC4G+9er+7yE4LUELoFsqWPs41
 +CwPqTE5GKpv2FT0gGVx5CyYlxdnF7aNnKMqVI6duw==
X-ME-Sender: <xms:QsCzZTteP20krJpgkBgKvLeuyO16mQO-IdjwBRIh5JZetmtoNHDaRQ>
 <xme:QsCzZUc9_sJEw6lE-juFgZzBeYCLwgA4imm0eOuErVY-baVFmhBy-aY_mGGWm5TgA
 qyFCxu-ah9MmU2GAA>
X-ME-Received: <xmr:QsCzZWw5InjwD17OxvV39OLiLJguORIxvoRFcX5g3APnZMHlz37C32Bw02ldCk8MP-rKEsYg_Uwd40n9oWIPBcoGzVSq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhs
 rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpedtve
 dtgfdvhfekteekffeltefhiefgvdejhffgvedvjeehgeehkedtveeugedtteenucffohhm
 rghinheprhgvughhrghtrdgtohhmpdhgohhoghhlvghsohhurhgtvgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihs
 shgrrdhish
X-ME-Proxy: <xmx:QsCzZSPnnMLvuVJov4DyKw_6rphDgKJT-w14-Gikcjv7qwZ9V6GePw>
 <xmx:QsCzZT-g_35anv_fP3oe4zUmd2Cnr33G9p1EFBrriTlAzkO1nEOIGQ>
 <xmx:QsCzZSVxypkbXUZZZ8RM5e7OOB7D_akQgwkJPnuhNNjPS8tWXqBM7A>
 <xmx:QsCzZaYWlpwhVzkg8OXkCxdHq-ataxNRSL165z4PYJ3KYeEwkIdQGw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 09:22:57 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id D8912C52F; Fri, 26 Jan 2024 15:22:54 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
 <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
 <87cytwnqoj.fsf@alyssa.is>
 <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
Date: Fri, 26 Jan 2024 15:22:47 +0100
Message-ID: <87msssmax4.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=64.147.123.21; envelope-from=hi@alyssa.is;
 helo=wout5-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> On Sat, Jan 20, 2024 at 4:19=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>>
>> > On Fri, Jan 19, 2024 at 1:13=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wro=
te:
>> >>
>> >> Hi Gurchetan,
>> >>
>> >> > Thanks for the reminder.  I did make a request to create the release
>> >> > tags, but changes were requested by Fedora packaging effort:
>> >> >
>> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2242058
>> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2241701
>> >> >
>> >> > So the request was canceled, but never re-requested.  I'll fire off
>> >> > another request, with:
>> >> >
>> >> > gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c ("gfxstream:
>> >> > manually add debug logic")
>> >> > AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 ("aemu: improve
>> licensing")
>> >> >
>> >> > as the commits.  These match the Fedora requests, and the AEMU one =
has
>> >> > been merged into Fedora already it seems.
>> >>
>> >> These revisions have the problem I mentioned in my previous message:
>> >>
>> >> >> The gfxstream ref mentioned here isn't compatible with
>> >> >> v0.1.2-rutabaga-release, because it no longer provides
>> logging_base.pc,
>> >>
>> >> rutabaga was not fixed to use the new AEMU package names until after =
the
>> >> v0.1.2-rutabaga-release tag, in commit 5dfd74a06.  So will there be a
>> >> new Rutabaga release that's compatible with these release versions of
>> >> gfxstream and AEMU?
>> >
>> > Good catch.
>> >
>> > One possible workaround is to build gfxstream as a shared library.  I
>> > think that would avoid rutabaga looking for AEMU package config files.
>> >
>> > But if another rutabaga release is desired with support for a static
>> > library, then we can make that happen too.
>>
>> We're exclusively building gfxstream as a shared library.
>>
>> Looking at rutabaga's build.rs, it appears to me like pkg-config is
>> always used for gfxstream unless overridden by GFXSTREAM_PATH.
>>
>
> Hmm, it seems we should be checking pkg-config --static before looking for
> AEMU in build.rs -- oh well.
>
> Would this be a suitable commit for the 0.1.3 release of rutabaga?
>
> https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf441=
38def886f47cb1c7c
>
> The gfxstream/AEMU commits would remain unchanged.

That combination works for me.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmWzwDcACgkQ+dvtSFmy
ccA/bA/9HViR04SiR6/J/fE+YY4bPoJrPJbefXtWcGONiBtUOLiWcWBts8sCKeo6
gFIYq332eOE/VdvIhAhI4DWf88RonhIIllzA5awBHJUVjp/NdP+FehxoaE22eaJf
VBhcwCsOI4BKbNyosjhJCAS3mDHEqWZJgNW4Fq/lJsDoTZ+5e0nvID6FkNv8z0GA
3WqZyUF9+0BjDHpGyy9WNSK8x+pG3wa1fxFqr51zdMAPSnk7pX1uHyHKQanEJS01
qtNnevB0fGRy/1c14qQWoIFFcc9d1dNd2aA53hOsudCCErahjnD4339FofFZquFV
g2KHJ+O8TKcPret2wumagjw8ahEzT/hZ02S3uUe8kWU/MXdwNmnQFwSyxdeBW39b
PthJ45ZAu3LbgCNTihWuYdAcsAqOj07KPYANVwPocYL7fj9XS9k0cATxTzeLEpSh
LyfhjpsnzjraQmS25drUetv1m2vPtyocLxh79UCg/yiw3V9+vF1T2S6RVOhxHIXL
qPSNwWTwCuf2GzyeLyGHzkTK/xnrDR6sPDqsVvIyyt94IoHajvz5nswleXW2kvgE
9wsCQnxjlsSg3FIgbwC3SL+9UQjJm89eZRpLQ3W9uldoMAlOEZiyvAlcsetHXHTd
k2PSxEXFxDLjSxvl6Lkesj9RlWYbvDQjR6OSW7vO/8O/ljERU38=
=Tcfe
-----END PGP SIGNATURE-----
--=-=-=--

