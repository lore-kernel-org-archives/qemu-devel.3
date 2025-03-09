Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4A1C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trUGK-0001pk-ON; Sun, 09 Mar 2025 23:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trUGI-0001kO-57
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trUGD-00042q-0V
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741579020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gFkGOY70zUnwng3AonYui4UspjxoA1N+lJ2X/WoVDI=;
 b=UEB7t+/k0KyV+tOSUxgBI7jpW0ZNKiDTeYQVIBU0JizT+KxSa0I6HevgLX8GICIQVLeyIR
 ecROE/GlSuV4RFNkyBtWOR2CA1rUxRjkJODOjt5aLkvKar6I+Yoyni8Gz2OKLazztc31dH
 ORE2D5Qg4C1jpScV/gpFZLht4BuTJAg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-YeWs5yP4N7O77O9UiyH6Aw-1; Sun,
 09 Mar 2025 23:56:57 -0400
X-MC-Unique: YeWs5yP4N7O77O9UiyH6Aw-1
X-Mimecast-MFC-AGG-ID: YeWs5yP4N7O77O9UiyH6Aw_1741579016
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AE101800361
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 03:56:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 884061956096; Mon, 10 Mar 2025 03:56:54 +0000 (UTC)
Date: Sun, 9 Mar 2025 08:41:25 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/15] Functional and s390x patches before 10.0 soft-freeze
Message-ID: <20250309004125.GA50577@fedora>
References: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bM/+5Bw5HKDmGMkw"
Content-Disposition: inline
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--bM/+5Bw5HKDmGMkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--bM/+5Bw5HKDmGMkw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfM47UACgkQnKSrs4Gr
c8hpkwf+LDFbme96jC8OszwO6UAGZxxp0bRhvMyAWBVXATJEwOVr7E+3+S1nvVmd
YbFnogj+6Bq8S8CiPZTvlVkCiVh/XF5651uYmXoMs7f0bOmaYBkQxtCABFxERltD
n9LuMSyeUr9TLjhC20q/jxauExn/j1HCp8NaJy1ZwcS0g4rkTrVolm/EHNboMYEz
9ancmXL3NQhFycJLjwdOjXvg6wClb0zR3iqWgwjxp05bj/T62NaGlHOM/AU7XSG4
lpcalgFtwHkvvT92pqVMgv9qXUbHEtovLSqwHpoPs3QOzEtSP4MAQkI0tmF+nOVl
feiYhVO2R2dG50MhFVCD3XKroeZguA==
=UiY7
-----END PGP SIGNATURE-----

--bM/+5Bw5HKDmGMkw--


