Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220BFC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjti-0007PI-2c; Fri, 17 Jul 2026 10:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wkjtg-0007OR-74
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wkjte-00025M-Dr
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784299837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+M74bxpl3GcocDoj0ZTEtuFdGhW3O0DOOq4pDkCai8=;
 b=M6EM5KiK4MXkhiqEUpJINgUi5TKJPQY5IwDDcanW+OaZYPT5bfCj/w2CUrxWHdS/WaSyPJ
 k2kduwOVHugw2uhMYKmlLspGhIdaTzVuWRx3D+DHsnPPGXgCFtoGnUYZeLDsNcrsPXIVqe
 tunUjfMtL3PSSiumtpg2MZTBzyciVI8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-1TyflqddMDCh8wQbzNSfxw-1; Fri,
 17 Jul 2026 10:50:33 -0400
X-MC-Unique: 1TyflqddMDCh8wQbzNSfxw-1
X-Mimecast-MFC-AGG-ID: 1TyflqddMDCh8wQbzNSfxw_1784299832
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A2391800BDD; Fri, 17 Jul 2026 14:50:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.229])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17D44180029B; Fri, 17 Jul 2026 14:50:31 +0000 (UTC)
Date: Fri, 17 Jul 2026 15:50:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] Misc HW patches for 2026-07-14
Message-ID: <20260717145030.GA749123@fedora>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="krOzWQiJL/jsIUJ2"
Content-Disposition: inline
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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


--krOzWQiJL/jsIUJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--krOzWQiJL/jsIUJ2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpaQTYACgkQnKSrs4Gr
c8i2Tgf+O2Bcg1f3BD5mRPqMeG0ghdNYJdXQNJVAl9GuQL3ZdRdGq1dMDEaOP0sj
F6OsdNzB8tgSpTrmRWqFrzASoIEA9J06hnKEbAkjT2TbVTTZNdZJtOCxKrd7rft/
Fkv0cAkn1IhKdc6MhSA/NjNN/TGfaUa9Fnb5BaQSksmefLUQc4br8gAepIYrFPhw
c7Hy5U6ZRATzE1rGSyfC5u+USBPUe4HzcViQgyx+UOU8yKLf1v/lTcqH8a0tIzcG
aOXCPfLq/09iCJVljy/cT6mcxysb4KHPbFJ/UkAmWDTjhAhSDzHqHa69oNdXsAA0
fPpmicA8SxwnF1V5OEC6/kFsAeRhXQ==
=LQ40
-----END PGP SIGNATURE-----

--krOzWQiJL/jsIUJ2--


