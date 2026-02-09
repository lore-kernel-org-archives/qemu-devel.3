Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EE3E81BB1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 13:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpROz-0004i2-Il; Mon, 09 Feb 2026 08:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vpROx-0004ho-Ts
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 08:34:08 -0500
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vpROv-0007Li-V1
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 08:34:07 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DADEA14000F2;
 Mon,  9 Feb 2026 08:34:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 09 Feb 2026 08:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1770644043; x=1770730443; bh=fJtYQ5wMI8
 fG1u+3xZ/vaQtPBMltxkyXZFL+6r4IElw=; b=bUovGtYHoEG3/IUmhiIyPn3J/3
 /foPFx0VW77j1iM2iysxn9pdns6zBs0lmIgUvn8uOp5STkdB9bSpRE/Ga/9mfuHr
 w8cMemUi6e4pCrnZmm9Xl+t1zlvdhC/VO5LqOgCO97A/GgAl3an2mU28v72eqObf
 AEq36ylAQxlBXkhuCAingmrseWdSoCoxtnhk2S34NCBSpPVhTMm8veRdTLFuyJBW
 Vxl23FoUY5Ihx+eiopTP04VAJsMi/Bet5F4Qn5MbKAEZ/kpyoRCeb0gMIY8IsNED
 4lUq93NG2VjgSMABJpZ6rlwOnBPe1MCWY8WTnVnEx3jmsdE+QRMEblNkU+Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1770644043; x=1770730443; bh=fJtYQ5wMI8fG1u+3xZ/vaQtPBMltxkyXZFL
 +6r4IElw=; b=rCfM6defbnyiu6rftXi3MdziF83kg4mHwFwnWOj/+ltQ2QWRnLO
 9DdFwjGIJroK2T7NWc4S7ZTI6XproI9r+shoFQbQ0dcECvtEJzlG442YQpAUdRbf
 9vh2ZpJDrMKPjlV9tAUpnnYm293If1HfOZ/SBLFzDV50onFpn4F+73TTswSm2E93
 XAl9+0WSNWwaP+lVFuVPGWEUPvp5O4jWNcUGo2bn9NENFBspkI0yerRnP2vSe7vu
 K0f12+GvoxVN5/JGM6DnzwSFl6a2+/ny1yblv4o4LCxGKGr3JgyfPcKCY+CGQYGW
 V2iGReJBgv80+hE402tN87o4tKksUzy3YyQ==
X-ME-Sender: <xms:S-KJaY3xFq0W7dgvNcZZJM0k-feEN_GO2Fnh33zWER-BqlJXfQAWSQ>
 <xme:S-KJaYrmePeHt-8LytfKEDNzYFrC5HOmAks4W64JxUiHD3aObd-Lh16YyiMJeeo2A
 g_gCStV_uBR-dUqtrK5B1hz-oNj469T6Hia_VBIw3H42fzYXbYNkg>
X-ME-Received: <xmr:S-KJaaesI0VaxWt1ie-22c4jv3JyvLxWZm9S6E8KWctIq3sS2et8buNGtxNU9KlVfNRpnvakC-7f9k_KbnK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeileegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
 tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeetheevud
 fgjefghefhieejudelkeeljeegvdekueeuhffhgedvveefteevgeetieenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
 hishdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehsthgvvhgvnhhsugestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprghlvgigrd
 gsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrnhhoshdrphhithhs
 ihguihgrnhgrkhhisheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhhihhlmhguse
 hlihhnrghrohdrohhrghdprhgtphhtthhopehpihgvrhhrihgtkhdrsghouhhvihgvrhes
 lhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuh
 drohhrghdprhgtphhtthhopegrvghsthgvvhgvsehrvgguhhgrthdrtghomhdprhgtphht
 thhopegusggrshhsvgihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghsohifrg
 hnghesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:S-KJaSvLyFjewdQ4l88BAGQ5p07Uk8XM-Sgn-iisMI1ratPgokAt0g>
 <xmx:S-KJaSU_pz-cfMrYsEnFMv9jiwAIyvGThfzXagIzikAx_Z325HZhwg>
 <xmx:S-KJaX9sc3or5ENzWOZTL2IvzvU1Tz1vWJLz81MuC3S4ybbdlw8vtQ>
 <xmx:S-KJae6Jss2gPVkhtF-j3-aGH4EJvH1S7Fak47uEoGdu-B9urbts8w>
 <xmx:S-KJaWtkamf9SFAJPBBUPsAquY1K9OkiVH68Uwvf_bfKUKp6uygnKMCD>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 08:34:03 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 60B0473DF568; Mon, 09 Feb 2026 12:39:22 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, slp@redhat.com, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, manos.pitsidianakis@linaro.org,
 stevensd@chromium.org, dbassey@redhat.com, Stefano Garzarella
 <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>,
 stefanha@redhat.com, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v12 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
In-Reply-To: <CADSE00+gUyRdKpkx910Um0KtS=LkzRhrq2h4hA2irPmrZvUs=w@mail.gmail.com>
References: <20260204093758.1250167-1-aesteve@redhat.com>
 <20260204093758.1250167-4-aesteve@redhat.com> <87a4xnl2gr.fsf@alyssa.is>
 <CADSE00+gUyRdKpkx910Um0KtS=LkzRhrq2h4hA2irPmrZvUs=w@mail.gmail.com>
Date: Mon, 09 Feb 2026 12:39:15 +0100
Message-ID: <871piu5eos.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.154; envelope-from=hi@alyssa.is;
 helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Sat, Feb 7, 2026 at 8:05=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>>
>> Albert Esteve <aesteve@redhat.com> writes:
>>
>> > Add GET_SHMEM_CONFIG vhost-user frontend
>> > message to the spec documentation.
>> >
>> > Reviewed-by: Alyssa Ross <hi@alyssa.is>
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> > ---
>> >  docs/interop/vhost-user.rst | 41 +++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 41 insertions(+)
>> >
>> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> > index 6c1d66d7d3..e314313806 100644
>> > --- a/docs/interop/vhost-user.rst
>> > +++ b/docs/interop/vhost-user.rst
>> > @@ -371,6 +371,22 @@ MMAP request
>> >    - 0: Pages are mapped read-only
>> >    - 1: Pages are mapped read-write
>> >
>> > +VIRTIO Shared Memory Region configuration
>> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> > +
>> > ++-------------+---------+------------+----+--------------+
>> > +| num regions | padding | mem size 0 | .. | mem size 255 |
>> > ++-------------+---------+------------+----+--------------+
>> > +
>> > +:num regions: a 32-bit number of regions
>> > +
>> > +:padding: 32-bit
>> > +
>> > +:mem size: an array of 256 64-bit fields representing the size of each
>> > +           VIRTIO Shared Memory Region. ``num regions`` specifies the
>> > +           number of valid regions (non-zero size). The array index
>> > +           corresponds to the shared memory ID (shmid).
>> > +
>> >  C structure
>> >  -----------
>> >
>> > @@ -397,6 +413,7 @@ In QEMU the vhost-user message is implemented with=
 the following struct:
>> >            VhostUserShared object;
>> >            VhostUserTransferDeviceState transfer_state;
>> >            VhostUserMMap mmap;
>> > +          VhostUserShMemConfig shmem;
>> >        };
>> >    } QEMU_PACKED VhostUserMsg;
>> >
>> > @@ -1761,6 +1778,30 @@ Front-end message types
>> >    Using this function requires prior negotiation of the
>> >    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
>> >
>> > +``VHOST_USER_GET_SHMEM_CONFIG``
>> > +  :id: 44
>> > +  :equivalent ioctl: N/A
>> > +  :request payload: N/A
>> > +  :reply payload: ``struct VhostUserShMemConfig``
>> > +
>> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
>> > +  successfully negotiated, this message can be submitted by the front=
-end
>> > +  to gather the VIRTIO Shared Memory Region configuration. The back-e=
nd will
>> > +  respond with the number of VIRTIO Shared Memory Regions it requires=
, and
>> > +  each shared memory region size in an array. The shared memory IDs a=
re
>> > +  represented by the array index. The information returned shall comp=
ly
>> > +  with the following rules:
>> > +
>> > +  * The shared information will remain valid and unchanged for the en=
tire
>> > +    lifetime of the connection.
>> > +
>> > +  * The Shared Memory Region size must be a multiple of the page size
>> > +    supported by mmap(2).
>> > +
>> > +  * The size may be 0 if the region is unused. This can happen when t=
he
>> > +    device does not support an optional feature but does support a fe=
ature
>> > +    that uses a higher shmid.
>>
>> This is still phrased as if unused regions after the last used one can
>> be ommitted.  If 256 sizes are always sent, then size must be 0 for all
>> unused regions.
>
> Had to read it a couple of times to see what you meant. But yeah, it
> implies that a zero is always followed by some valid region and is not
> always the case. I guess I can keep only the first sentence and delete
> the rest.

Sounds good to me.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaYnHYwAKCRBbRZGEIw/w
ojALAP0Qus2Pj7NNoP8BW8LyUeF4gl0pVeaYm0W9w5i9aDafigEAvpXJ8M3tc7re
HsII7cS/0F73chW8YUiV6jmAhtt2OQ0=
=/V9m
-----END PGP SIGNATURE-----
--=-=-=--

