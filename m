Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF916C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlnKV-0005Be-EX; Mon, 20 Jul 2026 08:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlnKN-0005Ap-66
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:42:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlnKL-0003kY-9s
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:42:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvWB81910265
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUEFeqe3nmFgcDPXmVor19zyDV7iuIH2BWCvGqlAub8=; b=dhDVHhQYX/MiEu9X
 t6Yl1RVacUdH/3GQTaoAuWNARadsFbjKLrnSrbM8NIiYRfWJXCRfYR3XAGyIhE/N
 AEgaGvenWRtgelulvGguK+xDJZT6cUWS2RMmEp1bBFkCOk6xKjfXQxqs8QbRBWoc
 VQozE42VRWFIfX6imJqK1Tg2qaFR9EUvbNSV57hwBmuzy6/pR+tfGvt1/UxzCmN+
 FIwgmUHIJVvC5Apxvyu7WjRo+SKMh+aY1JYHOMPrki+Zi/EvaGz0SR7ffHYLLzQP
 lY9xEI+4dR4G5vtA2rk7w2olkKoy9JwLmjuAtazyuJhtymfMx1kvr6dRIJWt09wp
 snJDXw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs50vh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:42:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0408254aso88035041cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784551350; x=1785156150; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WUEFeqe3nmFgcDPXmVor19zyDV7iuIH2BWCvGqlAub8=;
 b=WTv6H0UXspGwcw6Fq8PZdYYSkjkV2IuBvVA+Kvl8YPJsdmSLi1dNm7vpQDmwl3K4iA
 vw3t1ApVzLWKkVIPSCrM9D7aItt7g7205oQMM6p1wZ4g3G0QfZkLOjlj0n+xeiwMKskP
 nz/CZTdY3Azmej6d4kqkcfEHOVNEBZn+DarZSreu+Z+Q/ec493oyM+iZHxzC1ZU/ztzA
 OrnSvDVsjrtT5dtamp2xWCkMRdAtIyHW7McY9LUSKuNIw2k8t6WFzQvVXBamQNov+oWL
 bxIUOVN/X+KRIaKjAtpfOHelL75XQ9Z5mgBLI6lN84TLdLK4fyKu88u77iMhnwJnFyx0
 m5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784551350; x=1785156150;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WUEFeqe3nmFgcDPXmVor19zyDV7iuIH2BWCvGqlAub8=;
 b=WanekLmkmXIujuCg43zpQiU4/+Ks8WgWfbTFZakPQ9B9DPv03sxh+pyuVHsTmPoLfJ
 FWLOMJ0k/nexxJRJjDms1slhsJBo66E9e4Id/IZXhAsEXTZpqukxfwgySE6Ozvy1KV66
 CTWeNbLgYy3kI7pTCm5jWfktaZXizC1ND3dnUbJWFdPpYU/z32HUU/2kEylcrqfANjT1
 oU9+XzxdHFkPtMSAdzD473JXiJLQk77dAeD1KFiOZ/xXkIYYnwbIxnj9qwnD+D0fCDZy
 3cdsT7xS0K+cnaujkTLPbiTq5XQbaitKUTqzuSBKg+JM80x8fzIWTne3yV6WwNdvBBJw
 FPCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjFSGS4hJoujAzVKkdeQcrRYJivsYvDgl9Khjh5zTjrlaZXGTwgMvM+iV56GB0B+3g70etyvhVOWqr@nongnu.org
X-Gm-Message-State: AOJu0YyFzcnehr8a73DNBlnIGxiq5cnAIT5SrOqkrTxVdZEfYwk/zBx0
 okpKvuGiFl1A3k1k3sYS4+ih+J+RqQMBW7kwr9P2Rl8jSB6bJG4NWYfFcS+LWaUyNhH8SPJA/6t
 BYRezPkQ631rH3P2KW84b6y9IrBF2cG9+fQRv21Pd1lBlDVeYIrVe62moxg==
X-Gm-Gg: AfdE7clJiX163cWr7JENXa/TErHXayBXv3nWFd5OtMPYWu+cESnch1KpVG8hUyL9wU6
 2CCfwG+CtQpAyCNbFPMfIKACMCOBMvfr0fbl+SZuGDzuE8eCiPFKnnvIb3qpbh4Op9DHRF5uw6L
 R/0d7ZeAiMlkRSS9iH3SWhcd0I3uJ4dbZ6xUPtfaJdVhyy6TMJkEVhmFGEdj3/HQhnwl1/ji7xe
 IdDjVwrSp4C3eIpAtq6keC6s+Mqu2lv0Ha4wrFdkfhaB4IaIPnTOPGx8AxPnphRYegKmvPeC9kF
 Fce2t/yX+gGfQNwUzqxSKyM08ogprwwzTlC59/Y/IHqKG9bX2MIg3gMnLT71LamZQftIWEfVB2D
 lfL1pzXXdNepr4Bl2pMrX4qLNugQlgV9Dao2FqNnFtj7o+9PqWpk=
X-Received: by 2002:a05:622a:50c:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-51fbeeb3148mr168186421cf.1.1784551349888; 
 Mon, 20 Jul 2026 05:42:29 -0700 (PDT)
X-Received: by 2002:a05:622a:50c:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-51fbeeb3148mr168186181cf.1.1784551349489; 
 Mon, 20 Jul 2026 05:42:29 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2aa698sm255832295e9.4.2026.07.20.05.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 05:42:28 -0700 (PDT)
Message-ID: <2f85ee9f-91a6-4e61-8438-8c5f3a0dee38@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] bitops.h: Add find_first_bit32()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-4-brian.cain@oss.qualcomm.com>
 <cc3b6f33-6cc7-484c-901c-ffa4003c2865@oss.qualcomm.com>
 <CAFEAcA9iSgrua_ekOQ=EaXp=Mcxwk52qK6AkRXCrH1KcRm_vTA@mail.gmail.com>
 <6e4220ed-1e4f-4174-88cd-151c03b8048d@oss.qualcomm.com>
 <CAFEAcA-_rWzq3zq4AfduTRodMTcBZEU6bFtX3qhJYfn3VfBLdA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-_rWzq3zq4AfduTRodMTcBZEU6bFtX3qhJYfn3VfBLdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE0MSBTYWx0ZWRfX3wfkJzFgy+NJ
 pQk5xfU/tTWbtWBklWOPp49hB50Lagj8E8zmuUc/ghy6O/WMCVjcr9SxjXhuvxI2SoEkbcCmJLF
 4T0cnNEUix3gzAfTp8XU0vqtjk6NSKk=
X-Proofpoint-GUID: w-1C7pZ4uRLgZ77aNEAz4FPabHq5on5c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE0MSBTYWx0ZWRfX+l9zTz68x72U
 Cwq/CqCIbqv8oI/hA+rWxorymRDAo4iXSLg9FQkqqhb+D3oYK4MoTXeT+emsc6Pqdj+HYOgmUZU
 SXEWAvJLnwjMMxjPyMHGvQT3Pjgo/4HIcIOFrWVua0VLJAkw9yj7372BWVY4pn6YkDBlLjpQeUi
 RrvFY1D1RM4YkB1aaHinWfCaJk+fSZZ2CYHx0a5y/IrUtpYQrm3X8TjRT4ugVXryjiN4MoRkdSn
 M/J6Pm5USQIWmIn1XTWI2bYEYjhdx+8nJ0lp5HxXQ5CZtWZ9eF2ZGZUgcaxs/m33yCHf/wHM/9A
 YgdsEUcutAw0il0Ppo8YrBc4XM8phT+dT8IS2hFG1DBExY6AiUfn+0jc1eG2G35/yxT73o21I3+
 BZSZxQ0kDsxkLQEqEVzEv3TODgn08/fbIZnXF1yBvVw4MuXKNSPW6hicWRr+iYyXdccsYFJKuRh
 +qGJbMq548lvakR3WGA==
X-Authority-Analysis: v=2.4 cv=CpiPtH4D c=1 sm=1 tr=0 ts=6a5e17b6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XfjdRMWuiX4hZh7pmcAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: w-1C7pZ4uRLgZ77aNEAz4FPabHq5on5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200141
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 20/7/26 13:51, Peter Maydell wrote:
> On Mon, 20 Jul 2026 at 12:46, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 20/7/26 10:31, Peter Maydell wrote:
>>> On Mon, 20 Jul 2026 at 08:49, Philippe Mathieu-Daudé
>>> <philmd@oss.qualcomm.com> wrote:
>>>>
>>>> Hi Brian,
>>>>
>>>> some random thoughts...
>>>>
>>>> On 15/7/26 20:56, Brian Cain wrote:
>>>>> set_bit32()/test_bit32()/etc already let devices operate on
>>>>> guest-visible uint32_t register arrays without depending on the
>>>>> host's 'unsigned long' size. find_first_bit() has no such
>>>>> equivalent, which pushes callers towards casting a uint32_t array
>>>>> to 'unsigned long *'.
>>>>>
>>>>> Add find_first_bit32(), implemented the same way as find_first_bit().
>>>>>
>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>>> ---
>>>>>     include/qemu/bitops.h | 30 ++++++++++++++++++++++++++----
>>>>>     1 file changed, 26 insertions(+), 4 deletions(-)
>>>>
>>>>
>>>>> +/**
>>>>> + * find_first_bit32 - find the first set bit in a memory region
>>>>> + * @addr: The address to start the search at
>>>>
>>>> s/addr/ptr/?
>>>>
>>>>> + * @size: The maximum size to search
>>>>
>>>> Pre-existing, it is not clear this is expressed in bits. Neither if
>>>> we expect it to be a multiple of 32, or @addr to be 32-bit aligbed.
>>>>
>>>> Maybe rename as @last_searched_bit?
>>>
>>> Could we please stop bikeshedding this function? It's
>>> a simple copy of the existing find_first_bit() but
>>> with the type changed from 'unsigned long' to 'uint32_t'.
>>> The comments and parameter names on that existing function
>>> have been fine for years, and having the new function
>>> pick different names and comment phrasing seems unnecessary
>>> and obscures the parallels between the two functions.
>>
>> Argument renaming of course implies renaming the other companion
>> methods. You taught me to add public APIs with good descriptions
>> when possible, I thought your advice was worth to other contributors.
>> I'm not considering this review comment as bikeshedding. Anyway,
>> thanks for your review and advice. I don't object if Brian keeps
>> the current names or rename as @a, @b, @foo, @bar.
> 
> Sorry for being a bit grumpy -- it's just that this is the
> second time around of somebody suggesting a change here
> to something that's already present in the existing
> function this is patterned off (and which we borrowed from
> the Linux kernel originally).

Ah, I missed the previous suggestion and didn't know about the
historical origin. Thanks Peter.

