Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64402CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCCPn-0006zx-PK; Thu, 01 Oct 2026 04:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCCPR-0006lx-Kq
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:45:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCCPN-0005id-1s
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:44:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xLVo1932287
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 08:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 46PonqXm2c3LXlS5HOmrTuSsf/tKo1kW2NgnJc9s/Uc=; b=bOo8oguaE92B9M3G
 lbrietfHVbQXLo+9FkQAnx7p9k6M4E3OuFqvQyWn/HPw2cHlyWn51HKoWkKINiLl
 vRlqR85Ouwl2XQs29CllOuYdi5sEmEGbUnBKJu+JsUw38o3WIZypZTFS+38zbbLI
 ml7QPhfLDXYxBzHUayOQ1RZ3Kf3uZ4WxcAbX68xHg4NKK6giBPCsUIBG5dkUunzc
 uEEwhN+kdKZL4hO50N0xlGMk6Qr7hnazS3T4CkfIYsp/KRxN39lS1RdMddq8IqKW
 Q4CkCxQrfQS0po35nV9DShkyL+mSfSlZvUKBvSAz6+asO7BdFI0y33OgMLEFao5l
 ImZuog==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh59wnk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 08:44:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c58ee2116so1160167085a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790844290; x=1791449090; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=46PonqXm2c3LXlS5HOmrTuSsf/tKo1kW2NgnJc9s/Uc=;
 b=RcDX8reak09eYOcp5vS0XvWPZqGk3S2rjooCyPFGxBnxat1MeghEN+7MBZjvnQp67M
 sBkjs77inKXZhkNMQHOOzZQv9RDoZiy9s6zJUlWTaKAZD9hfwPov1f8p8uT1vy0HpnWq
 cCZMYudPZqZ8/9TMjNDCqiS2G4cmvQzvTPKgdbsY6GjjoFVTEcIRGSpjbkFBcOBlPjqr
 3NaUriayBgX7+A6he/utZMowOyeKwn6xKf7Lot7fhnip5S/y0wGq99bIrXBDOd+fhBWB
 pSGyMfPbpuivJNiwLGO37KyY0XkmSSejqc7SRQAuZhY9dEoaqfo1DeyqnhQhrlvrlfoh
 WrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790844290; x=1791449090;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=46PonqXm2c3LXlS5HOmrTuSsf/tKo1kW2NgnJc9s/Uc=;
 b=n1a4+sI939rhIpuJeqYfVp3tYqp66MPlP/YKzBGKqTj+2x0iUuI8b3rQqYy+qT9jy9
 1NJEcw7G+FRh86VstHL5E881nBQfQOkJ2ryy20qC9Q3vnhttmIl3bOwGCkGlEsO108E1
 Or4FstkWuSbCtGvc5VVkMXfAvMXxv9r+kJM/Epz0pkX8mvy++iDIH+M2IRDOyYjixv6b
 fI6Nnli8n07ADwGCzeQJTkUGWkiSkp+kj8EtH1fiLvJv6MHed6JVVjFz/RjyO0NaESps
 nYGpcTHIKuxXfdEWPa3JqNgI+OP9ZKDWjFbyOIXHHOYEOLEFSFyclAqHtVUwlms7tfWG
 aFoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNn2V+vnHCWto1mERwn0hhdykaS4oLGXlc5EDdlFaBsxXlifmgSr6oz1/S9bCyHlNSwAkE7j2LN43M@nongnu.org
X-Gm-Message-State: AFuF++kQ/4FnOMVAIX/Vsl55SaYJ6fruBVP9n5AuToHy01BC7hfxjMz6
 JjNVjPwDjWDwZbGKw7rvLKkws3XqjwizQI7jkTISXTA+ssh1HoYHBM2LooEtMyG4kli83D0HKrY
 s/iWiO+gEsuRDE7046a9FvxBunzSF9cElo1nb7yqLPgphkBFv1Jlg7p6cmA==
X-Gm-Gg: AYBFou1tE8SxBHfS4ZcyYHDmnavG4lJfhYrBOQb5jTkL2NFv8meIqV0gr+wWvqYyUDV
 2hnfM0o634FUzAYIrM366JDrfHVWWcRV9Io6+AIAZ1w9LMDGCOUgjtUD0xcyg5gVoH8DOUDyA6y
 uHSdCQBD18InfPGKpxErRupmSVmKnTHADmKODOAMznMSuhB/KLkXki/myGY5cePdtFgWtZLVl7r
 WyjhaVWsaDcxrsc+X1qTQdUZMcXjKPdGGLG0PzrOOdTdUXu9B9VgaUhFxn13U7ANgqrtv6GErSz
 zKbqtoI3c7EOvuWy2gM2cRH4ql+mTz7ZQvf6PK4PHXVlPZkVm/xCHkFJQyGo8FhjMhrmtqCSUre
 9ZnL9qsuSgB1M/SpkBGzn9LCsYtGk8AvwCA==
X-Received: by 2002:a05:620a:4095:b0:93b:c209:b6c0 with SMTP id
 af79cd13be357-93ca9513afemr721155685a.5.1790844289857; 
 Thu, 01 Oct 2026 01:44:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4095:b0:93b:c209:b6c0 with SMTP id
 af79cd13be357-93ca9513afemr721150985a.5.1790844289301; 
 Thu, 01 Oct 2026 01:44:49 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f96d01csm37581595e9.2.2026.10.01.01.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 01:44:48 -0700 (PDT)
Message-ID: <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 10:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
Content-Language: en-US
To: luoyonggang@gmail.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
 <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
 <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
 <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
 <ar4TQtKqfXX5Ul9O@redhat.com>
 <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: irU86tUo6UoOlLBl3KFbwSWN_eFKZZz8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNCBTYWx0ZWRfX2mWbuIvufSau
 kcE9nIEtCnN9egx90Zy18YRHySekYwlrD32xN25by29ILAmGfpoZSN/JVNf1s+IkOr9OPx5qP8S
 D+C4f0ipFvD/ssSACeQHouEQ5j1i8UE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNCBTYWx0ZWRfX03TGGm4TiHID
 SV/S1sITimUW8SONN/1mE0W5r68mACCoOGTh9iA75zBavi7PkyppD22w1z9+9N3SUcU/ZhNRiuO
 kcaIXajmCAlo8yN08DpA7HPnikxNn3F4exsAm/TPPT5KX9vYNBxlP8izTzPBd4bvWzVhgdA7Q20
 mOWl+rsvN+TaF2UUZRgudErTKORMyb/PjlQVQTTgYFaOJXxu7lUxHTMW+CKnCxg+wTs9L+JUhpr
 wFvNMTZoxoF7LgO4QDx5PewUMM2FzCy1SqfFML6h1ZJf6izj+O082xhw9Yl1mXOv95dkrmuQncG
 zi+YdqKA6Q5ybUhxYMueTWWz/bCV6PqR8AR7ItoAbSq5ItKh6OPKfFLid6icUIj7Kcnc3qDKacr
 bv/O5NcRffYDcKHpuH2CF+fMVVEcrFl/nnpFnDJY7LAk37hwzzDXsk/y21s/fc4X4qk5M869puT
 Vs4E1ZDL4c/nElLQWew==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe1d82 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=iyRaGYhiAAAA:20
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=aXWF5__G5Zs2yFWEykkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=IC2XNlieTeVoXbcui8wp:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: irU86tUo6UoOlLBl3KFbwSWN_eFKZZz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010034
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/10/26 10:13, Yonggang Luo wrote:
> On Thu, Oct 1, 2026 at 4:01 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Wed, Sep 30, 2026 at 09:23:50PM -0700, Pierrick Bouvier wrote:
>>> On 9/30/26 6:55 PM, Yonggang Luo wrote:
>>>> On Thu, Oct 1, 2026 at 2:19 AM Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>> On 9/26/26 1:15 AM, Yonggang Luo wrote:
>>>>>> - Add machine_class_set_name() so boards can keep a stable -M name
>>>>>>      when the QOM type is uniquified. machine_class_base_init still
>>>>>>      defaults the name to the QOM type without -machine.
>>>>>> - Document that MachineClass::name is the -M name, not the QOM type.
>>>>>> - Sort -M help by MachineClass::name so order matches the printed names
>>>>>>      when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
>>>>>>
>>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>> ---
>>>>>>     hw/core/machine.c        |  6 ++++++
>>>>>>     include/hw/core/boards.h | 12 +++++++++++-
>>>>>>     system/vl.c              |  8 +++-----
>>>>>>     3 files changed, 20 insertions(+), 6 deletions(-)
>>>>>>
>>>>>
>>>>> First, I'm not opposed to this series, and if anyone wants to pull this,
>>>>> I'm ok with that decision. It's just unclear for me what will be
>>>>> direction after this step.
>>>>>
>>>>> If I understand correctly, the goal here is to allow to register
>>>>> multiple "virt" machines, while still having distinct QOM types behind
>>>>> the hood, which does no affect behavior of current binaries who have
>>>>> only a single "virt" type at most.
>>>>>
>>>>> That said, if we project in the future where we have a binary with
>>>>> multiple of those "virt" machines, how will the current series help? The
>>>>> situation we'll have is distinct QOM types, that all answer to the name
>>>>> "virt", so we have no way to select them individually.
>>>>>
>>>>> Slightly worse, find_machine() will just pick the first machine name
>>>>> virt, which is a non-deterministic order at the moment.
>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_type=heads#L846
>>>>
>>>> That will handle it properly. For single-target binary qemu-system-$arch.exe,
>>>> this won't be an issue, as there is no conflict as they won't be compiled in.
>>>> For multi-target binary qemu-system.exe, we will choose the target through
>>>> -M $arch:$machine, and when no $arch is specified, the default to arch
>>>> to be "none",
>>>> so still won't be non-deterministic.
>>>>
>>>
>>>> "when no $arch is specified, the default to arch to be "none",so still >
>>> won't be non-deterministic.
>>>
>>> That's my point, the current abstraction will create something ambiguous by
>>> design. When people will specify -M virt, without $arch:, a random machine
>>> will be selected. At least, maybe this series should ensure there is only
>>> one virt alias, or make it forbidden and uses unambiguous names only.
>>
>> Yes, if there are multiple choices, we should not pick an arbitrary one
>> non-deterministically, we must require the user to narrow the choice
>> explicitly in some manner.
>>
>>> "$arch:" is just a workaround to not add -target option, except that it
>>> comes with additional problems, creating inconsistent command lines.
>>> I already expressed my skepticism about the "machine prefix" based approach,
>>> being more in favor to strongly filter types per target with an unambiguous
>>> -target option. I'll accept the community's choice on this, but just wanted
>>> to see this explained before someone hits the pull button on this series, so
>>> they know what will come down the road.
>>
>> Historically, QEMU do alot of things like this where we invented magic
>> syntax that needed custom parsing of the command line. Over time we
>> came to the conclusion this ad-hoc parsing was a bad idea, and we
>> should always explicitly model things, even if it is more verbose.
>>
>> Thus I would not want to see "$target:$machine" as something that is
>> parsed into two pieces.
>>
>> IOW, "aarch64-virt" would be OK as a unique name which treated as an
>> opaque string, but "aarch64:virt" as something split into "aarch64"
>> (target) and "virt" (machine) would be a bad idea.
>>
>> An acceptable way of modelling the latter would be to use
>>
>>    '-machine name=virt,target=aarch64'

Why mix target information parsing at machine level when the
machine already know it is target specific? People wanting to
use the ARM virt machine don't want to know (and don't care)
about the M68k virt machine.

> 
>>
>> or
>>
>>    -machine virt -target aarch64
> 
> 
> That's made me confused, as different people propose different ways to
> handle it.
> Can we just choose one first?
> '-machine name=virt,target=aarch64' is introducing new options, so is
> '-machine virt -target aarch64'
> I can not argue which is better, my suggestion may land one first. Both
> "-machine virt -target aarch64" and "-machine $arch:$name" I have
> already implemented. And currently I chose
> "-machine $arch:$name" according to
> https://patchwork.ozlabs.org/project/qemu-devel/cover/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/#3749257

You still did not explained what you are trying to achieve
with all your contributions, so my view is surely biased by
what we envisioned 3 years ago when we started to pave our
way for heterogenous emulation.

My options so far for a single binary:

- infer from argv[]
- enforce with CLI -target
- not expose any machine

That said I asked you multiple times what you are trying to
achieve to understand and get a consensus or pick the best
approach (we do not want to compete here, the point of the
community is to join efforts).
You are ignoring my questions, so this post is my last try
before I ignore you on your future contributions. Sorry if
it sounds unfriendly but you are about to reach the end of
my patience, exhausting my review time.

If you have AI power, please have a look at semcode + lore
to dig in the mailing list archive and summarize the previous
work and discussions we had before offering distinct single
binary alternatives.
https://github.com/facebookexperimental/semcode/blob/main/docs/lore.md
Once installed and configured, you only need to run:
$ semcode-index --lore qemu-devel/3

> 
>>
>> Inferring from the binary name would be acceptable too, as that can
>> be thought of a syntax sugar for "-target aarch64".

Yes. Better for my mental health to defer the merge of this work
to you Daniel, since you already had a look a reviewed it. But
please compare with Pierrick approach before doing so:
https://lore.kernel.org/qemu-devel/20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com/

Regards,

Phil.

