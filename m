Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A6CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 00:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNL2b-000196-U1; Mon, 16 Dec 2024 19:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNL2J-00016d-QD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 19:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNL2G-0002qT-Km
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 19:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734393718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gj7mbvoIIZ36JCIQByIHMN9B1HyKfVI85mAxeQnqNW0=;
 b=hs7qyQzQHN8IOCTi6KkVCgFQEAooI671fUU8PPLPH6V/DJMsMFDgJ0sI1t+s98D7MFYzcS
 V1rsHI+GjjQbG2KdP5V2SOaCTcM7HR1alxFtNkRdhaMCoCDKLJ8BUE+obNgwCTPMEBJrvw
 qzHWa1NFal/rQWhAXxZ0iiZcM/xzh9g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-c-tLlwKrPKqSz-bkDcJYkQ-1; Mon,
 16 Dec 2024 19:01:55 -0500
X-MC-Unique: c-tLlwKrPKqSz-bkDcJYkQ-1
X-Mimecast-MFC-AGG-ID: c-tLlwKrPKqSz-bkDcJYkQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58DFE19560AF; Tue, 17 Dec 2024 00:01:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C787230044C1; Tue, 17 Dec 2024 00:01:52 +0000 (UTC)
Date: Mon, 16 Dec 2024 19:01:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/67] Constify almost all Property
Message-ID: <20241217000151.GA558905@fedora>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ft2LuTW+yrXYbp7c"
Content-Disposition: inline
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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


--ft2LuTW+yrXYbp7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--ft2LuTW+yrXYbp7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdgv28ACgkQnKSrs4Gr
c8j/qwf/V3Ja6Kojuqp/6DpB8F3TQX+bnF+hOWuWP58TvuBEmrwV+f6xFz3XNZPf
2l87udLR1Vsx9dyOzZbPqNNYsG1wAU170eS5FdjluLbNhufXRL6DMRSx3cs09Ods
3UUA83oqc/gc9BnRx4HxOEaTGxY2A7YDLTg7l5TYJFCBnerqaR7msOkVhk54PnGK
sJMKF0Krfsjhe+GHFZp7gWmt0oJ/4CrBZnEBP8D3Kizwc/q/9zn4Gyhd3U9WmuFD
LCjDlQ4hBZlQxe9MBVgZAVyQI0t2rgaZNSK45HxYetUqd7UjqTvCau2fqdoWYX5a
dQ5G3vMi8+kAyZI1BauJVgJEsCTE4g==
=dK46
-----END PGP SIGNATURE-----

--ft2LuTW+yrXYbp7c--


