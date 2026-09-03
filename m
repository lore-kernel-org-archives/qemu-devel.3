Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83756C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ARu-0000ZL-J4; Thu, 03 Sep 2026 12:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2ARt-0000Yz-4j
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:38:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2ARr-0002Vl-7t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:38:00 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3Y101091194
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 16:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HPKbwvtjL+Z3CJr15gaOweMMpnD1iPIvnJsHl+YOLFo=; b=cDeRtAWw6+GYmAOu
 stYM5fjbptzqZryFAMia4JYzjr+ko98AIyRArzp1V2VLCI4/nHQbhRxSqOtAJxOi
 VTEZs2BtqyYDDSepdgHQOGaFb5nZRleSs9qyCt0opR55I8HNfOW6fc3hbNxKgVxZ
 E2FUNpuVMkC3GQ6K5x0JlxjPBPiJbxGfixn9PFuwdaOk92ig35z5xDocXnm76F3/
 DFZG+Bwcu5vo2H4pCZ2oj3j1opj4fU2MWNj1N6LeXPhpxumg0Yo3PU5BBYd0Maef
 M3+FfTVbzvQRy3inLSbL+46np3qII/OeG+vPUlCWdJZS66K74G0zQ5xSnUCc+kWr
 LqCFDw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekjd3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:37:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1d85c012dso153259a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788453476; x=1789058276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HPKbwvtjL+Z3CJr15gaOweMMpnD1iPIvnJsHl+YOLFo=;
 b=ORjs9e7DGcdWMWy0Rc+MWbIyEKj0PFwTrCBA0FUKEMfvsMaEAFmmVAf0tPHb7aG3LT
 S3DQYy9JKfnN9MWuHEpTVLkVmKwt2xDTWjOBCazNUK9YQJLz034gkA2VtavrZfCzwAaA
 AMPYp4gYcx00mInpYoe4G39VPkPqCBs2SYaNoN1sOz12ffNSdEvreiH445KpWWMrrgo2
 6cv6lu3icyTAhsgOe2LSMFFHacnPjypt099N3Soyb309xLzRKIADnBwrtAnF1XBdBKoP
 Vxv11/96qvN0E8MA1e/a03gASn8ppRuZHTsIiNmOCJD2iDuHU/QqvrrZtMrOOhFteXKO
 HMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788453476; x=1789058276;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HPKbwvtjL+Z3CJr15gaOweMMpnD1iPIvnJsHl+YOLFo=;
 b=fE4SJtzYHeA533aaUQlOObTwAWFnYjd6KOjd31bR3Q/FxriA2rinaCh2kTMbIHb4+4
 qQRZ15+cIhzX0VJ2eODI5MlXKlbGvLK+ykWGXfMNzWphwEGJYtUH9DxTlOQdcJtkpeRg
 UFxbCfCxe9RUeQtSJzym9OawlQNDSiMLGMJ+bNOtIvVO6XzkutYf9cZpXiDvMzTq9ugd
 LRob7cNM3PR36zo02ey1gYw15HtwMdoZjuxFz9d9KqMAB2siqbK0Uca/HRLQZq9muF3X
 teDfibIqcnKIcu33tVZnCIBgRtsfjQvm1TGWslQSHgXuFCD7CQdMoeMyzLMKx39JYLjq
 ANHQ==
X-Gm-Message-State: AFuF++mUnIycMHzG3/NsuBevNwLOEzq+j3O1OrYkzM4mAXG/deGTvXBw
 5pulyb4LehfDgt9AVA4ShDgPp+NUagQ8UYZ08uC+VeUjztBEcmR+tEUL2DIW1lx+4Cqr2hCmvmv
 aX1167rexNw3So1qC1ebjChWy8CU1gp3PGbhtFyLidU1MJ0TFjiB75zhO/Dc2DIyIRQ==
X-Gm-Gg: AYBFou0qkrQrp3WJDxzU2zaXh1eSZTYDr1z/OqTX1XI5eVA9R5m0cY5mbSpifrL34Ny
 SqmxJvnEGoysCtu0gDbGuboCIkowH6dHZueeBfLp5QS88cS/mOIeIlmtk82BJLshuXDiTGjWPfw
 CtrbHSCpRxKuehOdOCwEZU22COE0n03PeR5c9QIEYS1NX2EVR9GFw8sfwdzx7dbKj5NjmukMfH1
 Bc+Or/Y6nQ3TQzzE41mj6T9bHcXfyaxd6cXw/sV6FOkK5qI3pXIxaGVwKbLTjzILoU97w9ol3fU
 vNkPSOsu90SIRJAB+NueRGfJHj0HoFWyPCjDbl/5g2V0eohFGHBwDOCPa+YI3fT0WWmntXBUJYM
 0TCb+/TrIaxAxqf2NROGz2EIEqFuuQvlODWlNQZRP5Ic68PeI4N0v4WRl/aKAtJ9iU7od
X-Received: by 2002:a17:90b:2807:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-39aee16f931mr23263091a91.16.1788453476079; 
 Thu, 03 Sep 2026 09:37:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2807:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-39aee16f931mr23263004a91.16.1788453475613; 
 Thu, 03 Sep 2026 09:37:55 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432423f99fsm587702c88.1.2026.09.03.09.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 09:37:55 -0700 (PDT)
Message-ID: <3a3789eb-610a-4367-a72e-995a469e31d0@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 09:37:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 000/105] tests/tcg: run tests with meson - last chance
 to review
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <878q5lugc5.fsf@draig.linaro.org>
 <c3a1b237-36bc-4150-8aab-21aeebf22273@oss.qualcomm.com>
 <732d046a-dee0-4e83-b553-ef924f476363@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <732d046a-dee0-4e83-b553-ef924f476363@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J_qIJuKzs6f9oWZHekh9f3Jjm4j6zJ8t
X-Proofpoint-GUID: J_qIJuKzs6f9oWZHekh9f3Jjm4j6zJ8t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NSBTYWx0ZWRfX5VJ6BgAHeNTt
 xnDYalsGwPWp9lg0u6Tl0sMYbuqZt5XybYdu9prKOgQKRHLBfvUljkFRblSMskgx5uuMTW1Z6KY
 d6yYgBEj3CfUBr5qNykExCU35sJhIbqHBQ5YZDTK5ek/Mfe2KuOSCbC2HVtbgCIK8PDYBXFE/hR
 h/o0lm2+WI8Gte5BNTqBeFX1gWzxHuV4WjppHwA3EQCd8KPafXZyqmiVdTYWAOJ9QkykC1C9I25
 7woGFsRYI1d2lCPVmXYABMbt6ZcIQQihe+rmrI90EwCwZQViCGRhn3ai1w383ax1VzeieGsLEBo
 imkR6uT9DCtRSt0n662Hh0tZlAGRcrvJVrAgJdIBeD8aTDbMlIsKZ9rJR2BgypUoDP0gKShT4ls
 UL3wAtY6+SQn+brObolYd82qqytu7blQXpbNCJbg+lkb5fycy7UzLB/2JRHFpuKjaWVwXIL4mvR
 Qtq+FJkTM3gP3xp5f0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NSBTYWx0ZWRfXzCU8A08uXib1
 vVvSqgVmIv4M0AQyhD/jgxGD6s6SMxrqOsPa5aKRsgxoKjAhIjz+Uv0QhLSifNPKZZd6CZUUIdX
 J6ixnkKT46U8edxWBWWxKx94hlmKLIg=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a99a265 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=sNwSsDUCwQL1zc3qnXAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030145
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

On 9/3/2026 9:34 AM, Pierrick Bouvier wrote:
> On 9/1/2026 11:22 AM, Pierrick Bouvier wrote:
>> On 9/1/2026 8:44 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> This series replaces TCG tests makefiles with meson, with the
>>>> goal of having something more readable and maintainable in the long term.
>>>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>>>> them with meson directly.
>>>>
>>>> It covers all existing tests for all architectures, including
>>>> user/system/multiarch-user/multiarch-system. It implements all requirements
>>>> listed on original thread [1].
>>>>
>>>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>>>
>>> <snip>
>>>
>>> I think this series is ready to merge so consider this a final chance to
>>> review any architecture related bits. I shall generate the PR on Friday.
>>>
>>
>> Glad to hear, thanks Alex.
>>
>> Just be aware it does not apply at the moment (since yesterday), because
>> of armv7 flag added to tcg/arm/Makefile.softmmu-target. You just need to
>> apply it an anterior commit, and do a git rm to go past the conflict. I
>> don't think it's worth respining just for it.
>>
>> I'll be off next week FYI, so won't be able to help if anything else is
>> blocking.
>>
>> Regards,
>> Pierrick
> 
> A new conflict appeared today with latest hexagon PR.
> If you feel like solving it and adding missing test cases, feel free to
> do and send the PR.
>

For reference, that's the change to add to conflicting commit:

diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index aef9a53d773..4a2826c4276 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -49,6 +49,7 @@ tests += {
   },
   'invalid-encoding.c': {'cflags': cflags},
   'invalid-slots.c': {'cflags': cflags},
+  'icinva.c': {'cflags': cflags},
   'load_align.c': {'cflags': cflags},
   'load_unpack.c': {'cflags': cflags},
   # Build this test with -mv71 to exercise the CABAC instruction
@@ -60,6 +61,7 @@ tests += {
   'multi_result.c': {'cflags': cflags},
   'mem_noshuf.c': {'cflags': cflags},
   'mem_noshuf_exception.c': {'cflags': cflags},
+  'privileged-insn.c': {'cflags': cflags},
   'read_write_overlap.c': {'cflags': cflags},
   'reg_mut.c': {'cflags': cflags},
   'scatter_gather.c': {'cflags': [cflags, '-mhvx']},

> Else, as I'll be off from tomorrow and next week, I'll rebase it when
> I'm back and send directly the PR for this series to avoid having to
> deal with another conflict.
> 
> Regards,
> Pierrick


