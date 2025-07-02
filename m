Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9F5C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyXL-00035e-9B; Wed, 02 Jul 2025 10:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uWyXJ-00033o-Df
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uWyXE-000410-NJ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751466842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PzV1bDeDb27QKnKC1Lg2roOkqHiZ8Bn5SDAAv9m8wE4=;
 b=BfeJ50qQAoTvsuMANFjMJe2TkGgO34RU7m/TMjqqNlZMvcYZ9E3H7DaPxPbe5+SCC7B0Ui
 n2iLrqObuBvXYJMJl3tuENJp/7djuqBOUPNLBPA90+yWcfAp47L+M7q7W6JTiiPANJSJqy
 BGJFG0MhL6uWEPrVppcgMeP1fC8g/hM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-QFEIy45YNsO3CznBkVUGvA-1; Wed,
 02 Jul 2025 10:34:00 -0400
X-MC-Unique: QFEIy45YNsO3CznBkVUGvA-1
X-Mimecast-MFC-AGG-ID: QFEIy45YNsO3CznBkVUGvA_1751466840
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE15918011EF; Wed,  2 Jul 2025 14:33:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 154D930001B1; Wed,  2 Jul 2025 14:33:58 +0000 (UTC)
Date: Wed, 2 Jul 2025 10:33:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/43] target-arm queue
Message-ID: <20250702143357.GA59158@fedora>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+GXDXUcbsrwNharR"
Content-Disposition: inline
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--+GXDXUcbsrwNharR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--+GXDXUcbsrwNharR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhlQ1UACgkQnKSrs4Gr
c8iC/wf9Gwf0BB87TAIuC9hosGjZrF3p7AUvR41O2swUy8cwyh2sNMzeNdMDhbtl
w+kjZrVQcXFO+EmaVH/GV+N41Rd4xGcf5Q+BgITrcr2LQLA1Bigx2avrG0JDMs0i
FTyOGgM8nVMPgkJnEleIxdnh/Fd+es02vH2zpOMtlx5JzlZUyhnPbQfDDBfYciSF
fOvycPcR7T+M3ldG4RpZM1nEZQ0Gvvfn1dTN0eI4s02uHjos5GPMHL5wvQU5wy7e
8/x10itRrdE94tjz4qzHWse7Rjm3WUIy6dzZS/9Mm50S8IfIf4yB+8g1oMwLSfVS
+YlBivgetwKLu3aw8OKueLJvuMyUig==
=QsFL
-----END PGP SIGNATURE-----

--+GXDXUcbsrwNharR--


