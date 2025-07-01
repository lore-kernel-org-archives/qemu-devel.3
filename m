Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A9C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWs0e-00041V-5r; Wed, 02 Jul 2025 03:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uWs0Z-0003zc-Us
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uWs0U-0000TL-4D
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751441747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QD6Ife/7wgRwr9Ng04tUz5kOKtkOUR0X8o8zJcla0T0=;
 b=f8sW7XRKLJJSNYkmLBnVm94rM6eah/xLPq7/tW1SUpj8JzWU1UWR82MlgWnH1HdyUmbE7D
 8phMbC6o287Jo8svMX/xOBJbnfkWoaajuMquGk46+ixVzjF8SNlDbFEbM+lYXruJoN337l
 JcQTtKN3vl0/2hKLXfnzVkGpcWdsGzE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-7-t3VnShOeW5mVBHu-RaYA-1; Wed,
 02 Jul 2025 03:35:45 -0400
X-MC-Unique: 7-t3VnShOeW5mVBHu-RaYA-1
X-Mimecast-MFC-AGG-ID: 7-t3VnShOeW5mVBHu-RaYA_1751441744
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9599D1800366; Wed,  2 Jul 2025 07:35:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3122180045B; Wed,  2 Jul 2025 07:35:43 +0000 (UTC)
Date: Tue, 1 Jul 2025 07:22:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/29] tcg patch queue
Message-ID: <20250701112206.GA19512@fedora>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OSnQOpR8HC8X4ehB"
Content-Disposition: inline
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


--OSnQOpR8HC8X4ehB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--OSnQOpR8HC8X4ehB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhjxLYACgkQnKSrs4Gr
c8h9QQf/X/5zOnOeM9/ira3K+QxgkYHbnToBcycYV4WculNKdOvT2REgJQi6pW31
SEfr+4Ksnm9HIvZmJyfGbNlWBiuxi/PvA34uylH03W77U+81E9QasJafR1TQOSQW
DAUPE0tRgzTjtOVL6V0+6ql6HVl+kIMgH7kbIZxagGT9iC4OZyWxcVp9up4R7xVv
QUViB5VVD1O+DQoI5u1H003qx+q9AJw9zr8yiAsF5udbZ3bR9PTNR7e3QEZ0EC3m
SdvvKyWMtihPecQ2vRubAWyfvC1mj3GzEOpqbAxCmhYpXQQB6UN5RnalCEG40RO6
jvtjxHMP/kt09x0+WujApY/2G40eLw==
=4iUz
-----END PGP SIGNATURE-----

--OSnQOpR8HC8X4ehB--


