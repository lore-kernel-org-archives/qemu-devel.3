Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3949610A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n3R-0001ae-NB; Thu, 26 Mar 2026 11:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5n3Q-0001aL-8Q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5n3O-0008MT-Ph
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774540525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkhsZ+4WYb4UpPprivDQbnPhli6Yt/ZiU2dF3YO8xwM=;
 b=DWdkQCXGLIxFr6hv9Qy5lqYjFs0cBhMDtEVC0Ws4PbBOWgkI1srdgFHxna72sSY5EvL4zA
 5AAft5VirPPGgYT9JfelvVq901EmTU+ZyIBH7HhRQWS/gHlD2ayAgmQkXYLY0d95ySPJQq
 OBjlUkelto9awXvub1tyKkcOYF/GvQI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-9AB8HI5TOiiMAQVC29dtyA-1; Thu,
 26 Mar 2026 11:55:22 -0400
X-MC-Unique: 9AB8HI5TOiiMAQVC29dtyA-1
X-Mimecast-MFC-AGG-ID: 9AB8HI5TOiiMAQVC29dtyA_1774540520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A9501800610; Thu, 26 Mar 2026 15:55:19 +0000 (UTC)
Received: from localhost (unknown [10.45.226.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8779D19560B1; Thu, 26 Mar 2026 15:55:16 +0000 (UTC)
Date: Thu, 26 Mar 2026 11:55:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, virtio-fs@lists.linux.dev,
 zhenwei pi <zhenwei.pi@linux.dev>, Hanna Reitz <hreitz@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Milan Zamazal <mzamazal@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 0/4] vhost-user-blk: fix compatibility with older qemu
 versions
Message-ID: <20260326155514.GF758087@fedora>
References: <20260311084728.751169-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mhkaxRLYx8MX0uJr"
Content-Disposition: inline
In-Reply-To: <20260311084728.751169-1-dtalexundeer@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--mhkaxRLYx8MX0uJr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 01:47:24PM +0500, Alexandr Moshkov wrote:
> v1 -> v2:
> - reorganize commits: make refactor commits first, then core semantic cha=
nge
> - add additional pre_save check for inflight migration possibility
>=20
> ---
>=20
> This is a small continuation of my series about inflight migration for vh=
ost-user-blk.
>=20
> This series is designed to solve the problem of compatibility with older =
versions of qemu, where this feature has not yet been introduced (for examp=
le, if we want to downgrade versions due to some problems).
>=20
> In the current version for vhost-user-blk, this feature is enabled using =
the parameter and further migration of the inflight region will depend on w=
hether the vhost-user has accepted the new protocol feature or not. This cr=
eates an inconvenient dependency, because there is no way to disable this f=
eature without reconnecting to the backend.
> This series slightly changes the semantics of the introduced protocol fea=
ture VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature a=
dds a new parameter for GET_VRING_BASE message - skip_drain, which allows t=
o control drain in-flight requests on the backend.
>=20
> Thus, user can enable or disable inflight-migration param for vhost-user-=
blk to maintain compatibility with older versions of QEMU.

Can you describe what the user needs to do in more detail?

While the patch series introduces a way to tell the vhost-user back-end
whether or not to use inflight migration at runtime, I don't see a way
for the user to enable/disable inflight migration at runtime in QEMU. So
how does the user migrate back to an old QEMU if the current VM was
launched with inflight-migration=3Don?

Stefan

--mhkaxRLYx8MX0uJr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnFVuIACgkQnKSrs4Gr
c8g/nAf/fg5Y8ZNvlhaxNPN1jfI8plT7beo1az0FD+g2faVR4zLuDlumqocFziQQ
H7qgyugiiJrgdT41sk3AXd/SKiqGgTUAnVLzpYaYFdfRJLIeomJLHPZQxXIO/+Ye
CfCZL0e7Diwt/442ISK3jRwlBcCamEl5frLvn4PGSYPCLzcxds7gsAPN6dEmnGhm
VgZWc7qs6GXTWD3O/WOZkdk3QOR64cRIIE4GVt6w4zszzliRlvqIv7i4VXobCp5Z
83dnaz6xsrR8wT4j3f6TrlJBLZipe+BBYRHlM/mDl+K5nQ5TKrTuTUxrD8ZieobT
ApWq9QsUqScul4vR+NlhwQHXaYhXgQ==
=7g79
-----END PGP SIGNATURE-----

--mhkaxRLYx8MX0uJr--


