Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DDAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZQm-0001j0-3N; Tue, 14 Jul 2026 05:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZQk-0001iZ-12
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:27:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZQi-0008Ka-HL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:27:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E77SIu3932438
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YsjEJp6DYQzK2zaLDLP3O83HT20ISI+a2E8CpMG8dm8=; b=FMYyNUPt2ASQ8iU4
 QS9XstVQssDjm5fsZ6EQfNuKvPYSS0fcVP9jseMS656DY5ot+QXDFmdLFj5+fOd5
 Hu/cdnzmGVJZjm1LyAUdIxZWOZG0CwzNSPVghtWKcMBih/VZRaPs8sKfpTbZLEmY
 4bih0niZ8YBcX6ZArfQ+lFOL/QF9zDQLZuIUP8J5XFiTvlT1hsNAbwWYc3tGPLtp
 q8TA6LnOYD2b5V/6fdbWHielUd5TuAffxVckYvdtUTNgvthid610aaKtMDwmm4vQ
 XtfbTQt6nsQURFWbcah1ZLjDJQTWilzS8mxfj1/tNNj9uGrGFqlJEDGEz4Kf6oup
 Gc4QMA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq0gx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:27:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c19493ac2so62436581cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784021274; x=1784626074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YsjEJp6DYQzK2zaLDLP3O83HT20ISI+a2E8CpMG8dm8=;
 b=S5Z7HURhk9OWGJMPKNrbU4sh7xeuLqgAM3SvFTQBVd8IP8bXAayV76p2Kh0GaTzc1F
 qiI+LNyYnrbjIHXvVqLxOfdi76nHPtKu3ks7cmp38uRmA8fuCX7TVDNlAS4lrhPwtl23
 vEo1H50LF4AZImMLuoxKUn389uSBLztkWRXtZIL0n4meKc/CBZP6ymrLxGQZoOo6vjO/
 YhvCuSDwR0gtLF0BYuoJvkVaxCLgXrZ3wez5Rt2ozkXO4kxgkWJT3n49SZUE4u/XxR2B
 GbslHGijepkK1V9fcsSuth9YusPjz9pWiw5ZgCHs9FgQdfS4GrechDfZoVYA8sc/7iC1
 63+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784021274; x=1784626074;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YsjEJp6DYQzK2zaLDLP3O83HT20ISI+a2E8CpMG8dm8=;
 b=qHPtgymg8hucFlFeqZPV/r8kbqYnyuXFG73NsfB/EU/wFx+vlVeOccuy++yoszsgo+
 yNS82wOM/usxKefWz/HRN1HHCZJV4TG5sGzMSqHJ3fAWfcsjJzZVlkL+ag5Oz5AWLeMu
 IR/61LrO5NNVKoWcA79tebUB+JNVCU2XQdsCKD4FHjw+mnazUDXIeC+3lmFWn6fkCAYH
 vkDbOap4fl76KRKUhuc35yzsfZxkQfB8BVKvKYPA6ZVGBU+zVg/R2X54K4cydsE3LTuR
 qanEfYMsEHFR6s2y3boXjioBJzMJ4jcAd/LDHXC+XdjIPrClLdt2cklFoum4df3GqFax
 kGxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/ffCdakCIKDyKHKFxXOeWsvLJYZVxdU2IYCyRh48/kvqCu7Y9ZGQEH9zafMcS7mWW0gVC7Li/lfDg@nongnu.org
X-Gm-Message-State: AOJu0YxA8dHkfE+92s1nfS/xwpQrIHdSVWWlmLXggXausPuDoX/aV/9g
 Ea64cdxTsZLf6D4JZY3qQHfcX460Loa3QCSqOGWrZNf4JxwQZI8jSc70v2Ese/4+RlEhdkXJezW
 fX3BcFoYVPEND3yWaacAadPAZXZQyrUHEZVBYCno+rns3vLbDZuwaHG8Vtw==
X-Gm-Gg: AfdE7cl9kc6efGDO0yfis8X8aVGqpytmilmY2+YDbXoBcKjWnn1KdMToRi/I3J+vkQq
 7uI8sfl1QSTNa2eYH2e54/7q4m9JfAtTyJZOUZBJgUZVO7QCx84qjOGR/odr+3F90ZKsQ6ohEDT
 /oOQTF+x3CzEJNqCmpul8xKsyybliXIy3zPMluzPnh+Yze7PQlOarVTosg165vHVKVV4lPANdmZ
 uKW5iTF6cKO4kgdbZzteb/HkSaML+RicoHUUEYKral5t+orK6T0YB1ToYNV0t55qSHTDJnu9evU
 7eKKp4qnSe8uF3hpm+vmF8MWZIZZfnr3xiEFciT6S6t0IIH5NQfDaXoEELiDidX6dIrD8QqkkWZ
 AwzTy2AsDtYsbbWabXk1SvMe41ABKNljJ0z8ZXn0ySJyg6sQgLgY6j5fHsSiFIg==
X-Received: by 2002:ac8:7f92:0:b0:51c:a7e:4cc2 with SMTP id
 d75a77b69052e-51e42393b4dmr10506411cf.20.1784021274406; 
 Tue, 14 Jul 2026 02:27:54 -0700 (PDT)
X-Received: by 2002:ac8:7f92:0:b0:51c:a7e:4cc2 with SMTP id
 d75a77b69052e-51e42393b4dmr10506241cf.20.1784021274021; 
 Tue, 14 Jul 2026 02:27:54 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c165d5b2e0dsm109557166b.57.2026.07.14.02.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:27:53 -0700 (PDT)
Message-ID: <4bd00c71-9a3e-4fd3-916f-fa9c79c78d7c@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv/virt: Add optional UART1
Content-Language: en-US
To: Yanfeng Liu <yfliu2008@qq.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
References: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
 <f3999d13e4cf6e470d7761be01d1291944ae0e9b.camel@wdc.com>
 <tencent_75E11E56A40ED70491B2E653FCEAC9FEDD09@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <tencent_75E11E56A40ED70491B2E653FCEAC9FEDD09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5NyBTYWx0ZWRfX1HSrkJlZ2Z5c
 a4MXyMLkxRqudd7NFw4FpBWoGQ5gL03ME5yJyBYpZx3TAcfn69/oN4Ju5KD5R+yvs5b2OBCAaS8
 zKaakJrs0A2njfjPTCAbb5y84s9yX1jthFnS9ImvDzlRUVfIaYq2UJdr5uluJbdPmwCFvU/CSmn
 U28oEsSrbwiGe3Qv/BFJ+Rv+yz/opRzTytNErHGlnihnkYcygrM7V1GyJMr0fOqfNVtfzaIdsOV
 nbzdZ1luzrKWfqx4yHnjp7PSeOaGV9xrHzzuiuF3t+0R5YMItujECUYT/KSD6gUNS18fMc6izZy
 G5jdLw+0xCOTlTLQKDfQaMxfF/I9s2+GerwjnRozNyeSJB4OxeY2NVrdIZkQVr2+sm4+XP5J/Th
 3ieZT7JqzmCpmXGkR+sHsPJu/88OApwEnFbTGz7pPBsBbG7pkVNHZQSiMiW5EdTuRyOv+FIx2eh
 JTv1/ZXVJ6ykNxg7uqw==
X-Proofpoint-GUID: iODEtJSnc0P82ZRaXws0UGn6bC-y6nk8
X-Proofpoint-ORIG-GUID: iODEtJSnc0P82ZRaXws0UGn6bC-y6nk8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5NyBTYWx0ZWRfXySb5Z+t9dtM8
 wt10xgr6/gFZhDhMfwgxWlgSAb5mgi7s13ist77QSU0xDgcJfRKB2ed45dBo6NABQaN1yGOxp9b
 UqjNuTUvtiG1b8u1h/qIf4vn6TlJuwI=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a56011b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=dZbOZ2KzAAAA:8 a=JF9118EUAAAA:8 a=D_RgE4d47K6sYyuMCyQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140097
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

Hi,

On 14/7/26 05:40, Yanfeng Liu wrote:
> Alistair,
> 
> 
> I was using  0x10000100 at first but soon noticed it is in the same MMU
> page as UART0, which is difficult for pass-through hypervisor guests.
> So current approach seems a little more flexible?

(please do not top-post on technical mailing lists)

It would have be clearer if you precised that ...

> 
> Regards,
> yanfeng
> 
> 
> On Tue, 2026-07-14 at 01:13 +0000, Alistair Francis wrote:
>> On Fri, 2026-07-03 at 12:24 +0800, Yanfeng Liu wrote:
>>> This adds optional UART1 to RiscV virt board if required at
>>> runtime to simplify multicore development.
>>>
>>> Note that UART0 remains default serial_hd(0) and it is:
>>>
>>> - the lowest address UART
>>> - first serial in DTB
>>> - behind /aliases/serial0 in DTB
>>> - the /chosen/stdout-path in DTB

... here [*] ...

>>>
>>> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
>>> ---
>>>   docs/system/riscv/virt.rst |  5 ++++-
>>>   hw/riscv/virt-acpi-build.c | 12 ++++++++----
>>>   hw/riscv/virt.c            | 39 ++++++++++++++++++++++++++++------


>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>> index 33775a61fd..9a112ccdef 100644
>>> --- a/hw/riscv/virt.c
>>> +++ b/hw/riscv/virt.c

... and added a hint comment about alignment here.

>>> @@ -96,6 +96,7 @@ static const MemMapEntry virt_memmap[] = {
>>>       [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX)
>>> },
>>>       [VIRT_UART0] =        { 0x10000000,         0x100 },
>>>       [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
>>> +    [VIRT_UART1] =        { 0x1000a000,         0x100 },
>>
>> This could be at address 0x10000100 instead and squish up against
>> UART0.
>>
>> Otherwise:
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>
>> Alistair
>>
>>>       [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
>>>       [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>>>       [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },


