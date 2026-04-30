Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F348CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVIx-0003Cl-76; Thu, 30 Apr 2026 13:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVIg-0003Au-IC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIVId-0008Su-S5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777570541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AqZ9PbbPb+LzIQyHM4ZcAgBsGLr+j+qRX0cBlgJpz94=;
 b=b7pyTEEnqRxOskJMNDqdQmEif/ArDExnM0ESOSlb6j0liYrtrrqrfZBXWyQglWg/CpgTo6
 DII9LiT7hRzkScTHMiujulr1lnveLTkd3Rzuvb128IJWR/KF9gjXaaAeWzZUIErWC3x4+u
 u2oaPuDLCgoXi/0W4Xz+KyGQwYUnC1w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-8Z_4QnCGO2-KIf-5VDZg-w-1; Thu,
 30 Apr 2026 13:35:38 -0400
X-MC-Unique: 8Z_4QnCGO2-KIf-5VDZg-w-1
X-Mimecast-MFC-AGG-ID: 8Z_4QnCGO2-KIf-5VDZg-w_1777570537
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 826201956054; Thu, 30 Apr 2026 17:35:36 +0000 (UTC)
Received: from localhost (unknown [10.2.17.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85521180045E; Thu, 30 Apr 2026 17:35:35 +0000 (UTC)
Date: Thu, 30 Apr 2026 13:35:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 0/3] Block patches
Message-ID: <20260430173534.GA31740@fedora>
References: <20260429182127.219776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="acD36lWmIzgHCxCl"
Content-Disposition: inline
In-Reply-To: <20260429182127.219776-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--acD36lWmIzgHCxCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--acD36lWmIzgHCxCl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnzkuYACgkQnKSrs4Gr
c8i8pwf9HWd7ryhEFEObb5wSxolg/oSQEHPnBjfhDWgnh1oauwHnGoRUBFYzpT5J
pD4RawGf0/QD0xaSsfPkWHYD5xjTZhxJpwF77ODIIYQhu3tvKngwa+fp7SoJ53bK
wiDYd9S0Oj2IIBFor1E/DKeyWDOs/xXEd4BhELrGASOUKwAVTnHD/Is4TyPmLQq7
oHuqS8DSl1x3JMtcaxNaYAg00BhTLyKm4FWJKK6p+n3ez9iPIO4cUnRkyd92PYVl
UxVuM+I6theOVze+QivRVzRI8sj9d0sJaTZM/j/e5g6HakwuY2grlpvg9eCqsCSG
LUC3b9oqmUMYVFbidiUmnaek4ZTHNw==
=6cAk
-----END PGP SIGNATURE-----

--acD36lWmIzgHCxCl--


