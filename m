Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC51CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZuo-0004P5-Ah; Mon, 22 Jun 2026 04:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZui-0004Mz-Lr
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:21:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZug-00024S-DC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:21:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65M593BS1275281
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2wUKKjQl9rsTVFmPwUk2auYgIVYYH6IgFYyIoSTnS80=; b=UQzXio1v+fXs6+cE
 AlPendamYRFL6yqaXm1yojfxLUHbV6VLMPjx91tD5PMmDRk6LA7Uf54iTUlWxQ9h
 KU83HgyY3ghnYk9UbXSZ47dJ9BtqnseOJDqhBbCpcQLSKJwMz64v2Y3cE9pKQKZI
 EkLOgoBDI3IvME/jX0qFouAPzYIWo6yXa3BbeLU2oZen5VDp8RelHvynzdeXA2lY
 HPw3dCElsEzlc7VCevv4PIwz6N136uJzwpxWGWDIy7RhvVZdKz+WwKHK8/7k+83u
 3iyCGv3M6xNuEOpJo9PCqEnI9YOcqYDmz/43lMvE/kW6wUe6SH1ZJWnl46hZAtq/
 ZPurqQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewk32wm3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:21:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9158f2c4b55so671697785a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 01:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782116506; x=1782721306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wUKKjQl9rsTVFmPwUk2auYgIVYYH6IgFYyIoSTnS80=;
 b=d+WVxkCTGJwPZGRorZtvSJ8RTOEpAzboMmzqOji4fq29aPfmCJpCe/gZqq/kcY2Z1j
 EGeYob+vob5nnCgAfPNhX6HtXGVYtsgh1fRyOPMajCGohCUbRaaXkCRZDvtjRNLi21Kn
 xBey57ZDZFNh9mHJ5txCcehbAhxC24STdMSQ9N1PLgzjNj/OaSWrGhwMy34XkgZHwa3V
 WT0kalHdfXpYRN5E9xih8wNI0r6qnlkyKEL2q57/XaEM05PNSll2JpAIwVFfoj/I9FP+
 MWXDfLGUGfharYxzlrOtB5/IXk5ukMHGR4GM1ePHm1Flw9OfvXgG6AkJMSQhrk6fqUhn
 QCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782116506; x=1782721306;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2wUKKjQl9rsTVFmPwUk2auYgIVYYH6IgFYyIoSTnS80=;
 b=h5W0BShF4G7l4FfuSMnKDtLMAoz5QAg1UZ6hZLmwyrVZWb6uvnzaij95c9etQC+BIA
 Oj41kWWyNqm8AWUw12idbsYXwugMdyrxY8RfQAwjjsfxtFkweyyBuEQGe6+Z3WMQC3TM
 HsFJEl4V3JCqEVOHqMK0zlg/2U5dFcMmYed76k/5Py+0JThvR9Jjhw/OwsB3C03c8HwA
 j1tO148Ue0Frwt6myfwpnZCr/GlFNTq3YLyAO1EVnY0OYwhAXV35YjaF2Q16OGRHE/+r
 6iCTnpDy69mDlyWeiKHIAUZsfDRUS6vpI5f6BBLt0VdrgA3egeDVLB6febvi+lWlZ2sC
 ThOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kA0pareSM8s8AwkeJnTvNs5koSpU5Y0Naw8RJOV3MVxlAPOfa45npk91t19AFumUaXxTgD310Bcwu@nongnu.org
X-Gm-Message-State: AOJu0YxSUlUIByNj36NCl4XpfYrf53aJm9F9t+T0FbDVVFpOVvtMAqlE
 RhKS8IHTy87u0N+nbTUA4TeRToMWn748K5ulxFBVkbAA7o0TAs0Yg4KkdbU1a5T/kbcwupXDk1+
 gk7bwTl3spzpjFC56Dlqv6626RL3eXeMzJd0Ci3lr7utxQRqR3kgtwcxWbA==
X-Gm-Gg: AfdE7cmmAhq/RQVlL0ShD7PycL5L+k8XlMz27owEMhjZc9jXiHG3zaAeiN0VakRbV8k
 XGS2p0aB+NN0ggnMPTHGUfQatn7+KfB4yQbwL7BDtjBc//qnSePEBxlSq1QLS8us39vD66loCOx
 Vt/8l/sUstEzIncTG245RCAfzmXp5i3h2+48IH7WvY7y/fF+tl45iWQsASzpaOhr4f//s1fhkSp
 67urcUeXpxtHjAYND+mwjg3jCSafLwRuio/JtYQZnHCnQS3QngRoOsSoYYOmn1jLR7PV4C780R9
 rRX5aZXdwQOMGDAwMxL3vRWS96U9Uy3DYWKk9GUIVt7+9c1ivugIFgzZsNByzhFncQ+nvufHC44
 gtRQrlUdVgbt0zUJkvzl/w6kxeZPun4wx51jVhwgd3VvvbMhjYh6Nc2spuNMG7xmEPX0=
X-Received: by 2002:a05:620a:4388:b0:915:d5cd:8cda with SMTP id
 af79cd13be357-921d1343ae2mr1408193585a.21.1782116505540; 
 Mon, 22 Jun 2026 01:21:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4388:b0:915:d5cd:8cda with SMTP id
 af79cd13be357-921d1343ae2mr1408192185a.21.1782116505075; 
 Mon, 22 Jun 2026 01:21:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c5de7sm23513026f8f.15.2026.06.22.01.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 01:21:44 -0700 (PDT)
Message-ID: <27203775-0a47-4758-90e5-f74cd8ef36e8@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 10:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] hw/arm: ax3000-soc: Enable Axiado SD host
 controller
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-6-kchiu@axiado.com>
 <41ffebd9-00fd-4a1a-a281-1e8bc475fa9f@oss.qualcomm.com>
 <8beb5c51-04f2-4e96-ae7d-a015d16b0ec3@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <8beb5c51-04f2-4e96-ae7d-a015d16b0ec3@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ns0mwKgGMsr_Ry0iOSEuyX5QpW_AWTKw
X-Proofpoint-ORIG-GUID: Ns0mwKgGMsr_Ry0iOSEuyX5QpW_AWTKw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA4MSBTYWx0ZWRfX76xva5QS5Gu7
 jM/GN8XpKxTnXRKfX08f8KuoIdF65FzTYpI2/2cc7My1oMdt9qWdfLWYtiNhSBDg1RG9kiyTyvg
 4QvV9QcwEHpOClHUmFye3I0wRmsHKts=
X-Authority-Analysis: v=2.4 cv=NovhtcdJ c=1 sm=1 tr=0 ts=6a38f09a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=440cDlBIAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=NN8S7mceJWIg8xvRshcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=d9D1X1bx8dWolqnE4HNT:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA4MSBTYWx0ZWRfX3dRoi6VzKCnn
 T3dt/HWmvnbseNg1sk3nunv18mkBSFVEKFlXYL4xf1TRIoCRH4lf6BggwRq8xlyRKlfzaB7gXEz
 KEXusFNjIFPEOAgRNXz7K/c6TLA6ZLSYB9XjybWG8BCW8KnJ1VtPbEbAAmLDo1sLjoCCvKMu681
 RpnJvxmyxzRVjWcxKdTroC2uFdH7AKWqUv4k+NAklpjVCu4YiYwNUstFu1WhpVqrUM9L6Aoicam
 tTVQM/IoyOYtwbuuxHdKOmGkaPLVN+kJaPQEy6KAqMtJ9Na0ErwI4+qflEYwNpAFIrfOAg3x2N8
 Czktgdz4odfOjhAJvWTJJVFK3xOb66Ks0rC6FDahVgSQckHqtQhysKe1sIXXa8nuVNiVkFJQKsv
 G9u+PXiLDAEs9jqsZpe/ZhkHzn6xokhqLhWTKsXyuflcP+jto8hL3zqbYQh3L4iP/GM/PQ6wjiR
 bhlK7iabSKki2MY4a3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 22/6/26 05:34, Kuan-Jui Chiu wrote:
> 
> Philippe Mathieu-Daudé 於 2026/6/18 下午 11:17 寫道:
>> CAUTION: This email originated from outside of the organization. Do 
>> not click links or open attachments unless you recognize the sender 
>> and know the content is safe.
>>
>>
>> Hi Kuan-Jui,
>>
>> On 18/6/26 12:12, Kuan-Jui Chiu wrote:
>>> Enable SD host controller into Axiado AX3000 SoC to load kernel and 
>>> rootfs
>>> from eMMC.
>>>
>>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>   hw/arm/Kconfig              |  1 +
>>>   hw/arm/ax3000-soc.c         | 18 ++++++++++++++++++
>>>   include/hw/arm/ax3000-soc.h |  7 +++++++
>>>   3 files changed, 26 insertions(+)
>>>
>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>> index 866e4b14e6f..13c0b44a180 100644
>>> --- a/hw/arm/Kconfig
>>> +++ b/hw/arm/Kconfig
>>> @@ -724,4 +724,5 @@ config AXIADO_SOC
>>>       select ARM_GIC
>>>       select CADENCE # UART
>>>       select AXIADO_CLK
>>> +    select AXIADO_SDHCI
>>>       select UNIMP
>>> diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
>>> index 9a01d23bcc6..159385cf913 100644
>>> --- a/hw/arm/ax3000-soc.c
>>> +++ b/hw/arm/ax3000-soc.c
>>> @@ -35,6 +35,7 @@ static void ax3000_init(Object *obj)
>>>       }
>>>
>>>       object_initialize_child(obj, "clk", &s->ax3000_clk, 
>>> TYPE_AX3000_CLK);
>>> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, 
>>> TYPE_AXIADO_SDHCI);
>>>   }
>>>
>>>   static void ax3000_realize(DeviceState *dev, Error **errp)
>>> @@ -165,6 +166,23 @@ static void ax3000_realize(DeviceState *dev, 
>>> Error **errp)
>>>           return;
>>>       }
>>>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ax3000_clk), 0, 
>>> AX3000_PLL_BASE);
>>> +
>>> +    /* SDHCI */
>>> +    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
>>> +    if (!sysbus_realize(sdhci0_sbd, errp)) {
>>> +        return;
>>> +    }
>>> +
>>> +    sysbus_mmio_map(sdhci0_sbd, 0, AX3000_SDHCI0_BASE);
>>> +    sysbus_mmio_map(sdhci0_sbd, 1, AX3000_EMMC_PHY_BASE);
>>> +    sysbus_connect_irq(sdhci0_sbd, 0,
>>> +                       qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
>>
>> So there is no link between the SDHCI and the PHY. Thus no need for a
>> particular AXIADO_SDHCI, simply instantiate a generic SDHCI here, and
>> register the MMIO region for the PHY.
>>
>> in ax3000_init():
>>
>>     object_initialize_child(obj, "sdhci[0]", &s->sdhci[0],
>>                             TYPE_SYSBUS_SDHCI);
>>
>> and in ax3000_realize():
>>
>>     object_property_set_uint(OBJECT(&s->sdhci[0]), "sd-spec-version", 3,
>>                              &error_abort);
>>     object_property_set_uint(OBJECT(&s->sdhci[0]), "capareg",
>>                              0x216737eed0b0, &error_abort);
>>
>>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci[0]), errp)) {
>>         return;
>>     }
>>     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[0]), 0,
>>                        qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
>>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[0]),
>>                     0, AX3000_SDHCI0_BASE);
>>
>> Then you simply map the state-less eMMC PHY region:
>>
>>     memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
>>                           "axiado.emmc-phy", 0x1000);
>>     memory_region_add_subregion(get_system_memory(),
>>                                 AX3000_EMMC_PHY_BASE, &s->emmc_phy);
>>
> This is the original design in previous patch but PMM preferred to have 
> an independent device model for this SDHC

AFAICT nothing on v1.

On v2 Peter said "Adding the new SDHCI controller should be its own
patch." This is about the code contribution process, not how to
structure the model in code. Is there another reference I missed?

As it this AXIADO_SDHCI is unnecessary maintenance burden.

v1: 
https://lore.kernel.org/qemu-devel/20260306121511.1781020-1-kchiu@axiado.com/
v2: 
https://lore.kernel.org/qemu-devel/CAFEAcA8dRq+hqCZ+eSHdafwEccd4coqHZ12nxWAkyDOG3GEkgg@mail.gmail.com/

