Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A61CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgQ3-0000d5-7u; Wed, 20 May 2026 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPgPl-0000MT-7v
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPgPg-0003uL-7I
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779281557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+WP2ClbiYjyZjzT0tfAA6+PZ+RyO9l7mrL1849NqHY=;
 b=d8NuGguNOU6wmSxHAkNYrjmfcyJjklsQNojxUq1W29DFWfRG/EGB/KrG5YRxfR/4w9FFd3
 IcXnI8w7/n5sxUujnk/2lZis4Vx3rJ56cygXIH45/kn81PAlLY1X1cat/RTtwWyEOjNs5M
 53t8l+8CQIukQqiP+CqsCs45K4nlL80=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-A5Lb6Ej2OeG7tlU0etNg4w-1; Wed,
 20 May 2026 08:52:34 -0400
X-MC-Unique: A5Lb6Ej2OeG7tlU0etNg4w-1
X-Mimecast-MFC-AGG-ID: A5Lb6Ej2OeG7tlU0etNg4w_1779281552
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13F3D1800657; Wed, 20 May 2026 12:52:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A55641800576; Wed, 20 May 2026 12:52:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 443F721E6A01; Wed, 20 May 2026 14:52:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
In-Reply-To: <20260520123947.12711-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 20 May 2026 14:39:47
 +0200")
References: <20260520123947.12711-1-philmd@linaro.org>
Date: Wed, 20 May 2026 14:52:29 +0200
Message-ID: <87fr3ms0oi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorg=
anise")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b75f3222f2f..2a4d124fb3c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
>  F: linux-user/hexagon/
>  F: tests/tcg/hexagon/
>  F: disas/hexagon.c
> -F: configs/targets/hexagon-linux-user/default.mak
> +F: configs/targets/hexagon-linux-user.mak
>  F: docker/dockerfiles/debian-hexagon-cross.docker

This one's wrong, too.

I have an unsent patch fixing both.  In fact, I have an unsent series
fixing *all* F: patterns that don't resolve to any file.

>  F: gdbstub/gdb-xml/hexagon*.xml
>  T: git https://github.com/quic/qemu.git hex-next


