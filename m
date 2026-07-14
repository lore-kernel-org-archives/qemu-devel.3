Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC04C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 00:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjR64-0002Qg-8I; Mon, 13 Jul 2026 20:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjR61-0002QV-6j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 20:34:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjR5z-0007xt-3H
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 20:34:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNn9l33033806
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JFJLnkb9VAkfFwUO8Ll6y8gQq95Fzt3AOtU4iAuP1gA=; b=NYsVPiRpuDJ3Yta9
 iOfTnDGZPkR6o24e+mOHy/rkZOlnwfjeez8jbq0lOGOngVhCkeQsWIPccXEkSfsx
 xXt+5kNq+p9ajV9Zsz5RLJmKlCodyO7/I1+SXNrVAaWsLudGTB8p57qYSSF2qke2
 T7KavQlKp+rk3hAM8Mz4FspPcznWcezr/DHX4QIv0WjetEhR8Z0ahxUJE0CRoSIk
 UNqJ/fzdFQR/JqlL7VsOfcHcRrU+wH3NAZJLmn/xxlsWehuCrFz057VJ0ASoDDtQ
 D2xalyXBaZCMd7cC9JMRvMQQwh1QPmrGkCcs7NQ7OwjVY6JJmbOG+VMQCf4Ik7w4
 PXzZDg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavu5h5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:33:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e55f0613cso409084385a.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783989235; x=1784594035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JFJLnkb9VAkfFwUO8Ll6y8gQq95Fzt3AOtU4iAuP1gA=;
 b=TMy/tfhkvE89cZpWsBcgo1AQUOkCJSELWvMm2fCVlpDTmO7X62RXrsLzTZW2TZ45FX
 jHvHcmFcX66ciAqwZ33PuIp9ccqesW2l5YVMlO7X1UCfwcgjRMiuk6uGBuRbm4B0rL5k
 OiUs1x/U8omfXYau69WgJ/sgd0He60Wz0pd5wuSSYU6W5uLuYwtW5fD55o445GP2pnom
 QkPdtki94A3u5VpE7mMCn69d4AdnCy0Y4d7KA6kZAd89BNRKYRT7fJJaC0ZnWQTr+c4D
 fQSqyyMM8J8JXPpQaWjtw4v91+TlumnBQEyR4Vh5317otP9yQ+FnIqKVNBU8GvKr0oa1
 BBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783989235; x=1784594035;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFJLnkb9VAkfFwUO8Ll6y8gQq95Fzt3AOtU4iAuP1gA=;
 b=gMrvfs0BdMb+6yoDZ2HLJuMi5MRn99uCzrkRuJjR99NRPPP7OSXJR2X0hjVEufLuVn
 kODNECXI7vhfcRqPc3zfO+lbPzYh/yDyd1HF9HppRlrkOmsxAbqRp+rQYvZdDF3VqmNz
 nEE37FWMjUZmdviKYqDF8nYaZFpDXJ2c0qhHu2FkVw68t9stUNdmwoxt3k85G6oXGtP4
 4ljDqvDQgc+lcnOgoatBPLzGRFcsIQUlTZnoypGm7dWNfuwQ1vMF+PGC+APLalYqtuL+
 bjipO8MqchGGfR3dHz5gry7IGE4B7GlhQHOFe6rAbroqEqQU8N385MXb5htsipkKLY7S
 9rXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZb05txJ25kR+SzaTw3lgUl8W9eKT+5Bs0Tt5IVm2bVZJEkFu6tIadP2QHLTSkLyTITmf7I4Q8XbvF@nongnu.org
X-Gm-Message-State: AOJu0Yx2z1M8BO14/m862XwAVLgOAhPfSfHeGX3UoPDAYMeLhZTJVHKz
 LmemahruDDOAwlxh0lxqtK6U8ySxY8Wbkzo4GEyddz2FPV1em10v2r+Jmwhbec/9lsZj5di+VOf
 DfZnfLo9sS4lFKzi2995MMrdKKzEQNq3eg6xV3+1eTS0pnkT+qgPDdFSgug==
X-Gm-Gg: AfdE7cmwm56v4ZV2XD5wreGOvLSYABaUfm4T9s14LDoiK+Y/PL08QUMujIe0NGeT/tJ
 6y8kd+iflNXtqBHEWQSTRqwaicJLauYfmtpu4FqzYXedtvVnlXKVR7Ik2CgGbWuBPfkfqFmIvmG
 61eymUEt3s6YMww1KsfsCnTf5zPd1/+761NiAYNzcmxqH2wd2k0fnVrsac670GjQ7KzU0pm0uvG
 VW9m8/+xiq/BY3+7A5GAWXvB6dKJe14XQpoNWISvFwh/K+JuljQk7v9NQHdSo8LYfPW47hgmoCf
 23tqvCIv/vMarcL11kj5UoEDwm4Fm/LUMjvhXMWexfKK+yVYpJ2W6B5b0swgL5GgOQ3BLm8og8d
 PqYVXasZa4Y8Tm44oeeHhhbmDcycaBqjb5m2gOml1SduarAOjnoTBotpmdgjDeBdLK4g8BfxdVe
 KO7E3askSGaEMJ3t0=
X-Received: by 2002:a05:620a:2952:b0:92f:196:2090 with SMTP id
 af79cd13be357-93086c24bfdmr27950685a.70.1783989235117; 
 Mon, 13 Jul 2026 17:33:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2952:b0:92f:196:2090 with SMTP id
 af79cd13be357-93086c24bfdmr27948685a.70.1783989234638; 
 Mon, 13 Jul 2026 17:33:54 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b4a082sm1219985485a.7.2026.07.13.17.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 17:33:53 -0700 (PDT)
Message-ID: <97c8894a-9c57-4173-bb61-e4e46e43ce7b@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 19:33:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/hexagon: raise SIGBUS on unaligned scalar
 stores
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Alessandro Di Federico <ale@rev.ng>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
 <20260709233436.3075100-3-brian.cain@oss.qualcomm.com>
 <e8e0fe2b-3aee-48d7-85d7-5829c9039588@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <e8e0fe2b-3aee-48d7-85d7-5829c9039588@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pqKlgTll4D_BlozeSqgLugz8CoJyL2DK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfXxW92nrfl5hP7
 YNUUA0YQLXNnooRT1Cmoz/wWn/YnDzi3FX2dv3jpYj+WXCgChrZq0dWNjHf3QdTg8nQIp8HO/+x
 rxm2MIYaNyYhkPbxDmSI7m+hWXzu8znMF5XuNLziL0gPN8moMdZ5zWxeXjDfWPvwpB+Fsauiu6c
 cxZXwp5ZpoMjo1A2rli3yBcIPhfophGnnOa+ykQa+kfHZamOZCCyGUFWHcYSw5V/EV+VFVBRyG3
 gh392qC03nPEW0tfsZMcBvoumEOJlL/oW9OV25rZPbnboSU18q+FdkxuvnnXg3JXX2680aJxokN
 tzF3G4OHSSiAHulnjskJBFrEi+KuI9sFqy3NXhqSVFzXQt3NlNeZgUyXl1zC2LFzeZaBtigKyGq
 1wj2B7fhpv8pt4+txMExdHgLKVOxIqVvaJ6D6wR1lyoREzmYbbsBs4Uir1LrhKRUr1vPsmDyw8j
 dAnjuHWBDuzhc7zsOkQ==
X-Proofpoint-ORIG-GUID: pqKlgTll4D_BlozeSqgLugz8CoJyL2DK
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a5583f4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=va8k1C0U7YLc5WF3qyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX183963zqqKoB
 V6Dw3LdTB7SzUNdmcXsqJx9uZIWuGn/B3gdNsqPS7f+j91W8RULe/GSvfW/bOF10p9X4dogl4qV
 ZuqZtoXehbCMp7+IQMgTLyNFG9IxuDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140004
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 7/10/2026 5:48 PM, Philippe Mathieu-Daudé wrote:
> Hi Brian,
>
> On 10/7/26 01:34, Brian Cain wrote:
>> hexagon-linux-user had no enforcement of alignment for scalar store
>> exceptions, and unaligned stores silently succeeded instead of raising
>> SIGBUS.
>>
>> Stores are logged rather than committed immediately, so both commit
>> paths need the fix.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/genptr.c    |  4 ++--
>>   target/hexagon/op_helper.c | 13 ++++++++++---
>>   target/hexagon/translate.c |  6 +++---
>>   3 files changed, 15 insertions(+), 8 deletions(-)
>
>
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index 125952aee59..3ce223caba3 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -95,19 +95,26 @@ static void commit_store(CPUHexagonState *env, 
>> int slot_num, uintptr_t ra)
>>   {
>>       uint32_t width = env->mem_log_stores[slot_num].width;
>>       target_ulong va = env->mem_log_stores[slot_num].va;
>> +    MemOpIdx oi;
>>         switch (width) {
>>       case 1:
>>           cpu_stb_data_ra(env, va, 
>> env->mem_log_stores[slot_num].data32, ra);
>>           break;
>>       case 2:
>> -        cpu_stw_le_data_ra(env, va, 
>> env->mem_log_stores[slot_num].data32, ra);
>> +        oi = make_memop_idx(MO_LEUW | MO_ALIGN,
>> +                            cpu_mmu_index(env_cpu(env), false));
>> +        cpu_stw_mmu(env, va, env->mem_log_stores[slot_num].data32, 
>> oi, ra);
>>           break;
>>       case 4:
>> -        cpu_stl_le_data_ra(env, va, 
>> env->mem_log_stores[slot_num].data32, ra);
>> +        oi = make_memop_idx(MO_LEUL | MO_ALIGN,
>> +                            cpu_mmu_index(env_cpu(env), false));
>> +        cpu_stl_mmu(env, va, env->mem_log_stores[slot_num].data32, 
>> oi, ra);
>>           break;
>>       case 8:
>> -        cpu_stq_le_data_ra(env, va, 
>> env->mem_log_stores[slot_num].data64, ra);
>> +        oi = make_memop_idx(MO_LEUQ | MO_ALIGN,
>> +                            cpu_mmu_index(env_cpu(env), false));
>> +        cpu_stq_mmu(env, va, env->mem_log_stores[slot_num].data64, 
>> oi, ra);
>>           break;
> Thanks for the API conversion :)
>
> Consider enabling TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API in
> configs/targets/ (I missed that when you merged the system emulation
> part).


TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API was in "target/hexagon: add 
build config for softmmu" (you indeed caught it ;).


-Brian


