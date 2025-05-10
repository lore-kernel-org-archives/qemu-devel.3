Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58ABC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 18:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDp53-00038D-Qg; Sat, 10 May 2025 14:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4q-0002xp-QG
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4o-0007ej-Gu
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746902254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KadWgkCBmZmgVnWQ1Ss7Pt+6fnsKwIGOSxdHcY6NPhs=;
 b=B8BJApcre+ZxzeYBS0UoGZ+Blq18jvzA7s7koU3Tzg17ev+Y8ipgZsugyopEnSC1RCq40A
 rb33jfNTXVa4G+VdrkdZ+n8ILyzApR8PdGkvnYCvZ/B2e8LK13EreH4CnPvSVGDF1/yCk7
 Hr1cGRpkwPIERzB32cyIGH9b5uQqUnU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-bZz1ljYKOoaBOuWPFkLvgQ-1; Sat,
 10 May 2025 14:37:30 -0400
X-MC-Unique: bZz1ljYKOoaBOuWPFkLvgQ-1
X-Mimecast-MFC-AGG-ID: bZz1ljYKOoaBOuWPFkLvgQ_1746902249
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4A961955DCD; Sat, 10 May 2025 18:37:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.39])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D31E618001DA; Sat, 10 May 2025 18:37:27 +0000 (UTC)
Date: Sat, 10 May 2025 14:36:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 0/3] Block patches
Message-ID: <20250510183607.GA116961@fedora>
References: <20250508142234.44974-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t9RZ3QRyL7QyjCky"
Content-Disposition: inline
In-Reply-To: <20250508142234.44974-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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


--t9RZ3QRyL7QyjCky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--t9RZ3QRyL7QyjCky
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgfnJcACgkQnKSrs4Gr
c8i//AgAs15rYTwqRgizjjPKF++//S4PBDVup51u6cmt4Ymo3oq6WLNA02fvsmk4
+9yUgMx+XVE+pipMmUWbzrkypr+ZUXju/2nv8EgtOKJGJV0WyVdeHS/32UkKt4dI
3XGp5NGKERG7Aaow558NWgNiscEv43vSKEfmHhWqxOgZARAHYgzFgVGCxCyt/4KT
dYmNYG2DV3lU+FHJuFTlmoXLQE9TalZQLAk/qUjbrX/x+lwlAskHN5kDX1v8vFwb
RUSB67vMd2j/JuiPTvxzyvzx+t29aNSHhh9D5zY1aisH2P7TNkUWoR0hjdPowWcw
ex/S4kOZ7qAmeejM2VHledW6g0c5ng==
=Ri8E
-----END PGP SIGNATURE-----

--t9RZ3QRyL7QyjCky--


