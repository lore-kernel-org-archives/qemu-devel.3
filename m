Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C3606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xwmp4meT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mr1SnXPT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPO3p-0000oY-CQ; Fri, 06 Nov 2026 12:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPO2e-0000Za-46
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:48:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPO2c-0006lG-60
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:47:55 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HDSXO383178
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hTGWsHlabfsW4CJoAyvMNjyxrLVOZhaTpVVhLMe7jIk=; b=Xwmp4meTTIgnC+Ha
 PG+9gmI0IM73BG+hbhHw1yc9jAk38Rh3mVHyUI9aGT5BAQ3LUj+HhScE3l7kUkxw
 uF1ii3byRvdpMLGH4+whFIRwxqfd2B40FksEL3GanPEhfPiJ/jIt4W38EvrzZ7GG
 RQWKwc3Wvjhnoe0XfRh/9DtLJ9qM+XozQk+No7Jhy3tGhXFwrdCHoFgOD5JdrEhK
 l8PH0T7l3YPxp/bl9thhbPThiMK3Q8CxHYNPdBUnQIWZIheBZZ6sfINHDBmiDfMq
 JUm3//NbOi97xPFx0WB57e8c1eLgKYnB/lJ2rbjCL0AOc8NJO+iTMuw3hjuxInJq
 Wb4msA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk3wg4rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:47:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36fe0b57d91so857089eec.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793987271; x=1794592071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hTGWsHlabfsW4CJoAyvMNjyxrLVOZhaTpVVhLMe7jIk=;
 b=Mr1SnXPTXVY3q+M3viI+qO84e89KPT3Ep3WjZvkyYf+Scanmp08fGMyV1zQt8cIf79
 JtDaPkNmUkFOy151dBSAgGx5cRqPgY76GUCXopMCJDa3DweZieBgjFsRSIFr9t7PEBw5
 lM9+obCVrU9v0T4zHuIFHmleRQLzHVnyUCjur5MHgz6MwayyE5SWxOeF/+Wm5PS/uYTN
 ar7J0bwMlO0ZnvTePkjoytCbazP+9EH0JMUFJz9Ld/gQbeYMvzW8sM/xijJ/DR/LTIYT
 X71cBXf292alfQdghsLwNjT6LsWAVzm4bYjNEd5tEYyDcDQzObW6k9ijQwZmmv4C/Nv8
 70qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987271; x=1794592071;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hTGWsHlabfsW4CJoAyvMNjyxrLVOZhaTpVVhLMe7jIk=;
 b=GyggIFmJyTDSjEYZf91shas8MHfwCgDaRPUrWlA9+7Lqk/3Se/e+5yDadE+LjQ3a36
 f9RxdDbJrGD1CGQKCwBtOPNY6UTIa8/T6bQ5WGs4w8YfiXG5H8QHsMLijLrktoaeEusa
 vaeSBmf1tK06z29CZcDvVwAgam6GlSPqsLwf9hB1+ofAobini4W/CxEfUr0lIeXbIcml
 eTVKJORDu/8jk8ZIof5yPFo49ePa5UUpUxlsTswYYCxbYQUzMdeRgcBrhWftRmj8/b8z
 UKllRngPCxCBUdsunjnq0H+jWUvl9syxNz4Y1rTXE9uF3RyUpLIN7/IeW4aqFhobVz99
 aUPA==
X-Gm-Message-State: APuU4Z+9iGQBmfaitNk9w/ffZlPhjwoBWQG3MYneOW9T8f1hqty6aNw0
 sHPkw9PvSuvCrMrA0U333A1fSiMsfB7jfB3oyWDfr/fGRrT8ff6elZ6m9Bm5MxqF9oGpUjnbUSh
 baWU6XWV88iBLWhynfRtktxEeCslMD1pNdS3QPySh6gJxMI9gTHtzakdZzQ==
X-Gm-Gg: AYBFou0xhCyw/0HHN0oA1Ojp9LRLx7ptRsI6sUw+cUeAYffYh+4+HbYWxDdazgIe5ji
 hkSHVrLGVkKLYa9hpVIrgVKECsCyo8RnvpEwG7vEdR4OtVSEAstkqK8QrcztTU6S6/lMNZsWK53
 YyWk7bYA4w++r+9oPMwFp3rZvm1BhVIZP2QGmw72T8GzCCPG4RgmKS2ie35jJQARwe7+DbgVYL9
 7FmdIgeWNN7V8kSGJDZ0UmxWRcRE5id+hP9XJ0HpPvppd3OLhqsoZ8TotCmjvhhUlysO0ftMaXg
 dDdcZ/W1UiLkGXGoIbOS3bwTOSQxrvpu3yS6QF3FoP1eMpW6PIbP6RYzeCybPjJEJhXEt4OfmWE
 p0P10CCksisIIbIo7CFA9H3KOdZ4GFdQuWwy2PkV7KGD/az19JXHWVr4y9W4ttjBmQsBrEMFQQM
 WcGgKjtlEE8MinQOpw/hocWNx9nlaVJ8lFVDBFjskm9A==
X-Received: by 2002:a05:7300:f14c:b0:36c:49a7:86ac with SMTP id
 5a478bee46e88-36f783c0d66mr3688125eec.37.1793987271359; 
 Fri, 06 Nov 2026 09:47:51 -0800 (PST)
X-Received: by 2002:a05:7300:f14c:b0:36c:49a7:86ac with SMTP id
 5a478bee46e88-36f783c0d66mr3688097eec.37.1793987270727; 
 Fri, 06 Nov 2026 09:47:50 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa651c57asm8483817eec.2.2026.11.06.09.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 09:47:50 -0800 (PST)
Message-ID: <93d749b2-aa50-4cdf-9343-7d7a11bc6a8c@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:47:47 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target-info: add target_mask_selected()
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
 <20261105190346.1539-3-luoyonggang@gmail.com>
 <f84768d9-1aa4-463d-a0f5-4844a4babe22@oss.qualcomm.com>
 <CAE2XoE_u9AhjKZxtocf-e=8SjgiJ5gURxJVmwoXHTu6uKWK9+g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_u9AhjKZxtocf-e=8SjgiJ5gURxJVmwoXHTu6uKWK9+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MRl64KY1Mp1tslL-VNRddlxd3llV5kem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX95FBDJbpFFk8
 /K9TyLqpZ2MuswHj7B7OGB4yxyf5wXh3NpvsfDRwLWYrWrNJgZ3G054SY3hFLVyelDHi0TZBz7b
 uWvL/5ZMhQ6Zsx1lH2SNwI4b3azOTBVmUHW0oEuh/1mxDa5lUXZRNKDmjtmzfvkft2tV1JXPcU8
 KJrU6ha5AYiAx5MFOlF1L4S7eto33dpsW0SPxlhKj/6ikCXSeeyz8d2Mvom4SUdr7y7avNRfVMH
 6LtOHqbNJl+06QB8UNmb/PIiruVwazyZI5cAfzgqENm21Jso6ni5Nq8tbiK+YpF2ZKIw8dxnhH3
 NJXFBDtfRiPfH0vjAHAEtPcCVTMLTwlTWqCu+et8eqtTICE1xiWGqk5ZbEQ8n9l51VlOLGSNTIZ
 AOLgvNTVZE4+/oXDN/j8MP2J+wqgjepWF1KdSANri5eGfBV5BAKJnPu5gYbrgIeGwchSKmcarzb
 43ReQ7xxf6CgwTk8U9g==
X-Authority-Analysis: v=2.4 cv=a6OlZkSF c=1 sm=1 tr=0 ts=6aee12c8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=X0wvDPPaXnzoaKlo8kAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfXxfn6oql4uRGA
 Umz0bCAC/HXQGYtEvC9gKkWY2aUuAJIHnNabaf8zNV1o9LvF/ffTNSbyYjg5RNor1jIHs17Uz/o
 H7Xms0YPAHncvACflxlOa3ThYbcnIc4=
X-Proofpoint-GUID: MRl64KY1Mp1tslL-VNRddlxd3llV5kem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060070
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 9:46 AM, Yonggang Luo wrote:
> On Sat, Nov 7, 2026 at 1:44 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 11/5/2026 11:03 AM, Yonggang Luo wrote:
>>> Return the QEMU_ARCH_* mask of the selected target. System mode
>>> returns QEMU_ARCH_ALL until a target is selected. User mode returns
>>> that target's bit. Tools return 0.
>>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>>  include/qemu/target-info-init.h | 15 ++++++++++-----
>>>  include/qemu/target-info.h      |  9 +++++++++
>>>  stubs/meson.build               |  1 +
>>>  stubs/target-mask-selected.c    | 13 +++++++++++++
>>>  target-info-def.c               |  3 +++
>>>  target-info-qom.c               | 10 ++++++++++
>>>  6 files changed, 46 insertions(+), 5 deletions(-)
>>>  create mode 100644 stubs/target-mask-selected.c
>>>
>>> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
>>> index b7024c9fae..8492986832 100644
>>> --- a/include/qemu/target-info-init.h
>>> +++ b/include/qemu/target-info-init.h
>>> @@ -24,12 +24,17 @@ module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
>>>
>>>  /*
>>>   * User mode does not support multiple targets in the same binary, so just
>>> - * define target_info().
>>> + * define target_info() and target_mask_selected(). The target is always
>>> + * selected.
>>>   */
>>> -#define target_info_init(ti_var)        \
>>> -const TargetInfo *target_info(void)     \
>>> -{                                       \
>>> -    return &ti_var;                     \
>>> +#define target_info_init(ti_var)                           \
>>> +const TargetInfo *target_info(void)                        \
>>> +{                                                          \
>>> +    return &ti_var;                                        \
>>> +}                                                          \
>>> +uint64_t target_mask_selected(void)                        \
>>> +{                                                          \
>>> +    return QEMU_ARCH_BIT((ti_var).target_arch);            \
>>>  }
>>>
>>>  #else /* CONFIG_USER_ONLY */
>>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>>> index 2cd4cc5671..5673d10eba 100644
>>> --- a/include/qemu/target-info.h
>>> +++ b/include/qemu/target-info.h
>>> @@ -134,4 +134,13 @@ bool target_base_riscv(void);
>>>   */
>>>  bool target_riscv64(void);
>>>
>>> +/**
>>> + * target_mask_selected:
>>> + *
>>> + * Returns the QEMU_ARCH_* mask of the selected target. System mode
>>> + * returns QEMU_ARCH_ALL until a target is selected. User mode returns
>>> + * that target's bit. Tools return 0.
>>> + */
>>> +uint64_t target_mask_selected(void);
>>> +
>>>  #endif
>>> diff --git a/stubs/meson.build b/stubs/meson.build
>>> index 744fb759a2..49cede8582 100644
>>> --- a/stubs/meson.build
>>> +++ b/stubs/meson.build
>>> @@ -12,6 +12,7 @@ stub_ss.add(files('monitor-hmp.c'))
>>>  stub_ss.add(files('qapi-event-emit.c'))
>>>  stub_ss.add(files('replay-mode.c'))
>>>  stub_ss.add(files('trace-control.c'))
>>> +stub_ss.add(files('target-mask-selected.c'))
>>>
>>
>> For which configs is the stub required?
>> target-info-def will always be present.
> 
> For tools
>

Can you post the exact link error that exposes the absence of this symbol?

>>
>>>  if have_block
>>>    stub_ss.add(files('bdrv-next-monitor-owned.c'))
>>> diff --git a/stubs/target-mask-selected.c b/stubs/target-mask-selected.c
>>> new file mode 100644
>>> index 0000000000..510a515851
>>> --- /dev/null
>>> +++ b/stubs/target-mask-selected.c
>>> @@ -0,0 +1,13 @@
>>> +/*
>>> + * Tools have no selected target.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/target-info.h"
>>> +
>>> +uint64_t target_mask_selected(void)
>>> +{
>>> +    return 0;
>>> +}
>>> diff --git a/target-info-def.c b/target-info-def.c
>>> index bcf9cfe1e4..a992019626 100644
>>> --- a/target-info-def.c
>>> +++ b/target-info-def.c
>>> @@ -9,6 +9,9 @@
>>>  #include "qemu/osdep.h"
>>>  #include "qemu/target-info.h"
>>>  #include "qemu/target-info-def.h"
>>> +#ifdef CONFIG_USER_ONLY
>>> +#include "qemu/base-arch-defs.h"
>>> +#endif
>>>  #include "qemu/target-info-init.h"
>>>  #include "hw/core/boards.h"
>>>  #include "cpu.h"
>>> diff --git a/target-info-qom.c b/target-info-qom.c
>>> index aeeedb7e81..fb4c9835e5 100644
>>> --- a/target-info-qom.c
>>> +++ b/target-info-qom.c
>>> @@ -9,6 +9,8 @@
>>>  #include "qemu/osdep.h"
>>>  #include "qapi/error.h"
>>>  #include "qom/object.h"
>>> +#include "qemu/base-arch-defs.h"
>>> +#include "qemu/target-info.h"
>>>  #include "qemu/target-info-def.h"
>>>  #include "qemu/target-info-init.h"
>>>  #include "qemu/target-info-qom.h"
>>> @@ -40,6 +42,14 @@ const TargetInfo *target_info(void)
>>>      return target_info_ptr;
>>>  }
>>>
>>> +uint64_t target_mask_selected(void)
>>> +{
>>> +    if (!target_info_ptr) {
>>> +        return QEMU_ARCH_ALL;
>>> +    }
>>> +    return QEMU_ARCH_BIT(target_info_ptr->target_arch);
>>> +}
>>> +
>>>  void target_info_qom_set_target(void)
>>>  {
>>>      g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
>>
> 
> 


