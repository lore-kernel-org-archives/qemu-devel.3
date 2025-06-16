Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC281C7115F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRBhs-0001J8-FY; Mon, 16 Jun 2025 11:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1uRBho-0001GJ-82; Mon, 16 Jun 2025 11:25:04 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1uRBhk-0007Pg-SF; Mon, 16 Jun 2025 11:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1750087475; x=1750692275; i=lukasstraub2@web.de;
 bh=Q0QMmAMAxMTOjGJNlVYZvDXiWUaMzdU5o4YzJb1SrV8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GDLj92xAnycwVDmkA4qYAf+Ce2m2k+SIdrQzYRx7bEjntH52xj22WjQEDImgzX07
 2zyt8Sp96eWXcBD3MYJrXCX0EDx37irGkTjWc/fw6+LBOFU/zTLPDqBmLOHvA4m1y
 vEhylFnWbtm8nOQoiyu+ywsVvzKKW/QQxuLAKaaCSI95ytZh0xGMUPxNhiHUoTIQ5
 JaJzEBCkt0R6AFp1SBbANvWIddc1iWkwsWcWb8X/vttIsNE1yPwhKMjbe+RDJsmBW
 K4esvHKQ6ov1Y9L8fKyMhIQnSsJWvlZLu3V2wthBblrCoNisXvqfikewbdiK+YR5h
 WRg5tmW1eGtNpv7gug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([185.53.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1v5Q3N1FhK-00ehL8; Mon, 16
 Jun 2025 17:24:35 +0200
Date: Mon, 16 Jun 2025 17:24:19 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Eric Blake <eblake@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Alex =?UTF-8?B?QmVu?=
 =?UTF-8?B?bsOpZQ==?= <alex.bennee@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 17/18] qapi: add cross-references to yank.json
Message-ID: <20250616172419.4c0dfbda@penguin>
In-Reply-To: <20250613203620.1283814-18-jsnow@redhat.com>
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-18-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A1sQA+D9lBpD9/d97+.OaJH";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:0rrxlqVTR4Nju1BaOpJodG1Me9d6NsT50HdBqdv9kZWkhzm2hxR
 Pqt8ERZQXpH7nSqLGoLDRU46KxhSNl/toXdtx2qdB7BkwbcIxY+ZoTP4QDXZwNEDUlJ57a4
 Ln94yHnLKBhRjPf4ZCa3pBRCP8lf60XR5lf93QvoMcoVEldMraGMH9nNfEpuF6tEXaodIJy
 C1LRCFNJyfv5RcEaddp0w==
UI-OutboundReport: notjunk:1;M01:P0:HEHvbdEuN0c=;8NLtlk3deJOqH2runTGnF/zFssn
 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
 HEMt5SH
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/A1sQA+D9lBpD9/d97+.OaJH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jun 2025 16:36:19 -0400
John Snow <jsnow@redhat.com> wrote:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/yank.json | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/qapi/yank.json b/qapi/yank.json
> index 9bd8ecce27f..931d4b22d4b 100644
> --- a/qapi/yank.json
> +++ b/qapi/yank.json
> @@ -9,7 +9,7 @@
>  ##
>  # @YankInstanceType:
>  #
> -# An enumeration of yank instance types.  See @YankInstance for more
> +# An enumeration of `yank` instance types.  See `YankInstance` for more
>  # information.
>  #
>  # Since: 6.0
> @@ -20,7 +20,7 @@
>  ##
>  # @YankInstanceBlockNode:
>  #
> -# Specifies which block graph node to yank.  See @YankInstance for
> +# Specifies which block graph node to `yank`.  See `YankInstance` for
>  # more information.
>  #
>  # @node-name: the name of the block graph node
> @@ -33,7 +33,7 @@
>  ##
>  # @YankInstanceChardev:
>  #
> -# Specifies which character device to yank.  See @YankInstance for
> +# Specifies which character device to `yank`.  See `YankInstance` for
>  # more information.
>  #
>  # @id: the chardev's ID
> @@ -46,20 +46,20 @@
>  ##
>  # @YankInstance:
>  #
> -# A yank instance can be yanked with the @yank qmp command to recover
> +# A `yank` instance can be yanked with the `yank` qmp command to recover
>  # from a hanging QEMU.
>  #
> -# @type: yank instance type
> +# @type: `yank` instance type
>  #
> -# Currently implemented yank instances:
> +# Currently implemented `yank` instances:
>  #
>  # - nbd block device: Yanking it will shut down the connection to the
>  #   nbd server without attempting to reconnect.
>  # - socket chardev: Yanking it will shut down the connected socket.
>  # - migration: Yanking it will shut down all migration connections.
> -#   Unlike @migrate_cancel, it will not notify the migration process,
> +#   Unlike `migrate_cancel`, it will not notify the migration process,
>  #   so migration will go into @failed state, instead of @cancelled
> -#   state.  @yank should be used to recover from hangs.
> +#   state.  `yank` should be used to recover from hangs.
>  #
>  # Since: 6.0
>  ##
> @@ -74,7 +74,7 @@
>  # @yank:
>  #
>  # Try to recover from hanging QEMU by yanking the specified instances.
> -# See @YankInstance for more information.
> +# See `YankInstance` for more information.
>  #
>  # @instances: the instances to be yanked
>  #
> @@ -100,7 +100,7 @@
>  ##
>  # @query-yank:
>  #
> -# Query yank instances.  See @YankInstance for more information.
> +# Query `yank` instances.  See `YankInstance` for more information.
>  #
>  #
>  # .. qmp-example::

Acked-by: Lukas Straub <lukasstraub2@web.de>

--Sig_/A1sQA+D9lBpD9/d97+.OaJH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmhQNyMACgkQNasLKJxd
sliPDhAAjQOp62xZKPMjQeIQBKGDCOhb1CP6Pdu/Ynq/n3puAgKiHvvK+Y0nA47r
/5RQB/uSu986KOTKZm5zRC2vn2riOr/SQs+h4D7PdYQ4NavrAOksM2dsdJNlz6Ii
6dNLzZ+layeHOQVmKKrYe8+cYb0JW4+/p37DF7s37vgSCIZ8C7myAE4bsC4g994b
PMlCqREURysEclP/wjhPcrPv94x3/f2sZ/7bAdUscU7RlPVbYcgEJEy17OweFaz4
GRgInyao+Rc/9RqMPF/SGUwNnoVGY+zMbFTMIXGz+WA+yhLS9fytgH7Ok/IPAubS
WCYTX6cZ62KjlpYRAP+hp/P214NEzlNKB8PgeREixMACB9yZq7BBnLyYP3pPyzwT
TMgpUO0Lyn+DzuD5YlGj/JQVunFN6o9EcnVxo9xHYWEMQNjeuKJaIUrA1fs0Z5pz
h1sLU2pUGWceRx0A5ysGbvbAYUZItLaNd3C5rs3ilAySZ4Wlxg6XBUWzX6rm2EjV
OvAIgMH1ZsA8bPZ8dGoAXlqpgGmQ6jIPUeJqktJA1V/3FR79iUHbDDvP9XzzOmIi
dNrt4CxhgmUKnAETQamKHpXxVzzZ2w/N/qJAiXuPEaJKJlDthth59GYVgsj5/J2m
NJqt6Xl9BzD+MqUO57WXXV57XtCfK1vV5TR6EWYpZPw6JATt1L4=
=iTc5
-----END PGP SIGNATURE-----

--Sig_/A1sQA+D9lBpD9/d97+.OaJH--

