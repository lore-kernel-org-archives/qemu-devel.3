Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F9606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BHW+hAlA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UtVDWCVZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMWmk-0005Wv-Cy; Thu, 29 Oct 2026 16:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMWmC-0005Uv-3P
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:31:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMWm7-0005ht-VD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:31:07 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjX222103033
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 20:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eFleKu6h+cOyxoLTZCVw2CQdUsraLo/G5TTXNWHxWHU=; b=BHW+hAlAIMY4WVXY
 VrwvtDUf/gPL309DqL8I7uwOJ/QMoVWl+E5CwSZiQg/ewZGlU/+bxln12XkFzRC7
 TNlbFcAi2eioQv/vakyUVGxNBAmTxv6n5FH5Qg1Tkm+p1dl3Sd9BJgSpu5QpzFQm
 Dogw3tfWVyK7ihDEZ44lxh7j8EuNFLinHOup2UOOPZtzylI4/KNLi3raCuG6XaCt
 eVXfWaNPYC4sA0xqKgyoRHdKb3kBHLl4Tb9/bBuW6TvAADxvdAJm4GeiexmYvijT
 lt8AWsQGNATocFdoiXoPGzTgn6mqCkDLl4t7EvUWqIFlRvpHSGUudlxQBtgmkKHQ
 6uKsDw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44qapvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 20:31:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a223755e4so306745eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305860; x=1793910660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eFleKu6h+cOyxoLTZCVw2CQdUsraLo/G5TTXNWHxWHU=;
 b=UtVDWCVZlD7NSAo/n0aAba6GiM13+stb0kAVAJ8TydpZ0ZlvcdAzCNxaYOMeB4+JSZ
 7rzd2yBab0tZLMzX6qvoYmiHph+GsTZu08J0nPBiQyyyTlZJet2HqCqIqAiyxUglWS6V
 GWB7MUum/NIiVMfK9ioUoRQp3hz8gi93l5YGOLk43MUWYsYISlqlrZTteiX5sMgWo/RO
 IDLbEjBl39Vsr+8ahUCLMNMcJAuQ8ekq3OFDS9mE/6UtC2BCH2K+3lJjosPZucF0IzFd
 dcfN779bYHZGD9a8Dbb5KQz0gRE6+ddS9ShupztmOia93aURLIqi/9cx+tkz3/J+5ZnI
 ho+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305860; x=1793910660;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eFleKu6h+cOyxoLTZCVw2CQdUsraLo/G5TTXNWHxWHU=;
 b=wDSIPY52Zir75Bb/N0Yl/+mVznggZ7OxVbMLzDddjjRAWFiAdyt7JlYldVJkbnWf9L
 4Ovcd13MvbYJvMoFHhtFXcgzSzttxt5iM4w1Ztt2niQjJYDgEiejaXkyT3Rb0vH/YsBn
 jpXmcEjeTlmyO1fjtWRH0bgTCuJ37R0ogG3HdQa3lFqb5lHrm15iHGBgdbQu334fbc4f
 Lh912pMJ0ws4fQErVM4EksrCCrpSjemiaoszWSqi0oZK/Q8m1rdu3YO/j+nFnH2Xypeo
 DXVgLnbB+1yO1sqxxUDMYNOKv3m+nekMcwlSkWH4zUy8WhSV3mZOYfMq4mtQCRl4JpXr
 Ed5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYawXsfdxRJ5saZGEgpyTqjm7AgtXBsawKhEIgjPc//jRUqJnK2Z6V0YjV/vUKINCzsxkrlkdj95vR@nongnu.org
X-Gm-Message-State: AFq9FYIEeqfl/QsdcnQZzF94/Nk7wY1kOkMGVFXIOymT9Rzc+Elrha3A
 SapOYKPAVCrGs90lmTMN35BY3Z2bHBRji+47UDmavVY2QtaLhBBNeTYEKTJcag5+3qiL6Ka4f3R
 nXsKO/LXmdjzoFmzcmYYXTqjH892CGqX5w1AnYnOmB8JvL6G2Axhmur6Vgw==
X-Gm-Gg: AYBFou1v3KLPVnd619eIv6vH3dcCUvtLjUMgQeeAT1fpWyvdQtaUeBBRwCj4WVC8yTI
 2MxsvDiqk77bOnR4Ip/gwdzA+1yajpXP5K1xD0mxUxNkCtl4rJfI4mJllRBKzNp+iWfC7Pzs+ub
 kS0Yr4uP762dTBtJHxHDogDPtssxfpyegyJTVGF3bVObkQ9lPmg5spmKuyf81mdtbapoJN8b4ZZ
 t0UDEReu1uqR4euY8zEJc2YenLfx6K986NY4gVDJAo0oUVtHHAGTwgxxZHfc9u+/bUEo4QDw3e+
 JNpYUkvkZ7hXTyh2Vkj+N36j4uZ0Xq1VDbEATeeVNJb+kaGLXGsMa0jFj5/FGaur+6vlS3zW+DF
 ro2lYC/oAq+90sqxbwPkkBhmRob6okh+wdsVYGHTgN7G3Za+M/743U92+VIALEKALLc7IT9gkZS
 s7fGaOX0/B1GWMnhZ7Evn4P6IjNR4ZDO/rzqlMeVcqi3E=
X-Received: by 2002:a05:7022:418a:b0:195:e4b9:d326 with SMTP id
 a92af1059eb24-1ac5b9cb638mr241175c88.12.1793305859987; 
 Thu, 29 Oct 2026 13:30:59 -0700 (PDT)
X-Received: by 2002:a05:7022:418a:b0:195:e4b9:d326 with SMTP id
 a92af1059eb24-1ac5b9cb638mr241115c88.12.1793305859214; 
 Thu, 29 Oct 2026 13:30:59 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1abcd6f1sm921096c88.20.2026.10.29.13.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 13:30:57 -0700 (PDT)
Message-ID: <b7942592-928a-42fa-ba2c-a815492077da@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 12:30:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] tests/docker/dockerfiles: add release.docker
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com, 
 mjt@tls.msk.ru, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
 <20261029000853.15166-2-pierrick.bouvier@oss.qualcomm.com>
 <87ld7gin6q.fsf@suse.de>
 <7757e99b-0338-4508-b36f-9460d4efdb2f@oss.qualcomm.com>
 <87fqxoic5s.fsf@suse.de>
 <796b02d4-9cb0-4d04-a2cf-ca167fb01eb9@oss.qualcomm.com>
 <87cxssi9kr.fsf@suse.de>
 <f14977de-111d-451f-9bf9-872f7d233739@oss.qualcomm.com>
 <87a4nwi7y5.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87a4nwi7y5.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfX/E+pMkRM/Ch+
 V5tN4CTVkhR/BcpiSyOOdBo6NGMYrvkhUoyH5+t4DDvX0KPIgUDIYFww0widnPkF6vaffOJjgoe
 3W4qWflh6t3N+6ZEeihPLZrRgiuqIOc=
X-Proofpoint-ORIG-GUID: kO3iHhl5jSbo109uerfxEQoYGIpM-R-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfX05aMXx484/PM
 f4wUHR4MEJVSlLVov3GTCW91i+fL6CIlKtI2T3q3bIXqkvu8bjpa6ckeG2ENaWZNm6c8hcc4bAt
 fZJDPggDOBOnjeX7uMVPrUG38zjnNq8SGXZTjezkjSPrw8aq2bqRlEQk6tZlEQIzRe0DJhxRxTl
 ACuQlkXoy0yODhVt5Ie6zT1AYTWhel7KxXyYs77Q9+I+pbZnvIJu7HmLq7UsEwhZLMFxuL+HQVF
 9PZyJf9eXZZMhC/2Yn/dCtaB6TuTBDxIIwCddsC9S7GFuId0XCpWh7/puM63ImNaxS7cZ4bJIdE
 0xZxPJJQhpkzCOgJK3bKdGDsBy52dLpLTS+5KJZjfktJ62XzBf28Cv4KAy1uEBI726O1gYIMZFz
 jmnn7Ih5yqgGE7uwyLY8d5+vbQ5pgdFCYbAHEsE3WWbxlUXNiQCRgoykFsx+GAea3lytufJSzYp
 4LN28/evopyNw4882Nw==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae3ad05 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8 a=7ZklagOdOPq31Uo9tPcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-GUID: kO3iHhl5jSbo109uerfxEQoYGIpM-R-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 12:10 PM, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 10/29/2026 11:35 AM, Fabiano Rosas wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 10/29/2026 10:39 AM, Fabiano Rosas wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> On 10/29/2026 6:41 AM, Fabiano Rosas wrote:
>>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>>
>>>>>>>> This new dockerfile allows to build a distroless image containing only
>>>>>>>> qemu stripped release binaries, their lib dependencies, and installed
>>>>>>>> artifacts (roms, keymap, ...). There is no shell, no python, nothing
>>>>>>>> else. This is achieved thanks to a multi-stage build, where we add qemu
>>>>>>>> binaries, artifacts and libraries in a new scratch image. Image has
>>>>>>>> the minimal size possible.
>>>>>>>>
>>>>>>>> This is based on Ubuntu, which has the advantage to have working
>>>>>>>> containers available down to 14.04. Debian old old stable have broken
>>>>>>>> apt sources for instance.
>>>>>>>>
>>>>>>>> This unique dockerfile works for all qemu versions >= 3.1.0 (2018).
>>>>>>>> We could build down to v0.12.0, but it would require more tweaks in the
>>>>>>>> dockerfile, so we keep it simple instead.
>>>>>>>>
>>>>>>>> To build the image, you need to provide a qemu and ubuntu version:
>>>>>>>> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
>>>>>>>>
>>>>>>>> To run it, as there is no shell, and no defined entrypoint, you need to
>>>>>>>> choose the binary you want explicitely:
>>>>>>>> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>>>>>>>>
>>>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>>>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++++
>>>>>>>>  1 file changed, 48 insertions(+)
>>>>>>>>  create mode 100644 tests/docker/dockerfiles/release.docker
>>>>>>>>
>>>>>>>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
>>>>>>>> new file mode 100644
>>>>>>>> index 00000000000..ca6babde01e
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/tests/docker/dockerfiles/release.docker
>>>>>>>> @@ -0,0 +1,48 @@
>>>>>>>> +ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
>>>>>>>> +
>>>>>>>> +FROM ubuntu:$UBUNTU_VERSION AS build
>>>>>>>> +
>>>>>>>> +# add deb-src for apt build-dep
>>>>>>>> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
>>>>>>>> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
>>>>>>>> +# archive.canonical.com is not reachable anymore, and cause a long timeout
>>>>>>>> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
>>>>>>>> +
>>>>>>>> +# build dependencies
>>>>>>>> +RUN apt update && \
>>>>>>>> +env DEBIAN_FRONTEND=noninteractive apt install -y git build-essential flex bison
>>>>>>>> +RUN apt update && \
>>>>>>>> +env DEBIAN_FRONTEND=noninteractive apt build-dep -y --arch-only qemu
>>>>>>>> +
>>>>>>>> +ARG QEMU_VERSION
>>>>>>>> +RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
>>>>>>>> +ARG QEMU_REPO="https://gitlab.com/qemu-project/qemu.git"
>>>>>>>> +
>>>>>>>> +RUN cd /tmp && \
>>>>>>>> +mkdir qemu && cd qemu && git init && \
>>>>>>>> +git remote add origin "${QEMU_REPO}" && \
>>>>>>>> +git fetch origin "${QEMU_VERSION}" --depth 1 && \
>>>>>>>> +git checkout FETCH_HEAD && \
>>>>>>>> +./configure --prefix=/opt/qemu --disable-docs --disable-werror && \
>>>>>>>> +make install -j $(nproc) && \
>>>>>>>> +strip /opt/qemu/bin/* && \
>>>>>>>
>>>>>>> For the record, here I included a 'cp <list of bins> /opt/qemu/bin' line
>>>>>>> to make migration-test work from inside the container:
>>>>>>>
>>>>>>> migration-test
>>>>>>> sh
>>>>>>> env
>>>>>>> docker (installed as docker.io up there)
>>>>>>> cat
>>>>>>>
>>>>>>
>>>>>> You mean by mounting current folder in the container?
>>>>>>
>>>>>
>>>>> I mean having the test binary present in the container as well.
>>>>>
>>>>> This is something specific to migration compat testing: to avoid having
>>>>> issues due to features mismatches, we run the older version of
>>>>> migration-test when testing two different QEMU versions.
>>>>>
>>>>> But then...
>>>>> $ git checkout <old tag>
>>>>> $ make check-build
>>>>> $ ./migration-test <QEMU old container> <QEMU new container>
>>>>>
>>>>> is kind of wasteful. I can simply build a container with QEMU +
>>>>> migration-test already in it and invoke:
>>>>>
>>>>> $ ./<migration-test old container> <QEMU old container> <QEMU new container>
>>>>>
>>>>
>>>> Ok, I see. I'm not very familiar with migration testing, and assumed the
>>>> logic was opposite (that migration-test is backward compatible to test
>>>> from old versions).
>>>>
>>>
>>> It was the original idea, but we noticed it was way easier to just pin
>>> the test.
>>>
>>
>> I guess there are good reasons for it, but it seems like it would be
>> much better to work from current HEAD instead of having to checkout and
>> build an older version of the test.
> 
> There are advantages to using the old tests, maybe the main one is that
> we never need to think about older versions when writing the tests.
> What was there at the time is what's supported and that's it. If an old
> test breaks with a new QEMU, then the users will probably see the exact
> same breakage.
> 
>> Flagging sub test per QEMU version does not seem too complex to
>> implement (min_version=8.0.x, so this test is skipped when running with
>> an older QEMU).
>>
> 
> These are big integration tests that all run the entire migration
> process from end to end. If they were smaller unit tests, then it would
> be indeed simpler. But I confess we didn't try too hard.
> 
>>>> But migration-test is not included in old container, since it's a test
>>>> binary (thus not installed). I feel that for this case, you need to
>>>> build from sources, at least to get migration-test-old.
>>>>
>>>
>>> It's built inside the container along with QEMU. The cp line I added
>>> brings it over.
>>>
>>
>> Got you.
>>
>>>>>> I'm not against it, but I feel that if we go this way, it's just easier
>>>>>> to say "let's use the full base image", since it will become "I need to
>>>>>> run python, and X, and Y, and Z".
>>>>>>
>>>>>
>>>>> I think we should merge this series as is. However if we intend to use
>>>>> it in the future for something more complex, something like the above
>>>>> will probably come up. Anyway, I posted literally "for the record".
>>>>>
>>>>
>>>> Sure, I'm just interested to make something useful for you. If it's half
>>>> baked, there is little value in merging this.
>>>>
>>>
>>> I don't want to enlarge this container too much. In its current form
>>> it's also useful to others.
>>>
>>
>> Yes, I'll merge it as it is for now.
>>
> 
> Yep, thanks again!
>

Feel free to send a patch in the future to add deps and extra binaries
with an associated --build-arg INCLUDE_TEST_BINARIES.

As long as it's not the default behavior, there is no problem to include it.

Regards,
Pierrick

