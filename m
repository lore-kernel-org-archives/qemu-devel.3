Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B5DC44525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlknx-000454-DQ; Mon, 20 Jul 2026 06:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlknv-00044c-OT
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlknu-0004Pn-4j
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784541653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYQTrYlHTk+prNLrpXUWxI0METXLX980uH26S/8gHAw=;
 b=A1L0tOCR6CpYpoyPsdKVU5Bwm7H6VgeAt5/3adRGzwp4DAJjJYDW70RT6Jhi2z/iDNOO9U
 iMNULs2LgNRS73t9Pvz7WUZI55BYQlWrisKnvvMCP8F8RtpfPzupy3iibznGHk043lVqTG
 xiTecZfXbttW7bAK9g0EPP40i+3S4Bc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-Obj3fnv9MI6PBmOVweVX7g-1; Mon,
 20 Jul 2026 06:00:51 -0400
X-MC-Unique: Obj3fnv9MI6PBmOVweVX7g-1
X-Mimecast-MFC-AGG-ID: Obj3fnv9MI6PBmOVweVX7g_1784541650
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51EA9195E90D
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:00:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.56])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E01E21588; Mon, 20 Jul 2026 10:00:49 +0000 (UTC)
Date: Mon, 20 Jul 2026 05:59:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [GIT PULL 00/15] Various UI/security-related fixes for 11.1
Message-ID: <20260720095953.GA815529@fedora>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DcNfUhrsWxUCXWi/"
Content-Disposition: inline
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--DcNfUhrsWxUCXWi/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--DcNfUhrsWxUCXWi/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpd8ZkACgkQnKSrs4Gr
c8imVggAkf2q24jAZQC7Cl2YjqU7cwtSDGM/bf8lgMa16z0q6+bZozmR14DnrveM
CatCSSITtyd3VCf/CgJwkeAK6KyEUMmqqSSuG4NyO0O+xsXHp1akEc2Fe3+sxe3e
dCH9fJNmUpiy9m1HcKt60fY9VDq7L9+QUP8T0I/RFAWJUM4vR+rhq81yTiwSYLXy
OH7ag1B+EoFnjGBPxpeLdwOnAO0sDHP+EeFCgH0NrB8qoLxt61B5DVGMCSs8wo1A
ZFsdIwOEc4zoJo3wO4XfwwUr+8bxg8wXAUdyJWZvecE+TGMV06LZbuL8TO9fNaGc
yeCNusHxFGwwTndG1eKP7k1tMQV2IQ==
=S8m7
-----END PGP SIGNATURE-----

--DcNfUhrsWxUCXWi/--


