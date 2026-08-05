Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89ACC55184
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 00:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrPuR-0002b3-8l; Tue, 04 Aug 2026 20:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPuP-0002ag-O8
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrPuO-0003Rb-8V
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 20:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785891299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qUzxlSgqRap3e47e2y7scPCZqTdEygMq/5N3JkXrCeI=;
 b=DG1qD+SA4anN3cGT3dP7otdQSehCYQh0yIalL/MN9rMA9yjbYzLhf+csVGtaiYm88BR/LI
 leVRo9FVw087FNk4R3juN0zy1n1ZSX6tQaPXlM/KDw3TZdq5QhE3iLs1csW/NxXYrwafv0
 kjj68I9wegcPWDYK9K7d3KjoXiNumiM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-VXYuTGRHOqehBksq2Cw8tw-1; Tue,
 04 Aug 2026 20:54:53 -0400
X-MC-Unique: VXYuTGRHOqehBksq2Cw8tw-1
X-Mimecast-MFC-AGG-ID: VXYuTGRHOqehBksq2Cw8tw_1785891292
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13BFC195608E; Wed,  5 Aug 2026 00:54:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AADAC1956087; Wed,  5 Aug 2026 00:54:51 +0000 (UTC)
Date: Tue, 4 Aug 2026 20:54:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 0/4] hw/nvme queue
Message-ID: <20260805005450.GA582140@fedora>
References: <20260803224436.38768-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dy/1ys5YnEWYQOrP"
Content-Disposition: inline
In-Reply-To: <20260803224436.38768-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--dy/1ys5YnEWYQOrP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--dy/1ys5YnEWYQOrP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpyidoACgkQnKSrs4Gr
c8hWKgf/d8Ntquuyk/KgWvk4GsQrtwiAMVIhChfeMz5lddRb3JoyTUwXMVP1abO7
FMSvQRlynaW2XycOrO2520H+s0+oy9d7DPTXBsuC0e9GjEySXz9eXz0ZZ6cggyep
w8b+2M2bVwvfY7C+1MMtEFa87RU2rFhpDKbX597nCm8fjeW739gaGgjoHO25ZZAQ
gGgU/nk31nbYgyIYPYbPG1uynYarUXkPwJnXr/CrqJeMJloJTqVQoCMGTo9TYlMT
ZGZovZWIfzuKXk1uiZMk7cdZ9x+HOzqaSPJgaz53DHIEjP5c5jY62DN8PEvUMdUx
lp0Lgd/MJXwuP9QX8iPxjWCaL5nwHQ==
=wbuz
-----END PGP SIGNATURE-----

--dy/1ys5YnEWYQOrP--


