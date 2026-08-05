Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E41C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrVuX-0000Qo-3k; Wed, 05 Aug 2026 03:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrVuV-0000QM-Lc
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 03:19:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrVuT-0002DT-Rv
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 03:19:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6755l67Q2009591
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 07:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vv5W4uORWn8JiEcjjH+hW5f3KJtdJwQYrYJ6+GQd/+o=; b=hoyvI24T6jHhHN27
 8z48BZadv/wGUVxt5r/UoQMkM9Uu36pSUQIX1MvcWyhjuf4Jx+wM4oox4UtEIyNr
 aIg6Lqb6uq6XbNxtYp+HrcscJQKPJLLNTsQlf4K9XCIgBlpBBrKOEa0MaGtVCO/F
 Hulcp07J8ySKUdiWpzkj1vX0/2NdOgOd0tCvthbXCbY9DNmmiP/HwgDBRYviShPS
 9bXE8y2EVaKjoZAyUxEM7q+y5nHrNbik+GVxCS5+2LO8a/T+SvTWxl2N5TPJIGVz
 gvM+d4ZmtTp1E16G/aeA8vDiw8dvQa9mJMe8kj5G6IF2aQ7mmsgcfW7IuMI6QiFD
 /S4UvA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3nb99n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 07:19:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0408254aso24078771cf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785914367; x=1786519167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vv5W4uORWn8JiEcjjH+hW5f3KJtdJwQYrYJ6+GQd/+o=;
 b=FhbFWxRT0JGUxutj+0axWmIol4AbaTGbwvMyZEaYZ06zLoIwDO42I+eS8iA5Izu1RF
 KfrLP7yJFfYYZwt10wccSx8hTroFfL5GOg4z93UW66B1NMEdLBgRnXl5P4aHRlqtVazC
 OcZq7Yjpk/5y/GPRBuazgNGQK/0VME4/xresGHZ+GUNxZBotLpfK5ixt+Yas/FLzaidc
 egDdtxRoe33qpXTPs8mTc+ZSn4zveAVBVQoV+FSvOrXFEDHsu0+VFkjZ0XjA5OiRVXeT
 B+zdpXMy3sXRzLd2z1gtnxxB87Qg34+zugMJtBV1IMOBGNbiBtJ2tXItUFZzJssQb3ea
 AGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785914367; x=1786519167;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vv5W4uORWn8JiEcjjH+hW5f3KJtdJwQYrYJ6+GQd/+o=;
 b=jjPXaVgwjUbJkLq0GIFFxmncCzZlMbGvBQixlBNhby++yEnQDJa9G6t4n9k5wtz8Vr
 4TEhEsWq+yQwlJSD5BIAf/E3H0twnZViQioZqumI8Yj8KAy86wzvLgSU0MPozuz6PtNO
 oXXFfxHEDxo7rXAVJhgtc+JmewmPs7WTb300Q/Jyt4Uibs7RTviZdLlZ1wcjHUT8+nqm
 81U4Q1378lGprF8KLVW8TsDZeK9tHnTe1mvN1Z5Wvfq4jJawwJZvSbr7AiGvqw05gzqm
 mtSUIBcJTSsKXpwK0kcKQ6JQzm+dmXPPa5YPAyaohMj+Dg9+a0cSRyBlDgzQzoLl1+ws
 STeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKKi+VHqzZhRNwEF4UXOD3P5hNmXtsCg2+ct3J/ygbWsGQOI3q8BV/e8cKC+dT2mDrwFNmF1Ftb948@nongnu.org
X-Gm-Message-State: AOJu0YyPnzPd2r6pPHR9O3368ZukbZItPs+7jTlzIlhSGJPFjYBZs2Nx
 1SlRjSL4uYRXWGx7rol6nbX3wBT8d8M8HTk1EFepOpxcjsbpIq+/DHZzqxxWCp1eExXowm8fuNU
 oBBDNzcIZFlHki4C8xF1B3wY/EgMx547+11c+zRlMSivJcF95Yrkn61V6zg==
X-Gm-Gg: AR+sD10ZsP5uMiFi7ZOlsUk7UQnf+AnwXlSQL2TrfeuRCqxWivPG1ogxBv7SmTdKH/5
 Cjv5UUBV8GIjBm+oBYPvKO3Wk9IBPfjfkS9xI/b/NxAZVANR87bw+LeGeRUYaPtNqkhF/TL1Di+
 CUQ8t0mXG7f2q/wgA9QgRqkg2ZlcTRZwzuHr4/vRLRPqrx65k+ae8td99UYTgtCvVlHWGHP9f08
 AHsxnOGGvkA25zs9z6mRP8iPj43fmhSN4//o+QBUEWDzRIujTimY4Fl2SMXMdrseJwXIGiGmMjo
 YsfBl7VhTYsm+9gpgSnxRM2cs4wZ0dDTSpGcH8J9WbwZ0yObXmP802L0BDERjjl8bYjkGVcHtoP
 vQppPFjVGiyoYAQXw0l7OxYc=
X-Received: by 2002:a05:622a:120b:b0:528:38b1:b550 with SMTP id
 d75a77b69052e-52cd35d83bemr116281871cf.16.1785914367046; 
 Wed, 05 Aug 2026 00:19:27 -0700 (PDT)
X-Received: by 2002:a05:622a:120b:b0:528:38b1:b550 with SMTP id
 d75a77b69052e-52cd35d83bemr116281681cf.16.1785914366559; 
 Wed, 05 Aug 2026 00:19:26 -0700 (PDT)
Received: from [192.168.0.138] ([79.127.134.40])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20363e72eesm85392766b.40.2026.08.05.00.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 00:19:24 -0700 (PDT)
Message-ID: <4c94cd7c-29a8-4f1e-a782-92a2f64245d4@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 09:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
To: Bibo Mao <maobibo@loongson.cn>, "Andrew S. Rightenburg"
 <andrew@rail5.org>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20260415111738.3264448-1-andrew@rail5.org>
 <a4fed950-ae06-8dac-256c-132747d3b6f6@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <a4fed950-ae06-8dac-256c-132747d3b6f6@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hQKH7yLiE_5LvLy4gAmW6HQWyNPPU9jj
X-Authority-Analysis: v=2.4 cv=EvjiaycA c=1 sm=1 tr=0 ts=6a72e3ff cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=RnzuLS2lm5rFgCC4SXpEFg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=0thqkKc0AAAA:8 a=7ppjm1ks52wXyuoBlpAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=0vtrCm8UNV7l5cI7sn_q:22
X-Proofpoint-GUID: hQKH7yLiE_5LvLy4gAmW6HQWyNPPU9jj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA1NiBTYWx0ZWRfX+awAfVjuSa2A
 l6VAdIhNZJyjszqY+DKCo5xJ/XZaGfZcyiMQ4RFG+65oz5RE+Ak8vop5GaNCSJdyZz1qabKwx70
 KDhHuxUlr6XfjF3s92u1SFU43vVXa7I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA1NiBTYWx0ZWRfX6p5b/U2U3Ym7
 L+9IsZ/CB/jbA110mAs/8C7ABRdLH+gqrCQy7AE0lvWpzJP+rLYBtrKqi11u41CYQiiA78MTRC6
 HGhDGZ74GdFwKqqwIEo7+djfeKpCeWvIWf9nok/gREETdMzI9tNCqi6OW4lZAryQfMA7wg3dB1s
 5Dh9paqlHqaAItagaMHSoH14vMUpmtSpFZ0VOojdTEcpMAQwqmoQ5MSJS6JDNyDeyYxdZYkI1rC
 WtHV6Y/KwSXlKOUimXqRyu8MITBakBJMrjx0K91R/KhM9VxODhGN0/g5kiimaVDDW9sqbmtVBHU
 4uykEPTl/zW3Ak+eUDqafZQejTBUU2zFOd0RdpjU6IocKPJkKvQJg6RSSp6IpFZcTNQzTEXgkuo
 pm6hw2Eu7fN01i7HVvD1tAPCmmnQF+GedAuKDpoYj5IyAZCwLwGMdSvoeu+lrdwA7PVseHseApL
 tjnksONLwGCsIstqmiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050056
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

On 2026-08-05 8:56, Bibo Mao wrote:
> applied to loongarch-next with small modification.
> 
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/ 
> csr_helper.c
> index 7dc33bc180..d8d54d81e0 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -103,9 +103,22 @@ target_ulong helper_csrwr_estat(CPULoongArchState 
> *env, target_ulong val)
>   {
>       CPUSysState *sys = env_sys(env);
>       int64_t old_v = sys->CSR_ESTAT;
> +    CPUState *cs = env_cpu(env);
> 
>       /* Only IS[1:0] can be written */
>       sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
> +    /*
> +     * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
> +     * Make sure the CPU interrupt request state tracks the pending bits,
> +     * matching the behavior of loongarch_cpu_set_irq().
> +     */
> +    bql_lock();
> +    if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    } else {
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +    }
> +    bql_unlock();
> 
>       return old_v;
>   }
> 
> On 2026/4/15 下午7:17, Andrew S. Rightenburg via qemu development wrote:
>> In TCG mode, helper_csrwr_estat() updates CSR.ESTAT.IS[1:0] (SWI0/SWI1)
>> when the guest writes CSR_ESTAT, but it did not update the CPU interrupt
>> request state. As a result, software interrupts could be observed as 
>> pending
>> in CSR.ESTAT while no interrupt exception was taken.
>>
>> Update CPU_INTERRUPT_HARD after modifying CSR_ESTAT, matching the 
>> behavior of
>> loongarch_cpu_set_irq(). The helper runs without the Big QEMU Lock 
>> (BQL), so
>> take the BQL while calling cpu_interrupt().

Eh I don't understand this justification about taking the BQL...

If we can not call loongarch_cpu_set_irq() directly, we should extract
the common code in a common method and re-use, not duplicate the same
code.

>>
>> Fixes: 5b1dedfe848b ("target/loongarch: Add LoongArch CSR instruction")
>> Reported-by: Andrew S. Rightenburg <andrew@rail5.org>
>> Signed-off-by: Andrew S. Rightenburg <andrew@rail5.org>
>> ---
>>   target/loongarch/tcg/csr_helper.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/ 
>> csr_helper.c
>> index cd35ca93c7..0a5ed52eb6 100644
>> --- a/target/loongarch/tcg/csr_helper.c
>> +++ b/target/loongarch/tcg/csr_helper.c
>> @@ -98,10 +98,22 @@ target_ulong helper_csrrd_msgir(CPULoongArchState 
>> *env)
>>   target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong 
>> val)
>>   {
>>       int64_t old_v = env->CSR_ESTAT;
>> +    CPUState *cs = env_cpu(env);
>>       /* Only IS[1:0] can be written */
>>       env->CSR_ESTAT = deposit64(env->CSR_ESTAT, 0, 2, val);
>> +    /*
>> +     * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
>> +     * Make sure the CPU interrupt request state tracks the pending 
>> bits,
>> +     * matching the behavior of loongarch_cpu_set_irq().
>> +     */
>> +    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
>> +        bql_lock();
>> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>> +        bql_unlock();
>> +    }
>> +
>>       return old_v;
>>   }
>>
> 
> 


