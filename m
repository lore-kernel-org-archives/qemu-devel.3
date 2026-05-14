Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B6FCD4F46
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNahX-0005HV-1F; Thu, 14 May 2026 14:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahW-0005H9-5I
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahU-0002jb-55
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778782942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzumJpbf5DebHndh+okT4dMBq2glzCwswGQYeaG5NGc=;
 b=OdGDAGdSwC7MIWMMxAOdXSlG7woUsdKhLAUbQzDzbO0Ygx39Jg1mLHnkO69+1gBP8Nqqcb
 dNrwviwuLZUu9GlGUwhKGNzAfsSFZdz9QtEQAwQbR/jahtL1ynBFk8TZfu5svlaneQv806
 bgoFf0PszGTMUkTTEaDRZ/oy0M1O2l4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-zD6SmchcMmunIPLEM8qEWA-1; Thu,
 14 May 2026 14:22:20 -0400
X-MC-Unique: zD6SmchcMmunIPLEM8qEWA-1
X-Mimecast-MFC-AGG-ID: zD6SmchcMmunIPLEM8qEWA_1778782939
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D454195608D
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 18:22:19 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DE3F1800264; Thu, 14 May 2026 18:22:17 +0000 (UTC)
Date: Thu, 14 May 2026 12:26:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 00/24] Qom patches
Message-ID: <20260514162618.GA1481762@fedora>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M0tkvdBGOENQDXdn"
Content-Disposition: inline
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--M0tkvdBGOENQDXdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--M0tkvdBGOENQDXdn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoF96oACgkQnKSrs4Gr
c8izLggAuUUsf7SQiumObqerfNcy52Xu2ZHKZbJVroYR+s+muXixiS6zAw1gh4vn
Kl7U9Nsus8+Jzidxvf9k3wPpkinDfdB6xlMnrkbunKyWduioNlggznvoSgBhrLIo
mltWh5FljRF3MfhDmgTKMwVkf+ItFjEqLTY13hpKabmNr+vxiP7XedNznmcvIHDw
5oSNZYZjC1NjR1GDV6a6Fbp37z8aQJvQWn2MmzRuyfTeW5R1q2YNH+07gDAXmRYh
uXyEknAWCoBHY6JneHW5tNqbk8DA1lCkU+xF9BxfUWnE4zo49SLb/wQ6S8s1OC19
+YrRbNd5Ywy3NjiruCXL7+7muxHEOA==
=Vl4s
-----END PGP SIGNATURE-----

--M0tkvdBGOENQDXdn--


