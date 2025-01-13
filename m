Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455B4C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 16:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXMtF-0002l2-Gx; Mon, 13 Jan 2025 11:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tXMst-0002hH-GG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 11:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tXMsq-0007IH-Bn
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 11:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736784099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uBXnxJYG4EvQviFkDPeyyrWU4TK9Aji5EC6wvLY1cws=;
 b=N6R3HZaBU9MAOGaaXwsY5OOTwML7cgcRsFTA30JZaQ52yZh8sO2ubCuIjs/MIUmikKdjho
 E99SzgAy8ArHsJZlrTF8Xn5wArGRRjbWnKutrHbOKuJiExLUkGbFRgte4wWYSBI8X7ZJe+
 byjDnQueIceaSj5Q5a7RinGw492cZm0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-A2wEbcXDNrqWug2jNScgmg-1; Mon,
 13 Jan 2025 11:01:37 -0500
X-MC-Unique: A2wEbcXDNrqWug2jNScgmg-1
X-Mimecast-MFC-AGG-ID: A2wEbcXDNrqWug2jNScgmg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF4DE1956083; Mon, 13 Jan 2025 16:01:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76C583003FD1; Mon, 13 Jan 2025 16:01:34 +0000 (UTC)
Date: Mon, 13 Jan 2025 11:01:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/11] target-arm queue
Message-ID: <20250113160133.GA72086@fedora>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Jbxue/dZRY5IH9n4"
Content-Disposition: inline
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Jbxue/dZRY5IH9n4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Jbxue/dZRY5IH9n4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeFON0ACgkQnKSrs4Gr
c8jL8wgAnX+N75+sxlH57ooZctISGOon2OGNrs3AGqMcKpSKNoIyeYZacG3U86Zz
mFrq1iVOFGputNMvNozF2o0twkfE09GFc9+VddOy4LGN+xlKVm+ATgAbP9Bf29cV
dLFfZn8yw5x6yv1QphZJYDZdrs1dkS8nGlaeItGdLLOVoppxrxrKy9jedEMgtHfr
IFNL7uu92swvjVHuiHG8eH9XKomzB3zz1v9FbFSkFFE/zmYevaiAGTrKQ8VtVpVZ
Arnyib7gn/akpsbnmmP3RrsEC5eF4yp0JQ4b5/mAywZSeQUXXaUsSnRIea6prQHn
oyLbWF2dPqVU0NAVma2jQ/XAVrNACQ==
=lpKW
-----END PGP SIGNATURE-----

--Jbxue/dZRY5IH9n4--


