Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD533C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7AG-0005EP-ID; Fri, 26 Jun 2026 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wd79Y-0005Ab-7E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wd79W-0006xi-Ls
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782482609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m9qiOR1p+ZCGmqqMqr8/U5HQbmuMx6zIGbg/5TnMY2w=;
 b=AAaHW8kFKcgoxvhxCsDFD+kJ6bJp2Quu8OhSdrRt8Y3J919ULWUtiPSJN8A7G6dRE/AqS3
 zP2KU+0A9Uypn0tisvcZ/FZRZ2+0/t27vQumiGVjXJFcKb1c8IN7r1RsHt92svIk9g57JA
 WBFELw8S70MuD1cIDZ1aZUHjnZBishk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-NJI468N6PBuSPhbaKK3nnw-1; Fri,
 26 Jun 2026 10:03:25 -0400
X-MC-Unique: NJI468N6PBuSPhbaKK3nnw-1
X-Mimecast-MFC-AGG-ID: NJI468N6PBuSPhbaKK3nnw_1782482604
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67814195606D; Fri, 26 Jun 2026 14:03:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.186])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9760195604B; Fri, 26 Jun 2026 14:03:23 +0000 (UTC)
Date: Fri, 26 Jun 2026 06:54:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL v2 0/7] functional test and gitlab updates
Message-ID: <20260626105412.GA293764@fedora>
References: <20260623101238.3806547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+lVKaSHbtq+sZDTb"
Content-Disposition: inline
In-Reply-To: <20260623101238.3806547-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--+lVKaSHbtq+sZDTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--+lVKaSHbtq+sZDTb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo+WlQACgkQnKSrs4Gr
c8iFsQf/UHYDW87EQ/dN5oIjl0HFnum3It+moCyn482zDr0oG3mkgU2PJNwVtPyV
/xrJWiUvQqXVsLtC0s7UlqQWhbJYQMShaGx3fR5TMS12kNWDJDGy3G+/7fkVr6j4
jSv5P+kbek7kY0khyjWOynXROn/RveNRM+UICVrcYnYdPK+UCm384QUHB1VMMCGV
Xu9A8JrhgxU5us2wiAtXdnbHhIdNaLLZD5fyxIWgpQqBol8lilBQvafvpsZ/2P/4
/s9at8+KL9grE/R/XLg+7t2e4YuuyXh25LIWpXTHr4phggTZnxOVegF+OfFc3BnH
sacUAkhWpeP2hm85vYfGZeWgGx5Jzw==
=Y7Jc
-----END PGP SIGNATURE-----

--+lVKaSHbtq+sZDTb--


