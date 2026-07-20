Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFBBC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrXr-00053O-Kj; Mon, 20 Jul 2026 13:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlrWe-00047B-6L
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlrWc-0007Hp-8g
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784567487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gzZ/70JSxNkwWWS4LjzKj5QiKfkZeFLURRV0+Y2p4s=;
 b=Rrb9hdOSG95gJxLhyiOGCl6JbYNcgrWDHc/kP4x43hBMDq/VG1RQbCQeNpCi4+cM297iPu
 6dToTgf22YJNUD49b+j5Om+8suUG3rm07LA1Wh3ehRV52uNGEFTOGARuxaY2lXXQvEow/Y
 2AkZqCI9outgES4DjAlLJF285lxzr9w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-KacLyuFFPWCE5TBoum6XPQ-1; Mon,
 20 Jul 2026 13:11:24 -0400
X-MC-Unique: KacLyuFFPWCE5TBoum6XPQ-1
X-Mimecast-MFC-AGG-ID: KacLyuFFPWCE5TBoum6XPQ_1784567482
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CE1A1954237; Mon, 20 Jul 2026 17:11:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BD2F18001E7; Mon, 20 Jul 2026 17:11:21 +0000 (UTC)
Date: Mon, 20 Jul 2026 13:11:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 0/1] Linux user for v11.1 patches
Message-ID: <20260720171118.GA64020@fedora>
References: <20260719183721.3035-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="loK3NO3jYcGp6d1o"
Content-Disposition: inline
In-Reply-To: <20260719183721.3035-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

--loK3NO3jYcGp6d1o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--loK3NO3jYcGp6d1o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpeVrYACgkQnKSrs4Gr
c8hhhQgArb+RnFyqNT19LiWV9bZJKBt9hmP7UQEutQIVl1xXfwFJduxkpyE6OVcG
DM2r0PlxDmt6emqQg7jfrUDFmvG9MTUYaGiXnskuRyqEtEebH+jyl8fbiATtytx4
RTNauQb82G0uH2E6hye2HwoiGzseg4TELWidd0Z/z5idHDW+MBDXdywnAHH1aoDu
HtxIPs8A5ISVx4EFgS1DEqf7NEjziAinT855vlC8AjC8ma4gnj9uZR41u7Qeutua
mXLy5hC+6If32M+4+5g7TNEHuU3YT9TP1CUSFI6yR0J0J5bvx52Xkbka2hDSOJkX
2rsYo+tCur+04/V1Di2NnUht93ntPA==
=PGaA
-----END PGP SIGNATURE-----

--loK3NO3jYcGp6d1o--


