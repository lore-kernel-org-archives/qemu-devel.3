Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68734C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgKGx-0006kX-Qk; Sun, 05 Jul 2026 06:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wgKGk-0006jR-Ha; Sun, 05 Jul 2026 06:40:15 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wgKGg-00052J-QU; Sun, 05 Jul 2026 06:40:12 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gtPBh5zD6z49M5;
 Sun,  5 Jul 2026 10:39:56 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun,  5 Jul 2026 10:39:56 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.65])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gtPBh1VSKz1xpZ; Sun,  5 Jul 2026 10:39:56 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id D5E8D941946; 
 Sun,  5 Jul 2026 10:39:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001b1ab06ec-3fa7-405e-89b0-4473ed303fee,
 B15A73F14A4878BAD8FE4672BF1B2C4F0909EBE0) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <10a7bcd9-a90e-46f5-9e5f-a05043be3c8c@kaod.org>
Date: Sun, 5 Jul 2026 12:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Split miscellaneous changes from AST2700 FC series
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 3781897788455627787
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF1Xu+q4/Zw7Hk/kik4ECQ+EJbHlXk4eDcw7uaKQnVeQQN4D5Fh0PelXiEGWSnGeVu/LEE53lsg7tvEbea2bwuyUboIwqu62miTzqG9qfts4vk+gqwQoAZXkTUWlOBPiOby9JHBby0Wd7ytKiknRuiCJgdxabcCvk+1SSGAOoHLQYgKrvptRbEiX8EkaKS+UjQKYMVjf8nOkSypa0ARmwy0uzfD8Pvg9TNsIQGNnFeaoRCG2XrxrgedPU9X3t4uV8rDYDXbCK7ukgDu85fimWn13dgIZeQ+ktwmerIIjQ6n72g4Bqn3oud/0sPlRtzUaxptPmf96DXzW7/zqmKaJ6E+NMlds7y9Hw0cO6qXvuDh6FIMgHjgrz4daBEAgJDmFncNl1hUR+wDgFWLKYiILar3UzA4iE5vUDteGZkEbjj6uZPsM2PuEyQbKSrNb48QS4KR0ue3pn1Zhd2BVCJRaYU80XLkY5lB8KsWncBLdVMD9Brho//VL1/vs//smJoLN9u0TOFlnG85w4pLqK95OPANGEBAdT2MZdphnhhf/VDGnMrAiCXheOGNjPQfAfP0/Zj65nBTzIXy4RxRJdrG2I06jVTq44TcxHOKOtPFqNdKw9Bwt/ZSdM7ssoPgwfT6AK8kbpZRCRzTfH0peFzbLCw9WlTsxNFim2/WSrpXPyoqNQ
DKIM-Signature: a=rsa-sha256; bh=oifjHEtWdLt0qsaN18n07t3kPrI7DeQ2LnOTLRvHqtI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783247998; v=1;
 b=UNKYiuPdn7gMxpw+2wK4wwPvh+oIM95KWNGevtEOJFSRC/DgO2foneyHFxZYKfEkDtE/ADSB
 k929iaaHGAONdl56s8Nmwml6RSatWbfOhTemIXYM33Jg2+HPQalVCxZCYC2IXqGTsUujHQRkaic
 8O0ojcLoFQ8+SpEsG+SOQveivkhjtqK5Kma4gjimWZOWEr+rrA9mNixxZQSDCW4YFHpS1t0dwmn
 q38LGgYL14ft+msVSDZEZ+noxGD7+Db3s9FXUC3Lwj7JTHvnAH5jcKGtYZOi/t1RmqeXjgcjcLI
 HR73xIW2f+XXeC/sYez1bxgRHQYrX+Mxrf7/p/4XbnEfA==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/3/26 08:45, Jamin Lin wrote:
> The original series contains both the AST2700 FC support and several unrelated
> cleanups and preparatory changes. Since these changes are independent of the
> FC functionality, they are moved into a separate series so they can be reviewed
> and merged independently.
> 
> This series includes:
> 
> Fix the AST2700 FC hardware strap configuration.
> Suppress noisy unhandled register read messages for the AST2700 SCU/SCUIO.
> Add the AST2700 SCUIO RNG control and data registers.
> Add unimplemented Privilege Controller MMIO regions for the SSP/TSP.
> Add unimplemented OTP controller MMIO regions for the SSP/TSP.
> 
> The original AST2700 FC series can be found here:
> 
> https://patchwork.kernel.org/project/qemu-devel/cover/20260417032837.2664122-1-jamin_lin@aspeedtech.com/
> 
> Jamin Lin (5):
>    hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings
>    hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST2700
>      SCU/SCUIO
>    hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data registers
>    hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO
>      regions for SSP/TSP
>    hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions
>      for SSP/TSP
> 
>   include/hw/arm/aspeed_coprocessor.h |  2 ++
>   include/hw/arm/aspeed_soc.h         |  3 +++
>   hw/arm/aspeed_ast27x0-fc.c          |  6 ++++--
>   hw/arm/aspeed_ast27x0-ssp.c         | 19 +++++++++++++++++
>   hw/arm/aspeed_ast27x0-tsp.c         | 19 +++++++++++++++++
>   hw/misc/aspeed_scu.c                | 33 +++++++++++++++++++----------
>   6 files changed, 69 insertions(+), 13 deletions(-)
> 

I thought I had reviewed all these already. Anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


