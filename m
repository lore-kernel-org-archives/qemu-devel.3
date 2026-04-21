Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808BBF94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJH4-0001BA-Mv; Tue, 21 Apr 2026 18:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFJH3-0001Av-Dd
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:08:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFJH1-0004Hi-BS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:08:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZuTl4051197
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 22:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i6pvVZX/sGIhrzSt/U+m8p0ircz8MQIDoBp+bfwV9mQ=; b=dNrFD2GsBDoI6+lE
 GEA+is9mLxU5TjgO/LlRNK/qZ36/DYf0hNW69kjEHf6bc5Af8AWmpmeO5XcqiMZw
 THy8N1HdTKyX/g/Tzq9OHGCb11LhHRiPlLdoLDnsA13MnKp1NKRdIy1J7umOhiwF
 oKhNOvyo0TUXSSmYYIGAm7VIUmE/Idy2bOyZYKdl9u5WCYB+Khm+y+LwKQjNRvzR
 g4Ws4AZejz9pS87Of+a+XBWP8KjTYryU2+15c92pUo6D16754hSZtAD9qpPvWBFv
 HncpcKzGP2KKFKdv3NqNGeceme3F3cXeaheSPv5A7JwFntrUQTJcMcGVOoFP8sKR
 VES18Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfgkp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 22:08:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so4926265eec.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776809327; x=1777414127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i6pvVZX/sGIhrzSt/U+m8p0ircz8MQIDoBp+bfwV9mQ=;
 b=Z3LutF/oA9vhXtPlreaU09vsXPth21rrxZ89qRWBvRBadUUQEhdcA51jcIncYa1tbN
 C5X/U6o+ZvArcBghpGjaRW+i43au9CcDqJM3tdtjPHZ1RXuywKKNtCd1ArRDrd8XlJmI
 6qUaK4dpI7t20e757curpwGGqwc4ZU7wvmKIDwoU/gj6igo+apNmcdwtZxASe7c+0qNs
 kikFniB9tV7O5CwOFyh2gmb5mxGMra/I6Kv3FTeGIxLt0afQ8uqxIINqpmpOBQmIGIKJ
 wWF7sS4mR1HFwXLQi52TYXmqeM9flQQ6SYQ8trbfcLVyrqTcRi4tb/odm2ZfnxjIE4vr
 FWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776809327; x=1777414127;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6pvVZX/sGIhrzSt/U+m8p0ircz8MQIDoBp+bfwV9mQ=;
 b=eJcfK+qIQXT5mb3tpkT525EJVVL7bQ7CMs8RjsGQkbRQYvy9ojpdjxgs6kxcLTqxoF
 c/kUbejQg2ojBuGAGLjA0ebL7rm7KgajsKrJIZEGRZWP1iZBhgrmR/4IAyZV1S/d/TiO
 4Q/laZG2yF+edta1loGOevDRsF49BunQrWSifJyJDNekAYmtHE1Zffn934gOf1oSpEtp
 nvsZRXAKyku0DO8YdWac2alR816eq5tYxTSfrPfudpJpE2G4SI3B9U0xSMheeWjzip1n
 LzNMpr8fV2DquHifZYXW/M4Sy3IvJQ73S3Go0Qcz0fVbud7CyN4A6IL7sZmpLc6/iWxm
 gRxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9n7ubdrlNhyWo4FP/gxKCW4f3hEwB3SyxqUzKU6movWi0uUEZ+3okthDr7/a5j3CzPu2S0Z2VahjYy@nongnu.org
X-Gm-Message-State: AOJu0YySA98C8Cwpv4OTg7WjJ7fg8R9WL3YcuNz4KsJKkbnbL3DuyCQ4
 yW6BjIDY+3K5wxCgb5NivFlGm0CH56F8EIF2vYDIJHXrIp9dy3Bkd1LRUBhxdwFWYn47fluC6nk
 xynizNKdHhPT6yxVLZITycU/rYvZIRavDSHZF6/5QZdMndLyCmeh4fGrXiQ==
X-Gm-Gg: AeBDieslmJoAnCNWPt+ONg2UYdWbDgZAUDlBury/h/PllHWCSSlvyGqqLaoyX9PYCws
 bXoBEeW6wA0pnHP04yiczlu+qgEEgScxE95A+Omsrk4zBnSLH89zelUTj67cn9VK5Ep+oFbviI8
 KsF1V4Hr9mOi5IwDptRd57kvj1aQsraY/vcYOD9g2Xaxa7VSOYnFK5bW0NlLB09jT3Ub3lSsGDd
 O2ihrjk9dKC0xxwi7TgVuEclK2oxS9pRHcPNOPOAfmVqcGffrULN1PQ/pt6wt05JWxcjrJCIPgc
 rWpKZOafbSMU/ZIkkMdZH2+LIV2KDaWCPtC0b87/U0K8dgZ0PmyTjupN6uQa/TmbKkfFL1T1GTE
 PQxU2RAa/SWO2Y60/E1Yxnh23LdhGolLDUVCV6eFR4S1F3k6JyURj4P+86qil3xhD6AseYArH6F
 y6GXfIRWnNNAZbte8loLY4Uai5
X-Received: by 2002:a05:7300:3723:b0:2d9:db50:c6d6 with SMTP id
 5a478bee46e88-2e478a331b3mr10966719eec.21.1776809326909; 
 Tue, 21 Apr 2026 15:08:46 -0700 (PDT)
X-Received: by 2002:a05:7300:3723:b0:2d9:db50:c6d6 with SMTP id
 5a478bee46e88-2e478a331b3mr10966695eec.21.1776809326297; 
 Tue, 21 Apr 2026 15:08:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa5c38sm20190128eec.5.2026.04.21.15.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:08:45 -0700 (PDT)
Message-ID: <beefeef5-96ba-4645-a01a-7ca96055d93a@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 15:08:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] target/hexagon: add build config for softmmu
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
 <c2c0386f-7141-4845-9d95-adb3927d5054@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c2c0386f-7141-4845-9d95-adb3927d5054@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIyMCBTYWx0ZWRfX3pwgS/XZGlyB
 BG95CrevMa7BQgg/CoaIyPUGedI7MC+wStIzsBUZR7bRw1+0jdzePpLx2uLo3JCAfddke1dFBdJ
 +Ds/XJyrQlvdNwskmJ4nI5mgMP/O/DoJ1SOvyC/5tOrW5Ooz6tDkYEoXDfKWog1j241WbE9yP9q
 VXZOeVTykYHyqJdjoocBExC8LolCVR5ZsvSnS3lmLsRIKMSLx/0g8btfCTs/jpQHrmE/LaeOl/0
 PNh+OnyN7Ze6gA1Bo/AWo59DEKqBR4ug9FJdt/HwYUXMlkRZa+J50ls5BHwxPfGeVGleLNkVTTk
 JmdG6yHi9qMcy9V6dpyqVRiMj+UjeMsQwlPWMYL6py+A4qMLAyXvY62tYfYgmdMuwDcea4U8ooq
 yPqrUzPs/WUChmpqXGxZdosVZy9CVcjLh0YlwnSnIq9B8AW8mCktni6jGjY15fozf430iiVi0Fo
 v9HI2k6/w7KSkBLXduQ==
X-Authority-Analysis: v=2.4 cv=VMrtWdPX c=1 sm=1 tr=0 ts=69e7f56f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=CEatR1mcu4qtnOVYD9cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 2mJ-LG3fKaEC4eKDtOBO43FmNMnbayvF
X-Proofpoint-ORIG-GUID: 2mJ-LG3fKaEC4eKDtOBO43FmNMnbayvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604210220
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

On 4/21/2026 3:02 PM, Philippe Mathieu-Daudé wrote:
> On 16/4/26 23:03, Brian Cain wrote:
>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                                 |  1 +
>>   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>>   configs/targets/hexagon-softmmu.mak         |  7 +++++++
>>   target/hexagon/cpu.h                        |  7 +------
>>   target/hexagon/cpu.c                        |  3 +--
>>   target/Kconfig                              |  1 +
>>   target/hexagon/Kconfig                      |  2 ++
>>   target/hexagon/meson.build                  | 13 ++++++++++++-
>>   8 files changed, 32 insertions(+), 9 deletions(-)
>>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>>   create mode 100644 configs/targets/hexagon-softmmu.mak
>>   create mode 100644 target/hexagon/Kconfig
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b9a7c553dfa..ed661c9f12e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -254,6 +254,7 @@ F: linux-user/hexagon/
>>   F: tests/tcg/hexagon/
>>   F: disas/hexagon.c
>>   F: configs/targets/hexagon-linux-user/default.mak
>> +F: configs/devices/hexagon-softmmu/default.mak
>>   F: docker/dockerfiles/debian-hexagon-cross.docker
>>   F: gdbstub/gdb-xml/hexagon*.xml
>>   F: docs/system/target-hexagon.rst
> 
> You really want to have multiple sections here. Easier to
> discriminate who is responsable for what.
> 
> Suggestion:
> 
> - Hexagon TCG CPUs
>    (and implicit linux-user)
> - Hexagon Machines
>    (and implicit softmmu hardware)
> 
> 
>> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/ 
>> hexagon-softmmu.mak
>> new file mode 100644
>> index 00000000000..fdfa29b4f39
>> --- /dev/null
>> +++ b/configs/targets/hexagon-softmmu.mak
>> @@ -0,0 +1,7 @@
>> +# Default configuration for hexagon-softmmu
>> +
>> +TARGET_ARCH=hexagon
>> +TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml
>> +TARGET_LONG_BITS=32
>> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> 
> \o/
> 
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>> index 09d5cac4fe5..18dcfdb0b0a 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -37,12 +37,7 @@ typedef struct HexagonGlobalRegState 
>> HexagonGlobalRegState;
>>   #include "mmvec/mmvec.h"
>>   #include "hw/core/registerfields.h"
>> -#ifndef CONFIG_USER_ONLY
>> -#error "Hexagon does not support system emulation"
>> -#endif
>> -
>> -#ifndef CONFIG_USER_ONLY
>> -#endif
>> +#include "reg_fields.h"
> 
> Please use full "target/hexagon/reg_fields.h" path.
> 
>>   #define NUM_PREGS 4
>>   #define TOTAL_PER_THREAD_REGS 64
> 
> 
>> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
>> index 528beca3cd0..bc7a292e47b 100644
>> --- a/target/hexagon/meson.build
>> +++ b/target/hexagon/meson.build
> 
>> +hexagon_softmmu_ss.add(files(
>> +    'cpu_helper.c',
>> +    'hex_mmu.c',
>> +    'hex_interrupts.c',
>> +    'hexswi.c',
>> +    'machine.c',
>> +))
>> +
>>   #
>>   # Step 4.5
>>   # We use flex/bison based idef-parser to generate TCG code for a lot
>> @@ -262,7 +271,8 @@ hexagon_ss.add(files(
>>   #     idef-generated-enabled-instructions
>>   #
>>   idef_parser_enabled = get_option('hexagon_idef_parser')
>> -if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
>> +if idef_parser_enabled and ('hexagon-linux-user' in target_dirs or
>> +                            'hexagon-softmmu' in target_dirs)
>>       idef_parser_input_generated = custom_target(
>>           'idef_parser_input.h.inc',
>>           output: 'idef_parser_input.h.inc',
>> @@ -390,3 +400,4 @@ analyze_funcs_generated = custom_target(
>>   hexagon_ss.add(analyze_funcs_generated)
>>   target_arch += {'hexagon': hexagon_ss}
>> +target_system_arch += {'hexagon': hexagon_softmmu_ss}
> 
> Pierrick: is target_common_system_arch[] still relevant for a target
> which use fixed endianness / wordsize?
> 

It guarantees code doesn't use any target specific identifier, like 
accelerators related for instance. Common really means "Does not depend 
on any build generated target header".

Of course, if target comes in only one variant, it does not really 
matter, since files will be compiled once anyway. But I think it's more 
future proof to consider further variations could be added.
As well, it forces from the start to do things without relying on 
compile time defines, which IMHO, is a big win.

Regards,
Pierrick

