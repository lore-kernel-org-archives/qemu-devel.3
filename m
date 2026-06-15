Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2801CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBBY-00032W-6U; Mon, 15 Jun 2026 13:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBBW-00032I-F4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:33:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBBU-0001ee-Jd
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:33:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhPqY414052
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xM4njpu816Kk8ihPSUpwnKgF7IANWP5pi8s7fETfJro=; b=EhDvZ3RcuAy2/Az+
 YHhnsQwxzKjQbOF9i5TqFoJW85tJZ5j9gUHLEf3Egi5yfJGnegVrC9zqkvVAU3+Y
 QOGGVq7uImQrsGcMgQoQw+v9WMsuzPTgvDfZ2PGx02eW0Y4QBxln5w+ScY/Ifkcv
 nySq3eUB6dO1ia9QaMgf45z4b8Fh+21wdNKDCDbVucQA3lruQM4zwX1qguzA2d/N
 XLm+2/oOrLlMM4Lxku/z9joWvCtj+zyqWRUHE67LKPSLNwtlw/p70UuYCe+xlD5X
 clnPpjp1606/49KG+GStyM+Uz2LaDWicranptbUsQq+KYJVGKq+9fgcJWC6pfbQ1
 jP1VFQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter021v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:33:11 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso3789057c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781544790; x=1782149590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xM4njpu816Kk8ihPSUpwnKgF7IANWP5pi8s7fETfJro=;
 b=FZnVs25POInzqyIm8cS0WXoEKfN9pP76uw9VzcS3cvCglF204dXvFKiJ6v79pRqCvz
 Ik+hCUXOwSwU0ZQwuBQEvBKPq2c+JE4yRJUfeSsRIP5Q47q2S1F9pmZ/TmicNq2v4R1l
 kaV+55KPzy5HBH/PdnlW51W9nKkvATg6OMbEvx72L3VEDZUnreyDQq94CZ3wRmV5ZEw8
 BUD1AMe315ZLMpMgMJVLlKNpyurROx9wLsHH06ScbcPymyg5w8ZmpmVzIh28r89B7hDa
 1VdGqv5MGDOMgHRcb5EPUtk5f58cuktcgo7Or6kWMUiiYcvtwLFP0awlisSPxiIz2Iaj
 RUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781544790; x=1782149590;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xM4njpu816Kk8ihPSUpwnKgF7IANWP5pi8s7fETfJro=;
 b=QTrWX20lgdYe+ezb0dZ6inQb5Nn+VpCiQmWIgw1Xtfkx11g+mJNojotB+abS2mKvU9
 DYOJzMS3MfXUSiYRG8iZay0VLJoqI56So8Qc51y4IkaSKa5H+9p/6+tl8v05o93y+jCl
 bujd76rLRwsuT1l7JeJIW8a2OSWStVXeqoUw71i4312GBGNRBE+6Gd9MSrWlk+cgZNeA
 xKE7vtENB9WDdHhA4TLxGBGkqv6Y7UQHVfb6LBzVkcHHZ2kl0tzW+RAxUoRVbntn0lsT
 5sM2Y3icafaoJAf+xoWwAPkz1ykIEUKLjE7XfbxTieHFZTqdPSSJfg8iQV4rHwoPQooI
 tMcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/O6IF8tAz3TIbcThz4Ck+2P05C3n2M8uB25CGtPZ8sLbnZAq8oThKPk/eLUhlpMZAwr7oOO68OLyn6@nongnu.org
X-Gm-Message-State: AOJu0Yx2UmeSuWY6xbbD2ENNcxi4ZlQCphrRU6vaZy3qc3Bzh39llH5q
 PnSGCuJO5NJpI4bhk0g1cEwF/fK18dxAgmZNNTlRr8A/6glmuSuKtb7Soj/bOYo6MzcjVQiL5+i
 bnkr6JRHaBuwLyDSkdefpWQvH18la3mkIRPQZfKZhNeQ8T3tbKyrE0179gA==
X-Gm-Gg: Acq92OFdxCElq7VEjDTHka2WVXfgUCYcp6ALOV1FSaTtCE7jWu68hrpY1XMrLY/IP/w
 5a92tF/jOlJvgxUYobWK2NZ8UZxpkh72xcJ1lsAfEdJB4tvyWxzWfL7Xnh0nViDH/dTcqWbiFzW
 hYQIZHmWlHH/MTyTrZyP6z6Nzo5faNI6kv7iOMiKzeNuNHSkAB1Cghr9PJoCnPtUj3yAuU1asen
 pu/uUMu0Y35iH/EvYVvb5JZPXVeN7A3CPEMOepxHt0XyHCCZGq2KUdiKhEWDJBT7pycysM4Vqdo
 B8nyvuYDofA47/zbTn8/VTDynBypoXFdhysP2Nq6XkAVXV9+0MqmAMcq4SlXiVMgvhUgRrqKA/9
 D6PwOAPJyEtJOmlwKf7Z84+jJLgZZQJg2XJrRlYYdA1YeFLP/QCyCglIWFu2xs3qtyvWM8XdUIa
 dxZWiJ6onmOCfyWw==
X-Received: by 2002:a05:7022:2385:b0:133:3bb1:8d40 with SMTP id
 a92af1059eb24-13985ebce30mr25210c88.15.1781544789506; 
 Mon, 15 Jun 2026 10:33:09 -0700 (PDT)
X-Received: by 2002:a05:7022:2385:b0:133:3bb1:8d40 with SMTP id
 a92af1059eb24-13985ebce30mr25174c88.15.1781544788827; 
 Mon, 15 Jun 2026 10:33:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b9815a6sm11211003c88.15.2026.06.15.10.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 10:33:08 -0700 (PDT)
Message-ID: <f83f3823-c537-44e1-91f7-7a0c031ad7e8@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 10:33:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix AT_PHDR when program headers are
 relocated into their own segment
To: Helge Deller <deller@gmx.de>, valium007 <valium7171@gmail.com>,
 qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20260613152156.41147-1-valium7171@gmail.com>
 <7d65e071-ca12-4d48-88df-9ff08c70fa75@gmx.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7d65e071-ca12-4d48-88df-9ff08c70fa75@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mDj2r4ktew0qX9w5C7qvWzxeqv2CuA4G
X-Proofpoint-GUID: mDj2r4ktew0qX9w5C7qvWzxeqv2CuA4G
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a303757 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=loxuxTn8WkiU8bmny1UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX3WPr+hxj1Z7K
 f0AQTp9TFFxqaSAXH2c1T5lYMG4i6DNqRiDZy9fvWOdmiabZ+J9Nee3If6F5cXP3DI8Jzb/F9vb
 Jz0bU/vvr5Lkrpbtuk82yCYbP0F17zKqkx0X9//EnrRguX1RkLqtK5+Pdw3xiFM373hUJhCcOqS
 hwwoM9MT3EhXy3M5Y9JrOocziJ8l0por7ERt9ykxJmYcs+opyI61M0reP1vgk8tRcZNnXpthBxH
 +jZfAv9jUwjhivgqYJsNoY/9b/Swnoqet3gSSMlHfyT1VyaALk5CX2PR0BtfRWitBfKTCpzR94B
 wvRfqMCtWE86n/3lAMOdy6sGwomzOh0LPQ7YSQJB+Z/meW1mhxgZnpd9VsJQK/pwTv0UT1SItw2
 teaULY3BdRHgbksn028PUwnFbnxNWa7gRs1qZLQUitxIr39T2yccRQ3ShmETyM6ayqufc/bB7HO
 J7nemfGKElcd7vCgg7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX7GuZCua05Wro
 LBcJtNUNXO5wjhmq/hX29983WQI++m49ZDkEhz1SSjIPdfxYWiYDl6f/TUzh0eTYIc8nO3S89GC
 LLkSpWixZkjTUF6E23Azv6pRuoYEFsU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150186
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 6/15/2026 9:06 AM, Helge Deller wrote:
> On 6/13/26 17:21, valium007 wrote:
>> When a binary is patched or relocated such that the program header
>> table is
>> moved into a separate PT_LOAD segment 
> 
> How relevant is this? How/why does it happen?
>

Maybe a tcg test could be provided to show how it can be reproduced, and
check this patch fixes the problem.

>> (rather than sitting at the start of the
>> first loadable segment), QEMU's AT_PHDR auxv entry becomes incorrect. The
>> loader was computing AT_PHDR as load_addr + e_phoff, which assumes the
>> headers
>> are mapped 1:1 from file offset 0. This breaks when the headers are
>> elsewhere.
>>
>> The Linux kernel instead locates the PT_LOAD segment that contains
>> e_phoff,
>> then computes the in-memory address as p_vaddr + (e_phoff - p_offset).
>> This
>> correctly handles relocated headers.
> 
> Ok, I need to check on this.
>  
>> Fix by:
>> 1. Add phdr_addr field to image_info to cache the resolved address.
>> 2. Initialize to load_addr + e_phoff (fallback for headers outside any
>> PT_LOAD).
>> 3. In the PT_LOAD mapping loop, detect if the segment contains e_phoff
>> and
>>     override with the segment-relative address.
>> 4. Use info->phdr_addr for AT_PHDR instead of the incorrect formula.
>>
>> Signed-off-by: valium007 <valium7171@gmail.com>
> 
> Can you sign with a real name?
> 
> Helge
> 
>> ---
>>   linux-user/elfload.c | 21 ++++++++++++++++++++-
>>   linux-user/qemu.h    |  1 +
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index b05b8b0..8049c8a 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -699,7 +699,7 @@ static abi_ulong create_elf_tables(abi_ulong p,
>> int argc, int envc,
>>       /* There must be exactly DLINFO_ITEMS entries here, or the assert
>>        * on info->auxv_len will trigger.
>>        */
>> -    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
>> +    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->phdr_addr));
>>       NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
>>       NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
>>       NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
>> @@ -1469,6 +1469,12 @@ static void load_elf_image(const char
>> *image_name, const ImageSource *src,
>>       info->data_offset = load_bias;
>>       info->load_addr = load_addr;
>>       info->entry = ehdr->e_entry + load_bias;
>> +    /*
>> +     * Fallback for AT_PHDR if the program headers do not fall within
>> +     * any PT_LOAD segment (see the loop below, which overrides this
>> with
>> +     * the correct in-memory address when a containing segment is
>> found).
>> +     */
>> +    info->phdr_addr = load_addr + ehdr->e_phoff;
>>       info->start_code = -1;
>>       info->end_code = 0;
>>       info->start_data = -1;
>> @@ -1523,6 +1529,19 @@ static void load_elf_image(const char
>> *image_name, const ImageSource *src,
>>               vaddr_ef = vaddr + eppnt->p_filesz;
>>               vaddr_em = vaddr + eppnt->p_memsz;
>>   +            /*
>> +             * If this segment contains the program headers, record
>> their
>> +             * in-memory address for AT_PHDR. This matches the
>> kernel, which
>> +             * locates the headers via the containing PT_LOAD rather
>> than
>> +             * assuming load_addr + e_phoff (false when the phdrs are
>> not
>> +             * mapped 1:1 from file offset 0, e.g. relocated into
>> their own
>> +             * segment by a binary patcher).
>> +             */
>> +            if (eppnt->p_offset <= ehdr->e_phoff &&
>> +                ehdr->e_phoff < eppnt->p_offset + eppnt->p_filesz) {
>> +                info->phdr_addr = vaddr + (ehdr->e_phoff - eppnt-
>> >p_offset);
>> +            }
>> +
>>               /*
>>                * Some segments may be completely empty, with a non-
>> zero p_memsz
>>                * but no backing file segment.
>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>> index 07fe801..2268493 100644
>> --- a/linux-user/qemu.h
>> +++ b/linux-user/qemu.h
>> @@ -26,6 +26,7 @@
>>   struct image_info {
>>           abi_ulong       load_bias;
>>           abi_ulong       load_addr;
>> +        abi_ulong       phdr_addr;
>>           abi_ulong       start_code;
>>           abi_ulong       end_code;
>>           abi_ulong       start_data;
> 


