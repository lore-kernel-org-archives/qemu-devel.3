Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7D1CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShCj-0003wO-Du; Thu, 28 May 2026 16:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wShCh-0003vh-ER
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:19:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wShCe-0002fx-UH
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:19:42 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SHhYlM4031415
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PSfeNjhoHrdVb6wesFoDLATObw+P4e0uohH0GBBkoZQ=; b=PdlzdafhGB4eWdkS
 179OOaaQ1XhYgZGab6vS/+Y8xUdsmy8RKIkLMy9v1ouO2f6GiZ/I5ojR/DBTcW74
 J2/ebjP3L/ZwfKwZh+GCNo2G5wpysF88OLaOnS3FKRhH6X0A25xN0+4eOVtMhiYZ
 1vbkvMEbdx9+aBmYZY6eF8YBED2urFyuhixPthKcTinfIZe94QWa867BylulVEFe
 Uz0/nNqD4TK4YpuOFoGEfAgJ1p8brZWlFgrTmejVlY+UUqCaBzav1gCBmBhzqMbZ
 uMNr9mBM10ny6kVu5m/qUlX35DxaIjuqNbvF/+sxGoYlZ1JGG37erHVHNBb8HOUQ
 mNNMSQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y4vj1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:19:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-135916eefa0so251687c88.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779999578; x=1780604378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PSfeNjhoHrdVb6wesFoDLATObw+P4e0uohH0GBBkoZQ=;
 b=fEfbMIggQmc+xZMLOVLLrmVvtXBEfD1qvEzkO+M3IexNioYzCAIqBrrW4/siZV1azG
 yK+ZyXD8C+g6VbtA5mgUWNYjfgNQR9zHckciYy9Pi3zuPjTgQ4AACggxpzyJ4C21nzEs
 iExedhe/Cp4VmaUFj7WvA3AjmQVgnlyShhN3IsHDd54Jds3/vvVBpQx0QlK0ge/Mj7RF
 9luwXelCRwK9NuYExB9bDjuGfQZjG9XVTlowkvOG1LdyGFh6B3kq7xqpEJ2a/PPolvl5
 OkLc3Q9kbhbeXbsLhGqymeHbIMUwaqfiN8jaovHwW51JQWA2Lbl+LeEUeGqx6cOFMANE
 nwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999578; x=1780604378;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PSfeNjhoHrdVb6wesFoDLATObw+P4e0uohH0GBBkoZQ=;
 b=I3cCUX/c09lUYDc9FdoZGtAAxI9Shq/1oqI/ELJhSeJoz0raUzHIahoweQrf607Nv+
 6+C1jChPEVMpsokV1C9ppIuWF/jGweuNhHaWWn8p9Mnh/nmKy0Ng2RZe2talr11tXYW3
 8dfaixr6XA818VayNx9UH/R3lKw9he+Ru5FFU0+rgv6R9sfCO3+l1pYHTSfsXADhl+go
 bmBNn3hs4CWSwasShCkjjXwVtVTrqukQs9tVEKQ+zVdzUfCgijo7IqeSwjzICmfrNmsS
 mt5iAtRS8hHb4/NmrvSb5ZmePWdheQWjj7BaYPv9Xx/IIfTQWs4YmjKtC07WO0iqamDP
 CBow==
X-Gm-Message-State: AOJu0Yx5d9hzeP8zmDtHIxpWN6tT+MpdeSGnLQBxZn7beMvCiaJNyphN
 wYWlTL9Ya73xDRbbAgXXWCJd2XYWguJ714qM7YiXIfet9kCfLMYSK4wnLbSOLw6PnIrkOtOaip4
 KHo28rJlfv5GqJqcYmJGvuH5lHvlnd1Rn0O5JFw9DEsMufSwDvijrQ6zTRA==
X-Gm-Gg: Acq92OHK0vIoWwl+NpYqSe2h04KAZ8WidgzGI5evWdFdLvce2tn94iXm8EJLiWQVnhr
 n48yxOcuQaazOMKfHYePdHg3lmKSrP5zqFuQtflNgCJCHvDE1ssVo+WUdRoNt5YcJtMUrKB/vwl
 c+SgMd5gesMfT6ejOMvKnulHyXByi/Xd14gQl1NVHWLS+/++wGLjCiUsAHaf15TOBFlwEPGy43L
 Fayf3mytiesZS/SWeaRHmME6265kfYM51FpinXzouSDwp/ubMmjQOLmMX5W4G5qwRU/tTC0r96r
 9XJ0y8q6atwAYy+aleZX7BRAweQ6wGB3KeC9NbZfD1R8AuSIaHD7Bo0YpeKwF4CK9iTTGXYAKzL
 SaTAVJu1sOVUq5GhdZ7QwbLH6CgAGUHQ4NNbaSEjsgld03ZVOLj492LbN5qTKOb1rTBFlK/NBMY
 V5+bAm7lR5xoSwpHoTwugYx5cD
X-Received: by 2002:a05:7022:1b05:b0:12d:de3f:d844 with SMTP id
 a92af1059eb24-137a89dd386mr213015c88.39.1779999577841; 
 Thu, 28 May 2026 13:19:37 -0700 (PDT)
X-Received: by 2002:a05:7022:1b05:b0:12d:de3f:d844 with SMTP id
 a92af1059eb24-137a89dd386mr213002c88.39.1779999577243; 
 Thu, 28 May 2026 13:19:37 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137a958ac5dsm218485c88.5.2026.05.28.13.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:19:36 -0700 (PDT)
Message-ID: <22335206-2442-4215-a797-c10e74c7e110@oss.qualcomm.com>
Date: Thu, 28 May 2026 13:19:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
 <87cxymec7b.fsf@draig.linaro.org>
 <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
 <0f73d717-1621-4c3f-9c5e-9bfdfaffb0b8@oss.qualcomm.com>
 <877bor9vor.fsf@draig.linaro.org>
 <7d58926d-a36d-430f-828e-7ebdd9cc4eb5@oss.qualcomm.com>
 <87qzmyzbut.fsf@draig.linaro.org>
 <06092208-1b56-4fea-8d92-bf035fbd0fa3@oss.qualcomm.com>
 <87fr3eyrvp.fsf@draig.linaro.org>
 <8a878679-733c-451c-8053-663a74f8d4a7@oss.qualcomm.com>
 <87a4tlz897.fsf@draig.linaro.org>
 <86385e93-5425-4145-8a9f-0f72ed5de022@oss.qualcomm.com>
 <87o6hzx2np.fsf@draig.linaro.org>
 <5a4eedbb-483c-40ea-a4dd-b34a4b7d7b6e@oss.qualcomm.com>
 <871pevqumz.fsf@draig.linaro.org>
 <98156f95-e6bf-4061-8e3e-9e884ebc3e5e@oss.qualcomm.com>
 <87v7c7pagp.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87v7c7pagp.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIwNCBTYWx0ZWRfX2PsDYS6Y/rde
 Sdpyps9gvzAcFCP2p8nB/0o9UsH8G12sKBKaj5ajXhV2pEjX9ZF7abLOa79yqUAOHvS+A88wEiu
 9QGDYArrPH9oJIVm2Vki6MY4dhgtxR/WWeA9Lpqfuu6nNsvLXJVPWAy3PFhkSXipa9/fhkHz5Ud
 2+BGJfuXqsZrtXPu9aeclaL9fEjUfTU8x4mYsU8lQIrBDBOUjOCsgS7ILibPlu3VE4+7wqARS/m
 OACDOr5MTycP2QXHjpURDuThzyLFAlUcLQ77hLOg/xns1apccy5bBT1TanRuiSaRcm4DFEzw8L5
 KU4T3aQqRqjgDTwfwD6q0rSDvnEkTX4j409jtNSyuwqOiOXLPufZNPaLsULTW5sBFZdNVCElO4Z
 I5LnC9LgZU0tZmTKZ49xiEZPwor/+33QImdHjuWcXIaBVEt+hH7ZWwEyHokrUK7UdmhrLNG1KxU
 dSX4wlCSwszH0jD7i1w==
X-Authority-Analysis: v=2.4 cv=feidDUQF c=1 sm=1 tr=0 ts=6a18a35a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=yZ_YHYr3lP6itjBwDFYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: zr9Qu6ADuQfBcwe53QlwB2XQKOnVll78
X-Proofpoint-ORIG-GUID: zr9Qu6ADuQfBcwe53QlwB2XQKOnVll78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280204
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

On 5/28/2026 1:04 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 5/28/2026 11:03 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 5/28/2026 3:13 AM, Alex Bennée wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> On 5/26/2026 11:17 PM, Alex Bennée wrote:
>>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>>
>>>>> <snip>
>>>>>>>
>>>>>>> What do you mean? I run check-tcg all the time.
>>>>>>>
>>>>>>> Which containers fail to build for you? The main cross-compiler one
>>>>>>> (debian-all-test-cross) is built all the time.
>>> <snip>
>>>>>> I'm a bit tired of seeing patches in your subsystems get stuck for
>>>>>> weeks, without any proper review, to finally be (re)posted again in a
>>>>>> new series, blocked for more weeks, and finally reach upstream one month
>>>>>> later or worse. It's truly exhausting for everyone contributing in such
>>>>>> places.
>>>>>
>>>>> What can I say - reviews are welcome. I always list what patches are
>>>>> still waiting for review in the cover letter. I should also add for
>>>>> testing/next I try to be extra careful that regressions don't slip in
>>>>> because keeping the testing sub-system stable is important to support
>>>>> things like bisection.
>>>>>
>>>>
>>>> The main issue with your personal workflow, which is "reposting existing
>>>> series concatenated in a new single series", is that it adds a lot of
>>>> latency. Basically, if one patch fails, or is not reviewed, the whole
>>>> thing is blocked. And that is a problem. I don't see what it's supposed
>>>> to achieve, since it's halfway between a series, and a PR, without being
>>>> one or the other.
>>>>
>>>> TLDR: the problem is how long things are between receiving reviewed-by,
>>>> and being in a pull request in your subsystems.
>>>>
>>>> For instance, in current series, there are multiple sub series. Some of
>>>> them are fully reviewed and ready to go, they can be sent as PR
>>>> independently.
>>>>
>>>> I remember you mentioned several times that you like to have a "single
>>>> branch". I have the same workflow, and it absolutely does not prevent to
>>>> send multiple PR or series in parallel.
>>>
>>> I do split stuff out when it makes sense, but look at testing/next:
>>>
>>> e02df7f4810 * testing/next MAINTAINERS: Cover python.docker with Python library section
>>> 4fcb3a8c07a * MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>>> b554638aea6 * MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>>> 8417a661600 * MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch section
>>> 0f57fbac5bc * MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>>>
>>> Maintainers updates aren't critical to get in now.
>>>
>>
>> The more you wait, the more it might create conflicts. That's basic
>> software engineering, and where the term Continuous integration comes
>> from. It does not mean "run a GitLab pipeline", it means integrate
>> often, *continuously*, with low latency.
>>
>> There has been concrete examples of why delaying created an issue in the
>> past. In the current series, "docker: Remove LegacyKeyValueFormat*"
>> basically blocks any other change in concerned files, as soon as it does
>> not land. At least those two could have been sent as soon as possible.
>>
>> If you'd send a PR regularly (at least every week), it would be less a
>> problem. Miss the train? get the next one.
>>
>> If you want a good analogy:
>> Problem is that your train is leaving at random time, and it has several
>> wagons, which increase the risk of a mechanical failure every time. As a
>> result, passengers are stuck waiting.
>>
>>> f80f388a538 * gitlab: update issue template for binary test cases
>>> 4e7de923722 * gitlab: add MacOS 26 job on gitlab runner
>>> e0692ad4b23 * gitlab: add initial MacOS 15 on gitlab runner
>>> 1299b5aec2f * ci: drop cirrus MacOS build
>>>
>>> None of these matter without bellow
>>>
>>> dd2db9273be * accel/tcg: move jit thread manipulation into do_tb_phys_invalidate
>>>
>>> b60553095bb * tests/Makefile.include: add binary dependency to run-tcg-tests-% rules
>>> bcde94b9315 * tests/Makefile.include: fix typo in comment
>>>
>>> Why take the chance to break the build when the changes are in service
>>> of the wider patch? The more runs through the CI to shake out anything
>>> the better.
>>>
>>>> If tooling is the limitation, please take a look to those (ugly) scripts
>>>> for inspiration. AI can probably rewrite this better than me in 10 min.
>>>> With this, sending a series or a PR is a complete no-op for me, I just
>>>> wait for CI to run, and send it when ready 2h later.
>>>
>>> Tooling isn't the issue - but I'm never going to be doing multiple PRs a
>>> week because each one has a degree of latency due to CI coverage.
>>>
>>
>> Sorry, but this sentence doesn't make any sense at all.
>> What is the "degree of latency due to CI coverage"?
>>
>> CI takes less than 2 hours to run, you can run it 4 times within a
>> working day. 5 days a week. That's 20 chances to send a PR.
>> The only latency is human based, and a way to solve it is to automate.
>> Lack of tooling *is* the problem in this situation.
>>
>> You can't take a lot of pride in automating things with AI, and claim
>> it's impossible to automate sending a series of patch and run a CI
>> pipeline from it. Use AI if you want, but please apply it everywhere
>> it's needed.
>>
>>>> Saying "people have to accept my tempo" is not acceptable. Fix the
>>>> tooling instead.
>>>
>>> I think it is fundamentally down to the maintainer what tempo they are
>>> happy and able to work at. If you wish to take on responsibility for more
>>> areas of the code base then be my guest.
>>>
>>
>> There is a difference between being really busy and just adding latency
>> artificially because "I said so". We worked together, so I can make the
>> difference between the two.
>>
>> I would be happy to help maintain any part that needs help. Maintaining
>> plugins was a suggestion that came from Richard, and yes, I was open to
>> do it for a long time, especially after experimenting weeks of latency
>> to see patches get merged, and this several times.
>>
>> I stepped in for docs because we identified there was a need for it.
>> I also talked with you in private to help on linux-user and you
>> explicitly asked me to wait, without any specific reason. Now Helge is
>> maintaining it and doing an excellent job, I'm really glad he stepped in.
>>
>> I would be happy to help co-maintain tests/tcg and help this move to
>> meson. Unfortunately, you snipped that part without even trying to
>> answer to my proposal of helping by making a small proof of concept.
>>
>> Coming back to your proposal, do you wanna share maintainership on
>> tests/tcg/multiarch and tests/tcg?
> 
> I'm happy to turn over the maintinership of tests/tcg to you with the
> new meson based system.
>

Sure. Let's focus on seeing how it will look like, and I'll be looking
forward to see your review of it.

>>
>>>>
>>>> Regards,
>>>> Pierrick
>>>
> 


