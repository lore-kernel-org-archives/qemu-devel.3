Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96442FF886F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsed-00026O-5i; Mon, 04 May 2026 08:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wJseb-00025l-Dl
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wJsea-0002XS-25
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777898643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=heZTRlIEsYy6Sm7IaOT0gM/jfUTfKGmhBAVpCsLYzls=;
 b=OH0FlW1ExC6k72KPIjkPSDq2zGZt0uLH66wr6iFVc+1Dchvk5Yec/dJS8gfV3p/p0v8njL
 UUSDHj2BDZu7jWagNL8As0/cp+b1pL6DPdDYObEB+pLmjePt2fEWDbAx3Pz010+jd4mej2
 ZF/bo+YDyxcEGmnMp70zGlGgAP/CZXo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-yCKhZ5WcPs-xX2_au3ERwA-1; Mon,
 04 May 2026 08:44:00 -0400
X-MC-Unique: yCKhZ5WcPs-xX2_au3ERwA-1
X-Mimecast-MFC-AGG-ID: yCKhZ5WcPs-xX2_au3ERwA_1777898639
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25D731956052; Mon,  4 May 2026 12:43:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.109])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B77A19560A6; Mon,  4 May 2026 12:43:58 +0000 (UTC)
Date: Sat, 2 May 2026 06:49:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL v2 00/11] First batch of s390x updates for 11.1
Message-ID: <20260502104934.GA81694@fedora>
References: <20260430160307.634093-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YTsxuSGkakdjAgmk"
Content-Disposition: inline
In-Reply-To: <20260430160307.634093-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--YTsxuSGkakdjAgmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--YTsxuSGkakdjAgmk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn11r4ACgkQnKSrs4Gr
c8itcQgAnfuCkpZIMkMRY9iOojpRXplQNENCMhdZ3pZsxhB8PRol63hBRAO/wo9H
onYBVHCA4JzMHIhukllHw8mD+5g4HSYUsE/jWUO7JKR0+om8eeG2V4T8kTi8/25e
TzSgBMPdu8zU7JY3sXg//j1OBcKU/nB5QeSsGjYIhr1EFnDpYjrh2O5033zrv5GK
nCxro1vIsckXaESd+gLF5jsTFk2NQrb/EEBPaB5l5GfFet8Zo2b6P4hqWVx0OATE
enIbRpEY0cEwIBV7w+D1SLTkXjoIcmt3cTd4md1rfJOrNITvFAtagwvVgC3ygDmU
lhBduBT3Ek7kRXGgm2WeIPDAzK0v9A==
=zwXX
-----END PGP SIGNATURE-----

--YTsxuSGkakdjAgmk--


