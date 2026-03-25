Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6C7109C046
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RSv-0004s4-NA; Wed, 25 Mar 2026 12:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5RSr-0004rK-Q6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5RSq-0008C3-8g
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iNMRRkHa4c3eYsZdGmfsDfjxato3j8WQGZ/e92kqEyM=;
 b=Z9tR4ZQb7f/m1mXz329jOSoyCLlKUFQX74Q0xvacOeYAAb6ouG1ED1d/8XfTIoUHikPEo8
 /sJuFRnhCXRHW2nwom0FeTlRpmGnCAuQgDdfqMjC7pRoIu9eecjtdJ2GgK78WJsUyz8t9k
 k2zA6F1NTykvDa5Cr3L2mDT8c38OdDQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-VcSTSriTP8qQ8ejSn1K2Rg-1; Wed,
 25 Mar 2026 12:52:10 -0400
X-MC-Unique: VcSTSriTP8qQ8ejSn1K2Rg-1
X-Mimecast-MFC-AGG-ID: VcSTSriTP8qQ8ejSn1K2Rg_1774457529
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A7721944F01; Wed, 25 Mar 2026 16:52:08 +0000 (UTC)
Received: from localhost (unknown [10.44.32.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC918300019F; Wed, 25 Mar 2026 16:52:06 +0000 (UTC)
Date: Wed, 25 Mar 2026 12:52:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v2 3/3] qapi/iothread: introduce poll-weight
 parameter for aio-poll
Message-ID: <20260325165204.GA701300@fedora>
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-4-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3eV4ODSkzvFgOnfB"
Content-Disposition: inline
In-Reply-To: <20260323135451.579655-4-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--3eV4ODSkzvFgOnfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 08:54:51AM -0500, Jaehoon Kim wrote:
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 28c641fe2f..39d17010bc 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -85,6 +85,12 @@
>  # @poll-shrink: how many ns will be removed from polling time, 0 means
>  #     that it's not configured (since 2.9)
>  #
> +# @poll-weight: the weight factor for adaptive polling.
> +#     Determines how much the current event interval contributes to
> +#     the next polling time calculation.  Valid values are 1 or
> +#     greater.  0 selects the system default value which is current 3
> +#     (since 10.2)

QEMU 11.0 is already in hard freeze, so this patch will go into 11.1:

  (since 11.1)

> +#
>  # @aio-max-batch: maximum number of requests in a batch for the AIO
>  #     engine, 0 means that the engine will use its default (since 6.1)
>  #
> @@ -96,6 +102,7 @@
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> +           'poll-weight': 'int',
>             'aio-max-batch': 'int' } }
> =20
>  ##
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c653248f85..feb80b6cfe 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -606,6 +606,11 @@
>  #     algorithm detects it is spending too long polling without
>  #     encountering events.  0 selects a default behaviour (default: 0)
>  #
> +# @poll-weight: the weight factor for adaptive polling.
> +#     Determines how much the current event interval contributes to
> +#     the next polling time calculation.  Valid values are 1 or
> +#     greater.  If set to 0, the default value of 3 is used.

(since 11.1)

Other than that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3eV4ODSkzvFgOnfB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnEErQACgkQnKSrs4Gr
c8ghTAf/dfb/2iLohXvqpK1NbMROUZSHyus5U0mTAinSVxZfRg4chTH0oOl7jWjN
Hua2a1NHsTY1SrZujI0UANyMWq7ph2+7jAO0NLCQoRkKzXjqmEKdh3HueMYHbMIs
bEXwDUmwJnAeXfocR6GWlfnXrKQEnoB8B+LEIVsoCcylY8R+I2FdmdbnJ54mtz1I
Pohe/FWMTaAkv4/BKV5+TkCswECqsTt5lfCCeuGDpCgfcdsC2vreWymWSvRSiJ2T
WNFskX8m2u7oKzOmL0X0+oCTegm95dC2/xjVvBb2m31Kd7zaif8KTGXLI2nxwvu9
6nquSHK2LdirYWg3m5rEV1uP/X53sw==
=gOlD
-----END PGP SIGNATURE-----

--3eV4ODSkzvFgOnfB--


