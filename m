Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C11CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKKTm-0002io-2w; Tue, 05 May 2026 14:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKKTd-0002iI-Je
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKKTc-00072q-8t
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778005595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gKUbFUGHAt5EzvHMNS4MfCjypKX5bdbEO6dpVhRyB44=;
 b=GQ/cMhOupod8uI4YH/24ObL/LOj6q21MZ8r1e618FhkV5L9YU2uHOHhGaWMhDq9dscvDRp
 UnpMMHCv14DNOZ6KtCKZicIA+y6RUjm6K3ZKj8otMaIv8phKsJSkPesyE6UCNZtv3WHG8P
 Hh+tlhgOoHY9PFU3+CH6UMpQML4bNXY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-SbysW7PlOYuW8dTHmgiJ4w-1; Tue,
 05 May 2026 14:26:32 -0400
X-MC-Unique: SbysW7PlOYuW8dTHmgiJ4w-1
X-Mimecast-MFC-AGG-ID: SbysW7PlOYuW8dTHmgiJ4w_1778005591
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA12819560AD
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 18:26:31 +0000 (UTC)
Received: from localhost (unknown [10.2.17.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DF0D1944CED; Tue,  5 May 2026 18:26:30 +0000 (UTC)
Date: Tue, 5 May 2026 14:26:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/4] Monitor patches for 2026-05-05
Message-ID: <20260505182630.GA44048@fedora>
References: <20260505123502.1316554-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LGx3xtocIT0ehd0t"
Content-Disposition: inline
In-Reply-To: <20260505123502.1316554-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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


--LGx3xtocIT0ehd0t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--LGx3xtocIT0ehd0t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn6NlYACgkQnKSrs4Gr
c8gi1ggAhajdCkDVy6vpC8mGauF/ci9Mj+PaNKW5OtNNPfZPQgoCCAY/EyL/6jvE
uEV5MFDP8kzTw8JCnd1rvrqTfzf3i8R4RHDPjJMv0lERPWMUVSk9NBBTBcC7t7d7
S8J5JEg1uIFf2w+h+HmD1GJcw7cPk5oFvfxSsSzLgWyX6ReFy5UlN895UtNpMbDk
NlQkx8SNs+tVrzdM3Dph6LGI6a3gK5tcnkEqqryUQlIU9O7i765XCipXMBNVO21z
16JnkWJgHbSxXigeYMuP1PqSevNUTdJ/ni7ijSXoPTQmejeDE2fXHewzsBcocORa
vttRagsgWqgZ2sDHUBGe2MJI4U1aJg==
=1QvE
-----END PGP SIGNATURE-----

--LGx3xtocIT0ehd0t--


