Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79283C624C6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ISo-0002s5-8b; Tue, 01 Sep 2026 02:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ISl-0002r8-Qr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:59:19 -0400
Received: from smtpout4.mo540.mail-out.ovh.net ([51.210.91.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ISk-0001V1-Br
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:59:19 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxYK10B9z45c3;
 Tue,  1 Sep 2026 06:59:17 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:59:17 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.159])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYxYK0K5Mz422n; Tue,  1 Sep 2026 06:59:17 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 2586412E3FDD;
 Tue,  1 Sep 2026 06:59:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001b19ffe6d-7838-478c-977f-7f4cb8aef9cf,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <599cfd64-00e8-4f09-8b9d-959fa4a65120@kaod.org>
Date: Tue, 1 Sep 2026 08:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/25] hw/arm: aspeed: guard board-local
 temperature-sensor aliases
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-6-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-6-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8630304261138590765
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFCz8ENcifGGc7lwMsh5Km2xuR+xdVhCLoxl+J2tovlCADjZE+WbMnanW7kgYgQe1Xb30hsAtuy6Zdh3JAhi6x2xIv0v1XCEdPl3zPVRXVt5hjCmOq/ZpuqEhKYNf8xVymhh8KyRxc6vTjsgFENdi6tszQlEq8FCwobqBFX8MEKZhFbq1M/+xzqMFrMBrJxefSUfZ2mAx/Mmj98zFs8rSYoGmSYa8hp4Qmxm+k7rl1SKe4/Mp3afxzMeOZDjd8oBqNZM63rfKRRkKDccYy/hmCmI66unOknYfrD9bhs8c9qkAUt7fGjDSuiUibfBtFU5ZtXhyuCJ/gU1dRq45DzfQKytD3saJbNA6p1tbRJpdsegVz4V/wqh8veQyoHhXgO6yyZrR/bGh+p5wpsb3U81TLv4vIs/2hpl2dNhwrsiINOLOtl3EtKBOtvLJGHaW5LgQ92n9MDQqXoejcQ7v0plfhSV+lr5E3Aj2zE69GJm5akSHfX1kTPqVS0lJyneFfJel1+fmeuclKJGurOAltv1fER4pX7KmvO8ud9HIGcVrd8f4Ljz0vZxn3RnHFpsYoAenNnR7KFH8JoNzUkMR+Gi6GqTfayR3TQQ4TjqMiZgO7UsH3xexzPljXdUgY1IYuVuyJyuL2uGcy8Pmc1Lu1oFx+Ikt0NoZnOazwl0XI5qisDpg
DKIM-Signature: a=rsa-sha256; bh=knVhpnRcKxIvwEjfRk0PJL7CJr3P9zVyq+eF01aF4Zk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788245957; v=1;
 b=Zqbw7iov/5g38eA+BTpyFXjgL5fwARUYmonuEewW1GyNLAzGqi10JWXl5RM1xZj4v7gBW9im
 9pn7+ZFMoOogXNuIaIMdcNAjMyL3HoHB87RdNSaZMQ2nGrHNMJSDsj1nj1SjvnRYEV99rzwtw6N
 fmVMsczovipv6Gh+VxC5T2A3mhcqD07FMrZNjCpOiaF7txdInx3dLgecFrvxlul0nU1oNSYi5el
 AvdhiX5JevPRvnSHckFG/CZGNFaczI+yzHYEuLAynYpVrDJ++SsT8MjXJQemXavgLTfx5C/LQD+
 LLKMMvPstna0VCph0u3WvxANFjNu5ELwt3rQ/pPgzki5g==
Received-SPF: pass client-ip=51.210.91.53; envelope-from=clg@kaod.org;
 helo=smtpout4.mo540.mail-out.ovh.net
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> The Catalina and Fuji machines define TYPE_TMP75 (and, on Fuji,
> TYPE_LM75) as local aliases of TYPE_TMP105 because no distinct model
> existed. A following change adds a canonical TYPE_TMP75 to
> hw/sensor/tmp105.h that would clash with these aliases.
> 
> Guard each alias with an #undef so the header definition can be
> introduced without a redefinition warning, ahead of switching the boards
> to the real models. No functional change.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/arm/aspeed_ast2600_catalina.c | 5 +++++
>   hw/arm/aspeed_ast2600_fuji.c     | 6 ++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
> index f714c9d1b32..33e75338efc 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -22,6 +22,11 @@
>   #define CATALINA_BMC_HW_STRAP2 0x00000800
>   #define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>   
> +/*
> + * Guard the alias against the TYPE_TMP75 that hw/sensor/tmp105.h now
> + * defines.
> + */
> +#undef TYPE_TMP75
>   #define TYPE_TMP75 TYPE_TMP105
>   #define TYPE_TMP421 "tmp421"
>   #define TYPE_DS1338 "ds1338"
> diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
> index 37db252e276..6dc3535f0cb 100644
> --- a/hw/arm/aspeed_ast2600_fuji.c
> +++ b/hw/arm/aspeed_ast2600_fuji.c
> @@ -15,7 +15,13 @@
>   #include "hw/sensor/tmp105.h"
>   #include "hw/nvram/eeprom_at24c.h"
>   
> +/*
> + * Guard the aliases against the TYPE_TMP75 that hw/sensor/tmp105.h now defines;
> + * TYPE_LM75 is guarded too for consistency (no LM75 model exists yet).
> + */
> +#undef TYPE_LM75
>   #define TYPE_LM75 TYPE_TMP105
> +#undef TYPE_TMP75
>   #define TYPE_TMP75 TYPE_TMP105
>   #define TYPE_TMP422 "tmp422"
>   
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


