Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97730E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVAcw-0000PH-1D; Tue, 07 Jan 2025 09:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tVAcu-0000Ow-2m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:32:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tVAcs-0004zc-J2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736260328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDor7YJlYtL+6jP2shCrIEsiSX8sRisU5498G7H7l58=;
 b=MdMSJYhiJDi9KUOkDX+IE/JUmeskYvTFLcckcTzd61n3aqSrzJAYNJX+PdQCsl/pSYPG5l
 Q5vo6ZrJL8hXK5KKegb/Eg/30WFMVXhhKzwSJrzG728AzbK3UVZipTLC9pj4jXWVBg9xcZ
 lfOe+8rLAEyMWQ6tuTjXIH3LnFa94Ug=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-KvrS9NMIPoWfoyTewEi2kw-1; Tue,
 07 Jan 2025 09:32:06 -0500
X-MC-Unique: KvrS9NMIPoWfoyTewEi2kw-1
X-Mimecast-MFC-AGG-ID: KvrS9NMIPoWfoyTewEi2kw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB3A919560A7; Tue,  7 Jan 2025 14:32:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.129])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E31251956053; Tue,  7 Jan 2025 14:32:04 +0000 (UTC)
Date: Tue, 7 Jan 2025 09:32:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/2] Misc QGA patches for 2025-01-06
Message-ID: <20250107143203.GA102645@fedora>
References: <20250106113814.35459-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pQQUX8VQwq0byT54"
Content-Disposition: inline
In-Reply-To: <20250106113814.35459-1-kkostiuk@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--pQQUX8VQwq0byT54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--pQQUX8VQwq0byT54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmd9OuMACgkQnKSrs4Gr
c8ik7wf6AoAvhY87Z1ZE83oCta4BzLSgzdEBKGPk6+/LFCQiEFSDlDaVDdWeiOg8
bxgs0KU+tQIif9hMST5K1gG5V6BX6uyRTO1h/BYuG17vZMxh9LlJRoJFfko4J3Go
9aZNsAIApkPNIU8iy8gLkYnT8L9eBTsw7QwKQrDvWRcw8sPuK73mZKV8GDIc5NlU
0y2u3ppV8eh5IddQU8GHa5+Qhc4eOcQX9g22++Mut0egoH90d7qi3uGLkq+RNmNF
0iRAbtQZ+sxSCakoy/WHMsov93tNot7VySlLxyua03pmCEWYsmHpJPEg0h6nLUO5
wlX4aAysbdgw5ioqIeFEAASaGnxHGg==
=Kaeb
-----END PGP SIGNATURE-----

--pQQUX8VQwq0byT54--


