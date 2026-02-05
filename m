Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F2BEE0AEE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 19:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voncI-0002H2-LD; Sat, 07 Feb 2026 14:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1voncF-0002GN-UC
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 14:05:11 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1voncD-0006bU-Oz
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 14:05:11 -0500
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 039D71400143;
 Sat,  7 Feb 2026 14:05:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Sat, 07 Feb 2026 14:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1770491106; x=1770577506; bh=ucMR9luIo5
 jvcGoHDLdJB3fP86ThLUhSFcOFGEW4vBs=; b=SX89BXtn7MZvnGFs6QeqpWc3Y/
 QFqRFD4ufh4P4D/iaxBGKzCeKXXFDIFbOIZUoVRu747ByN2za+sITVPTMSz7P+9M
 JXeSccDo6B7NE3Bc1KYrANlRUDjlF1hvOGsEGkGX2Zp9By1FfLh9LxRD/WCzoUlF
 W+nbnX7YRkS7ox/hUMQfzlJQO/6xl4NGQg2ca7G7zraAeHULMTTWFUy8re9hnVG2
 jhxarmPoMtcQEgApLHNiNXyBnksoppJAeKazyTaIxZxU7nP0aaE2WqlANfYOJILH
 hHxIs5U7MSt2VzXMseq0qtx9f4AxEssVLtfW95KpjnrFXbUJJs6c6yAWY8qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1770491106; x=1770577506; bh=ucMR9luIo5jvcGoHDLdJB3fP86ThLUhSFcO
 FGEW4vBs=; b=iezzlxY8TvtHZqlT8FpZxnwFZteqXTuuPX0Ccb7cp1aTxc9ir7R
 hNtd/mX6M1jEnx1lE102+I0HeEG1eqDayN6Lm2AVd9GTeBijdi8efurUNRMGNIFH
 F48D2TU7zjGgwp19JzdnRFGWqlwcunxZlek1mrRfNIq+ghTJ+ebwDpY1+y/hskuJ
 ABbwgV3/EkCh2kjmhujkY4YCq5FhGeYmqyooWWx5J4sS6lNDItR7VAKJJCuLiGis
 31xlo+NBpmvNl8JsLB6zYdX5tVmVrMCpFk00u1PjF2jpuGqGEYBjSVE4N/Uf9qW5
 Sw9PkVX+f7nPo2PLmq9Fhi6VgHrLL/Di/7Q==
X-ME-Sender: <xms:4oyHadFSQfBxpCRjqa-xXaRXfwnEDlvZe1xNRZhdPKEgIrllC4Ysww>
 <xme:4oyHaX5ol0YqiLt9dI2qK4buk9EuUZKR7-FtqFDUJTT9JnjrQIs06WNjgi17a0BPj
 dE9KPmO55qBG4ga2-lVPVNnrNWSIEya6JJBLtmYBCcFkIEM-6t0Sw>
X-ME-Received: <xmr:4oyHaYs50sKaOau-Yj3Z-jFSBl6KiKw6OohP0zypLbjaoaNAXjsj9Lq3EfQrD_xc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledukeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefujghffffkgggtsehgtderredttddtnecuhfhrohhmpeetlhihshhsrgcu
 tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeiudffue
 eilefgtefgtddttdekkeehkefgheekudefveetgeefiefftedvteeuveenucevlhhushht
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
X-ME-Proxy: <xmx:4oyHaT-g30jfc6skWaoFXmsJ4Gp4X4j1dZrGfyGgiGw4D25Oo75f0A>
 <xmx:4oyHaanwP8PRW1UIwPG6A2g2P8sg9NDoYCsQZHCaIyDYdQdEAQoUVQ>
 <xmx:4oyHabOZo89ewzl5deax2VTufsN0lpo5T-8Z0eHMKW7VHcvKM5YxDw>
 <xmx:4oyHaRKBwh-lDJVUk0JP83J_CqdWzmRk9JI2AuCzO5EzHXCLsOPIYA>
 <xmx:4oyHaR9CeB-1wwYuzU6RrUfcfHkHBZ7657drodtCo6Rqt7wQZ4-vWUGJ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 14:05:06 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id C6CB973DB080; Thu, 05 Feb 2026 14:53:35 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, slp@redhat.com, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Laurent Vivier <lvivier@redhat.com>,
 manos.pitsidianakis@linaro.org, stevensd@chromium.org, dbassey@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>,
 stefanha@redhat.com, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v12 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
In-Reply-To: <20260204093758.1250167-2-aesteve@redhat.com>
References: <20260204093758.1250167-1-aesteve@redhat.com>
 <20260204093758.1250167-2-aesteve@redhat.com>
Date: Thu, 05 Feb 2026 14:53:27 +0100
Message-ID: <87cy2jl2js.fsf@alyssa.is>
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
Content-Type: text/plain

Albert Esteve <aesteve@redhat.com> writes:

> +``VHOST_USER_BACKEND_SHMEM_MAP``
> +  :id: 9
> +  :equivalent ioctl: N/A
> +  :request payload: fd and ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends to
> +  advertise a new mapping to be made in a given VIRTIO Shared Memory Region.
> +  Upon receiving the message, the front-end will mmap the given fd into the
> +  VIRTIO Shared Memory Region with the requested ``shmid``.
> +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
> +  must respond with zero when operation is successfully completed,
> +  or non-zero otherwise.
> +
> +  Mapping over an already existing map is not allowed and requests shall fail.
> +  Therefore, the memory range in the request must correspond with a valid,
> +  free region of the VIRTIO Shared Memory Region. Also, note that mappings
> +  consume resources and that the request can fail when there are no resources
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
> +  successfully negotiated, this message can be submitted by the backends so
> +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) in the
> +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that the
> +  given range shall correspond to the entirety of a valid mapped region.
> +  A reply is generated indicating whether unmapping succeeded.

Shouldn't this be phrased like VHOST_USER_BACKEND_SHMEM_MAP above,
since as we've established replies are only generated if negotiated?

  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the back-end
  sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond with
  zero when operation is successfully completed, or non-zero otherwise.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaYSg1wAKCRBbRZGEIw/w
otB+AP9ttgZDsytu+Aas7AX0/9Zm9KbKcnOwDHuNYpDh3Lc0RgEApkLyPGjb3MBs
17/VSgyma3PkrnXgqVBQknXUA+vd6w0=
=ecZY
-----END PGP SIGNATURE-----
--=-=-=--

