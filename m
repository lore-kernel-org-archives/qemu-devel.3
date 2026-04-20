Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB624F588F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErpV-0000gQ-Je; Mon, 20 Apr 2026 12:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErpS-0000fi-7R
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:50:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErpQ-0002LL-Em
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:50:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KCJZDv1532103
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NlRGs5cl2KRiESF5qvo3+N3bJGaG/bZPBdlocOdeelo=; b=f6pNhczYiA6WY1C9
 LWGsqElHwMccprFW5G2yZovTEGxGBPTfMw5qE0Nc3/WDxBpb/03P2LY0M2foSJo3
 +reS5YwMc4PPl0woG3tgLYiQI4EpbubO1jgBb5nF7ViHqm5RetR1qMVVq5PQJjkR
 jjFQ2UzZQCpAvrVjo7gcEUgIo2dL/+hv9wA53sB4cZ4Cwg1AbqITpT3DKY5/em1D
 hmeLv1MUqOgQBd7LGp8AntBvNXQgD2qZsieOjZgQH1gNeGiAMZNo1AJKpCJR9/GI
 3Z4BRiLb2fSIhNj4fkz3j44FPK3DsQ4HBXkejAz4UgyZYXTUfLq6cjDuEdmAVB8P
 VQgFyQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus2ch1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:50:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2de07c12745so6608906eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776703829; x=1777308629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NlRGs5cl2KRiESF5qvo3+N3bJGaG/bZPBdlocOdeelo=;
 b=aan4HkimRFiHXUhxij8gOJHRv05PUHU7LZFulFi79AKHRYwKdjy4bFCUUBQiSWiRcj
 ysSewudvfwoJ0fbR81L2rFFYdw8sFGo+daKBLGYNPsMZNXuUh9xGA/b+wduvrSsguXbH
 +SiFE6oyiwVXyeXTk2JPhdOlNCUaG+BbLdZjB93+JI3FVCLXJb3inrMDbSZmoDTXyOSc
 M8h1PtllPHR9FMpIopg166luVxXH7Wg6jUWFhjR0hRpW1603SjzDMwnmJOSepQmdua7h
 1JoK0ilapir1J2tfesg4Xgt2DdHwQY+by3lj1GPy/CtmbatlXiloLg4N+KySHV9ioOlh
 3GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776703829; x=1777308629;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlRGs5cl2KRiESF5qvo3+N3bJGaG/bZPBdlocOdeelo=;
 b=adCy4q3UWN/ip8vqikS7T1mHQyNZt6YRF5PzM5inWETRtAghjhQX5QA70jUZkIS7mF
 3aB6Wg+FnEvfmCq3CDdu3Z5NCX4xyfYizrvlKuyzw5XJzwRFVJojhXYzJGOHj1SVMSUM
 6yk25y9k127rFK5VH7MO7KgbNlnYq7y3ERIoFRLDdwZ/eckQTaNzDS8KFWVWZkFoNkYI
 yE+f1/uHUbLOKnMN7IURzReEPBpcO3RZXmCZZKs3B3V+jowxwCTJ8GXLC0oVBhN9Ko3f
 orW/cLErnSbwN4DWV8xAor+N7Ypvo/zAf03M8OfdyQL67+ZlwO9tvc6hm0Gq2/c6Rrxx
 +HeQ==
X-Gm-Message-State: AOJu0Yx1ADDnSD/BP9JHBEXZRmJUgK494OGr7Tyj/GrD9TUpt5YETRgF
 YQTFIyHik3HlSq8B/LFo0J5m3ZmzxYs+lEl1GEuvh7yceNWJ9PfdpH3/aKT8h8x1JZQWjqRRpPA
 3RRwXAI/Cr5ZPYDaSWXp3KoIMEC7b3/XNsw3lx61L7A++CDwx3byMe0/IuA==
X-Gm-Gg: AeBDies8HModKHpA2x0mR41GUOZn/UoT/hnpIkfW4Lkycn1k+nS5s+OFcGmsyGFD341
 BWTFvK3hDntP5Qmqw6t1w6IEOQw3mngtbdbQNDSZrzY0535JBJfznWnfKOd57sRCErB9B7Aeaej
 xlUZjHZgUsaTEiJsCxqDL58yYX6eD6IwdSEnMSpPDBwpRMU0Ro7IbNggEvxL0C36JuXM4js1td/
 r63NHtzlCpjz4FzIma08F3o3qxY2rL4TpbQ5YK59TosOSIVUwHao7ikGN33+vlKUICKAQghBH+I
 aoO9YZyJFudwYNmEDrBlYdydq0gZrh4P8iA9Hg7GNJmU+gAci62r+DZmnHkoqsDz82wGpN3PGnu
 UkggNfLPZkr6iWWX2WGxdgZIMB9YVsOcD20cpnbAtuyJOi61rM7DtsX1Gl8u2h74WNZ1GBCUSfi
 IaGBelOzVYVHbBfMzscroSUpfD
X-Received: by 2002:a05:693c:2b15:b0:2d9:b466:5e19 with SMTP id
 5a478bee46e88-2e47a1058a2mr8689249eec.21.1776703829233; 
 Mon, 20 Apr 2026 09:50:29 -0700 (PDT)
X-Received: by 2002:a05:693c:2b15:b0:2d9:b466:5e19 with SMTP id
 5a478bee46e88-2e47a1058a2mr8689206eec.21.1776703828570; 
 Mon, 20 Apr 2026 09:50:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ac84c38sm15559276eec.13.2026.04.20.09.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 09:50:28 -0700 (PDT)
Message-ID: <5ee12c29-5d61-4c3d-a8b9-bb049585ea56@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 09:50:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] target/hexagon: add build config for softmmu
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
 <46a10ac4-a267-458e-973e-a784173460a3@linaro.org>
 <CAEqNhNbOJfne+0OTazYfYzzxbReNDng9pm=iNmsyFiEhasXoKA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAEqNhNbOJfne+0OTazYfYzzxbReNDng9pm=iNmsyFiEhasXoKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2MiBTYWx0ZWRfX5kxmI4hGftWG
 p/kugMg7ipo1/VFCixP28wCBqr6Pf2bbvTL9lIoWlWwsQ8YIzDLqzJFAJdRvhLI60EMkIEfB9Cs
 gD6vl/ghGlxmtBdyOQS6wwMOfvs+AYuZ4NYtNNIQ+mWNoWj9rK30VL70qS7ZE/n1UtOkOtvTrJw
 spNeJchoV+ySUSewVtfq43o/7rvvZyXnPhoT38PId2tuA1zU00wKcXah5KzGa1TtXhIsGA8e9ed
 AjWDAxxfxdE7wVxTmuCFJHsXmjoLIJLl8ZwjCoKhQxrY/LGEzGxC4l8a44tbGxejPQ3uOSrc4sR
 pen9RQq9dMIQtPZtPjEk0AKjaMTebOtLUOteNWFZS6dsS4MSoyC3tBZOseUM8WDjwTbkcd1mEr4
 /rzAObiBa11r8f2RPlFbpMmUy85aj2WOZ/goSCQyGGO3pMz0P33wXf56ZPwqQcwzoFX2d9548Dg
 yEz7Y8+H/lNOP5lzgsA==
X-Proofpoint-GUID: sum8oyx5rfSjOyc13-AJvziLUr79eS2T
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e65956 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OZYb1L2p-Va5CfB5bhMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sum8oyx5rfSjOyc13-AJvziLUr79eS2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200162
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/16/2026 8:12 PM, Brian Cain wrote:
> On Thu, Apr 16, 2026 at 4:19 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 16/4/26 23:03, Brian Cain wrote:
>>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    MAINTAINERS                                 |  1 +
>>>    configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>>>    configs/targets/hexagon-softmmu.mak         |  7 +++++++
>>>    target/hexagon/cpu.h                        |  7 +------
>>>    target/hexagon/cpu.c                        |  3 +--
>>>    target/Kconfig                              |  1 +
>>>    target/hexagon/Kconfig                      |  2 ++
>>>    target/hexagon/meson.build                  | 13 ++++++++++++-
>>>    8 files changed, 32 insertions(+), 9 deletions(-)
>>>    create mode 100644 configs/devices/hexagon-softmmu/default.mak
>>>    create mode 100644 configs/targets/hexagon-softmmu.mak
>>>    create mode 100644 target/hexagon/Kconfig
>>
>>
>>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>>> index 9883c4d1681..355abb4fd24 100644
>>> --- a/target/hexagon/cpu.c
>>> +++ b/target/hexagon/cpu.c
>>> @@ -713,9 +713,8 @@ static vaddr hexagon_pointer_wrap(CPUState *cs, int mmu_idx,
>>>    #endif
>>>
>>>    static const TCGCPUOps hexagon_tcg_ops = {
>>> -    /* MTTCG not yet supported: require strict ordering */
>>>        .guest_default_memory_order = TCG_MO_ALL,
>>> -    .mttcg_supported = false,
>>> +    .mttcg_supported = true,
>>>        .initialize = hexagon_translate_init,
>>>        .translate_code = hexagon_translate_code,
>>>        .get_tb_cpu_state = hexagon_get_tb_cpu_state,
>>
>> Please commit this change as a separate patch, explaining why
>> we can do that in the description.
> 
> I think I'll drop it for now, and revisit after this series.

It basically means supporting atomic instructions and memory barriers 
correctly. From what I saw, memory barriers are nop at the moment.

Regards,
Pierrick

