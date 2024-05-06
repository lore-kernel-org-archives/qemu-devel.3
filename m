Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA9EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 06:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3rbV-0006Qn-RQ; Mon, 06 May 2024 02:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3rbG-0006KJ-OK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3rb6-0004dd-Uj
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714975990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQapm1J1mC6roB+BwuihFStYb/xnfa8N3vQmFEeEWm4=;
 b=QrVBjCIgXifNwiygENwd9hVjeiP8W8A4fyGFhlDJk6uGKH4VrQj4eSdJ5VKe9T9inYDjMP
 w+lAB1FapboTJh52BY88pGEhAJtAd9kowUzzAM5m9sD5CreD4MtynMhwmZ0dDBqTWlu8/c
 tjr7LbGD5F/OD68wruWyFQ4xd3CW/0w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-9NrTt8yaOn6O2N4EOqzfTg-1; Mon, 06 May 2024 02:13:05 -0400
X-MC-Unique: 9NrTt8yaOn6O2N4EOqzfTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88BE58943A0;
 Mon,  6 May 2024 06:13:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62BC7EC680;
 Mon,  6 May 2024 06:13:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E2D921E6806; Mon,  6 May 2024 08:13:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Update Aleksandar Rikalo email
In-Reply-To: <20240209062147.62453-1-aleksandar.rikalo@syrmia.com> (Aleksandar
 Rikalo's message of "Fri, 9 Feb 2024 07:21:47 +0100")
References: <20240209062147.62453-1-aleksandar.rikalo@syrmia.com>
Date: Mon, 06 May 2024 08:13:04 +0200
Message-ID: <87h6fbsc27.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Looks like this fell through the cracks.

As far as I can tell, the patch did come from @syrmia.com.

Cc'ing qemu-trivial.

Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> writes:

> Syrmia LLC has been acquired recently and the syrmia.com domain will
> disappear soon, so updating my email in the MAINTAINERS file.
>
> Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> ---
>  MAINTAINERS | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f9741b898..1c2dbbc30a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -284,7 +284,7 @@ MIPS TCG CPUs
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> +R: Aleksandar Rikalo <arikalo@gmail.com>
>  S: Odd Fixes
>  F: target/mips/
>  F: disas/*mips.c
> @@ -1344,7 +1344,7 @@ F: include/hw/mips/
>=20=20
>  Jazz
>  M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> -R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> +R: Aleksandar Rikalo <arikalo@gmail.com>
>  S: Maintained
>  F: hw/mips/jazz.c
>  F: hw/display/g364fb.c
> @@ -1365,7 +1365,7 @@ F: tests/avocado/linux_ssh_mips_malta.py
>  F: tests/avocado/machine_mips_malta.py
>=20=20
>  Mipssim
> -R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> +R: Aleksandar Rikalo <arikalo@gmail.com>
>  S: Orphan
>  F: hw/mips/mipssim.c
>  F: hw/net/mipsnet.c
> @@ -1393,7 +1393,7 @@ F: tests/avocado/machine_mips_loongson3v.py
>=20=20
>  Boston
>  M: Paul Burton <paulburton@kernel.org>
> -R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> +R: Aleksandar Rikalo <arikalo@gmail.com>
>  S: Odd Fixes
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c
> @@ -3719,7 +3719,7 @@ M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Huacai Chen <chenhuacai@kernel.org>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> +R: Aleksandar Rikalo <arikalo@gmail.com>
>  S: Odd Fixes
>  F: tcg/mips/


