Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VsOYsWbj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VVYo0zQa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMW2R-0007rY-Te; Thu, 29 Oct 2026 15:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMW2P-0007nY-M8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:43:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMW2N-0008DS-MR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:43:49 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD3HR1143409
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /4/3hwqqfAuHi2Rx1DHtYAONY+OMoXV50y7coG0r8iY=; b=VsOYsWbjJNbQdlvL
 hKvCogvDe22Il9tYhvPZDUQVYTCoH5RfO3fjllqPGfiXHJtJA6jxEdC1w2NWIPEP
 pA82WtJFqGk17CSN5WYoRry+qBjaIFRpSLXLVCKUCcieDp573MBYQxL/F5IU4bwN
 LtZDz4RNRZf1g1sE6zgkyShOSUxTvxY2zV8BhRbT2SuRt7IW2j81YRodFpQUr5j7
 bx9m5kx5D05gjPrgaTCmH1Kv37D+jw7xyDSq8cu9pynUYkBldVPty/T9RWhboO9d
 EzuJFMwcp+6IxboFFJNtPzp9Jpn/ofmnluKI6ZdhaluRLib570hFtdHDtOqVSbx3
 5zKukw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76ck0wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:43:46 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso4141591c88.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793303025; x=1793907825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/4/3hwqqfAuHi2Rx1DHtYAONY+OMoXV50y7coG0r8iY=;
 b=VVYo0zQaB7UZ0cvSaS5YZSGtPZMsQAikD9CIQZzRkC42Bw3zbbj+lGdHJ5I+skDfhO
 Qpy5y67TYjx/COFNZHXnUVO0y6NadQHZzoiMsO5xw5S5u4iZqu8i9s0LhvXVBch41C/w
 mV5dXsZaZA3oSzvhmnC+7GoPC6CSNLa/6Ccz6XNwG5e72i1903Hs5GwPtlhmq7RGwKvY
 RKc45BMgsHZF8Z41ao1OnouHuQyknlkHrWTkJ4e66oh2rd7oStRIy5jljBhgEw8XVwX6
 OtIFvfzm+ElEoZnFOgtqFtwYrDk+sZCKNnREl6WHnEbaJmAFA9AJNhiUmQMn8IDkVA0L
 frqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303025; x=1793907825;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/4/3hwqqfAuHi2Rx1DHtYAONY+OMoXV50y7coG0r8iY=;
 b=dI4t6cQhzpDQ9IN7PrugHaKWcMzzLQ1z6G2qK6Pho9DsCMIpSKety7kNp0xqfkDEQc
 AKD6CnlaK4qlAotlmzuz9zelPJCEMPc94C19/vxUT4fwgsusFZDUw+Okcf3EUdw1pDx0
 6JTKKKT5acBmHmSptGgO3ZZ9W1MArjmM13JXb0r9pqIAw7NEloXPvY6eyw/Kvjye+xU8
 /NaWPt+yAF775i2GpmydcYrvhPzj01Y9e/I3wEUKMWItvNcEJ4nwV8PpbqCBLZFM9qq0
 RcsvEyLWp5dOYefdkh8nTZRZHrFZkSzPv5BfTjZAhwsnauMqm7+4Hf8oppDEbssh07Nh
 aHeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJCgPLvXuREHlHXMphGr4JZTG9wa4WnCaTxoflZ9sQsKPoTzhAUfWDfSVj9Gr1f/kI4YszckBYx87a@nongnu.org
X-Gm-Message-State: AFq9FYK0IRPzOP0A4UHMSWD2rUMsE2S7eoYdZvzBFKpsgPJB7YXjtX/+
 xWKduwpxHgZVgh6Xe76vgJBv/kYeiIAfRSF+ZLIkvODnz3lL4qzU0DIrFzbwNTpIjrREQx9uDom
 SBav1f3Kr2plqSMRvSQvkwiU//YHYVhAuYcbjqbhG0FLNd0+GCHL1CyEHcw==
X-Gm-Gg: AYBFou31Xn0KIAs0E8CFK/8p4l57BUET87X09kjGftRmbR6mymQG2qs2UfqAKZtyCyp
 9Y3iROjMqEJWndB2h//b61flYFMVd4BameijtVhaSQrBY/LAm+fG7DcEiwlOKApBg20RuGUu092
 q7m5JBcu+zh5WWSlK2P5E8z3pqBlctiCpcWPgrg/f+EM+rK8bv+QKbbQSjn2PiO5jZIHL+5hts0
 K9RvN39I8O1OPsS9NCO9McCiVOudR0UuwOyxiH8IL7h5wl9vjlh6PAEBSi3SMuoEp24Qaq+XrxD
 6XlWELCYAY+FOcbBtfoNR8XWpwOFhOe4X0qobNmUWfrvzWuLkP5FWtwkVW9mZ4CQhkTwe2nU6UN
 zz4dtQWWXcy14MRb/Uxy/bxarBDgK3GR86hdmEtayo3Xupeo99VTY3XK/kTvefl465fMNwzUj4w
 DjeRRIpv4Ntr4xWkuLR2MVnsHx/vWcfA3GGPLnyY9geYA=
X-Received: by 2002:a05:701b:240e:b0:184:329d:eced with SMTP id
 a92af1059eb24-1ac5dc657admr5150c88.25.1793303025095; 
 Thu, 29 Oct 2026 12:43:45 -0700 (PDT)
X-Received: by 2002:a05:701b:240e:b0:184:329d:eced with SMTP id
 a92af1059eb24-1ac5dc657admr5115c88.25.1793303024168; 
 Thu, 29 Oct 2026 12:43:44 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1b0a628bsm698255c88.22.2026.10.29.12.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:43:43 -0700 (PDT)
Message-ID: <f14977de-111d-451f-9bf9-872f7d233739@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:43:42 -0800
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87cxssi9kr.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yWZF15FXLeJcIqD-4RtVZ6U4eLRi5-dr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NyBTYWx0ZWRfX61OShTj7a+Bz
 pregXQNf4zo4S4HNrnR27Vcr4dG3Ghs78QEzQdLb6+KYol450aCQvBRVTR82C0sgGo5T3FIqJig
 wddfCVOh+JJWZHEUkyXSxedGdxtaxYYp6H8t5o6xzsM3ETnmGZc8Oex4562LM5eD0Li3PRm1GaX
 UGsUSU6nFqKaQ1AywCBxOXbYi7gQ84G+SEiN/uSpHXKHTNnC6PuSv5JoMum0Ji30FDBgP+vryD7
 9+Z5cnVE62Rt+8DrfLFlHLLSf/mCOHa53wwOc6Lqtf0m6kTis+bYLXOAfriioCE5xrY9B0QVjnG
 bZRLWqf7fsZMbgvk2JHy/Hyk6ObKeXz0Q1YFYkqNim144Y1MH39kFlN4xJH8sgHbH/Px0QXA4Nz
 ShGCW6GTFWd5F1OtXER6U7DYUDasFf0u7FOYlavmY6ZoCo0T7qXUztUSQgsTOMbeFm5d+m8LlGL
 CFEyCGIVxC8PEsOAUdg==
X-Proofpoint-GUID: yWZF15FXLeJcIqD-4RtVZ6U4eLRi5-dr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NyBTYWx0ZWRfXwVqQdvOiGexy
 ODB4/KYmTPb0nWEp944GIUksuB0sZi2676dGemXMlpgsAE+HrkIl1fbFFJbUsSlyUrWHSBrDZyw
 oyd5Kucmt/pjacMCd1G9woDLrwiDEJ0=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3a1f2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8 a=nj9H9pdMQwSepduOhpIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/29/2026 11:35 AM, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 10/29/2026 10:39 AM, Fabiano Rosas wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 10/29/2026 6:41 AM, Fabiano Rosas wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> This new dockerfile allows to build a distroless image containing only
>>>>>> qemu stripped release binaries, their lib dependencies, and installed
>>>>>> artifacts (roms, keymap, ...). There is no shell, no python, nothing
>>>>>> else. This is achieved thanks to a multi-stage build, where we add qemu
>>>>>> binaries, artifacts and libraries in a new scratch image. Image has
>>>>>> the minimal size possible.
>>>>>>
>>>>>> This is based on Ubuntu, which has the advantage to have working
>>>>>> containers available down to 14.04. Debian old old stable have broken
>>>>>> apt sources for instance.
>>>>>>
>>>>>> This unique dockerfile works for all qemu versions >= 3.1.0 (2018).
>>>>>> We could build down to v0.12.0, but it would require more tweaks in the
>>>>>> dockerfile, so we keep it simple instead.
>>>>>>
>>>>>> To build the image, you need to provide a qemu and ubuntu version:
>>>>>> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
>>>>>>
>>>>>> To run it, as there is no shell, and no defined entrypoint, you need to
>>>>>> choose the binary you want explicitely:
>>>>>> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>>>>>>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>> ---
>>>>>>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++++
>>>>>>  1 file changed, 48 insertions(+)
>>>>>>  create mode 100644 tests/docker/dockerfiles/release.docker
>>>>>>
>>>>>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
>>>>>> new file mode 100644
>>>>>> index 00000000000..ca6babde01e
>>>>>> --- /dev/null
>>>>>> +++ b/tests/docker/dockerfiles/release.docker
>>>>>> @@ -0,0 +1,48 @@
>>>>>> +ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
>>>>>> +
>>>>>> +FROM ubuntu:$UBUNTU_VERSION AS build
>>>>>> +
>>>>>> +# add deb-src for apt build-dep
>>>>>> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
>>>>>> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
>>>>>> +# archive.canonical.com is not reachable anymore, and cause a long timeout
>>>>>> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
>>>>>> +
>>>>>> +# build dependencies
>>>>>> +RUN apt update && \
>>>>>> +env DEBIAN_FRONTEND=noninteractive apt install -y git build-essential flex bison
>>>>>> +RUN apt update && \
>>>>>> +env DEBIAN_FRONTEND=noninteractive apt build-dep -y --arch-only qemu
>>>>>> +
>>>>>> +ARG QEMU_VERSION
>>>>>> +RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
>>>>>> +ARG QEMU_REPO="https://gitlab.com/qemu-project/qemu.git"
>>>>>> +
>>>>>> +RUN cd /tmp && \
>>>>>> +mkdir qemu && cd qemu && git init && \
>>>>>> +git remote add origin "${QEMU_REPO}" && \
>>>>>> +git fetch origin "${QEMU_VERSION}" --depth 1 && \
>>>>>> +git checkout FETCH_HEAD && \
>>>>>> +./configure --prefix=/opt/qemu --disable-docs --disable-werror && \
>>>>>> +make install -j $(nproc) && \
>>>>>> +strip /opt/qemu/bin/* && \
>>>>>
>>>>> For the record, here I included a 'cp <list of bins> /opt/qemu/bin' line
>>>>> to make migration-test work from inside the container:
>>>>>
>>>>> migration-test
>>>>> sh
>>>>> env
>>>>> docker (installed as docker.io up there)
>>>>> cat
>>>>>
>>>>
>>>> You mean by mounting current folder in the container?
>>>>
>>>
>>> I mean having the test binary present in the container as well.
>>>
>>> This is something specific to migration compat testing: to avoid having
>>> issues due to features mismatches, we run the older version of
>>> migration-test when testing two different QEMU versions.
>>>
>>> But then...
>>> $ git checkout <old tag>
>>> $ make check-build
>>> $ ./migration-test <QEMU old container> <QEMU new container>
>>>
>>> is kind of wasteful. I can simply build a container with QEMU +
>>> migration-test already in it and invoke:
>>>
>>> $ ./<migration-test old container> <QEMU old container> <QEMU new container>
>>>
>>
>> Ok, I see. I'm not very familiar with migration testing, and assumed the
>> logic was opposite (that migration-test is backward compatible to test
>> from old versions).
>>
> 
> It was the original idea, but we noticed it was way easier to just pin
> the test.
>

I guess there are good reasons for it, but it seems like it would be
much better to work from current HEAD instead of having to checkout and
build an older version of the test.
Flagging sub test per QEMU version does not seem too complex to
implement (min_version=8.0.x, so this test is skipped when running with
an older QEMU).

>> But migration-test is not included in old container, since it's a test
>> binary (thus not installed). I feel that for this case, you need to
>> build from sources, at least to get migration-test-old.
>>
> 
> It's built inside the container along with QEMU. The cp line I added
> brings it over.
>

Got you.

>>>> I'm not against it, but I feel that if we go this way, it's just easier
>>>> to say "let's use the full base image", since it will become "I need to
>>>> run python, and X, and Y, and Z".
>>>>
>>>
>>> I think we should merge this series as is. However if we intend to use
>>> it in the future for something more complex, something like the above
>>> will probably come up. Anyway, I posted literally "for the record".
>>>
>>
>> Sure, I'm just interested to make something useful for you. If it's half
>> baked, there is little value in merging this.
>>
> 
> I don't want to enlarge this container too much. In its current form
> it's also useful to others.
>

Yes, I'll merge it as it is for now.

> For migration, we'd need the extra binaries I mentioned plus the output
> of -dump-vmstate to run ./scripts/vmstate-static-checker.py. It's
> probably better to have a separate container image with those.
>

Regards,
Pierrick

