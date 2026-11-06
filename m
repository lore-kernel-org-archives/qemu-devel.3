Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34237606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eR8hai1v;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NY0YPb95
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPHq-0002dZ-5X; Fri, 06 Nov 2026 14:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPHm-0002Zs-Dj
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:07:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPHk-0007kD-93
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:07:37 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Ht4Ho433229
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 19:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EbIODbFmDRmQPmE8jVWiaRQNcZ+cOfHVokHU5VJ2ZZ8=; b=eR8hai1vC0ro5ABX
 5YT7DBplNzUSZuYzheZZj/o1bKobGa7hhGwmB1Wp5S0RqF3EH95w1srJGF5Sr7KV
 sw9+OT2sSSmyaulJzWm7WdGHXoKazWRwYBG6embTcORiVXAQrG6yHVWW1kNH7nOR
 GAzgJCzbh+zfxOn2nlj9av3K7Jgw6kyMoYKqFQobnIV9Zy/ZzFsqHLzEhVLz3+yK
 Zf+CMFe6nD49jI0X8SCICvQvVvQUP4k+7j+UHs0qKjFjaUuK2JZnH74h9jzg3sSQ
 WfuCqeUP9Gz3Vw4I6QuuVCVfLaLY8I8za2YlXjCYNGetnL8btiCLXZPbwcOBD75p
 B6k7IA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa48rt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 19:07:32 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b25d977b91so1503008c88.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793992051; x=1794596851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EbIODbFmDRmQPmE8jVWiaRQNcZ+cOfHVokHU5VJ2ZZ8=;
 b=NY0YPb95vBZIcqNAqMKqRkJ3LExLd2jozDuRJwrSbiR3eTDhf3HtKxEWXXJ2dUL+hS
 bbT4u69WRvONSHvUsFax71oBxe3EH4zkvNyWxfOiin+dX7XQP0xz31ipgmuCT5JSesZf
 wVaWLvXBLtD/aWHic2x/CtTe7IyO0avPaTrER07FeOw9QtoJucr3WiV/gHp9450g15/v
 yBfZmllOy9rDTH87SIdJBftwuz/j81bOuVJqWeeh75asPd30pkaj/DUI0/+FR0vVnYuW
 x4MRbNSeSdDuFJnheBDcYbJal+phXqQhWkZ4IjQoT0jC4TN/wD4gyYagM6zdxhCG7XLC
 9kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793992051; x=1794596851;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EbIODbFmDRmQPmE8jVWiaRQNcZ+cOfHVokHU5VJ2ZZ8=;
 b=z2l6dXagFavh7a4U2836jRl2SBtw3vWobzKgzwBLUMjG3MC7xFnMxhoEOHndjR5pDn
 osYJ6E94OtUXkarEATSvoAIGLtTfm3YQEeHpC+pUUS+heEqzPYkWAJ0FQbVPXCMRe/CS
 uw/gvktmKZPvstw15zYDmiX7vhFEotJMJbs2yVLPwrKJ0H8p8oUv7aQC0n/9N4QehU74
 YdLvdMH7NFoG3JQvXbxh3giciJtiO9rn3NfHY4YzBgPGvzh4AtGBmNt3dPuZjyj2OTiv
 19BKD5g8X2i/p0Hux04XeyvI+GJ8IDoXFl0mx91GgzaH7trbaRkvQUCwR9hOGdKt5+EU
 m8Ww==
X-Gm-Message-State: APuU4Z80d0/PjKQJSCcCtKy3N2ifo0Mrf3CuXw6CbIDfpcoOfpw2uHG4
 0WT9O7ZricXOtVip0MbHnqz7QQusWr3uF214o9hRtK5ejs4s2IZiGlZOUANncqm5p5OjE6cONLf
 XB5dQNtF6lMVKE9nusNfH+UVWt8OnwxzmD8iyZe3vvCRgjJAQLWMCV9rQWQ==
X-Gm-Gg: AYBFou28xJD/zPmbLGhwgyAIkrxCZMeyBoum9DbiaGG9j7JwKY592C5/lb7eosJnhjR
 4JsQOr0AfaVy46C78gOwD0iFs2LoH8IKmGfbKiun0o9pboCH2wGiMNrMPA7keobOwFltUjtiOuV
 p+X2MBI2YXaBI5UIvV4tw82wCXRLLt7nH9v7bgSr2eEr0Npcx4bSZMSgM3YDrKFJR7geVZTvgo/
 LPLJPwqe/OQYY7pH2sKnVc4KQwDNnmtJy3/wP21AkQcmAGZ1rwyxujH9XI3ogVWWEXs6z/KiF1f
 AGCCz+JfXBMKl+ekzqAHErH9VrMVdaS01xqmCvq2X+VK132qVXeGRo21rF82G1mcX2N76m/wg2T
 40ve1Ri9XcLQleXgI+iMIz1Rkg1l3oJXhMFIiSFr9vkq4VyEq8CYtDlkqurUF5JVpitg0jWTB+j
 WdtC7T4n98EHEPXyDPSV8JtFJDD3eOGWEHgnDp4Dqq0A==
X-Received: by 2002:a05:701b:4292:20b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-1b25d37e36dmr4127215c88.31.1793992051275; 
 Fri, 06 Nov 2026 11:07:31 -0800 (PST)
X-Received: by 2002:a05:701b:4292:20b0:15a:4155:3d9d with SMTP id
 a92af1059eb24-1b25d37e36dmr4127179c88.31.1793992050681; 
 Fri, 06 Nov 2026 11:07:30 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e407cd1sm8195226c88.3.2026.11.06.11.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 11:07:30 -0800 (PST)
Message-ID: <5588b618-05aa-492d-a9dd-c32591a6f6cb@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 11:07:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] multi-target: restrict whpx-accel-*-cpu to matching
 target
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8_Cg5Arv8SnA2yXP_5RAENhw2N-iysUP2Tc1E170VxNg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8_Cg5Arv8SnA2yXP_5RAENhw2N-iysUP2Tc1E170VxNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aee2574 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Eq031dNoe_Qzr32X_uAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NiBTYWx0ZWRfX1c6K7AW0UA81
 GX3y09FmDLvw2Apg1eBof3RTPKoUbCfmUiIU94bLllrH+YFyZ148+XASTK9CxtdduHw+SubGgQu
 B62IhIZ3OQt94nHcJlE65eWnXbeWeSI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NiBTYWx0ZWRfXyuVZ+FoyONaN
 whllpXs/heZOcJKWHUCYng3a9EPQEitSO/BrjP+5beeJbLIcBE5yVESZkpgj8wqpfasen1mlnKZ
 zdt/A6LwqHg2mKpV6ZMDyjIgLbOaikjwc7fWGx1JZlEHjsCDFxNxg/AA9RL2CnycWkFQ7fstGjP
 9eT9JCLxk3OsGKmMHvPb7aJk73tb4RObpFb79cyj0DznolO8tTgejixGkVfgues2SjpaiECdnoF
 nHCpLYuEtEDR5tFQ8iWDYLGDFnJDoBh7xpnOZHtQCp+QZrODO2z9ynVUxT5S3cQPXquonpfRmIF
 Xemx/G8bNo7LBLZcu3OYJhO1Ua54SbA25+9wmvw6vKSyKxcCJr4wp2EY+VUqeaKzI6jdsoNe7cy
 LbsNYTna/IVeIEI8fym0hPLw/xMiKWB9jyJYv49Iw+d8uZZ4jPatKdduVYsZr8scpXaWqLwMoDm
 spCOkbTpy2GWqGvSrmA==
X-Proofpoint-GUID: bgvYyh4YtAcIdD5nEjl39OKjUyw2YoHn
X-Proofpoint-ORIG-GUID: bgvYyh4YtAcIdD5nEjl39OKjUyw2YoHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060076
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 11:04 AM, Yonggang Luo wrote:
> On Sat, Nov 7, 2026 at 1:54 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On windows x64 host:
>> $ ./build/tests/unit/test-multi-target
>> Type 'whpx-accel-x86_64-cpu' is missing its parent 'accel-x86_64-cpu'
>> (same for windows-arm64 hosts and whpx-accel-aarch64-cpu)
>>
>> Parent type is conditionally registered from current target:
>> register_accel_target_type uses '"accel-" + target_cpu_type()' as type
>> name. Since whpx-common.c is shared between arm and x86_64 targets,
>> only register whpx accelerator cpu type when current target cpu type
>> matches the one it was compiled for.
>>
>> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  accel/whpx/whpx-common.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
>> index 78d2827809b..20c684638b0 100644
>> --- a/accel/whpx/whpx-common.c
>> +++ b/accel/whpx/whpx-common.c
>> @@ -20,6 +20,7 @@
>>  #include "hw/core/boards.h"
>>  #include "hw/intc/ioapic.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/target-info.h"
>>  #include "qapi/error.h"
>>  #include "qapi/qapi-types-common.h"
>>  #include "qapi/qapi-type-infos-common.h"
>> @@ -492,11 +493,18 @@ static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>      acc->cpu_instance_init = whpx_cpu_instance_init;
>>  }
>>
>> +/* TYPE_ACCEL_CPU is only registered for current target cpu type */
>> +static bool whpx_cpu_accel_is_available(void)
>> +{
>> +    return !strcmp(target_cpu_type(), CPU_RESOLVING_TYPE);
>> +}
>> +
>>  static const TypeInfo whpx_cpu_accel_type = {
>>      .name = ACCEL_CPU_NAME("whpx"),
>>
>>      .parent = TYPE_ACCEL_CPU,
>>      .class_init = whpx_cpu_accel_class_init,
>> +    .is_available = whpx_cpu_accel_is_available,
>>      .abstract = true,
>>  };
>>
>> --
>> 2.43.0
>>
>>
> 
> Hi, I think
> 
> [PATCH v5 0/3] Register accel-$cpu_type for all targets
> https://lore.kernel.org/qemu-devel/20261106023936.772-1-luoyonggang@gmail.com/
> 
> should also handled this. so this is_available do not need anymore.
> 

I would prefer to send the accel series later, giving time for
additional reviews, if anyone has an objection.

the whpx fix is needed now as the test fails on windows at the moment.
the patch can be removed after, no problem.

Regards,
Pierrick

