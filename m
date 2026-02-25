Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52F5FD375D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 13:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEaW-0001w7-H3; Wed, 25 Feb 2026 08:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvEaV-0001vW-3A
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvEaT-0005K4-DS
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772024756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lwnsPzJoMH4XWfrme1gJfiT8NDcUr0VN6UL4SZNwysA=;
 b=QKBg8dw8HjmH9GrrLfIqn1u0uQPiVxg8vybNSbV0f446RROXCKV7AGYZTYmhWEcXU7IOts
 nOtzNuDTfmbt5Lh99dPjNzhdq4o7oDfe4fZuLs2n8jeb4/vM94ij1o480vpszP29pRYv0d
 1jfpr7qbJWXwQiTmEPWBSXzzgPjN8+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-6mVj4-VrNt6GgdiYFJWqlA-1; Wed,
 25 Feb 2026 08:05:51 -0500
X-MC-Unique: 6mVj4-VrNt6GgdiYFJWqlA-1
X-Mimecast-MFC-AGG-ID: 6mVj4-VrNt6GgdiYFJWqlA_1772024749
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFB2A1956055; Wed, 25 Feb 2026 13:05:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED9251800666; Wed, 25 Feb 2026 13:05:46 +0000 (UTC)
Date: Wed, 25 Feb 2026 21:05:43 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 virtio-fs@lists.linux.dev, Milan Zamazal <mzamazal@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/4] vhost-user.rst: fix typo
Message-ID: <20260225130543.GA1663199@fedora>
References: <20260224075055.863068-1-dtalexundeer@yandex-team.ru>
 <20260224075055.863068-2-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YpuVS3lxF746hVRw"
Content-Disposition: inline
In-Reply-To: <20260224075055.863068-2-dtalexundeer@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--YpuVS3lxF746hVRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2026 at 12:50:52PM +0500, Alexandr Moshkov wrote:
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  docs/interop/vhost-user.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YpuVS3lxF746hVRw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmme86cACgkQnKSrs4Gr
c8gyPQf/TTArzOCaQAEb+dXUjpZFd6kTU5agHi+nmDN9ille22nGNVbiH8EU7uUF
ZnPB/PCJhmO+VPoCKwTieQ9WyL5q/ExJ/zJWmqt4ndYWZBXoHsgSk2ma8dBICt6Y
A5zIwSBh0IuJoxhgigmOSjjYMNa6zw+gFNK560KyCYLY3ZMYdFh9NCBUNzHVp+Zl
yKpValSXrr+QoGM000czDeE2FBEB31QEi3c62KfUo6N/2+hkoSEYAFK/3vEj83s8
ocnJoJUpc0c2g8fjYj8Zk9iC61SP3/f6xIv3VEemkd9kY8shbvGAtrxa24sPaA3j
mK1ijOrd8jdKePpqWj94b8MJWjjigQ==
=6roa
-----END PGP SIGNATURE-----

--YpuVS3lxF746hVRw--


