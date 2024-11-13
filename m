Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D90D41C30
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 10:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBAg6-0003tP-Iw; Wed, 13 Nov 2024 05:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1tBAg5-0003tG-IO
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1tBAg4-0002sc-4q
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731493966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A9ZreOZL0iYuFK9Y3hwW3P+K1SCul5Q1ZQ3kwo8lJDs=;
 b=M2z/BodBQjjkM+axBPjuKzVbO9RC9vRzSamwW2q6lHUGdzu+Wu+tSx2ZN1vubIBG5fmxq8
 avdb3UOG+jecT57Kfla+DFKsYZardhwvz+zhwolHw1xfpJCyGQWJrBc3vEWr4b9iIKeZAx
 I1TT9NrGBx8VUTtrhdMDHRDuBSh99Lc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-T_30wueJOkKoXG0AJCjUYQ-1; Wed,
 13 Nov 2024 05:32:42 -0500
X-MC-Unique: T_30wueJOkKoXG0AJCjUYQ-1
X-Mimecast-MFC-AGG-ID: T_30wueJOkKoXG0AJCjUYQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE7D01956083; Wed, 13 Nov 2024 10:32:40 +0000 (UTC)
Received: from fedora (unknown [10.45.225.217])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDC941956086; Wed, 13 Nov 2024 10:32:38 +0000 (UTC)
Date: Wed, 13 Nov 2024 11:32:34 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Rodrigo Dias Correa <r@drigo.nl>
Cc: qemu-devel@nongnu.org, jiri@resnulli.us, jasowang@redhat.com
Subject: Re: [PATCH] hw/net/rocker/rocker_of_dpa.c: Remove superfluous error
 check
Message-ID: <ZzSAQpHc1l4oKY3k@fedora>
References: <20241112012612.317020-1-r@drigo.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iSR0qcDBtKLa7OY8"
Content-Disposition: inline
In-Reply-To: <20241112012612.317020-1-r@drigo.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--iSR0qcDBtKLa7OY8
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Tuesday in 2024, Rodrigo Dias Correa wrote:
>of_dpa_cmd_add_acl_ip() is called from a single place, and despite the
>fact that it always returns ROCKER_OK, its return value is still checked
>by the caller.
>Change of_dpa_cmd_add_acl_ip() to return void and remove the superfluous
>check from of_dpa_cmd_add_acl().
>Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2471
>
>Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
>---
> hw/net/rocker/rocker_of_dpa.c | 11 ++---------
> 1 file changed, 2 insertions(+), 9 deletions(-)
>
>diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
>index 5e16056be6..6d29130ec2 100644
>--- a/hw/net/rocker/rocker_of_dpa.c
>+++ b/hw/net/rocker/rocker_of_dpa.c
>@@ -1635,7 +1635,7 @@ static int of_dpa_cmd_add_multicast_routing(OfDpaFlo=
w *flow,
>     return ROCKER_OK;
> }
>
>-static int of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
>+static void of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
>                                  RockerTlv **flow_tlvs)

The second line is misalgined.

> {
>     key->width =3D FLOW_KEY_WIDTH(ip.tos);

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--iSR0qcDBtKLa7OY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQrkJ38FtkKeURG3jOljYAA5sbRZAUCZzSAPQAKCRCljYAA5sbR
ZP8aAP0e/RIWyF8ziiWbZr7/qu7L+s7NA4gB1uDSrQTt8lNqBgD/dL3RgTqQQ1qo
g1tphcUk0yc7zcAwu7oXI98S3X/xJAY=
=Wx0R
-----END PGP SIGNATURE-----

--iSR0qcDBtKLa7OY8--


