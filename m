Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3A0CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXktg-0000JF-JL; Thu, 11 Jun 2026 15:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXkte-0000Is-Eh
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXktd-0006qu-1A
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781205415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5u8n6pF2LilO1RKFAtP3PmWkMAuhpkTv5bWJw2tbHCw=;
 b=Q+BQHpjF43RTfoYhBbSq+N+CdFpNd0l/cVLzyVlPK0SQJw1pUfQiqDjVGNQNLnJhZBVple
 uhId9fs+ZjZXyVHhjIhIUsAjCrzS/2FN4AwLDGG+o0Z5dGG1BwQJ28D//pKCY4xUEkizRG
 layun4byPWEqIXCOuTpuAnGA15C+WfE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-5VGcl6bwNV2iNu047UEoRg-1; Thu,
 11 Jun 2026 15:16:53 -0400
X-MC-Unique: 5VGcl6bwNV2iNu047UEoRg-1
X-Mimecast-MFC-AGG-ID: 5VGcl6bwNV2iNu047UEoRg_1781205412
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A3101955E7A; Thu, 11 Jun 2026 19:16:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 058231955BC4; Thu, 11 Jun 2026 19:16:51 +0000 (UTC)
Date: Thu, 11 Jun 2026 15:16:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/71] target-arm queue
Message-ID: <20260611191646.GA228482@fedora>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4cM9LWqZConOACRh"
Content-Disposition: inline
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--4cM9LWqZConOACRh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--4cM9LWqZConOACRh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmorCZ4ACgkQnKSrs4Gr
c8gz+wf/XmXbX0BqfA+7d5p11kwrREIfPEWIKL+1GUpbHmrFaavHH4C1ugHxprmB
OlfWod1K+ulFxgX+dFvWXi1MHQktaDdZ02iz8bmP46MAeQN+ezsQjwQYsQIbFCAp
qw7m3dQB9/Et8dmnmCjhdAzb0eqGUScT57wQ0JMTGDAFg0vOLT6k90uQHoEbR7Dd
WtdJ5TTQhfRfH2PmJk9GDbMEZfsu8jmDtfz6tJzwPM6E/ICsbDGz25r0Ivfpq4Zr
y0oiwiY2FfkjpNTfd1X/FRd4tEAWoD7qT1UoYvDbEYi582jHXCfyVRIFV9y4onNh
SCBBN+u+mgS7MpSj9oJO4QGc3OjaZA==
=dlAr
-----END PGP SIGNATURE-----

--4cM9LWqZConOACRh--


