Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76574C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCuQ-0003c1-T0; Tue, 21 Jul 2026 12:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmCuE-0003PO-It
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmCuD-0005Pi-A6
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784649676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gURuejfEWD4ZabfyZmlgN3GEBFtvKnK0Y5iTZ6mNtK4=;
 b=Uh/KKFKqbr+GPZLHebVCH72XtzXthTfA68gFCIt2wXgzOVlJWFxmWL+pjBhPxRpFCuaoRJ
 OotkQcH0f958cMCx2oCxYtNVT3e/5lyC4PHHoB5dN/adcTNcjOTk/uCEfWTU8WSsHTlajE
 LEWle6mg27RSf8QFWUjKqKlk+urmFm4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-YZX0hDNrNGeRrL50ViipGw-1; Tue,
 21 Jul 2026 12:01:14 -0400
X-MC-Unique: YZX0hDNrNGeRrL50ViipGw-1
X-Mimecast-MFC-AGG-ID: YZX0hDNrNGeRrL50ViipGw_1784649673
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C59101809C90; Tue, 21 Jul 2026 16:01:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BDAA180029F; Tue, 21 Jul 2026 16:01:13 +0000 (UTC)
Date: Tue, 21 Jul 2026 12:01:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] Misc HW patches for 2026-07-21
Message-ID: <20260721160112.GA208643@fedora>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BmvTL3Mid4OnodMp"
Content-Disposition: inline
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--BmvTL3Mid4OnodMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--BmvTL3Mid4OnodMp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpfl8gACgkQnKSrs4Gr
c8irpwgAu5G1d1/Pewe53xp1IP8lIFbDsAgFkrWA/5RHTMFe88cpmxrGpqK9P3Kp
bsJSRyOGRVWqtZBXLFpHV7JDrYXUKKAq1UvOMJQy733tlGO8xNR/H/ADEp8J9qk6
YmSUoCnv4ShkA8wd4WHaLEAR+VSuEaOVKbzJjF9T0RsTYbau3mPzdTUpIiPsXY/H
xJrdNKWTj1iEFNiOa0Xz8sJXY4MOIN4j6rj6GU+uqq8e5awDvXTou/eL9WnNVmFX
BKYp3fSm0iMCFJT9pnU/bFp+McbVvOKvyb+x+ouTCCPcm8rXfVwf62R14aoxiQYr
45nMwXdTdWVc19OID9sjiq4ocvEr0A==
=tdZ9
-----END PGP SIGNATURE-----

--BmvTL3Mid4OnodMp--


