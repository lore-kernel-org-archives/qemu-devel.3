Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9711C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trUGP-0001xG-Nz; Sun, 09 Mar 2025 23:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trUGL-0001tN-LG
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trUGK-00043f-3C
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741579026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1QH36P1tkR5QzJNb4BD4t0CX+9+ARkqHtRYNWTKfyWQ=;
 b=S1rW/TRO2Qio+egPy1tio67kuWyJ1gNRuAJoL+5Nc7hDO2TwLVAO5OcECzdtEtKThjrsDD
 EsgEa3j42DD7ObrQKpqzGC/5x2+aG7uNwYLFaLYcvRPuIIGUrYNKjzCj60NihelP8rDAr0
 j6Q/1tmFfEtlvWHXJTvDcCmj/xrUbkk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-l84BPLeIMquNZJVtPyn08Q-1; Sun,
 09 Mar 2025 23:57:02 -0400
X-MC-Unique: l84BPLeIMquNZJVtPyn08Q-1
X-Mimecast-MFC-AGG-ID: l84BPLeIMquNZJVtPyn08Q_1741579021
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA4D3180049D; Mon, 10 Mar 2025 03:57:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9703E1956096; Mon, 10 Mar 2025 03:56:59 +0000 (UTC)
Date: Sun, 9 Mar 2025 08:41:39 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/21] target-arm queue
Message-ID: <20250309004139.GA50643@fedora>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EtANYVMqvejVjR4l"
Content-Disposition: inline
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--EtANYVMqvejVjR4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--EtANYVMqvejVjR4l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfM48MACgkQnKSrs4Gr
c8iwrAf/QpPJ47QDtByNCjYGvjFMaYr7DAQL5gc0YXlfEwg3nTqyNQGAfHJYdqx/
zB6OwWbtORMVzsMVNf04+HvyFBa+XrCDhboSzwdSxgGz+J9XHPOHKAOOFVyB/uyf
fPpnMIdGoUd3tZNfAgBsdxU9dwpXTjdO4xZZHdcx5j9NCxmg5wdAqPmnaONw/zGq
1+8ePPp7Wv0lWa2YXd+PR3m5GHxkhPifrDAeCUqKwhywq9jGy6+HYAfYgmkEAP4N
4mf0seb99oZ5m7ArhJ62/X9nGs11XjF+zm4y8ybK6usZbFy83ZdFrtUg1s+c0Ihy
8/InrUdrzYlr9nvl8kOgFxKJiG8wzA==
=bF18
-----END PGP SIGNATURE-----

--EtANYVMqvejVjR4l--


