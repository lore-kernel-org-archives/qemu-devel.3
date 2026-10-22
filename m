Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF465606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dlN5jVZ3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xm2B00vA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJn8B-0000vg-PG; Thu, 22 Oct 2026 03:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJn7x-0000rG-N0
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:22:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJn7v-0008JR-G9
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:22:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M70G3j3518230
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 07:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1B3fIP0QeLSjHe11QtIMz9CDzRFOY9pWFoSzv+pehkI=; b=dlN5jVZ3n+5Vfi0D
 WwRfNaAZijYzTg0aA1sKlVjvryLavKDHcF9Y4Y0jUaNL/HhBZVTEaZZqHvwXr7TB
 GD53qEvMUdwyds6dUvzO6ekXqMo0OhMNHe8lwIy7CITc7r4rvHeN8H/UNPmc4l/r
 jBXjeZ8ntstsJr5U5/OTMB1Pf7POFclzXN0E75kEpH7zHr79M9exWyZSezCF3e0P
 Xbh/GIItFTQ6lZgmwwCxN119Y1fPTMlKTb+JTIaTC2yl4oxJEJUyO58wTW3xq0pX
 wzu75Q+F8AxhY8P1d75p/fUAoKLxkpeMl6b5zLW+Y2qlXi5ps57GgaIqzIoDrWFs
 4mXghg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bh65f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 07:22:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so3965009eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792653732; x=1793258532; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1B3fIP0QeLSjHe11QtIMz9CDzRFOY9pWFoSzv+pehkI=;
 b=Xm2B00vA5K3VbcbPA1PWcJoKuUxa3pw3zoUmyJBsUIcpJ7mWSi66ecqgxVtg12phaw
 WyfbA3moq5Jh943WbOpgBrL8ov7ZEh2KVpfwgxd+uOLTP1iutdzvrZKqQD75y+snEjOU
 arPloKUpSaNlMutzt1/gAaflT/+2FmjSM1UREkKRgo98QC2VarbBCEBqNKup0VKjFtDE
 W4DM2ubLeoNIIf1+s4RuBD0ilzya/J3BRN/o7pLg5BYtvDx16B+kwmGsTooFXe9TrPU1
 ka+HQH+qKDfixjx+T0rkvRBkhgl6GONDS9qcCBLwa0TNBnCCdxMGH2uTLFl+rsIuxnE+
 3MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792653732; x=1793258532;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1B3fIP0QeLSjHe11QtIMz9CDzRFOY9pWFoSzv+pehkI=;
 b=qzgh1EgYZNnKdFuBFfiWN5yvhe2xg7P4CUSJSV6SITi5uAApvCnpIxOeQtUmR/ZW7n
 vOlJK0PBnaPbi2E1Bf483jiSapmsFRlUmg9t9rL1aTedZkbFGVR+0PYZibPjhpARWyqX
 jPUjoT1v/9u2ZTctYQKpesDLfxVSYtcw7Z2ybwK7AGcgWScYZ86Avr0rczwr14Auz7i6
 QwpKPUdylytsskNX9hYeqI0zbce6w0Hgc6uKazBdUAiI27/KO6LYrnA3VfaEHi2bUpnM
 hfBBwX6D0k5/dMA1J+UUdsexZJwSvGPvW23SLPxQLXrbUepUQF3lr1PYgZfbe41n/NL9
 Qwfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRmQcw8/3eJNZeRfiqELkDCtSxPL7cMAWN1zSJKPiWMNkTDGoJPYLco3oWWPf2yfTgbEv2r2wKj1BE@nongnu.org
X-Gm-Message-State: AFq9FYLhKUDYIk15qIbrwMwlTPNHMgg9dSBLFmODRAxwovczVDxP4GaY
 +5dGp9oLJ2sHLnsCBOK7ZVkgDYt+hPxkduItfg64+ZbucCFJA3j81a3PkWD9A/AMaF3LxJRvOEU
 CXCa8irbVATFHR2qD+2A3sXXFAiPZvxIwGkUAsnvmwLg9UGPrhs8McytxQg==
X-Gm-Gg: AYBFou3hk/pBrYoZGKIBgRskjpZFn2v+CDDbZr7UIx8nnBoZ9xvEShQrmaBK42+XogS
 ivVn2hDSF2Lk+YMlhk+AAw/KLNgdkY+ZGgPN8PGVWvmZGZoY7buJE9tQXUOhyvb5usvlD1DO3o2
 a0YkUNRuy1tVqh3WkR0cUSUXRE+pZzBs80NGOKb6Uu8/mRyA7/XRqg8TC4Pb/H4f/F6x4HZrhxZ
 YhPifMiq4pZSRWvOGCWCjO5akvhHNWu7FmOFivVKDb6dhVAgRYMcTiCtQwG/oNn6UjHovMxegVq
 6nyCBCMaaN663zvQZh5su8F95XrFBslxj4z490UIIzSXhlq1DE6QKGATIfBpNLYTMe37eq3Ljid
 KZEG7NLiJhL3QPan0Aq8bOlUlBbGAgH21x1Oy40parMMMOfSx71Qwu30zI5yZUz0uJk335w==
X-Received: by 2002:a05:701b:2814:b0:169:9f67:a91b with SMTP id
 a92af1059eb24-190a54cce7amr5227456c88.12.1792653732054; 
 Thu, 22 Oct 2026 00:22:12 -0700 (PDT)
X-Received: by 2002:a05:701b:2814:b0:169:9f67:a91b with SMTP id
 a92af1059eb24-190a54cce7amr5227409c88.12.1792653731436; 
 Thu, 22 Oct 2026 00:22:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc8c6dsm15223709eec.12.2026.10.22.00.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 00:22:10 -0700 (PDT)
Message-ID: <8a514978-6f76-42cc-a2a2-eb3fbe029159@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 00:22:09 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] multi-target: add riscv64-softmmu
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "luoyonggang@gmail.com" <luoyonggang@gmail.com>
Cc: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <929a2b8d-347f-4f6c-82eb-261febfe8db7@oss.qualcomm.com>
 <CAE2XoE88ma_mKg-40_3zOZyH3vtAndezpLp_5V6uM5DEgeo+1w@mail.gmail.com>
 <ebbc9e10-75da-4d8e-b752-4eb2e6637edb@oss.qualcomm.com>
 <dc63fd40f14a96f17964ce5c9e47eb5c9efff5b6.camel@wdc.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dc63fd40f14a96f17964ce5c9e47eb5c9efff5b6.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAyOSBTYWx0ZWRfX70y0o6E//1h7
 qz2gvEnmAiAPvmIwLDadxsHzQP5vUzu6ACRlE+AFQpsaaosKuDPJqMbyTUPK1dqf/sCrTsNQ5mb
 UJmGUh2LlULTsHEcc/wRUza3gx3evIIwEVdPp3LhTSjV8TLZmbvc6oULYB3pvsZof1iFeMTcIss
 DUb3njzQI3w9MTfNyWBRQpG/kFVe+oHQcXD7dxmxZfXYbXmvdzH5YJLS3tlW62pDdjO8RlZETpv
 ZFZnAtLn8cJiNUBIDieBN0CxIzSIk5z5RX6zcwmZ7AbiD4Blgul/T6pNLmBN2MXoXqpLtj2j7lP
 LOn1aXqhqzfT7q71Z4AH5NceUnyugiGCsENbBj8wcrhdRV88XTTzzi20O4eHbxwvn1qYCV6OdHy
 mMUTQbiXUC4bypkpyUJzkExj5/qf4OEp9uTho95ARJd41lV2+7defRjJgTXozumZzB7kMkflbUK
 WABBtyQyEnJb7EDgwTg==
X-Proofpoint-GUID: hdic-gUELsrUw5xM7-eGynPAzZczv1L0
X-Proofpoint-ORIG-GUID: hdic-gUELsrUw5xM7-eGynPAzZczv1L0
X-Authority-Analysis: v=2.4 cv=CMy/zhrD c=1 sm=1 tr=0 ts=6ad9b9a5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QITQrNqJsH1R_Blz__MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAyOSBTYWx0ZWRfX062v5Lz1VNIX
 gMkwUybBzAqWPTSNu1ppZGe5snzlsTMLrFgKmDJrlIOQUci6jeJ60eZm5pP+mgwq/datViWEEvM
 qfLDHZn77m44oNsdtdNeYo9aIL9xlb0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220029
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/2026 7:42 PM, Alistair Francis wrote:
> On Wed, 2026-10-21 at 14:35 -0700, Pierrick Bouvier wrote:
>> On 10/21/2026 2:27 PM, Yonggang Luo wrote:
>>> On Thu, Oct 22, 2026 at 2:27 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/16/2026 4:22 PM, Pierrick Bouvier wrote:
>>>>> This series adds this target to set of multi-target.
>>>>> Changes are straightforward: functions and helpers renaming,
>>>>> and one type
>>>>> restriction for this target only.
>>>>>
>>>>> While the series applies cleanly, it will need those additional
>>>>> two series to
>>>>> build multi-target test binary:
>>>>>
>>>>> - Based-on:
>>>>> 20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com
>>>>> "multi-target: remove dump functions duplication"
>>>>> - Based-on:
>>>>> 20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com
>>>>> "multi-target: remove qmp_query_cpu_model_expansion
>>>>> duplication"
>>>>>
>>>>> Usually I prefer to wait for series to be merged, but I have
>>>>> good hope to catch
>>>>> the freeze date if current series is reviewed, and send all
>>>>> three at once.
>>>>>
>>>>> v2
>>>>> --
>>>>>
>>>>> - make virt machine only available for riscv targets
>>>>> - enhance multi-target test to detect duplicated types between
>>>>> all targets (we
>>>>>   missed the virt machine since we were always picking the
>>>>> first target avail)
>>>>> - add an additional commit with the rest of softmmu commented
>>>>> for future work
>>>>>
>>>>> Pierrick Bouvier (9):
>>>>>   target-info: add target_base_riscv
>>>>>   hw/riscv/virt: make machine available for riscv targets only
>>>>>   test/unit/multi-target: check QOM types can be initialized
>>>>> with any
>>>>>     target
>>>>>   hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this
>>>>> file
>>>>>   target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
>>>>>   target/riscv: prefix helpers conflicting with other arch
>>>>>   target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
>>>>> targets
>>>>>   meson.build: add riscv64-softmmu to multi-target
>>>>>   meson.build: list all remaining softmmu targets as comments
>>>>>
>>>>>  hw/riscv/virt-acpi-build.c                    |  2 +-
>>>>>  hw/riscv/virt.c                               | 14 ++++----
>>>>>  include/hw/riscv/virt.h                       |  3 +-
>>>>>  include/qemu/target-info.h                    |  7 ++++
>>>>>  meson.build                                   | 18 ++++++++++
>>>>>  target-info.c                                 | 11 ++++++
>>>>>  target/riscv/helper.h                         | 24 ++++++-----
>>>>> --
>>>>>  target/riscv/tcg/bitmanip_helper.c            |  4 +--
>>>>>  target/riscv/tcg/fpu_helper.c                 | 16 ++++-----
>>>>>  .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>>>>>  target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 ++---
>>>>>  target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 ++---
>>>>>  target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 +--
>>>>>  .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
>>>>>  target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +--
>>>>>  target/riscv/tcg/op_helper.c                  |  4 +--
>>>>>  target/riscv/tcg/tcg-cpu.c                    |  1 +
>>>>>  target/riscv/tcg/translate.c                  |  4 +--
>>>>>  tests/unit/test-multi-target.c                | 34
>>>>> ++++++++++++++-----
>>>>>  19 files changed, 113 insertions(+), 57 deletions(-)
>>>>>
>>>>
>>>> Except if there are specific comments, I'll send it as a PR
>>>> tomorrow,
>>>> with the two companions based-on series, and with the current
>>>> helper
>>>> renaming, as there was no comment on general helper renaming.
>>>> Helpers
>>>> renaming can be reverted as part of general helper series.
>>>
>>> Hi Pierrick
>>> I personally feel a general helper introduced too much magic, I
>>> think
>>> helpers renaming is fine.
>>> If we want sharing a name, a more make sense way is refactoring
>>> them
>>> have same behavior, such
>>> as add/div/mul.
>>>
>>
>> Hi Yonggang,
>>
>> It's one of the reason I preferred the ad hoc rename so far, not
>> being
>> sure the effort was worth the result.
> 
> Can we at least rename all of them then?
>

I'm not sure to understand what is suggested. Is it to rename *all*
riscv helpers to prefix them with riscv_, and not only the one required?

> Ad hoc renaming just seems like the worst of all the options
>

Compilation (and linking) act as a safe barrier, so while it's not
consistent, we can't introduce regression. Also, it's temporary.
It will be gone in a few weeks.

>>
>> The original attempt you sent to fix this by renaming binary symbols
>> using asm() is definitely too much magic to my taste. I hope the
>> second
>> attempt, source based, will be more satisfying, as it has very little
>> magic (just relying on HELPER and HELPER_INFO macros).
>>
>> In all cases, this is a conversation that can happen in parallel of
>> enabling more targets since reverting those renames is a pretty
>> simple task.
> 
> Agreed
> 
> Alistair
> 
>>
>> Regards,
>> Pierrick


