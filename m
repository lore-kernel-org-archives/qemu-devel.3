Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC95F5A8A7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEsSz-0003g9-4x; Mon, 20 Apr 2026 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wEsSZ-0003dn-3E
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wEsSX-0004d3-Kp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776706256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VPeuBoSwC34SzA7tVzPvDFUIEHo77VzKoYtbWJNoZMU=;
 b=NGhG8SbWfmEy/V6pqesaqLItk0Rly42O7jtc/ONjGtcNzkv5wsNoURebGDtybbdZfjPpIB
 9Ck6hJYnXn2Si/Zqt8CoACYTIAIvupylHuS2GflXysgKz4MMbNmmJl2RE3iJEWuqZDDS2i
 wBSE+OXzTXkkZbsvKBOgCn7bLqsODfQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-f9CKqDGrNH-MZ-X6_S1J4w-1; Mon,
 20 Apr 2026 13:30:52 -0400
X-MC-Unique: f9CKqDGrNH-MZ-X6_S1J4w-1
X-Mimecast-MFC-AGG-ID: f9CKqDGrNH-MZ-X6_S1J4w_1776706250
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E6F91800473; Mon, 20 Apr 2026 17:30:50 +0000 (UTC)
Received: from localhost (unknown [10.44.48.35])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 507001800660; Mon, 20 Apr 2026 17:30:48 +0000 (UTC)
Date: Mon, 20 Apr 2026 11:47:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/7] MAINTAINERS: Remove PhilMD from NVMe Block Driver
Message-ID: <20260420154724.GA366820@fedora>
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9vA+ThI383PTF1sI"
Content-Disposition: inline
In-Reply-To: <20260417110550.70068-7-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--9vA+ThI383PTF1sI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 01:05:48PM +0200, Philippe Mathieu-Daud=E9 wrote:
> I'm not following this code anymore, no need
> to be listed as reviewer.
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9vA+ThI383PTF1sI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnmSowACgkQnKSrs4Gr
c8j5tggAuSzLdddubvwpQV0ix+WXoYI6B9JMCFjoqMzBxZbozXA6qxkJ0hX5Cidi
LkO9/wsTDd2cg1cbjDIdIjoOBBmaekmY2Qqe/ucufVEvwHfAjPSA/ZJvxP7UPZ1J
p1jYIbX6Yl25GoHB3TnzLxQWlvsTn8sqCiAQ7O1eqjNa7kPey/sILpNdwDPW2thy
CTv4aEac9C+dJwOQtCgMLc2K5fwAcE1NJhMN4JzgZBW4XSIyojotFt8KfCcF1uVx
E7V7XwHJgb5R6UEUR46lWNQhnhJ7KvD/jsafC21qHQEWggz2px1N05kXWfEkg4Cj
hwfqzPwdV/c/QOfennngPspBEdCDdA==
=ucz9
-----END PGP SIGNATURE-----

--9vA+ThI383PTF1sI--


