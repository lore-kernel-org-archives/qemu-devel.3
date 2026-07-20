Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB0DC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrWx-0004XM-9M; Mon, 20 Jul 2026 13:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlrWh-0004CK-Tj
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlrWg-0007IA-Hf
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784567493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pdGAv5+twTEqlQmqoEljvWjrxtqSklTivjOAdFYH6MY=;
 b=NwGetWETy67Sozq6KorDehofONNKA8lr2i/sLHMxR+4uGOVXwzxM9C4rWFat/gdvWoxdFy
 gvsVqmjIpHgBt7Lys+FyPFKl/4bU39cPbkN6/iILqqP5VqMD3+1M7SVguOZsjo3yXA7hOx
 juM5lGSpuKDsKSdh9PwL/InV/jPg95g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-bNpQTa-AOxiQmj5AcJU8qQ-1; Mon,
 20 Jul 2026 13:11:29 -0400
X-MC-Unique: bNpQTa-AOxiQmj5AcJU8qQ-1
X-Mimecast-MFC-AGG-ID: bNpQTa-AOxiQmj5AcJU8qQ_1784567488
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94B4E1964CE5
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:11:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.104])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB86D195422E; Mon, 20 Jul 2026 17:11:27 +0000 (UTC)
Date: Mon, 20 Jul 2026 13:11:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/7] USB-related bug fixes
Message-ID: <20260720171127.GA64070@fedora>
References: <20260720103833.364506-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="leTQX2ofzN5+K2Fm"
Content-Disposition: inline
In-Reply-To: <20260720103833.364506-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

--leTQX2ofzN5+K2Fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--leTQX2ofzN5+K2Fm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpeVr8ACgkQnKSrs4Gr
c8jJQgf+IYvWlu1t4IoqfvX6WXfGdmcwd2+HMqZoj0wFuT+iKTY7KSZ59Uc1onPs
/7K0h+t9EUypJZvuVe/Ods86Km6Ey2dCsLMRHqQmeWK6x2EmGr5Xd2x/YGxQJMyC
9XxSPIG8mdvd7+cLPU0dwkxtcnyBkrZhPi3ilFfgg5UvBoaYzt62x4i/NiaT/NGA
v3jKdLZ3iPhrqgFA17upqQ5FEUMF09iOo2TrP7zaLxPIw9PfQm0lpS3X7YmyMNAw
/LBsn/R5JeTZ6DOLS3NRhfuFgGwROVE3b1x4ZK1jeFaqbIENiEk3kO7VviYosW7U
FrT8bBmLxUlvqbIg+yPBIJrnrF7zKw==
=pw06
-----END PGP SIGNATURE-----

--leTQX2ofzN5+K2Fm--


