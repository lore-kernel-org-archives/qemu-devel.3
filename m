Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9E3C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYth-0001bS-MX; Mon, 12 May 2025 15:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEYte-0001an-Ur
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEYtc-0002AO-Ux
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747078382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/GuQfywWbFMZzMk0428+6epUiMFOALMkSPAznQsBBQ=;
 b=Cnt6PGQTwwiRIfZg7l5+M31+ZcJ3JfYxv4B818Q68MuB0npkKcEtUe5JrU8xWQqTS30AlJ
 SRY0++OUUUfXLnrMDDwK8Q/HOnsigBrvqkcxKwbYYhBjYnU6fdhmmVFuQE5HWsgC5MMuTn
 jK4/OtZns10UNb10umu35zfGvQXQ6aI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-2jMMlajaM0qrhoXQErA4lg-1; Mon,
 12 May 2025 15:32:58 -0400
X-MC-Unique: 2jMMlajaM0qrhoXQErA4lg-1
X-Mimecast-MFC-AGG-ID: 2jMMlajaM0qrhoXQErA4lg_1747078377
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B118E1800873; Mon, 12 May 2025 19:32:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DBBF1944A82; Mon, 12 May 2025 19:32:54 +0000 (UTC)
Date: Mon, 12 May 2025 15:32:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC v2 2/4] virtio-blk: Add VIRTIO_BLK_T_OUT_FUA command support
Message-ID: <20250512193253.GL141177@fedora>
References: <20250508162044.857655-1-afaria@redhat.com>
 <20250508162044.857655-3-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ahYP1B4BNxJr2wOz"
Content-Disposition: inline
In-Reply-To: <20250508162044.857655-3-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ahYP1B4BNxJr2wOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 05:20:42PM +0100, Alberto Faria wrote:
> @@ -828,13 +832,16 @@ static int virtio_blk_handle_request(VirtIOBlockReq=
 *req, MultiReqBuffer *mrb)
> =20
>      type =3D virtio_ldl_p(vdev, &req->out.type);
> =20
> -    /* VIRTIO_BLK_T_OUT defines the command direction. VIRTIO_BLK_T_BARR=
IER
> -     * is an optional flag. Although a guest should not send this flag if
> -     * not negotiated we ignored it in the past. So keep ignoring it. */
> -    switch (type & ~(VIRTIO_BLK_T_OUT | VIRTIO_BLK_T_BARRIER)) {
> +    /* VIRTIO_BLK_T_BARRIER is an optional flag. Although a guest should=
 not
> +     * send this flag if not negotiated we ignored it in the past. So ke=
ep
> +     * ignoring it. */
> +    switch (type & ~VIRTIO_BLK_T_BARRIER) {

This changes the behavior of the device. VIRTIO_BLK_T_FLUSH |
VIRTIO_BLK_T_OUT is now treated as an unsupported command instead of a
flush. The same is true for the other command types as well (like zoned
devices, discard, etc).

Buggy guest drivers might depend on this behavior. From a user
perspective it's QEMU's fault if existing guests break, even if the
guest driver violates the VIRTIO specification. I would treat this as a
stable ABI that third-party virtio-blk drivers depend on unless there is
a strong reason to change existing behavior.

Can you add "case VIRTIO_BLK_T_OUT_FUA & ~VIRTIO_BLK_T_OUT:" instead of
changing existing behavior?

--ahYP1B4BNxJr2wOz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiTOUACgkQnKSrs4Gr
c8iQcQf+Pl+e8QxbUtzMpGTAaxfwIpYJSGxT83CMISnkes9gnQMPg2WPjMC9A/tx
/dAPG+BW65/V1RWGNAHP7rAiSpJPgDpPBBgIKb6PaK6y9v/4SC9lAhMOskpLolX0
m3Y2vlplJHWrusAqTUtY4wkHvAb83VWXwbtqYU9CyG+N8/eAtEnS+lkWYb4Ne0ZI
1oFuuCZKw64Nww+AaKIamdf/W0ycz0V7tB4wv7QCbbYE6Ss+aKoiPzysfVP0yd4q
2Op5yVoKM6AxA2MxinH6KdUK7MUqbhjr54CPC+FjBXMGmlbxYuDG1NiqtthPUS3q
krQq9pBEWtWort7zGcyEnhg1FF5BhA==
=JE/u
-----END PGP SIGNATURE-----

--ahYP1B4BNxJr2wOz--


