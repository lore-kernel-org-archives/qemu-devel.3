Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4220C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 19:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdC04-0007IA-EZ; Fri, 26 Jun 2026 15:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdC02-0007Hq-K9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 15:14:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdC00-0004So-Ev
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 15:14:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8bTJ2264982
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 19:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1wR+vg8SOqoyZ4CIowpSxKqQWYmnCTqL1xnH9jvOXsc=; b=Np71hXKu6Rs5mU1d
 YOmQfEFmZcayR7/OvifSZ55rGD2E51zcFCPQPoSU8825bcksB42LtA0lr7OqQQAI
 Ks5OLZUgaD8yUXIzt+XG0p4LobB2nUai3isTuIsoP92W0iyWFkHjjtoV9b+ZZmEb
 dhpp+v5L6r+2figCjFXLv3qsU2OZCphIbO9E6HgL1ckYlSUTSjj9NNEmAUKI4f6C
 zLwYywmUPBN388fcen0OZq6SzXgsXu2Mw1NSnaUUfT7S63gQxssqgjEoWC1Xpw2d
 OzS32t4nw4NW0HhTBgo9lqH3lxkzoegD4LLs/CiPWxl+8kTFQlnkoxr9zt0aCoZ5
 aucJEg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eewc5tb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 19:13:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c62861b3bso2932460eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782501238; x=1783106038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1wR+vg8SOqoyZ4CIowpSxKqQWYmnCTqL1xnH9jvOXsc=;
 b=TNJx5jY9MgI95BSsZhjJXiy8S6dsUN6aFC9M1wmmHn/HwLWR4R+TBsgbNX2h1oSbUb
 GNWYytptxydGdVhEUvj2d1aeLB7qgukItEk/lvh+SRTO2G0JL0FdiVHO5T8stVQRCUP8
 budN1bWk0UCZkeNXemFTZV17sNt1rncTMxOP02eEiXm+Od3HXSTaDJQgPZk+qnDO0Wpl
 97acJf2aC+8NEIjGPrJDx7dcJ2rIWhwbmDgqtWwtL4mJzajsONRqAkGDlHv4gLuYHSXz
 sSe1+T9FFOg2dlraNFaKFx32KllYKF+/PuH+rMPpBsDZLN++uyEyMAcU1oq5Xwgf330F
 ybJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782501238; x=1783106038;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1wR+vg8SOqoyZ4CIowpSxKqQWYmnCTqL1xnH9jvOXsc=;
 b=grDx/321rb8HkmXebtbtBY+Gq2A1HEvYIg78Ta8tZixCfpR5RRzDuB9BuLTyLK3N4i
 rDITitJzAxMWOynsoqJ7vxolQ/arIKUzw+EmGtsDkvLv+x4GzDi0cU6T7YcRGF6pW1gw
 5TOCsUE6yeKZZC8HvAVVxQywUjeXQpR1EudZMCEp6HxEK5FXD2b26SSg9a32pMd3YBow
 C4eyjVAl7il8azpRfm8ttqFwy4BJjGcdOzzVn6kC5WFjadF7LLq8/n/2ORDPIyzjlsjK
 XOU4AM55DCUOpu2RGTzN196nZU3jGBnPv1axEfh5VB6KFBHs9gY1qByEtrEJQVUCZcxQ
 oMsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFwmHxTu8lbEHqW07qxZ57XhrbxaxPMjYrY3kO/F7s4EHoF9eS9V2C7LfBfg5AzQaf3m56ZSUcMKyl@nongnu.org
X-Gm-Message-State: AOJu0YzAZH6G0BXk5m5oO4WW0BzpGfX5jQ5qcvWEd1BFV7CmH3DjE/w8
 q6rHWcnrfX6XB3FZ1ZaOYQulNxfPWDYvNS3xjxfqgesySq5GqHy6reL0nEaFK95lWL3OD68IJ24
 Kw/JM7swa74l6MYybUu+RlikrqjXXrwmWZUMiwpDJflVvB37Y+XfLAScu/w==
X-Gm-Gg: AfdE7cleD2MoJX1/7Rv3qpmS0YpuUXhWnPkaFoF8QRWudNk7sGDeETiFIAOFFzVfpqZ
 sWZjGoLjL3eZ20dERp+pxhAXxHwpU/T6CDYOecMAoyo1Yw6JaaijBsJ1TayYYSInE8vB0mZniNH
 eaudgu8LnbVk9hV0tDUqPLUPFfFkr5hFMSIslV6Y7P6aZHenCu594h8w8fCG7MB5NBz/blHnnoy
 LjB6tUqQUNVxXiz6GSgEACLXXorE2RYDlDBENY5q9auEaeZGkzAtsMI+OM4lz0qoAuNO2kCGBU6
 8FJwygoi4fklucLUDomr7/yoZhLb+/IqRVB2S2t/ZG+rdMu4ZkrTm9ouivxKtK3rhsE2Ut6dBFj
 OTUHQa4z1PKOQWTz98+Rd6uMs5Ra/SOEfwFqIejUkVNu6W8rs6JpbwSmuRr2J81unbiNQ68a9aY
 zpp7w=
X-Received: by 2002:a05:7300:818a:b0:30c:7ccb:189e with SMTP id
 5a478bee46e88-30caae2d7d4mr1280708eec.6.1782501237873; 
 Fri, 26 Jun 2026 12:13:57 -0700 (PDT)
X-Received: by 2002:a05:7300:818a:b0:30c:7ccb:189e with SMTP id
 5a478bee46e88-30caae2d7d4mr1280675eec.6.1782501237235; 
 Fri, 26 Jun 2026 12:13:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f31866sm24766800c88.1.2026.06.26.12.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 12:13:56 -0700 (PDT)
Message-ID: <3eeed5ef-792b-40db-a49f-8fdf904664cc@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 12:13:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: linisha <linisha232@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, mjt@tls.msk.ru,
 philmd@mailo.com
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com> <aj5P0n03aKv93uci@redhat.com>
 <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
 <CAGKMO+VCZ_3cPWx000N_+REsEK+gQg8RCWJcx7YEchUcy20V-Q@mail.gmail.com>
 <c0292d61-3915-416f-a6e1-d8498dcd42e9@oss.qualcomm.com>
 <CAGKMO+XpdeOQwqqp6sq+q2gbGBkH-inBU0B49buohQ6OWhOxUA@mail.gmail.com>
 <CAGKMO+XRcM86qk_X3qaWeYjvxnHWj-jsyWC-FoBLkYBemHJgtA@mail.gmail.com>
 <CAGKMO+VVgV_qx9rwz7XQQhW5y9GzjuZJcGfd9ucTGx=Y58pPUg@mail.gmail.com>
 <fe22c259-195c-4032-94dc-7b62fe3f25e3@oss.qualcomm.com>
 <CAGKMO+VzDjFZj_TDwrSPqL3vMaqwy9gEh6GA3Jxst59AJpxRxg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAGKMO+VzDjFZj_TDwrSPqL3vMaqwy9gEh6GA3Jxst59AJpxRxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE1OSBTYWx0ZWRfX+zFLhoQ9L59c
 nGy/rmaWmfN8kwV3gBnsBmiXM2fJEsnfcB/WnDrFf0WW1nSSg8JArXFduEAeQYEeMDaP6hZU+EF
 YKe7oNQYs+Lkv5XDzsZUoYoFQ3UYyoU=
X-Proofpoint-GUID: EP-4Q_RVd9R5B94Lhm9DLCCdKOsnVzx1
X-Proofpoint-ORIG-GUID: EP-4Q_RVd9R5B94Lhm9DLCCdKOsnVzx1
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3ecf76 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=czFU1XZlGIcXm0JCWBEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE1OSBTYWx0ZWRfX0UGsM+j7ZI1V
 GyRpv0ixoJ+3ctsAmDh2jpA+Q/3ShfbdaZ3H4t2ItQG1WCid30fRQE+4x2DFg3nM2LMg8PeEph1
 hHwY0fIgctm4NfsGxZxkF/QAjWngaQammDMmuU9rDC4Y0qXajoQypUYkcsi1k4dXXoGFKu/LJFm
 BUP/soRgHP6Jh+B4920z51BCRjyau2Ax8h6kLXE8fcafLlm8RqvhLSzZSCztYFQkG80rJKs0gau
 yAyfAtekoKoJlfLFaLqQM8pyZSzES/dJWzYM9KMn8KN/k2HD5nUkbTQnOg3FKPSxxtPjfMuIKJD
 61WP9hdO0bsc4IMVzFRkAIslE64Vx4QSopEcoU4YiiFlECoGeHPN5NcKFQv3cwZ21Ws9fC18nNi
 avIZlkJyg5NLWBk50EE5Z3cld+m1U8t9DbmGhhTVSDiFAyqNnehd/SmQUZM7BbpVuR7fh7HppRQ
 RFM4bjC7Yp/X7586WtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260159
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

On 6/26/2026 11:58 AM, linisha wrote:
> Hmm that would explain it! I'm on Git Bash / MinGW on Windows, so
> there may indeed be a line-ending or Perl quirk affecting how the
> script parses MAINTAINERS. Good to know, I'll keep this in mind and
> double-check the MAINTAINERS file directly when picking CCs in the
> future, rather than relying solely on the script's output.
>

In case your (corporate) machine allows it, you can also use WSL to have
a native Linux env instead of using MSYS2.
In my experience it works very well.

> On Sat, Jun 27, 2026 at 12:19 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 6/26/2026 11:44 AM, linisha wrote:
>>> Just to clear the confusion, attached the screenshot.
>>>
>>
>> Hum interesting.
>>
>> On my side, reproduced on a clean debian container:
>>
>> $ git clone https://gitlab.com/qemu-project/qemu --depth=1 &&
>> cd qemu && ./scripts/get_maintainer.pl -f docs/
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:General
>> Documenta...)
>> qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> Maybe we have a funny joke hiding there with mingw/windows.
>>
>>> Best regards,
>>> Linisha
>>>
>>> On Sat, Jun 27, 2026 at 12:10 AM linisha <linisha232@gmail.com> wrote:
>>>>
>>>> Hi Pierrick,
>>>>
>>>> Quick correction to my last reply — I checked again more carefully and
>>>> get_maintainer.pl -f docs/ still says "No maintainers found" on my
>>>> tree (origin/master), even after git pull. It only lists recent
>>>> contributors. So whatever change adds you to MAINTAINERS isn't in my
>>>> tree yet — could you point me to the commit/branch?
>>>>
>>>> Apologies for the confusion.
>>>>
>>>> Best regards,
>>>> Linisha
>>>>
>>>> On Sat, Jun 27, 2026 at 12:08 AM linisha <linisha232@gmail.com> wrote:
>>>>>
>>>>> Hi Pierrick,
>>>>>
>>>>> You're right — my tree was outdated. I just ran git pull and now
>>>>> scripts/get_maintainer.pl -f docs/ does show you as maintainer for
>>>>> General Documentation. Sorry for the miss; I'll make sure to pull and
>>>>> re-check maintainers before sending future versions.
>>>>>
>>>>> Best regards,
>>>>> Linisha
>>>>>
>>>>> On Fri, Jun 26, 2026 at 11:58 PM Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> On 6/26/2026 10:44 AM, linisha wrote:
>>>>>>> Hi Daniel, Pierrick,
>>>>>>>
>>>>>>> Thank you, Daniel, for the Reviewed-by tag and the wrapping feedback.
>>>>>>>
>>>>>>> Pierrick — I didn't intentionally remove anyone. I used
>>>>>>> scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
>>>>>>> Philippe Mathieu-Daudé, Richard Henderson, Alex Bennée, and Cédric Le
>>>>>>> Goater, and I picked CCs from that list along with people who
>>>>>>> responded to v1. You weren't in the script's output, so I didn't know
>>>>>>> to include you. Apologies for the miss — I'll CC you on any future v3.
>>>>>>>
>>>>>>
>>>>>> Thanks for your answer.
>>>>>>
>>>>>> Just to dig this further, is your tree up to date?
>>>>>>
>>>>>> When running it on my side (from upstream/master), I get:
>>>>>> $ scripts/get_maintainer.pl -f docs/
>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:General
>>>>>> Documenta...)
>>>>>> qemu-devel@nongnu.org (open list:All patches CC here)
>>>>>>
>>>>>>> Daniel — I'll send a v3 with the commit message body properly
>>>>>>> line-wrapped to 76 characters. Let me know if there are other changes
>>>>>>> you'd like at the same time.
>>>>>>>
>>>>>>> Best regards, Linisha
>>>>>>>
>>>>>>> On Fri, Jun 26, 2026 at 9:09 PM Pierrick Bouvier
>>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>>
>>>>>>>> On 6/26/2026 3:09 AM, Daniel P. Berrangé wrote:
>>>>>>>>> CC Pierrick as docs maintainer.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks Daniel.
>>>>>>>>
>>>>>>>> I wonder how I was not in original recipients for this patch.
>>>>>>>> @Linisha: did you explicitly set list of recipients, or remove some people?
>>>>>>>>
>>>>>>>>> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
>>>>>>>>>> Add a note near the start of the introduction explaining that QEMU options, properties, and command lines may differ between target architectures and machine types. This helps prevent confusion when examples shown for one architecture do not work for another, such as the pflash0/pflash1 options visible in -machine help on some machines but not others.
>>>>>>>>>
>>>>>>>>> Please ensure commit messages are line wrapped.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>>>>>>>>>
>>>>>>>>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
>>>>>>>>>> Signed-off-by: Linisha <linisha232@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> v2: Take a different approach based on review feedback from Daniel
>>>>>>>>>>     Berrangé and Peter Maydell. Instead of incorrectly claiming
>>>>>>>>>>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
>>>>>>>>>>     machines too), add a general note near the start of the introduction
>>>>>>>>>>     about how options, properties, and command lines may differ between
>>>>>>>>>>     target architectures and machine types.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>  docs/system/introduction.rst | 9 +++++++++
>>>>>>>>>>  1 file changed, 9 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
>>>>>>>>>> index bec7291e47..8d9ef61d26 100644
>>>>>>>>>> --- a/docs/system/introduction.rst
>>>>>>>>>> +++ b/docs/system/introduction.rst
>>>>>>>>>> @@ -1,6 +1,15 @@
>>>>>>>>>>  Introduction
>>>>>>>>>>  ============
>>>>>>>>>>
>>>>>>>>>> +.. note::
>>>>>>>>>> +   QEMU supports many different target CPU architectures and many
>>>>>>>>>> +   different machine types for each architecture. Options, properties,
>>>>>>>>>> +   and command lines that work for one architecture or machine type
>>>>>>>>>> +   will not necessarily work on another. The examples shown in this
>>>>>>>>>> +   manual are specific to the architecture and machine type being
>>>>>>>>>> +   demonstrated. When in doubt, consult the documentation for your
>>>>>>>>>> +   specific target architecture and machine type.
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> Not convinced many people will read this, but I gues it doesn't
>>>>>>>>> hurt.
>>>>>>>>>
>>>>>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>  .. _Accelerators:
>>>>>>>>>>
>>>>>>>>>>  Virtualisation Accelerators
>>>>>>>>>> --
>>>>>>>>>> 2.47.0.windows.1
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> With regards,
>>>>>>>>> Daniel
>>>>>>>>
>>>>>>
>>


