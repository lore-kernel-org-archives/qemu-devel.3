Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483B7D41178
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMBu-0005Ce-0w; Thu, 15 Jan 2026 07:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vgMBp-0005Aj-Af
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:11:01 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1vgMBj-00014s-7I
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:10:57 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id D338AEC02C8;
 Thu, 15 Jan 2026 07:10:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 15 Jan 2026 07:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1768479050; x=1768565450; bh=lSUZ/b50rv
 ziLgTAO8h0r4ZuYJdWI7SdQqV/oN9mX40=; b=n3XV8tRhsXAx+xHWl2Ks/BmmV3
 2UOCG1J7gOVrA0aIeS4cL44P+W0XrWN2ZFQGIidC60gawMnupK/zGk77+mnAaJ8E
 IzMDqEDbRBloJ7HyAvcNV0RcppgsD5He8DQSqYGviuMwA5gMLr4VrA/VA8GEO+Ox
 IDFcQdKnvOQRP1PP4Dglb2uHR/Mh+kEwcuPyHX8mR7tOLBI5Znh9cKbLgvu1OE6r
 liLRyIvNoaIcFs9yEUKrEbUMYLknGKCVGlazK3LSEt4RRd+9PbHjJdy9uEEwcSMV
 eUH6lEd4jLaD6uwc95LQBACEEI9gk1oS7U7E734A42EpALN6i2ZdvBGQD0Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1768479050; x=1768565450; bh=lSUZ/b50rvziLgTAO8h0r4ZuYJdWI7SdQqV
 /oN9mX40=; b=Duc59CVBaDO1cpf6wVAOYWV1RXW7PvtHZsUgCFOnt92IOc6/mIN
 ksVlGnKIIIcSwG8a0U3VIYmdGFah7j3nhDhpr+R2A8gXQcbK8+yWieGno3BvPCjR
 w+pmLiSWhSil0OsDMy4g3dhdzUVunK9EGKoD1f1+85I0BQYEoZPNIng/1/i422BK
 5X1nCJm0yl1kHspv5ws/fG0+jrkEyAfMH9u7lu08MGHz8mQkV5M9/nl2E7qHgC1U
 4+Oy6vl+PO7EMrj6HhmtmZ+uVS47tzRrXa0JjJiYdBda5VEz6KFvEWaCB4T5AJoB
 qwUs8TIA8zvAx2+bewPbAujr0tbJp0Tyu1Q==
X-ME-Sender: <xms:StloabHujWuFAwkZtjUi5Cs_b9juwlaq5uMlXzlwEaGuiehTmX2vFg>
 <xme:StloaX7mK3conjjOGEOriI2fSbO0j0xNnPNt9ZJKcYeVmeBHbOpKY3Ecj6gZd2GlS
 dJTFL0n9XvL59JJMOUA0vxUAP5rBuW7LlRW36Oglo1IMN3x3lEA9mE>
X-ME-Received: <xmr:StloaRfradHPdb0umh_IPbW37n3-4XMb7XD751mqEx8cshEIhcWp5ltbjR71vlY-e5Y6wSMJLiYw4dWw3n0J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeitddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:StloablCZD9bcxXl1qV3fQt4HnstAzmNFu2AD9NFfg3oaFxQGwbu5g>
 <xmx:Stloae8v6kQDrNjJq-NBzTz2gKAQVY-WmfrUJz3q9Aa5ZzIEaXlIFA>
 <xmx:StloaZE3ULgd8uvX3GrKRuepUPBsyRYFHfWtxLc4n2BbXmY1E9OSQg>
 <xmx:StloaaKOhjA09NCm3TxtghKU_9dFI1wd26PZHoa6LHKgIcINliAk_w>
 <xmx:StloabFJPxQ9wgdfaJGIV99wsR3RL-NyvlF3PTDITJGwyiJ0f09HX4dk>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 07:10:50 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id B058B705D789; Thu, 15 Jan 2026 13:10:48 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: dbassey@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 manos.pitsidianakis@linaro.org, slp@redhat.com, stefanha@redhat.com,
 Fabiano Rosas <farosas@suse.de>, jasowang@redhat.com, Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 david@redhat.com, stevensd@chromium.org, Stefano Garzarella
 <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Albert Esteve
 <aesteve@redhat.com>
Subject: Re: [PATCH v11 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
In-Reply-To: <20251111091058.879669-4-aesteve@redhat.com>
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-4-aesteve@redhat.com>
Date: Thu, 15 Jan 2026 13:10:44 +0100
Message-ID: <87cy3brs8r.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.149; envelope-from=hi@alyssa.is;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Add SHMEM_MAP/_UNMAP request to the vhost-user
> spec documentation.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 59 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 17a68a62eb..6c1d66d7d3 100644
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
> @@ -1064,6 +1086,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
>=20=20
>  Front-end message types
>  -----------------------
> @@ -1872,6 +1895,42 @@ is sent by the front-end.
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
> +  VIRTIO Shared Memory Region with the requested ``shmid``.
> +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
> +  must respond with zero when operation is successfully completed,
> +  or non-zero otherwise.

Having now tried to implement this, I'm wondering whether replies should
be mandatory, even without VHOST_USER_PROTOCOL_F_REPLY_ACK, like they
are for some other messages.  Without waiting for a reply, a backend
doesn't know when it can tell the driver to start using the mapped
memory, so I'm not sure there's ever a case in which a backend would not
want to wait for a reply after sending VHOST_USER_BACKEND_SHMEM_MAP,
even if it doesn't wait habitually wait for replies for other messages.
(crosvm is like this =E2=80=94 its backends don't negotiate
VHOST_USER_PROTOCOL_F_REPLY_ACK, and their non-standard map/unmap
requests had mandatory replies.)

> +  Mapping over an already existing map is not allowed and requests shall=
 fail.
> +  Therefore, the memory range in the request must correspond with a vali=
d,
> +  free region of the VIRTIO Shared Memory Region. Also, note that mappin=
gs
> +  consume resources and that the request can fail when there are no reso=
urces
> +  available. Lastly, mappings are automatically unmapped by the front-end
> +  across device reset operation.
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
> +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) in=
 the
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

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaWjZRAAKCRBbRZGEIw/w
ojTxAP93lHaJh2kmvHwG5O2vK/Jh+U1b0Ku8woayEWso4+mkMAEA9IszIjVUPVO9
z2sWZctewdSNuhRCqObUzKVhwkY8DwA=
=7k++
-----END PGP SIGNATURE-----
--=-=-=--

