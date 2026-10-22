Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E14606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pe2GOfGX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jSl7kXxd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzW3-0004Bu-3f; Thu, 22 Oct 2026 16:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzVq-0004A3-Af
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:35:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzVo-0008L2-Ad
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:35:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHNsx3742027
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wCe3wi/AiFaU5qaKnsvZo07MWbXR7e0sR8Dv008GvSk=; b=pe2GOfGXeJdAJsuu
 DzIv5FpOnMesQ6jJ3WHicrsvt8iqKuSjXVFkj8B3ZJE1uC6v2lu+Gxdl7dSOEQP0
 xLah0ZlB8fGa+TggMpBCat/V8qLX5kYObNHDCXth88LpZInhxs+Pco/9dB1z3uNt
 imp4ZIqVoQlgpUMpK1yiyB7jRVnebSbb4FdaKpxomqLin5JV5COWI32T7ZKHOFnX
 pVukxghsKbqwdSNJlryW/GoX9zP7dNhCAxurZuh7halSttNafzoLP6gdNCb2Z3GN
 YszFmKe4G8/JVZdAueYtOaw7vcmgqhlY4z76CwmrEhLcZNwvpldtiGeRIlGWfnpN
 oJeSug==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0fae-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:35:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3692c5b061bso547357eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792701336; x=1793306136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wCe3wi/AiFaU5qaKnsvZo07MWbXR7e0sR8Dv008GvSk=;
 b=jSl7kXxdK73QFlR4FJQ3jt8i6NEUmX5Fz9IOxnJY0qHh4phq+CQh7Eh/UujY/TfCJW
 QmXg3GZz0lhNxeWKqCsNkW66sS8jItfLV+k3tBg0Bdjgvafy459aUrAu2I5/YdDsYfb8
 lUWmNs/uu0d+IZwUbxyHrLN4ZAi8wxf2X9uXUNbSFVbpE/1MGVDsP+S4VHcei0VXumQ8
 UJova7UW1UuK1cD/ACeA6R6WkL+b33bAqhSV83C2fSUYiscQ39lwv6tp1y246ix+tOEQ
 jhlljHAYZ8/2uGOxhRqAgxvkFtQdOPx/DIMVWNUcFf7BXtQtebcJ3twv6nK5eTZ4Q5g4
 eIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701336; x=1793306136;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wCe3wi/AiFaU5qaKnsvZo07MWbXR7e0sR8Dv008GvSk=;
 b=Zruy+jSTkwa1NbH9JPnC2L0/S/7tv514ZEVdAoBiumEwp+0vHoEB/RdgRT2qTtymFF
 ytQc7/FLP6rxr/FdvWduM9poNtlE3UHLdWHBba8aEoPYPXEocweqVzidgDJC5IrgW+7s
 JT8bPK/60jkPTLAId8I20L4lJCYkjPvYliJh0l+itm4yLUvPtJDeUtKRoEcF2lP8AGui
 QOU+/VwygVrRDj9jJZzkTGQ7gSefAeD4FfNPRu2Lx4jPsi9JrJxLy3l4PnToZxqZ7t8y
 LTiPzkj89AxaOH3exgifa/xyB00jK5165w0nw3XZU19+t2vaJm7KQJhUoqA+xDXm+Etq
 SSUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/AKVfPFrQ1VHa76uEqmZZBy1IR8CUl6Neu2G+eXjqRGLIwCt/OObGvuZHSAMb0/Q5bbFqmrTK8Wfh@nongnu.org
X-Gm-Message-State: AFq9FYJj5hSxd2pGpBjXMjG6KGB4jzkeqtxODVpOlQdmaFSM89NbZEfX
 TQ8SXJiLTZVIhCVUQswnO8xkHAly4LkF6aViREm90rDvMtD/YTegPivhu5WzmrWeMHcOBnz/ZkA
 ohtFy87vi6xi5QmrkZazKYpVl6lRwYawWBlo+sEUVDhhWuA1bM9atsrzjNA==
X-Gm-Gg: AYBFou15Xl8Nv4gSYjZApdKtFN6zvQA6xtJOyA8WS0Gl+IFW70JQe7Cj0DrWMe1A26W
 zl/0vFTjh790c80iAkiMdqMivH+7fDGQbvwKZRNNCgPm1NJhKe7h/sNt+QuS3x8Bpbeg3eb5KtE
 po4BirBQqBVysIMEceKdLmT8XeHGUETXo5M/Yy9OsplNcWE9HUK4v02E9ARNk4ZweONAoQGgnxB
 gLZZPfW0bLHKs8as9m9Mmd7O2L6PNjEPpgo1io0rL4mQg5xN5BGG7g4nbFcEqqipo8HRo27jJ4v
 67eqyvE14SC0Ts55xRHqHLJKrNHhrusDUkqHyY9U46WQ1qEOC+3Pc3zxetY2loC8W5QydvHgthw
 wI1I+2MsXKDn0O4VxfsCfuoVUTL0rcW2KXJ5BovQQ9nDYfA3GN+eI3v/hyNp/i1A7Z5bM3g==
X-Received: by 2002:a05:7301:dd96:b0:347:8d01:164f with SMTP id
 5a478bee46e88-369d9799eeamr285567eec.19.1792701335826; 
 Thu, 22 Oct 2026 13:35:35 -0700 (PDT)
X-Received: by 2002:a05:7301:dd96:b0:347:8d01:164f with SMTP id
 5a478bee46e88-369d9799eeamr285527eec.19.1792701335260; 
 Thu, 22 Oct 2026 13:35:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9e1a085sm286114eec.29.2026.10.22.13.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 13:35:34 -0700 (PDT)
Message-ID: <42ad0b95-6e9e-485e-a183-6625a5f93511@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 13:35:33 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] multi-target: add riscv64-softmmu
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 <8a514978-6f76-42cc-a2a2-eb3fbe029159@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8a514978-6f76-42cc-a2a2-eb3fbe029159@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MiBTYWx0ZWRfXw61e6XgKiy5J
 UbgSK1HdLvNMGXtdB0g7Ho/tMHqWWQYuSmRDjOGB0RKaoJRFCVlNzaCH3/yuRD0z7EjRgXbKBiR
 F5YefU0TK9oWeQPkSxMOTX5RjZ5srJjB2xYbFO2Xa4SLO05GFw1rU1xSvQPlBU8sOKcHPKyhITW
 U6FIn+uOiGHi0U/4xqE06pkSRmfmFf0JlCxvUs/WasCgeAN80tghiswBy3kSw1j4Tsaj7nV7gGc
 ThDCWfx9sVbAy3Qwoc/By46WbQ9GK1kaY1uA0sgjBPhCa+glcF6xPgOTqChp2g58a4IltzB+VyP
 8Ce2GtWwESsAhKj5T7bk3VI9T6Fc57Zr5+sK8L4xPqjdT5eBOwzlRzvXRbSlASaHT5aBCofD9V6
 1Eu+oja6rV3hOEiFK0FOweMLnr0oQGFmj4wmmGCWw6BkZiua0SlfAvvdDwDzrIiq568pljwoEQ8
 DmoW0C9d269pn6ESXBw==
X-Proofpoint-GUID: LGuPU_nGwA7VW187K1ynq-lieExSZkoB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MiBTYWx0ZWRfX7FAtzjDCXiTj
 DAvYcvxiILpNICMmeb4DOxZQAY3sab37iUvzl9ksyZ43KQpZ46j+tC5lJxSx1lTW5UVGwxnKxQV
 TFfPZd/iThIho7PAMFEd+9Nao3dxVEg=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada739d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=aapH_XW1r2SsUJNC2SAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: LGuPU_nGwA7VW187K1ynq-lieExSZkoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220082
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 12:22 AM, Pierrick Bouvier wrote:
> On 10/21/2026 7:42 PM, Alistair Francis wrote:
>> On Wed, 2026-10-21 at 14:35 -0700, Pierrick Bouvier wrote:
>>> On 10/21/2026 2:27 PM, Yonggang Luo wrote:
>>>> On Thu, Oct 22, 2026 at 2:27 AM Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>> On 10/16/2026 4:22 PM, Pierrick Bouvier wrote:
>>>>>> This series adds this target to set of multi-target.
>>>>>> Changes are straightforward: functions and helpers renaming,
>>>>>> and one type
>>>>>> restriction for this target only.
>>>>>>
>>>>>> While the series applies cleanly, it will need those additional
>>>>>> two series to
>>>>>> build multi-target test binary:
>>>>>>
>>>>>> - Based-on:
>>>>>> 20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com
>>>>>> "multi-target: remove dump functions duplication"
>>>>>> - Based-on:
>>>>>> 20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com
>>>>>> "multi-target: remove qmp_query_cpu_model_expansion
>>>>>> duplication"
>>>>>>
>>>>>> Usually I prefer to wait for series to be merged, but I have
>>>>>> good hope to catch
>>>>>> the freeze date if current series is reviewed, and send all
>>>>>> three at once.
>>>>>>
>>>>>> v2
>>>>>> --
>>>>>>
>>>>>> - make virt machine only available for riscv targets
>>>>>> - enhance multi-target test to detect duplicated types between
>>>>>> all targets (we
>>>>>>   missed the virt machine since we were always picking the
>>>>>> first target avail)
>>>>>> - add an additional commit with the rest of softmmu commented
>>>>>> for future work
>>>>>>
>>>>>> Pierrick Bouvier (9):
>>>>>>   target-info: add target_base_riscv
>>>>>>   hw/riscv/virt: make machine available for riscv targets only
>>>>>>   test/unit/multi-target: check QOM types can be initialized
>>>>>> with any
>>>>>>     target
>>>>>>   hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this
>>>>>> file
>>>>>>   target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
>>>>>>   target/riscv: prefix helpers conflicting with other arch
>>>>>>   target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
>>>>>> targets
>>>>>>   meson.build: add riscv64-softmmu to multi-target
>>>>>>   meson.build: list all remaining softmmu targets as comments
>>>>>>
>>>>>>  hw/riscv/virt-acpi-build.c                    |  2 +-
>>>>>>  hw/riscv/virt.c                               | 14 ++++----
>>>>>>  include/hw/riscv/virt.h                       |  3 +-
>>>>>>  include/qemu/target-info.h                    |  7 ++++
>>>>>>  meson.build                                   | 18 ++++++++++
>>>>>>  target-info.c                                 | 11 ++++++
>>>>>>  target/riscv/helper.h                         | 24 ++++++-----
>>>>>> --
>>>>>>  target/riscv/tcg/bitmanip_helper.c            |  4 +--
>>>>>>  target/riscv/tcg/fpu_helper.c                 | 16 ++++-----
>>>>>>  .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
>>>>>>  target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 ++---
>>>>>>  target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 ++---
>>>>>>  target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 +--
>>>>>>  .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
>>>>>>  target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 +--
>>>>>>  target/riscv/tcg/op_helper.c                  |  4 +--
>>>>>>  target/riscv/tcg/tcg-cpu.c                    |  1 +
>>>>>>  target/riscv/tcg/translate.c                  |  4 +--
>>>>>>  tests/unit/test-multi-target.c                | 34
>>>>>> ++++++++++++++-----
>>>>>>  19 files changed, 113 insertions(+), 57 deletions(-)
>>>>>>
>>>>>
>>>>> Except if there are specific comments, I'll send it as a PR
>>>>> tomorrow,
>>>>> with the two companions based-on series, and with the current
>>>>> helper
>>>>> renaming, as there was no comment on general helper renaming.
>>>>> Helpers
>>>>> renaming can be reverted as part of general helper series.
>>>>
>>>> Hi Pierrick
>>>> I personally feel a general helper introduced too much magic, I
>>>> think
>>>> helpers renaming is fine.
>>>> If we want sharing a name, a more make sense way is refactoring
>>>> them
>>>> have same behavior, such
>>>> as add/div/mul.
>>>>
>>>
>>> Hi Yonggang,
>>>
>>> It's one of the reason I preferred the ad hoc rename so far, not
>>> being
>>> sure the effort was worth the result.
>>
>> Can we at least rename all of them then?
>>
> 
> I'm not sure to understand what is suggested. Is it to rename *all*
> riscv helpers to prefix them with riscv_, and not only the one required?
> 
>> Ad hoc renaming just seems like the worst of all the options
>>
> 
> Compilation (and linking) act as a safe barrier, so while it's not
> consistent, we can't introduce regression. Also, it's temporary.
> It will be gone in a few weeks.
>

I'll delay current series until the helper renaming is upstream, and
repost it after.

Regards,
Pierrick

