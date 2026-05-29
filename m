Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FCDCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Ch-0003HH-9R; Fri, 29 May 2026 15:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wT3Cb-0003Gk-Lz
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wT3CZ-00041L-BQ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780084141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvGjAUdvC6rKzTXkxHiKxWw31vsnGVwVviXKV6/zFuA=;
 b=JOpw2/8PGVa0PhNi31BmMeIscSOOYW573W/6VDn5NgFO3voAPcMqHa/MwEXkEbo9wpb4Vr
 WUXMD69M46iFHxk4TX02ARv/GShAxJ0PaBG/TV0eVA8EuP60yWMO18JCXfyOWc3tqyKeBN
 4EIkcoKJATlhk2va9ddVNbNXq47KB9I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-Xk8N3sw6MrynqZ2EpteiWQ-1; Fri,
 29 May 2026 15:48:59 -0400
X-MC-Unique: Xk8N3sw6MrynqZ2EpteiWQ-1
X-Mimecast-MFC-AGG-ID: Xk8N3sw6MrynqZ2EpteiWQ_1780084138
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253A2180034E; Fri, 29 May 2026 19:48:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6A601955F22; Fri, 29 May 2026 19:48:57 +0000 (UTC)
Date: Fri, 29 May 2026 15:48:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 00/13] testing updates (gitlab, MacOS, MAINTAINERS)
Message-ID: <20260529194856.GA200119@fedora>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O2FsSyCe0jbalmyE"
Content-Disposition: inline
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--O2FsSyCe0jbalmyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--O2FsSyCe0jbalmyE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoZ7agACgkQnKSrs4Gr
c8g9swgAsNOfIOu9YJV9bYPKnRv3e/GWP99RQmZqP3fi7aSk4GHHkG+/6Mmsznjq
zMgcK9wvHQcwKhgbqdk4+hjwCf3KIBadltXWZcdwPuTJ8Ue1KXjq1vZgS7U1eG33
CkNNFhHsrLkMQV+M8UBYIw8JOMuAA58o6cq2qUY71lP0zZ0H0bNV8IYPJRhIBV1s
m9i6OfsXLbAu4AexYHuR5SMSUDQ6pWamK/6JThlNqdBTZGALxJeeuZOyTAXY0bL4
hY3TgiumAoTe4xhqsNd+gtFt9xaJkUctnFG2Uv7+Ysm72WGI7rbH3xUSs47BrN5H
Fvjx/c2nrXuyFKoLHu0sBQW9aRSWnw==
=oKWu
-----END PGP SIGNATURE-----

--O2FsSyCe0jbalmyE--


