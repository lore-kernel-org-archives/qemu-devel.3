Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9563EF589D9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFunQ-0001Tn-Td; Thu, 23 Apr 2026 10:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFunN-0001Sw-54
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFunL-0004Ek-Gr
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776953562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BlKALc8CvktyKZkpot/Rpuk5SHpy5FStSc1fGsvx6p4=;
 b=e//22aR/hih+USXKg6yKnZGbjaH8i8pt652lAvUWtbK3LmWTuNT4jishQJjVmySozX7h2o
 LHXCLowAgXbAi+5ELfnhOlnlUE7HBnEsVMgzp5XZOsdtAVS+Cf0+WInYoRSU4UyHBtfRC1
 8afnjL7x4WUnAb26WWOIPUoAf8GWCnk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-UfDnantMN2abAoOKwher9g-1; Thu,
 23 Apr 2026 10:12:38 -0400
X-MC-Unique: UfDnantMN2abAoOKwher9g-1
X-Mimecast-MFC-AGG-ID: UfDnantMN2abAoOKwher9g_1776953558
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6D1C18001D6; Thu, 23 Apr 2026 14:12:37 +0000 (UTC)
Received: from localhost (unknown [10.44.34.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B279180047F; Thu, 23 Apr 2026 14:12:35 +0000 (UTC)
Date: Wed, 22 Apr 2026 21:03:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 00/40] UI patches
Message-ID: <20260423010342.GA517451@fedora>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q3Mb4zgKS5kfkY45"
Content-Disposition: inline
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


--q3Mb4zgKS5kfkY45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

--q3Mb4zgKS5kfkY45
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnpb+0ACgkQnKSrs4Gr
c8jPxgf4zZPcveJH4lLzfNGhriyEyQL5/9FZKhMaySXVytTXjW1UQB754V8tKOFX
oc1bYTqYykJfl6iFgnhJMdLL7eoEBJGLdHBWeeb2gHH4+I9bYctwZygBDpoxzoPw
khpjICEDiTtynyqaExnsvTWEBpbBY2+vsLU6mZY27uVCxh7Gw7eGzOWxLw4qgz8G
IQnZZSTW/No5oDIMd1mgG1M81TTTRShqXcLkmE+vd97ImUWoa36Y/U7uvLeAD/k+
TVbsWIZ6nNm9FY6+Z3zx/BxBqRIub1gZn6Gg9/hMbyOZUDcAwlm/0cNuMYnXeGEv
88rvWsw1J9GS+K5gkj/wuJmOnX87
=Lnms
-----END PGP SIGNATURE-----

--q3Mb4zgKS5kfkY45--


