Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46B0CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNahi-0005J9-AC; Thu, 14 May 2026 14:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahh-0005J0-CJ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNahf-0002mZ-Hu
 for qemu-devel@nongnu.org; Thu, 14 May 2026 14:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778782948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7TLkAtKAjJOcWmX1NhvUU0qtZkAa0vbuhBqe5nS1OtQ=;
 b=YE5x6ahyeJzw2ARlvMniYLYMFV9HofAykKXdOzy/72d2abtgJWv7BSClvCh0uHXZsWj4p+
 pkGoR6cgTWvdZ10dq7SFto4VZIv8XXH5FusH9tFlqgPkt24xEVY6oZGxb19QhHkZi/Kusj
 1HOMWOBngRvzsOwJsTpn9Z7cjPM9xjY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-02HlXp9cPI6ebvkZmn-51g-1; Thu,
 14 May 2026 14:22:26 -0400
X-MC-Unique: 02HlXp9cPI6ebvkZmn-51g-1
X-Mimecast-MFC-AGG-ID: 02HlXp9cPI6ebvkZmn-51g_1778782945
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 966F819560A2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 18:22:25 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F77E30001A2; Thu, 14 May 2026 18:22:25 +0000 (UTC)
Date: Thu, 14 May 2026 12:28:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/6] MAINTAINERS patches for 2026-05-13
Message-ID: <20260514162804.GA1485612@fedora>
References: <20260513175157.3765935-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jWV4zkbUEWZ6oaY7"
Content-Disposition: inline
In-Reply-To: <20260513175157.3765935-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--jWV4zkbUEWZ6oaY7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--jWV4zkbUEWZ6oaY7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoF+BQACgkQnKSrs4Gr
c8hRuwf/Sm2Mozxhnrg3j3bqBMfYU3k09uLTZYoj7DJsBqD/e8dX6YieQwUAtW2e
rDuMtM6MVI9tT7yIlObhQWbobQu7YjUTyZMkrk7a+MPxKLqqAOrAn6dFqC+8fBU5
8sPywBUzNamV8J0ZRfCv60YjFLXh0Psph4NtdfvF0chPFkOJPlKTIJ4MdXKnn+Tt
c8UjM4TpwylTwhzoUf4Pp3O4a7Co+2CZNtEWagSbK8nims5eBwyA3TRhLDbzNZaU
Qyb39F64acSiexulH9cRLB1g7NQQHDWYO9tAIKJYEGTpc5UMRoY9LZJeylBeGluP
7dxyED3ScVym1LycfpBByl0bocGYGA==
=V1L9
-----END PGP SIGNATURE-----

--jWV4zkbUEWZ6oaY7--


