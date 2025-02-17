Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24453C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwRk-000864-84; Mon, 17 Feb 2025 03:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tjwRj-00085g-7A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tjwRf-0001y8-Qu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739780737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hv0DzEqKRfrI7HQm+WUlnfp7DuMtZq0j6YlXIxy9/oQ=;
 b=C/EGs6tzAzuIRsx4257z1yp564OtjtzasbpvSF5emcebOep8IQ8ZgVMFrS7EcFCVcQk2BF
 CxBcrXVsbmFXB8xy2k1X9jkLZsGQHAddKVqGWZ2bS5KKVNsXorljGWGrQpPoxwIpOqJHkg
 qsApp0xpHVRBUNlSmsc7ke4LcYR8888=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-TPIWY7JgPmaB1zzLmu0IGQ-1; Mon,
 17 Feb 2025 03:25:35 -0500
X-MC-Unique: TPIWY7JgPmaB1zzLmu0IGQ-1
X-Mimecast-MFC-AGG-ID: TPIWY7JgPmaB1zzLmu0IGQ_1739780734
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BFF3190F9C9; Mon, 17 Feb 2025 08:25:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECC3219560AA; Mon, 17 Feb 2025 08:25:32 +0000 (UTC)
Date: Mon, 17 Feb 2025 16:25:29 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/39] Misc HW patches for 2025-02-16
Message-ID: <20250217082529.GA788063@fedora>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uZBDWSoayaHePlyB"
Content-Disposition: inline
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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


--uZBDWSoayaHePlyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--uZBDWSoayaHePlyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmey8nkACgkQnKSrs4Gr
c8igjAf/bSIVh+GLAUsYPSF0GS70YUyhLAkP9CxtYY16/bpfD1HZC0lptiPxNo6c
rb4TaoxBFUZTJEJWm0GQOkidn+qmt/UOw7zIS6aji7a5+a93cSNfLim3/28zGRm/
4BDJ5SAMGYrWEHXpe9P/CuN5PJAyiJbtmriHZiPHw0b+5OzbTOF9PcCreX52cka5
fHMj8tbvj3wn7hizMPhP7VPI0HhaZcoL0ufEt/JfrYLDYDZtmIbqdGUkx6YD0qYy
gEem9wTrjLYUx8AQDPNYsA6Xx1k0u4+DhaObPILbtEP4LTHDCVKHKy+QRRK/jDoH
pr5l3iRwxXPFMKtR6iLdTh6l2K9dIQ==
=aKqz
-----END PGP SIGNATURE-----

--uZBDWSoayaHePlyB--


