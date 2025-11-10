Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1991BCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPGV-0005dG-5A; Mon, 10 Nov 2025 05:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIP2h-0006rp-1t
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:22:41 -0500
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIP2f-0000ap-1y
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:22:34 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.72])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d4m1x1Ck9z5vws;
 Mon, 10 Nov 2025 10:22:29 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 10 Nov
 2025 11:22:28 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002a1ead866-742d-4004-a1a6-9ebfc5e173fd,
 2CC8F654BF9A736B588295E2BFA8A60E013487DB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b96ef4b0-a3ee-4723-b75b-cc7e36b703d6@kaod.org>
Date: Mon, 10 Nov 2025 11:22:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
To: Nabih Estefan <nabihestefan@google.com>, <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <steven_lee@aspeedtech.com>,
 <leetroy@gmail.com>, <jamin_lin@aspeedtech.com>, <qemu-arm@nongnu.org>
References: <20251104233742.2147367-1-nabihestefan@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251104233742.2147367-1-nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 58a9720f-ea1b-4ee1-98dd-b3bfd81ac307
X-Ovh-Tracer-Id: 13611285448819116905
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGy2KD/fMkSjODZ7HR0RP4RoLQjk4VmI6IkrQ4WTsfV4mEJP6iq4Br4N7AMAkYPNzuRoLgzW88hQG5tteOK1pXGCB7DcDYAEf7wcPlAKkXXDKIbTvFh/xkeMTfQzaxMs1yCPMJvI7BWIRPcVA8zYW5lD7grp4OsjOSdTJE+AfCBH1vqclYTkyjD9tTc7g8IYV+gXZT98b3tjxSLJStSX8/zM4ef71LyYjXmsrMV54mBnROyb1ELVW+P6b/re9VYaUGTAUbbRm8J5ndOm2mouDcxibSve6E73NVrIqLOBYs1TRXIAGkvQsOoXJ4h9Gaq6HKlwLUrVmLbya3hP9dt106Xsd0liuG/ONMhX5whQQE3mgF3Fip9fU0BzurUUfiGG5gLvD2f8U5iXjk6upIfTTJ7HyNTtGfojKkW4JqjBlqRPbAT96E4YZMKRwQVGe9e6/1zW+vKAnLVl8J5gGikmdKWIvLZQs1k0Y9f0lb1aGUTqgAsTlfD3A0HuG6pNxDtpdWl+W4ZNG6KgvLT5IBQRPZzCjRvkB0Wm0ekvEXMIUW48lu8Ba1Wer/d/iQ/PbuGbnOYhqq6WVw0jIh8+FHFnx4M6SQ42nosdV1hKHLnLS4tEtjyPwThzFOQafsP+Uj1ZImkP4W+1BOqISCa7x6r02orQRah25jprfRt9Qc78n2a9g
DKIM-Signature: a=rsa-sha256; bh=2FLPZ9sjRY2a8AlU1SEiRTeNxyEIo3sFmROj34JW7xU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762770150; v=1;
 b=hWIhZERw/j9J7lfLG40WniW6ddREckEaC4DO51QR+FT9AzFoSHRVuVcrWuoCqBdJRru1eCw4
 Ye6fXNA3Sdq6c+re/0si8FDcOLRazsQVb7k8ySka5NVUDC1MkU1qbP41zyVVEP0Qii1iKcC5wop
 FyF2cFWFLP6T9Jea6maEdbP4Oy00ymbkmy5Bl5em7TtmMauWPYrz3dfo9RYLFI6sQqbcOyX6JO8
 tgDJ1dSEvj2Pgjok8l4/KcBFFtILYGjD0spvcRwV/Am9cepr2V+N95taUS5QjvsYERa7Am3mu6v
 JyLSBgV6Vl9qsuiFTNHdVAH29PDttVMwPOYxg43xPRVyA==
Received-SPF: pass client-ip=188.165.49.213; envelope-from=clg@kaod.org;
 helo=5.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 11/5/25 00:37, Nabih Estefan wrote:
> The address for LTPI has one more 0 that it should, bug introduced in
> commit 91064bea6b2d747a981cb3bd2904e56f443e6c67.
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 91064bea6b2d ("aspeed: ast27x0: Map unimplemented devices in SoC memory")
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index c484bcd4e2..1e6f469538 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -87,11 +87,11 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_UART11]    =  0x14C33A00,
>       [ASPEED_DEV_UART12]    =  0x14C33B00,
>       [ASPEED_DEV_WDT]       =  0x14C37000,
> +    [ASPEED_DEV_LTPI]      =  0x30000000,
>       [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
>       [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
>       [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
>       [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
> -    [ASPEED_DEV_LTPI]      =  0x300000000,
>       [ASPEED_DEV_SDRAM]     =  0x400000000,
>   };
>   


