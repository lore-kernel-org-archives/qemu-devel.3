Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02627C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 13:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujHK5-0006KL-Ns; Tue, 05 Aug 2025 09:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujHJz-0006Eb-Oj
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ujHJx-0004YL-I3
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754398989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ohqm1Kk0j2Fegp4+r7V1uiWkakyp3qUqx6ulwjLylk8=;
 b=bbu0L4nXd+M/I2Jpd+YLJ4WkX+jR3iNxnEHyPqKKxc6kaxBbRMN01U62WAkcHWjairPGHc
 IEGfZwJyMoqBaaQ0UkM1bPlB57IUHzDLFSYrhyIjKTDwKQAA9O3BzeJ+UtQc91lTSsHImM
 Ys43oPa0CiIDoqKv/95V6MXldpBArFU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-w0oyVS31MIGXquxyngSCFQ-1; Tue,
 05 Aug 2025 09:03:06 -0400
X-MC-Unique: w0oyVS31MIGXquxyngSCFQ-1
X-Mimecast-MFC-AGG-ID: w0oyVS31MIGXquxyngSCFQ_1754398985
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27D3D1955DC1; Tue,  5 Aug 2025 13:03:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A86451800B65; Tue,  5 Aug 2025 13:03:04 +0000 (UTC)
Date: Mon, 4 Aug 2025 21:27:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] target-arm queue
Message-ID: <20250805012714.GA240199@fedora>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WgYXWnzLq0gSt+ce"
Content-Disposition: inline
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--WgYXWnzLq0gSt+ce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--WgYXWnzLq0gSt+ce
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiRXfIACgkQnKSrs4Gr
c8g8iQf/TdDpbjetjAYjjsRxGLOPZbhgj5S+FyELFmN3n/wlpZ0VNVjxkZ9X/m+v
ad+Uc+iQLpSFKHhPmX5RShjtGS5Dbx4IePd3rtjJTyY8bfTWc+m2sCUHIK2a5fZt
z5cJRXUa3GtxFgVw57mjr83UHbPZ+cFvC7AY/0Es+FOXY6eDyQgZvrQdgc21EFNJ
WfA+fp82hBCTbD/alD47RhumLgMWhH1gF3jKKOcl10TGIOuQq9r5Hk1ws5GmNYJk
i2e5vKphdY94Uu0zD2pB+OKfYXlYoVSDUMWU/sxJbWA8AwheIxkNzZELQVr6XSu5
bilqavcwtv5EQIPtXpw5MjxP69BViQ==
=wxsy
-----END PGP SIGNATURE-----

--WgYXWnzLq0gSt+ce--


