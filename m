Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8762C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1sUu-0002gG-GS; Wed, 02 Sep 2026 17:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1sUt-0002g8-EU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x1sUs-0004nI-5C
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788384469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ucFu8xLRGeLFb1Yf23ECT0wk5W86Peg4a1g3tTgHcQ8=;
 b=Hf9qe6O9KbV/ZSkXR8OfbRQGcd5XrPRwyulHNpA3uWx0MMPBmnHUjmKVPFDFLLzuRS1nYJ
 F/mdySDMPLjyyi2nex/nB7kCIGPGbGZUw99ubzKN0xcyknfCz80roQVqr+eBX64Zv1Pf6O
 tg1O50aGjB4PQFdeTAxN8aODjBFZfrI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-HrWX0QJNNLGhNEM3evhhZQ-1; Wed,
 02 Sep 2026 17:27:45 -0400
X-MC-Unique: HrWX0QJNNLGhNEM3evhhZQ-1
X-Mimecast-MFC-AGG-ID: HrWX0QJNNLGhNEM3evhhZQ_1788384464
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70C09180267F; Wed,  2 Sep 2026 21:27:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92963195608A; Wed,  2 Sep 2026 21:27:43 +0000 (UTC)
Date: Wed, 2 Sep 2026 15:20:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V14 05/15] block/export: track IOThread references
Message-ID: <20260902192044.GA787498@fedora>
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-6-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A7D2NkAKdKn/+BCj"
Content-Disposition: inline
In-Reply-To: <20260831160038.221776-6-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--A7D2NkAKdKn/+BCj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 12:00:26AM +0800, Zhang Chen wrote:
> Track the IOThreads used by a block export and identify the holder
> with the unique BlockExportOptions id.
>=20
> Acquire holder-aware references during export creation and release
> them on error or export deletion.  Support both single- and
> multi-iothread exports.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  block/export/export.c  | 62 ++++++++++++++++++++++++++++++++++++------
>  include/block/export.h |  5 ++++
>  2 files changed, 58 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--A7D2NkAKdKn/+BCj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqYdwwACgkQnKSrs4Gr
c8iT0gf/VMo5McxcRSpzcyA8sydhOLnmohCKJIh/SwYeLZMEaQJ16P+4gHQ5w2lt
+eBNbfhkgarpN8kfZxclM6+HcdS4ooNLbd7StwMDCZxWHRyfOUFfLISqiRYbzedW
dnaI6tNDeY/oCrWt0+nB6YpvSLVq+GDBWE3qFFKf24aQGuubXbsFH3qymhby5YiK
DoIO2BXirLWUEXPFV9TjGB9gd/e2LZ38XwP5FJs5Co8iUWJuAYhjBF/I3NhhuQIf
Nw/hEp7Q6CFmPY5mBMIQ72r4ThW2q7QNQ7SbdFKDmVE4/TLVGtoQhDNjC0zr6eCQ
VQVB8G2swCva6OV9IP2QUHGy/t9htA==
=P5iv
-----END PGP SIGNATURE-----

--A7D2NkAKdKn/+BCj--


