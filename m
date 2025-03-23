Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E02C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhkr-0002tw-Gc; Mon, 24 Mar 2025 09:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkS-0002rn-PT
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkQ-0007V8-Bd
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IuX+mKjZPbitMOnZCtjU1yb5e+9XB3TV1uK6iP/TpjA=;
 b=YXkIb30NCUCJsJ/4Ao64pc+WJcpe+5tSZX8lX1Bllxxb3bv2h3C/Z3m5yLux5rtnbzg++K
 YhrZjtp3+dho+acqQxiu74ipMcu6noDhdXmkWgSAoupn3YvpULrRlcDJGwboBRpXU59dUc
 RZZIMxLGCokfYdRyjrHo6njbQk4TYF0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-Ym1WXBfKNAKS3s97UaDeYw-1; Mon,
 24 Mar 2025 09:21:41 -0400
X-MC-Unique: Ym1WXBfKNAKS3s97UaDeYw-1
X-Mimecast-MFC-AGG-ID: Ym1WXBfKNAKS3s97UaDeYw_1742822500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DAB219560B0; Mon, 24 Mar 2025 13:21:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5ABA180174E; Mon, 24 Mar 2025 13:21:38 +0000 (UTC)
Date: Sun, 23 Mar 2025 18:29:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Subject: Re: [PULL 00/12] ppc-for-10.0-2 queue
Message-ID: <20250323222915.GA41839@fedora>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+c/vWJ4qm3V7eW8m"
Content-Disposition: inline
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--+c/vWJ4qm3V7eW8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--+c/vWJ4qm3V7eW8m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfgizsACgkQnKSrs4Gr
c8jP2ggAmm0WoDM0Qg2emkMzXC+cdbJ1q5Uhi6AHVfyqO9LYQjVzFlkbS4St1RWO
a6njZJkH4D8/KcLr2AAb2Qregla/HrTYesm2u0QRm1nhIoplAY1gN8VQ0WWtSS55
LQkOaWhq5HLLLqpEhzBBRwWREF74SJ5myG98F1ITRHC4amhiMYIuPZHVl1Fb+6uv
3qTosq5XC6yzsdxq8gecCmk7VzROhlGaYgPwDGVu4UkTswYBwdm+YGJOpHx+h40B
NVZKUcAvpCPg/N3F8OF8IZ5bskgqTvCxrAkZbB6lxl32sajh/FJHxQNsA00joKLU
UP4VG8n54sEuTMo60nKCnB+9kIymJQ==
=SEtv
-----END PGP SIGNATURE-----

--+c/vWJ4qm3V7eW8m--


