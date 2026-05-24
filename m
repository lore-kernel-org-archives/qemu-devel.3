Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE12CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 19:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wREHy-0001Yg-9X; Sun, 24 May 2026 15:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wREHt-0001XY-KP
 for qemu-devel@nongnu.org; Sun, 24 May 2026 15:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wREHr-0006LV-9l
 for qemu-devel@nongnu.org; Sun, 24 May 2026 15:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779650097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UWf5w+zd1+278jl5zDqy1BLGq30IxbIkBtdd9upSmKw=;
 b=fEx6KkUUdPTd7t2xZS0BUfIIS2ZIIev4f6n07Fkh53VN1EM0+KScLVjtnMMme+Z0FNwhJ4
 BFEwxL8hwuZf4eG/ZTeFSQf1XBRACNgg4fvOURG/YwBQrWuLdbAQRlGT4rIfArlV9qMRxD
 c5mIzYQcfmFHnrsDN0/V30Rq5KCJXTs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-RbS4OQpZN-yYKTEprf87Yw-1; Sun,
 24 May 2026 15:14:53 -0400
X-MC-Unique: RbS4OQpZN-yYKTEprf87Yw-1
X-Mimecast-MFC-AGG-ID: RbS4OQpZN-yYKTEprf87Yw_1779650092
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04CFD19560B5; Sun, 24 May 2026 19:14:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4E43300019F; Sun, 24 May 2026 19:14:50 +0000 (UTC)
Date: Sun, 24 May 2026 15:13:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [PULL v3 00/29] Misc patches for iotests, qom, crypt & io
Message-ID: <20260524191344.GA1497546@fedora>
References: <20260521134943.1714527-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3yygpHhQ1rNKuBor"
Content-Disposition: inline
In-Reply-To: <20260521134943.1714527-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


--3yygpHhQ1rNKuBor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--3yygpHhQ1rNKuBor
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoTTegACgkQnKSrs4Gr
c8jQNQgAkcg+5NbCGfjXuPnkBz++80rRymuuRUuaE7/v9aXPAbUUD7/3rtgLEyoN
QE0c9Xam0ac3cJCcPHh+ol1hKpzNC0cmwKv4i2prrflYH3g1jxdN1jSiLOsAdyfw
PIMo69E5nSaBkGhKphyswWBQXS7wOgoRjkPX3pbq81arJdq3bd3xXZovpdDUcgT9
5CBqYpn8Q5Aqn47fU1oqkSCLSh5Ev1RfW/I/LFVSlNAbit+fI2RF0PBlu8FA54Xv
BL1wPVeqPSuBsMG9joLV4w/KPx/LShYB5+hTtkldnI8qlBBCYJ2B9EZ/oZ3D5IiE
twZ72P+dxnUng24YyyzVgKPNMToINQ==
=hBee
-----END PGP SIGNATURE-----

--3yygpHhQ1rNKuBor--


