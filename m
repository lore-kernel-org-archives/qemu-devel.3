Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1165C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 19:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFWQ-0005DE-Ky; Fri, 28 Mar 2025 15:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tyFWO-0005Ci-U4
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 15:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tyFWM-0004aO-5S
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 15:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743190654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EJtmUpo9ayZbJl0I50HyH+Jk4SxSizt2Hj8QdXqz1yM=;
 b=B/OOJAd0Eyd4p7RhSu2CXDqB/On+zusQdQ1tDZ6WcTZcAvUCdRef1E2OHEfRcqlgU3JC+W
 62TQby+daale5zO91zuq+BONGmNRCST76B0nKzywt5FATQ8e+M/OzBhiK4eob7sybu2FT0
 xQtGlRFnEjLaM/H68bG4vVw3cKu2exw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-8LchNgmDNb-TobkknGBaiA-1; Fri,
 28 Mar 2025 15:37:32 -0400
X-MC-Unique: 8LchNgmDNb-TobkknGBaiA-1
X-Mimecast-MFC-AGG-ID: 8LchNgmDNb-TobkknGBaiA_1743190651
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29A9F180AF67; Fri, 28 Mar 2025 19:37:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.238])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 265EA1801766; Fri, 28 Mar 2025 19:37:29 +0000 (UTC)
Date: Fri, 28 Mar 2025 12:36:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 0/1] Migration patches for 2025-03-27
Message-ID: <20250328163620.GA76614@fedora>
References: <20250327185316.23523-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zZ6we1v5+39H6czZ"
Content-Disposition: inline
In-Reply-To: <20250327185316.23523-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--zZ6we1v5+39H6czZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--zZ6we1v5+39H6czZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfm0AQACgkQnKSrs4Gr
c8j/yAf/QUuboZJpea5UnxdTkN2f9gn4Sk0y/WrOpysxmbEYvZ5YDeiEb/UweRDp
nzPAQBYOry8cvOgUDvL+ppcX6DsXtCQ+7/l6AEg6BCrjB+cWHACNFgaUw4HQs55x
v2LMC0RnFXkFNrHGencxnzfnN960NRixVN6pHMb6VMHLJvX0xfywjinAlanMyN2B
SR1LaKlIPIOt6Of5yvMHGnaGFi2bLkqnf8eginLwbd+uyHoDImE9gzAHDn9cUfqb
txnhtZNcC1DOjqvb5H4NNLnq3kxTCVVkX1O5wGKRWI8yrzNgySSeJPidFflTybUe
Su2KuDSnxHMGy4btwhP44ipi08/lHw==
=xPrx
-----END PGP SIGNATURE-----

--zZ6we1v5+39H6czZ--


