Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB61C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCuN-0003W2-VH; Tue, 21 Jul 2026 12:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmCu8-0003OV-H1
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmCu7-0005PJ-5A
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784649669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/VkGBcWZOfSkKW5mIizHqF05kfAHFyvRbi4Ln9kST6Y=;
 b=JBYtnCh5hU41MTvA0reDdzkw3gAAlaC+7IZywG4YdSR8oXTpHissMwwLqarfyaX50+vX5x
 cBx/ZxOZbBatvJgTZx98P4EdZvuYtNDWwwiRaFuaxENkMgtWTBU9fuuUNSsTPyzCa6OaZK
 Q4srzFLfBR87aAd2LwgwHiDvKxAhj+Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-EXAJl7p3OB6iBcEm8uxAzA-1; Tue,
 21 Jul 2026 12:01:05 -0400
X-MC-Unique: EXAJl7p3OB6iBcEm8uxAzA-1
X-Mimecast-MFC-AGG-ID: EXAJl7p3OB6iBcEm8uxAzA_1784649664
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 148C61944F09; Tue, 21 Jul 2026 16:01:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B73C71800769; Tue, 21 Jul 2026 16:01:03 +0000 (UTC)
Date: Tue, 21 Jul 2026 12:01:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/16] target-arm queue
Message-ID: <20260721160102.GA208598@fedora>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jrWpd1x7YNsosHs/"
Content-Disposition: inline
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

--jrWpd1x7YNsosHs/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--jrWpd1x7YNsosHs/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpfl74ACgkQnKSrs4Gr
c8iLWAgAr5JDbswb/kAxoBcwue2nV+WmFfG8TjklI12WFxJsORP09jfJwzGTZpfL
59NzHnQYBar6X42755OGGajDZl7uVSEUhdWWmBhNrC1l0kx0gwqsAt2gwWPxI0DN
1Dae/dHqEZzJh2SR3n37v1PUtyrs9EaBP3v55N9U9W997eRPKL5Ivs/NVgxPB7Su
ljnHnXCn9zgTU7Ftoju07/CaHw2JLfgFq1cs+TdOcOl5myDZYJ5+qwEbSHNAzjsE
IPbJ8CA84lIdY2A2428vOLvpljMlPKPg/26obp+bJ4Mm0a6B3f2Ui11H2wcgGPn2
K+eds8E/HdUVTS8LhMoukTCd6T8IXA==
=Sv+n
-----END PGP SIGNATURE-----

--jrWpd1x7YNsosHs/--


