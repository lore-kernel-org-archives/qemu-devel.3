Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6415CCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92k9-0001h7-DK; Wed, 15 Oct 2025 10:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92k3-0001fJ-QF
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v92jw-0006aW-89
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760539465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZJr1B92xSGunX+IoquMZJ1Umw9DtWtUDrc/CgKtnve8=;
 b=cbQQJXeng6YM53RRQVtQYR4xb+ggs3sKfUE7ertWjEouM/hig8CHDlc0r5H8A+xPXdYq8K
 lJB0XcSOsPSNNNGPLiFDvymTYFp3G0NQwTry/9EAHxHVwFRY3x7HVzPoLawhOZclCWSmXl
 x7GPAvLXcqpwxvfn1ClQ6e2NPpEWCDY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-woJVRLxxNwaCniTPhekF9Q-1; Wed,
 15 Oct 2025 10:44:21 -0400
X-MC-Unique: woJVRLxxNwaCniTPhekF9Q-1
X-Mimecast-MFC-AGG-ID: woJVRLxxNwaCniTPhekF9Q_1760539460
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1416A19560BA; Wed, 15 Oct 2025 14:44:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9232830001A1; Wed, 15 Oct 2025 14:44:19 +0000 (UTC)
Date: Tue, 14 Oct 2025 14:22:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH v2 27/33] qapi/trace.json: docs: width=70 and two spaces
 between sentences
Message-ID: <20251014182220.GA18850@fedora>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
 <20251011140441.297246-28-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cQXygG5e+MJ89Usf"
Content-Disposition: inline
In-Reply-To: <20251011140441.297246-28-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


--cQXygG5e+MJ89Usf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 11, 2025 at 05:04:33PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qapi/trace.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cQXygG5e+MJ89Usf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjulNwACgkQnKSrs4Gr
c8jOvAf9E+OCqFMdz0HS4+bli50N20+X5ApV15ZLsclyTklHVe3nyJ8LMrQsERhn
USDXEB7XDGWAiaHLqa2HnY8us8WymAfEuyw7AsJo10Eo8rX5f/MVD041PBFnAlsX
eWIodGH/u83VEH9a8gHLg3wdAX9KgWEh+E71rzpWsUr/LmvNPCqlLfca/ySPiL7v
AKtNTNp3En1CaFI+79yo63wunxS30Ma1HlUAPkUX0yXIUFY3CK6f+SNS6rrxJNTD
cDTqziJWMC3ni3DaLW0AMH4e4RswtMlhG8iXtyxF06ag7MEQxBbU4TqzDqcwdFML
XNwm8a2aIgzOXxHO96TuR6tp0kdxeA==
=K0Fe
-----END PGP SIGNATURE-----

--cQXygG5e+MJ89Usf--


