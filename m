Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41332C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYrsB-00010F-TY; Fri, 17 Jan 2025 14:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYrs9-0000zm-To
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:19:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYrs7-0007oy-UQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737141550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AxYiympufnu3aBVhgA4rR9o4mWovwy3uCrTIGELWbnU=;
 b=K9rPUaDP5vdxH9ctGVwFpHSoamihh2szYG3p7Jmm5zKcXzj5O5K3FI/vao48d+CqMsHzHv
 z+qS/idlyvWwDZl8peBAzWlxmm0Q4TmRX7m8+ybkzwMAdhpKR7tHoTmpb4RqIxFr+ljska
 jhnVD9QIn8ZaBy6eN1L0G8E2ovIL/gk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-ArEhvk3cM-itwCZHtWoEHw-1; Fri,
 17 Jan 2025 14:19:08 -0500
X-MC-Unique: ArEhvk3cM-itwCZHtWoEHw-1
X-Mimecast-MFC-AGG-ID: ArEhvk3cM-itwCZHtWoEHw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF1E8195609E; Fri, 17 Jan 2025 19:19:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 889D5195608A; Fri, 17 Jan 2025 19:19:06 +0000 (UTC)
Date: Fri, 17 Jan 2025 13:57:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 00/37] maintainer updates for gdb, plugins, documentation
 and windows builds
Message-ID: <20250117185740.GA401932@fedora>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fxcTdA3xNjxikj/m"
Content-Disposition: inline
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--fxcTdA3xNjxikj/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--fxcTdA3xNjxikj/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeKqCQACgkQnKSrs4Gr
c8iH0AgAifaVt0f7GLX7bfbRvB4lLb7v9dENkJIHsftEGMDwnXpg1+uf6TK+9mK5
jV5OS5Nbbtnk2H1xy6kDE9aNjSgIr40GNwdFIN0pYthDwX43ELHuXp+YjBVBXHRF
aWQgu+C/QFHeLRLDAHItyGeNyuUIVdonMdBcd+ciSd/O9Jgd0pC+8NyFf+q/uV+7
cnSCfz0XrcjuYBdRM3xEIBZ3arLnUsVyPezye/79l+/ijcTk/tvo5ySry3eQFIFV
E2hhSyx3IDJAcOVJK4mzhgUV4Idf1uiVHxX2d7j57uqQhdBu5TjIPc87GppeuI8H
2ztYDUXr1z3ZhYzKvbCM0ivfqhpG1g==
=5yRJ
-----END PGP SIGNATURE-----

--fxcTdA3xNjxikj/m--


