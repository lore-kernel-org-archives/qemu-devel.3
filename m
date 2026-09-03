Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8373C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AYN-0002FH-4c; Thu, 03 Sep 2026 12:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2AYL-0002F9-Az
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:44:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2AYJ-00045T-6W
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:44:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G39Yg927750
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 16:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jFk2RTCSHkZaY67CFaLAXetFy2F2sAirj3L4r5P5TAk=; b=nznxhNAVX7bLfcEH
 07GtKvjwUEBcSuz6Q+TcJKBdIQ+S/JUgGcV1wfXK31N5iZpwz/K2rev9a4n2oOSA
 CSbcrSSARn0RSIMzYIHeVfVUB9P6K1j+xh5nwcvYF+BA3SqSkh6zWmX8Ln5wGVX2
 dr2lnSR2zQ0bm29h+cIp5HbMHLC4egyhVDTivF75FtyZpCwjnKRr0oqoNi1NsEU0
 aaTgF0YDAIrkVJqrnoIqfYtGMg+X4q8y1BEbhg5HJ9QsJ8A60ekKf4QQmnAnuQFF
 XTCJqSzvNkAqdvu4TOmKy4Ebjnl8uDA6gHhiDphj1z0Lf0T7PU5Pz4sOSVMid0zH
 NXfpZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx1r3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:44:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso173635ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788453876; x=1789058676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jFk2RTCSHkZaY67CFaLAXetFy2F2sAirj3L4r5P5TAk=;
 b=BTowtYNLMQqkEoMTp6kw1QskwVCH3M5yoTPrVeXdStJRjXgvew0fefcvNF/wfjF/2N
 uxvaAL9U7yXejAF90Oca6WzGSqrLACVoq02G+wVlBdQ+JL/iVCKnNBFLUh1pknssnl5H
 HLUxCIlQlgw76oTDgaJ0clR8WEqjkyBE3mJ0/hXs5apngSRMOVLLtAYFWBNgiQQ0c2tH
 mQ79oa+adKTJochGrytQlgDVkc8pE+otbxWhYlmcmLXAYcEhT7jhj4ZjEEEMvy0Crwjz
 IUY9XY+s3yeloxqW9vhWjKDIMHcmSahGbcW8Vr7ZO/AwvjGprewrPp/XAOGso8gAxBzB
 J3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788453876; x=1789058676;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jFk2RTCSHkZaY67CFaLAXetFy2F2sAirj3L4r5P5TAk=;
 b=Ml8IowpOnRtgRclJ1yZGOQkD4Qs8dxnriOeSPKPMgWSW69w0UCWQyvTjJyCKlN35Jw
 L1ciP5eIx3XwqHtz//35HxwjTujq0tLMEllg9jjHGQhATv7KX6jTab4AjnjgPsm+dnF4
 p1Y6LRlvqv0nN2NtOebmkM7HWs2St9V6foZTPzOR48+5it68C6W6l08iDRG5XTr3AiK4
 cNqkaVHMnTCWW9FUXi7I/nPSTdrfNcpugb+eknQ6OEY25/IX3j/6mu+etdVxJEDlI/Af
 8NqYPfBlx0neAa3lVAk9+G8vE7Hj4Hovu+ujjv0IzfyaR3LLR2Png4Jux/zvIkbaZlZu
 gRYA==
X-Gm-Message-State: AFuF++ltGD+GN0rH/qUe7Cq7wycUPoj0s6jzTW6tvJnldQ9iTnjuwZI9
 vuIdJbwGXj7jNR+1L31OjXBfRQlbiH/BHPx25jwCEZkxM6dFPZkfTaKW4EtH//ph1M5I/zYdIAR
 mjbSPB0UhPVF7Hsc4eWsw3MOcMGVKJkV+Vo5NgXgBQBEBE7OU66FDHMveAw==
X-Gm-Gg: AYBFou08t8fAHR9msFGvF1zxtyu4FQ09iTBa94en5Q/T4jGDQql3xssP/QNy66P98nP
 sgGpeJemaiU5ejdQM93pz5LL+AoLon+fooLnSMzZWoyvyusSizhRDGf3lISfbLADGdFouBcc+7i
 98eoyPhbJvcGHckdjkFb9Jg8zirlWS9fmXES7H6YaABOfJvgYXl/A/RhN132ZwEXtvsUdLjutbK
 fS84eJmaVun0savoNfSLTrOEVNHTrqBnP3OsL0/5nv5htU/q1kMJELWoYC638GOxKPYtdvJdpId
 YJDV/nZg08XFCdq8H+i+NCTaz4UVKkyvxvt4qbu7k37jMIFHKj+xv8HeAS2K2Uxi5eE8eojHWQJ
 1AaroNp5ZVTQ0Zj1hwR7roDwZ6lalL6++mQJMv5pPHvBjOaOg8toUlphoe1XFcUaqt+nZ
X-Received: by 2002:a17:903:903:b0:2da:e967:794e with SMTP id
 d9443c01a7336-2db12657cacmr3706315ad.19.1788453876213; 
 Thu, 03 Sep 2026 09:44:36 -0700 (PDT)
X-Received: by 2002:a17:903:903:b0:2da:e967:794e with SMTP id
 d9443c01a7336-2db12657cacmr3705605ad.19.1788453875714; 
 Thu, 03 Sep 2026 09:44:35 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339885ca07sm226629eec.1.2026.09.03.09.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 09:44:35 -0700 (PDT)
Message-ID: <f01e1a0a-5794-42e4-addf-203590501b8e@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 09:44:33 -0700
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
 <3a3789eb-610a-4367-a72e-995a469e31d0@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3a3789eb-610a-4367-a72e-995a469e31d0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FiMR54aYookXTPl_9qDDXMlIAElzMDLh
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99a3f5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=iKV36UOfJ3wH4EvjPMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: FiMR54aYookXTPl_9qDDXMlIAElzMDLh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NSBTYWx0ZWRfX2tcq0bRbnq6T
 Ka+u1i4t0eSXsvPVSaw8rgLWEp1A0kqWww6u3nszyCepjKQcyVS8nUGdw+DY14DoI8bUIHgpT2l
 MgSwd8Ll1FyJCLfhShJ8TCVRWGFQnrORYCgFp7uZo6A8uRbvCSfsWxU1iVNlM3urLYEXJLb40bI
 4BJlqVzhWCEsx6mQVkoWjOGdkUk9B3/kpAb4OvXFJkqOfc0csVMsEd+WTdzGciNxolZDlpqRxp5
 JZ8d8tSD7SenfLJ9BBXRK1af9QLDNkd6aSb4RR3GS45aYmeMzfacjK18bwIytS7XnGwn6knqUID
 ZPqHyRKgLMfIWlLMapQhWwSl//+WPqfIxNW8AYfo1qUSnEw02Gi0jyusrMDOP2kNMCCLVb51zyl
 9nsd60Ys8JZ7BHDNbjxN8YJ8zvWTXLP1MWs8Mb410K6BFds0zSMFfYPdkxcqF3qKoyLqMNh1PpB
 HDfHPc9ca8ayzKtnnAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NSBTYWx0ZWRfXwd+I55kR9vMF
 KEVdJKc9Ur70YvTFBMSb848dXUhhpmn5GJCNhSyQu9aoUai0ev/sQr/mzITXuvatVHEfN8oei4+
 VeXXZktqMLwLUTrFxu57Shp45jGu+7k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
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

On 9/3/2026 9:37 AM, Pierrick Bouvier wrote:
> On 9/3/2026 9:34 AM, Pierrick Bouvier wrote:
>> On 9/1/2026 11:22 AM, Pierrick Bouvier wrote:
>>> On 9/1/2026 8:44 AM, Alex Bennée wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> This series replaces TCG tests makefiles with meson, with the
>>>>> goal of having something more readable and maintainable in the long term.
>>>>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>>>>> them with meson directly.
>>>>>
>>>>> It covers all existing tests for all architectures, including
>>>>> user/system/multiarch-user/multiarch-system. It implements all requirements
>>>>> listed on original thread [1].
>>>>>
>>>>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>>>>
>>>> <snip>
>>>>
>>>> I think this series is ready to merge so consider this a final chance to
>>>> review any architecture related bits. I shall generate the PR on Friday.
>>>>
>>>
>>> Glad to hear, thanks Alex.
>>>
>>> Just be aware it does not apply at the moment (since yesterday), because
>>> of armv7 flag added to tcg/arm/Makefile.softmmu-target. You just need to
>>> apply it an anterior commit, and do a git rm to go past the conflict. I
>>> don't think it's worth respining just for it.
>>>
>>> I'll be off next week FYI, so won't be able to help if anything else is
>>> blocking.
>>>
>>> Regards,
>>> Pierrick
>>
>> A new conflict appeared today with latest hexagon PR.
>> If you feel like solving it and adding missing test cases, feel free to
>> do and send the PR.
>>
> 
> For reference, that's the change to add to conflicting commit:
> 
> diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
> index aef9a53d773..4a2826c4276 100644
> --- a/tests/tcg/hexagon/meson.build
> +++ b/tests/tcg/hexagon/meson.build
> @@ -49,6 +49,7 @@ tests += {
>    },
>    'invalid-encoding.c': {'cflags': cflags},
>    'invalid-slots.c': {'cflags': cflags},
> +  'icinva.c': {'cflags': cflags},
>    'load_align.c': {'cflags': cflags},
>    'load_unpack.c': {'cflags': cflags},
>    # Build this test with -mv71 to exercise the CABAC instruction
> @@ -60,6 +61,7 @@ tests += {
>    'multi_result.c': {'cflags': cflags},
>    'mem_noshuf.c': {'cflags': cflags},
>    'mem_noshuf_exception.c': {'cflags': cflags},
> +  'privileged-insn.c': {'cflags': cflags},
>    'read_write_overlap.c': {'cflags': cflags},
>    'reg_mut.c': {'cflags': cflags},
>    'scatter_gather.c': {'cflags': [cflags, '-mhvx']},
>

And, please find an updated branch for current series here:
https://github.com/qualcomm/qemu/tree/pbouvier/series/tcg_tests_meson

Regards,
Pierrick

