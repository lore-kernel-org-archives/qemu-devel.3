Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C05D44C4B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgNWW-0004Mz-Km; Thu, 15 Jan 2026 08:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vgNW7-0004Fk-W4
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:36:13 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vgNW4-0007uX-T9
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:36:02 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id B391DEC02EF;
 Thu, 15 Jan 2026 08:35:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 08:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1768484158; x=1768570558; bh=F9vw8g7RLD
 jmK3etLWU8lPrADJVUZseOsMTL5yWxJ7s=; b=FVdmRa82VQFOjrd3+9YJwBUs0K
 FX329bMr4OVD5jYiShpFxu+6yyd+n9fN1HWRO4gowuUuYpScLc6fV042v8QThnvF
 V8ho2qsCntyveRxx1eEAqXxTQtcttVRRvUBA7NwwfLaKPPRG/k3ogpJpQ53ksk3A
 Ssfk9I8j0I1seTtInK1fawhINwQ8XG3GeU5a/YGi7aoZNlShw8ZEgTE99r2W8oWN
 Or1EY6PvbS0DUFqxqVEuq+rEfy0R9LusoUCRtOCGJPpnC4REvwyocXScQyFpPntD
 n2JSA9bVyI4tnVyiNKsvOIlLQjD4nQPFxiA1G8ZXtBgYp2ytWCXx6u0plJxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1768484158; x=1768570558; bh=F9vw8g7RLDjmK3etLWU8lPrADJVUZseOsMT
 L5yWxJ7s=; b=PZYyMDJ/ZcQmARj8qcTk1u9zYOiitICBcsAlDfnUssA8Lwm+u/R
 aA8A8qSwmgIxs3GwsEr619XyraALm/NBKusJ4blxitn/DGJEny3KlAxTjrxlTXjK
 R89xo2IEUp5ICjxL2jdFvhQAxfKypHEXHND9NCjeFrn04kfmnMj5i8Aj3PktA4WN
 WgBya7SKflEooF6Ti2Xzl76DgrqBT/5EyxSkyJJFcaJ48tDpMdRf1orCMI7iqKjr
 KV1WlFyeQOC5PbQ5T4xbYCrKu5/hQuoNRGQJTKy8IbEW/Cjx0zFjPxBNieB2LqKm
 KI/UsuXDNDp3wjEKsi6NPQ3nthbasbVXmkw==
X-ME-Sender: <xms:Pu1oadAXb4g6gIz_LYxWWg5S_lJIgk-RlJEoPpsftQUM1BM8Jx6aAQ>
 <xme:Pu1oabFCkNiDl87HNy4P5ksxWMUzcf6KL0log7s0-d20UubPMULSYiEWg6Phm0YuM
 G54F6HzqEPlY7UfBvBfyRDPvoHnlVX64S6l0bV-JxdmViilKTCcqg>
X-ME-Received: <xmr:Pu1oac7-_qz_vOO37TthLkB23QkF-Fi-QSIsi1wvmegnGkVmNlNsS80MlCUA1tE_EHx0av8CglONBmzs7UsCdtIYUiGeGLA7gsOO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeiudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
 tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeetheevud
 fgjefghefhieejudelkeeljeegvdekueeuhffhgedvveefteevgeetieenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
 hishdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehsthgvvhgvnhhsugestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprghlvgigrd
 gsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrnhhoshdrphhithhs
 ihguihgrnhgrkhhisheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvg
 hvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegrvghsthgvvhgvsehrvgguhhgr
 thdrtghomhdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtth
 hopegusggrshhsvgihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghsohifrghn
 ghesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhvihhvihgvrhesrhgvughhrghtrd
 gtohhm
X-ME-Proxy: <xmx:Pu1oaaQRSIyTG3ZiTc_Zb_AALyvWQrszN25TQDMZv2ztpB6DcIOzFg>
 <xmx:Pu1oaf5rdDgrkiS0DkxGYdpHHVLwctY19VOH7RBqVMO9llTbjLRu5A>
 <xmx:Pu1oafRD9ft6x-RVNSLKSO0pJw5WY47Q2-mK6ZoNba95VxiBjzv5LA>
 <xmx:Pu1oacnGMYyJdwvYNXEOTT_TlqxswjDiDYItSvMIuz5hg4UHvyx5Rw>
 <xmx:Pu1oaWPaOPPZYY9gQ-3fEkF2h1fOj___he70v_HNbvoS9VvUngWza3xs>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 08:35:57 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 762857061497; Thu, 15 Jan 2026 14:35:54 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 dbassey@redhat.com, manos.pitsidianakis@linaro.org, slp@redhat.com,
 stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>, jasowang@redhat.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>,
 david@redhat.com, stevensd@chromium.org, Stefano Garzarella
 <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v11 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
In-Reply-To: <20260115081220-mutt-send-email-mst@kernel.org>
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-4-aesteve@redhat.com> <87cy3brs8r.fsf@alyssa.is>
 <20260115081220-mutt-send-email-mst@kernel.org>
Date: Thu, 15 Jan 2026 14:35:53 +0100
Message-ID: <87a4yfroau.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.150; envelope-from=hi@alyssa.is;
 helo=fout-a7-smtp.messagingengine.com
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jan 15, 2026 at 01:10:44PM +0100, Alyssa Ross wrote:
>> Albert Esteve <aesteve@redhat.com> writes:
>>=20
>> > Add SHMEM_MAP/_UNMAP request to the vhost-user
>> > spec documentation.
>> >
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> > ---
>> >  docs/interop/vhost-user.rst | 59 +++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 59 insertions(+)
>> >
>> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> > index 17a68a62eb..6c1d66d7d3 100644
>> > --- a/docs/interop/vhost-user.rst
>> > +++ b/docs/interop/vhost-user.rst
>> > @@ -350,6 +350,27 @@ Device state transfer parameters
>> >    In the future, additional phases might be added e.g. to allow
>> >    iterative migration while the device is running.
>> >=20=20
>> > +MMAP request
>> > +^^^^^^^^^^^^
>> > +
>> > ++-------+---------+-----------+------------+-----+-------+
>> > +| shmid | padding | fd_offset | shm_offset | len | flags |
>> > ++-------+---------+-----------+------------+-----+-------+
>> > +
>> > +:shmid: a 8-bit shared memory region identifier
>> > +
>> > +:fd_offset: a 64-bit offset of this area from the start
>> > +            of the supplied file descriptor
>> > +
>> > +:shm_offset: a 64-bit offset from the start of the
>> > +             pointed shared memory region
>> > +
>> > +:len: a 64-bit size of the memory to map
>> > +
>> > +:flags: a 64-bit value:
>> > +  - 0: Pages are mapped read-only
>> > +  - 1: Pages are mapped read-write
>> > +
>> >  C structure
>> >  -----------
>> >=20=20
>> > @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with=
 the following struct:
>> >            VhostUserInflight inflight;
>> >            VhostUserShared object;
>> >            VhostUserTransferDeviceState transfer_state;
>> > +          VhostUserMMap mmap;
>> >        };
>> >    } QEMU_PACKED VhostUserMsg;
>> >=20=20
>> > @@ -1064,6 +1086,7 @@ Protocol features
>> >    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> >    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>> >    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
>> > +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
>> >=20=20
>> >  Front-end message types
>> >  -----------------------
>> > @@ -1872,6 +1895,42 @@ is sent by the front-end.
>> >    when the operation is successful, or non-zero otherwise. Note that =
if the
>> >    operation fails, no fd is sent to the backend.
>> >=20=20
>> > +``VHOST_USER_BACKEND_SHMEM_MAP``
>> > +  :id: 9
>> > +  :equivalent ioctl: N/A
>> > +  :request payload: fd and ``struct VhostUserMMap``
>> > +  :reply payload: N/A
>> > +
>> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
>> > +  successfully negotiated, this message can be submitted by the backe=
nds to
>> > +  advertise a new mapping to be made in a given VIRTIO Shared Memory =
Region.
>> > +  Upon receiving the message, the front-end will mmap the given fd in=
to the
>> > +  VIRTIO Shared Memory Region with the requested ``shmid``.
>> > +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
>> > +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
>> > +  must respond with zero when operation is successfully completed,
>> > +  or non-zero otherwise.
>>=20
>> Having now tried to implement this, I'm wondering whether replies should
>> be mandatory, even without VHOST_USER_PROTOCOL_F_REPLY_ACK, like they
>> are for some other messages.  Without waiting for a reply, a backend
>> doesn't know when it can tell the driver to start using the mapped
>> memory, so I'm not sure there's ever a case in which a backend would not
>> want to wait for a reply after sending VHOST_USER_BACKEND_SHMEM_MAP,
>> even if it doesn't wait habitually wait for replies for other messages.
>> (crosvm is like this =E2=80=94 its backends don't negotiate
>> VHOST_USER_PROTOCOL_F_REPLY_ACK, and their non-standard map/unmap
>> requests had mandatory replies.)
>
> the use-case would be multiple MAP request and a single ack at the end
> to confirm them all.
>
> behaviour of sending ack without VHOST_USER_PROTOCOL_F_REPLY_ACK is
> legacy. let's just stick to the simple rule - if you want
> an ack set VHOST_USER_PROTOCOL_F_REPLY_ACK.

Okay, makes sense to me.  I'll try to fix crosvm's implementation.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaWjtOQAKCRBbRZGEIw/w
onjDAQDMFrdquiQ71rT6G0vkMFer3rff3RtRSLdVan0++h4ujQD7BZPg+MQ+8zxw
DNxsdoNM1h/TAMc7l8nOKA49DfwjHQA=
=0a9x
-----END PGP SIGNATURE-----
--=-=-=--

