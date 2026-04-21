Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1006EF94CA7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFIOu-000845-2Y; Tue, 21 Apr 2026 17:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFIOp-00083h-Jp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFIOo-0007bq-97
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776805968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4iY6tDg2VjYozxVRxZlX/JEU//pNZ4zTJzziDPcsEU=;
 b=PPwGMJmtkRvs/zgbgFke1RNEKIQfiIQ3udbC2ZYGCu67YG5NlDxYckdBvu0Hqth/Ojs6VV
 pDTRNLMIVcYsR6NSNMBue2MiWwXpO1XkcTGUs48oSNsRGc9sZM8ZOpj8OMUMDYAi8vmxzZ
 uTNDyOuFRB+gnnOIGPn58OYsR6FzMbo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-1Y58pOq7O6GItg9LnQN0dA-1; Tue,
 21 Apr 2026 17:12:44 -0400
X-MC-Unique: 1Y58pOq7O6GItg9LnQN0dA-1
X-Mimecast-MFC-AGG-ID: 1Y58pOq7O6GItg9LnQN0dA_1776805963
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5583195609E; Tue, 21 Apr 2026 21:12:42 +0000 (UTC)
Received: from localhost (unknown [10.44.32.90])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 883561800357; Tue, 21 Apr 2026 21:12:40 +0000 (UTC)
Date: Tue, 21 Apr 2026 17:12:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jorge Moreira <jemoreira@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260421211237.GC466778@fedora>
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+ty7g7TBfkBFfUng"
Content-Disposition: inline
In-Reply-To: <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


--+ty7g7TBfkBFfUng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> While starting the vrings on SET_VRING_KICK could solve the state
> machine issue, it still won't notify the back-end that buffers are
> ready (the driver won't do this). Non-polling back-ends depend on this
> kick, especially for queues where data flows only from the driver to
> the back-end. Most implementations likely attempt to read from the
> queue only after receiving the kick.

This is an interesting question to clarify in the spec.

Stefan

--+ty7g7TBfkBFfUng
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnn6EUACgkQnKSrs4Gr
c8hrCwgAvIY6BkFu3IzSsD+Ui67HoqflSS2rca7UWRo4KuI2slrRgypklDNiCBuk
IhK3STGWUaaE3gKQViGaArjDRXf9rZbzA6NBJcsA0JKGIk3TsYICYJTZ6i4o6NQu
BMIC1RNh0R/AcdfTJY8iKgyg7KgwLtuzKI+ztkk4grZgLhcFkHue4FJT+Mh/VTPy
xRQSSdZOp/+A9j/7skMjV9yWHmCHyU6HIOdYS71WUdv0smufJBYEcd6TuxLHofZJ
caeJbmBzrJJWjzoMNKzWf5IBlAsNCSv48oDRpAvR7FsFwrDz6xkssjTiH+SHUdAe
Q/b1HWtrm6ULJBOyb6QOveQInJOy2Q==
=kgsf
-----END PGP SIGNATURE-----

--+ty7g7TBfkBFfUng--


