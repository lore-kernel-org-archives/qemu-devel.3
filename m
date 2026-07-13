Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31388C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjLBw-00073k-BJ; Mon, 13 Jul 2026 14:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjLBt-00073O-MH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:15:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjLBn-0007ss-8W
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:15:41 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF84xQ1887697
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 chVVcX+KUqotC1ZDGE9xlTiP8TMMgvd5gPtn6HPnqhg=; b=dKqZ4L11tNLCWKc7
 bHn2wIkHUxXhyIdZGsivS1YEiXW70X571SFaa1C+KfJIyXR6IotmvZXp/wXcGCmr
 2o7pNffS9JLFWzSa9n8x2iAlG5xLvR+HAfGZe4yCrwi5nMcdBttjWXa7BIqvqgqX
 tXbfWmjOtboiGi1tadciMb8hzreo2IuULYpaYWnOcJgImKGSWHimmDWBGw3DeHc9
 cR4UrZPEkHMlTPHUH7EY199ssC+rvjI52cfBDwbHGYDak72Py9fB77nK/yHnTvTn
 MW6IrXIaUBn8etMcro2aUMk907c4+MzZHT5jKk5Krq9PjBBHMEDJ0/avqZZNH3lq
 1KZ80g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavt54f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:15:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so4901157a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783966532; x=1784571332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=chVVcX+KUqotC1ZDGE9xlTiP8TMMgvd5gPtn6HPnqhg=;
 b=hubf2TINE3vrVpwd3P3XDW+Rn3JiX4a9zS8xB5VoCAcDqL+UZQ+8qrYGjnL/elMI8h
 HuDh8yRO1wVuT1PZPtegTdIm2unB03P8Il7ji8Xy0gzKtn0BMmgdVUF8EUL+Krp1q8Ev
 rUjet/+Ak3SbCf3HKZBTe8msMw24avaOhHTM2y3oIGeiLemqku2VOI7bgHMqLu0VWhXK
 f2Y+q4BUpQnNDqwQmYqrDakZAmgTM/HychZKmAw5YPZtHzWxYL2lIgXkSxU3K1vFfajR
 6kKbEwwPjHKyCfuR+XQyuBc2NSUyhm8hg1WRb8q17X8OM6uMKmJQxpt8VL0LH90VWh9B
 2tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783966532; x=1784571332;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chVVcX+KUqotC1ZDGE9xlTiP8TMMgvd5gPtn6HPnqhg=;
 b=PT+qnkjyOwAhRsYTdrCnN0FKgqwYGEJD/zoZdYjwpu5ZVNFBsKJmtm0XbA1EHrdiBt
 s9t8aBpiDrrdIyHe8ltIMVpZJSdmhz2RYI8IgT1AObrdSBjdTLBCdJzIyZ2uwhxAdB9d
 Iwox1gfr9+MHQ8PWOLWmpHGP8ydHMIZ6ilQoV/Xp2a0unf7SlN55Ilw2Wl0xrR60/7/P
 XnlYQR8extlFkHMxUqUlKsWeKHkklYEnUMVWUgddJ1WMFLpMD+6ueoXkoA8r8cKVH3df
 QGBaLcUEUls/I/9HmqB92m9GohBden98ZKyY1XnVlZz/e4C+oJaGXuNFLsQh7oR3Lkzk
 yL4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrwx9fMPU+KVeeu4j7mFwCkBZcFleiD26IU0XFHxIgLB4tGxrIBw1ysPbMX3uSWo4OKfDdDWxgmXO0M@nongnu.org
X-Gm-Message-State: AOJu0YzMGaQZkH/UNKhOym5iP6fs5nZ9WfnMU5fPsl4u0ol/lRxRUg7B
 KRYfdaJLBR+xWDgoUPwpes/PVyODqZ8xuBJSbvBcfzOgRGLG3TdKZfoNCyDX4qOZSggHayl2OyL
 N7ydVWcA/H6VHosowodTlD0F9In5u2suZOJWeIfG56ys0CO+agn4t3eCYqA==
X-Gm-Gg: AfdE7cnnyEtAC37i4r7I1bxsQxRrqHbRxUuKa2V/kjuozw9cOhzDqILVhF2zKlJYV3C
 zKvCB9wvFfLXON7mCsUMl+pu1ll+Gddmuhqlp6yvU5kyXuts3n03FKRsnDFdNbu2AsCzFPEYgX4
 SxObNHcFFaGXbl4AV9aSW+/EuxR/jFnqadatrjegTaT81ZikHOdGvmUMKKcpBaLYkckapw+Tch9
 tKKQ4aWo8vTV0tNtEwh7l45PolsKMKlf24fmC41zWAGbO6iAiAY3Ab1GwZPGZu/w8mKx92Qz7sx
 QJS1dSYsNEi6LpR5mRQfYH2lpEArfJCoOC8SCyX/0VzWAo1MxHk8cghoM6IBF3LQTQNQEBB3gUF
 zZRLSOuYpUFMcWzKq7gRwCpaLxH1fDf8xtwRpt6UsycorKmyza+IchNCNu9F41TVWJzSB03bOdk
 ASH0w=
X-Received: by 2002:a05:6a21:6b0f:b0:3bf:6c05:aa with SMTP id
 adf61e73a8af0-3c34d8935c4mr438563637.57.1783966531730; 
 Mon, 13 Jul 2026 11:15:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b0f:b0:3bf:6c05:aa with SMTP id
 adf61e73a8af0-3c34d8935c4mr438527637.57.1783966531084; 
 Mon, 13 Jul 2026 11:15:31 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b9081d5c3sm22874685c88.9.2026.07.13.11.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 11:15:30 -0700 (PDT)
Message-ID: <4b825174-6ba6-49c5-b135-be611a4cf04a@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:15:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260710212601.583352-1-functioner@sjtu.edu.cn>
 <20260710212601.583352-3-functioner@sjtu.edu.cn>
 <990f11f5-c8fd-4cf6-b186-180e24452ff3@oss.qualcomm.com>
 <5a303ce5-cb6f-43b9-857f-39cffc8c7d67@sjtu.edu.cn>
 <8c2aa5fe-026e-45c2-a908-5f6c245b2993@oss.qualcomm.com>
 <2c57e188-b9f5-45b9-90b3-81a3d128254a@sjtu.edu.cn>
 <69924eee-ba12-4a3e-baff-8ecb86d1ce77@oss.qualcomm.com>
 <37b40d64-aaa7-4358-ad5d-70c15dc05cba@sjtu.edu.cn>
 <9b8f79c7-1f30-4036-ba05-22d390a22410@oss.qualcomm.com>
 <e46324ae-0853-422d-aa45-11d73b4b3a18@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e46324ae-0853-422d-aa45-11d73b4b3a18@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fIpWiUoUcrEHqJX2AV1MEvKAN5JWWpUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4OSBTYWx0ZWRfXwz5Hk3eb+Yvg
 CdadlrDEYiNoo2jgJZX4M3EiBaFoOrfXAxSbuOVa5XpqYiaqlrN1sOPB6Ulc/uapjeQPajg8MVu
 hH5fRPyjdhC762exGyUUpH61lwMn6B+flRVXw8V9Y435tUiybcd96VW4gn4Ts3cOL0DqayOVJLk
 57bOD2JJJPxux+LSoCQvu6j3BPr1S6AKRRn9kfJDrBqB9kYdkyG8MGkRQX9b6Rkl6h8/3DnuYN2
 EzsZfcZSmamat+MO1Hngi0ieXkbhsZ38A75LRm2vZrJ22ee/KbD3YOIc+aRwrknRXhJYBMZ+SVU
 dtD8geg6iyoVVQrPhWjubEb9angN7tt2acV4OjDovBmP6BdGDdSR1QBxr1dFOoT797KoiMJsExo
 QbqUVvwz7JEnvnrEiV83rHjQYhL9MjqcNVN8KoOUDkv/9Hu4NArE0lYCCfAUpSzDRPhU5c/OxHB
 gu4MRo7eXkNEDqP7+LQ==
X-Proofpoint-ORIG-GUID: fIpWiUoUcrEHqJX2AV1MEvKAN5JWWpUe
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a552b44 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=0YVlk87hHFAOU0yzomgA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4OSBTYWx0ZWRfX/NWiEjCLV+kx
 9NxqxnBOHpZCsfKxSp1hr0uhFXMOAdlI7hvGEJMOjrPDJh+CxrGNdtvMpAAeQICEFgsKWb5g318
 SElcm0F/0+hU9/QLlON40Faz4JXg8SI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130189
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

On 7/13/2026 11:07 AM, Ziyang Zhang wrote:
> On Mon, 13 Jul 2026 11:03:23 -0700, Pierrick Bouvier wrote:
>> On 7/13/2026 10:56 AM, Ziyang Zhang wrote:
>>> On Mon, 13 Jul 2026 10:53:56 -0700, Pierrick Bouvier wrote:
>>>> On 7/13/2026 9:34 AM, Ziyang Zhang wrote:
>>>>> On Mon, 13 Jul 2026 08:31:18 -0700, Pierrick Bouvier wrote:
>>>>>> The problem is that if that the guest program, or the host library
>>>>>> (host
>>>>>> libhello) may depend on libstdc++. If they do and if they depend on a
>>>>>> (newer) symbol not present in lorelei libstdc++, we break ABI. Same
>>>>>> goes
>>>>>> for libgcc.
>>>>>>
>>>>>> By not doing this, you'll be forced to provide a lorelei devkit
>>>>>> everytime a new libstdc++ is published, or a distribution updates its
>>>>>> gcc.
>>>>>>
>>>>>> The only solution is to embed libstd++ and libgcc statically, or
>>>>>> rely on
>>>>>> host libraries. If you choose the second option, you know have the
>>>>>> opposite problem. So I think the only way to solve it is really
>>>>>> static
>>>>>> linking, even if it will slightly increase binaries size.
>>>>>>
>>>>>
>>>>> The devkit already ships libstdc++ and libgcc anyway: its own clang/
>>>>> LoreTLC link them dynamically, and we bundle them so the toolchain
>>>>> even
>>>>> starts. So bundling libstdc++ for the thunk flow adds no new
>>>>> dependency,
>>>>> it just reuses one the devkit must carry. Static-linking the thunks
>>>>> wouldn't make the devkit any smaller or more self-contained either,
>>>>> since clang still needs the dynamic libstdc++; we'd only be adding
>>>>> static copies on top of it.
>>>>>
>>>>
>>>> There is a difference between the toolchain dependencies, and thunks
>>>> dependency. For the first one, it's perfectly find to provide
>>>> libstdc++,
>>>> for the second, it can create conflicts at runtime that may be very
>>>> hard
>>>> to diagnose and solve.
>>>>
>>>>> On the ABI risk itself: libstdc++ keeps a backward-compatible ABI, and
>>>>> the copy we bundle is recent, so a thunked host library only breaks if
>>>>> it was built against a strictly newer libstdc++ and references a new
>>>>> symbol. Even then it needs no new devkit, because the resolution order
>>>>> is the integrator's to choose. On a host newer than our bundle,
>>>>> putting
>>>>> the system libstdc++ ahead of the devkit's on LD_LIBRARY_PATH lets the
>>>>> host library bind the newest one, while clang and the Lorelei runtime
>>>>> keep working against it by backward compatibility. So a gcc update on
>>>>> the host doesn't force us to reship.
>>>>>
>>>>
>>>> Sure can choose indeed. However, he has to find where such libraries
>>>> are
>>>> located on his system, and prepend that to LD_LIBRARY_PATH. Not the
>>>> most
>>>> user-friendly thing to guess and debug IMHO.
>>>>
>>>>> There's also an active reason not to static-link. Both the Lorelei
>>>>> runtime and the generated thunk libraries depend on libstdc++. If we
>>>>> statically link libstdc++ into a thunk while the host library it
>>>>> dispatches to links the system libstdc++ dynamically, the process ends
>>>>> up with two libstdc++ copies on the host side, right across the
>>>>> boundary
>>>>> where C++ objects and exceptions pass between the thunk and the real
>>>>> library. That can break:
>>>>>
>>>>> - Exceptions: one thrown in the host library may not be caught in the
>>>>> thunk. The two copies have different std::type_info for the same type,
>>>>> so the match fails and it hits std::terminate.
>>>>> - dynamic_cast / typeid across the boundary: they assume a single
>>>>> type_info per type, so they can start returning null or misidentifying
>>>>> types.
>>>>> - Duplicated global state: two sets of the iostream objects, the
>>>>> locale/
>>>>> facets, and the exception emergency buffer.
>>>>>
>>>>
>>>> That's a good point, but does lorelei even provide a solution for that?
>>>> I guess that exception raised from an host library and sent back to
>>>> guest binary with target specific types will not result in what is
>>>> expected at the moment.
>>>>
>>>>> Based on the above reasons, I prefer to do that than statically
>>>>> link and
>>>>> grow the big artifact. Does that hold for you?
>>>>>
>>>>
>>>> Ok.
>>>>
>>>>> Thanks,
>>>>> Ziyang Zhang
>>>>>
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>>
>>> Wait a second. I missed something.
>>>
>>> Sorry, last time I answered without actually checking the libstdc++
>>> situation on the four distros. You were right to push on it, so I looked
>>> properly.
>>>
>>> You were right that the x86_64 sysroot is the crux: libc6-amd64-cross
>>> gives /usr/x86_64-linux-gnu/ a libc but no libstdc++, so the guest side
>>> has no system libstdc++ to fall back on. That's the side we should keep
>>> providing ourselves, and the devkit already ships the x86_64 libstdc++
>>> next to the guest runtime for exactly that. It's only a default, though:
>>> if a guest executable needs a newer libstdc++, the user can put a newer
>>> x86_64 libstdc++.so ahead of ours on the guest LD_LIBRARY_PATH (the -E
>>> one) and it takes precedence, while our runtime keeps working against it
>>> by backward compatibility. So we are not locking anyone to our version.
>>>
>>> The host side is different, there libstdc++ is reliably present. I
>>> checked each distro's stock minimal base image, with nothing installed
>>> on top:
>>>
>>> Debian 12: libstdc++6 12.2.0-14+deb12u1
>>> Ubuntu 24.04: libstdc++6 14.2.0-4ubuntu2~24.04.1
>>> Fedora 40: libstdc++-14.2.1-3.fc40
>>> Arch (2024-08 snapshot): libstdc++.so.6 from gcc-libs 14.2.1
>>> It ships out of the box on all four, and the C compiler pulls it in on
>>> Debian, Ubuntu and Arch.
>>>
>>> So the split I'd propose: provide libstdc++ only on the guest side (the
>>> x86_64 sysroot has none), and on the host side rely on the system's, so
>>> the host thunk and the real host library both bind the host's own
>>> libstdc++ rather than a copy we ship. That directly addresses the ABI
>>> point you raised: nothing we ship shadows the host's libstdc++, so a
>>> thunk never forces an older libstdc++ onto a host library built against
>>> a newer one.
>>>
>>> Does that split sound right to you?
>>>
>>
>> That's a reasonable default, and Lorelei can be updated for this without
>> having to update anything on QEMU side (or its documentation).
>>
>> If I had to choose, I would still do static linking for guest and host
>> thunks, because I don't think we can handle exceptions correctly anyway.
>> But the most important is that current example already works out of the
>> box, which makes this series ready for upstream.
>>
>> Regards,
>> Pierrick
> 
> Thank you, and thanks for the thorough review across all the revisions.
> Your feedback made both the plugin and the walkthrough much better than
> where they started.
>

I know it can be frustrating to address all the picky comments, but in
this case, I really think it makes Lorelei better and easier to use, and
not just to accommodate my personal taste. Hopefully it will help to
make it more popular and integrated with other emulators also!

> The libstdc++ discussion was valuable too. I'll keep static linking for
> the thunks in mind, and the exception-across-the-boundary case is a fair
> point I want to revisit properly. Since all of that lives on the Lorelei
> side, we can iterate on it without touching QEMU.
>

Yes, the important was to have the simplest example possible, without
requiring any external dependency. I hope you can use it on Lorelei side
as a minimal CI test to keep things working as they are.
> Thanks,
> Ziyang Zhang
> 

Congrats again for your work on Lorelei!
You're welcome to share your paper here once it will be published :).

Cheers,
Pierrick

