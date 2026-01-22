Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDE9D6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2MG-0004xh-0d; Thu, 22 Jan 2026 16:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vj2M8-0004tI-OM; Thu, 22 Jan 2026 16:36:44 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vj2M5-00049C-2R; Thu, 22 Jan 2026 16:36:42 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.207])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dxvX517BRz5wNH;
 Thu, 22 Jan 2026 21:36:37 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 22 Jan
 2026 22:36:36 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007876700f2-0bd2-4971-a47e-71d529f1cf2f,
 9C2E3E0988B38FCDD726FE3DC76C694F3DF0A25D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2b87b036-6026-4247-999a-52b7886b533a@kaod.org>
Date: Thu, 22 Jan 2026 22:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/aspeed: catalina: use pca9535
To: Patrick Williams <patrick@stwcx.xyz>, <qemu-devel@nongnu.org>
CC: Glenn Miles <milesg@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
References: <20260121-pca9535-v1-0-164640e622ff@stwcx.xyz>
 <20260121-pca9535-v1-2-164640e622ff@stwcx.xyz>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260121-pca9535-v1-2-164640e622ff@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: bccd65b3-32ff-45f0-b65e-0b6f9fd90ce0
X-Ovh-Tracer-Id: 10981183266453031925
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEG7xqfyqL1yqVRAzhZ4M9/BCnxpcihWQyH2q3bqGFFKXG5yw8ZosfWCV2hGAop9zAKQFeuZR31OcN7PTw9xwhVl2SoDnlGh5CpdrzoGPY3q7bfO5akZSwkWdC2bgG2Skvu0CSlJxkN9sWQwi+7TGL5Gy1IEnaVejdyu2lobk9BffJ92x0v/5uJdOPSj2oieuBgt1BVw4Xwj/ZvUCwcBOBNiiGs2vTx2+5NQ3oEBTKeaxWueJrmsBZKelud+J+gX9TbWF828oEhW9A4uQMoYdycgYdYk3J4GH/V+n+bY3K646UgZp26ccoq1w22jvzgYu42jn/CtjAyUETYBWOp7kNmsmSClm0caOIlVBjSzvrF/hnoGliQAWw3Mcw/DrGIEtBuPO4Ag/F+vsKHASVX/I2aKJuXS+WcXlY5aGmBlQbPXCvpEmhMMnZXs7M9l/avlwHOqcxkeK5BOzWjY92KyUlUxRUYDgoGyWQYiyqbCPXDMYMAayddZf8PFPQ1rRRcywli/DLnzd/xYvjoy5UVrmJjcPcLF7LuxmMSJS+PdCgfSFtBUQ7WavB+aalbxNu8FqNt7SSwC7T5U7iK1wzULjY5SHGwoPehqV0Gd7a8kqGW+uYCn3C9101YjJI5auF/7wAeQBPW1iOrzPfKQLxCJdFYkO4JMdoy7oE/dbPDd4KT9w
DKIM-Signature: a=rsa-sha256; bh=xF/b0qw6N/t3pEG3JfiR5tPCbpZ8a82D5QOc2Mw3JZo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1769117798; v=1;
 b=hGr6PXD+xUi5do+xILB7YDgFqT14UBmnmxXGZHMpFIPtCxEGmy1XM7i5u+LvG/px1CB6AjgV
 hJH6xGtfIwtx6F++gSDIAWzfep8uQNr9XKo0LWQq9QX4YI8lL5wiUrlwcTHOIANy37/1Zo4Hp9d
 JJBdNXcgyAwNI1z6vmFDvvYOSS/wuFOqhei7ZE5SuhQBirq8IfWWVoZCXaWlqtHHhAEWBO29K2I
 s/w389oW6XEPPrDWy8WgCLTNvkn+5kI6/cHuGTqZlZJ8cUAH4eQZoKIS8acrFu0mxYk3S6tBjNl
 Z8CB2hgN5xsHVaePVQJhGm3BpZXe18/H5ZtbkZUGTOl3w==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/21/26 19:17, Patrick Williams wrote:
> A few entries in the catalina model were using the PCA9552 chip
> because it was "close enough" in function.  Since there is a PCA9535
> model now, switch to use it.
> 
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> ---
>   hw/arm/aspeed_ast2600_catalina.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
> index 4edb30bb16..65495a524e 100644
> --- a/hw/arm/aspeed_ast2600_catalina.c
> +++ b/hw/arm/aspeed_ast2600_catalina.c
> @@ -480,7 +480,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>       /* i2c0mux1ch1 */
>       /* io_expander7 - pca9535@20 */
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> -                            TYPE_PCA9552, 0x20);
> +                            TYPE_PCA9535, 0x20);
>       /* eeprom@50 */
>       at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
>                             gb200io_eeprom, gb200io_eeprom_len);
> @@ -497,7 +497,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
>       /* i2c0mux4ch1 */
>       /* io_expander8 - pca9535@21 */
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
> -                            TYPE_PCA9552, 0x21);
> +                            TYPE_PCA9535, 0x21);
>       /* eeprom@50 */
>       at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
>                             gb200io_eeprom, gb200io_eeprom_len);
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

