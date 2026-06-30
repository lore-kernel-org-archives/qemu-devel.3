Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB2FC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZJi-0003CA-O7; Tue, 30 Jun 2026 10:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weZJh-0003Al-4K
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:20:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weZJf-0005Zt-5c
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:20:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEDM9M2224546
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 14:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fgKVOZpMEaY04mD/9g7XL4KyaNHYwKpuiKtrgadyHAk=; b=HdjvmUAZk2HvPFO7
 2fop/8j/kX9mHOAMytXR2AmMebUVnxuC+zr46WfD0jLdD3UXVslqDy+tA1OCbvjO
 hlDFXVwfgWTMXTbaR/h/KcqKkitTlBWJZuf1r3bQwIw3wo9rGTw3y5wzJ7FsQSj6
 ODADvxnxDxnFI9rM0XoeQJUgkWGDruSa5iIHYBf72e0Sl3l+kJsZ3/cjJBKjeH8Y
 Y6Ryob3SdCaSIH7fVge+v8dl92S8apbr/tbDO+ldkJ6NHohEytkmuB2LZKhDx39D
 TVvnb9Y7zmZGsq0qoRgNpOJu4faqpBCj3k/McZTvUY8KkblsZqm50Vza/vrU12Gy
 hGhF0A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1cvajx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 14:19:56 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-737d352d3b0so2896568137.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782829196; x=1783433996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fgKVOZpMEaY04mD/9g7XL4KyaNHYwKpuiKtrgadyHAk=;
 b=hpKnjHXIO+GGPkmgEMVaNqFAGnk+z7HB0c8ies/9ucv9oCrpqv2HeBk81btQBo2QXC
 c9Ud9095aJZD1+tMamllp9BUGfwNK30fBuPfKITx5YEJ4pShRU5jmy54Znl+IraB6LkG
 9UAIetectgIcvYJkoOWgvNYRqM9ZV7hGHryiWO4W8wvpTRuCWhjGFQgeE9gtd1ujekg/
 XwQHUoqOs+ilTZJOAeVG8xOh4LbmDS1a0n1DegKQbnQ70RLKzNL/M1LaxgKrKKBdBPPr
 oovDGBX1YdR57/4hmxX180UGsiQ3ac8Z+1w6/iZlw1TNLQTzYgCTOup8qIYZdSoAdueA
 WwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782829196; x=1783433996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgKVOZpMEaY04mD/9g7XL4KyaNHYwKpuiKtrgadyHAk=;
 b=OOZQtBaUobp0WwddTY0hdL7MELI6Akz8ELYS+2xlh9bhUmv1m1mFWY93xRjOTpRZW3
 fbQC2Ghd/n5HhrTfW4IS2G2iBZlqNZqd+g0Q8h7cMya7rQB3/btcgqAcenr7bJoXWyy+
 r3IqGnPpSeMyMhPUTKgIH2n+jacni2Fu0zKH40qnt0nPgjnOmAA+djAdc5SGfIOm+yYr
 /T6i3cBzj8xuI48BHDjkRlzfA3SoaBwPOOQ11j9q/d6ytYmcfqUVzuND6P7Bw5G0l5Pb
 aJFlT48I6MSKkc2/izYrI/FGcUs9dst5GCgKclPy07b2wcolXuuKA70FOrbJ8my51eXw
 4L+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp07sw3TZw4sGEKgt2RVws9Os16mgu8QCC1PaY1ZFZiKNYNm6iVvZMG9mH6EQURuwW2ppNcJPR9OJL/@nongnu.org
X-Gm-Message-State: AOJu0Yyf0qGN/ctxzH/LRA3kB90QUkvDuCifEopHFPl4pY5kowhZCjv3
 DdZZgZMyYWC2EYOAROLnAhEsf9XnfgG7rvTPRuO/76FE5+SBezdMlOoCrfcQ03h3TNX0+T0nN4k
 5dBO1CVPrf/HzeX1rtm1Eevno11pxOEZHRafkA17UQQAgonFBzVGpRdgDdA==
X-Gm-Gg: AfdE7cnApO5g7UCMd7SIManqybhpVbaHLNmuO4C8Nle0q/eluNvcPi0ugRTqK6JQsEz
 cjPbIn7BtP7Vq9rEh6aKt4LXGwULlszUMVAA4qlr+hugFRJx497l5nmFw7sW+V49RL1/Ww6vM67
 llHtZ0lxnMXM7N6VUjNcVB2eFp6weMZ9BQEQBvYCjPUlk3dsx9CLmSwkfITF9kFDxXdnPq7MlVm
 ySK8uIUvKWjLWnHZ5Qscxt9uGbRSej5nofS/g61zZWGxQuUztUu9P91s/pK4sz2M1iJR5eaV0vh
 T/cFVspDrtinjRRP0XBVM7s8UUgmptTfHXp1eCHIhixE5dHrhqssBVzcDuxRKmGgN3JJmZOIb8r
 x5QQjVjH0X6nd8R/DtUSvlHygvmnbmFDPHULn96KBhvBC+aK8YbI1VBZruGvmPA==
X-Received: by 2002:a05:6102:f89:b0:650:94b2:b209 with SMTP id
 ada2fe7eead31-73a365e0f3amr2099731137.4.1782829196192; 
 Tue, 30 Jun 2026 07:19:56 -0700 (PDT)
X-Received: by 2002:a05:6102:f89:b0:650:94b2:b209 with SMTP id
 ada2fe7eead31-73a365e0f3amr2099710137.4.1782829195541; 
 Tue, 30 Jun 2026 07:19:55 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be383819sm875845e9.1.2026.06.30.07.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 07:19:54 -0700 (PDT)
Message-ID: <b13c7644-83aa-48c8-9045-550a436b57ad@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 16:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, freude@linux.ibm.com
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
 <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
 <d55a9d7e7759251c1e75050a9a9ccd6f@linux.ibm.com>
 <6e7ce946-1128-4b2c-9520-a171bca3ceb7@linux.ibm.com>
 <a6e637d07024e0ff8a457500110e225f@linux.ibm.com>
 <9cbb2f6f-c80e-4ba8-a307-4f640f64a8a5@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9cbb2f6f-c80e-4ba8-a307-4f640f64a8a5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfX8OvV7Hjoo/Zn
 TTjdOAnuZZ8wGuQsKIHMyzEeVn0qmZu3lHo2lDno+067NOZ6yNQRG7jI2IwfMNleL3rtWwG/IGc
 g0e/ko/v6sQSndMK7OboQkmTB17O/OeBjreHnGY2AJyloG9L9wShyO3BKvgYw1HwaPKuLi90R0x
 L7gP7sKAPA/UXkzN/eAEA9TuyCE2QVd4/Ft4fGTUD4CGKgLb7eSx8eI/HPLVgH4isBW2aUeO30u
 7omSu0MdbUvCxxfRVCiv9XZ3yHKQYOLM5Mxo0oMvEgNeWmVj/Txijc1ATWTLDgLEdm9xt/G8qb2
 4nIODtMigwKoppYPVAv9akfKqE0x1zFNbyjAQncdLbq8i3Gw+ScF5Xj+kqDkE7RDlxMOCH5xEnf
 bxytD67wxMIotODOv9es3Ffr55+WST+StZJwfozMG5trAKpyCMDpmJeKDIHpZ0XvMCbtxKH6mU+
 Os1fFpH8a1J/TOcAK+g==
X-Proofpoint-ORIG-GUID: F4tGv3cHeCw53WgVryHzbrtCPrijIjlX
X-Proofpoint-GUID: F4tGv3cHeCw53WgVryHzbrtCPrijIjlX
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43d08c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=lMLw8EYMNNNL7W2twHAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMyBTYWx0ZWRfX+pRwS91LbAjt
 Q8CNh45QwnDZjpXThwaT5DdQzS/K4BvBJ+qiWgWfpwnjmbDJM5NXh8f8p8wYljOkRXNw96ClzVu
 8uRpJS8eCIBVY+bv5WKSI9DMRWf4qhQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300133
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

On 30/6/26 12:54, Ilya Leoshkevich wrote:
> 
> 
> On 6/30/26 12:23, Harald Freudenberger wrote:
>> On 2026-06-30 11:33, Ilya Leoshkevich wrote:
>>> On 6/29/26 14:57, Harald Freudenberger wrote:
>>>> On 2026-06-24 14:56, Ilya Leoshkevich wrote:
>>>>> On 6/24/26 10:09, Harald Freudenberger wrote:
>>>>>> With the introduction of the address wrapping function
>>>>>> wrap_address() the result can't be used to walk the
>>>>>> source address any more. So introduce a new local variable
>>>>>> to hold the wrapped address to avoid mixing source and
>>>>>> wrapped address value.
>>>>>>
>>>>>> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx 
>>>>>> argument")
>>>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>>>> ---
>>>>>>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>>>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>>>
>>>>> If I take as an example AMODE 24 and look at the third loop iteration,
>>>>> with the current code in master I would get:
>>>>>
>>>>>     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff
>>>>>
>>>>> and with your patch it would be:
>>>>>
>>>>>     (addr + 8 + 8) & 0xffffff
>>>>>
>>>>> which is undeniably more elegant, but otherwise looks equivalent to 
>>>>> me.
>>>>>
>>>>> What is the functional issue here?
>>>>>
>>>>>> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/ 
>>>>>> crypto_helper.c
>>>>>> index ae392bce0e..29ad2aff43 100644
>>>>>> --- a/target/s390x/tcg/crypto_helper.c
>>>>>> +++ b/target/s390x/tcg/crypto_helper.c
>>>>>> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState 
>>>>>> *env, const int mmu_idx,
>>>>>>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, 
>>>>>> mmu_idx);
>>>>>>         for (int i = 0; i < 8; i++, addr += 8) {
>>>>>> -        addr = wrap_address(env, addr);
>>>>>> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
>>>>>> +        uint64_t _addr = wrap_address(env, addr);
>>>>>> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>>>>>>       }
>>>>>>   }
>>>>>
>>>>> [...]
>>>>
>>>> It is a fix, not an improvement. The original code
>>>> used the addr variable to hold the wrapped address.
>>>> But as addr is also used as the loop variable there
>>>> is a mixing between unwrapped and wrapped address here
>>>> and the unfixed code only works when wrap_address does
>>>> return the very same address as output as it became as
>>>> input. My fix corrects this.
>>>
>>> What does the patch change w.r.t. wrapping?
>>> Suppose we have amode 24 and addr = 0xfffff0:
>>>
>>> Before:
>>>
>>>   i = 0; addr = wrap(0xfffff0) = 0xfffff0;
>>>          a[0] = ldq(0xfffff0);
>>>   i = 1; addr = wrap(0xfffff0 + 8) = 0xfffff8;
>>>          a[1] = ldq(0xfffff8);
>>>   i = 2; addr = wrap(0xfffff8 + 8) = 0;
>>>          a[2] = ldq(0);
>>>   i = 3; addr = wrap(0 + 8) = 8;
>>>          a[3] = ldq(8);
>>>
>>> After:
>>>
>>>   i = 0; addr = 0xfffff0;
>>>          _addr = wrap(0xfffff0) = 0xfffff0;
>>>          a[0] = ldq(0xfffff0)
>>>   i = 1; addr = 0xfffff0 + 8;
>>>          _addr = wrap(0xfffff8) = 0xfffff8;
>>>          a[1] = ldq(0xfffff8);
>>>   i = 2; addr = 0xfffff8 + 8 = 0x1000000
>>>          _addr = wrap(0x1000000) = 0;
>>>          a[2] = ldq(0);
>>>   i = 3; addr = 0x1000000 + 8 = 0x1000008;
>>>          _addr = wrap(0x1000008) = 8;
>>>          a[3] = ldq(8);
>>>
>>> The behavior look identical to me.
>>> What am I missing?
>>
>> Lets assume addr is some 0x1000 and wrap does just add some offset, 
>> e.g. 0x8000
>>
>> for (int i = 0; i < 8; i++, addr += 8) {
>>      addr = wrap_address(env, addr);
>>      fetch or write something at the wrapped address addr;
>> }
>>
>> Then the idea of this loop is to run through addr 0x1000 ... 0x103F.
>> 1. loop with i=0 and addr 0x1000
>> 2. loop with i=1 and addr 0x1000 + 8
>> 3. loop with i=2 and addr 0x1000 + 8 + 8
>> 4. loop with i=3 and addr 0x1000 + 8 + 8 + 8
>> 5. loop with i=4 and addr 0x1000 + 8 + 8 + 8 + 8
>> 6. loop with i=5 and addr 0x1000 + 8 + 8 + 8 + 8 + 8
>> 7. loop with i=6 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8
>> 8. loop with i=7 and addr 0x1000 + 8 + 8 + 8 + 8 + 8 + 8 + 8
>>
>> BUT the given code does something different. As the addr is used in 
>> the loop
>> to hold the wrapped address this loop in fact does:
>> 1. loop with i=0 and addr 0x1000 - all fine, but as addr = 
>> wrap_address() at the
>>     end of the loop now addr is 0x1000 + 0x8000 = 0x9000, so next loop 
>> starts with
>> 2. loop with i=1 and addr 0x9000 + 8
>>     and at the end of the loop addr is 0x9008 + 0x8000 = 0x11008 and 
>> next loop starts
>> 3. loop with i=2 and addr 0x11008 + 8
>>     ...
>>
>> So introducing an intermediate variable which holds the wrapped address
>> makes sure the surrounding addr walk in the loop does as intended.
> 
> Ah, now I see where we were talking past each other, thanks for the
> clarification. You assume that wrap_address() may do arbitrary
> transformations, like addition in your example above. But today it does
> only bitwise "and", as defined by the architecture:
> 
> static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
> {
>      if (!(env->psw.mask & PSW_MASK_64)) {
>          if (!(env->psw.mask & PSW_MASK_32)) {
>              /* 24-Bit mode */
>              a &= 0x00ffffff;
>          } else {
>              /* 31-Bit mode */
>              a &= 0x7fffffff;
>          }

            bool wrap32 = env->psw.mask & PSW_MASK_32;
            a = extract64(a, 0, wrap32 ? 31 : 24);
>      }
>      return a;
> }
> 
> and I believe in this specific case the order doesn't matter.
> 


