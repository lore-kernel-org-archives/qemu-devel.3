Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9A606D804
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+U38t1F;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KfGgEk8c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3pD-0005BI-EZ; Thu, 05 Nov 2026 15:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP3of-0005AS-UJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:12:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP3od-0006BQ-51
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 15:12:08 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeB4a2433592
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 20:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +dEpD0CQxlFY5AsGMlazR2KALkxz/6cYyjrvJMsX7EU=; b=n+U38t1FelM4CblD
 t+s0HhRoeeW1PgyAobhKlsyfs5tPAxDHKfk72/h9BaIcixb5M7qXF3b0inf5iFgM
 iiJhC+w2Hzu29X4oMi/JZflagIxYQjxWXaqvoGuhxlZPA8eYILEI9gO0jS6qzEhn
 K2XkUwbB7cx5M1cr14RaOeGP08UCmtB2Epy0rj5GHJj6bWMFSGMOmP0Bn8YBb6gx
 u1SUBRJhoxrDzEiv0NBgzi7+qPlqNMVgNdgpQlofzAxj1Oa8PjK0WQoUGrIh3CN1
 tfYUWUvKWo2R88DpfUNnvJENnfsJujPuy91/QncTHBeNFOQDiwU//dt3q9jZodQn
 z+tFZA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd2nnd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 20:12:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36d69ab3c2bso2387112eec.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793909523; x=1794514323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+dEpD0CQxlFY5AsGMlazR2KALkxz/6cYyjrvJMsX7EU=;
 b=KfGgEk8cFfexDvzpWT8sVDvNEhOlYzPUny2OCeOODhuZkV4M67wLNN8sqcwyXQJMWg
 z3/7PgATXTg48Y3XJhKNIb3AvnbvAexPpIPuUk8qybrBOX/3mzxCvUQVMMq6xF/5f7iC
 tByXak1zy7mdjHvdHBnsGM1W5RKsCl+NcjhbFATtHIRmLCzipyMS6FWPtVQ8jHMQBjO7
 7AGuG03orBvu2AcPi2bs5/B/fSHV1O1eQJwlHP1cXNgr2UKV4OCzs4ItuauZpP7m9Xy2
 oWi4qn3YMD6vk5Yvr+YgMmG/S8QOAUkkJWRYD9gDtszzys4Knod3kC+ynIrNpDtUGw7G
 yN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909523; x=1794514323;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+dEpD0CQxlFY5AsGMlazR2KALkxz/6cYyjrvJMsX7EU=;
 b=p1NmUS6Y6cC/QDgoZRIL0C8oz2C+KkQR7xUs/6p5lngqwVfFNW0FrEqAZ9MLP7iz2y
 pwP2D64nGrMBvvKXXgXUCaT+gmlTmd9RhMlY+ukp85RUkaAYpNZJkSDRu8sMkqur6KZJ
 EysdSVmMyAN/xzvA8H7k4rBP+BV4b9JDbx35svo9wLHkvaRdObuDWCr6CBgrZTpTcqKp
 9exHS0wjNeVV4yQZHk6vBMpHeEwkeryvCrMuTjSvjQynfuE+a0VKnglJ8ftYrQrtXvDb
 bg6Cx0mCDHjeLrkgUDGw+lVIu0erwLbfa0s0+bLyXeSB4bVz9v1t7ZWzOxLvOf6/KQq+
 q7Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxj2szszEiJG0U4DdmNQYjfQuRmKeqnK0uZ7wj6mMhPBiFFcPdDDmYdVD/Ud3EYDs/tegbeDy6+36wu@nongnu.org
X-Gm-Message-State: APuU4Z8knG4+tITCD8QRwr8L9K/r9SPWgA1w4fUxtuUAvkBpoNF7zxQJ
 7kekjvZOiObmzjdnxmn/hs35ac5jWDLOtIuJO5/94t+UDpMVKWJnk5eoP4f19GJ94xwmyRcKk7O
 U1gYcK9Bx++TfsPjtPzUpaU3TaYGiHWuBlnJ/2KzlL0IAAKW5lTCg0afxNw==
X-Gm-Gg: AYBFou1L8FYUeW4/O7B79DxnYWtgMbtWNNM2FfzhkK6TA5XqVoYTqn21jX0OKeNR4ec
 VGaI3X0KTrSd8tB7jEcz+/AH3nt0Rb3ZS+m2Zd2+Yqjqv0B3hrUB+76PR7nOtYek75fwfjMm1o1
 OE1Qt6dt2xRVXMLScQ83/Qw+epPbnJSQYy0PnBH+qa1bitB8rhmcEcDoKVeANH2LD/gNYA5bNn2
 WUjzKwP9jyrcxxvTrLoHX6FgP5U847TlOpZXfYvw7gB3Boil/xGIM9ogFDwUTTHfe6FNrjB/ksv
 dJjxT4EIj97uwSxxFUZsU4+pRVyJfOMBdzabiEIMwSZE8eZvVhd9yj3f3xH2llcJaJgqE+cjkjP
 tYM6aXACl2E8P9BhxQUoDwHbFS3wx7OcH6VSxUhm3SNMqmYI0/hv7U92Oy3q+VfkPyE9Iyc2uLV
 ReTssMF/58vANoIv+i//6BjhNb8uUogVHeTxHtHVN9HA==
X-Received: by 2002:a05:7300:c3a6:b0:36c:a1ef:f8f7 with SMTP id
 5a478bee46e88-36f729cfa92mr386106eec.4.1793909522784; 
 Thu, 05 Nov 2026 12:12:02 -0800 (PST)
X-Received: by 2002:a05:7300:c3a6:b0:36c:a1ef:f8f7 with SMTP id
 5a478bee46e88-36f729cfa92mr386063eec.4.1793909522151; 
 Thu, 05 Nov 2026 12:12:02 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f7369c69fsm470900eec.6.2026.11.05.12.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 12:11:59 -0800 (PST)
Message-ID: <3829e1be-09a6-4582-a506-21c6625f5cbd@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 12:11:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/10] i386, AGENTS.md, meson changes for QEMU 11.2 soft
 freeze
To: luoyonggang@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261103133500.2295582-1-pbonzini@redhat.com>
 <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
 <5de7e4a0-70dc-4a0a-936d-d66b1eefcc09@oss.qualcomm.com>
 <CAE2XoE-o_K=npvHPPb+pxeS=hFwEYJh-PYEVGrcbeF4nAW+ULg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-o_K=npvHPPb+pxeS=hFwEYJh-PYEVGrcbeF4nAW+ULg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MCBTYWx0ZWRfX8ypX1uAeD6dk
 oDVwKc5SOzvu7L8nZ2NNZncsEB8WPsmMozEXnYVWCzR3vbXsJ4Rrh9V56TgOWPCviQGWI08SNuN
 FecF2CjiREckno6mSOLmg/BhuvNAB0Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MCBTYWx0ZWRfX9vWcQjUFJRPg
 b1nx7S4vv5BRysuvAjHC9+5dczbt5lkYbVnjMtLuPrnpbNua3edxKurMxS6jGyYQjHWfGfwxjoq
 96he2JyIxxvNRGRG1j1z14BDPBjYkpTpYnZ+JQewnxSbs14HOqfyw7j3G3Br9ni51QaQvNyt9pp
 SlAuJdVgKfGhZ6sXJ3flfo5xbkDWtuvFLD8PvNGp0Z53FchDhNuE8YKA1E0HfsxDxZkKglWBt8v
 YH8YvYmPU6tmRg84rJQvC/MSRSLexVIBsylbpOfC5vWvsAptdpD5d1CQIPbB6rWxf+yd0xTLYnz
 uqo6UY3OBUsOOIbxhdvzFKxXyrYuk+wgiRV84l1PU1bAB9FCAjvbKOI72gynLjlWBJMYpCFfZMr
 Jj74e7YdG9Thkkmq5ZaoK/jjy2zBRvIuiSiyUWBz6mlIftP33TQVGYuSV8atNp5gg2CLUW9Zuha
 aT1loijylgaLRoZU8xA==
X-Proofpoint-ORIG-GUID: 1BEVM-d9NRqYbmTaERzoXocJ5f58rli3
X-Proofpoint-GUID: 1BEVM-d9NRqYbmTaERzoXocJ5f58rli3
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aece313 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=UbqguA5DT6hmXDJ0Q3cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050080
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 11:57 AM, Yonggang Luo wrote:
> On Fri, Nov 6, 2026 at 3:53 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 11/5/2026 2:27 AM, Peter Maydell wrote:
>>> On Tue, 3 Nov 2026 at 13:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>
>>>> The following changes since commit 74f7bf4c59e6b6d50dbc6e124d93440be8be4386:
>>>>
>>>>   Merge tag 'pull-target-arm-20261102-1' of https://gitlab.com/pm215/qemu into staging (2026-11-02 20:19:27 -0800)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>>>
>>>> for you to fetch changes up to ab78ac76f44a1241e76fd32d248df62d83f1ea58:
>>>>
>>>>   meson: rewrite scripts/qemu-version.sh directly in meson.build (2026-11-03 14:31:24 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> * target/i386/tcg: bugfixes and cleanups
>>>> * AGENTS.md: add final instructions
>>>> * meson: rewrite scripts/qemu-version.sh directly in meson.build
>>>>
>>>> ----------------------------------------------------------------
>>>
>>> The qemu-version.h changes here seem to have broken incremental builds:
>>>
>>> In file included from ../../monitor/qmp-cmds-control.c:28:
>>> /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
>>> qemu-version.h: No such file or directory
>>>    11 | #include "qemu-version.h"
>>>       |          ^~~~~~~~~~~~~~~~
>>> compilation terminated.
>>>
>>> This happens even though the incremental rebuild decided it had
>>> to re-run configure.
>>>
>>> Blowing away the build tree and doing a complete rebuild avoids the
>>> error, but it would be nice for incremental builds to work.
>>>
>>
>> It works fine on my side, with both ninja and make. qemu-version.h is
>> correctly regenerated as the first target being executed.
>>
>> Can you reproduce this with a clean build folder?
> 
> Hi, it's for incremental builds, that is a build (exists) before these patches,
> then reset hard to the version after this PR, then ninja will fail.
> Clean build folder won't trigger issue. but for fast bisect, issues will happen.
>

I see, unfortunately there are multiple occurrences of such subtle
breaking when moving between commits in our history already. Especially
for current issue, it's now pushed and there, so we can't do anything to
avoid bisect hitting this eventually.

One nice and bulletproof solution is to rely on ccache, and allow
ourselves to delete a build folder (a full ccache rebuild is less than
20 sec on my machine).

> 
>>
>>> thanks
>>> -- PMM
>>>
>>
>>
> 
> 


