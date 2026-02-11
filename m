Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC15EEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbot-0003xv-Cj; Thu, 12 Feb 2026 13:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqboq-0003wU-0Y
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vqbon-0004A5-HN
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770922416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAw4aZ+gjR2jUwxxxnqb+AbK06zKP891V04ZINb5pEI=;
 b=ScbWU3qJaBTGcxHZ225BWtmLMEEXrORnilgA4hki1RYM8CtmjsReaVpXRdJxOTZoosNupe
 fuVBHG+WDgPTH+5Bn1pQ7uRLhAxyEwwl+jg4YLkwv6rVhsROPwkZSul14YCPADDEGqqDtq
 oxYWgeODzdJVLxj7fidZEDt74HIpIrU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-dZbSVNAaOOyzi3ZJyCcYfQ-1; Thu,
 12 Feb 2026 13:53:33 -0500
X-MC-Unique: dZbSVNAaOOyzi3ZJyCcYfQ-1
X-Mimecast-MFC-AGG-ID: dZbSVNAaOOyzi3ZJyCcYfQ_1770922412
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1386518003F5; Thu, 12 Feb 2026 18:53:32 +0000 (UTC)
Received: from localhost (unknown [10.2.17.121])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9875330001B9; Thu, 12 Feb 2026 18:53:31 +0000 (UTC)
Date: Wed, 11 Feb 2026 16:08:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, bernd@bsbernd.com
Subject: Re: [Patch v4 3/7] fuse: uring support for write ops
Message-ID: <20260211210821.GC234157@fedora>
References: <20260207120901.17222-1-hibriansong@gmail.com>
 <20260207120901.17222-4-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xGDj1//P3GnKN9wn"
Content-Disposition: inline
In-Reply-To: <20260207120901.17222-4-hibriansong@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--xGDj1//P3GnKN9wn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2026 at 08:08:57PM +0800, Brian Song wrote:
> The payload of each uring entry serves as the buffer holding file data
> for read/write operations. In this patch, fuse_co_write is refactored
> to support using different buffer sources for write operations in
> legacy and io_uring modes.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Song <hibriansong@gmail.com>
> ---
>  block/export/fuse.c | 55 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xGDj1//P3GnKN9wn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmM78UACgkQnKSrs4Gr
c8hdZggAlwwBSRDQZ42W8hrkqb82O8DgCE8P3cuJS0vgzALzDREg9Z4pCaT/BG+j
SJE07uqZv06PLlfhPWQIXl/qEhwXVd0Q5vsTCHdVKYaP5pFOXyt6jPPVqgSb+Dzn
9xwXj2M5wKSDoENwd9L6z+cWeijk2d/+z3necKv1ilSax2Aho5Su2cqSQw4kQPeG
8tmi1KWEfCOV2rtF9EP7HHoniPpm8zjrrW6KU8+7dZlxtwYgL4jXEa872eMEPwLo
iq/DTBzt7y4igZD1doesfoNFvKYmnU5b0yhZeQCFo+IxHt1ois7QhULuap1umFiS
tKMKjyWbAf45UOoz+eB3BpwwyN6CPQ==
=XSjR
-----END PGP SIGNATURE-----

--xGDj1//P3GnKN9wn--


