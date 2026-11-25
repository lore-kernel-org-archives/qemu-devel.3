Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19861606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T1PrfI+c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dLf54gQl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW9JD-0007dq-IN; Wed, 25 Nov 2026 04:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9JA-0007dg-V3
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:28:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xW9J8-0007Mp-0w
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:28:56 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9Cn9L2039197
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I4WluNbE0jRYto2+VfXhihIGY3q3Pj+y9C/rcZDoNy4=; b=T1PrfI+cOJL9Uou8
 tjMXs87f4e1o3UMC/ICDSxooDjVJfeEoX1PEVpidZGPPR4KzH1yJaaiSdWF5Mn3i
 xVHS6IfY+d+qM/KLL9xGew5ZthyTqZhQcaKfb38OqRX8R64yOKLYV5Olx3hWgr4D
 GoURHuX0RQXJ9LZBwWM3xp87ktXCqSMZs6nHxiIq/S4aQfzQaK7+L2WFyCJDfVkB
 erRAQgor9bCN1Ta9qhTiSqh2A99nRDf9K6fjHBEch7JYipigP10+SJfWuk7VpFHo
 lro7wez/po2XZO0yhnTVR8HNZx2L/Q1UhsL8j3Q7L3EwpZ8J5oMFFWpizrx0CAYX
 M7Ukwg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vukr3e7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:28:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9495a1f5e47so866924285a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795598932; x=1796203732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I4WluNbE0jRYto2+VfXhihIGY3q3Pj+y9C/rcZDoNy4=;
 b=dLf54gQlVBZsLKnBMk6e/Qi4Ic/vaw+Ow+i/zUrybwwNb0vPPFp9uiwe7uaHTRlfsa
 f0+wR5ASOBZ4d+7bOO9XhTsDF1gnxYsOUKfi4f6kjDqxAGzoryFvq0BgkomZuxZib1v1
 +c2KZgRjYImozQpS5+PCJU7f3EuDxn/FiC9xJ3xUNjNFM4ICIzHvJoCf+sy7y8I60n3q
 dlZKFFjvad3yUxOBKb8+mdP5wg2VfYS6EjwyJN+4asxTh+D4hS6q/ZWyrehAhx2G+ZLf
 DAo+HNXhVr+bnCwHxrYDVEoPschU+HnBCkfMmuB9F5cq0wwe/Z3uL9gcqXDa3bsYHCRD
 5chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795598932; x=1796203732;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I4WluNbE0jRYto2+VfXhihIGY3q3Pj+y9C/rcZDoNy4=;
 b=qN9QyzB+BAPCwpT9cLcQYry6DhZAT87CRdexeyeuYWViQcXwtv2HqH3pEdOE4wv2mt
 3ok03r1B3FX8/ySS4maDnAulPSLtsPIjHTS4pLV7yHV8px5S2Hlnk9Kg4xDfEI2jwAT2
 kclNMORrYrd+/R2AOkiiW8CPwrPYVY+9wbd4vFuSUtiqjtpEdakpYV4dmekp6uYlBtJV
 YFJ5Su/uQdf+VTix5hH2+CC5DMIisZVlwF6OSc2pwWKYAEZlG0c6Kl2i34jjEgYJpewj
 HnusMYmdQlShrMTLthRiwA+eo3JmwyfZjTculNWG+Os+5ahfdNC0WpFzZ2jNK/HD7J+Z
 BXvA==
X-Forwarded-Encrypted: i=1;
 AL+hErFkIxsEN/I6nwCeQSL7JCQ1tWVx3yzT9gh+ne3t+mia3/fE6xROZYY39JmF/dy4hiD0s6ydIlfu4vQJ@nongnu.org
X-Gm-Message-State: APuU4Z/oi+aMlo21xLK3lB0OE0wdBAjDBByt9fE2xaH5psOw5/vg1urR
 q1+j3tWi1Oknwnvlw5WgM6RBoobo7Y1HB5d/yoylMjabTTg4SzK1eEuQD9Jcn/DV3RjkpbT9LxL
 VdKznkRoQaIfcW9NQghYpzZsu0KINHFuQeuh14aDf2WIKqLCCs4Ju1rdSIQ==
X-Gm-Gg: AZFdTZfn8XvGWANHcNqpiiE3ziTg9vtkFEaJ3CoSL+NE9mqn80LtS/1xgMO4pylns7v
 uTsP5/t9ZVMwvEEmubtdXvORqIeX9+xs5GgrmbN0xf97f43Rbu/m9SacSuBD4bmanEMNud7xydK
 4794+QwQkh3QP20w/FdRj5BVDXRwlpkQc0R9fe5gHR9Ew2+s81o3izRMH3jIhSXrumpfXaQxlNT
 pNp6GZOgot569wwLnucACTXMaKsepQMWK2N35qygKasvkMhg2C7H7YmP4S9tqUNU+VXBYOYnakb
 gHPuVhEn7KnjPiyeKGMPCtgdFmRFhY6ZjqaZFTMYLB9atdkNCbeBa/vtOBCUXwb81PqUUlrRys+
 phU93rP/KNScI8jIsTtMBK/HIIxWIkM9FY/HNSy17VxP175RD3wnDAQ9iHyCNLwfEY9WL8q4UuT
 qt5f2nbXM=
X-Received: by 2002:a05:620a:4008:b0:949:72f0:cc12 with SMTP id
 af79cd13be357-949baa151a2mr3257338385a.64.1795598931745; 
 Wed, 25 Nov 2026 01:28:51 -0800 (PST)
X-Received: by 2002:a05:620a:4008:b0:949:72f0:cc12 with SMTP id
 af79cd13be357-949baa151a2mr3257334985a.64.1795598931248; 
 Wed, 25 Nov 2026 01:28:51 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm32686213f8f.49.2026.11.25.01.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 01:28:50 -0800 (PST)
Message-ID: <1bdfc992-1991-40a3-aba3-c7232a729bbd@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 10:28:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
 <dedd71fe-044a-43e0-a968-b1ca0566d0e7@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <dedd71fe-044a-43e0-a968-b1ca0566d0e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KfVHIgYD c=1 sm=1 tr=0 ts=6b06aa54 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=eDDFyTeRAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=ebC4ZMxUUoTH1bodX7kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=xu_OM7uD2k7YPmAm5WZD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EvjhOSBJymFHWV-vabe9-NS1lB__Ieeh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfX47NOEhRU3fA4
 mpDDi/hGxSFvQXvAPLMTCqgpsv85ipPjpftw6Z5SD5wX8ys80IV6vAlYWPNo1XL41L1ZVP15P5o
 jLF1OQYEMTCp9yf5NzDjSwOL0Awf5eY=
X-Proofpoint-GUID: EvjhOSBJymFHWV-vabe9-NS1lB__Ieeh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfX8v7HinZ2gtST
 gFYrWLsCUZ++89JE/rOj78muQQS79g+KW+MJmftn4Qvk5fEQnnJ5KpXwQ5SSOC9QQ3fcvzUJeAx
 rZDDRW0bxEf/Q7+XvK/wpr4Q6DyLxc0e4QfIP3Yeuf9nI1AIrodXgUBY8qKgWGwCpySHQcA2b70
 ZhgiSWI3OBTiwZrIhFPFB0Z6145DaId4VJ0T7j6A996e9zM7wc1dW5wnQG1R5+uqi1GJ4aNK1yp
 xofil1tSMegumgeHlRFDobMzhJSf6Rw+KRgAYJybSuFR8aWat8XZSoPjqG7a+Y9C3FOrfLxF7nA
 u8tglD5CSy9pYsooyj5+GiWlynsdYMVoFIeTIV/nCBggS2BEP2prZh8pBYHXm2CRURWeUfXdXuJ
 oRku2poRkv2Ixr9bZ0UELtYd2houoZvly2Sy3yh3egrECNbCMRMhNUZaiPEkHdrY0dqFeZlIS0f
 Sp8YmyYzK/AIlRbV0ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250037
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/26 01:23, Richard Henderson wrote:
> On 11/24/26 10:27, Philippe Mathieu-Daudé wrote:
>> A ROM device changes its contents with direct stores while in MMIO
>> mode. TCG does not see these stores, so translated blocks built from
>> the old contents survive the switch back to ROMD mode and the guest
>> executes stale code.
>>
>> Make memory_region_rom_device_set_romd() drop the TBs of the whole
>> region on both transitions: before leaving ROMD mode (if currently
>> in it), and after entering ROMD mode, for TBs another vCPU built
>> before its TLB was flushed.
>>
>> Measured with a guest that repeatedly leaves and re-enters read-array
>> mode on a pflash, once with no code cached from the flash, and once
>> with a function in the flash called after every read-array transition.
>> The flush is almost free where code isn't cached in flash, and costs
>> about one retranslation per cycle when it is.
>>
>> The pflash models are the only callers of this function. Other ROM
>> devices (nrf51_nvm, amigaone) flush from their own write callbacks.
>>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Elliot Berman <eberman@anduril.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   include/system/memory.h |  3 +++
>>   system/memory.c         | 14 +++++++++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index 027ca81bd2e1..8dbe37e60ad5 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -1959,6 +1959,9 @@ void memory_region_set_nonvolatile(MemoryRegion 
>> *mr, bool nonvolatile);
>>    * device is mapped to guest memory and satisfies read access directly.
>>    * When in MMIO mode, reads are forwarded to the #MemoryRegion.read 
>> function.
>>    * Writes are always handled by the #MemoryRegion.write function.
>> + * Switching to MMIO mode when currently in ROMD mode, and switching 
>> to ROMD
>> + * mode, both drop the translated blocks of the whole region, so the 
>> device
>> + * may modify its contents while in MMIO mode.
>>    *
>>    * @mr: the memory region to be updated
>>    * @romd_mode: %true to put the region into ROMD mode
>> diff --git a/system/memory.c b/system/memory.c
>> index 56c5dd6c8abd..f01470993914 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2249,7 +2249,8 @@ void memory_region_set_nonvolatile(MemoryRegion 
>> *mr, bool nonvolatile)
>>       }
>>   }
>> -void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
>> +static void memory_region_rom_device_set_romd_mode(MemoryRegion *mr,
>> +                                                   bool romd_mode)
>>   {
>>       if (mr->romd_mode != romd_mode) {
> 
> Surely push all of the new stuff below into/below this test,
> where nothing happens if mode doesn't change.

Less convoluted, thanks!

