Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF75EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 04:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi3Dz-0004FT-2K; Fri, 10 Jul 2026 00:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wi3Da-0004EK-46
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 00:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wi3DY-0007lk-CK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 00:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783659123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vudsYPpxXaey5fPe3xzwztqZJ8906j2ngB/7+pdmvKw=;
 b=KW6TWa40ucLvh2O/p5OS/WAmWty+WIzf5iLwyIrlRQTnckZlzSV8qfEQFR/OmGSjx4XVuG
 RLRlL/J+t8Q9gu46hFVm6ZTpUjgBUDxWbMrJxo0isonsQ0W97pkvFjXhjNtbKpDvu9IG4L
 lB9Ao+yRoGtPvAtvAIrsdPiY4ZveViI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-DpBLsVAyNCWTT4h8FsMe0g-1; Fri,
 10 Jul 2026 00:52:01 -0400
X-MC-Unique: DpBLsVAyNCWTT4h8FsMe0g-1
X-Mimecast-MFC-AGG-ID: DpBLsVAyNCWTT4h8FsMe0g_1783659120
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9F5C1956066; Fri, 10 Jul 2026 04:51:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBDC43000C01; Fri, 10 Jul 2026 04:51:58 +0000 (UTC)
Date: Fri, 10 Jul 2026 06:48:07 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, stefanha@redhat.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: Re: [PULL 0/1] ufs queue
Message-ID: <20260710044807.GA604192@fedora>
References: <cover.1783552661.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k++7mnjkjuV8dX9y"
Content-Disposition: inline
In-Reply-To: <cover.1783552661.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--k++7mnjkjuV8dX9y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--k++7mnjkjuV8dX9y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpQeYYACgkQnKSrs4Gr
c8g5eQgAlb0H7y05yF33qlPanrrvaTbv/e4Ca9/92xUJ1GHZRhaRRaAacdhBcnSm
qBk9y17LQZjD1KYj4JcdWvU2QpIRgY9C7gEbzaVL0BhIHg3qoD5VNoCB7YwWDnjj
UcoekTHeJoBp4szAyRgP+fUKtBcce/kL9JonL7GdyGxV1e4jy5qmKXivbVOQ+A4w
8dhUWZanrxcpLOtW1YX9KxHPf2WRIgMGVuo5vauUYVINVeoaqqX5nIxpbQigCRnJ
KJke7FB+rZ4FXJBAogfHsXgm6vqpoe18KQKJGT3UNDPjA2sRd57G82KO6+fyF/u2
+HRdjNogjDSJaNra19NcwiZWQXgwmQ==
=yHlM
-----END PGP SIGNATURE-----

--k++7mnjkjuV8dX9y--


