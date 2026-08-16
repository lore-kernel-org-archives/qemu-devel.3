Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519E2C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcGC-0005DN-Nj; Sun, 16 Aug 2026 10:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcGA-0005Cj-Mi
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:54:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcG9-0002fD-83
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:54:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl5wn2398157
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rK4RN6OCpppwQO5dTLQ2qwr//kWAqBQCpaDdEz7bFAc=; b=JmY821FPDkWKWylj
 7JX3zSK6agR8R/qYvHOUnh1BqL66XAIwyL6MEkprGNzj4BGyPgDDzeciBwxHPTX8
 Bbuq7NZ3FY4qtFhUVCxyjCEE0kyPO9FYfvwjaMFXNqQ/04mFumgmPkdkn3DzWq6A
 2TyHjCOSjVgY2oC45NKQflnGJsqLXvYxgbCnb1w1Rv3I9GcQ+oro6bNPEOGr7AjY
 O94oSDjQA2uiT72wyvvyxZLXL98zZVEU6WpDnr0LzMCEvYcm+joLd7KPqOIHEF9K
 cq1VSZJD7dtI+RPOxGD+V3LEUzxAk2vJZBfoaVy5HGe8PCzTxTdgPV8LmKKabuMm
 w7j5qg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq3p2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:54:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so49736521cf.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892081; x=1787496881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rK4RN6OCpppwQO5dTLQ2qwr//kWAqBQCpaDdEz7bFAc=;
 b=AQtyIkgeR2OhLJigUr8F9VI1TM+C75w1VdvlfeSGJ6qH6uSFbhIQhntgNqy22CHz+E
 vuTO84sqNWb2f9/UI6Y87jLkrKTmPI8HDh3TvVdrMCSRFNU/7Fk1BpjoLWQ2pR/LHKXr
 OgbVLYSyaemw1puVa7p/6I8tjpxy9pgtn4FHbDA4MtH/2QVfL2xSKbk8QUJbjNq18ltL
 m5wcTLKCOmE8+ssAt3FgYgeUCQJfFM/StsR7tq0jsjbtJEbksmEQduLPA4TJGYX/YLDA
 IzQjAnAp52t7YzmAEGKJUCKyYw30tBmk2BEtyxSUHySwJy8NqFfCxn1uuev/Hz+MrjJ8
 ORNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892081; x=1787496881;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rK4RN6OCpppwQO5dTLQ2qwr//kWAqBQCpaDdEz7bFAc=;
 b=E9yCK/4pC01EY/cP4Tr9xoq6UKQchf4Na993oL2IN8p4j9RjknY7usCw0wQ/e6VLaQ
 HnnhKtddCfm3oAf6zU1YFym3zUUCJipzfZHnxWkB2/qMWHyK5q6DhtZL56Z7ainfVurF
 xp5w9p0ck8efMtgc+3XQUGWzr6NaSXYUPA8hy2tmr8KlaXFsrY8V/ckSz7+OxUn0XYtj
 6DUssutLuk5doRH9y2WnByafa83VUKo0HbHJwzxDZXXT/Bl2dd5OSqiO3bU7ZpTXRCWe
 7aSZk+BujRLVSqLemUCMQPDDgOkIMrZroo2FpwoSA5YHK04S0YvYSzsL2Jb9DUeVyIUV
 vXOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoozQQ0yX+E38yWSX2euifbKXsTduQ8UZvJyneeobIYQ5lt7hdJuDOrZ8XaUgBuE4l73FdNHucricu6@nongnu.org
X-Gm-Message-State: AOJu0YyJacx/YtP63+Rn61j6N1l5X5B4eEwr15KYYcEr42am7jq4NkkP
 JyNJlQFrKGUAWZlUiw3T4TaoI7/9FMnGhNhkexvzVuEnQ4oqCIPWqm6hYRq4ErSmqjmN9qtznNf
 lR+8lFTadX1dTicr/GfUbMXOyFu4/8ekv7dahhi61YjNXF3ywswMhJUaDWA==
X-Gm-Gg: AR+sD11/shzUkP6xYAVWrJsrgc1mU+6BR8xnfagEn25eucs0r83DvisLam7lnEMPo9U
 /V17w7fylkp+DHXoas2gs3csi0bvBg6R49toGjl/CFy87lH37DkD0c9cJlkkDbK9ph7C2wovIZS
 qgTEsd+kjluN/YNJUj+nw5rVqomB+qyitazQqHT9rdKPcR1g+kVvOlHPymYfm58oMKhJiTSBqoL
 3TJoX/QYSI4SEoeMVhWs35195yGsN+hM9gjGo7iIaOwOhwxtOlae07HvowQjdi0mgzpx6YHnz3q
 ONB9v3ySl6Qtj5LGJLBywTie5u3JMmXTzkjV4ikSwsFMEypjW0BJuMDU/vLqhXxoaj8hqjqjb3n
 bXH3zzS8GlXBLuNFa0VGTk8kTSOAhKo13frA=
X-Received: by 2002:a05:622a:410f:b0:51a:896c:9aae with SMTP id
 d75a77b69052e-52d8535e9a8mr206689551cf.13.1786892081115; 
 Sun, 16 Aug 2026 07:54:41 -0700 (PDT)
X-Received: by 2002:a05:622a:410f:b0:51a:896c:9aae with SMTP id
 d75a77b69052e-52d8535e9a8mr206689301cf.13.1786892080724; 
 Sun, 16 Aug 2026 07:54:40 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c6115sm24217092f8f.32.2026.08.16.07.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 07:54:39 -0700 (PDT)
Message-ID: <da09d1aa-5aed-492d-9afa-01d3a1fcb813@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 16:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] hw/arm: aspeed: Store boot info in the machine
 state
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
References: <20260816131300.51799-1-bin.meng@processmission.com>
 <20260816131300.51799-2-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816131300.51799-2-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXy4BKHC4fT7tT
 gYkWQMYqZB5YITnv7sVkWNW+iI+gyzmP2mZ+hr7OtB2o3nH/bZF3sDkBzhXFLpnMPAqmI05dNQN
 0QVMl/PKkUICVKoHf4wFdBgOv5GmoL6urP8SjAgiLixlQgqKvi4HhMVVLN/ttFOcs4VEXqOKxO/
 nJNbCfF9VGo6aBBGidXQduRUXW58GDH9Bir+p3Wdxh3Rxh7GEaxdMFJ31cdn3BHQOnwXP1yE0I7
 7Fy3j/UJSPpAunv+CehDi+VhtVIY6fomHMeHCmwA8OXf+vy8f1fEHUhjY9QIc1tadVoCps1tdW9
 jkwe/uJIbSOh2vGQFRjhiDhcrCzfhF851MtAIL8yrZH1dSGZA9rlRlecoUlVykDkjG/0r+2ju85
 rokK2QrwnEBP5aYCn5gwv5HqguaKM3XURcJtO2+7bKgfL8bc0TU0g/OKwCtmlHBd+tV+yZU7UEf
 meSYkxGhLQzC3PGlQVA==
X-Proofpoint-ORIG-GUID: 4EdoySKmFXr5wUAaV0DyjYadRIn2hHGe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX+Vt5m4XLK2+y
 bQ1xd/Y536I1My+TCgt5pqeNmvpTQXJxvnIj0NbG/TeszlYkNUJXHps7J31MdVmXpCdT1dcXAV1
 VeWKSzDaJUsyI94lp1YVhTLUxL1oURQ=
X-Proofpoint-GUID: 4EdoySKmFXr5wUAaV0DyjYadRIn2hHGe
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a81cf37 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=6H8sgBPm4cYhR-Qzk5MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 16/8/26 15:12, Bin Meng wrote:
> arm_load_kernel() keeps a pointer to the boot info struct for the
> lifetime of the VM, so the struct logically belongs to the machine
> rather than to a file scoped static object.
> 
> Move the boot info into the existing AspeedMachineState.
> 
> As in the xlnx-zcu102 and raspi machines, the boot info belongs to
> the machine rather than to a static object:
> 
> 4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
> 0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/arm/aspeed.c         | 17 +++++++----------
>   include/hw/arm/aspeed.h |  2 ++
>   2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index a9238e6217..8fa16b3831 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -24,10 +24,6 @@
>   #include "hw/core/qdev-clock.h"
>   #include "system/system.h"
>   
> -static struct arm_boot_info aspeed_board_binfo = {
> -    .board_id = -1, /* device-tree-only board */
> -};


> -    aspeed_board_binfo.ram_size = machine->ram_size;
> -    aspeed_board_binfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
> +    bmc->bootinfo.board_id = -1; /* device-tree-only board */

Should #define a self-explanatory BOARD_ID_DEVICE_TREE?

> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index a00238ed74..54f0d7643d 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -12,6 +12,7 @@
>   #include "hw/core/boards.h"
>   #include "qom/object.h"
>   #include "hw/arm/aspeed_soc.h"
> +#include "hw/arm/boot.h"
>   
>   typedef struct AspeedMachineState AspeedMachineState;
>   
> @@ -42,6 +43,7 @@ struct AspeedMachineState {
>       char *fmc_model;
>       char *spi_model;
>       uint32_t hw_strap1;
> +    struct arm_boot_info bootinfo;
>   };

Maybe time to add a typedef to be style-consistent.

Anyhow:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


