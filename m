Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83820C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txobi-0005jD-Og; Thu, 27 Mar 2025 10:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txobg-0005i1-Uf
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txobf-00088b-91
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743087198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zc4eu0C4LoQ8yFzS2s/iGTgeeKF+vMrun1gwSkc+6QQ=;
 b=GS1ZUmqAkKAG65QeOqozzrxv4GMzPojZscA8A5B74jPkxOJDkS8t4DFC5xwAZd/d+N/B+A
 r4ys/IiERFVbnCR/uAKea4h5ECLaOe5SDSaM+CBBxlcAEgAdmznTQF9hT9VyOxTs3hY2jp
 7KB/uy9jC0dhF2XEw0olVSZ2NoHmJ9Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-QQzvhuPnMqSwAeyLWbxoNQ-1; Thu,
 27 Mar 2025 10:53:14 -0400
X-MC-Unique: QQzvhuPnMqSwAeyLWbxoNQ-1
X-Mimecast-MFC-AGG-ID: QQzvhuPnMqSwAeyLWbxoNQ_1743087193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 015361944F0A; Thu, 27 Mar 2025 14:53:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B3D31800944; Thu, 27 Mar 2025 14:53:11 +0000 (UTC)
Date: Thu, 27 Mar 2025 10:53:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 03/15] fuse: Remove superfluous empty line
Message-ID: <20250327145310.GC37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YlI/YK2kjIxKcasZ"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--YlI/YK2kjIxKcasZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2025 at 05:06:43PM +0100, Hanna Czenczek wrote:
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YlI/YK2kjIxKcasZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflZlYACgkQnKSrs4Gr
c8gBtAf9F/IiS/wEXn3xW9dpzIJ9Nj82X7wLel9uqMjN/wOc8T5wTW2lNYN9XDgN
opvirdZo//XHwQ8vKdokKHvbc7pYmipFsOKzsO0uz2mo85qg42fsBw6GY2VwvUUo
mwMqrCBCzbkL8xaC1hgYNPCdovSmLD9K1Wb/3jMgwdJMW4QlQHhoDlI7Slm3vJt7
YjV4CL3/NPzWf0RIjNhsPcCrnTSV0+GFep1CxWDlwd3b6sH53cJT+VOofpJB/bnS
xCiKgLbWFFurXdUpepD1CoTRW1ivQAV2Q7VBMXNBWiYB5KkbYLjicpmeJXAmPHNJ
MjuEIK+9wmv1kyqREXe2BAK8dCifhg==
=h9+H
-----END PGP SIGNATURE-----

--YlI/YK2kjIxKcasZ--


