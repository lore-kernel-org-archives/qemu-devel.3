Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A5C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 00:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrPtz-0002ZE-9z; Tue, 04 Aug 2026 20:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPty-0002Yl-2S
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPtw-0003P8-Ln
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785891270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1cEtZRs7pAZsc17ngTN0iRh444JCJSdKKtIaVyCuok=;
 b=dx5ump6QDtiC2tAgGpadf3DI3KnCryt6kFgsYdzcNR5t6Kiu7LZPzwj1JvR21ljbU4X4EJ
 y7Y7LPNF4PiaDFNm8I5H0zqv7WaULlEjLRj5JBHkuAhWlT/fXZavfecOSiDglEXL5OKJ/e
 /oBLQu+ktcw35bOTRc0iu+4n/TvBNbc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-EhOl_j3IOf6Li9O9nLs02A-1; Tue,
 04 Aug 2026 20:54:29 -0400
X-MC-Unique: EhOl_j3IOf6Li9O9nLs02A-1
X-Mimecast-MFC-AGG-ID: EhOl_j3IOf6Li9O9nLs02A_1785891268
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B2AA180044D; Wed,  5 Aug 2026 00:54:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F3DF195608E; Wed,  5 Aug 2026 00:54:27 +0000 (UTC)
Date: Tue, 4 Aug 2026 20:54:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] target/i386 patch queue
Message-ID: <20260805005426.GA582011@fedora>
References: <20260801163524.62111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ITxOCPudQ3RDs0Tr"
Content-Disposition: inline
In-Reply-To: <20260801163524.62111-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--ITxOCPudQ3RDs0Tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--ITxOCPudQ3RDs0Tr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpyicIACgkQnKSrs4Gr
c8jP6gf/ayWy289Hr7ph/P2juRD+RWaVr0bk89nH/+rkiMB7rIsIG/KTcqwabxdM
Hco9t6/u5HWEuRwj6EF9vTC8lvypDa0Cnf09MQj3cGeWf6PfLznWlFGFb58uxBE1
E9LROltw3ci14Y2dckOPXeSU9TBmANEgMqI8+3AKZNnlPE9SsBlGX7wqWzOJrBCo
UirstWU0soBzqg1leyTlXp/pwgy1ZvrKWIqhI+MZJO1Mr8OYc7SZhNnklcQ+wzXJ
duMI8K+S3HOzM+lIT54B9+1L+XkXfPg2f9aIttfxO51zvWrSsS3EQc2VFTOxRmKP
QDGhAkoAb1L7dPlIPI54UkY1zLNnNw==
=BunS
-----END PGP SIGNATURE-----

--ITxOCPudQ3RDs0Tr--


