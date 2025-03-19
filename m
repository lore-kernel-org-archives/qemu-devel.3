Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84BCC35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwgG-0005Uy-Vy; Wed, 19 Mar 2025 12:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1tuwg9-0005Hw-P6
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1tuwg8-00054p-0o
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742403235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eL/kTS6eKS5K7z/X/En8m3Rg8f6+pSA4O7ncB7ZDoJc=;
 b=Vy3T1AA3M8uKxNh3beLQFJnVtZlyKDTise4WQhLO3/6bgvS4b9aHBerNeaZmusqVrKPLJH
 SYy95MP+qHApqyag6Z+jIm/ZwAweNY7Tmz4UJDDy+H6oV/sIOOZh15XVBLx3MBBnv0berz
 OeRR/6LjkUvyz2Qhz50wKdFfeKAUfBU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-Cb9Y8w6gO-GUBzcysbcl2A-1; Wed,
 19 Mar 2025 12:53:50 -0400
X-MC-Unique: Cb9Y8w6gO-GUBzcysbcl2A-1
X-Mimecast-MFC-AGG-ID: Cb9Y8w6gO-GUBzcysbcl2A_1742403229
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 805F71800361; Wed, 19 Mar 2025 16:53:49 +0000 (UTC)
Received: from antique-laptop (unknown [10.44.33.169])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF130180094A; Wed, 19 Mar 2025 16:53:47 +0000 (UTC)
Date: Wed, 19 Mar 2025 17:53:44 +0100
From: Pavel Hrdina <phrdina@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/3] scripts: render_block_graph: Fix with new python
 and improve argument parsing
Message-ID: <Z9r2mK4gMNSVK7yy@antique-laptop>
References: <cover.1742401551.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O0Dz5VLQ7l18KV1t"
Content-Disposition: inline
In-Reply-To: <cover.1742401551.git.pkrempa@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=phrdina@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--O0Dz5VLQ7l18KV1t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 05:28:06PM +0100, Peter Krempa wrote:
> New python doesn't like '\l' escapes from the 'dot' language.
>=20
> While at it improve usability of the script by employing proper argument
> parsing.
>=20
> v2:
>  - use mutually exclusive group instead of hardcoding it (Pavel)
>=20
> Peter Krempa (3):
>   scripts: render_block_graph: Fix invalid escape sequence warning with
>     python 3.12
>   scripts: render_block_graph: Implement proper argument parser
>   scripts: render_block_graph: Avoid backtrace on error from virsh

Reviewed-by: Pavel Hrdina <phrdina@redhat.com>

--O0Dz5VLQ7l18KV1t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAmfa9pgACgkQUi1kczAH
4YyN2xAAzWHEK8Q0l0MriFZbd72lbRiNZPDsny7uRtC4DlB6tVlHoLLe44C5DRA3
rtu+PPL40HGb31ZIekd6MwPuUNJgfHqMqceZf2wp9OerrWU0DQdYuic/zWwQk1Ti
gi/ulfJbNUNJbSrz6TLu1NSKkxH+VX2PCIRsEt4EWO/vTFRWRgYbaw9IPqIAl2rU
zE1JMGyRbcFYEed2oGj2H+kRneC7UP2zGgz8C8JjwGR6/V6gAWMqss8IR0WxYA0w
kGNz0DUT4WnncsXVsd0UzpPJGOkT+DpCuNNoq0G+YdsSvgmbepsqHDydP4EmH7Ta
0TevbfRYY/o3DEzg/jYWgzm1qFcPhfUPbq4FHJBkdu9+XLoEpoTq3qYO3fMYTLie
+3Uvq2d7IYj0Pf404CCYPqJdNgBmZQhjKUQioGvPK2EhQQrKtpoZlGwknBaCrebG
gSe93iCNrYuqp+BtD249Yscqd2a6WcqTYzUPk8Xe5ILEPRNMtTZCB1ck0JMbO5dy
bITvwpbx3bu/Qr1QPGyyICtZpmNtE4N2/iL33pIVNMD1shpYwmN8SyUiuyOO9ccC
KpSBuE3n97/FEgzvgMb5JnkWKXIX12wkbn7npTwFW1+MsbTc3u4zchYlGx1mDBaD
n+t80QV2Ba7NK3yfU4yLoxf9eBE3Af3bFzzW27TShwV0KhvTMUI=
=yCFW
-----END PGP SIGNATURE-----

--O0Dz5VLQ7l18KV1t--


