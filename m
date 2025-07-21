Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CA6C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 18:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udvIk-0007OW-TM; Mon, 21 Jul 2025 14:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvIi-0007K1-0P
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvIg-0005Cp-3s
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753122705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FUsGmf8CUbxxVEHoSiyqlRzU5J+AWDQNion1NZ39d+M=;
 b=bcr+i1wNIzyiqgJ3+Wy3lEAxTz3E3bvZ47UN8u9xVCxkQMqSmIEtt2Fj5JI62NZfy5Cl7n
 AOhKoQR3/ptJfYYrASo7fBu2MxhRNLuCfQr3R856fK4JTA6OLlZ+JfKN2Ed10XwWKgmlLy
 xaERLEZIM4LG87vo34Jiji3fxaIs6Ag=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-qQxCM0irNYOum1zwl2R_GQ-1; Mon,
 21 Jul 2025 14:31:41 -0400
X-MC-Unique: qQxCM0irNYOum1zwl2R_GQ-1
X-Mimecast-MFC-AGG-ID: qQxCM0irNYOum1zwl2R_GQ_1753122700
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC89419560B0; Mon, 21 Jul 2025 18:31:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4822C18016F9; Mon, 21 Jul 2025 18:31:40 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:31:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] tcg patch queue
Message-ID: <20250721183139.GA78004@fedora>
References: <20250721151113.56372-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lZzCYSXTPD4P+FpD"
Content-Disposition: inline
In-Reply-To: <20250721151113.56372-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--lZzCYSXTPD4P+FpD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--lZzCYSXTPD4P+FpD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh+h4sACgkQnKSrs4Gr
c8ia3Af+JgU9GkYlQK0L+pkZXz+inHnn09Mi9LNx5glxjhwaoc3oOJTNL2fNt8Pz
uOkr26AjVD4dqjqYb/dM/Y3LZ9YDFcEUMprcEqddZbebgeX7PBViYDrpBsjU7tVm
zQfmqGouW7l3pXnw75X+vz6wBa1opubb44wIZEh0HJvrIWJQpnuEcLafAnTRiukd
4pAERbCzKvD7XelB2LjbFEH4O2/H/PpNhekgJvz2/kTvM/XgFaH4FxVw8RkrgSnR
BgVWSd/iRRe3OdIqPl4hyib/oOb+HoOhInUIGg5MetFfjGM/0lk42jzEloNqCP8Z
3u9r4eesujtbYsRbUxjBUGd9VZdD6g==
=oZp/
-----END PGP SIGNATURE-----

--lZzCYSXTPD4P+FpD--


