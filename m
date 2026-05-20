Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B643CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfpI-00065A-N5; Wed, 20 May 2026 08:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPfpH-00064T-7W
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPfpF-0007vn-9h
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779279299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sm/E5egj6/J3NwKEAZpgJRBczfbzEeK+Db2s4PGDCDs=;
 b=EaFB4HfHy3By8qRKbkG1QTiuio1LMEeUWa89mtpJte0wdpuhb6jgv8r6NMklpOi2xWk/2r
 DqtPiuDlTTMa3DAIo7fg+PDGjY9GwpPbwnGTqGW6d5YdlCMxRo66qxp0gT1bsP/RuU2pn5
 HqVweOV/FcGBkYSTSecO9RIX2J2Zzk8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-ak78N2pMNZa_ebBKsXpTVw-1; Wed,
 20 May 2026 08:14:57 -0400
X-MC-Unique: ak78N2pMNZa_ebBKsXpTVw-1
X-Mimecast-MFC-AGG-ID: ak78N2pMNZa_ebBKsXpTVw_1779279296
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E68781956095; Wed, 20 May 2026 12:14:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44C201955D84; Wed, 20 May 2026 12:14:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E123C21E6A01; Wed, 20 May 2026 14:14:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-trivial@nongnu.org
Cc: J. =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs/devel: Fix typo (s/exist paths/exit paths/)
In-Reply-To: <20260520-exist-v1-1-535f929a87ae@9elements.com>
 ("J. =?utf-8?Q?Neusch=C3=A4fer=22's?= message of "Wed, 20 May 2026 08:44:12
 +0200")
References: <20260520-exist-v1-1-535f929a87ae@9elements.com>
Date: Wed, 20 May 2026 14:14:52 +0200
Message-ID: <87se7mz39f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Nominating for qemu-trivial.

J. Neusch=C3=A4fer <j.neuschaefer@9elements.com> writes:

> In the discussion of control flow through a function, "exit paths" were m=
eant.
>
> Signed-off-by: J. Neusch=C3=A4fer <j.neuschaefer@9elements.com>
> ---
>  docs/devel/style.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index b8edcf9316f059fe15415543098118b28fcaf99c..f4da16a0e83ca6fed205e2516=
fff4ac2cc941d04 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -469,7 +469,7 @@ for a time/space trade-off like ``tlb_mmu_resize_lock=
ed`` in the
>  SoftMMU TLB code.
>=20=20
>  If the lifetime of the allocation is within the function and there are
> -multiple exist paths you can also improve the readability of the code
> +multiple exit paths you can also improve the readability of the code
>  by using ``g_autofree`` and related annotations. See :ref:`autofree-ref`
>  for more details.
>=20=20
>
> ---
> base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
> change-id: 20260520-exist-b23e143e9bfe
>
> Best regards,


