Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E31CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzIP-0007lx-K7; Tue, 09 Sep 2025 10:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvzIM-0007jn-CN
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvzI6-0001k4-Cp
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757427948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqq3CqnMW/WffMk2rRPhAFizP/tifcBAbvzZeTt7EjE=;
 b=hBldHucBkZIQ4NI3Wmrkn+biQxS/26SBKl50oUYo53PpD5uYkGRrMAUg2CKzVs9Akvz267
 UFfjO5sCS8H2aU1QUFWkZEc+VKFDI6A7gk4Hy9Ln4bJC8GqLBYduG1A6HdM7CvOfEkqiGV
 wlB7fSZADdhWGB7zl0ra0DLIH+2KJJo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-l6wDbCivOSOcSjaJCuV4Yw-1; Tue,
 09 Sep 2025 10:25:45 -0400
X-MC-Unique: l6wDbCivOSOcSjaJCuV4Yw-1
X-Mimecast-MFC-AGG-ID: l6wDbCivOSOcSjaJCuV4Yw_1757427942
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47C2B180029B; Tue,  9 Sep 2025 14:25:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20F121800452; Tue,  9 Sep 2025 14:25:40 +0000 (UTC)
Date: Tue, 9 Sep 2025 10:25:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 peterx@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 00/10] io: deal with blocking/non-blocking fds
Message-ID: <20250909142539.GB218449@fedora>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <2a5b37b9-6bb2-460e-b9b3-0a3505f132c4@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vg8/lDXfibg848NJ"
Content-Disposition: inline
In-Reply-To: <2a5b37b9-6bb2-460e-b9b3-0a3505f132c4@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


--vg8/lDXfibg848NJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 11:12:25AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> On 03.09.25 12:44, Vladimir Sementsov-Ogievskiy wrote:
> Marc-Andr=E9, Stefan could you take a look at my series?

Please discuss with Daniel Berrang=E9 and Marc-Andr=E9. Thanks!

Stefan

--vg8/lDXfibg848NJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjAOOMACgkQnKSrs4Gr
c8hfaQf+KDUgNJzDpRZpX33BYL3P8T4U24rUEx/UUAft5Xw+lmYWYIr56+lgblo1
QuACnQ2yxGuJUGxSdR2RGdop4nv1Kq14FXKYX3HGhww+ZediytARA/2ExQcvTdG8
rrO9CuZOrxjO3n8VUU2rAAE9vWCJTJXcxUp1ATWgweXL/t054CcaRW4neSLwMz1Z
dm0pVjr3mQP4NGGN9dPvDmhszGf6EJDsJvXXoLGN+oEOMtd9/P5cDvsDZEweOMKZ
bbNDtSDEJEY5SGP3OcQaKHIlKgAf7Xg9kCz7feOgD6B4mY/vYQosewZ701x9wfFV
4MdoHy8Cd+6cFt4Kybmxb5vTVhYxLw==
=pGI6
-----END PGP SIGNATURE-----

--vg8/lDXfibg848NJ--


