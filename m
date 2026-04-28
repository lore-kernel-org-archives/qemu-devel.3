Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1E7FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHidp-0008Nu-Oq; Tue, 28 Apr 2026 09:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHidl-0008M1-Jk
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHidj-0002FS-Qr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777383494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Km4HD+Mlc1gaCwChdq/2OXbwUf3D0q9/erKJF1EOY3A=;
 b=cCDGoE8qnmjKUAF+G5OpErGlAQIBBw23URR4Q0LtU5CnukLFAC0fi93FymW74NrTgSbgYj
 DuoUNckk7l+PAqMDJ1vkAMMt8i1tZViV7h6aGoHf2WWvZBQrtcGLxDUTuaJgES17IjUWPT
 ULmwPKFhnM9Sz4Q/hXn3DKlJeI85B9Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-6apaetFCMvqE1QVqrz-8MQ-1; Tue,
 28 Apr 2026 09:38:10 -0400
X-MC-Unique: 6apaetFCMvqE1QVqrz-8MQ-1
X-Mimecast-MFC-AGG-ID: 6apaetFCMvqE1QVqrz-8MQ_1777383488
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D83A719560BE; Tue, 28 Apr 2026 13:38:07 +0000 (UTC)
Received: from localhost (unknown [10.44.33.158])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2A371800348; Tue, 28 Apr 2026 13:38:06 +0000 (UTC)
Date: Tue, 28 Apr 2026 08:02:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/14] Linux user next patches
Message-ID: <20260428120214.GA254456@fedora>
References: <20260425155140.50186-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VAcCkzw3ZC2sVsrQ"
Content-Disposition: inline
In-Reply-To: <20260425155140.50186-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--VAcCkzw3ZC2sVsrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--VAcCkzw3ZC2sVsrQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnwocUACgkQnKSrs4Gr
c8hoFQf/Rt989vMzhgEMNs70iiIvn0wh3UC/mOuqrNtWaoyHD7tDJPb/BHH6sBaE
otO3KU+OhrrgJ9lCiDIyMB41lNKlQRC864FvqGtAzAcd8IkRsm5qINwbsONZbzb0
WXhldNp9obTzLCiryyxvwj4vpfMNUmgGSNL9c92nLbh4hjP2NyRO0hnzGDL0Ilvz
Q3UYyN9dgnF1fQs/G9/hUYbMH38vfKIpoqUXTSnDamHXQu+PdTYA/B5QYFnyw6Cd
v+TnKbGSAUH1d5nEI4m0xlLYWw+GVyczsUTRT2XuH6sMVz+2PXwUX4bEh42Mq5Cp
RkO4eoyCWwEeP4/h93I1d3tFq3OCTA==
=otMD
-----END PGP SIGNATURE-----

--VAcCkzw3ZC2sVsrQ--


