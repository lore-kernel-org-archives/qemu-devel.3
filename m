Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15646C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsjM-00069t-9S; Tue, 13 Feb 2024 08:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rZsjK-000692-Hx
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:21:46 -0500
Received: from smtpout149.security-mail.net ([85.31.212.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rZsjA-0001C7-1C
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:21:46 -0500
Received: from localhost (fx409.security-mail.net [127.0.0.1])
 by fx409.security-mail.net (Postfix) with ESMTP id 7CA75349B87
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 14:21:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1707830494;
 bh=XANcQpFYnwO9vzQkqHmw+mMhEh5OW+eOwUQfg3m4KkE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lpdj5y1tVX++a+RIsj58MzvXpeyvgIA2ACBXuFTK+Rh1syRf7E+wZYslGZqqCpNZj
 BqxdCwFKQmsfEMegY2EP7f/73WV/ndrB2p0HbZglRSkEJrbZE1shLrcV6jBuGcfFqw
 uHdBto/4gRNx8+nnRp4Xf1R3gt/s1pWa+MjPTxWw=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 2C001349BF3; Tue, 13 Feb
 2024 14:21:34 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 5DD74349B6C; Tue, 13 Feb
 2024 14:21:33 +0100 (CET)
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:8::13)
 by PR1P264MB3661.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 13:21:30 +0000
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c]) by PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c%6]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 13:21:30 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <172bd.65cb6cdd.5cbc9.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TewjfXNvZjrCWLYkPKRXIuF3PNdXism2wU2J2oY8Jb3l90xTUTIcOyIp6f6+fBWdTcVSLXAQMRL4hYkTGVuK/XTCaQod2t8pmt8qrJYvyQuf8PsudBY2wNHt/G6W+iI5WgLRohQH7UD1H60UJLMuF/WoMSWaIHl0rgCYI4gB76JByH0ScEUz0vfWLnuUTbNweW98wGQkpAcYE60LJ22UlOn2dRL0ZP7jenJtM/+loqy0pwfMS8za/AG+SZxldEc+yHhtGDOlxMf7ir750pNcUVDnsJjyPObodVXDnT8C9dvinPkavMb/wv/oE7CGPRc+U06AWK7SDOQ/2kny94yLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLhAaGM2COzS79PRev8IThP0pHOcQgeJQON3etaMRvw=;
 b=TXo+3+OjGfcPVoTW4chDOSFALA/ngorJCC4TF7a3hsue8XbnRjrfHFaJINVvoRXTa92VWx+pwCw6e7uCFk5tBSZs1AoG5bToAmaH2c4phDa3dTI2kDAzaoJ/omaxxqKhKdgwpzWVJRlf9W9pz9e8tJp4hSZaW8rQbhvYp1sdsUfvVyqjJNLpRUPLJ9KExIMZIZdJD/SQJx4/d8OnNvqLx1NkFGoMN0R1Xy0mTKc4eV7lDEbsJwraE8gw6h88kpY2GDVMY0EYF9hJ81fAG0dlEf5cIlHSrr2PZLTriTmvWThP6Dy30blldu5cvs1udjsIsmmnjSO96h+ctlhVlOBLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLhAaGM2COzS79PRev8IThP0pHOcQgeJQON3etaMRvw=;
 b=nrpjE/RMLg2cPgGk277lJ4ICxPlb+7yhL/86CJVFcYH8xEyps9Gkih/FYp1ZDA3jlVp1sIyFqgvQ1WNi6+nJhxo3P7OdP/XnY0HUqMuyAYep8e6DjXxaTK7fOt3pL1kqZXnuDMjeWtAhz//XU79MDG7XRQwJJb3pFWLywPYfgcNMRig4RDOcQB668KmyxywtfxhxB5cUkAq09fXWhYR6HvvUbXonTYUd9B9B/SVj/jyW0O7ZsD2+EYPJz5Pl9inqBt6aLGTo892SO9y3ZbdRhqM5eDGLb/4hzniFym+k3gO61bynj2TZFJJdBr+rOT1RYPDDvzn51iZT7WFvkhDZmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <a2e88ec2-e731-a915-d7c2-d3391a06c875@kalrayinc.com>
Date: Tue, 13 Feb 2024 14:21:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 12/12] hw/sparc64/cpu: Initialize GPIO before
 realizing CPU devices
Content-Language: en-us
To: Philippe =?utf-8?b?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow
 <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Richard Henderson
 <richard.henderson@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Artyom
 Tarasenko <atar4qemu@gmail.com>
References: <20240213130341.1793-1-philmd@linaro.org>
 <20240213130341.1793-13-philmd@linaro.org>
From: Damien Hedde <dhedde@kalrayinc.com>
In-Reply-To: <20240213130341.1793-13-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0172.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::9) To PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR2P264MB0861:EE_|PR1P264MB3661:EE_
X-MS-Office365-Filtering-Correlation-Id: 016e4c27-75c6-42d1-76ac-08dc2c96b0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3H0oFP0SbFsJ+7YYtS9qJ84TCL8p43Nq8nkMsvsXlLfwVZj8ChLFUG9xN/vXRa3ThX/JePXP5tHgMUreKI3AD1R3XQq/Sc6GKYMiRw5A7apZCfLZAQw18mOdEzEXGHG0y6rT03B3xDoo1bEoPulXAG5T4QJnxlyYU5ExXt07rpm/Ms6YaAoMue+7NCnD55TR9ib0EfVODCCwPNTiwyHjQR7rm3q61BlGpCpTCc9Qg3I20DW08lp/PCJbmyATIVNHc+nbzcd3jvutcQBuTcjTJGxj+VU6dG+bYkPFY+CAZtduWyF5ugGmHNkbmdsgfbe7J0CiQASO6Jyem05QqYrJ6A7CvsLgbjfor6Q5FAYMkBLOzrQoMcynC2EmFIN5hBH/cCyYVPLr0/bG84VtA8HspfPk8e4CnDasBHWIABwwt15yH2b10wDPKhpcjQJsDPdktGh754TZ7obSAGIhXBWt1OzxYp71dT4Zqzct7VE4d9ptezP2JcR0UIlyaBFJmiojtJ5WopL40IO6Yin01a0k2vGbfUGb+xBDVFaw5qrB3R+wnUrGV4TmRMaD07zXblG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(39850400004)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(6512007)(6486002)(478600001)(41300700001)(8676002)(4326008)(8936002)(7416002)(5660300002)(2906002)(6506007)(53546011)(54906003)(66476007)(316002)(66556008)(66946007)(2616005)(83380400001)(31696002)(86362001)(26005)(36756003)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IQiPGltqNpR+cs2TXhjXfylC0OIgpmuqKM04C3hEUHfI55teOugF+X91v4gqNcNNh+ihvAfVJAp7tp9urU/0ghEadTAnAopBfNOPlBqbYDpKWq3kC5b/caZGjj4KR1zXiaf2Z32d4IC7C/V004EoXikisV5b6l6LDdcoy9fWR87VLsHRa6Eeq/NKAoTQICDJ68guxr6ztp5BFiVfmlW2JZTHUaCmDMJhy/Rb5qvnW7r2Vk90scL1yD90zwyA9g4znPzSyzk9X9/ZShVVk2DtkSIOfg5xEZC0hheDdxLsAQMFSl4e45TUp/5FM4eiNHRxBum9y8GJgg9NHKHFRtRqpiklYh1bbc33Og5+zRJZ+Ffq2gKdZ8KVTshkUQvgi+PD/Gn0rPuyxmhVNVmQNXeeDoqV6bqLe+49gfy2HdIU9KGzZoC/BudfPZCatmZZR/xHMjcSML5gAavfxyRF10CnXKOjbl3TA6tJ7Gt+LBPdNhvSksLQ0t5rsn9KAOrGDfCGn57sEIUUC38m+Nf1F7nSiaHX10opFTXvxXJZtrUwqST3C6eCh3uzo6Dusa0iSwOr5x0Gb+0vHE03/allFZhIpQOCE8gJKL4/Nau43ipE1ngCtwQ1Y8eHQ/vgraEAkS1VCAYWxh9p6EMbtiLwJgb9QqdXnoYcSP3ROT+xu4lf1va0oTqL3Z8oP4a9/YmP6aL0uESQ9rwj1nyVW9ToMiJLF78gqyReyEuQ2aohjXQYbPRF7/t+tM6CbF6zgX2ZN5KNP8M1MmdLW693bhR+F4YhEvVZpxXiBG94g0tfjfd9QGbwzXmCtnlmpSFU5PEhE3GUjbuo7rkeLcFMtK+uxT28LGbtfnF8BGI+r8F/NzTpGRDVgE0j7hbd8A6APFMoBs88/s6HSXFXHSw7jXVvk/AynXWX6uQGW1RPGz8UrmCzEHMYMZtwjG5r4QzjWkDgtakQ
 C3unZ2W1jzGUknYNieOhEX2m01/vrRC6XPDjcG7zqUbRDcHy9GigxpAwnaoHLTNL6mOYif0EHm3Zswykvm60fW2cp04+JL8UkBG42fo+nXuPQqx5aHn3xdUKogrPmJoJJ1467fsJOGkELrNs629bORcVoePoBH6B9XFWkkJeNr8tXuSIFz3ZmyTgw+0EXlQ37NfM9oa1HSXsuLZNnqmICAxdO/qYLQrOgKDwnYOfDHeogPpvRquRYmXwp8E27qqNSmN8lGcuERJdthxlSnHaXJL/alqKt8bokxGFL3GplGVDBhwGxhSwmPYs/EeO3O6boLMo+kZD6otVwfdCBW2LmhQNJM4TTzLJkpsaj/29Rv2o56pJbGgQH8nVC+X3w5FrBkR1ny9NW/lpXh+2WTpqaNtvenuO3AbzpbkMit7ZhE1C2p8HbNkAevNh5g84eXXIydR604zzmkwcOoAO5dcrxcUbgvb1fkPfp7GwSdJF17J/0fKZmdCr/PTY306XQ7KpjtyqWYqN0tu7554UGzpXCIQVgBpLV0GAVadYFR9HtetiapKduC8UIIE6UKz40cnAYV0dbOx1ebVdbSanywQsSNjEGM4EuQ8jVyC4hrEcczQFEHnyBMex+UFM+19JXrpD
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016e4c27-75c6-42d1-76ac-08dc2c96b0e1
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:21:30.5177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb+QbziUjoEkylEiVftQ39+KLpIW00TxCCrRhBGFEhkdRUgeEqYq7TKEwlCjVDjv+2o7yfzYOjgZvr3woev7CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3661
X-ALTERMIMEV2_out: done
Received-SPF: pass client-ip=85.31.212.149; envelope-from=dhedde@kalrayinc.com;
 helo=smtpout149.security-mail.net
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.447,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 2/13/24 14:03, Philippe Mathieu-Daudé wrote:
> Inline cpu_create() in order to call
> qdev_init_gpio_in_named_with_opaque()
> before the CPU is realized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/sparc64/sparc64.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 72f0849f50..3091cde586 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -24,6 +24,7 @@
>   
>   
>   #include "qemu/osdep.h"
> +#include "qapi/error.h"
>   #include "cpu.h"
>   #include "hw/boards.h"
>   #include "hw/sparc/sparc64.h"
> @@ -271,9 +272,10 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
>       uint32_t  stick_frequency = 100 * 1000000;
>       uint32_t hstick_frequency = 100 * 1000000;
>   
> -    cpu = SPARC_CPU(cpu_create(cpu_type));
> +    cpu = SPARC_CPU(object_new(cpu_type));
>       qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
>                               "ivec-irq", IVEC_MAX);
> +    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>       env = &cpu->env;
>   
>       env->tick = cpu_timer_create("tick", cpu, tick_irq,

Reviewed-by: Damien Hedde <dhedde@kalrayinc.com>





