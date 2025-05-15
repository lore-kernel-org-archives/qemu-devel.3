Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9720CC3ABDD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 22:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGQ08-0003Hr-ST; Sat, 17 May 2025 18:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ07-0003HV-HM
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uGQ05-0006j9-Ub
 for qemu-devel@nongnu.org; Sat, 17 May 2025 18:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747520844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28mb3z25RysTxH69D1rUiRH23gfIMT5ccbNctG69IiY=;
 b=OGNCn6XPsDfC5Ygc2lbLcnCIyKlP8iOL9pBzd6qW7OXu1AxeVP7zP6jt9Dkhf6hKpUI4w/
 4h/iL2gfqcs49RSJGoCzZd0gp2C8AQC1zAOqEx1KOC6ROjlf3q8A5VR3CYoHbqw2MW/CcF
 yk58Bms+SYZGNEHV4iFSP4zT2ks8WQI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-20UpBu94MJqFAngUSOpr3Q-1; Sat,
 17 May 2025 18:27:23 -0400
X-MC-Unique: 20UpBu94MJqFAngUSOpr3Q-1
X-Mimecast-MFC-AGG-ID: 20UpBu94MJqFAngUSOpr3Q_1747520842
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D25D31800446; Sat, 17 May 2025 22:27:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B87919560B7; Sat, 17 May 2025 22:27:21 +0000 (UTC)
Date: Thu, 15 May 2025 17:53:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/58] target-arm queue
Message-ID: <20250515215323.GA423664@fedora>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IREAQJs4YlvDY9to"
Content-Disposition: inline
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--IREAQJs4YlvDY9to
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--IREAQJs4YlvDY9to
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgmYlMACgkQnKSrs4Gr
c8giWQf/bt3q+B3HuF/gT7EMSQq1uBekoC4vbcbJrLRXPUZGMbteMzlhwAX/nxQ1
FPvIbor1nO6hE5r1AAQ2sIVwnKuz89Ho6Bc2qtYMbXyYXYB36P4AS54hMpTyUNFr
2j1Rb2ROCFou+VIauyL2bm/XfmhtIXzh37908czOOIeu4tRsTJ0DYXLPMwpTIFye
In5OqJZrMe+y18OMImlC04z8zU+NtEmJ9cvWel4L4z1Z4O9Yad7X74ty98Imu3Ft
vGLF1cwF3m4+fXYvzT/knjhkN7DM3pL09cOK5LKuEVEf9BKWWxHuhRx6oJqQgqXq
PADEeP0s3AJ+5v2tvLNzJqdSx9yGPw==
=YzJE
-----END PGP SIGNATURE-----

--IREAQJs4YlvDY9to--


