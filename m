Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92592CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCSf-0007Uq-DY; Mon, 15 Jun 2026 14:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZCSN-0007RG-Ma
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:54:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZCSG-0006OZ-8F
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:54:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhm0m992238
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 18:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tMIfthXbLXmK+CNBDrrY39/4cOuOMn+2LYRpx9at/4s=; b=RRg4t9Wi7/B3KHzP
 Z+9FAR4fyEOUzVwXki0OCgakxmMK3rwQMO0FPo6H+zk3YVsNntpwoS+Tp7MCzP5b
 ELs/SDw9ERA1aATW6LNWKE24YoD4bUWAS0BLRrnAmx8Cnfyxt9uuJDHW1Ux9aD00
 XcD9pz/5A/9Zd0J2ZY+qpCCOPFJ4OPkJcUcjyRMXs2NmJDy4pLH0bbAU8A9r3MCk
 zIvqvCUPWFfPuV08HcewW3Akmo+S0RSZmFXjq2Lhf1r7BSVLOXvR4L527zIHPRRh
 U9s7KoWochvgikPyZl4WCGtRlINvVR+Awlg+lfKIbz4Vgi7OIEDQ/RafNQwDVgvY
 P1joqQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhhxns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 18:54:37 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-13980b6561dso3694765c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781549676; x=1782154476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tMIfthXbLXmK+CNBDrrY39/4cOuOMn+2LYRpx9at/4s=;
 b=XSAv5IHAhocuW31VbLyCP9T/0oyeHhbEfWlhlYPS+y2mom+V+PuTeyTmL20rYWf5XR
 esaWvjKjRNV59+XP6qJGiFJApLQPwZAIb1/YfjdafLyFi7PczimWqYd/akfbPutgPzOf
 U484rwMJDCueav6jRbbNpZQUfyQY+4Ya9nxZuU246viHuAh+R9+BXhjVw5mcM3ePZSYB
 D6oartrNyYgD8B30DadjdgWU8cT/FdxWcLXdJIFZtRWRqAr7rg4QWDZ0GJMX2dDyuvo9
 6Yuc/9IQwRiH5ZPAXbCpZIvuA9jA5czmp4bPhEEFPigospih00hOZVa6dX4wmkvkNMZp
 gB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549676; x=1782154476;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMIfthXbLXmK+CNBDrrY39/4cOuOMn+2LYRpx9at/4s=;
 b=Rnd2KxSRpyL6jEiKDcY9FHYBAPCP1Gh3eWO5pX7w97op27Dw8ptwmaCJy1mv8A9sRo
 lHmgvE0p5tqliom7MZvFUfx2lUrG70aYoAiZ4dIMZ4BBBspKXq/j1fwplFzKqzQte6fO
 Ls9okeV9vCCYCdeNI9wTFCGAYg9e9ZUqLkn3JgZqH7G2d95TGdTVknKrFmr71YfXoAxi
 bKaM0FTosI8+1ZM3J8b+HHSJMS6hr8T3iGvcsTvOihUvOqUDN2uW6g1ztrT46eh8Ekra
 TmGpoC6ABevV2s1bZRzwtCQnOnV4zfiGllrM/M8ENcMzK4aggYBHgjoPzlq2IIRG2neZ
 7GQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ohwau3SBjg1onJC8Vf3BHMEPWKvjAVrJcneBCJHXennRBPy2Ab4WD9cKS5powho8jBbze2jahIxvs@nongnu.org
X-Gm-Message-State: AOJu0Yy18BRLIn9fYpx2f54F8n9U5YnntWkW/sKDY4B4WnzRNV4baxyC
 sHxtXv5uaSztLApNn4J32M7dzpThzdht7MuztjRUbKsTrPnem3hnJOS5KHre3VHySOTgUkiHuus
 +A0PknQCJDcxuTap//OJ2/lNfvj3aB8fKBunIrva84MxwpH2CuuO5VMFZYw==
X-Gm-Gg: Acq92OHJRHCXYQly1lIkKlO6bJJ7r8yaMx+k6YN+eTBUI66akutfEwS5O70wwoSCujd
 al3R+063yi/ykFez1YHqQusxds2W6Wjlj0XTh5pu8yHRs5EdqbItgfN0A7mKP7RFk+mQntgzzJ0
 OjhQaNV2vHMov6ywGohywnMret3V6C55H+AZ2c+izbpRPbow8aQuYh1gsVii7q9aYhPogAyexNz
 H3yphCR7h370UAkgoouNZrg6V/SJ9AHmPSfYwBsTO9P/1uMFRcK6SVVWW69PTaukn8+Ys56U9Ko
 vClVt6dzJz69R1qbJPs4FTkLEEqdVgpro7bSZHSlkHwWFOQ73Za1A986e9ZpKAs79HmCalFwley
 V4haMKwuC8qcS2122VNT+28hRQGSg4RyDRT6MbyNxGqxxv2EZElUOxrKLrnnRXQWTRwD2fW8NDj
 yLxIcK69qr5BeOyQ==
X-Received: by 2002:a05:7022:38b:b0:137:699d:7b95 with SMTP id
 a92af1059eb24-13985f0567amr168418c88.19.1781549676250; 
 Mon, 15 Jun 2026 11:54:36 -0700 (PDT)
X-Received: by 2002:a05:7022:38b:b0:137:699d:7b95 with SMTP id
 a92af1059eb24-13985f0567amr168401c88.19.1781549675760; 
 Mon, 15 Jun 2026 11:54:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97570asm10658676c88.12.2026.06.15.11.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:54:35 -0700 (PDT)
Message-ID: <7d8b0949-4c1c-4ed4-bc6e-48cd96ee7ee3@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 11:54:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/25] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_cb
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-19-pierrick.bouvier@oss.qualcomm.com>
 <tgge40.bxa62azpxlb9@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tgge40.bxa62azpxlb9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwMCBTYWx0ZWRfX0TatMPiMU/Qn
 GOEhlkl+akBNVVz6V9PcqkCRl7+AMp3+iX94GlAn+nNI/oyDnRnnV47NSMEgj65VEu6wsLk19qV
 K4HtpHFVsvWepXeSzyQCN8tWCvtNrPQ=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a304a6d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=DAu3S_-rgCSt3k8ut1IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: u2iiY2Lr4hBebThaNCdkUPtiP94utVJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwMCBTYWx0ZWRfXz0bZJkDOLhuK
 dfeeA15vln8JcKFzMZnf+pw6BQVSfCw/gOev/dxEW9nwyuOrgi3FDBktzQi7fNOdBCOOX9oq6Ov
 lWJPCg+2gHnn0OzgA9Eq1c42P8TxSx4RyVEVot3hj/yKGp4IT/F3InYEK1tTysn3dXk5+5bCGdn
 GtP5E9QV7/KAzWyKZ/YngbbAE5PO6FtgTLYV4wkfmUi9zRlALu+MaytDS6/urpy89p8fnyXldME
 qocZlKj8jfm9mM/UvDhJqAUQQFhAH3zUMPutY5IShQPHoG1vOdV5+McgKRQL4ddiI3A7VR8449h
 n1eiwosbIxyt/cUdsxJXZ/AHFUYEK5pdlnFjKn9wf/ZXTVKM4qLIG1lacwdOF7JNYbG7L2O/AsN
 db9N0bEdG+nSLO3iFYvqRiQQw0PDlIALeDF+QC2qS8GWQOb8N2NAMzdBuCHNGwUAz7yvHK62ZFB
 PZRMl+vxCtap7hXtEag==
X-Proofpoint-ORIG-GUID: u2iiY2Lr4hBebThaNCdkUPtiP94utVJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150200
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

On 6/10/2026 11:00 PM, Manos Pitsidianakis wrote:
> On Wed, 03 Jun 2026 23:51, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> include/plugins/qemu-plugin.h | 8 ++++++--
>> plugins/api.c                 | 5 +++--
>> plugins/core.c                | 2 +-
>> tests/tcg/plugins/syscall.c   | 5 +++--
>> 4 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-
>> plugin.h
>> index d82d996bce6..909f19b7128 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -840,12 +840,14 @@ void qemu_plugin_update_ns(const void *handle,
>> int64_t time);
>>  * @a6: the 6th syscall argument
>>  * @a7: the 7th syscall argument
>>  * @a8: the 8th syscall argument
>> + * @userdata: user data for callback
>>  */
>> typedef void
>> (*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
>>                                  int64_t num, uint64_t a1, uint64_t a2,
>>                                  uint64_t a3, uint64_t a4, uint64_t a5,
>> -                                 uint64_t a6, uint64_t a7, uint64_t a8);
>> +                                 uint64_t a6, uint64_t a7, uint64_t a8,
>> +                                 void *userdata);
>>
>> /**
>>  * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter
>> callback
>> @@ -891,13 +893,15 @@ typedef void
>>  * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry
>> callback
>>  * @id: plugin id
>>  * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
>> + * @userdata: user data for callback
> 
> Suggestion: I noticed in some patches you say "for @cb" and sometimes
> "for callback", if you re-spin this series you could make them
> consistent if you wish.
>

I added a commit on top changing all comments to "user data for
callback", since cb may or may not be present, depending if it's
callback registration, or type.

> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
...

Regards,
Pierrick

