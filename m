Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E68C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 06:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPEql-0007f6-Qk; Wed, 11 Jun 2025 02:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1uPEqB-0007eE-U6
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:21:40 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1uPEq9-0008R9-3Y
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:21:38 -0400
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ED32E11400C1;
 Wed, 11 Jun 2025 02:21:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 11 Jun 2025 02:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1749622893; x=1749709293; bh=iRtBKjK22P
 cEM9ocSmXmrVWcTg8faSelkAYCJ9KaGzU=; b=kJWBWNsCxVvyXqqUrpB4I4XKf6
 obY/oHpT3uEJpX7qANeNod32HqvcEQ30ttYiF24lUuXgt7Dih6i4mRcXt0rmagzu
 MyglkrpoB14AEv9kFAluFThlDoVTbf/lxkSLYOMzWaAw/5u9qhdrmxSrNOM6HiGS
 KAUzUYaAB1vhkMOVF2EAeXfvJOoOAO34UJ4QPlsiFqCqUEC/cGU9ZTKQoy4S5yJz
 bJK/zFB0nSP6PZ4rAU0OxaMs1Sl+srl1ChT6gO3/3vWyyiw2KZO4WbI3NJAR6sKD
 SnSsx5vUdpBvywnEmSCqx5jRAUcRJof2j471sJkOg0g1SoG9AZCZq3UKv8Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1749622893; x=1749709293; bh=iRtBKjK22PcEM9ocSmXmrVWcTg8faSelkAY
 CJ9KaGzU=; b=ZfnBGAc5A3GWn5zzUrMWFdrwCyBRehBA4FI0qmZ0YloVcefgbRp
 WY933JMYdwIvarMzynKPaCfGFlIR2G9GWH+8G2m278VNE9PZe2rA5pZ9Qh229IUt
 lp89IVHFVwjv6EjQJNpqnZyPeYDDV/RfoukXdGznsRWU0xfzF+W2JQlYtQdeJl8B
 MOeRCn1/omnIozUcuOApf47u3gJQYDSWuPYgbOc0YgkGIe9bCHazCYjy6tmTytJk
 y0i9z4o9dEpgLpDl0QZUF0nW0SCHV/da1ip85QHFhNjZsgLxXBV7lfUSmVhs4LPz
 FcQCVMHGEXib4a+i6UFNhw/RjkLq9oJa+nA==
X-ME-Sender: <xms:bSBJaBD-WHzCBOVkC0JalfkAcanzIDUioCca8zC-X0w-fpudG3DiwA>
 <xme:bSBJaPio3ETjuloHjySZqPDMoAqSAL55UL0kPYZnZRkK4kYDgjgPBQvifjfl7CzJq
 NPZWNI1lGfR_cJHzA>
X-ME-Received: <xmr:bSBJaMkZw12y0O_M_5zKgCzYRuKeyErPag0KTbQvOEyqFYnJqgNYMX00FGWr-5oENyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudekudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgesghdtreertddttden
 ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
 ftrfgrthhtvghrnhepieduffeuieelgfetgfdttddtkeekheekgfehkedufeevteegfeei
 ffetvdetueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopedutddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepshhtvghvvghnshgusegthhhrohhmihhumhdrohhrgh
 dprhgtphhtthhopegrlhgvgidrsggvnhhnvggvsehlihhnrghrohdrohhrghdprhgtphht
 thhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheprggvsh
 htvghvvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdrtghomhdprhgtph
 htthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsghgrrhiirghrvges
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepshhlphesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:bSBJaLz8a403XQ4FcRbM0d6eZSwxVq2fanTX6dqhVVPU7GDfbI5i-w>
 <xmx:bSBJaGRIn32RQiHCg7rDBKkcR7Ocht5igSkzrokr2lmsCH370BF2Pw>
 <xmx:bSBJaOZG8owOdM9g4Zgp76esAgZnDzCulVr7EdIK4Zh8OogibfzVyg>
 <xmx:bSBJaHRlgPEMhDLpkRIJ2V-QZxFdA3IkBLYcbHP-qCHko89TcdpYHQ>
 <xmx:bSBJaDKpFL7qTU8ut4iKIDETfp8w9bIePcHQ-6Quc_ENf1ylQCh9zZLn>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 02:21:32 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 1C2CB7119FF; Wed, 11 Jun 2025 08:20:25 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, slp@redhat.com, david@redhat.com, "Michael S.
 Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, stevensd@chromium.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v5 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
In-Reply-To: <20250609144729.884027-4-aesteve@redhat.com>
References: <20250609144729.884027-1-aesteve@redhat.com>
 <20250609144729.884027-4-aesteve@redhat.com>
Date: Wed, 11 Jun 2025 08:20:22 +0200
Message-ID: <87jz5ilryx.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.152; envelope-from=hi@alyssa.is;
 helo=fhigh-a1-smtp.messagingengine.com
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
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Albert Esteve <aesteve@redhat.com> writes:

> Add SHMEM_MAP/_UNMAP request to the vhost-user
> spec documentation.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 55 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 436a94c0ee..b623284819 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -350,6 +350,27 @@ Device state transfer parameters
>    In the future, additional phases might be added e.g. to allow
>    iterative migration while the device is running.
>=20=20
> +MMAP request
> +^^^^^^^^^^^^
> +
> ++-------+---------+-----------+------------+-----+-------+
> +| shmid | padding | fd_offset | shm_offset | len | flags |
> ++-------+---------+-----------+------------+-----+-------+
> +
> +:shmid: a 8-bit shared memory region identifier
> +
> +:fd_offset: a 64-bit offset of this area from the start
> +            of the supplied file descriptor
> +
> +:shm_offset: a 64-bit offset from the start of the
> +             pointed shared memory region
> +
> +:len: a 64-bit size of the memory to map
> +
> +:flags: a 64-bit value:
> +  - 0: Pages are mapped read-only
> +  - 1: Pages are mapped read-write
> +
>  C structure
>  -----------
>=20=20
> @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserInflight inflight;
>            VhostUserShared object;
>            VhostUserTransferDeviceState transfer_state;
> +          VhostUserMMap mmap;
>        };
>    } QEMU_PACKED VhostUserMsg;
>=20=20
> @@ -1057,6 +1079,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
>=20=20
>  Front-end message types
>  -----------------------
> @@ -1865,6 +1888,38 @@ is sent by the front-end.
>    when the operation is successful, or non-zero otherwise. Note that if =
the
>    operation fails, no fd is sent to the backend.
>=20=20
> +``VHOST_USER_BACKEND_SHMEM_MAP``
> +  :id: 9
> +  :equivalent ioctl: N/A
> +  :request payload: fd and ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends=
 to
> +  advertise a new mapping to be made in a given VIRTIO Shared Memory Reg=
ion.
> +  Upon receiving the message, the front-end will mmap the given fd into =
the
> +  VIRTIO Shared Memory Region with the requested ``shmid``. A reply is
> +  generated indicating whether mapping succeeded.

Should this be phrased to make it clear replies are only generated in
some cases, like how e.g. VHOST_USER_BACKEND_IOTLB_MSG phrases it?

	If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
	back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
	must respond with zero when operation is successfully completed,
	or non-zero otherwise.

> +
> +  Mapping over an already existing map is not allowed and request shall =
fail.

request*s* shall fail

> +  Therefore, the memory range in the request must correspond with a vali=
d,
> +  free region of the VIRTIO Shared Memory Region. Also, note that mappin=
gs
> +  consume resources and that the request can fail when there are no reso=
urces
> +  available.
> +
> +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> +  :id: 10
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends=
 so
> +  that the front-end un-mmap a given range (``shm_offset``, ``len``) in =
the

un-mmaps?

> +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that the
> +  given range shall correspond to the entirety of a valid mapped region.
> +  A reply is generated indicating whether unmapping succeeded.
> +
>  .. _reply_ack:
>=20=20
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> --=20
> 2.49.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaEkgJwAKCRBbRZGEIw/w
oq2nAQCR0up9+aoGTuoPCT1Ph+sTlhu/oAEqhJPiqAl5RgwHtAEAkoPq5INXzCX5
wIeVAWyxYwBAr6gJ18qlCFAuTD8RzAM=
=JqWB
-----END PGP SIGNATURE-----
--=-=-=--

