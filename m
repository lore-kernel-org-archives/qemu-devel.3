Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB48C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjtTJ-0002vE-Fa; Wed, 15 Jul 2026 02:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTH-0002ul-FB
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wjtTE-0003rl-Ps
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 02:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784098311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7WZX0iywPBD75Bvcg7Blxr4ilA3AnWl0uzJ/GwaiCV8=;
 b=f/sqvLfQIXo32STuIUPVAbcds+h5oNn5+ov5pWigMsD5h8zX/uKErs/qy8gDQ6r3QsIYEJ
 K3TNcA5nLOdXpRRZj0VE9GpzqZENfkRLwV0pfLt5eSNH9fQooqZhZcWvpjfDrSUy6yHWOz
 ly5lV//An5h8cETeSfK8WYoNJuO9TnE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-WMz5yeKRMQ64CQrEwsD04w-1; Wed,
 15 Jul 2026 02:51:47 -0400
X-MC-Unique: WMz5yeKRMQ64CQrEwsD04w-1
X-Mimecast-MFC-AGG-ID: WMz5yeKRMQ64CQrEwsD04w_1784098306
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2AD4195604C; Wed, 15 Jul 2026 06:51:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDDE918004AD; Wed, 15 Jul 2026 06:51:44 +0000 (UTC)
Date: Tue, 14 Jul 2026 20:22:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 0/2] Linux user for v11.1 patches
Message-ID: <20260714192249.GA706131@fedora>
References: <20260713143533.4641-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wni6wUYsKAYU0DSB"
Content-Disposition: inline
In-Reply-To: <20260713143533.4641-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--wni6wUYsKAYU0DSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--wni6wUYsKAYU0DSB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpWjIkACgkQnKSrs4Gr
c8hukwf+O1j13ThX6rrprwxUdxRMRjveEYjPMPR/WgVTuEeXvurCvom3EPyqFJbR
GqsGzq+eeTHhozcRyiPgkjQVc9dXiU92YeM+G3tF+OpgPydb2xvHaWBVjrann1AL
VCC84vYXFoIK8ND7lQMtYkpNLA8s+CA0Zw6Dtx4JH5JewLol9mDrG28z2nqRyQiC
zBaJY751hL2pwWmOhhiiSdcrUZFJivbqqPnpiIOj8s7ubhJtL0X1ZPE3HetnSzac
IM7drnAYQ0xOG9XmP/IPJCmHKooKV5Ien9URUi5lDQaKszXxJDyveT9SfWl7i72i
Vr6s1QSDOCy8LrBfe4AeysUDCm8j7g==
=5x+M
-----END PGP SIGNATURE-----

--wni6wUYsKAYU0DSB--


