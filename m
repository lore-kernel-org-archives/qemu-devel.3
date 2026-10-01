Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38660CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC45-0003OC-SY; Thu, 01 Oct 2026 04:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCC43-0003NY-HZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:22:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCC41-0002dh-Sd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:22:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xKNl2805837
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 08:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9h8IDV9Vq2TWZ1n+VhRIAbVUfvcWryfuLi7ZKuhvCxg=; b=Gz8ZEzp7kWe0iZhy
 Ai0iFvcRozuSYun3Sgn3hq0o/p46feLot7PKECq1zAu6cA/2WsU6zalWJxMxmgQ+
 YbkYgWCF0KqfyQXAkamYGZYHfye5Loogv+/SzeL/jG1f2Sjm2FZO0L4oWsX3tBhM
 Ra/YX8KaCBdvAumdM25XqHW7eavRqMOYkrOkCzY2HbzgdRwkWN2lF8I8nKNLDchu
 qOTf80691b24uu8J8kSfKwFfT3qy0L8TfEtxVzwphLgDkVJiuHcLzAdn3FiikSaI
 K0r5j0lD0x3x+Fk8tQuxk9ko5PhFq+QL7gz4CjOjq3NfUPWBCzX4eMTrWssGTGcw
 hFrOJQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1hvkggne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 08:22:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so1561532785a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790842967; x=1791447767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9h8IDV9Vq2TWZ1n+VhRIAbVUfvcWryfuLi7ZKuhvCxg=;
 b=jX476L2g4No37D7Ujezmu0AnJmHsJFav549j8USk54zMC8TqASyl3ODmFFH0AAi3uS
 GX31iPQEIBCCg1Xvb9pzSEXtfYxVrX4p+k0Ps/mdC4OAjzofKn1HKrTPdYTbFCtOzGw+
 kaY6mgIjHa7SlZBkOKJ0lpTFbWENPEyXoGjDjt2A+35JEDVJOJB1et1M/JtxUSZgbvF6
 cZlZhDA3eaTDBv4UlCoC9qXNYQqfe8ieN1L+IPanz/bqBY4AmTWpvrSzat/owLWer92/
 X/djm5Qka3KGOo0KjmmXuRlhOFn+Y9oCw0hgghQTGRjI0d/R5/dbi1Utlx/pz0Xbpwg1
 ucSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790842967; x=1791447767;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9h8IDV9Vq2TWZ1n+VhRIAbVUfvcWryfuLi7ZKuhvCxg=;
 b=zFWG4EH/GHCU/OMuDgxAHD22dYyBvQpP30Nc9VcaYIJrXMCaYZWCsK5hgO/39eADxW
 ZjkOyCuVTHyRkvFELuDBqR0yOvyeTcyPKXj6mFoFT1ILZC9vkQK1Y34LhZ+EqssleDZd
 9bDjtBTFV2Yl8xRA79r0FRAQM3M+LQ2sx707mDrHwKD/X7Af3HXjgwktXxtn1h7R3JCz
 ZfVKeOL3C9L6lJbdJkbHoe1enuA255VeFmzfoH+xHMQzAgN5BOnZRW6YV3LRyN5ns7l9
 JbE+g6B9f3XGmiEklLaqMK9HGjqQkQJL9GKW8ppQ/PzFt4cCOevLeqhvtAT0yyJBWpWa
 jvjA==
X-Forwarded-Encrypted: i=1;
 AKwUvByoEhySx0aoneNE+sfaaCJj6zmY1/CZTIETHdCjg+TFozduGAoP/TFurvqrA7y8XwQjqyVeiK8mopn1@nongnu.org
X-Gm-Message-State: AFuF++l+r6B+Hrm/O/EZMJK6pNZHx9FAlMAbrm0MBXGdzRreNNljhH89
 N1fnyYnh2FKNhvcBwv2lASXL61QCpffj+7aZNsUclddn7XCWEQ5uykY8Qr6LNzXTzxc+b4NdJEj
 k3gfBcgzdDXElhd605peXPFdjnyXb+0+froBQE9QwDh1/ASsJ8Q08VDJsZQ==
X-Gm-Gg: AYBFou39sYC8Iv5PAzl6PCI4mTg5WeECjvqVsnOh+ZprZpVWK8Ro5yMsr9Caxlzr++R
 yadjaQjP0EQ3ObhFCO/OO38Coo1CkNLw+gJNzzVVBt3mFKmoyxH27w+zxbCgLi4UTwZNf2PfQk5
 sdOD414vKT+vZEYN5yvwmlOvyJuRXD+MDncFfohlE2zeTE8o/cSJ3cRI0VdwoiO6CncIxj0axx9
 /tkj5w/N+ymGuXkh6G+KFrh097s5EPOdz1f/zKRVok8xZJ2MlyM8EEjO0f/fQuaeW3H/w1CMkQW
 DHxKE89hMZp7imiKuBegA0tfIbvyRLl4E9zxuq+5LsSQG9kD+y6REmE+WXQdUhK0r0TsB24/mIE
 ytd+uJxhfJg/HZuYE5vv68/1n/2HmSBHWsg==
X-Received: by 2002:a05:620a:4892:b0:93c:6515:b437 with SMTP id
 af79cd13be357-93ca96beba1mr766047985a.23.1790842967369; 
 Thu, 01 Oct 2026 01:22:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4892:b0:93c:6515:b437 with SMTP id
 af79cd13be357-93ca96beba1mr766044885a.23.1790842966891; 
 Thu, 01 Oct 2026 01:22:46 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f90cd4esm66851255e9.1.2026.10.01.01.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 01:22:46 -0700 (PDT)
Message-ID: <76924034-bd03-4b0b-9ad4-0e1b9568cc7c@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 10:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] target/riscv: Clarify riscv_accel_set_irq()
 arguments
Content-Language: en-US
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
 <20260930174508.81497-4-philmd@oss.qualcomm.com>
 <52c0cc7fb2a863ffcb0cc43ae256e05329c6ddb3.camel@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <52c0cc7fb2a863ffcb0cc43ae256e05329c6ddb3.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMyBTYWx0ZWRfX2H+SEdahOV1h
 g7MhlbKo9pH66oBsHr+WSTWoQwEL/DZB9hIUI5cTG/E/PRZKj35VPQeEEVdVc95f+Haiq71onYH
 oXtLr8h3mWz+xv6gvBUiwNqjmxFaBlo=
X-Proofpoint-ORIG-GUID: sXkTr9mY0aIJIoqTv-2L0KYQ6v30xWLQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMyBTYWx0ZWRfX1+s1Z8tTOGca
 1+kVKu2gwlmQ8lMiS/Rf461BLe6BPPnzBADt0RdK6JzlB+nr8ozCSBPMnKJqY5/AX9UIjM4XXyE
 6tn5CW0H3guLjW3pn1iGbPHsowlwhQcPAseph+wgmIOodLkK7ImnD3f//9N4X7qbV/Lyi7psPzN
 48YD6N6/wtq+z08sjyZmnsULrdx6tsGa/+Hos2svk1nI9MTSMq7kF/qa0zsS8YUKn6FOV5H3EF4
 t58bs9S+ay2DSzacYnIyglb0dvuHRBdIx5yQKPdjSXMx8QRQ2mACudmYR+qzGsDXFh/bOxov7Zy
 fkgQdXIu25agyf6+NB3Kwndtp5KyyW/9X/+OPhFDUsyGJGoFlZkjdskBnzJCPc/7oNe/3nz61ro
 RWxEgmdtTuGr3bfIB+YoXFa0PeF9R2+b3UiJhekq3EGhvI5M+2lEvu6EKLxGZADoGgRrtBPBF2A
 c7Sn3GFRhIZUQFg+cJg==
X-Authority-Analysis: v=2.4 cv=IY8Symqa c=1 sm=1 tr=0 ts=6abe1858 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=OOEZ26oYitUW5BF2feQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: sXkTr9mY0aIJIoqTv-2L0KYQ6v30xWLQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010033
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 1/10/26 03:47, Alistair Francis wrote:
> On Wed, 2026-09-30 at 19:45 +0200, Philippe Mathieu-Daudé wrote:
>> Use per-accelerator locals to make the differing conventions
>> explicit: TCG takes a MIP bitmask and value, KVM takes an IRQ
>> number and a level.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

Per 
https://lore.kernel.org/qemu-devel/19ec18d8-548e-469c-ad03-6d47380cb6dc@oss.qualcomm.com/:

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Alistair
> 
>> ---
>>   target/riscv/time_helper.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
>> index ede1a4c2a34..29bbebb96fc 100644
>> --- a/target/riscv/time_helper.c
>> +++ b/target/riscv/time_helper.c
>> @@ -25,18 +25,24 @@
>>   #include "system/kvm.h"
>>   #include "system/tcg.h"
>>   
>> -static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
>> +static void riscv_accel_set_irq(RISCVCPU *cpu,
>> +                                int irq_or_mask, int level_or_value)
>>   {
>>       if (kvm_enabled()) {
>> +        int irq = irq_or_mask;
>> +        int level = level_or_value;
>> +
>>           kvm_riscv_set_irq(cpu, irq, level);
>>       }
>>   
>>       if (tcg_enabled()) {
>> -        riscv_cpu_update_mip(&cpu->env, irq, level);
>> +        uint64_t mask = irq_or_mask;
>> +        uint64_t value = level_or_value;
>> +
>> +        riscv_cpu_update_mip(&cpu->env, mask, value);
>>       }
>>   }
>>   
>> -
>>   static void riscv_vstimer_cb(void *opaque)
>>   {
>>       RISCVCPU *cpu = opaque;


