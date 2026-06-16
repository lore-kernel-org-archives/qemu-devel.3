Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7072CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 01:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZIss-0004Ot-Ni; Mon, 15 Jun 2026 21:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZIsr-0004Og-9O
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:46:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZIsp-0002jr-Fn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:46:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0OKuA1915255
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WCpfTpZCMaKXrJc+cdGdpHbppd4H5ZvMk7VeVD4mOMI=; b=dA7N6gvNRegoXtXo
 bNCqfbjCIqCOrOhDIcVaRPX+wlLgfuiYvI5x1DVh3Wc+yu6hrg3LyzNzTLyl7JZ3
 XPOlHa1ucCgUtbmNjfNqYFwaEF8rWA/Aa/J8v22Fcunckjm9Hl+WFZoYR4Bx6Pcy
 oKXMzVYgPBa7NM72A4kZfK0TcBr2rWASpVRGKlBN7cUpqg2yJmIt/DKbH8J0TLEX
 7d6oAe6fl92pxtEgInCupVBD1vi5Y6rKDeU1h5f90YJdbUENkVduHTh/BrC31+iX
 CUDmE8CNL4MkVIgMuA2SuHGHCf7zIJ0NLgKrKmV9dTkwkBW3PrOyWVbLPb2qPyxS
 O8V3sQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx41ak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:46:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915c1997732so857039285a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 18:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781574389; x=1782179189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WCpfTpZCMaKXrJc+cdGdpHbppd4H5ZvMk7VeVD4mOMI=;
 b=YgSpbHCMc+griv0MuUBiIV5jwGLVCusqaXmLvNEi++dzNrFJVMJ6XRgybHRAiejkvk
 q2z0cDcchbBvS8zC684Em9/tRK2D1uL8K/12nf9WSHkdnvzDdkp/ncS0GExv0XeYCbbJ
 dc/mYiIn8ONWsMTVbmRz3lHVJkpDv+l/RTs917reoq8QTkTrnZE1k6/P8evyEqWcpU5N
 z7XaUe+EmB2ST4dL/V9H6KY6kBnjrf+L6Ad9tYgfmwoo3IGYu3SKXgqcRv6jXDfMDgm6
 hbnxuKaMxnGI/p+N0EEV9cHMmT6KtzSEizU7xW8rf9AwiWvL0D3nJi2lU8zMnJiOjzZa
 1LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781574389; x=1782179189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WCpfTpZCMaKXrJc+cdGdpHbppd4H5ZvMk7VeVD4mOMI=;
 b=AqbvucrA7HP1+6vdlOSnGLYMpklwwJQJ2F3eQV6SMFSvxvyiC/9s3QXoyEda6ct+6s
 DBYbEaMmJafe1U6L8zwcWKNqMp4Vw/ytUJ8+tAyIA1pphSXU463iiqC5TH7TprfRl1ts
 VadsNwX1AHXRuuJALI/lS7ZAKR8ctqqOiuON5xOT1gPnD9qDqA7vWmhNlguGDuv6V1E+
 JsWpdT58+0X8q9173cUt0kIOtJTIuwW4ADMmqRBWSf1+Yx3D7Moksr6lSkX5vD+W4mpV
 N1rA4vJRq3UskMlQpit6sbnrplyoHQ7sUC6QbWvFWw4ZaXjlF0M5LexSMd9bt1kp3K+C
 t0JA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XxtkfArRkQxn8tRd8TEfojRWaNuGhpubeJfRwyANj7bSw6AcxrRd1XrBveAWi88c5tWcKR64Xur8v@nongnu.org
X-Gm-Message-State: AOJu0YwsqcquU61pVbalot5hjjlOPYYTCQ0PnPktGe42RGYdzLodPrtu
 93hDmEnqladLtxN6SvZ+wz2rJWqbV4PAotfmlzUbv3VTiG5T5DUUduXQtxno+vz246Ykt7ooacu
 o5VMZl7y28hzjmy2IINgqlahiG1Bxz748G9S9f27EzLlHOzDl9v/G9ovviA==
X-Gm-Gg: Acq92OHtf0wi2+Wdl33BXkEq731prwsi2wFy7vNcuNFiHnhtMP30ftQ6JpQWP+TXWuP
 Gei/V11h0TtsTqJMq5QgG50wsLge+BW+nDOOuREcof6Dzt8sAvC3B5RjKrWzx909tO74QpmtIsk
 dcsBsotvM/NXxU365EZ7VhdJCXzGwLmQAAIHHjkY12Xx8CejU1TKh6gInsL6nEa4/E8G7vuqHyx
 MgSH3DFC3pQKOnwEM9nwfBJ9hCD9OyQyxyFWtN7ZZ4IRZ6dNxE9U3D7bZgqLHVTg0tJlmC91uhT
 GqbtBy+dkJm9MVyfmsOjsed1aWD778WEjp39iQknDVT6OdZ6/F09Vpm0Yor1ood63o8M2NVZ9p2
 b+EjxD68dU3v2EJW/79D25nmHIYFpSPSvlcedCLTMV2zYhLOwAf2hOTK2irrwNhI+pz73vJpF
X-Received: by 2002:a05:620a:4156:b0:915:6bfc:8e93 with SMTP id
 af79cd13be357-91c468c76b0mr269744385a.15.1781574388849; 
 Mon, 15 Jun 2026 18:46:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4156:b0:915:6bfc:8e93 with SMTP id
 af79cd13be357-91c468c76b0mr269741585a.15.1781574388444; 
 Mon, 15 Jun 2026 18:46:28 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a8eb30sm12914035e9.10.2026.06.15.18.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 18:46:27 -0700 (PDT)
Message-ID: <5da25555-76bf-412f-adfa-d5d99dd6b47d@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 03:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] accel/kvm: Replace legacy cpu_physical_memory_write()
 call
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
 <20260611180320.30320-3-philmd@oss.qualcomm.com>
 <803df8f4-8b24-48e2-b3ff-3e30be677d5e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <803df8f4-8b24-48e2-b3ff-3e30be677d5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SQaWBrIGU89xk-43WajITk1cIgOBV6g-
X-Proofpoint-GUID: SQaWBrIGU89xk-43WajITk1cIgOBV6g-
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a30aaf5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=a0W9dbyPv3PxTJVfJvAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxNCBTYWx0ZWRfX1wyYcbOTZMim
 2/lnkqNcfcZwbY6ZuCrvAhuzGnlxB70o+u4h3VjPkoiRv2F/lDjKl19/AzgQU64WTco4L1O+k9C
 E4zt/UVnixG4MNsLxLCVxn5l7wIScT8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxNCBTYWx0ZWRfX72kAoj3budMs
 7F/wwFvdiirDyw7RBNXJBo8js10zaLrYkO1ukVeD2/HeBn+SEAJFWsnOYunuuaJ4Id9H1+0+jC8
 6A12WxXeT5gCHFKmIw/m872Lko68QGWBNQPIw1KndCYOQjbVFabBasCKzOzh9lAPNOkkvQ3yrmX
 bScN2zvmeq0VI45RXSdCDzu1raSikMzvHUwjAZLVPRvEbZb1EUmbhS7XcQaiEr7esibYNfoC60p
 2nwMFA+F0A0Mt++HEvT5iqGVI3v1qIsnQQKrfw/COq3P2YsUsbEAjdg4p2A/CZygdYtA9xnlLlr
 EDAaOlw/nXfTptQvIcO1bT8aL28cWKdlAHPHOmhvFX+CCXzxTNOnuOCFvWy9WuXZltUlKM6kkN0
 l4QTFAUkVoOhr7z9wGhbtS/KDbVnlWedg4fUegoSUCjyq/Nptnb0Nn8z/z7UKMeY34/vXk9dftF
 839/3Js6WDFS3LABlsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160014
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

On 15/6/26 20:39, Richard Henderson wrote:
> On 6/11/26 11:03, Philippe Mathieu-Daudé wrote:
>> cpu_physical_memory_write() is legacy (see commit b7ecba0f6f6),
>> replace it by address_space_write(). Both if() ladders only
>> differ in the address space argument: rework to have a single
>> address_space_write() call. No logical change intended.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>> Cc: kvm@vger.kernel.org
>> ---
>>   accel/kvm/kvm-all.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 96f90ebb240..f4f0e64fbd0 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -3178,16 +3178,12 @@ void kvm_flush_coalesced_mmio_buffer(void)
>>           struct kvm_coalesced_mmio_ring *ring = s->coalesced_mmio_ring;
>>           while (ring->first != ring->last) {
>>               struct kvm_coalesced_mmio *ent;
>> +            const AddressSpace *as;
> 
> 
> Really const?  This doesn't look like it should compile, since 
> address_space_write doesn't use const.

Ah sorry, I'm still based locally on this previous series:
https://lore.kernel.org/qemu-devel/20260319191017.12636-1-philmd@linaro.org/

> 
> 
> r~
> 
>>               ent = &ring->coalesced_mmio[ring->first];
>> -
>> -            if (ent->pio == 1) {
>> -                address_space_write(&address_space_io, ent->phys_addr,
>> -                                    MEMTXATTRS_UNSPECIFIED, ent->data,
>> -                                    ent->len);
>> -            } else {
>> -                cpu_physical_memory_write(ent->phys_addr, ent->data, 
>> ent->len);
>> -            }
>> +            as = ent->pio == 1 ? &address_space_io : 
>> &address_space_memory;
>> +            address_space_write(as, ent->phys_addr, 
>> MEMTXATTRS_UNSPECIFIED,
>> +                                ent->data, ent->len);
>>               smp_wmb();
>>               ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
>>           }
> 


