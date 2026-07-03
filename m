Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D50C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa97-0003a4-GR; Fri, 03 Jul 2026 05:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfa95-0003ZJ-LA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:25:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfa94-0006Kw-35
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:25:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635ri1T3134737
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 09:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BtuvWETEIafHlI89h+kC44LxZS64vXDOPHiPsInwsVU=; b=hlMU8sZQ03+l+s+w
 HxuYuzRXe7CcKarFxAlw4X8qvFzGHpDEE56Y2qR2YfOM3FzFNSLHNb6xTWQfBzyV
 vrX0+YmtKI+0yPBJPJWdXhCR8r1HVSGRGwsIAIUM1/H0mAUAw3Rnl4FjhVKcgQ1S
 zu5dS5NImS1RvtfUd5ZHuQBl/BZpV9CbVsKC25Fqzq8aAdCCvcjS/7NbRiI/eMbX
 uwpG46t+y5kBctN9jKXUTj9EVbDV5ixgri2HHGDbov5gXs73i+kPRKsqI8xSHa0l
 hrT3UQ+pQX4At9dEsFxkXON9nj1hTpOO7715X3LGK0JLl03kIUGoLvQxJperfm9h
 XJaCLg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qchcgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:25:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so39103485a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783070712; x=1783675512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BtuvWETEIafHlI89h+kC44LxZS64vXDOPHiPsInwsVU=;
 b=KmcLja7bkFlWH7sqR7yyG8SfNu0MyRPheGBeCDnOyMhlgPVIAIpsGgh+nghBiPVWY/
 RWWA+HkLZvZCoL8bmswO74YTCldmTP3ILsFUrEcLLmgchR7YJA8vUE2ceP0VzmaUMHCE
 j+vX1EqBpTB7rEedxVCzc9Rj3WEKulBdHIkxmopjU/gweUaH7aOEht7zjA8yt8tlHEhQ
 FNGc+/UX6sON7kq7gFP0yuOato56ZopcsshRSAqIb7SuEFVmEH9lI+c0FHaPBw+38HiA
 FWx1xKpPXx4MZOHolOvXmu+6WhVVI6FDCQJy4ZWB0pmHJ10cJaQShHeXXYZLOv4cmXb1
 8JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070712; x=1783675512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BtuvWETEIafHlI89h+kC44LxZS64vXDOPHiPsInwsVU=;
 b=fp5sn1fs3U7U1eWhV3L1+BlWvuVU9QWG461cVgcySeFwnx+5iH78qX1/2GYjSsP5fG
 zORrZzl8xzzBGR6LEvTwzd2UKkTs9QlpI1uxrsrBSiDYAUfdWKjJxoexRJ9/BFqOrPUC
 2yIllFU8VnXwKJrgGYLvZoFPWhqpiz5gcl5YFgG9PW+IKraQNqnxDOf6c3G65Sq/bL/h
 JV6uVccRFYwZniOrcaHf6sr8mfdg+gOv3hIVwWw4JZDO8R0woVCPEwUf4AsZPM16/t/r
 30gbC8opsWaz3k2umyV/wuIhTwodd/H2QzH3g2cQmA0ArDEC1V715KcjYvuhbe/r1WPw
 hjjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mS4MMjAhINZTXb5Vzkd5S/FBKME/dfuENlUIa67OI8f74XqGu+BjhMzrbUO4n6ThlKn9z8s6xw9rq@nongnu.org
X-Gm-Message-State: AOJu0YwxHuABgZQlJvUMIDOEbH/fUcfTePEXtorJEMeGj4cRxSZB5LLj
 /yC4VhY4x/GlIJ7rwVwS/YlgM7+OA1g/NFeVDEDNIy9rSnNxUSOgQQfjxOUb0DkwkYLN7NwjE9N
 wklPxC6xKNVXHdmYGEPtkFHuk3Kp9Vh316UWuL+4bvsEjkLooecQgqp7KsA==
X-Gm-Gg: AfdE7cnluRZ4aodqCK3ynFxJCDVdfhbDMnEFxRmRjwiEgSSqHc/Kd+V7SBmKGmq+SxB
 t2jdg3aGlMp5Wuu/syNoNo14kCby6EA+EjJ6BiBucMGvqNysRBGk9JRl56pGWGnHp/c6Dvd18rI
 /O4fYmU96C4h/j+Hx+PSqzZclBLRCYFW+17LC0s6i2oOPI0Mc1nYd9BA3LEC4ctgjT+bTD8T5jc
 Kisp51/zRif6E1oa4N8RlB1hvbZ1p061vDiGa3yFNfHk95UGu6EFNwJBU/oPD5KFVgcTc0yqf5q
 Ce/0RuaINk0Ok9RaSYVLNcspdx8F7zTtKi7EzppF0pc+HVik7TqR4aRN+VuuNcaKl3YttK04EL5
 uDRaqGFIfu73nMy8UcTFI2B5lSd2+8P5YvRvxGMZKN23C5S8xoGEYwZKTpf004g==
X-Received: by 2002:a05:620a:29c3:b0:915:b718:accd with SMTP id
 af79cd13be357-92e781f130fmr1265519185a.6.1783070711999; 
 Fri, 03 Jul 2026 02:25:11 -0700 (PDT)
X-Received: by 2002:a05:620a:29c3:b0:915:b718:accd with SMTP id
 af79cd13be357-92e781f130fmr1265516685a.6.1783070711468; 
 Fri, 03 Jul 2026 02:25:11 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde19e8dsm17765476f8f.27.2026.07.03.02.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:25:10 -0700 (PDT)
Message-ID: <492afb3a-328d-4354-a620-10e1aa0a2ec9@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 11:25:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] hw/arm/aspeed_ast27x0: Add unimplemented Privilege
 Controller MMIO regions for SSP/TSP
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
 <20260703064506.937904-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703064506.937904-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3mvrJay9GV9WXspCVgfq2zNILN1WWquE
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a477ff8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=O0DVhGvcGMGwp8E8R44A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: 3mvrJay9GV9WXspCVgfq2zNILN1WWquE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfXwB4ZutetslFO
 TOJN0XNUIOk3xaJBKCL0S4/4jr7kf2NUXbuVgChyfFj3eIZQQ7vCpredTD19BupPbQUFalnBbSU
 qJp/14YsqKb0QYI/o5SHMmPrrcZ+XAGfEmbjhTh/OBrm/nge74Uvv+aEZVbsH2rFzNdKgHg0W/N
 DOjYnk9zo2YeDDaoXqOoKOJTQHJUWKoxGPEEGUtWNzHsfhQzO1XQsZ2blOo/b6HCL+va2kewskA
 YMoeXQ+8/tUhDRgqwWtm0WpnFe5qDP1mAQwBCatHUWLmS1pZz57kN2afouqx8WZIgMY6zGiSmOn
 Iiu6LH4YkRqGy07HSo8szb4+fU/fbHI6k1ahZKA76EK5nm4FGMiRq21KZKJtJGHSeEcznZphv6R
 ws5W4H9OWT+ydyHwB29NqOI0ylgWJ+hhe2qFCv4xLxgfwU8Vw3PaNF5Io4dEGJOiGhBAJ37/Pwr
 ieZ2/3vWpgfNRNdj3NQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX92X3e096VzSb
 h06TGmr9oRFdfaHKXHaWpPzxwhsELDzWBRv+8FQVqAx7YZMFQhMlBRGiYtBtZF1VDihO29q1djI
 nYLTlKcKIGahTgqHOujdOUwctDJCDyg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 3/7/26 08:45, Jamin Lin wrote:
> The AST2700 SSP/TSP firmware accesses Privilege Controller MMIO regions that
> are not yet implemented in QEMU.
> 
> This change adds unimplemented MMIO devices for the Privilege Controller
> blocks and maps them to their corresponding physical addresses in the SSP/TSP
> address space. These stub devices allow QEMU to safely handle firmware
> accesses and prevent spurious exceptions, while accurately reflecting
> the hardware memory map.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  1 +
>   include/hw/arm/aspeed_soc.h         |  2 ++
>   hw/arm/aspeed_ast27x0-ssp.c         | 13 +++++++++++++
>   hw/arm/aspeed_ast27x0-tsp.c         | 13 +++++++++++++
>   4 files changed, 29 insertions(+)


> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index b3c4eb1915..1b68e4eb5f 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -22,10 +22,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
>       [ASPEED_DEV_SDRAM]     =  0x00000000,
>       [ASPEED_DEV_SRAM0]     =  0x70000000,
>       [ASPEED_DEV_INTC]      =  0x72100000,
> +    [ASPEED_DEV_PRIC0]     =  0x72140000,
>       [ASPEED_DEV_SCU]       =  0x72C02000,
>       [ASPEED_DEV_TIMER1]    =  0x72C10000,
>       [ASPEED_DEV_UART4]     =  0x72C1A000,
>       [ASPEED_DEV_IPC0]      =  0x72C1C000,
> +    [ASPEED_DEV_FMC]       =  0x74000000,
> +    [ASPEED_DEV_PRIC1]     =  0x74100000,
>       [ASPEED_DEV_SCUIO]     =  0x74C02000,
>       [ASPEED_DEV_INTCIO]    =  0x74C18000,
>       [ASPEED_DEV_UART0]     =  0x74C33000,


> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index 6098d1aae3..59dcccd511 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -22,10 +22,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
>       [ASPEED_DEV_SDRAM]     =  0x00000000,
>       [ASPEED_DEV_SRAM0]     =  0x70000000,
>       [ASPEED_DEV_INTC]      =  0x72100000,
> +    [ASPEED_DEV_PRIC0]     =  0x72140000,
>       [ASPEED_DEV_SCU]       =  0x72C02000,
>       [ASPEED_DEV_TIMER1]    =  0x72C10000,
>       [ASPEED_DEV_UART4]     =  0x72C1A000,
>       [ASPEED_DEV_IPC0]      =  0x72C1C000,
> +    [ASPEED_DEV_FMC]       =  0x74000000,
> +    [ASPEED_DEV_PRIC1]     =  0x74100000,
>       [ASPEED_DEV_SCUIO]     =  0x74C02000,
>       [ASPEED_DEV_INTCIO]    =  0x74C18000,
>       [ASPEED_DEV_UART0]     =  0x74C33000,
It would be clearer to set ASPEED_DEV_FMC in a distinct patch,
otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


