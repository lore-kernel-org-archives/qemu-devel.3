Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CDEE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 00:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTVvh-0007X5-HT; Thu, 02 Jan 2025 19:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tTVvf-0007Wu-8D
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 19:52:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tTVvc-00036x-I8
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 19:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735865556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2CklbbpjjbOpO0Hwnp/+CouSw/F3+3CyUSyXI3sVlnM=;
 b=efZbvmT9ezR5+EpaZNYBnDwyH0p9Fb68sI9UoNqFrHi7vUGJPmRAAhl3RMiPUEqoAo/x7C
 7QwZ6sF7sukcD0XMdDiZk6qZgc+4wfv3AZlpehqGWL9o1rnG0mGb41CiwRha5oRscd30uH
 SZJbfJLRba7YvPYMz+F9KwmSgtej0vM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-jXbRhhnsO1yQB6J25f1VKw-1; Thu,
 02 Jan 2025 19:52:35 -0500
X-MC-Unique: jXbRhhnsO1yQB6J25f1VKw-1
X-Mimecast-MFC-AGG-ID: jXbRhhnsO1yQB6J25f1VKw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FF601956088
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2025 00:52:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C07103000197; Fri,  3 Jan 2025 00:52:32 +0000 (UTC)
Date: Thu, 2 Jan 2025 19:52:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/10] Functional test improvements and fixes
Message-ID: <20250103005230.GA1236709@fedora>
References: <20250102103138.354618-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TlxNsUeAfU3K0G2F"
Content-Disposition: inline
In-Reply-To: <20250102103138.354618-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--TlxNsUeAfU3K0G2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--TlxNsUeAfU3K0G2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmd3NM4ACgkQnKSrs4Gr
c8gpXQf6AkrgaFT8bEcXhvRuWEE5Gnq8NV2Heng305HzRqFjAc9A8Ak68WFlKK0f
9lu+QJJbhnQeFxI2/5sWFf/K2eXCXNflVEa7eDLHvWvAFzIoL3JhmVA+g74WoSWS
57C7sBmsFDFO6ozfSDFBJ+v72mBw0iyYMfOqvxpPp4tN9NpBhLXjrvpdav+s+DbE
1NLloeRB5I/L1fFz9axWE29lIRrRkyo+VvjlY64WmMddPL/sHaHP5lIU/vtebKzy
bGsTXnYgvwlHbl240QRM0ExabF39DWsAAy9QhEutpiKQ4b8Drhv6UXkSE6mr8goe
GPNqxK2OVaj/CVqHboiuSxnbLbSWPw==
=gahQ
-----END PGP SIGNATURE-----

--TlxNsUeAfU3K0G2F--


