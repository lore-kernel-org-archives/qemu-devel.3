Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1509CCA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC8Kx-0007TT-TS; Thu, 01 Oct 2026 00:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xC8Kt-0007SZ-8X
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 00:23:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xC8Kp-0004I6-LD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 00:23:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6913fxRO1238051
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 04:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 18Rg/dajCd0tognlWy5soatv6SKrqtyjs7v2WXJTJIo=; b=cN9rrnyZIUwuA0as
 g9+arcdswh4CNlqg4WJQrsYU6sj+t9kGaCKeg97Pe2POchiMXaPpa30X0J4cpG42
 QMYm4+I8IxTsxblirQ4bVhwMVIPHiojoQIn0ztp7LF0epfC/IygX2dgnFmuNhqal
 ifKnB9DeSrSchk0f2t/ty2tVLZpn1Yx8Mp0e5BbGj1zlMh0/4fBnuanWuI6cXfBa
 bksDK3yKcI3oMywMgOkfLQsqkalZI0cFg3ir+kvhp0i+15qfNXn+OIvXhsEzSQTs
 EpjKfXAIMwu9Bx0GXkkfgdpDEU4Sfpa4MJ1UYpA2cD+vNr5pT/tBAovwAh9dyiiC
 9j15cg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pjdhv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 04:23:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so3318521a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790828633; x=1791433433; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=18Rg/dajCd0tognlWy5soatv6SKrqtyjs7v2WXJTJIo=;
 b=dbTzc6JkvhFc5J3PK/7eRKZ/ovNloANH+ceNjIfiKU8om0bM2xWSJMhH8lKXToTpf9
 aVQbGFD9uivRCkWhYpVWtLXzJzsIyeB2bEq3joJO+hzuCaLiu745wC59Y6BNaO1MblM6
 bHrUV1+yNakxna2f1itbEY2wsk+GURQXTM4Ln44lG9HIObn4Ezc0czzkt8ImevwzG57i
 cRvk2YFeCYi/9kB/wtq4D3AyEnpAhBqYEaNiaL1ccpihHjEPFzkxfrn+oPL0qdC5mUep
 9NcsZULHoVJxqXR+j44ibL9d21HMApkYMUyh5M4pnUpc+pPNJ8O16TBPBl3yDnhd0hXO
 C1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790828633; x=1791433433;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=18Rg/dajCd0tognlWy5soatv6SKrqtyjs7v2WXJTJIo=;
 b=hyF5JJTjt/2XqWQoTDJUkxjfDshsDRNkPjfpveYOD0qypdjjxRIxGMF4MoRi169itv
 9akvVeUvQVGpse/OKb29oik3c2UGmIUXPTtFTOcXEbZEghvHsMdpCxEBDhbzmMgol+fD
 C5ZFHb2GMnZ5zRlXZoCKFq+x3fKsboHhVRDB1TuYxRcvO8h4i/RX6lzUBPyZomjoo9of
 hp0VOR0i+vroFziHP5mofQWv+Qvlv1Dpstbg0oW+uuObGFOgfShqQkkG07JguqOhMXfO
 D+VZwAS03reIZq2VoXxY9cn5Xkbxb9zJIEHsAqP4ItId0DconoG8CXT5/FNEyH20HLw2
 BrVw==
X-Gm-Message-State: AFuF++mziD7PSIy4H29xLLDfeb7lHUchFPlhnWrNWsMZeER8IJWmTVUw
 ClGBtoLY4o1qCPdCZzu8p6Ls3hLNk/D1al5Y9wJphSWLJr3VhSkdB+h8FuXb609bSeTAK1uzotd
 6sOtgkpmRC4Op85U5jBaff05eDQvg7W8D4TTerogXM4Xm8mNBtQ/y31bJ9Q==
X-Gm-Gg: AYBFou0HgTUNhm77D6S8PvnPcglgJJrn07uYR8St/KiwSe9AwfwFpCozHyTv4YkDp18
 6Seeq5nzbeYPnY+cU2IXwasnj+onM0gdCRb33yHy2HVRYyIvrbcF6SSnmrbLDKL5bmORXXKIbSc
 VdmgF38VlRdoHOZ4i9VXajyjlcGM8M+lbsV/t86Tdj60dtVHu8vinRbh01EA+P8mfksDVKuGuhN
 qt++6uiO1gXFLNZ6Kqm5OlZ2tNmK7D2QJP7YT3sr3mrvYO0r8xBqGYE4oYtAGbK1Q3+iqp3aIi1
 ncWlrFzMPvL4scmi4jJFX/cprW1ZGwNNcIHvmjatP6yF9XA/afDLHoRNG6NC0HOC7aXLiL2CYVV
 e5NyThhIIKAWddHgf4zusTsiwbvd8jAyns7wFQ/xCzUaPxuw9G9eGmOcX
X-Received: by 2002:a05:6a21:101:b0:3dd:a006:7b3c with SMTP id
 adf61e73a8af0-3de9e75259fmr3425403637.59.1790828632538; 
 Wed, 30 Sep 2026 21:23:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:101:b0:3dd:a006:7b3c with SMTP id
 adf61e73a8af0-3de9e75259fmr3425371637.59.1790828632054; 
 Wed, 30 Sep 2026 21:23:52 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-888193d2061sm415713b3a.36.2026.09.30.21.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 21:23:51 -0700 (PDT)
Message-ID: <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 21:23:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7A_ieLWAI_iL_XrKxl1IUNAy3Qdsoeag
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxNyBTYWx0ZWRfX+zSlomloGbVh
 XGmQwkP8qtOuYQV+vGG7I+QS98AOMDsMA7rNxxnfOzcgAaastcVWxdxQcCj6k5ldLyQWI0JsZUU
 I8g4n13Hd+JrR5QVHTVOOqY0f/mD/q8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxNyBTYWx0ZWRfX3IwcY0ZaBdqU
 bmCnDcFWbDuK/k6pyOzwZxLOcbsHJGwhyC2un6Y8J4mnEheLC4Gw9mBw+ayNFIg26S6eoOITXeM
 fkqnEd4QVfKdOsL1Q40DKgbrN64/X0wa0G+i0iKIZcvmoMRh01KxqbE/ZvHhraNdW/4ieJ0voqD
 3d7UzcrAW149siw3AdT2YbbnQroIOLurqiN+V3HgDXpDl68hBk3R4XwWhuIWwRsxvssYbAH6ub1
 dxzG2Lg/V7BDzT+mha4H/gCnlSWRDMooOLxlKKJ5+gVR1ZVodrrlvNlJhY9bfzwMdmmMN4j8fYu
 5UIEBd2thsB74sDJCuFdyJaZy+eyyk735rzATt/Xq9aV1bgbtiwkVGv10nHxI1yYuPQSxATL6Sq
 /Ut8eNDVjwK+GRieno8b/8Fd+vsg2G8eR0P7NAa3kq618twkRZP2z1GSfNBm9BYw6O6LxS2rBqO
 T4Jd/b/h47LMjcxwgMQ==
X-Proofpoint-GUID: 7A_ieLWAI_iL_XrKxl1IUNAy3Qdsoeag
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abde059 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=yrPBLZhDcz1HLbYK-PQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010017
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/30/26 6:55 PM, Yonggang Luo wrote:
> On Thu, Oct 1, 2026 at 2:19 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 9/26/26 1:15 AM, Yonggang Luo wrote:
>>> - Add machine_class_set_name() so boards can keep a stable -M name
>>>     when the QOM type is uniquified. machine_class_base_init still
>>>     defaults the name to the QOM type without -machine.
>>> - Document that MachineClass::name is the -M name, not the QOM type.
>>> - Sort -M help by MachineClass::name so order matches the printed names
>>>     when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
>>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    hw/core/machine.c        |  6 ++++++
>>>    include/hw/core/boards.h | 12 +++++++++++-
>>>    system/vl.c              |  8 +++-----
>>>    3 files changed, 20 insertions(+), 6 deletions(-)
>>>
>>
>> First, I'm not opposed to this series, and if anyone wants to pull this,
>> I'm ok with that decision. It's just unclear for me what will be
>> direction after this step.
>>
>> If I understand correctly, the goal here is to allow to register
>> multiple "virt" machines, while still having distinct QOM types behind
>> the hood, which does no affect behavior of current binaries who have
>> only a single "virt" type at most.
>>
>> That said, if we project in the future where we have a binary with
>> multiple of those "virt" machines, how will the current series help? The
>> situation we'll have is distinct QOM types, that all answer to the name
>> "virt", so we have no way to select them individually.
>>
>> Slightly worse, find_machine() will just pick the first machine name
>> virt, which is a non-deterministic order at the moment.
>> https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_type=heads#L846
> 
> That will handle it properly. For single-target binary qemu-system-$arch.exe,
> this won't be an issue, as there is no conflict as they won't be compiled in.
> For multi-target binary qemu-system.exe, we will choose the target through
> -M $arch:$machine, and when no $arch is specified, the default to arch
> to be "none",
> so still won't be non-deterministic.
>

 > "when no $arch is specified, the default to arch to be "none",so 
still > won't be non-deterministic.

That's my point, the current abstraction will create something ambiguous 
by design. When people will specify -M virt, without $arch:, a random 
machine will be selected. At least, maybe this series should ensure 
there is only one virt alias, or make it forbidden and uses unambiguous 
names only.

"$arch:" is just a workaround to not add -target option, except that it 
comes with additional problems, creating inconsistent command lines.
I already expressed my skepticism about the "machine prefix" based 
approach, being more in favor to strongly filter types per target with 
an unambiguous -target option. I'll accept the community's choice on 
this, but just wanted to see this explained before someone hits the pull 
button on this series, so they know what will come down the road.

> 
>>
> 
>> A possible alternative could be to use ".is_available = target_X" on
>> those virt types, which will ensure only one is effectively registered
>> at runtime, thus, there is no ambiguity on name or who is the "virt"
>> machine.
> 
> That's the issue I want to fix, ensure it is registered at runtime. So
> we can list them
> all when a "none" target is selected.
> 
> 
>>
>> Again, I'm ok if anyone wants to pull this.
>>
>> Regards,
>> Pierrick
> 
> 
> 


