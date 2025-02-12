Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C32EC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGh9-0003Ck-GJ; Wed, 12 Feb 2025 12:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiGh7-0003BK-RJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiGh6-0005WY-EY
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZzIT3moFGsuViTOusT2InBGMCSU/c1cvK0UY3u9DYE=;
 b=RDo6PHSyZpch6qxUEgiaURGMTTntD9vguMEvYW5igX/9ravXZunftQzXyhHX3DthOEeq8F
 DjgRNpKZG3yfXyFEKokwmVQnor+XWZ0qwQADcmTf49F1owfB2X+amFfeaL8GqHsxoXUlPl
 zElIALG09WR0ZAOWFnLBKIwjAvIr2yQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-qE_FesMzMemLImxdV3jvxQ-1; Wed,
 12 Feb 2025 12:38:37 -0500
X-MC-Unique: qE_FesMzMemLImxdV3jvxQ-1
X-Mimecast-MFC-AGG-ID: qE_FesMzMemLImxdV3jvxQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19C591956089
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 17:38:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 656D61800358; Wed, 12 Feb 2025 17:38:35 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:38:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/12] vfio queue
Message-ID: <20250212173833.GA211850@fedora>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kf/k+kitMtUtrt1n"
Content-Disposition: inline
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--Kf/k+kitMtUtrt1n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Kf/k+kitMtUtrt1n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmes3JkACgkQnKSrs4Gr
c8jgUwf9HnQGXKY3YLRAdGgPRvXkD0A4o6FiITZQxw5mCW+izgt4+wBsp0lDHepD
CdicdQwrst+qdDa+bDd01HMSAlzJhHmd6dw/sqVMxjQF6quFLw2l7lycHLiVoAYE
LgQmgBII9wEf6WxH0DPqv3y/XlSvSXThPMPBQnVpv3VIy3WS8KQCY4TxIj/8tHQd
x6hjQMarQOOzHIPiy3Hp5blJ9gD/+ncj+8D6uEFx2hhcfYJnF/k/xgJFufdHgzba
lmso4WDVXbXHG7AJysQdhegFbKFT0/Q77/SJXKs3H/1DcaA8KAx05zqysEssWA6c
OErieCjyi8VrURICDXFl2KKgFY78GA==
=imfm
-----END PGP SIGNATURE-----

--Kf/k+kitMtUtrt1n--


