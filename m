Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C53BCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 21:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wagV8-0006HA-Lj; Fri, 19 Jun 2026 17:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wagV0-0006Fz-Fx
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 17:11:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wagUx-0007Sa-C4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 17:11:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JKtibV1830447
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 21:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GtEZTcvT5cvV2TBjCMmXK9EfcDG+PoUm6gcmIfhw4fs=; b=Jc4xhRmIKxWBEqhH
 Cq8Zh2KNBukuPIaj+s1bmBoyVNMbqtuzJqCSbmVOY7KYhI+3jauiG70w4eb4R4Rf
 2bhduBLNohfop6UOlsb26qPycojEl2ByfVtzouB+fwKmp+6wahugxEUG5cKZ1+Tn
 fbpZalin/AojLMKWIQLXb8BcYAm9zsFsONX5z7AXNZqDDHMUD3BsosowNHPv/c2j
 Y8Pm5a1B1Qzu6RN83U+kXWYM+ksStvffLVCO2RKrqdhtXvEUUNHeM9s9skFH2NLD
 r8OpI3KqOmGOFYx1zP6RQU7mUUiA/irKuaW0UBxQh7lpwvb/Byn92LkLKx4r90H6
 ogZt+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm22dqmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 21:11:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157de5360fso739284585a.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781903491; x=1782508291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GtEZTcvT5cvV2TBjCMmXK9EfcDG+PoUm6gcmIfhw4fs=;
 b=kd/NM7Uh3qo7M/xHRhbeIAOndJktoaFJ8XSkARSINfezIMnuTUNNYVJYRiwnFxQiX5
 nEhmpdaBVSxR3wSHgJehw8N8y7dYuW+KdPigrOOkZZyrdZ2buzWro4KJyZxwySn/HPN1
 cqKLhAuhZyTxGIN6R4PwMONIYa4iAmiEUVkKpSQFWS24xwKWbH4xjNDW4ztcNQ6WFUAE
 9auvfZh2FAmk5wd5MtzVN0zedv43GqNXTrRWGbkGqsjCZyoM2a8BZ9rQgE8J3talNp7T
 6RHJqAsbX7J2DV9DC1z7aBYerR55gSg7d9AdcSmNEekn+UPkvJO8Xfqyi4Duy9Zxts06
 GP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781903491; x=1782508291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GtEZTcvT5cvV2TBjCMmXK9EfcDG+PoUm6gcmIfhw4fs=;
 b=g89pHoSxK1RfbOV9YZKapBv91Ye7839nq5W4BTibgTX1BBhi0Hku6IUupvcew+FH8+
 hoqz4yO476CQU4+a9C2/Bu04WIY7nbAQRHR4vGOIq/LgD0CugXUp7ez4bFqCrjdwnohu
 P0wndnO6HgvspdvlWawgOQ9u5wAhhJvQjgiMl2Kgl8pCff/U3XhJiTbZy8hAPG4G8RQW
 Js0wamc+cMC2AkD9Y+eAXf/NqJbEKfqlCT3qvPnLIVn4qXp7dGmmOlWqGxj7jablJSAk
 KkKtRUtErMKdAjRqS7xl9jX54K6QAaaMB5Au34Av0dwFkHReEXH+ONhbhxGR6a48iY2N
 jXqA==
X-Gm-Message-State: AOJu0Yy5WA5WkHca0PoIj/MKaUt/0XuIvdT9UPRz8iGWuJxbcmm4wJA7
 jIRwfxM46TJJ5Oyi4dmJ7bFBp9INdKMk6a9x8nn9TiXXBw2JXsIJB3DCQb0T76CN/1BWpcJBOUm
 DSvzBI3ovwo3+h6RgAJGfnx+JuPwCNVu8qMMb5r+m00/0jK6auvt0ebk2eg==
X-Gm-Gg: AfdE7ck/3RRSSgzYiOYasUK1jPhJi9C7CaRl93ovtM2RRDBbo1KcaacT32kYMiF+dBw
 QYg9II/WjjOs86jIOXzKbUHs/Q8N1M+IF7IcR5MmSzdI42sUJfnEJN5GwEz75maoOVKDvsRzWxC
 ijxPcu6GZ+q9nFAuhboas/568xrxdXJnHas0EU4CSfMy6FMaqqn5vG6vPPXMl7hstiudFHle35j
 Lni8eRL3EWc3c1S6R94grAnA69hnVX1AEsYo0sS3x6HcPeXk2B+3pAZWXUCOjFTHQpJ1LXPZezz
 W6WA2SA4BnBpg4WFdZe5xjbFerMCSQSFXVnIxhKjvo1HFl0LJFE81X2acF/fHmGUzb+8qI8RhID
 ImGkDSQqdQ2q66+Pc3HZAIKuat//WbTtD+sDQEdH+xaLZEOGp/Yz+PWJyhIxBEHRzlnoliQiSvt
 2CblUKpCMzTOfeUXs=
X-Received: by 2002:a05:620a:4586:b0:915:4c9b:4120 with SMTP id
 af79cd13be357-9208d1f3de5mr710533985a.37.1781903491076; 
 Fri, 19 Jun 2026 14:11:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:915:4c9b:4120 with SMTP id
 af79cd13be357-9208d1f3de5mr710529585a.37.1781903490614; 
 Fri, 19 Jun 2026 14:11:30 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-921d7965d70sm107285185a.9.2026.06.19.14.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 14:11:29 -0700 (PDT)
Message-ID: <96d23459-495a-4c42-b6a4-d01f58de28ed@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:11:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: tolerate chmod EPERM when unpacking hexagon
 toolchain
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20260619043159.2174062-1-brian.cain@oss.qualcomm.com>
 <20260619135326.1248896-1-matheus.bernardino@oss.qualcomm.com>
 <624606ae-4557-4289-b3a0-d612c9682cba@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <624606ae-4557-4289-b3a0-d612c9682cba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YN+vDxGx c=1 sm=1 tr=0 ts=6a35b083 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=kxkpSQQAEukOxNruim0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-GUID: m2WbeucUnxzTFxDMZ32LYESIFU6_wkYO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIwMyBTYWx0ZWRfX1Td5NHD2TVKO
 7P9nvDq5sGXHlEbNDqCNTYq0+UVL/gesAvNRB0iWVBZwruJ3J49l+qISeq44OSogU+xJlJaEeCl
 I1y/YkTQOMd5khH8ig708mLb+fnoLLc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIwMyBTYWx0ZWRfX3d0PG4ZT2Yis
 5K1a7TrIQsZFoX3uylL8K3fhDWNBzCfZWef3tPdTHK2KrVNfnjwXcuGqBVxkhcSHPFJhC49UgBl
 5yPf/NuwJxN0F9hymvYlrF/c2uOoGB8JnU8djESNZXvSLMpvnfAiSGuwPNYEArr8OHW7zHgXplk
 j1tg7TFaq696FAHDFMfrUJuH6glFfI7b1hWKYAKp+vSTB9OAfqzpmhghbyXwPt2zp9WGZkJW2r7
 rygYzRlLRK+08zZzkAdXCunkqH31CDIJYd6aa+cL8wcRoVHRqaKt2b30KvQ3N5qmkK5DVRBRxZX
 0Ro/cOZ+EWO8lYUy/vibRUS8uX8fRsKO2vlLWnWdIOMNLtLbSSaiNUhzfWLuHf+DaMv1Olcj2r+
 XR3i6hDttJsKjADaYaecpfV7fLNHoIwAPtKP8Tk05mIZ8qs13vPhy7aEznmw59JDwJihHcUL155
 jJCConDpfu4okxfutjg==
X-Proofpoint-ORIG-GUID: m2WbeucUnxzTFxDMZ32LYESIFU6_wkYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190203
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 6/19/2026 11:41 AM, Pierrick Bouvier wrote:
> On 6/19/2026 6:53 AM, Matheus Tavares Bernardino wrote:
>> On Thu, 18 Jun 2026 21:31:59 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> ...
>>> Download the tarball to a file and ignore tar errors during extraction
>>> with --no-same-owner and --no-same-permissions.
>> tar's man page says --no-same-owner and --no-same-permissions are "default for
>> ordinary users". Isn't that the case for rootless podman?
>>
> By default, you're still root in the container, even though id 0 is
> mapped to your original user in the kernel. So from tar point of view,
> it's not an ordinary user.
>
> The side effect is that tar will try to apply the original user id,
> which gets mapped in the range configured by /set/subuid, which ends up
> being different from yours, and thus results in a
> 'Cannot change ownership: Operation not permitted'.


Yeah - so apparently I can't seem to live without the `|| true`. But 
Matheus recommended `--fail` for the curl, which makes a lot of sense to 
me regardless of the behavior of `tar`.

So, I'll send a v2 with that change.


>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   tests/docker/dockerfiles/debian-hexagon-cross.docker | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>>> index 23e8bb2fb26..817c903246a 100644
>>> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
>>> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>>> @@ -49,7 +49,12 @@ ENV TOOLCHAIN_BASENAME=clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-lin
>>>   ENV TOOLCHAIN_URL=https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
>>>   ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
>>>   
>>> -RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
>>> +# Ignore tar's chmod/lchmod EPERM on the toolchain symlinks and directories,
>>> +# which rootless podman's overlay storage rejects (harmless mode metadata).
>>> +RUN curl -#SLo /tmp/toolchain.tar.zst "$TOOLCHAIN_URL" && \
>>> +    { tar --zstd --no-same-owner --no-same-permissions \
>>> +          -xf /tmp/toolchain.tar.zst -C "$TOOLCHAIN_INSTALL" || true; } && \
>>> +    rm -f /tmp/toolchain.tar.zst
>> Hmm, I think the "|| true" may mask some real failures. For example, if
>> the URL is invalid, curl would still exit with no error code, but the output
>> file would contain something like "errors" : [ { "status" : 404 } ]. Then,
>> tar would fail to unpack that but || true would mask it.
>>
>>>   ENV PATH=$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
>>>   ENV MAKE=/usr/bin/make
>>>   # As a final step configure the user (if env is defined)
>>> -- 
>>> 2.34.1
>>>

