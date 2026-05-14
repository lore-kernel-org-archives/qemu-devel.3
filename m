Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9C8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNahW-0005HT-SV; Thu, 14 May 2026 14:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahW-0005H6-4F
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahU-0002kT-HA
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778782943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rinGv0NCSy+a/0dqAE0w56NtAts8bcvDhOr+VaYGoq8=;
 b=DoOnTO79kW7y7q10NGrubcRS7EqaBC97TLwThoybnY2njmAtB8R/0v6EQjRfqMQlRRc3zN
 ONVoWI4+eZbI6bYLKI61wsSv+XH8LF7Vhl/nWLmqq8rxzwXmVKbAwi1SMn3HYmKoVeRn0x
 UbiBu8p8dAyv14s6Z+pyxQ6PuVfx3og=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-gtLKN0fhNvifvhSdmE7z2w-1; Thu,
 14 May 2026 14:22:21 -0400
X-MC-Unique: gtLKN0fhNvifvhSdmE7z2w-1
X-Mimecast-MFC-AGG-ID: gtLKN0fhNvifvhSdmE7z2w_1778782941
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAE791956056; Thu, 14 May 2026 18:22:20 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A33C30001A2; Thu, 14 May 2026 18:22:20 +0000 (UTC)
Date: Thu, 14 May 2026 12:26:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/9] aspeed queue
Message-ID: <20260514162634.GA1482440@fedora>
References: <20260512171354.4183887-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Uy91fl7e+o382HoE"
Content-Disposition: inline
In-Reply-To: <20260512171354.4183887-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Uy91fl7e+o382HoE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Uy91fl7e+o382HoE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoF97oACgkQnKSrs4Gr
c8gD6AgAj3/Af9nIcjConLqwdh0iqvN6sdCivYXRbbT5c+C4WF2CrBaJEWAANqgg
u8XcBLSrvOQio3ksPpRb0/3QE69cXdMWrJCOZy5vk/+DK+DnKB3n7bkTfdRKJA3x
rIy1LoPUJhJPnM4K76wwkXYa/v9qiLnPTS/EUUGnd+pUQcjD9qmVBubdnin39YRy
SwGNHfUtZ6HeqslQxcLWPN+0sKniJhGdWrhdQpaCLUEaKaRJVp+TOEF/BCCnLw/I
MqB86mGjKuZc0RqiYHkyDkOKKvBoFHCxRkDqwNKSqnsjDItS9s4k4Wm7UnR7rcPE
gg/23GYGtUr3bH9JFaApLsZWFarirQ==
=Qodl
-----END PGP SIGNATURE-----

--Uy91fl7e+o382HoE--


