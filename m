Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7D4C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texDT-0000Xc-Gc; Mon, 03 Feb 2025 09:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1texDQ-0000WW-S4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1texDP-0007wx-CI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738592058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eihbu+YTGJg47Or8lq/fdbLALUeTNDwwngwxGAOT7Uc=;
 b=daDp+MPxtW5IeWChyg83yUNcBKrQaItSswRZq1m456VoUwqkBG6GnfxjVEbODvgnfRh2KN
 +5iNo6R50r3As6l3Qz5ryA2QhsPfXu32J+RUf+wlt8xDAMl5VmudaqB4N38ohtqtw9TeTR
 2pTxjdlbhzvuEVWwBIvTv27xftKGBQc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-7W9UvnDLNdGcOEo-bBXiOg-1; Mon,
 03 Feb 2025 09:14:13 -0500
X-MC-Unique: 7W9UvnDLNdGcOEo-bBXiOg-1
X-Mimecast-MFC-AGG-ID: 7W9UvnDLNdGcOEo-bBXiOg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3590618009C1; Mon,  3 Feb 2025 14:14:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DFD11800980; Mon,  3 Feb 2025 14:14:11 +0000 (UTC)
Date: Sun, 2 Feb 2025 12:49:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, deller@gmx.de
Subject: Re: [PULL v2 0/9] Hppa system mfdiag for v10 patches
Message-ID: <20250202174920.GA62447@fedora>
References: <20250131092229.38232-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pQvz7gdXerwtsIoT"
Content-Disposition: inline
In-Reply-To: <20250131092229.38232-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--pQvz7gdXerwtsIoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--pQvz7gdXerwtsIoT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmefsB8ACgkQnKSrs4Gr
c8i59Qf/QUfso0/iXJkSiWyI9oMiLgX+ddliVyy/40kQ6Fn4bqeo7fTEIHlJEQAc
Q+Ksp8TTwn65M6jZ03gQQZ3MUcfFCyST4oNRlYyGJvAdd18ivPlB6UxUWU54PKrY
ryMZ2Beg4DYUt75+t3Le7E9kBwIJqfpPP5Dj6GV4lE2sO2n2PRHHkfDBB0oCx7Mr
Z1pVk7gfIE+PZHmS//ZP5+V9ceV8yUjhWfI0uDuT9mV+nFbGQWMPW26hvazzScTJ
ZJR/YhpNLB4W5JmWMGi4MF1DN3q9yI+W1Awmg9S/4Uy7k9ahqFhR4L+je/0Pw/eu
J63n4CXSPEESJG2/YIH6X8KCBxFAsw==
=nL8v
-----END PGP SIGNATURE-----

--pQvz7gdXerwtsIoT--


