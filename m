Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B1ACD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRPk-0007Bq-1c; Tue, 19 May 2026 16:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPRPd-00074J-FH
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPRPc-0006VQ-7F
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779223895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSHi/qxB7tkYmn2zylR4GMazCd3nl5nHV/Tx7loP5zs=;
 b=OkfNmYoKTuN7mEjRJlgcP4x9U9+TQfJYlKlnGhuVOsgys81++obyOwmjIKSUPBiUXUXoDo
 qE0QAOJwpihI67BZFKEiiHJNH25/EK1+TWiGoO3fw1HCL1pYE4jpAM1v7XRmGmaHGDdIWO
 nPMtu5NCWdsP9TStat2g3q6qin/BmlQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-IIart1spOsCw2l1KSM_lww-1; Tue,
 19 May 2026 16:51:33 -0400
X-MC-Unique: IIart1spOsCw2l1KSM_lww-1
X-Mimecast-MFC-AGG-ID: IIart1spOsCw2l1KSM_lww_1779223892
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 722D618005B3; Tue, 19 May 2026 20:51:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D110419560A2; Tue, 19 May 2026 20:51:31 +0000 (UTC)
Date: Tue, 19 May 2026 16:51:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 deller@gmx.de,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 0/2] Hppa post v11 patches patches
Message-ID: <20260519205130.GA340863@fedora>
References: <20260519151823.13878-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V0i+MOG+Upw07YfZ"
Content-Disposition: inline
In-Reply-To: <20260519151823.13878-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--V0i+MOG+Upw07YfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--V0i+MOG+Upw07YfZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMzVIACgkQnKSrs4Gr
c8ik8wf/VqLqNTNfrYPHvjAjwKwvwyQRugDpa4YZB4UCYK11R86f8dmhX2MsfpD2
LJba5c51RUQV6/CBNdSqN4eDb09kWnMXRDvjuZEyyeRc2MrjSq0SbuAy35jWYhsX
neAXerzeGCdnel/06IwG8oD6KweFLj0egoU0p+lgNilgaIfg/ea0Lsdnml1RmSyB
55HORJagBPW21OlTSROOwE3xiaT6A15NphHHmBPuPUIGgVNeXS4MvEFIXnv94YT4
q6tG3kdenLowRf2Ut/QaS++AQzhozkw9a9AtGQeDWWdMD66WvJKDutA1AZxIFMW2
52dxCMQMwomF2Ur63bF2k8QiVGZtFg==
=nnxs
-----END PGP SIGNATURE-----

--V0i+MOG+Upw07YfZ--


