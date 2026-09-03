Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C6CC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29Aj-000634-Iv; Thu, 03 Sep 2026 11:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x29Ai-00062C-Ek
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x29Ah-0007G0-3s
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788448569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ak8Dn2Q0XCd9mgFVKD7KNjVT7rsJa+pZ7cEtfR7l6p4=;
 b=hTE0Fk/88qE2U9jXvTRdjtBdTjbGghc9XNDkDJ4rU31ZcedX4TZLWCznH1Up6r3NjE9ZUD
 fID1rnJAFOkKODZpVHu1NxZHBm3LHyi3C/9UKSh/u3Q/F/nFPMUAg1d2VyQINjLenMMTGb
 tlAPcA7Dm30P9rCmEZSevzWdo4swOO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-r0qjlSrPMICGgCO27rz5aA-1; Thu,
 03 Sep 2026 11:16:06 -0400
X-MC-Unique: r0qjlSrPMICGgCO27rz5aA-1
X-Mimecast-MFC-AGG-ID: r0qjlSrPMICGgCO27rz5aA_1788448564
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8236190A37A; Thu,  3 Sep 2026 15:16:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3574D18005BA; Thu,  3 Sep 2026 15:16:04 +0000 (UTC)
Date: Thu, 3 Sep 2026 11:16:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 9/9] iotests: Add delay-alert test
Message-ID: <20260903151602.GG825275@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-10-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O8kONWcbiWw0NXdA"
Content-Disposition: inline
In-Reply-To: <20260831135206.126184-10-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

--O8kONWcbiWw0NXdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 03:52:05PM +0200, Hanna Czenczek wrote:
> Test delay-alert-ms via HMP qemu-io (break, aio_read/write, resume) on a
> null node (with blkdebug).
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  tests/qemu-iotests/tests/delay-alert     | 136 +++++++++++++++++++++++
>  tests/qemu-iotests/tests/delay-alert.out |  46 ++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/delay-alert
>  create mode 100644 tests/qemu-iotests/tests/delay-alert.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O8kONWcbiWw0NXdA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqZjzMACgkQnKSrs4Gr
c8ghgggAuxwulCT3ajIMqHH+rFgyWSAnf18wOCWV4xQ9+jM++hF6h/citAyZpvSj
tLk6mopEJ+N79QHq8F7jMfmGCZDA6e5ZtMuG2TNh5UIDE/4ZyHlxYMuo5ZmvGBT2
eg0gbSGYX+dwSZxLb9Ifr7BL4I8MDlgm19Q0FM9vPqtKQo1pdmazhLRIufXDYWRi
q9VgwZYDGGH5mLeYC2PexldWRKduPOeSan0OiGGRJ+G5pZgHFDMRuwbOzcVGh8ni
RKOhUlpq8leDn8MqmRGK0XZJpy+7j3P5rg3N0YyVKm6pFHGHtC7VuZvFxhDiiQSB
pe68Y/zWq7JFBqVBCemP7qNXay+HJw==
=dT7r
-----END PGP SIGNATURE-----

--O8kONWcbiWw0NXdA--


