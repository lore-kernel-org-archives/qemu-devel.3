Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6801E77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuQw-0000wX-Me; Thu, 12 Dec 2024 20:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQh-0000qP-Jg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQb-0003EH-Gi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734053111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWM8gJCoA8Ss20XMzUa7BFO6NTokUUKW8j0Bies8+zY=;
 b=TNTdKCz2O2mtVw46xk9M+StzT48bniV+GIAMzfNUiqP3tXAzTYTOzU/Oo9NbhzbYnbbnJB
 VXFbrhpskiF2lMkDlLpDsCexYNEZyrkL/TC+zY0IwFowr/iXojEleTekwOSIJsIQC3nnNc
 Ylop60wP+m1Ru01E9QNGcH7Y0ZtL+10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-NhNgC_q8PcGLMIns65XyGg-1; Thu,
 12 Dec 2024 20:25:07 -0500
X-MC-Unique: NhNgC_q8PcGLMIns65XyGg-1
X-Mimecast-MFC-AGG-ID: NhNgC_q8PcGLMIns65XyGg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D25851956088; Fri, 13 Dec 2024 01:25:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 665DA1956052; Fri, 13 Dec 2024 01:25:06 +0000 (UTC)
Date: Thu, 12 Dec 2024 20:21:24 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] tcg patch queue
Message-ID: <20241213012124.GA395472@fedora>
References: <20241212204818.2468583-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Srmr5YyYYsaoiEGN"
Content-Disposition: inline
In-Reply-To: <20241212204818.2468583-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--Srmr5YyYYsaoiEGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Srmr5YyYYsaoiEGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdbjBQACgkQnKSrs4Gr
c8jVDwf8CdWS0UABFW2bRqFkvJbURhR1SSdCZLk0lJLr9JaIqCx5V3SuFbX+8wdA
2lLsewRFXver5ZHugJGYwiRwQN6Tf3pk7sQuafQzT/waSNlWr7eKv6ZXgH/kFj4f
0mJD/7ptF/D4RFSCtM7oBurnCLUrKH2ySaW/jKStQHwodqWRvxKnaO9DsID5SipM
a26IzCbsNBxrsEO7W4g6WfGkI6WPQ9uw4bVFnyaTDqZMXhzfGzImIzyCK17tNrcg
5yl+tUcn87YJbGGUCXRkK7u0M1ZZXbSDN6VmsTFcMMAE2X3yawasnM1InNovnttL
iUjA2KIGPsmwLA1PzY4JBB1brLOEJA==
=/Ff+
-----END PGP SIGNATURE-----

--Srmr5YyYYsaoiEGN--


