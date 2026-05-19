Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1F3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 19:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPPwl-0006ka-Qg; Tue, 19 May 2026 15:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPPwj-0006YI-GM
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPPwe-0006jE-W7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779218249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mVfWGruJ5aY5K+oJSu7gNhlLmQXFDISlW3Sd+J5b5yA=;
 b=E2WK6xyvp10O9/8LdfMavFdQS6XoXc9Rg3hFtwRk/Q25122djES9rEUbKnKBU4GR4aGk2T
 d44Idl2STRNTZJgK7n9XByL71agbZetVQjKBYoROvNTAy/sd/SGoZ46a/HHteODzSExHbE
 ll0/+VFBT6b+c4lGpG8BCvvPEN0Vbek=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-StFD2VP2Px-yLTDMuEg-Qw-1; Tue,
 19 May 2026 15:17:27 -0400
X-MC-Unique: StFD2VP2Px-yLTDMuEg-Qw-1
X-Mimecast-MFC-AGG-ID: StFD2VP2Px-yLTDMuEg-Qw_1779218246
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC4DC195608D; Tue, 19 May 2026 19:17:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE42E18004A3; Tue, 19 May 2026 19:17:25 +0000 (UTC)
Date: Tue, 19 May 2026 15:17:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 0/2] Firmware 20260519 patches
Message-ID: <20260519191724.GA335383@fedora>
References: <20260519085554.944458-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jfeFkg4wzv5y/gEL"
Content-Disposition: inline
In-Reply-To: <20260519085554.944458-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--jfeFkg4wzv5y/gEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--jfeFkg4wzv5y/gEL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMt0QACgkQnKSrs4Gr
c8j8awgAyOtde7Fjk+gK80pcktY+rEuPuo1pCZ8CGeFCSjuhlual+Oz0h3NWUYA+
L6B8h0QGJfo7F8eBMcm2Aih3zqLajxtnhOnozKu1eOw19UmUDxt7L7fMfpNZ6pWF
k1w+JQgN2JuajFglWnwaKJelmXGRgedtHBHQDaGrs1pQ4BEyR6gLNmq3VdD7ErMd
ghnoIwuh0RHMWX2dINAbuQlLnaziPYrshZrvccEetKqidRqR7imfR7HwyqmubIg8
GvFaWdo7ZllY5/ndCLe9xic5krJUFKz0BloJmsZITFo53A+AB2H07xsdecMJegLP
yAV4XEb/JKuY0fXShAVcs/tVeN7DOw==
=1ac9
-----END PGP SIGNATURE-----

--jfeFkg4wzv5y/gEL--


