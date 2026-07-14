Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC86C4450B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjtTM-0002wA-3n; Wed, 15 Jul 2026 02:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTI-0002v1-8L
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTF-0003rt-P1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784098313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7DloXMBkV8Ne5Gj0w8nB3alKOUzzcD8lPNUTO5Xd/A=;
 b=djTZ6tdsYAJsxADBVqXZdIPaklkbcFmCfFTaaEvAA951qnkaWs0/RwxMnYXJ9XWbZB5Ys2
 OTUOC8VcKIJC8DHIz6XkDqBbHpsM/Nl8njTcTD9j8G1KiKwI4ONvif1HtqpWbTuNXOLpuW
 8sHWOhlH5eVWQx/uHRzg/yarKmWOIjQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-c3n_6pmDPYCI7Rlk1uhTnA-1; Wed,
 15 Jul 2026 02:51:51 -0400
X-MC-Unique: c3n_6pmDPYCI7Rlk1uhTnA-1
X-Mimecast-MFC-AGG-ID: c3n_6pmDPYCI7Rlk1uhTnA_1784098310
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F1C5195609D; Wed, 15 Jul 2026 06:51:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADD121956086; Wed, 15 Jul 2026 06:51:49 +0000 (UTC)
Date: Tue, 14 Jul 2026 20:23:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/7] gitdm metadata updates
Message-ID: <20260714192324.GA706252@fedora>
References: <20260713161745.53889-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TGtqe4q4pnE1im5u"
Content-Disposition: inline
In-Reply-To: <20260713161745.53889-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--TGtqe4q4pnE1im5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--TGtqe4q4pnE1im5u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpWjKwACgkQnKSrs4Gr
c8hobAf/WF+OWeJAHxcHRPDuscs/YUb4pVsykGFbeFwEcxpeUkIeeVxbcAZNkZJV
rEIDVCkovY7p94G1ULWFKu7+iN1QeyxirnGqYYq2FgkGZnze4sM9SyqJdMFWbmB1
31rBGhFkqmvy9N22aAo9NEdD9ljrsTfVnvXoavU5KwwqDK3gU60LotFPb/AlvGg4
UUXqsluxSSvGmohPrwHUkoWxcihGfMkj8F+NcqgFr+V9HCf393Y2/ddTjWpA40AI
s7fhRIX2N0y1o9JnzFyqljRZDabDUAFJk9B0S3TLiXFpIUYhMARirdIPeTI7FJdl
u3qfLGFxcf3Jl4m7MhJe0umC9LM1eA==
=62ge
-----END PGP SIGNATURE-----

--TGtqe4q4pnE1im5u--


