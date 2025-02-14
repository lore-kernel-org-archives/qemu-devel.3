Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E88C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwRn-00088N-Gb; Mon, 17 Feb 2025 03:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tjwRk-00086Q-PG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tjwRi-0001yX-TZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739780741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sTiu0sm4HdhvWsAqAwg5PAz5q5MbU9y+Rxyc5N2c3Ks=;
 b=XWdTkcGV85NZnDW5xXpWvUAeWuUyrqAdTWy05Qppe4vmtTvRrJ36Il+x1WzuHD2GZ/2Rno
 e1HxHzsJ0OSGlGYFCOvEoXfm2rwRYwrJ8vQ2MFDiTVGNXMsx5IMx6xi3Q8BmjEoSTirAn8
 yLzk3RVxAmKQDgOi5zye8pJqtoUiFlQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-QjTrfDBfP5GEmIq2JYgbwg-1; Mon,
 17 Feb 2025 03:25:39 -0500
X-MC-Unique: QjTrfDBfP5GEmIq2JYgbwg-1
X-Mimecast-MFC-AGG-ID: QjTrfDBfP5GEmIq2JYgbwg_1739780738
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFE72180034A
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 08:25:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2212A1800358; Mon, 17 Feb 2025 08:25:36 +0000 (UTC)
Date: Fri, 14 Feb 2025 11:58:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/27] rust, Windows patches for 2025-02-13
Message-ID: <20250214165837.GA757221@fedora>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RcSx3Vz0CTDrGMa6"
Content-Disposition: inline
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--RcSx3Vz0CTDrGMa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--RcSx3Vz0CTDrGMa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmevdj0ACgkQnKSrs4Gr
c8gLwwgAlNX/byp9lB/YBARNvkW0BTNoF3Vkysh5wjYXTdDZojvzzGWHrFhH5lE6
XJOD6UeqgUlo7ueAlVwAWDv0YnAzoaZYmEnT9TJVw9bF9aF5do3BA2VWBOvx71NB
6Rj55RsIFOmWXbVrFOeB0/SRAAXIhnbH4vLuMdv1CHex80x18baMA7XZCnORlq6A
83/raTP1BZ/orUAvMsBRmmR+32faJVUrzlOWlXN20eD/CG1bMO9+RHMrY9BCXN1N
DSRZNo5V+Jbht22iu+LhTU5HTABuQuCiV3IbdtBmG8WQEAfoxnFhvzy8ZvIQE61D
L83eItZ+OAzwUowsk2rk/nEX+4E06w==
=oe6/
-----END PGP SIGNATURE-----

--RcSx3Vz0CTDrGMa6--


