Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755A1606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hLQR7uwW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WKV8NtHO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdyZ-0006j6-KB; Wed, 21 Oct 2026 17:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJdyY-0006ic-7B
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:35:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJdyW-0003j7-22
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:35:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeSLx642482
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 21:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RJa+glhofsiegO34d9lvzrqxidmEiE1waH9HZUzUt6g=; b=hLQR7uwWM29ieu7q
 8rynCAhqdqAT4x07eGt8AqNIYB/rMwtmXmNxGgCeGkh8OvWbz+W4Vr9O0s+PXzia
 yoFVDV6j0GhBrd3O8IduHIqAkncAuq0SDLI6yk1a8Jq+HyCwUPbysYxwWGMYO4oq
 iCLEPBjlNSf/P0wjwrhOnzicj77NFRI2gQ8qsuZsu9v4nJbkeG+IxBDcYZBrSb5s
 YQqGDH45AGmH/R/PWgPua1Wb9SnKAxqFTg2ETWDT1xKvj1QmTqMHVso5xqAqY4x9
 c7cd7W4DKKa2Kah/DVXCBNq/D40N9qEF631DEUjrIB7lswlho/8m7JFcyNNBiETn
 IxYfPg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5q9xu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 21:35:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3580c07911eso3306543eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792618552; x=1793223352; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJa+glhofsiegO34d9lvzrqxidmEiE1waH9HZUzUt6g=;
 b=WKV8NtHOilH3e0MXjJr2LoTsU79aPn+d03uHoSD9njen23zHDQj7yrHaj6TosDwn4n
 m5716d1ShWvEbr+gDsIGOBUBHDMVpbhhyurG/eGAm3adKEhGgRJpKq0A2HKHGUdZJDEx
 MJ6E2aWjFTxyWMQiYp9MCZGp3swVmzfjGenQLKzA2dkqFwaUf/4r3IZhEDodSTdQQcZG
 i7d7smQ+RYk4lvfLPKxCItyRdi/JrZv+1q/oBwdKRThH5G6lJd75AdsvTbMhs//YmJ5Q
 Ykimlv+IIZAjhNqpWu1Ih8PG1TeWnmUrCTDwvulKHd16l/XL+k3l9XCRuFXwk0PYxqmO
 uEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792618552; x=1793223352;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJa+glhofsiegO34d9lvzrqxidmEiE1waH9HZUzUt6g=;
 b=aKgaTcZUKrz1iGfHHrfzqLN0idIs3sm41Zcu+Pp9ouzKNzDGVPA3TBtyTsu2gi8Jr/
 wA1PNq/TvyClvmge1abY3OjgpEys4V+VjuPMsw1bV58rspfc665prTMTzi8G63WgQYT/
 Q8B5hHeqsmWdY+AEDja8C80Lb11MNvo68v+PgiVhZYGMrni+d8S4jJO/KD2oxyy6bxx9
 lEjTVzSFcixJevV7GRRhzZ+EQFzs1FRLf6mKVuEa5DQ0bQZyAse6hVW05snNqtkHHuT6
 mKjCfH+3G5IJyfITN3RtqFfPSubWjP2qF2SUneUVlvLKAoKbxWFzDJukFUqVVuD05X7Z
 mqYw==
X-Gm-Message-State: AFq9FYKLEZKz8t9QowZWuT7GuwDVhSJUUuuYlHKW7YDp24vWMqyO1nJP
 U4rFYTkLyX3qpxObntkoXZcNy6r19W8scGCGdSmiIuJM5zHZr6Isezz3b3CYeWDVHbvDWIzK9AS
 I3uRpboV2uUjwlgMpzHav1fS/z5hBSeVPVqJOKfIltFxINQhV+7LF/12J4Q==
X-Gm-Gg: AYBFou2hbZczQ7py8+Kr5oTCyjDu1wEXmZrecfh3VUXDetBnV7JRw20QrrbHHwHcLB8
 Hv5/TwOrOXofLPLtBlwm77bzmPO839/INtCY9hilhkxYquU48+yi3z+p1XXJfTAiwBAFms8OpWV
 LlieGro71hnjx/WbB/CAlGyXmLuq+Yik22bl2BjA89xmulD7D77hjRqT5ApEVhKsTUsB9g27suC
 V17AEvvfNpo5TZAHGlEzbUePz43F+BvtCfPJNZGfIpRmL80XeTSndfC3Jza5NTuCvVxkFnIDN+V
 fDTqGG5bByxUHUBX8MN2vzu1Y/SQTQfqZqLCWjnWtUTCOHjgn4ONyQXK9vOXVB/oGdV5azDve7T
 IKiHLCVbdkLhyUipeJLrOOYVTtepdeo5x1KK1by/U7QGhbh2eHbBD7a0Qn+z8zmMer6UEFA==
X-Received: by 2002:a05:7300:b099:b0:367:414a:c8db with SMTP id
 5a478bee46e88-3674eb303a7mr4529409eec.14.1792618551961; 
 Wed, 21 Oct 2026 14:35:51 -0700 (PDT)
X-Received: by 2002:a05:7300:b099:b0:367:414a:c8db with SMTP id
 5a478bee46e88-3674eb303a7mr4529367eec.14.1792618551281; 
 Wed, 21 Oct 2026 14:35:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5eesm9134486eec.8.2026.10.21.14.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 14:35:50 -0700 (PDT)
Message-ID: <ebbc9e10-75da-4d8e-b752-4eb2e6637edb@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:35:49 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] multi-target: add riscv64-softmmu
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <929a2b8d-347f-4f6c-82eb-261febfe8db7@oss.qualcomm.com>
 <CAE2XoE88ma_mKg-40_3zOZyH3vtAndezpLp_5V6uM5DEgeo+1w@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE88ma_mKg-40_3zOZyH3vtAndezpLp_5V6uM5DEgeo+1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4NiBTYWx0ZWRfX5rlE7QpN5WXN
 eVuhabrxiPv+VrQ4RtazCrO0p5KPLvo5JTO+AJwNP8JGI3kPDsfZybzhU6c82/lh0UBkbRR+YnN
 sP15V9grREXdg9UmUyyBa869LPG5vPI=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad93039 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=dt-pvSbmZywwmCFDf_cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Hih7NkdU2FngtXffLxwC9Jyw-QaEkIaN
X-Proofpoint-ORIG-GUID: Hih7NkdU2FngtXffLxwC9Jyw-QaEkIaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4NiBTYWx0ZWRfX0lv7513fph4x
 4OwaBZZ01S0WIFcn8Kp1Yra1oY/1zum3DbNIqtDwvNAOnAMPRkd8VE5jxYbiGDUHsHDgf3bXTEy
 +iV1zMlgTjuzezYhc41kh3zxD16zgSg+gNoXbxX0s5IfZzQB5qha5olZn1rTBk33XW5JsPlCSo5
 7srnYWLwfOxiQgkVgINpaFttYB9dI0Xk77v6Up+jscyM1d4KgnV+9mV41WWCigI5Qmtrn/2AvQL
 gmqDAcSiuz1r8i+2aVdbKJjn3rZY8CQwruuGPm8CZMx0jXXgPUGSSrtmFBYBCSYP07zXW+UvSjR
 Dsg1yKOcUPJbr/yXLfnaGzl1GDiYNV0ehbJf6mmUbnM+IE2vWXfcnp26HfGrodgxN0+Riz1/leR
 1R5DgS7sZ+6eKz1LdIpFbEVtu5vl7Sqmn7SUIQcDoazCfJewXKv+eyLMGXY2HzjN35HeuhX6hI1
 IgDHLMvsRJWUomakffw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210086
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

On 10/21/2026 2:27 PM, Yonggang Luo wrote:
> On Thu, Oct 22, 2026 at 2:27 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/16/2026 4:22 PM, Pierrick Bouvier wrote:
>>> This series adds this target to set of multi-target.
>>> Changes are straightforward: functions and helpers renaming, and one type
>>> restriction for this target only.
>>>
>>> While the series applies cleanly, it will need those additional two series to
>>> build multi-target test binary:
>>>
>>> - Based-on: 20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com
>>> "multi-target: remove dump functions duplication"
>>> - Based-on: 20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com
>>> "multi-target: remove qmp_query_cpu_model_expansion duplication"
>>>
>>> Usually I prefer to wait for series to be merged, but I have good hope to catch
>>> the freeze date if current series is reviewed, and send all three at once.
>>>
>>> v2
>>> --
>>>
>>> - make virt machine only available for riscv targets
>>> - enhance multi-target test to detect duplicated types between all targets (we
>>>   missed the virt machine since we were always picking the first target avail)
>>> - add an additional commit with the rest of softmmu commented for future work
>>>
>>> Pierrick Bouvier (9):
>>>   target-info: add target_base_riscv
>>>   hw/riscv/virt: make machine available for riscv targets only
>>>   test/unit/multi-target: check QOM types can be initialized with any
>>>     target
>>>   hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
>>>   target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
>>>   target/riscv: prefix helpers conflicting with other arch
>>>   target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
>>>   meson.build: add riscv64-softmmu to multi-target
>>>   meson.build: list all remaining softmmu targets as comments
>>>
>>>  hw/riscv/virt-acpi-build.c                    |  2 +-
>>>  hw/riscv/virt.c                               | 14 ++++----
>>>  include/hw/riscv/virt.h                       |  3 +-
>>>  include/qemu/target-info.h                    |  7 ++++
>>>  meson.build                                   | 18 ++++++++++
>>>  target-info.c                                 | 11 ++++++
>>>  target/riscv/helper.h                         | 24 ++++++-------
>>>  target/riscv/tcg/bitmanip_helper.c            |  4 +--
>>>  target/riscv/tcg/fpu_helper.c                 | 16 ++++-----
>>>  .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>>>  target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 ++---
>>>  target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 ++---
>>>  target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 +--
>>>  .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
>>>  target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +--
>>>  target/riscv/tcg/op_helper.c                  |  4 +--
>>>  target/riscv/tcg/tcg-cpu.c                    |  1 +
>>>  target/riscv/tcg/translate.c                  |  4 +--
>>>  tests/unit/test-multi-target.c                | 34 ++++++++++++++-----
>>>  19 files changed, 113 insertions(+), 57 deletions(-)
>>>
>>
>> Except if there are specific comments, I'll send it as a PR tomorrow,
>> with the two companions based-on series, and with the current helper
>> renaming, as there was no comment on general helper renaming. Helpers
>> renaming can be reverted as part of general helper series.
> 
> Hi Pierrick
> I personally feel a general helper introduced too much magic, I think
> helpers renaming is fine.
> If we want sharing a name, a more make sense way is refactoring them
> have same behavior, such
> as add/div/mul.
>

Hi Yonggang,

It's one of the reason I preferred the ad hoc rename so far, not being
sure the effort was worth the result.

The original attempt you sent to fix this by renaming binary symbols
using asm() is definitely too much magic to my taste. I hope the second
attempt, source based, will be more satisfying, as it has very little
magic (just relying on HELPER and HELPER_INFO macros).

In all cases, this is a conversation that can happen in parallel of
enabling more targets since reverting those renames is a pretty simple task.

Regards,
Pierrick

