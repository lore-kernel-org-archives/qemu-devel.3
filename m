Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6969FC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZIn-0007Fh-PH; Wed, 05 Aug 2026 06:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrZIf-0007DL-KH
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 06:56:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrZId-0007pq-02
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 06:56:41 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6758dYqG2348639
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 10:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7bfYx99tVFeLQzNixnAWfebuVzbkYuumv4+4k8UmBFY=; b=UsAxT31I3CqxL06I
 dhuTirOE//mLZfyHRRHOUL4BKSLtAdHEFg3gzQs4NiASZA04aseDyjViAuculbff
 pVvYUgvosnFZLvvOnGo3paSUmUbD7IW3l+4CcWoIUOYhM0w7nSLbYD97lFdAZQTx
 aqKDMV6SfhMjqTlEv/39ISviAPYe8w37g7f4JV4TaIxHtZqydOQNP61SLr2lZ83G
 2wBgrFggTt2JQEK1Lvnvq4yOHR1r4DNT6A/QBAuOpR/ZMWiTjIO/qc9MRxJacMn4
 TQ5ccsUtGjVq0SNA87f1bHpBiVlvF9GG6fJ18Dce/AcXCZw2I32l+PFUu/zehdzo
 fm+Fzw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3nv4yh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:56:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso8395611cf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785927395; x=1786532195; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7bfYx99tVFeLQzNixnAWfebuVzbkYuumv4+4k8UmBFY=;
 b=hWeD+nh4x75IfHjDbihFvY56BLH21SJxKA8ggPF3wDcoadJ1B01OnFGKhaVs0tKhsu
 Tgjrb203a8CavMZn88xnrMSg9rRlOjqTJjJi4tD1gvPwM51Q10LPCRjzfv3AAGDFPZcA
 GUQH0+5JgWHOxRfw05WmUUARiw5Z7VwLn0It7pFMXtDdlnBaOIiXn8Spu4Gzbxg2Wz9w
 EM5edTaQtT7X8FCe9HTrohq8494IJwjQsi+C62d/JALAu6bIhkeogAn05G7Gd8YrAlHt
 BeIqe/k4c0wuvNlTKoPqStNZpIdRduhupXyYavLsJlAKbF7hlLpU2OweGej4yf61Sh7Q
 Ai3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785927395; x=1786532195;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7bfYx99tVFeLQzNixnAWfebuVzbkYuumv4+4k8UmBFY=;
 b=Jer95BKXk2V3yz1BRQavCmtnjGfSu6oIuk0kRHVDwsr5lKARhGf/rYg8NiFCkSVzN1
 6+PEMVXmYmAuZ+6hVCOiSeUJxvQmeQOKAY2ra8SJtTkQm7KqsLOxNSb6NbCxWvumUuoa
 715d/Mlv3fIph2molA8mtLYftaOXxcPd1KawgyWRipWiN3wH1oy9KwfLoNduELWQtV6r
 TeMsyvxCTRpd5Zie75l7xTfNaa65GOERUxfdmXSfotKnzgBjnp1Jq3vCDyk3m66pHdy0
 7BWbPvmr9hjvN4W2BfceNE9eHFfMKKYUELH4I2b1MVWIx7yyeX6JXT6Ywi+kDrs6mBCo
 KDFA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrjhsk2Y+D5upZVMt7wGUopnFLhADXUk+2wUK0duxJrlAkKpflv4kZgWz4R8KnkKwJJcUQdsEhwhKuV@nongnu.org
X-Gm-Message-State: AOJu0YyR4grqypesDDdjWIlTl6MGZeac2kVzHfeCiE1eeNpHMPMUld/R
 n1RzW5qLXugEhT9nrOUJFgH8vq2b6GfO38HgE+GucwIu1/Sl/vmEbyjiFQ4ph4RXRl+TUPLT9/d
 ZBjbqxf8sXDg9vSpZDqMJS10mBWo7isz4uCA9dsK5iq16k0Hm9+Bw+8OmzA==
X-Gm-Gg: AR+sD10Of3WHTOu9FwVxW4UfYzd0sCUAkQ3fnhrwLHk4kBZalD53txrW0CAFAnrW7mv
 AjuzTav3mWJR5NI9Ev5ftLp/MQFDIiWXED4HveJE6cXjZbgzxuRE6HtO3zPZL3xkmVUbSgoWNvG
 H+VYpM6LTOJJHurG/C6S8c+yu8hbiU1h/70qOZHIlUHiRBDne0GndSmu5S685FOraP3BxUmq6So
 3y7/CIgXrPwcsJiBJ4x4QlRH31UV+WnswD9aggg/MXUiHyuKbJmh1B5Z0iHMRjGnxMPlA0jwfHX
 SrZIlojf5pcPZZBIbZi9okfK7FbpEXausaFnVCDYg1JknwLohhQxJhNkXAzBBMsTequniTWmJua
 WAH7HbvOg4h50TYlehRD7DF11KXLPHhUhxzY=
X-Received: by 2002:a05:622a:592:b0:51c:4dc:287b with SMTP id
 d75a77b69052e-52ce5f5f836mr52647801cf.7.1785927395243; 
 Wed, 05 Aug 2026 03:56:35 -0700 (PDT)
X-Received: by 2002:a05:622a:592:b0:51c:4dc:287b with SMTP id
 d75a77b69052e-52ce5f5f836mr52647371cf.7.1785927394670; 
 Wed, 05 Aug 2026 03:56:34 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e52d819sm37876585e9.1.2026.08.05.03.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 03:56:33 -0700 (PDT)
Message-ID: <c3d6e704-0133-41a8-8386-83aae7340f33@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 12:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
To: Bibo Mao <maobibo@loongson.cn>, "Andrew S. Rightenburg"
 <andrew@rail5.org>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20260415111738.3264448-1-andrew@rail5.org>
 <a4fed950-ae06-8dac-256c-132747d3b6f6@loongson.cn>
 <4c94cd7c-29a8-4f1e-a782-92a2f64245d4@oss.qualcomm.com>
 <b851d0a3-ab27-d039-2ea4-e4b6a1037274@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b851d0a3-ab27-d039-2ea4-e4b6a1037274@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NyBTYWx0ZWRfXzG5z7SwY+VQD
 Uue9t94wToBL8CGC/5GCtva516eeKRMwnAt5nSauPSaBl3o6SChIwaBZ8aXKiQYwlnAkp6zbZ6U
 ntosP7huIsLOPzM3ixwatuTwaCcC4YXtTvIaWeVTjRZdytuluk4mR9/xzYLAztfrCyRzQdst6PJ
 lpjJwiCEcgKOOZszIIIru4nA/EckyNoKov36XVX5RD+1aua+al9Aqs8doUe3FBpWdlpUep9OGK7
 GwYol7qaVXyhK52gVWoAGBLnwF/TG2XVeFh6HXs4QFEF1lqiyOl0KKKDOJjStOsuM1ShbVWVrb9
 9C+dQjhPILzwrXu8+yFdBW1sMpLLUkhNZMXzL55CmsR1WLfkBraZ7hUT4/IrXqcSRUHbjadXNF4
 +gI18hRKd6imDH5s4Kv0uMxL53saLytn0WdR6xG2C6i7rrIqxfAHqto9njH+xddFo2PreU37Mlw
 QDGxMbKHhAP3FaBUlug==
X-Authority-Analysis: v=2.4 cv=AZqB2XXG c=1 sm=1 tr=0 ts=6a7316e3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=rP0CljThwvTTKv4wyZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: PIS47eLfMG9lwdUmvm2SMiTageay9SQy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NyBTYWx0ZWRfX6ld/zu8iiN99
 tFO0qWumI0Wmd6g8Yt30sUlRnfBkqSk125h9tJq5bCgov/LfGH3gETeUCSnaN+Ceql4VsJE8MxW
 pA0OLSZsPtGuVhONIC4PvneufUGpZHM=
X-Proofpoint-GUID: PIS47eLfMG9lwdUmvm2SMiTageay9SQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050087
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

On 5/8/26 09:33, Bibo Mao wrote:
> 
> 
> On 2026/8/5 下午3:19, Philippe Mathieu-Daudé wrote:
>> On 2026-08-05 8:56, Bibo Mao wrote:
>>> applied to loongarch-next with small modification.
>>>
>>> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/ 
>>> tcg/ csr_helper.c
>>> index 7dc33bc180..d8d54d81e0 100644
>>> --- a/target/loongarch/tcg/csr_helper.c
>>> +++ b/target/loongarch/tcg/csr_helper.c
>>> @@ -103,9 +103,22 @@ target_ulong 
>>> helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
>>>   {
>>>       CPUSysState *sys = env_sys(env);
>>>       int64_t old_v = sys->CSR_ESTAT;
>>> +    CPUState *cs = env_cpu(env);
>>>
>>>       /* Only IS[1:0] can be written */
>>>       sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, 0, 2, val);
>>> +    /*
>>> +     * Software interrupts (SWI0/SWI1) are latched in 
>>> CSR.ESTAT.IS[1:0].
>>> +     * Make sure the CPU interrupt request state tracks the pending 
>>> bits,
>>> +     * matching the behavior of loongarch_cpu_set_irq().
>>> +     */
>>> +    bql_lock();
>>> +    if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
>>> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>>> +    } else {
>>> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>>> +    }
>>> +    bql_unlock();
>>>
>>>       return old_v;
>>>   }
>>>
>>> On 2026/4/15 下午7:17, Andrew S. Rightenburg via qemu development wrote:
>>>> In TCG mode, helper_csrwr_estat() updates CSR.ESTAT.IS[1:0] (SWI0/SWI1)
>>>> when the guest writes CSR_ESTAT, but it did not update the CPU 
>>>> interrupt
>>>> request state. As a result, software interrupts could be observed as 
>>>> pending
>>>> in CSR.ESTAT while no interrupt exception was taken.
>>>>
>>>> Update CPU_INTERRUPT_HARD after modifying CSR_ESTAT, matching the 
>>>> behavior of
>>>> loongarch_cpu_set_irq(). The helper runs without the Big QEMU Lock 
>>>> (BQL), so
>>>> take the BQL while calling cpu_interrupt().
>>
>> Eh I don't understand this justification about taking the BQL...
> I guess there is g_assert(bql_locked()) in cpu_interrupt() -:)

Hmm OK, thanks.

>>
>> If we can not call loongarch_cpu_set_irq() directly, we should extract
>> the common code in a common method and re-use, not duplicate the same
>> code.
> yes, I think it is better to call loongarch_cpu_set_irq() directly to 
> avoid duplicated code.
> 
> Regards
> Bibo Mao

