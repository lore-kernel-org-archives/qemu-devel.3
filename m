Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B963C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 12:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9Mp-00023p-6c; Mon, 17 Mar 2025 08:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tu9Kw-0001VT-G3
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tu9Kh-0002kd-C7
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742213541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dU1acf18OSGQM+e9rDjUVGCH70OnbBWHsQTyX2q6gKc=;
 b=fwKaSRx5WKyvBEiHVL3uVFUZDdZsfxSg70IxRpgALBzyNgDO/EQAN2cSLQuI1D1ua2DkwE
 rlnDW451CIgXHxEfWb1Ae+k9srJ6mtUi4DZR44tSDW+dOtBUIauXk9U3etEng8QcLXDoNU
 nSc0DZuXBae9WecAU7iYp+ZHgmJBRR8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-4lZvivMBNBecxr0VEdfP6w-1; Mon,
 17 Mar 2025 08:12:20 -0400
X-MC-Unique: 4lZvivMBNBecxr0VEdfP6w-1
X-Mimecast-MFC-AGG-ID: 4lZvivMBNBecxr0VEdfP6w_1742213539
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB93D19560BB; Mon, 17 Mar 2025 12:12:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.82])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 006CD180175C; Mon, 17 Mar 2025 12:12:16 +0000 (UTC)
Date: Sun, 16 Mar 2025 06:10:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 0/4] Migration patches for 2025-03-14
Message-ID: <20250316101015.GA1182101@fedora>
References: <20250314144824.1707-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XQUSjMsZR9/AHCgk"
Content-Disposition: inline
In-Reply-To: <20250314144824.1707-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.335, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--XQUSjMsZR9/AHCgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--XQUSjMsZR9/AHCgk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfWo4cACgkQnKSrs4Gr
c8ijIAf/RdNCzoqlEFuVroviuWxDRnv5jpPWaSpCboC2tnvncOTLU+2Du5PkreGv
iDH4cuNhcKWWJ1ZNYo22YlpXsDcFXrqvntGJGkx3dLuszeuI/jprKwnHCaJsuKPu
P8y8u8wDjieomMuRrShZ58qSnORjEDiFrqztB1+A20eSWs860YpVN+jd9YiDkiGm
TJHM8k/3rZt9S0Mzzvv70RyEVHN65Vk5vbIoybaFdRRVm3EaDqWBQVw2kmFhM7hF
tMlyibN3bCUVPcu38lLbG7EgURlvT705SRmUiRbq8pGfy5xKCyCGsrRjjQ2njfKL
9tYE89THGvNouSACcc+I8w6wlQfdBw==
=wgli
-----END PGP SIGNATURE-----

--XQUSjMsZR9/AHCgk--


