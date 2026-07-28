Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ADCC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogC2-0000k7-1m; Tue, 28 Jul 2026 07:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wogC0-0000jX-Ao
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wogBy-00024L-MA
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785238909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Si5Tdxj5I8qxFVfQ1q9UvTfHfmzSWxEXyo20EX/n7MM=;
 b=PB+j3TShsC0PMSnnzVvx7oEuP772WBUkOPQ5SNAb1gZqB+QDlBvpmvfC4G4Irc5sgNSRxh
 BMIzy5PaDv3yMwt9wcvGBWdTvb3SrRIlEH5jyWKQW/GxXCUTyZ0lmjH2aryUYmmbYfUAO3
 o/NyfV3Yui9rbsuNQOrM/e0n2Hb/rLM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-e65KJcKONQKZ56KsSuV33Q-1; Tue,
 28 Jul 2026 07:41:48 -0400
X-MC-Unique: e65KJcKONQKZ56KsSuV33Q-1
X-Mimecast-MFC-AGG-ID: e65KJcKONQKZ56KsSuV33Q_1785238907
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4441D1956049
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 11:41:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.73])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5060719560AB; Tue, 28 Jul 2026 11:41:45 +0000 (UTC)
Date: Tue, 28 Jul 2026 07:41:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [GIT PULL 00/23] Fixes for 11.1-rc2
Message-ID: <20260728114144.GA1016344@fedora>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q9BWdvY+KbZzMEzZ"
Content-Disposition: inline
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Q9BWdvY+KbZzMEzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Q9BWdvY+KbZzMEzZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpolXgACgkQnKSrs4Gr
c8gIaQgAmCeIrOSRKrW5hQIadJ301IN8DXx7rtrf0PkKXWWefA3xwagOpaB+xxe7
Z386aw/RwXbBfDWYcN8OeqgLkINjcmuzqCIvn47fzn4h/3lt2nMw0y2zVoVQ55tq
374HGhmZ4tWfnaIgfa1r56jB6mCS5yR1nx/szJYf9yFCSy1rqOkoT/p3YuIhpS1e
tnZ66YNen2g62Eh8R5BXRkPaKStJMuAU/QHs3E/dqdF5Et8AA6ecnbtNmTKJjlOT
FQ1fhSWhAL+21jKXe7xzBBgjiFeldsZKeJOtxc5OAq9aRm/U24HrsTXUJ2Q9Wq5y
wRk+HO4Di0dBDjgVPOWwghhdaykhUA==
=lOB4
-----END PGP SIGNATURE-----

--Q9BWdvY+KbZzMEzZ--


