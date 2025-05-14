Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486F6C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC40-00061H-Sz; Wed, 14 May 2025 09:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFC0A-0001Jo-33
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFC06-00033Y-6d
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747228691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mw/v1a9HhmS4Ohv5T0B9ZutLzvEJjGpUKtR+zS+yVOU=;
 b=S5dfRfYn67DcDzo+EoLEl/+ekGY+Rw9aiENwVmJTO9iyW5RTlNQB/4Z0qAO2jeGIMclhtZ
 4pjiCuPio7w6rCx7RacxLaogNxs9mBkxdwZNu+QgTDTmfhFb+VYfVLeP29UI20/9byb4JY
 FUb6DBAwe+8Z8cc0KOZNBk51DR5UmNo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-EtZZ5FSIOG-UQ2LohpP0KA-1; Wed,
 14 May 2025 09:18:10 -0400
X-MC-Unique: EtZZ5FSIOG-UQ2LohpP0KA-1
X-Mimecast-MFC-AGG-ID: EtZZ5FSIOG-UQ2LohpP0KA_1747228689
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D235180036E; Wed, 14 May 2025 13:18:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E7A518003FC; Wed, 14 May 2025 13:18:07 +0000 (UTC)
Date: Wed, 14 May 2025 09:18:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 stefanha@gmail.com
Subject: Re: [PULL v3 0/8] block-job patches 2025-04-29
Message-ID: <20250514131806.GA265199@fedora>
References: <20250512152940.1294079-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RCpBeRPkkw4yRdjn"
Content-Disposition: inline
In-Reply-To: <20250512152940.1294079-1-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--RCpBeRPkkw4yRdjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--RCpBeRPkkw4yRdjn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgkmA4ACgkQnKSrs4Gr
c8hgywgAh7AR7xhBggH701133I35sgx/3im0But4dqJYZj0mXTR4cC19QNJSBG7N
uqJumP8vZJ58rP6F74GOl/JYSUOz82JgDipg7wJI9QXrEEi4SproJvd+qJazEyk5
J3naUnCU9Uh+by0YevI0CMyaneXRCHiPxy6o9YD3X97De1NzY1mew9KRCn/LOqmZ
tzTcB12ZljGltAguqeaaVgvZg8Ca3gxalziWCT/ZRMz9wMn4eCqseYfyOx9Uojuh
JyRDdPAVfz+ebUzkXq5pYjc6sPOkF0KfgdMc6j4znmIaP+EG4OmeWFKeXqXaMNTE
jaO92TgRiisR1AYWuDjPQgK80Usq+w==
=riip
-----END PGP SIGNATURE-----

--RCpBeRPkkw4yRdjn--


