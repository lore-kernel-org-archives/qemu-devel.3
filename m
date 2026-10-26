Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68EE606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GvI6LyxL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XMtrZacc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLP8A-0008L7-JH; Mon, 26 Oct 2026 14:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLP89-0008Km-UL
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 14:09:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLP86-0004hX-Nx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 14:09:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QHIHw12391294
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 18:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E9/i/Ioi1sFdI3Z9pKuURQdICDL5pTlxm/9ICL8s/To=; b=GvI6LyxL1ZHUdPMP
 tAJkFTx05dixYCNUwr1FImtNCiNtdpe44zxUWDCp1LZgAs+TRrIUWsM7J5cXR8E5
 pLno3Wmia02ZW16jB2Nac468zSg2SHQpnqAmaMzbVhFU8q4Nkn6Yk+a+KwGIr3vz
 FliNZ6hhplKxkBv8yJobhK1e6oYkAD0l30fTTLT4M7EeZ15JEeBNTZFKEp34oNH0
 0Vuc1tmha6JbzQ1e0uRC5I55f3NaleGxHm7vbvABj0WF15VO1uXFtA0HzprzKu6k
 sHjL2dfvAL3YMhG0xexIFV6IBeUTmGHYXmMklZj4TVR9Z4oiUtZWyPFsJHbPYmK5
 WF+BKg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54g6r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 18:08:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb92868263so1676722a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793038132; x=1793642932; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E9/i/Ioi1sFdI3Z9pKuURQdICDL5pTlxm/9ICL8s/To=;
 b=XMtrZaccCzi08axA323L8eFqLoJ2cmg2lVK2Kcg5cMcdRw6ECvZj9n3SkLexVKEIpt
 OAwFhlNy3Pa5QhP3AesBKG4baZwCp1qllIY6ScthahuoxE1Fk8DR91t50aO71+KV45yw
 mFUEPPdrsSWNiI0sOjh2ZtfIFZ1GffQsUkiAPjfvvkYjfc+9OqIOVw6ZELJ2Mw1H0NPQ
 NYTBeFFKx1GC7N3XFsvg+A2fBHEpwaT2SVJtwsUWdFTHoJZcFO1gzLxj3QNMBxdG5ShC
 OK7jhkKpSfDXfRDOWNmwc0Yh5SH3HkHYwt043pa/oynoXzyRoiqElWRwBz+5yUxIC8yR
 70/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793038132; x=1793642932;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E9/i/Ioi1sFdI3Z9pKuURQdICDL5pTlxm/9ICL8s/To=;
 b=aUn0tp8BJof4v1uPYBU4ohqfR3TSAGUmrdXQWJ+VyjFv4mqAnXlhQ7sPYfDZ91SdlG
 sgChVAuAGZ7IlUNLPafjqVDM3fvTvMc6Lo4mW2/RlEREYTT7TdAHUcu6baUaE5gCBl/x
 emXZ3kg1HJKVYCe0HZ2dR49rsQUdhPPgeLnAshEB6ExsPnGjLwU4b6OqEtbRlmn7SnUQ
 f6SHUCeGNqhnGrdbFQHemS1cHHiXbkYPiOd+euOLTHFMVqDS1Rn7JUtN/uOLyUVC8G+o
 A7lylBV7uYDXu9ws54MnNEdawvc3mbe1QI4JMDiPJEEfMhloQJOi1niqUc+Ct8i8keMY
 YqgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1/21XR0jCjXVXVa8LxG6uMBY7LSJ53p4wZpzVkwTRune/pUj+93zRy37IssRVoR0R4hO2P03D8IHs@nongnu.org
X-Gm-Message-State: AFq9FYLbOHaCV3mfzorINdHqrNn0JVE/PWvPNaFTwH8ADBaxEPDe/MCu
 inQ67NLMGshZKTQfGVrfprIF5oW8Kgicu1nJr6hLL3M7PToHx24lrdkqvyGppeJyzXod2TQYxhd
 sFTLX8WRT3N3Cg1ENQCUp0zQjaFIKk1514XQxcrbPfGYh4MPymhA2GkCP5w==
X-Gm-Gg: AYBFou3wDHcSAzJpa8+4BaHxmcYjdj7+m8lUInjC1Rxnp65L2sb32xTZR+0u4f8bkkI
 oKoksrEK/zAml5A/EoxZVvqJScDOJu1BY2W5A+w0+Dts1w7OuDiFUO9g2PySx8EZ86INO/VRPb7
 9IQ/0LsaSSsbjdW0WEq7UvY6GI5+8Lkd0w9JVTW53RDExrn25XpQKPBY/EZa/DbE54/ptNBsHQ2
 qw+Xt8fYgnDpMUCdtOE36HRKYZ8eD9uu/hCEKotK2Kdw87pVbnU8lSTzPW8VU8sEuCZmbmHLWkY
 Aj6skQ+HMrRYjo45uogqMgYQyzCyct8MmKtQN2JZZSsaUUFSkgH/cj4/Q1keQ4zl1EpuUVlFqjq
 mOpxLEhomsbn0J4L6UZTaWOBwwKMqzDoc89pxRo88+ceUQSVQ4u0vB5gErjLGJxEttMAnGg==
X-Received: by 2002:a17:90b:8d8:b0:3ae:2961:14db with SMTP id
 98e67ed59e1d1-3ae296116ecmr1573741a91.21.1793038131956; 
 Mon, 26 Oct 2026 11:08:51 -0700 (PDT)
X-Received: by 2002:a17:90b:8d8:b0:3ae:2961:14db with SMTP id
 98e67ed59e1d1-3ae296116ecmr1573719a91.21.1793038131199; 
 Mon, 26 Oct 2026 11:08:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404429a8sm437944a91.8.2026.10.26.11.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 11:08:50 -0700 (PDT)
Message-ID: <786c36d6-d321-46f0-9e66-eb5847baabe9@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:08:50 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] releases: build and run any QEMU release easily!
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
 <87h5icl9dw.fsf@suse.de>
 <c4b4213c-6013-4a96-aa13-509778bbb6eb@oss.qualcomm.com>
 <87zew0jud9.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87zew0jud9.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3MiBTYWx0ZWRfX40rplvgQR8+2
 /XrRu4dBvGvPtHwQ/f5Ztudi/WPDcd4W67PMFi5z8zqkBfR9fP9oASW1vRdU2gqgDu6kHXtHok/
 sdyDst5XNI6JwxpOSjgwLhBfbJwQIRs=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adf9739 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K1PMdzNZOo9RSkK6fkYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: tCgoinooH2mPV7ZowRBJpJgYyd0jo4do
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3MiBTYWx0ZWRfX1U5/WXm27apP
 0NHHbgQp/bnscs6wDRMz1LUmGl20F5B2+SWkkl/s69pBTbgLy/E7SEj1CHeLitxbOd+f/FYA6CC
 C5pPr6lmH1jKs0SNG/RF8yfumDEy8KYhTnTcUpndHIOAruZfAleoia4fBYMQjjcGKsPK5Smk8T8
 gWADeVGopfEk/BjmXwzkwbQijZujqgcS47mPOZYgOnWQa8RWTXLhTJYgQ12VkwIGsHFXodRb8Ui
 Cgfd6y7i6SUdiPvW4T79rgPnDd0tObUpRlxlRqcrQcdPRNQWRkdYKkJw0WTOFN1cFTSo9q0MyqE
 pEobi9uhYSuS1LNofYphTLzOPaLmXAR4efcuNgIJ2xufjOa0pHnqXXSG9U3vEPphvd0ojwda2CD
 cyvf5p87fi85Ebb9p4+u5Xjhlq33E/aLCrbozCOmC4in4Eo+OSuXwc9iPUDyD0dY/78oUQrVIk6
 BanUGF/J/fPTeas5odw==
X-Proofpoint-GUID: tCgoinooH2mPV7ZowRBJpJgYyd0jo4do
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260072
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/2026 8:32 AM, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 10/23/2026 8:33 AM, Fabiano Rosas wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> This series was inspired by a recent post from Fabiano to provide container
>>>> images for migration tests:
>>>> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
>>>>
>>>> The idea to be able to build and run any QEMU (past) release with containers was
>>>> in my mind for some time, so I gave it a shot. Finally, it was easier than
>>>> expected to obtain a single dockerfile (with a few hacks) that works over all
>>>> our releases.
>>>>
>>>
>>> Good stuff, thanks for this work. I'm just not sure how much of it fits
>>> upstream in the current shape, let's discuss...
>>>
>>> You say this was in your mind for a while, could you elaborate a bit on
>>> how you think this could benefit the project?
>>>
>>
>> First usage that comes to my mind is that it would greatly help for
>> migration, allowing automatic testing in CI, by just downloading any
>> previous QEMU, dump a machine, and restore it on current version.
> 
> Don't we also build QEMU several times over in CI? Maybe I'm wrong, but
> it might allow us to decouple a few tests from the build steps.
>

This is for current version, not past ones. I'm not sure it's worth
adding an identical build for past versions on every pipeline.

>> We could do it for last 10 releases to ensure migration from packaged
>> versions in all supported distros (red hat, alpine, ubuntu, ...) work
>> as expected.
>>
> 
> It's a nice idea but potentially a costly one. I don't think there is a
> guarantee that the downstream package is migration-compatible with the
> upstream package.
>

What would be costly? It seems it would just be a download + savevm
through monitor, and a loadvm from current version tested.

>> It could be a enhancement compared to the manual process done once per
>> release. I read many times in review "it breaks the migration", that
>> yes, it would be nice to have CI saying "this series broke the migration
>> from qemu x.y".
>>
> 
> Most of the "breaks migration" issues are due to device migration. What
> we have today in terms of migration testing cannot detect most of those.
>

Ok.

>> Beyond that, I think we could also offer a "rebase on steroids" tool. We
>> could extend list of containers published to all top merge commits (git
>> log --first-parent), and provide a fast rebase, based on download only.
> 
> Bisect requires a test of some sort. Will this cause the opposite
> problem than what migration-test encounters? I.e. instead of "old QEMU
> needs old OS" you'd have "new test needs QEMU from new OS". One
> alternative would be to build the tests into an image as well. Or
> perhaps it wouldn't be a problem in practice.
>

I don't think adding tests in image has a specific value. What we want
is to keep the same test source, but just change the binary used. In
this case, the container just acts as a binary.

>> See it as a giant immutable precompiled cache. Dockerhub storage is free
>> and unlimited.
>> Some quick math: Since 8.0, there are ~2000 top merge commits. Each
>> image is < 250MB compressed, so the whole thing would be < 500GB.
>>
>> Finally, in my personal case, while working on single binary, I had to
>> compare output of qemu help between versions. I'm also interested to
>> track QEMU binary size evolution over time. And some personal fun with
>> software archeology on the project too for anyone.
>>
>>> To be clear, my use-case is simply to produce a few containers for
>>> testing migration on my workstation. Your series can help a lot with
>>> that, but from my point of view, some parts are clearly extra and some
>>> are missing.
>>>
>>> Also beware that what you're touching here is both "infrastructure" and
>>> "publishing". This has implications for how people consume the work of
>>> the project. There's a chance that people see this as "official QEMU
>>> containers" and try to use them in all sorts of weird scenarios that we
>>> as a community are not prepared to maintain. You might get some
>>> push-back on that basis.
>>>
>>
>> Sure, it was free to generate all images and push them on my personal
>> dockerhub, and it's now automated to push any feature release also in a
>> GitHub nightly job. If we want to make it more official, it should
>> really be hosted on an official account.
>>
>>>> The oldest functional distro we can find nowadays is ubuntu 12.04. Because of
>>>> this, the oldest QEMU release we can build is v0.12.0. Previous ones require an
>>>> environment we can't get easily today.
>>>>
>>>
>>> I think the ability to go all the way back is very cool, but unless we
>>> want to look at this from a archival or heritage perspective, I'd say
>>> there's a line somewhere to how old we should go. I don't see an
>>> use-case for very old binaries. Even knowing if they still work would
>>> already incur in a maintenance cost.
>>>
>>
>> Agree, mostly was a fun challenge. I was also curious to see until when
>> we can go back in past from 2026.
>>
>> For the "maintenance" a scheduled CI job running nightly is a free thing
>> for me, but I understand opinions on "maintenance cost" may differ. I
>> also co-maintain tests/docker with Alex, so I'll be the one taking the
>> load, and I'm fine with it.
> 
> Fair enough.
> 
>>   >> Images have the absolute minimal content possible. It's only qemu
>> binaries,
>>>> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
>>>> tool included. As a result, images have a size from 149MB (v0.12.0) to 1.48GB
>>>> (v11.1.2).
>>>>
>>>
>>> No shell means the first thing to do if one wants to debug the image is
>>> to rebuild with a shell in. Not sure how frequent it will be, maybe it's
>>> ok like this.
>>>
>>
>> We could leave a base system, for only ~100MB per image, which is not
>> the end of the world (+10% in size). Personally, I appreciate to have no
>> shell, it reduces possibility of exploit when running an older QEMU
>> having CVEs.
>>
>>>> This series adds 3 pieces:
>>>> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>>>>   Ubuntu version when building a given QEMU version.
>>>
>>> This is the tricky part. We'll be carrying code (script+dockerfile) that
>>> only works on master. If we tag today and tomorrow the old distro repo
>>> breaks, we obviously cannot fix it retroactively. So we need to be
>>> careful of where we direct the maintenance effort.
>>>
>>> 1) I'd suggest first of all to keep the release image entirely separate
>>> from the ubuntu image. Treat release.docker as we treat the other
>>> dockerfiles and update it to work for the current release without
>>> looking at past ones. Have it clone, checkout, build and gather
>>> deps. Allow the configure to be tweaked via parameter in case we need to
>>> disable something in an older build.
>>>
>>> The script would then build a distro image (or dockerfile) with the
>>> knowledge that it has about ubuntu depending on the QEMU tag vs. ubuntu
>>> version combination. This would allow us to track the cludges more
>>> precisely instead of "some ancient distro" as the dockerfile currently
>>> says.
>>>
>>> This is more of a layering concern and how easy it will be to drop/add
>>> version-specific fixes.
>>>
>>
>> IIUC I think that's the approach Fabiano took, to use Dockerfile from
>> previous versions, and the conclusion was that it requires some seds and
>> hacks to have something that work. Internet state is not immutable.
>> IMHO, building previous QEMU with past Dockerfiles is doomed to fail.
>>
> 
> That's not what I'm suggesting here. I'm saying that "current
> dockerfile" should have less tweaks and "current
> build_release_container.sh" should be the one responsible for doing the
> ubuntu-version-to-tweak mapping.
>

Got you.

> But maybe you meant to reply to the second point below. In that case,
> yes the past dockerfiles require tweaks, but they also provide most of
> the time the exact list of dependencies for the previous QEMU, and that
> work was already done by the people from the past.
> 
>> Only thing you can control/guarantee is that "current dockerfile on
>> master works".
>>
>>> 2) I wonder if the usage of apt-get build-dep might be a convenience
>>> trap. In theory, some of the adaptations that are required (such as
>>> tweaking dependencies) have already been done by us when working on that
>>> development window.  If we take the dockerfiles from the git tag, those
>>> changes don't need to be done again and for the issues that didn't exist
>>> at the time, we can map them to the git tag instead of ubuntu version;
>>> (we tend to know more about QEMU releases than ubuntu releases).
>>>
>>> Another issue with buid-dep is that it lists _ubuntu package_
>>> dependencies. The distro can change how it builds the package without us
>>> noticing. There is already some work done by lcitool, I imagine that it
>>> would then be duplicated. Or worse(!) be different because build-dep
>>> might be listing way more packages that what we need for the default
>>> build.
>>>
>>> This is more of a push towards using existing infra because those pieces
>>> are already looked after for other purposes.
>>>
>>>> - A script build_release_container.sh which automatically detects which ubuntu
>>>>   version a given release should be buildable on (based on date). It works
>>>>   great, and the heuristic works for all our versions.
>>>> - a script generate_release_links.sh which creates wrapper scripts automatically
>>>>   using prebuilt images (hosted on my dockerhub).
>>>>
>>
>> Sure, lcitool could work to express all that. Would I like to spend time
>> to rewrite all the missing bits in yaml when debian did it for me? not
>> really.
>>
> 
> I may have misled you. I'm not suggesting to use lcitool for the missing
> bits, I'm suggesting we consume what's already in
> tests/docker/dockerfiles. That point you already got.
>

Oh I see ok. Like extract the list of packages, and inject that.
Well, I'm not sure it will be simpler than just doing an apt build-dep
to be honest, and not sure what we gain from taking this information
from our sources.

>>>
>>> It would be nice if these two could take any hash, instead of just a
>>> tag. This is one of the things that will depend on what you intend to
>>> achieve with this series.
>>>
>>
>> Very easy, it just needs a non shallow clone.
>>
>> ---
>>
>> After reading and answering to this message, I feel there are two topics
>> we can discuss:
>> 1. the current implementation
>> 2. what would we like
>>
>> 1. Personally, I just posted this series as an example of "yes it's
>> possible with very limited amount of code", and I don't mind having
>> something completely different. I feel it's probably not worth reviewing
>> every line at this point.
>>
>> 2. The biggest question seems to be the direction with:
>> 'do we want to provide a single dockerfile that covers all versions' (a)
>> VS 'having a dockerfile at a time of history for current version' (b).
>>
> 
> It's probably (b), because the "all versions" part spontaneously spawned
> to life. If you take a recent-ish QEMU version there will be few or no
> tweaks at all and then it all becomes a question of "why base this on
> ubuntu when we already have dockerfiles written for several
> distros?".
> 
> UPDATE: You just replied that you think build-dep is consistently close
> to the real deps enough that it would be less work to maintain. You
> could very well be right and we're approaching the hair-splitting zone
> around this topic. I suggest you carry on using your best judgement and
> let's leave it to time.
>

We can also decide to settle on fedora, alpine, debian, suse, or any
distro. In terms of images, ubuntu was just the most convenient (tried
with debian first, which required updating apt sources for older versions).

>> I think (b) is what we have now (current ubuntu/suse/debian/alpine image
>> works for current revision, since it's used in CI), and it was already
>> proven it fails from Fabiano's feedback.
> 
> But the tweaks may be necessary either way. This series adds an
> indirection to choose an ubuntu version just to be able to issue (some)
> commands unconditionally in the dockerfile. It could just as well check
> the qemu version directly.
>

That's maybe where the philosophy differs. Key idea of this series is to
tweak the environment so it works all time, and not do specific things
per version.

> (yes, there's potentially dealing with all the other distros and lcitool
> and all _that_, I get it)
> 
>> It seems to be that's what you propose also from your answer above.
>>
> 
> Fabiano and I are the same person. =)
>

Sorry, got confused as Peter answered on v2, and I assumed he was the
one who answered on v3 also.

>> This series goes in another direction (a), adding a unique dockerfile
>> covering all versions, independently of all the dockerfiles we have now.
>>
>> If we agree (a) is a better direction, unique dockerfile approach can be
>> vastly simplified by restricting ourselves to qemu >= 3.1.0. If not, no
>> hard feelings, it's just a proposal.

Regards,
Pierrick

