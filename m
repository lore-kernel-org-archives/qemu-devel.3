Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF02C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBcW-0008N6-FD; Fri, 26 Jun 2026 14:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBcL-0008Dd-2x
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:49:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBcI-0004v7-Mm
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:49:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QFiqp51820759
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 18:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ap+V6+Z8J4g/p7EzdbaZu83IL2XzOob07eAXWZqjDwQ=; b=gl6bNsF4LVntkdDa
 TZRtk0moElIbBTgSpm3RBYyhXdyA+lKll+GaJnX6uxAX0rdrT8YehU9OcWo841b4
 KDrutUdbE78IYw04eys1aXxYgiDlZkeWJDRZazN5R6bdBCj0Q0SfPWNrKWlSDxby
 vK0G3Ys+kOGolgMOP/YXgemvhqrc5LngQM2y1kkv3oXiVXtLkzMSUd+k1HgDxU1K
 SwH+XJZATDojim8wZhNmI6OTHjP+Q2Ru7rSlp45K0QZxCUCHLZCMmZO07xyFPSxu
 biMdrhhRDLJncQZOBZWQl1d3nTC9rEErVyZLXFd3I+dyWEUEFsiWXd/0SBDd+DHJ
 f1/vPg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eewc34a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 18:49:27 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139c6673856so2087490c88.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782499767; x=1783104567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ap+V6+Z8J4g/p7EzdbaZu83IL2XzOob07eAXWZqjDwQ=;
 b=GdrgmbM00f8BklfqI/UjPwuGXi4gj38z7L/ni9UyxsBY55OgybusbqDbX1RGJSyxU9
 APxXUnEDlQXaPW2bjNE0GwbieeFa1s9yUq5guiq3dT3aNYPygwXtPXGBhgOVkkaum5Hj
 MNKz2NIwAibzGYK8dnErwS2rckgCLmDmYJHoLgYJ7QbKnN9ngpA8uDIIBrviSfXP0oIP
 PEJNcTBaAQHsvt/Ksie450awUXDsngZqfCOVgzsEQiq1jShoiXLp/6X4tg8gJfdTBgtC
 4x4PGHU1tRWjx5tA5yiwNIdtDMhWXqi6T9njP4v9w/uHfgRJByq7lOStlb7BCNQ42468
 uJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499767; x=1783104567;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ap+V6+Z8J4g/p7EzdbaZu83IL2XzOob07eAXWZqjDwQ=;
 b=SHVKbjAfZuoDXP1azkpn6bjIccSFKUvigfVUXSaNJggo3atjAH9aGtwumOLFOhlm53
 a7AYl31f+gq882vFFy0uYJlP0RI13goCORzyd2QLtXJZ4BJgAmARTBRlXyG2qM9QDZsp
 MKiKorwcXw+tko1CO4vI2SgvxCF7Jf9vJQRW0Af62fsbOb9LPSiSg8cSnO4henmqJIUy
 JFx5Dv+3+sCkI3z7zyrxDBpH/xwouuxP/w1e9BlfSu8xPi8F1rAjlheTrYJ5/Meaw+0J
 /WpG/LcNZjoDDOjaMan4vBasSWhUnk0MP1KDeayVOdzhvmo6C8tlXLCmHjuZFkfvEA/G
 n6tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jf4vBBUNJjemdFzisaD2XzWvHKjdRleeYUaAG/X2EtLZrEWrqLrJvVAnNY3UBzoR04ZYdmFVjObcS@nongnu.org
X-Gm-Message-State: AOJu0YzYN0nPHFgv1oz+YS+3ElvIdqhuD4XZ6BxcY1QdJxGFR+Ziljji
 br/y+iG4z/5D2k0Bp73z1iPce/Jrb/5ZMslk00U19iLQJ+bnGGOwh3/NYYc6gLtCN2m95lGOKa2
 cMNmVCNJwQN0L9MEEWEBWnvYYz3RL8T1jt+Wada3+2ws1O2+cLhhGUM+NNw==
X-Gm-Gg: AfdE7clS0qZ2noty7/v0k+Q5/iNbxqPdZxSZ+QG0BiEZF1jlRjFLWBlf2uMw1IiCqRB
 pHqZE3GbNb2zCcJoUSfLR0DXBCCYvu5dySt2YHOuBb1sCjR2tXxKw2Yb3c9iUHZeHCjAK4+VqnG
 QTTdQkdzW1ad2qB3pdIodAo9GJd74j6+ojPh6zVLouOelAKLOD41hxp168QZ4o9ZSoFnVpr1UwT
 K2n/Nscf6EkOtqEIrjcrJb5CQT4tl2nKbSHjjtswdMKUtAlp3TciM2R5t0poEagVlgt69E+SI/k
 rMtF9PbtVO12RkvuWCQkEeC4byU9Hteiq0xoSnRZ9h3ErL+0NQ+gQVxHbeuclb9tiUcVDzzo4D9
 f2jR9Iu1sh3moUj/CAKhuVQIkzi2j2gyRRfG8jm58tZVvp4jFU5dmKsBLB6qMGJ2Tq1hH04+Lg+
 76Xkk=
X-Received: by 2002:a05:7022:7a2:b0:138:2b3b:8b9a with SMTP id
 a92af1059eb24-139dbaa5d74mr5492906c88.23.1782499766908; 
 Fri, 26 Jun 2026 11:49:26 -0700 (PDT)
X-Received: by 2002:a05:7022:7a2:b0:138:2b3b:8b9a with SMTP id
 a92af1059eb24-139dbaa5d74mr5492883c88.23.1782499766262; 
 Fri, 26 Jun 2026 11:49:26 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e42338f9sm7745731c88.0.2026.06.26.11.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:49:25 -0700 (PDT)
Message-ID: <fe22c259-195c-4032-94dc-7b62fe3f25e3@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 11:49:24 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAGKMO+VVgV_qx9rwz7XQQhW5y9GzjuZJcGfd9ucTGx=Y58pPUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE1NSBTYWx0ZWRfX3mNQMuqNtCNQ
 geC6RkMB63nK5HS/NX7sKWeEKH2Gx1qLgJkyX3waLOorx2oMjAiS+FauKXLudtRE8h+rAm57O5T
 Jmior/i1lxmz3ii7hpravl3dGBBSrTw=
X-Proofpoint-GUID: ltOPYaMNTgMpo4JVylB7M0L_XCTih5rE
X-Proofpoint-ORIG-GUID: ltOPYaMNTgMpo4JVylB7M0L_XCTih5rE
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3ec9b8 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=vBGCoyBw86KDqxnhfUYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE1NSBTYWx0ZWRfX0Yz5hLAoVcn9
 0SK1pN8woMq3ZksY4V75R1zmMmWzMRJGNvdf/FKPX1Bl2F/IXvcijw9rn8dpZ8zaqBRwqkPefOE
 pJV3XytrJrrCkr60iQAxmnseeC5HLUwTYFOFm3qRQzrASj46/L/GqKE5aFo6F2jt7WRWxVYFINS
 9p/9672bFnFWypjVLd0rUL6yCevwM/IYIUO4/oyz4ucRHQjnzfceBSwnJGvQtzf64bzpRuk5cxq
 RWnzNJMySx+QUeEPJ2YxOj2wS06QNBDzhHB/jEj5ojyhYSpSgssf1O7wXAJMhQ0xqOdx/BKvgRb
 qsyBR4W1IBNXL3WRRnXbAvCXTwZ353ODqS7vepIhe7PSXMhIEImtRCpRQxbwJY7KCw2M2ynVLBm
 BJS29l/HJAhPW3zDOThh2NtadABpk0NdmgYtSr7jSPfapKnLWdSkaaaiBG4l0hrME2BKS6XYAuq
 ZG0/3EVHDSfoFDRa0IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260155
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

On 6/26/2026 11:44 AM, linisha wrote:
> Just to clear the confusion, attached the screenshot.
>

Hum interesting.

On my side, reproduced on a clean debian container:

$ git clone https://gitlab.com/qemu-project/qemu --depth=1 &&
cd qemu && ./scripts/get_maintainer.pl -f docs/
Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:General
Documenta...)
qemu-devel@nongnu.org (open list:All patches CC here)

Maybe we have a funny joke hiding there with mingw/windows.

> Best regards,
> Linisha
> 
> On Sat, Jun 27, 2026 at 12:10 AM linisha <linisha232@gmail.com> wrote:
>>
>> Hi Pierrick,
>>
>> Quick correction to my last reply — I checked again more carefully and
>> get_maintainer.pl -f docs/ still says "No maintainers found" on my
>> tree (origin/master), even after git pull. It only lists recent
>> contributors. So whatever change adds you to MAINTAINERS isn't in my
>> tree yet — could you point me to the commit/branch?
>>
>> Apologies for the confusion.
>>
>> Best regards,
>> Linisha
>>
>> On Sat, Jun 27, 2026 at 12:08 AM linisha <linisha232@gmail.com> wrote:
>>>
>>> Hi Pierrick,
>>>
>>> You're right — my tree was outdated. I just ran git pull and now
>>> scripts/get_maintainer.pl -f docs/ does show you as maintainer for
>>> General Documentation. Sorry for the miss; I'll make sure to pull and
>>> re-check maintainers before sending future versions.
>>>
>>> Best regards,
>>> Linisha
>>>
>>> On Fri, Jun 26, 2026 at 11:58 PM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 6/26/2026 10:44 AM, linisha wrote:
>>>>> Hi Daniel, Pierrick,
>>>>>
>>>>> Thank you, Daniel, for the Reviewed-by tag and the wrapping feedback.
>>>>>
>>>>> Pierrick — I didn't intentionally remove anyone. I used
>>>>> scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
>>>>> Philippe Mathieu-Daudé, Richard Henderson, Alex Bennée, and Cédric Le
>>>>> Goater, and I picked CCs from that list along with people who
>>>>> responded to v1. You weren't in the script's output, so I didn't know
>>>>> to include you. Apologies for the miss — I'll CC you on any future v3.
>>>>>
>>>>
>>>> Thanks for your answer.
>>>>
>>>> Just to dig this further, is your tree up to date?
>>>>
>>>> When running it on my side (from upstream/master), I get:
>>>> $ scripts/get_maintainer.pl -f docs/
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:General
>>>> Documenta...)
>>>> qemu-devel@nongnu.org (open list:All patches CC here)
>>>>
>>>>> Daniel — I'll send a v3 with the commit message body properly
>>>>> line-wrapped to 76 characters. Let me know if there are other changes
>>>>> you'd like at the same time.
>>>>>
>>>>> Best regards, Linisha
>>>>>
>>>>> On Fri, Jun 26, 2026 at 9:09 PM Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> On 6/26/2026 3:09 AM, Daniel P. Berrangé wrote:
>>>>>>> CC Pierrick as docs maintainer.
>>>>>>>
>>>>>>
>>>>>> Thanks Daniel.
>>>>>>
>>>>>> I wonder how I was not in original recipients for this patch.
>>>>>> @Linisha: did you explicitly set list of recipients, or remove some people?
>>>>>>
>>>>>>> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
>>>>>>>> Add a note near the start of the introduction explaining that QEMU options, properties, and command lines may differ between target architectures and machine types. This helps prevent confusion when examples shown for one architecture do not work for another, such as the pflash0/pflash1 options visible in -machine help on some machines but not others.
>>>>>>>
>>>>>>> Please ensure commit messages are line wrapped.
>>>>>>>
>>>>>>>>
>>>>>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>>>>>>>
>>>>>>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
>>>>>>>> Signed-off-by: Linisha <linisha232@gmail.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> v2: Take a different approach based on review feedback from Daniel
>>>>>>>>     Berrangé and Peter Maydell. Instead of incorrectly claiming
>>>>>>>>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
>>>>>>>>     machines too), add a general note near the start of the introduction
>>>>>>>>     about how options, properties, and command lines may differ between
>>>>>>>>     target architectures and machine types.
>>>>>>>>
>>>>>>>>
>>>>>>>>  docs/system/introduction.rst | 9 +++++++++
>>>>>>>>  1 file changed, 9 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
>>>>>>>> index bec7291e47..8d9ef61d26 100644
>>>>>>>> --- a/docs/system/introduction.rst
>>>>>>>> +++ b/docs/system/introduction.rst
>>>>>>>> @@ -1,6 +1,15 @@
>>>>>>>>  Introduction
>>>>>>>>  ============
>>>>>>>>
>>>>>>>> +.. note::
>>>>>>>> +   QEMU supports many different target CPU architectures and many
>>>>>>>> +   different machine types for each architecture. Options, properties,
>>>>>>>> +   and command lines that work for one architecture or machine type
>>>>>>>> +   will not necessarily work on another. The examples shown in this
>>>>>>>> +   manual are specific to the architecture and machine type being
>>>>>>>> +   demonstrated. When in doubt, consult the documentation for your
>>>>>>>> +   specific target architecture and machine type.
>>>>>>>> +
>>>>>>>
>>>>>>> Not convinced many people will read this, but I gues it doesn't
>>>>>>> hurt.
>>>>>>>
>>>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>>
>>>>>>>
>>>>>>>>  .. _Accelerators:
>>>>>>>>
>>>>>>>>  Virtualisation Accelerators
>>>>>>>> --
>>>>>>>> 2.47.0.windows.1
>>>>>>>>
>>>>>>>
>>>>>>> With regards,
>>>>>>> Daniel
>>>>>>
>>>>


