Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356B0D59F50
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8iaF-0004Xf-Le; Wed, 06 Nov 2024 11:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1t8iaD-0004Wt-GZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:08:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1t8iaA-0004dt-PZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730909313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ngOtguWyuKycC0/LK8cWHwE2KvkVdKbG3yJCK+RxSjY=;
 b=HjC2TeuPlsdgQFwD6ismEiqhlpy0cDLxjAgXt0iJWn6516ajNhY55DoBUbuHRhuPoGnqE2
 NfISupqZksmBzIKTPlWZIKxFDCl58H92ZetjcWxzauxh9yoW29v4tvPFG4t6+m0b1x1PlU
 R/8uZb0nxfwdG/+DZN5tOLNkF/wvpZY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-haIMG6ywNdm1VClOuYcAZw-1; Wed,
 06 Nov 2024 11:07:16 -0500
X-MC-Unique: haIMG6ywNdm1VClOuYcAZw-1
X-Mimecast-MFC-AGG-ID: haIMG6ywNdm1VClOuYcAZw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C48EC1955F43; Wed,  6 Nov 2024 16:07:15 +0000 (UTC)
Received: from fedora (unknown [10.45.225.164])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 163321956088; Wed,  6 Nov 2024 16:07:13 +0000 (UTC)
Date: Wed, 6 Nov 2024 17:07:10 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com
Subject: Re: [PATCH 0/4] qga: Open channel before going daemon
Message-ID: <ZyuULjHv61Szsbu6@fedora>
References: <cover.1730713917.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ucARYSYd61jvZITe"
Content-Disposition: inline
In-Reply-To: <cover.1730713917.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ucARYSYd61jvZITe
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Monday in 2024, Michal Privoznik wrote:
>See 3/4 for in depth explanation.
>
>Michal Privoznik (4):
>  qga: Don't access global variable in run_agent_once()
>  qga: Invert logic on return value in main()
>  qga: Don't daemonize before channel is initialized
>  qga: Make run_agent() and run_agent_once() return no value
>
> qga/main.c | 52 +++++++++++++++++++++++++---------------------------
> 1 file changed, 25 insertions(+), 27 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--ucARYSYd61jvZITe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCZyuULgAKCRAU0rOr/y4P
vFMNAQDdziPqLqMkfudEI3X3Ur6eIXgLNfsOByOE75od2d/8mwEA1OidKIrgmvju
FnMeaxmx+UM1f4Lpgrz685z0lTpCUg8=
=X7BF
-----END PGP SIGNATURE-----

--ucARYSYd61jvZITe--


