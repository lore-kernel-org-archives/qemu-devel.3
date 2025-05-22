Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14454C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAxY-00056s-Kb; Thu, 22 May 2025 14:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uIAxV-00056Q-Hj
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uIAxS-0003Ms-Mj
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747939678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUNCdCA39uDh2QTrAiaI/p5ezBJxV579gkFC0WocEvQ=;
 b=Qzg2w8nsmDYabAgP/IKumfhj1AGiDGQBIyHtsreTnsvuxe//cpCvQvfrMtZVlqRIcOXlFL
 5lDv+sGDGCwiabPOapRhHXFzL2+z+yrw4/nQvxIhs7VLHQ+07OeVLvguRlJ0Urx3J9f9WD
 B48od3RoIBB4EqxTlAo8fFd/xj7AgxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370--xBc7IJhPeirrCA-WmcKvw-1; Thu,
 22 May 2025 14:47:54 -0400
X-MC-Unique: -xBc7IJhPeirrCA-WmcKvw-1
X-Mimecast-MFC-AGG-ID: -xBc7IJhPeirrCA-WmcKvw_1747939673
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94D121956088; Thu, 22 May 2025 18:47:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA8F119560AF; Thu, 22 May 2025 18:47:52 +0000 (UTC)
Date: Thu, 22 May 2025 14:47:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, peterx@redhat.com
Subject: Re: [PULL 00/12] Migration 20250520 patches
Message-ID: <20250522184751.GA16275@fedora>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n6zYfyHRSqz1NmIo"
Content-Disposition: inline
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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


--n6zYfyHRSqz1NmIo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--n6zYfyHRSqz1NmIo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgvcVYACgkQnKSrs4Gr
c8jhDAgAl0RihyJImOfVJH4fawsyAurFdcqYW4+xM+5rhAqTjgGLlTS90TPrJUmE
omioXwBKL/Pul8pIkJteyH6xNRUdU6+lk8JeECwrS45dHjW1U1QttO08gnrQpNgp
qfN26MhA2U/5FtrzxpPzv1i+nLSB88DVZbSsYncMsZ5UzvdlxD/mjjIdYD7ZACtl
1wYYfRXRrpgAIxchPBd7Q4AlG55meK/As8866dGUUHxw5Y2hEmtQLeptJ5EISgGA
ASVJo6T4bD1vu6+rSgnqhhIuHHVIDl6GZD5A2kvCCDkj1OZ0djbxsVLmgXgk8Q/d
GnZ7J461X9+WF7yqsqx7TFjXc3QE2w==
=X+Aj
-----END PGP SIGNATURE-----

--n6zYfyHRSqz1NmIo--


