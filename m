Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC9CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdt6-0005Bs-Ml; Thu, 11 Jun 2026 07:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1wXdt5-0005BY-7D; Thu, 11 Jun 2026 07:47:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1wXdt3-0005WS-EX; Thu, 11 Jun 2026 07:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1781178462; x=1781783262; i=laurent@vivier.eu;
 bh=a3rgsEVTjnkM8bvPXdn9XVig3H6AHH7jbbeCXkkT4e0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=treaTyfcn/LSCZmE8CpewkG8YewVzp3Ud7znl7n5swNu0QUORLiis/M4dUJkvalm
 9YGlS2X0p2qzGFzRPj7x5Z8XrfvCNDaGPVQ2RfUyZBGusLYFa4XVO1x0CoH/fB1Uy
 wg8t/foCFT2Ynukkc4Yk3Zp62zNp6GPlaranrXiK8Qy0Sv94mpaXCvdkF6JsMe8+2
 CCPGkmFiEVBrNsi2h6a4ujW7vu2iXFHS3EYrkrc5hG2KY+jJDxGnk5cvBVt0i5g9z
 vNMg2PVVdOluo4iEPcs40GRrMJ3B+hGCU99a5hgJ7fjwgc5v1gPlo9V07mnt9pmsf
 tyJIgkSF4acLaD/jtA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1MlO9r-1wx3gJ1e8b-00ntbV; Thu, 11
 Jun 2026 13:47:42 +0200
Message-ID: <cdbeba99-980a-41b0-bb7d-a264b76c5716@vivier.eu>
Date: Thu, 11 Jun 2026 13:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options: fix typo in spelling of 'scheduler'
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260611113547.651075-1-f.ebner@proxmox.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260611113547.651075-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+U/eRgvWK65ZuaoqMA8CjHdRGNgLjuaaPqGNs3LG/yTNY2Tzu6D
 W3H/HD/v2iayKGCz9KjSfruBjUc31Ajy3rnZesgJFpXqf2TYOceu2DmMQi+JcoClx6A63Y3
 aFICdysja2YEOCeaVHU1SH10oZcCD7Db8kaTPHtUStblq+hVB+Sr8oe1l9oVWLM4YtIaQQd
 q4FFzkdgJSZKh1zll8Biw==
UI-OutboundReport: notjunk:1;M01:P0:/KXAwXhHRkQ=;/kqjc/z37/IMB1l04ycYK77HEmT
 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
Received-SPF: pass client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 11/06/2026 =C3=A0 13:34, Fiona Ebner a =C3=A9crit=C2=A0:
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   qemu-options.hx | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 96ae41f787..2fd21519b2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5517,7 +5517,7 @@ DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
>       "                    main QEMU process but will allow forks and ex=
ecves to run unprivileged\n" \
>       "                use 'spawn' to avoid QEMU to spawn new threads or=
 processes by\n" \
>       "                     blocking *fork and execve\n" \
> -    "                use 'resourcecontrol' to disable process affinity =
and schedular priority\n",
> +    "                use 'resourcecontrol' to disable process affinity =
and scheduler priority\n",
>       QEMU_ARCH_ALL)
>   SRST
>   ``-sandbox arg[,obsolete=3Dstring][,elevateprivileges=3Dstring][,spawn=
=3Dstring][,resourcecontrol=3Dstring]``
> @@ -5534,7 +5534,7 @@ SRST
>           Disable \*fork and execve
>  =20
>       ``resourcecontrol=3Dstring``
> -        Disable process affinity and schedular priority
> +        Disable process affinity and scheduler priority
>   ERST
>  =20
>   DEF("readconfig", HAS_ARG, QEMU_OPTION_readconfig,

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


