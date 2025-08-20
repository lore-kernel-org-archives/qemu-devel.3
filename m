Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B88CA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeUG-000350-Kz; Wed, 20 Aug 2025 04:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1uoeUD-00034c-MW
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 04:48:02 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1uoeUA-0003ot-KC
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 04:48:01 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 1BC3E1D0019D;
 Wed, 20 Aug 2025 04:47:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 20 Aug 2025 04:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1755679674; x=1755766074; bh=fdd6qstluf
 OR1IR3ecGHK1Iit+V07tWQ/FnYjEopR9A=; b=ccjezI8fAUYQXXams+vl7RoTkH
 lvD8jY+sHGbewQtJR1UYnSsJG6r1IKBkXUieCI7s/OJQ5+1Gq5VF96Y0297zvoFn
 Kdy62yFKDbZcaqwsUNOk0YkZOhu+GjIw97bQpvQcKthL75pRmCFiySsJNrSJ7uQw
 fRaIMoBDnZe5nXDcqXF5DvNyOW14dj7hPyh1vchgbo9MVADXiTIRpYw9pfl0R/Hj
 AGwSP5qdFOke18wHr0oIFuPl5daGVaa57untiZzHS/3i5QhX8vjwo010/Z23fKfr
 RqM9axXx5fQhDC9HVJu6AhQ1hBPBcFwMMUHqvJ103g3LFFctbVAVLaxsjVXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1755679674; x=1755766074; bh=fdd6qstlufOR1IR3ecGHK1Iit+V07tWQ/Fn
 YjEopR9A=; b=B/jVcldoahcp0HAMlMCSzfVku4rS8CSwxbM4bjjS8cKRT86nCpe
 48ihUeOSlymubaVB/ZAuWKKYDo44kGJd7kduOueIZ0Nk4GY4MoomCjoHtU1Q5fzB
 MdxlGMywTVAzSW4d40iy0x7V8dQ8mfthbiGq0zdbVq3oS187W2gj/IqC/GKsTRrT
 3muf8NV6uHg80bAIQQDKch9KxAOEA0pMiDDCWZouHDpwSz8s571jYj7AS4bkNvKD
 4h9qj0dIw3qaAkydo2o8l+T3rN/T+ke54gWPufxx8MoKC+BDXwqUtwwVbhcXXrzZ
 A21stnv4TQfZN89PVIwM6R6SaA3Wxc0FnAQ==
X-ME-Sender: <xms:uoulaGDveWasqO7olDATFPjk7OyjMshCXS5a4Rh-SagXm9BIv9_U-A>
 <xme:uoulaOAOaZVCLUmN0V1wHdyPSopmxwHmuMuxIT9Y2jGMgbcTr7n3wk4TwnBQyrDf1
 Z3tLacGpM1npA-nrg>
X-ME-Received: <xmr:uoulaMOIXpVAXHAYMGi4UJY20I6rZI-7ssVhZlJXrP-S3rMg9YRst33ka118hHsB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejledvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
 tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpefhteeigf
 fgkefhteejkeffvdegvdeghfeitdeilefgudejfedtteevffdvleefueenucffohhmrghi
 nhepshhpvggtthhruhhmqdhoshdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthht
 ohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvvhgvnhhsugestg
 hhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgr
 rhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
 dprhgtphhtthhopegrvghsthgvvhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegu
 rghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegusggrshhsvgihsehrvgguhh
 grthdrtghomhdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhr
 tghpthhtoheplhhvihhvihgvrhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhsth
 esrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:uoulaKO6Wn3AthfSj5QaN91XpDLfDpr5Cj0HFznYj3ic1OdtMdQXaA>
 <xmx:uoulaOIwFHzIJh5Scv-ZHiiun657FdeK2BTJsbW-pYCgdfD_egc5XA>
 <xmx:uoulaEpkRiSWkOpujkjvtWoCroBl81-rchDpsERkLY8SEIizUQmbKw>
 <xmx:uoulaKNuae5an5FY9s25b_Xkg2LJzjwAZ10Ez5fHuakP6RY1Bo-0qQ>
 <xmx:uoulaIoiZ06Jroofd1a4zsTW3D6rzGV9oCHQYIUPNqCUZWnWwUDSegaF>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 04:47:54 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 48BC214409BB; Wed, 20 Aug 2025 10:47:48 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, "Michael S. Tsirkin"
 <mst@redhat.com>, jasowang@redhat.com, Laurent Vivier
 <lvivier@redhat.com>, dbassey@redhat.com, Stefano Garzarella
 <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 stevensd@chromium.org, Fabiano Rosas <farosas@suse.de>, Alex =?utf-8?Q?Be?=
 =?utf-8?Q?nn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com
Subject: Re: [PATCH v7 6/8] tests/qtest: Add GET_SHMEM validation test
In-Reply-To: <CADSE00J61r4Wt94s6OfCqt9V8sVaisgDajvKEYFmG1FJKdVfng@mail.gmail.com>
References: <20250818100353.1560655-1-aesteve@redhat.com>
 <20250818100353.1560655-7-aesteve@redhat.com>
 <20250818231438.GA30271@fedora>
 <CADSE00J61r4Wt94s6OfCqt9V8sVaisgDajvKEYFmG1FJKdVfng@mail.gmail.com>
Date: Wed, 20 Aug 2025 10:47:45 +0200
Message-ID: <87zfbunzv2.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=202.12.124.149; envelope-from=hi@alyssa.is;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Albert Esteve <aesteve@redhat.com> writes:

> On Tue, Aug 19, 2025 at 12:42=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
>>
>> On Mon, Aug 18, 2025 at 12:03:51PM +0200, Albert Esteve wrote:
>> > Improve vhost-user-test to properly validate
>> > VHOST_USER_GET_SHMEM_CONFIG message handling by
>> > directly simulating the message exchange.
>> >
>> > The test manually triggers the
>> > VHOST_USER_GET_SHMEM_CONFIG message by calling
>> > chr_read() with a crafted VhostUserMsg, allowing direct
>> > validation of the shmem configuration response handler.
>>
>> It looks like this test case invokes its own chr_read() function without
>> going through QEMU, so I don't understand what this is testing?
>
> I spent some time trying to test it, but in the end I could not
> instatiate vhost-user-device because it is non user_creatable. I did
> not find any test for vhost-user-device anywhere else either. But I
> had already added most of the infrastructure here so I fallback to
> chr_read() communication to avoid having to delete everything. My
> though was that once we have other devices that use shared memory,
> they could tweak the test to instantiate the proper device and test
> this and the map/unmap operations.
>
> Although after writing this, I think other devices will actually a
> specific layout for their shared memory. So
> VHOST_USER_GET_SHMEM_CONFIG is only ever going to be used by
> vhost-user-device.

FWIW: I'm not so sure =E2=80=94 my non-upstream Cloud Hypervisor frontend f=
or
the crosvm vhost-user GPU device[1] uses the equivalent of
VHOST_USER_GET_SHMEM_CONFIG to allow the backend to choose the size of
the shared memory region, and I could imagine that being something other
devices might want to do too?

[1]: https://spectrum-os.org/software/cloud-hypervisor/

> In general, trying to test this patch series has been a headache other
> than trying with external device code I have. If you have an idea that
> I could try to test this, I can try. Otherwise, probably is best to
> remove this commit from the series and wait for another vhost-user
> device that uses map/unmap to land to be able to test it.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaKWLsQAKCRBbRZGEIw/w
olLzAQCxMThzx6fqf2Is6ur3DX7n4Jj7UT0XUYLDZyzm4W+V3wD+IaPXPbAzD5Mv
L7TinRw6T2ORv4exHBgH1XXATq0H4wY=
=lvbI
-----END PGP SIGNATURE-----
--=-=-=--

