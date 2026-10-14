Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A9CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqTd-0006Xx-3a; Wed, 14 Oct 2026 00:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGqTb-0006Wp-Mn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:20:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGqTa-0005M5-1k
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:20:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLJfow1402910
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tklSDQJXTrPH3GoYFCCnVCv66lnsDuylGwVQ1zUnGh4=; b=Pf5U/T23zcMi8KPc
 74xfZdX7bhxCXqslsgLN3lZfdYE3Upeg4sKJ+DAj3QzyEWppv1F85wsZD+QeI+CO
 Y9caD2roN8poAQ/mH+nj8jOBeOFlf5Kd5isGVz69Jzrz7Z0qlpZAWSIbUqpjHACM
 5fGUH+Vt8u3/l+CsQfRc3in3iY1ZbRVvTCLHWlWDLdBW1A0bQcT0xZUE+px7qDHN
 F1Vd7EbE/YS9kvmne+NcY+dfqZv/wyzZVCcMgGHCOgg/c8VtA1XVWEATVyazINo0
 ZBZQd05icsKoizTMMKFGu0uhjfQ87Lvu0ZNpTpETuBATc1na71ZgjtaQ2bHlML82
 j2EGdA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk304x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:20:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cbf2fd504so649809485a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791951624; x=1792556424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tklSDQJXTrPH3GoYFCCnVCv66lnsDuylGwVQ1zUnGh4=;
 b=PMn1Q6Ioxw0jrFdqEDQaJ8qslGhf+ympzVodMZFubpklMbxnuYd0Mf/3v2RNbAm4zm
 igSynOlJI1kpiyVJcNF33Kuxt8+gSz7eUZumrykKQk9v7d7HxXOeUWvUR1yrDWuqPUDG
 4E2LyxBssfnOG3Y3v4FEsVz3A+bE/1/r1zTciNFQSc1AfqAsmfUP8/TFyXf9Sq+W20IF
 b5lWuehDIeW/lKIBFhnpKL5k5pLu3ua9hH6bl/XJT3X17S0ByimGEp0uN/rI3nYhXU2P
 QZDTfidVTiAqrm4aHWt+4ts31iPeb75iSq+swBefQnmX0H43Cck3ep9dF6hJvnUqLMhl
 JArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791951624; x=1792556424;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tklSDQJXTrPH3GoYFCCnVCv66lnsDuylGwVQ1zUnGh4=;
 b=OVk9Qnc7DZFmh8sIG9lriYU3paH9Q27bM78H/qj2dcC8M4XNA8r4tr4CuFGYft8iOb
 4pKKHOeJy7iyoG4QPX1no3tEpL5QLspu9BBRrNP3t7D9FyuY7Mhg621jlHfzPuL8lWyl
 3LyQB6oD/SPyr70awDdcJp3JyPr9e5/Kl7DGAXcbzR1iQfNCF8oGm6IPOVNf1OHV6dY0
 EuaQhRRF0hV5zD5ll5aJfkJ3s/YNjKTJyTE1q06qgyx6Jva2sq99D70AocBJV2pYz5rk
 I+w86oP7AUOHri4ATL3z5zvrbdEokEAA8AAKmWWCtqmtlYmZUNKPvl3omc4otZFISmB7
 cwgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfa/yXGPoQI9rl0NJ6HqCZTPCoDqJuXjXZqH4HOjGXqnD7ZNhr5Cv6Taj+4wd4qKSPiGQMr6yTNStx@nongnu.org
X-Gm-Message-State: AFq9FYIcrnU49Tn3URANRzSymKMWLCslVIN8fyz6doMblRGIAw0pfqd6
 zy2i87NM6sSkqy/VmAxHK8/PesdhrjRxAJAaXoeFRsi3gvaQvtwZV14f3A+8ME6iyRc7sx/Scsj
 OsX+S5L+GHEgOIdyPfq8fYG6VCDJThOinoOuo3YwaG7Pvu3S3L+vMBNUwFg==
X-Gm-Gg: AYBFou37TPQkht/ZBKqe8stmdwkxtKstFylZaHsiGRxS6BURXY//bMMO50pSLTNJzyV
 tuOQ4G3brDzdvxShrE+/cqbKFolBpBFYVfNKWFpffAapHecAeQHRAP53rWobwcHDIqtTALugsCj
 BW1DrnIEJK/Eid862B/iL1IqcTLFHXhs1wMh9Z6LHhG3ZYk4HRpmrBoE4SG7L+dLoLlweK8IOfs
 Lc1xn0qYNweDWcVbIx/8KWVV+EG2r+sdTq3miY/dNYE/icrgmxCvQjFIHTuvs2KfHYQ6q8YyvSf
 +ULZBIgW78sb1lGLrorflzm5JbtmbooWyNuQrqYtzRuO+ybczeWC5RbJJXwib1MOVC/+P1nv2Uo
 UMATrcgOGz8K000Ues2tPXXug+Wd5AtRCbg==
X-Received: by 2002:a05:620a:44c7:b0:93f:5ac:14a2 with SMTP id
 af79cd13be357-93f05ac16a5mr69493285a.74.1791951623952; 
 Tue, 13 Oct 2026 21:20:23 -0700 (PDT)
X-Received: by 2002:a05:620a:44c7:b0:93f:5ac:14a2 with SMTP id
 af79cd13be357-93f05ac16a5mr69490685a.74.1791951623437; 
 Tue, 13 Oct 2026 21:20:23 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf3e044sm398513875e9.14.2026.10.13.21.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:20:21 -0700 (PDT)
Message-ID: <8e5878c7-3cf5-4141-8786-c180425608a1@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 06:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/hexagon: halt on tlblock when the TLB lock is
 contended
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-5-brian.cain@oss.qualcomm.com>
 <5b415e5b-8d35-4f4b-a5c3-09ae631e6670@oss.qualcomm.com>
 <a2a1e47c-b92d-4ae6-9376-ef6fd14a0d99@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <a2a1e47c-b92d-4ae6-9376-ef6fd14a0d99@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v4SWikGRAki8lGOvfgw53rwXMFaEZvyn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX1M7QTSoI+jOX
 /kj6U5BaaEvRbYp1EZ4ExipP5UpricYoFIoziB1awWNgO4R3+RWs/9JLBTBX5X23g4TIvUO3dZQ
 5LkQjUAkQ7gER0XwIiD2RUhJicEsaYw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX4PUjqZ533qva
 s4RdKDBOUTlsTr0OspKY2tO92Qc891wwGBjJfW9CfFt4+gWBv5Ss0K3EU9AzPWORf0/ToV3OPj/
 K+qGErck1NhT26ENIORVKuKIRwD7+ClapfQK1V5xddvJOK/z2j0jZGq0rrJSzVSfACiurjhJKA/
 m5i10lJNuH2KWGF7EeKmoi9ua9zRCq1CJbJ9dszFz59uQroS6eYN1S0/1SldPy5u5dgMdWYXEMN
 pFhIXMyt4gPgYx9Emx0V9diADHRtnufp5ouST1W3YJme0EGZf4EtV+anhUQY68WdCt/a13n9PQA
 57E2LlrNfVhVABCkeHKFUGxp+53Kb703/e/lOF2qXz18ivPJr+wANadq4aRRS9aNVcnHw98Ebzr
 SKP88XdidukDu7D/MbRUipBJO3QcIqowV4sxcHpU+MuVxRlYEzar4/eqxhluJcCctChozDgwAoJ
 rIvxGQF1NBO0Ke6fG9Q==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6acf0308 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=V-x0i2ww60Py9ooNB60A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: v4SWikGRAki8lGOvfgw53rwXMFaEZvyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140017
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

On 14/10/26 06:13, Brian Cain wrote:
> 
> On 10/13/2026 10:01 PM, Philippe Mathieu-Daudé wrote:
>> On 9/10/26 21:25, Brian Cain wrote:
>>> Set PC to the tlblock instruction and leave the CPU loop when the 
>>> lock is
>>> contended. This retries tlblock after ownership is passed and prevents
>>> execution without the lock.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/hex_mmu.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
>>> index bdcfa057c21..b9fab949d0f 100644
>>> --- a/target/hexagon/hex_mmu.c
>>> +++ b/target/hexagon/hex_mmu.c
>>> @@ -12,6 +12,7 @@
>>>   #include "system/cpus.h"
>>>   #include "internal.h"
>>>   #include "exec/cpu-interrupt.h"
>>> +#include "accel/tcg/cpu-loop.h"
>>>   #include "cpu_helper.h"
>>>   #include "exec/cputlb.h"
>>>   #include "hex_mmu.h"
>>> @@ -185,11 +186,14 @@ void hex_tlb_lock(CPUHexagonState *env)
>>>               env->next_PC += 4;
>>>               CPUState *cs = env_cpu(env);
>>>               cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>>
>> Pre-existing apparently, is CPU_INTERRUPT_HALT appropriate?
>>
>>      /*
>>       * External hardware interrupt pending.
>>       * This is typically used for interrupts from devices.
>>       */
>>      #define CPU_INTERRUPT_HARD        0x0002
>>
>> or is there a better match from "exec/cpu-interrupt.h" definitions?
> 
> I think CPU_INTERRUPT_HALT is appropriate.  _HARD is suitable for an 
> external (maskable) interrupt.  The signal we need here is one that will 
> cause us to stop executing instructions while pending on the lock.

OK, we are good then :)


