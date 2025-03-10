Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B361DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tran8-00008M-Ng; Mon, 10 Mar 2025 06:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tran4-00007g-On
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tran3-0005wm-6q
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741604120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7CTQICW4lB9hnFIbYNeMJPbNmUOs/wMazZwgCIoYj+I=;
 b=YbAIIpba9NvXN2CBCtN0BlzfGC39lFiu6aZoLDoMB0w1qHHsP0hbnfVfLwTNcXAIEkwacF
 ZhrrU6sc7CPSiTZQIJyjbppmKWTnK5haIRfs34TuTsngOh8IhCLWAY/rsg+wHSGtPQBtkr
 KJPmECC4jTVnhWNDxUx/K2yA9tzupa8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-BMKUVDGhOK6MpUvj_e_pZA-1; Mon,
 10 Mar 2025 06:55:17 -0400
X-MC-Unique: BMKUVDGhOK6MpUvj_e_pZA-1
X-Mimecast-MFC-AGG-ID: BMKUVDGhOK6MpUvj_e_pZA_1741604116
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BC041955DCC; Mon, 10 Mar 2025 10:55:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 513D01800944; Mon, 10 Mar 2025 10:55:14 +0000 (UTC)
Date: Mon, 10 Mar 2025 18:55:12 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, afaria@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] aio-posix: Factor out adjust_polling_time()
Message-ID: <20250310105512.GE359802@fedora>
References: <20250307221634.71951-1-kwolf@redhat.com>
 <20250307221634.71951-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pVLfexvxi81M/ZbQ"
Content-Disposition: inline
In-Reply-To: <20250307221634.71951-5-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--pVLfexvxi81M/ZbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 07, 2025 at 11:16:33PM +0100, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  util/aio-posix.c | 77 ++++++++++++++++++++++++++----------------------
>  1 file changed, 41 insertions(+), 36 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pVLfexvxi81M/ZbQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfOxRAACgkQnKSrs4Gr
c8iApQgAwfyP+rChoupgA+7CcqS/hMRk7dLS8/8aL25Oxs2/0XwlvwVePrYtEtZg
sGgPbkrtkxQcLXeaeAskq0FwZy+fUHBzFDlY02gFzTq2k6//nopzuDbYXOdkmCkp
KC0jyCUHDlYiaxl1k3rgD8FcgNU973LCt4Mo0iQ4+J4qNWOcCw2OeJT6VpJH6FcU
NtlxMuI1HcjtFdVNexShiu5XrPUNYLkO6giv/eO3BU8AiSpbTVA1jXciHsRNLRKo
+2IlkuIMdZWGdLbA2Ww4cCgSo0J0j44RbxP9wpN7Sd+AHiRYodA+knt/bVroz6W2
1xc1gmPywWhymxMfSle6rpExueZHLQ==
=MH8c
-----END PGP SIGNATURE-----

--pVLfexvxi81M/ZbQ--


