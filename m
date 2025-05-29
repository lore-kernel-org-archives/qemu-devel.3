Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8626DC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 12:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKcUD-0000W4-Iv; Thu, 29 May 2025 08:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKcUC-0000Vd-98
 for qemu-devel@nongnu.org; Thu, 29 May 2025 08:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKcUA-0007cq-Mk
 for qemu-devel@nongnu.org; Thu, 29 May 2025 08:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748522150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTk4QVZMX4gmEb/VS74XUtdgfFkQupGiT/Z7pfNI6tA=;
 b=ecAsU1wdsbP0B4CRh0lojr+1kNf1tYL4hOi0XjDkN3+WbUu1fUvuBygpMjVOeIH7EVYRzm
 73Y9uWqxyKK2Iaf0t3/yUsrWySgEqX13llXNGe7IxzxLd5UG+PhxAuMMP3rp9ir936y/kA
 LQAwLP3dJmsep1irYu694UEypnZdEXQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-xgRf824HPHKuRcwH9vBlsw-1; Thu,
 29 May 2025 08:35:48 -0400
X-MC-Unique: xgRf824HPHKuRcwH9vBlsw-1
X-Mimecast-MFC-AGG-ID: xgRf824HPHKuRcwH9vBlsw_1748522147
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E46B19560A7
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 12:35:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1B2919560AF; Thu, 29 May 2025 12:35:46 +0000 (UTC)
Date: Thu, 29 May 2025 08:35:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/4] Miscellaneous patches for 2025-05-28
Message-ID: <20250529123545.GA55826@fedora>
References: <20250528121143.2208075-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2/qZbsKeXLJn7UIc"
Content-Disposition: inline
In-Reply-To: <20250528121143.2208075-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--2/qZbsKeXLJn7UIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--2/qZbsKeXLJn7UIc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg4VKEACgkQnKSrs4Gr
c8iCdQgAvNWUd56e3COZSshFfjiuXDuJ1D70lGEnuLAT8QmA2KfRz/lmjP6scWxe
1qzDEkFUmyzjnaFr6/VVEkwq93EK99fuOsMe+T739UN0v8qOFa0E0ptwyQyIpIYF
XRMdgHp8rnFTFxBH393aJV5u+WYaB5EMhFVso5uk5IJPV6I+sjBqFhyHnxHuxnXk
rYoRrcfVDP3XaA0nLCrCl9OXicM+BmnrOMwPiMv8sQt43t2/DeP4ZBlhLjwV0V7s
+/gnboYFmVt6dlRpmiQ7Urc0Ink1jeo0tC2Lu3+g3s7jsuEC9h3xvvCDEVqn8PnZ
fN5ODmKpQ+9uif4r2HhVU5c4CnleDQ==
=GPmN
-----END PGP SIGNATURE-----

--2/qZbsKeXLJn7UIc--


