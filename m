Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCB7C982F0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCu-0002s2-Vn; Mon, 21 Sep 2026 09:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCt-0002rV-LN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCs-0002kK-17
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3KttKas8LwS05duudE/TBGCb5jkwv47U96z9guubLQ=;
 b=cDrJHLpm38+/RC9XtWNnIYKP8ct9QpZRel9iLZbAwvklRzTIxDH9RIe09wtuYU0SI2Lygk
 SuRzJUoGLYcpiau8JlAMJ/ywWx1oDDOoTATYoj4AO7F/Xz6Fg1k+SVqX9dynLqV3IBeRe5
 TISixFlEXJ+/U7hWtuBEXjuECeO09B4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-Br8H75hfOhSx8OX1l5yURg-1; Mon,
 21 Sep 2026 09:37:12 -0400
X-MC-Unique: Br8H75hfOhSx8OX1l5yURg-1
X-Mimecast-MFC-AGG-ID: Br8H75hfOhSx8OX1l5yURg_1789997832
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE8CE1954120; Mon, 21 Sep 2026 13:37:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C9ED1956042; Mon, 21 Sep 2026 13:37:11 +0000 (UTC)
Date: Wed, 16 Sep 2026 16:01:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH V17 11/13] monitor/hmp: display IOThread holders
Message-ID: <20260916200155.GH162769@fedora>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-12-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xRoO7NltFh7fUM11"
Content-Disposition: inline
In-Reply-To: <20260915101655.3216101-12-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

--xRoO7NltFh7fUM11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 06:16:53PM +0800, Zhang Chen wrote:
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 91701ddf33..d7dd24d951 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -246,11 +246,31 @@ void hmp_info_iothreads(MonitorHMP *hmp, const QDic=
t *qdict)
>      IOThreadInfoList *info_list =3D qmp_query_iothreads(NULL);
>      IOThreadInfoList *info;
>      IOThreadInfo *value;
> +    IOThreadHolderList *h;
> =20
>      for (info =3D info_list; info; info =3D info->next) {
>          value =3D info->value;
>          monitor_hmp_printf(hmp, "%s:\n", value->id);
>          monitor_hmp_printf(hmp, "  thread_id=3D%" PRId64 "\n", value->th=
read_id);
> +        monitor_hmp_printf(hmp, "  holders=3D");
> +        for (h =3D value->holders; h; h =3D h->next) {
> +            IOThreadHolder *holder =3D h->value;
> +
> +            switch (holder->type) {
> +            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> +                monitor_hmp_printf(hmp, "[block-export: %s]",
> +                                   holder->u.block_export.export_id);
> +                break;

Kevin: Special-casing block exports is unfortunate. Other IOThread users
tend to be full-blown Objects. Do you think BlockExport should become an
Object with a path (e.g. /block-exports/ similar to how /audiodevs and
other object types are in the QOM tree)?

What I'm thinking is that block-export-add/block-export-del remain the
commands for managing the lifetime of exports - we don't use --object
syntax. But simply making BlockExport an Object would make this and
maybe other future changes cleaner (no special cases for non-Objects).

--xRoO7NltFh7fUM11
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqq9bMACgkQnKSrs4Gr
c8jNkwgAlLLNlP11DsDvVAwqrCfiiw0zsnEks69vqcOFRkXQ9LiLm8jEMA3oMxyY
5qR393yoiZa1k/Sk5p4QYp3hoXPhuXoVStXEm1RvRWEXLB7hKCLlGhrNHqKptkjf
TKowqcOFS+HdN5fFxg6iGuw4M0o9K9dFCh58mtQKDFs5AMczEok/DImloXusRtat
Pr3oh9ZzIQyIOLFEbFJrJjhiJySK7XMPoUMJ9XS6mAqnhVFfr4hNzTEvkREI7rsS
tbWkv6kDuHJwYSV0ngcZxY67kNEZVPFZACtVDhL8Q4QdNGAmX3jbf3iWwMcVmpyV
/DMYMOvsv1Rvtr4qygPX3sZK7UJ7JA==
=u7bg
-----END PGP SIGNATURE-----

--xRoO7NltFh7fUM11--


