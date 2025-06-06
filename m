Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1A5C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcfK-0003ba-RT; Fri, 06 Jun 2025 15:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNcfG-0003an-Vb
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNcfA-0004wu-Oz
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749237808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ji66m/InCG11Nqt5VVI4UNSJsBZiSfr5dkbrrPjOIU0=;
 b=b7kEReUCyiFVb2LV8MwIkk72fmR9GmcsEKl7KqYD8pUU9BV+bOIS8a4/XRsJAK2xLfWs1N
 bODWaj30p05qXXvxotfCSI/HiH9MUiNsrDmgIvo+CJ+8DLF9feAiBYqHc89gJovtiLpzSo
 YAeQqYmB8mh8YH0QjBYXXDTc7UeQbL4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-K8h1hzVTNDev3InNTlIdUQ-1; Fri,
 06 Jun 2025 15:23:25 -0400
X-MC-Unique: K8h1hzVTNDev3InNTlIdUQ-1
X-Mimecast-MFC-AGG-ID: K8h1hzVTNDev3InNTlIdUQ_1749237804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 335151956095; Fri,  6 Jun 2025 19:23:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.87])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A107018003FC; Fri,  6 Jun 2025 19:23:23 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:27:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL v2 0/6] Python patches
Message-ID: <20250606152738.GA524448@fedora>
References: <20250605182014.561172-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cx6oQ8ZbowfEMDVC"
Content-Disposition: inline
In-Reply-To: <20250605182014.561172-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.104, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--cx6oQ8ZbowfEMDVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--cx6oQ8ZbowfEMDVC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhDCOoACgkQnKSrs4Gr
c8jAUggAstMryRMdqaO6vCnzV1L2vUmUhNzlpR2bdu8aMeDblHLyWx6B+qay4BBN
ifHJocq7MBKXZeYZsQXLvke31Cbk7udv/9Jzdr4PKeTya4nSFwG/NNwXzoZaDnpW
0qaBe40DiXt8QaMav6Dm50m/7meNFefUvR8lY95uGO5CD4fHIAX8S3pUfwKCIc17
ch5aysENgHHJ4Lil6ntC+6V1raIlhfQdqWJrTnIFVvXC+KXJf9R0Of/+sZLdvK6f
jlY/w96nqt9uiNdlqIvDHsSe5L7q0uZhPSjRD0vpIF3Ekg4rLbpd9zyXylrlaQKk
PIiQyvHiBrDFSrcgx7X5+muaxBwnAg==
=+na2
-----END PGP SIGNATURE-----

--cx6oQ8ZbowfEMDVC--


