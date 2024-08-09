Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F36DC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLEi-0005Eo-Kb; Fri, 09 Aug 2024 04:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLEe-0004zg-JJ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:44:32 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLEc-0002Z3-Sy
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:44:32 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f189a2a841so17310081fa.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723193069; x=1723797869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HiC/1EA/ClSWubVj9AV07PKC8IDM8nXHlFdnvitTf1g=;
 b=NJLmhI8hyCM8NMGEWFPwWT0XEaN9gt2E1e40lFS8fgDvxHrRmL/qk/CP9dFyCqWTo+
 MiVVM3gMA1NzOSDIhY9gOfTH0J/XtaduecMuCKpUunhaN1RSZ4IrGHVg8d1PgVKssCzk
 bpAuxv0Xc0kQ496taEiQa0k/pED5b7586PTOGfwxUjtW9P1A866KkDwGx6HE2VsVx+aH
 LNyS/XLdbnTbzpXhakamsjNjPIatWIHlQ8s8bizFDc36YtrLgTIXAdAewToEwmnoI7V6
 Nc55C9aU1vfM5zmYOpXoldDQFMItAQQUFLCKzL0ePaHA2YCJB02A4eN4HpvhvaLYwU5t
 k/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723193069; x=1723797869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HiC/1EA/ClSWubVj9AV07PKC8IDM8nXHlFdnvitTf1g=;
 b=sscvr8ZlKZqGJzcLd4I3rEtUfCfcs8dqxY1uw7e5mW8m/qecPBigHukopaDll09HWX
 ZP0VB9MU1ngh6mkxClPAKS138Y5JVZ+jaQi+UtGAKMh5b+fN9rpSvPYGja8b+z9IN1y3
 CVSDf4PkLp3X9ECIq0xxkltreJPSUbkwPf9V9JnTelF8hCJ3osh2PAe9oZJFn4/qx+mK
 rVifkQmFiJRI9Jq4z8HVVnmfiOsAankgOYNqTBfHiNnsqAeGkS3IOrQV5yvNlnNZ31cI
 LofwN2fV18niu2tvhRSnEytYkdd3IEry8sLswlZjyW9aFPXUu6uazyRnNP4jTD/GsfS/
 hfrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpsr0D32vk4O3GTa/C9jyGYN24oHxrA8IPJBEK0Qmd0f01VGDaWuVHViysctvzJYXzQQPZeD7JJ6MHiTzDVhB8wSm+vio=
X-Gm-Message-State: AOJu0YxBXbTp/IUnXnTAbfFr0FRmQcR3CFd+DPm0z/g6mjhQxIwlwxX0
 VipyOnSNqjvCNu997pIyG5uyNJWN9Y/8z1uUS4idwS/qu9Pv5MpMwnzMyoV+VYo=
X-Google-Smtp-Source: AGHT+IFa8prN4ruLf/wggElzHk81wbvMYlk31ZnQ4JSB9Y7Roocvm4MvxtEqRmrfO1xVebM8Ficv+A==
X-Received: by 2002:a2e:958f:0:b0:2ef:2b53:c785 with SMTP id
 38308e7fff4ca-2f1a6d0463cmr5882201fa.41.1723193068417; 
 Fri, 09 Aug 2024 01:44:28 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429058bec60sm112072115e9.0.2024.08.09.01.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 01:44:27 -0700 (PDT)
Message-ID: <ec33abcb-409f-4609-9007-3337f3f647ab@linaro.org>
Date: Fri, 9 Aug 2024 10:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] qapi/char: Supply missing member documentation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 jiri@resnulli.us, jsnow@redhat.com
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-2-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240808182636.3657537-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Markus,

On 8/8/24 20:26, Markus Armbruster wrote:
> Since we neglect to document several members of ChardevBackendKind,
> their description in the QEMU QMP Reference manual is "Not
> documented".  Fix that, and improve the existing member documentation.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/char.json   | 44 ++++++++++++++++++++++++++++----------------
>   qapi/pragma.json |  1 -
>   2 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/qapi/char.json b/qapi/char.json
> index ef58445cee..8a4a87c95c 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -434,37 +434,49 @@
>   ##
>   # @ChardevBackendKind:
>   #
> -# @pipe: Since 1.5
> +# @file: regular files
>   #
> -# @udp: Since 1.5
> +# @serial: serial host device
>   #
> -# @mux: Since 1.5
> +# @parallel: parallel host device
>   #
> -# @msmouse: Since 1.5
> +# @pipe: pipes (since 1.5)
>   #
> -# @wctablet: Since 2.9
> +# @socket: stream socket
>   #
> -# @braille: Since 1.5
> +# @udp: datagram socket (since 1.5)
>   #
> -# @testdev: Since 2.2
> +# @pty: pseudo-terminal
>   #
> -# @stdio: Since 1.5
> +# @null: provides no input, throws away output
>   #
> -# @console: Since 1.5
> +# @mux: (since 1.5)
>   #
> -# @spicevmc: Since 1.5
> +# @msmouse: emulated Microsoft serial mouse (since 1.5)
>   #
> -# @spiceport: Since 1.5
> +# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
>   #
> -# @qemu-vdagent: Since 6.1
> +# @braille: Baum Braille device (since 1.5)
>   #
> -# @dbus: Since 7.0
> +# @testdev: device for test-suite control (since 2.2)
>   #
> -# @vc: v1.5
> +# @stdio: standard I/O (since 1.5)
>   #
> -# @ringbuf: Since 1.6
> +# @console: Windows console (since 1.5)
>   #
> -# @memory: Since 1.5
> +# @spicevmc: spice vm channel (since 1.5)
> +#
> +# @spiceport: Spice port channel (since 1.5)
> +#
> +# @qemu-vdagent: Spice vdagent (since 6.1)
> +#
> +# @dbus: D-Bus channel (since 7.0)
> +#
> +# @vc: virtual console (since v1.5)
> +#
> +# @ringbuf: memory ring buffer (since 1.6)
> +#
> +# @memory: synonym for @ringbuf (since 1.5)

What is the rule to sort the members?

