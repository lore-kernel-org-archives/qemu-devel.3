Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A91CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgqx-0005qZ-RH; Wed, 06 May 2026 14:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKgqw-0005pt-3q
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKgqs-000783-Kl
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778091605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7bCl58Imrvv6Wbo/AEgU5TE9RqfWT27ozQ5eNHWZkG0=;
 b=ULYjiOh+cCvl7N//4UWLR/8AtTJtnzlsNESRn7j4ctrMc/+RLM7XF9BiDjTh0TqaV6wzju
 qKUX0dlonXcRwrxJJw4EqSev7jvIgr1UX+VrYkEAOoheLyfjzpcmKoXaLX/VHMjf3ky5aZ
 IVyH6aILSnceBiLlJen6KIUVqNNqcwE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-VqwY_xokMYeoWAQQY4hhzg-1; Wed,
 06 May 2026 14:20:03 -0400
X-MC-Unique: VqwY_xokMYeoWAQQY4hhzg-1
X-Mimecast-MFC-AGG-ID: VqwY_xokMYeoWAQQY4hhzg_1778091602
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DD5C19560B4; Wed,  6 May 2026 18:20:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 858E91803A90; Wed,  6 May 2026 18:20:01 +0000 (UTC)
Date: Wed, 6 May 2026 14:20:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/1] Docs: add link to rev.ng video series
Message-ID: <20260506182000.GA209008@fedora>
References: <20260505230933.2712543-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BVhhAaDGtl4pdOtz"
Content-Disposition: inline
In-Reply-To: <20260505230933.2712543-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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


--BVhhAaDGtl4pdOtz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--BVhhAaDGtl4pdOtz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn7hlAACgkQnKSrs4Gr
c8gEGQgAvTDix2XKBDtvRfAgok5T9z2TOGZhHYBrW14RbtpHCglhDoP+0nJKqqg9
KgggC4K+/k8SB8wdbM4h8jruftUrKAs2I45GWLBMlzwqGaXriVNPcSLwAU9YK0Z2
R1caJ/C7fxJHSPfNOt/pnI26gPYGL0s9D/5YAuBM6MK8dsiPS3jt5hkWpduAGI0a
rOgNMcx/A10mnbN98mKJcWhAwX15jbHtBt7FcpYfPVlNqw0uixjHcNgf3RPR7zil
fN958WNuFH6J0/i4xVAFmPtDIUPCUVhR262GGboOysDWCicN7k/oTUFYBf4ktazp
i2hJida7lDfph18MVAVJ1N1QdxL+Vw==
=qJ53
-----END PGP SIGNATURE-----

--BVhhAaDGtl4pdOtz--


