Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656ADC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmyki-0003OD-RR; Thu, 23 Jul 2026 15:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmykb-0003Mv-2B
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 15:06:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmykZ-00028d-Cz
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 15:06:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NIm6GW1845180
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 19:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0gbGvwIt040piHOzFZ9ef4u0FviSstlfdMyIhMdoCao=; b=LweHcgxrtldwMK2i
 MnZ+u/m9RPQSSjHro4iSGBMtTY4N2uMWA53OFYzuUA1wcrVvoT2bCShImUJxm0rQ
 FSiVYfrw9dhNrfoOZUPKqiOkb/pVP6ZNXsC7yqT3qvA5KIPeZZACQcNMyGAdc3mq
 qAjNU7hEeSF2YR2hopizVWyS9VKSfmxjug5jaPKW5JRYXamsnpNmSAU8vqOpE3Fg
 3F++cmKvu78/HeZKY6qfq1KFZINsRTYdSW1v9KApqUakCy8MNTa1IEGrooUQCJid
 IXz/Bhj3gfcAjyMYoGmIumnt8mtzwldX5IM9D7pVNDG2xN7oFBh6/7VWlzwi88nC
 uOaL2w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkn9a153e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 19:06:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso14189485ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784833588; x=1785438388; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0gbGvwIt040piHOzFZ9ef4u0FviSstlfdMyIhMdoCao=;
 b=B/fOMeU9xxdKa0dhRRgtMOXDuP/9RUx2nvVN4Od/VHXLQZlnsMPd1tysGRFIU9YtAo
 xTnMZQ+96P6o4OqggFLhGp73S3wc/LeLGx9g55QpHxITxX6MvYZIyKJFhmvw3gPdVvlT
 +hNMvIUqq1XCCb21fRRvFFnqkzQyMrI2jpqetxUF6Q/EyvTcswXn1eTx/8uYtX9UuXOH
 kMHdkUf0ZmNvYA1QaLEwyQsEwCGmEHD9BSMLqUkgUmHL0HYluqcccI+eTSBcTbnzf8Gy
 /ZLg0S/naovN+TpsN6wDJ45sHYlQBXSFYVyvVA+ZH7rWBtnvGuuJdw4dSbdBde3lPNa1
 ZIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784833588; x=1785438388;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0gbGvwIt040piHOzFZ9ef4u0FviSstlfdMyIhMdoCao=;
 b=C7CGF9b++SM6Axsw+vil9aLJXe7+Ayoh9uzcjJCCoOZ5Cth9gXBwlrOb9RJqBFyxZA
 +OI6LS+3pF9pSWvYmUQ/ao+M6pcibqiMSBEukslWFeGiprj2Vem2f5fKirKV4s90r6wR
 5Op7IGwFLA3MO3ZuhHbyKeNKhz21P1NKWF1ZbtVU2MvKCKP+ycoq6qY9YQ6qdt4GQEnf
 F6y4LG1P4nrUDPsmQPk0lxDWKlAzUSQUamUmPwntAy8SkNIHClTvZcJXFvXNUEt8Ofik
 mVkR5NdpBbIjasUjnsJWsIqFS5iDXz8kuy6UMyT+aUlE5i/t26IxpSnZ7Q4/nGIAQng/
 epxg==
X-Gm-Message-State: AOJu0Ywm4mTLTo75oG+3bCDnxPHTd3jgwxqB+4K7irC4KFIr/pvudH8Q
 NuiuzZ1nrZa2AEq16uzogaC/H/DmKsukk3/IXD8tamj8jn3GapJp0fLqVMt/8qTuofaYo8PfNwF
 F0m6+qlpVC0UhQSXx+/EY5UW4SldluPkNObxTJiO8yRHR6HChqPYEsMJzjg==
X-Gm-Gg: AR+sD10amFYONhC3OZp4SowqDMaFqeuxuhIYLiSW9Tejuq92nOBvaoQptNpMq/vaqo+
 lm6sP+65kFH6gpVtQX9DNQOz2DotB6RyRoRY/A5hb8Ee9ZvQa679L/9JaI2FdEiww6XpC5DcSTd
 tN2NyqQ1FMUGp6XDCs1uoEsdYet83qhcGkwMM8Tvs0Qx+uwpFIw85BC0nIgBg8bI0XFjciFz78M
 3I56b9F33OJB/7lWVYUlt36+k1HFXVKubrMqhtNXsAIPgWpgtyqyUel7VfJbURL+qwhndOmdAuI
 Giz+5Oh4ml97U3ipIl8DyXjnpwr2DjPaTrRusRYMKaAl0dpJkJ7AXtKVW7PyQB1gWFfwpSmPKdf
 mHMx+wBQKxKLDiLTK9B2q30j7yxPW00CCWgWmwcmikTDXs7ES5iPfkx/w4/ZNEy3R/RR5
X-Received: by 2002:a17:903:ac4:b0:2ca:ed41:d331 with SMTP id
 d9443c01a7336-2cfa708d196mr53797635ad.45.1784833588217; 
 Thu, 23 Jul 2026 12:06:28 -0700 (PDT)
X-Received: by 2002:a17:903:ac4:b0:2ca:ed41:d331 with SMTP id
 d9443c01a7336-2cfa708d196mr53797215ad.45.1784833587744; 
 Thu, 23 Jul 2026 12:06:27 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df0686fsm22118653eec.14.2026.07.23.12.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 12:06:27 -0700 (PDT)
Message-ID: <16961455-1a2f-4312-8644-304fc97e5b75@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:06:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
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
 <87se59r999.fsf@draig.linaro.org>
 <c16b4480-06fd-4d96-b628-5c423d300988@oss.qualcomm.com>
 <87mrvhr3co.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87mrvhr3co.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4NSBTYWx0ZWRfXwMamENxF/Usi
 0w8MOVw9342qdTF8SYkTiRlIje82yoHsBop1TycdMfD6PyxF8SDntTJvNCbiYutSnuJUcChlEiw
 gTqs+71A4VaKDz5/Sih4zGfpbT8rJTqKERssU6PaU8TeJc8cGuGkS/Ku2AW/d+Q9A0UDsqO9fLu
 XBlE9RbOwZqCUc5rT5V7k1P5Gfja2Wz7z+jkh1R/jChLxqfq4eL6+qCmC4ALdQQ2O6QY557v38r
 Vgn36MOVn2Fl2N4L5iknWWqS46OlYGCju+mXIlC1hZRvrQpxabjCEj4JzBSQiN9ufn3NP5EDLJi
 1xIo0pIJVx6m/5p84i7dSpt6k96tO4PhPjtz1GBGyebNK6O5cRux01SgqrMU9klRJm9dwLDGa/e
 9kVJrYIcs1lY2rKYthVOqrNajfkHa1z9WLqr4VrvN1alOmO8QBINp0fV0eeO/u7b9P4q5aZXODU
 A9SrEnXkTnu2q+yTMnQ==
X-Proofpoint-ORIG-GUID: XO1u1bphoNKA6FX68ZU1I9SqXVy4h-a3
X-Proofpoint-GUID: XO1u1bphoNKA6FX68ZU1I9SqXVy4h-a3
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a626634 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ZMZP4gtslqF4p43hPaYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE4NSBTYWx0ZWRfXwVazvahhUx9K
 m2/sfa/m55m59ue/EciSXtyxui6n6ls4BxgEJbHVHxhLaBmnEwZYOWqPaOQQjxw9rKNUo0lO+ba
 lombWljKR1bD3ch56oXbY39y2enHv6Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230185
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

On 7/23/2026 11:02 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 7/23/2026 8:55 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 7/20/2026 6:14 AM, Alex Bennée wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> Those options were useful a few years ago, before containers were
>>>>>> available as an alternative for missing cross compilers. Simplify the
>>>>>> workflow by removing those options and maintaining only the container
>>>>>> based approach.
>>>>>
>>>>
>>>> I was expecting some discussion around this patch, and to start it when
>>>> the comment comes. Question is "Should we provide this feature or not?".
>>>> I totally agree with you that we need to support other configurations we
>>>> have in our CI, like MacOS and compilers from homebrew.
>>>>
> <snip>
>>
>> The way I see it is that we offer native cross compilers (with a focus
>> on debian at the moment), and the containerized ones: people have a choice.
>> We can add any additional compiler name for other distros.
>> Also, as Ilya mentioned before, cross compiler on fedora, for instance,
>> are not providing any sysroot. So it makes them unusable in our case.
> 
> No sysroot at all - even for compiler headers? We don't need the linux
> sysroot for building softmmu tests.
>

No header nor any library, a sysroot is both. I'm not sure why they
implemented it this way, but that's what Ilya mentioned and that I could
check (see his report on previous version that it was not working on
fedora).

>> So I'm not sure which other distro you would like to support that is not
>> (alpine, arch, slack, other?).
>>
>> In all cases, just let me know what are your exact requirements (distro
>> list and set of compilers) and I would be happy to make it work just as
>> you expect on all those platforms.
> 
> That's not really the point. I use Debian, partly because its range of
> supported cross compilers is so great. But we don't have a
> comprehensive survey of all the systems potential developers could have
> and with this change we now say they have to jump through hoops to be
> able to compile something when they likely have a cross-compiler
> available.
> 
> And of course non-Linux systems are far less likely to have podman or
> docker available. MacOS doesn't by default, Windows? BSDs? BeOS?
>

I feel that it's not an impossible task, but I see there is too much
resistance to remove it. I'll implement the existing -cross-cc-* options.

>>
>>>> I think it's a saner choice, because one problem with --cross-* is that
>>>> it allows people and maintainers to have their "own" setup, that are not
>>>> documented anywhere. By forcing compilers to be added to dockerfiles and
>>>> paths to be explicit in arch files, we make sure the same CI is
>>>> reproducible for everyone.
>>>
>>> I agree the ideal is everything is dockerised for CI but there are times
>>> its not practical:
>>>
>>>   - working with very new features on bleeding edge compilers
>>>   - binary only toolchains for the more niche architectures
>>>   - unable to run any containers
>>>   - running the test inside containers (this is why
>>>     debian-all-test-cross has qemu-minimal pre-reqs)
>>>
>>
>> The point of containerization is to hide those details in a reproducible
>> recipe. For instance, we could definitely provide bleeding edge gcc to
>> have the latest features.
>>
>> If test relies on a specific machine setup, it's basically dead code: CI
>> and other devs can't run it. That's why containerization is important.
> 
> For CI yes - but not for someone developing something and writing tests
> they may never even upstream.
> 

Thanks,
Pierrick

