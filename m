Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08174C44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlsPE-0007vc-OT; Mon, 20 Jul 2026 14:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlsMj-0006aA-RK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:05:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlsMh-0006BO-NQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:05:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6dp83274822
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 18:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4ED4CuUYVcueq0v2Ouge27UdEtEWS5mrLWvOOTHsvoI=; b=B5QG95ApIbU/I3MH
 cQKsZASjoAourlj21ZYGEtyNqmxsY1NrP9glJDfyQo7ZsEewp+Eue/k0XFSkEaXP
 fuZFUPEiNh8En6eS6w0DyF6OwZ/rawMVLx0N4NK+2PpuFZjNUHJ69kQGR3T9bSgy
 dkS0rsrB2+j4KrtSY3uzlav/73h1O4mQls6Z7W0V0kVMJMY7s01JE7y/X9e3qvSa
 dCA0tJe3Fl1gUHu0pn41l4fr/aMlyqnr3YM1hG30b4MepRrqEujY4sGNsYGUbLqU
 fplgDYG22gnpRdYMubyySYQVFrgj4NRbVa7qc7rsV2OtaQ32QMgmS3V4Z65Y8kFR
 4DRhBg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgreafpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 18:05:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso10899441a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784570716; x=1785175516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ED4CuUYVcueq0v2Ouge27UdEtEWS5mrLWvOOTHsvoI=;
 b=GCHqOBoh+RjQ/thbLtg4AlIcmvV0pI3p37crIZrgnlSV3RQ5BE5rRGA6LLQWNNNtVi
 qGaJMGhmKA1RQ+8x42d59Xbe3QlYO8hqm2xDIN4mcpz6yv+Bu6n9q8h7pXhNJjmh2rv+
 6WVecM+eyDDbqb6pNci7NFec2zo+c9hZZQmkiScoJpX5E1D+fMCEe3Kdc4HRqXfOhqjm
 9HNWDrbIfjypgvsBCZz6LVsDGVeUmDID/1JTIUkraCENoR8GmL5YAqgS0vH3D4Z5Yoyv
 VKjqDJdmDuDSwt6oUs4aasfkQUAIV66r+f1dxHiWkiSxMjSJhYKqGYbkvsFOUJLQWp8N
 uPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570716; x=1785175516;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ED4CuUYVcueq0v2Ouge27UdEtEWS5mrLWvOOTHsvoI=;
 b=mU025JPzCVd/lRuBjbTFSH77WwH/5ZbykMJ4/d8Lo8b4YJvn6cV6HhlJIhyp82MjXO
 UiOTXYxFt09pLkJ3arxwpvy1PXfUm8i4ULjdOgr0HAxRQMgUvUPgn6nsXzUdg73jjOCQ
 pguEzL2r0mmkGcIQ5jj7RwWigJlBvISXpqmEx9tSub+3dG3PsrJhvdeX1WA0sBJ1SPww
 SgCgtWmgpaqiSdHbv+4+XGj0Lq3aa/NBvJ1v6hUewETfquXE9qxMGvIaCcJJ5uPCTcmX
 96ToKFdBfzmmtE2UdWvMs99PFtDnLQvfjU/2pGWJhmpDZppGoioJSJfIzdjZCdUFiSXZ
 6LZQ==
X-Gm-Message-State: AOJu0YzrY3aoLaxqT+g7LDn6+g/oCM6JExVr8ncZjrRj2UimhJqsqNdN
 gJQ1OlFkZin1A5jeGEws5qtdzNjkRDdexWUPpjuV+RQi6JETVzUB4Psb3kMVWk44zV+HhyeHohR
 1H1gqE2RxGr+S082oO4UJdE58mWwbhFkcu/BLfZa0aTesXNIeBotaf3B9Og==
X-Gm-Gg: AR+sD13uOml9x6dB11Ab/6uALAbGJqtp4gK17kjfnNvUBQgI9fGrNTPAKPzeKRIs3HR
 GEy3n6JvtpU17L2Vnj03jyyC2c3IdKAk4yTgu+d+TRbMM1LtbhQzD3uZKB+3RGzWD9gqVmhwgfk
 9O1/A9ognZT+zTfIyoeK7ZCOAJvzNZu1POR5fFA6OV0TwDMQy5M0N5tmHBLsu+VmnRcrLNQkAkv
 Wkc3ONR3vsyJTxOXmyX/TJelQ+JDlNjtyxCOFE3wb/sMoPXgxUoyTbVUIuhqUOw6KGCvwREgj/f
 a8Qq5kkTw0Sx+DnKFAiuj/JGo9dnLaG58LUfGWRqgLS02T/mSHaoDN4NpfC8uRC7suMdpmwrR9Z
 MzAky1bGG8mllfzwX7zT2l9iSNQ94ZimK/lix5nPAlEarQWNrKNVZD1PBkqx3SDhTL10f
X-Received: by 2002:a17:90b:544b:b0:38e:9045:babe with SMTP id
 98e67ed59e1d1-38e9045bb96mr1083208a91.7.1784570715736; 
 Mon, 20 Jul 2026 11:05:15 -0700 (PDT)
X-Received: by 2002:a17:90b:544b:b0:38e:9045:babe with SMTP id
 98e67ed59e1d1-38e9045bb96mr1083165a91.7.1784570715238; 
 Mon, 20 Jul 2026 11:05:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29c2a48sm28700773c88.2.2026.07.20.11.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 11:05:14 -0700 (PDT)
Message-ID: <b20edade-6acf-4fa9-a3b0-93028f34fd01@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:05:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 <87wlupst0e.fsf@draig.linaro.org>
 <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5NiBTYWx0ZWRfX0ZG52kjg/ets
 dbsFfPtBX5Am4dj2wiIRHo4i4YSCGftQLI+OzFg3MnJ3wq203A543eCGUYnmVylhO+6blgg6fhN
 b6ZQUbrazgnMcQR5dQPbrxtvbON6qWQ=
X-Proofpoint-GUID: dqDBGcbjcKpMm2m3DYT9S8AynKW3v4mo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5NiBTYWx0ZWRfX14v1OKS+buji
 tryNxVRrGz9uNA+61Y/b2uDusKMdVoKvLeBpt/PLXiwDcXAzcwWwo/2iv2UNNEyDU4ie57y2nJ7
 xNK3QQ5FfEJYP4f8O7rgl1Q/bn1ooF67L1bgBgOuKs/6b5PEFvUhVuYd5dh7CV4SDiuvB8pRQRM
 hpM6kEPD+13PV3VU0u/kr/cY+Kl/DMGGOn6jSHHP21PpFa5zc0mJrnzQ/XW1L4e402JSrpjw67O
 eTVVfD9A2J8YHV+F3oDaLpGO/tyFpT5XIo/RrAiphB+qQ2vP2vudY9KpwTVvs4RuVO2sGubMemH
 q1KNvShgEXVnOQOH70Ysl4Fdclt4ubnU5nDPWkdlzOT1cewFdjZGVFib5xqyJ//GpPX+H//wZiz
 I3z25r541az5i635BTGG2YmiwA+4CwSb3vTZWW+umHejIOsHuuqfFacv8pjaVcOxEgwOEvYkA5r
 xLnxtSRbUDpvL7pY7xw==
X-Proofpoint-ORIG-GUID: dqDBGcbjcKpMm2m3DYT9S8AynKW3v4mo
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e635c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=A7Bg2S96s5f8cWgcl9kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200196
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/20/2026 10:53 AM, Pierrick Bouvier wrote:
> On 7/20/2026 6:14 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> Those options were useful a few years ago, before containers were
>>> available as an alternative for missing cross compilers. Simplify the
>>> workflow by removing those options and maintaining only the container
>>> based approach.
>>
> 
> I was expecting some discussion around this patch, and to start it when
> the comment comes. Question is "Should we provide this feature or not?".
> I totally agree with you that we need to support other configurations we
> have in our CI, like MacOS and compilers from homebrew.
> 
> However, instead of implementing this by keeping --cross-* options, I
> would be more keen to turn 'cc' into a list, instead of fixed choice.
> 
> For instance, instead of:
> # tests/tcg/aarch64/meson.build
>   tcg_tests += {
>     'aarch64-linux-user': {
>       'cc': 'aarch64-linux-gnu-gcc',
>     ...
> 
> We could have:
>   tcg_tests += {
>     'aarch64-linux-user': {
>       'cc': ['aarch64-linux-gnu-gcc', 'some_other_variant-gcc'],
>     ...
> 
> I think it's a saner choice, because one problem with --cross-* is that
> it allows people and maintainers to have their "own" setup, that are not
> documented anywhere. By forcing compilers to be added to dockerfiles and
> paths to be explicit in arch files, we make sure the same CI is
> reproducible for everyone.
> 
> A good example of that is xtensaeb, which was not in docker container
> file because it could be set with cross-cc-xtensaeb.
> 
>> I'm confused here - I thought we wanted to keep local cross compilers
>> and provide containers as the fallback. Otherwise it will be very
>> difficult to test against newer compilers without having to rebuild the
>> containers.
>>
> 
> That's exactly the point. By making it hard, you force by design things
> to be reproductible by anyone and documented. In this case, by forcing
> the people who wants a newer compiler to provide a dockerfile patch for it.
> 
> Another example is the aarch64 test with have require a bleeding gcc-16.
> It's not even installable via debian repositories at the moment, it
> means the test is just always skipped in CI. So basically, it's not
> testing anything out of the original developer's machine who has the
> "right" setup. In this case, the right fix is not rely on latest gcc,
> but add manual the needed opcode so it works on any version (see patch
> included in current series).
>

See patch 37 (test) and 38 (comment on this test in meson.build).

> For those reasons, I'm really much more in favor to provide a default
> that works out of the box, instead of "it works on my machine with a
> custom configure option".
> 
> What do you think?
> 
>> Currently the MacOS build relies on local compilers built via brew.
>>
> 
> Let me know which compiler is used on MacOS for cross compiling every
> arch, and I can add those to next version, so it can work out of the box.
> 
> Regards,
> Pierrick


