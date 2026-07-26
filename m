Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DCEC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKxN-00040Q-7c; Mon, 27 Jul 2026 09:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woKxL-00040B-5F
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1woKxJ-0006AU-Os
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785157276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8+sdJYe+CSa72Aa0jD9kN2ktht8sdUDmZlcz7whWEM=;
 b=Fa8H/hW0/7PJBAhbd9TLMLf11H/XhXxbREH7c1dtmuvlWfSw7GA7+EFYoM91pkTZ3ZsAs8
 yboXfbibKe+uMUeriqnjVYE2mcy2dyzBBcDrGLU/EV0jv1xDWXmqWu92AlVURuDcZnuGli
 kgRlaNzFGu9Jg/7YU1mw5D1MhknPlaE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-XWqFR7wlNtiLiqXbSzsV8w-1; Mon,
 27 Jul 2026 09:01:14 -0400
X-MC-Unique: XWqFR7wlNtiLiqXbSzsV8w-1
X-Mimecast-MFC-AGG-ID: XWqFR7wlNtiLiqXbSzsV8w_1785157273
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8995B1944D42; Mon, 27 Jul 2026 13:01:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.71])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E92318001E2; Mon, 27 Jul 2026 13:01:11 +0000 (UTC)
Date: Sun, 26 Jul 2026 15:45:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jia Jia <physicalmtea@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PULL 0/5] 9p queue 2026-07-25
Message-ID: <20260726194543.GA291035@fedora>
References: <cover.1784977523.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P6W2+WKplCMGLCHg"
Content-Disposition: inline
In-Reply-To: <cover.1784977523.git.qemu_oss@crudebyte.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-1.58, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--P6W2+WKplCMGLCHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--P6W2+WKplCMGLCHg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpmY+cACgkQnKSrs4Gr
c8iwSgf9GBHewO01YG0H1QJgwRPo2VN99EotgM6yhmyzy6uRdwCNMcrU9JI+9zMR
//9x+0n5QHA1qTPPrVwp9/tfUWE9nkTqfEfugO4ea6k2Hzzvv5BZ0CobnzAlCSTB
zyHw3l1lAqLujlm4h1mNVdOnrszhqKCc041Cl1E5Ms847TvtPZ4467rotRQSw8qE
LugOCYwVOfN0z3Y42l/zCL3Z3yWKVO+TEgaPMOcaHChuzpsFOfpj/+m5VlZukiLM
iHIJSuzCzN4rIpoTA6wSqqJlKTmfxVDcCbOU0wDg5mU7LiT5EInH8px0gB5zrCIV
BqXzxBfkE+8pYgZUKqdSUfZVwqdsJg==
=ch6A
-----END PGP SIGNATURE-----

--P6W2+WKplCMGLCHg--


