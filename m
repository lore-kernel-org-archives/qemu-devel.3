Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57922C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 23:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsVDP-0001UT-Hn; Wed, 12 Mar 2025 19:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tsVDM-0001UD-T5
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 19:10:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tsVDK-0007Ch-BX
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 19:10:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CMvLJ5031304
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r/kLE1wKiEQl67dFs+bsQhHuXeOHb3l8qJDxoPGEZHc=; b=mqowgxd071HzhMKl
 c3zKivZCaPMJiAgdFXMGVPTdrbuP0TEiM4RE+BQBxl7hJxeZ07k2s92SMmrl4XuX
 hpcM8e9YucnOUvA3nQwaTlnnTMnF5jyN6VPcJ0PZv2R8ZvmgANCP/Pi/LSZ6YJm+
 1eR1Z/Ol7zFjIBCdZcNGUTfy+J6wxGGV6VgIGEPpLj/wb7BTUtmsaSsy8/ziyLTo
 S9yb5euhGDqlVmfksXfU38vNQpKFMPCNWgkb1iLN97jCM9z/cnbsfu6HfT20Htxc
 lJlBxxdgjXBBv1PBG5MhBR2PPeLxFjOmJv4U6/2/BEtopx+GAxWwmuH9RKHdgCJ4
 BrYhQA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2qkwga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:10:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-47685de2945so6223241cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 16:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821010; x=1742425810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/kLE1wKiEQl67dFs+bsQhHuXeOHb3l8qJDxoPGEZHc=;
 b=WEzMcBAJ/YVWyJuA3KzowMt5UuBddtscmn8Jp+ZvwNiq87ofVvoLraVRzCEfcsUUAj
 ugLN+b/BeinUrrCZjOL5/Ohu4Jw/xB7n4yUAuuzXYXQCg9NByRX+W8ZDTUZDmlD9sn8t
 v9Ee2igV0KeC4hwmWMmdQVeghryiv0+CWR0jU1aBLl12ubY0+oz2L4455R5hvIYY66SV
 jAY9bTqnZMmR3FvAspm4igKYtxdHxam8HO0jHyO7n3Gh0RXI07uMUjCtbNhE3SCF6Nl+
 /b6NDauHFpPKl0w97B4FhceYw+fh9qhVsuvFyirFMbtq3FB86EL32wmUk6ULXoWQDSm7
 vYCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUupexnSDcIDxx9qX7jP5FJntqYR+NdfoZCh2Vb8hDGCShvEwllElFsWafccHNElTLnnX48eDvSIwzV@nongnu.org
X-Gm-Message-State: AOJu0YyJXYAY9LyPP0rQuV5QXsLDZp6HvpKOvW/oM6DjWKRPD05NS5T/
 uT9dDxkt0N2jQ9XwWev3VIWsb1KtOQPiMpmLLeeVi2b+4b51X63zsJqPcNo5yZV0IMfEHvA9t/Y
 nv7nQKbucU//8JBddwAxnHGS/GQYWfxv+lrkSGvF/mCTSHj56YMsn2A==
X-Gm-Gg: ASbGncsUt7ZtOkusMHUgTBwBLF/G8juGGxZkeH/mt9E3u6m3Vveb4jk1MiwmS7wihQi
 16PVb2V0wk5jvJhf6789YXPxx63Q72IxQCp7uQdBE/nGonIKrYpMFNlAWUSpXkl2ZYCrn+x27Ts
 bwhYJAeIHfus0Su4QxL8JJri3Y7UJjMhbzFK5/VbV0XDMuDtmF+qUOgDpRwZBVDjdZ8Ui0o693P
 hD+yfhZc9RsioSFSp/EeXGDghBi7ybDeXe3aGxslMmHqywVdMo5/36P4EEyrI4odCpZyYdZtBz+
 tUX0E8DeFgXPm70sL9/K/ll2AN5JPJ9XXzb8U7du1A==
X-Received: by 2002:a05:622a:438b:b0:476:b022:457e with SMTP id
 d75a77b69052e-476b0224a6cmr43487731cf.34.1741821010303; 
 Wed, 12 Mar 2025 16:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqj4yzLR6sbFvTeHIh/A2FACic37CsURcIcKwf6x+vsi1CObpkr+Ck6a/956SW30cPJj4bOA==
X-Received: by 2002:a05:622a:438b:b0:476:b022:457e with SMTP id
 d75a77b69052e-476b0224a6cmr43487501cf.34.1741821009915; 
 Wed, 12 Mar 2025 16:10:09 -0700 (PDT)
Received: from [192.168.1.217] ([216.158.243.21])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c73csm921121cf.79.2025.03.12.16.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 16:10:09 -0700 (PDT)
Message-ID: <b84bcd2d-9974-41f0-b9f5-2d416ed16d0d@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 18:10:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
 <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wGC4-JC2HNE2gHJxhiv48W5gG4v9HGQq
X-Proofpoint-GUID: wGC4-JC2HNE2gHJxhiv48W5gG4v9HGQq
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=67d21453 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=jCaHSKOc8xwm4VrxeLAdIg==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=xl6c0gYthU-HYvlUbuwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/12/2025 2:19 PM, Philippe Mathieu-Daudé wrote:
> On 1/3/25 06:26, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 36a93cc22f..2b6a707fca 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -26,6 +26,7 @@
>>   #include "fpu/softfloat-helpers.h"
>>   #include "tcg/tcg.h"
>>   #include "exec/gdbstub.h"
>> +#include "cpu_helper.h"
>>     static void hexagon_v66_cpu_init(Object *obj) { }
>>   static void hexagon_v67_cpu_init(Object *obj) { }
>> @@ -290,11 +291,18 @@ static void hexagon_cpu_reset_hold(Object *obj, 
>> ResetType type)
>>       set_float_default_nan_pattern(0b11111111, &env->fp_status);
>>     #ifndef CONFIG_USER_ONLY
>> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
>> +
>>       if (cs->cpu_index == 0) {
>
> This doesn't scale to heterogeneous emulation.
>

If we have a target-specific index here (instead of cpu_index) guarding 
the "g_sreg" allocation shared by these Hexagon vCPUs, does that 
suffice?  Or is the problem the shared allocation itself?


Could a heterogeneous emulation configuration consist of multiple 
instances of (same-architecture) vCPU-groups?


>>           memset(env->g_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>>       }
>>       memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>>       memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
>> +
>> +    if (cs->cpu_index == 0) {
>
> Ditto.
>
>> +        arch_set_system_reg(env, HEX_SREG_MODECTL, 0x1);
>> +    }
>> +    arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index);
>>   #endif
>>   }
>

