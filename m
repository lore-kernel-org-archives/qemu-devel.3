Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEABCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4sI-0001Yz-KY; Tue, 23 Jun 2026 13:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc4s7-0001S5-LL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:25:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc4s5-0006hZ-A6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:25:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBZ9hU030875
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iw4cvxAF2r/b9VCDa1DZOKr3eOO4ZI2d1SoOoNYW2Q4=; b=LD8J9n8Elj3X9f1k
 uEqCnlnYVnFKcCMuDk9IljvRmHDg6VJzQWF0Ks9i+j+KimFGE63zd+oIO37IWm7T
 J20u5JOABzhPQB59P8heyfd2ptHcG5deBP2QS2NmbVDDh7hW9sGmxqI24qH6jEUP
 s5M//x8I6J/VprAYhIxZ8nLIa5sJKEDSGaMNUKwbKHibxQHw6ezFXNPLM0reC+83
 qG7mJUpZfBR/nDqIowo13y0vIsv3YjOHIzt0dXGuHR7itsRSVIy/DPmr3ViopSw2
 b1JAB6M8H/zMZSO3V0WlMisd7flHRIIREkNS48JkFoyct1KW6e7GRTYipTxmBpdk
 YSjfjw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe6a25m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:25:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9158f07f5eeso5192985a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782235506; x=1782840306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iw4cvxAF2r/b9VCDa1DZOKr3eOO4ZI2d1SoOoNYW2Q4=;
 b=QKcvcrnACwCm3YKiiSUvmaFrNA3hfXfaRXYmWQowpUFzrJh25rGFfA7KWQ/XyKHndG
 3cQuWfltpFKN43b2UMrkJTkOWpLq0VBHAhi/tN63Es2K+MukE0RFbsTaRxuT2Z1m3zke
 MYObSa7YiXXyiiVs1Ux9QKTtKe8YreaRpadahZ8K/gegS3RYBR83V9JTUDuo6606wWzu
 u3Y+Uedzd5Hpz0zdcXUoYAZu4dwR3n3c05PtQ9bpZtIRqMvuU0LcUF8IXv1QrQRSEoXL
 6SyxCPjHZEdDV8bEnf0H1iGlIVCocJFTEY4HzijDUyUWue1YVNpkiXd7SuCc0Gz1uEQT
 TveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782235506; x=1782840306;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iw4cvxAF2r/b9VCDa1DZOKr3eOO4ZI2d1SoOoNYW2Q4=;
 b=WCxafmwnHSbQ+2TSOAcnEnHykg9ZDPzAoZYXGthV3oZlhr0CKB8duMnizqhkJMGPgp
 rsnXC6IwYbHqdHz72Iyq/MrSpfEntQxzP2gh7wg9bxy6rfJ/9Ui4Nk2v3/zXal0NciX7
 P5NRrriPdlT6c5mAMY870IF0p+IVqvxCrckfeKo6iJOixumzVSLz1YeU8BSkW9DzZBAu
 1WF1GSsNQVYBQWuCn6C8Ioa6sGQQC0TFGVtaZoMIJaf1gk2g+CX/ifo53cWLngoUNWWc
 Qw1lIlQRj3OSegWzatLHrTVOvVxjO5fOerGI7MJvzmw9kNVR9mraZhvfFk2jG3G+lJa7
 0ktw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xxo+KlS8+3gM5L+Q47FeqqJiFnRUkwV4mLnpnkIccUpOiEKYCPlR4KvrgffU/fCrE3QxZBltJXcQr@nongnu.org
X-Gm-Message-State: AOJu0Yw9tt1hTI3jaShIbDqxXKy/cxqcn3yF12UDd81zTAh15NWCWmeN
 JjgPj62mOf+rEfE0bG55TMhKZ99TVwhtds8Faj18QRZrIECmott3IUVKqkmPXK0GnXhytjHH95l
 Kh2fy+7ZoRkWBjCeE/uuF9Dtjd4+PSssILXIBUX+63w97RZo4aDpJTCpPng==
X-Gm-Gg: AfdE7cnTAUxUpeS+/6Crt9ed5S8wjmBPqO9NpN7BI3pXZAitOTvY2M8Cx9lHF+h7OTZ
 5l1m9fpucdY8DWXvSqgmV0DxU8WKD5JjbsDZqXzfT1AnHIDMMm/4VDK5kUZg8F726swC16TnR66
 ZT6rUWcBZKfihS4w0RMt+seG99GzyrMYr7UrYd+Z0MOjxRCTFAlxjSdFv+WeDrNgy8C0B7HHdQZ
 5i1P3tfFAhysuJtANXFYD8ouooSdQt7NyJI6S9Ik6iUStVPc7XNO1SUDrW4geev31ctcYajSBxc
 Jy66Qcub+yWHlYH9zYaDf9kV2jX2a0rsayI/m+/iO91//CWyqVNA5Xeu0v/cXQmbdLvwTT8LajN
 ligAoEGe6tsTi50Gdaqohri43AQIEBZlCdyf1TbayQvJL
X-Received: by 2002:a05:620a:444d:b0:915:8594:68e8 with SMTP id
 af79cd13be357-92647817629mr663708285a.56.1782235506020; 
 Tue, 23 Jun 2026 10:25:06 -0700 (PDT)
X-Received: by 2002:a05:620a:444d:b0:915:8594:68e8 with SMTP id
 af79cd13be357-92647817629mr663700185a.56.1782235505578; 
 Tue, 23 Jun 2026 10:25:05 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fda62183sm330640385a.13.2026.06.23.10.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:25:05 -0700 (PDT)
Message-ID: <3b91c2ad-479a-4d08-ada4-b9af24ebf697@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 14:25:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] target/riscv: make some riscv_sysemu_ops TCG only
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-6-daniel.barboza@oss.qualcomm.com>
 <5bbeb7ee-2826-453d-b50c-60240df47954@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5bbeb7ee-2826-453d-b50c-60240df47954@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zmKyUy0P1kUGf2JkDFnQQ4ow6GqjzX8g
X-Proofpoint-ORIG-GUID: zmKyUy0P1kUGf2JkDFnQQ4ow6GqjzX8g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0MyBTYWx0ZWRfXxcP/vxKP7XFS
 e+oqWSg3ajA6klI3N2o9E33MVYFXJKmowOGh6kjVoLQGpbm7Yj7e+wtDXZIDZ9t6DLaptXVXtp1
 Qajcs4r+D0FOpJL7rAeXvlm5QoQKqo0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0MyBTYWx0ZWRfXynRpFuwVnYHR
 nZ/6RY+2d1BuCLq3PUAXLdN0YJuSHR4DJyC6ezsKaC32TpRNxc2j1Au8kv1bjJeEAvl8LWYdZqr
 R/VYN9kOs0eFcCqZ1LSx7i2bwaE93IRX+Nn702gqa86T+M2uLRWje00I9O98deT88QifTxt3oYo
 8zJ6wSIYe93OCFUQZxR/m8a76SZVfMJHLazCSsF39BXZr9kdFWY288Mt4uJww4RvW+hrI7ITW2e
 B5w9LwLcU/6Pnh54UldBbuNJuRvEMpdYn3VfQFTl68hLq0RvB/K7sgYA8uKIRJwWVJ/S1QMBydz
 v5VA2G7JbWZiwQiwvDjp+IqZNUpZz1PfPvo4GIzvLDftL65FIttzdDeC+hGGjw3JPOZ6Vkh6vr1
 UkbSBJprohmeUZuAGycWogjIs0AoFg==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3ac172 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VaTl7tzlUKkYZzF-L0EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/22/2026 6:30 PM, Philippe Mathieu-Daudé wrote:
> On 22/6/26 21:31, Daniel Henrique Barboza wrote:
>> monitor_get_register and phys_add_debug are TCG only.
> 
> They aren't... And get_phys_addr_debug() seems mandatory.
> 
> Maybe it happens the RISCV implementation only considers TCG?

Yeah, the wording I used is bad.  What I wanted to say is that the RISC-V
impls of these 2 interfaces are TCG only.

> 
> If so, maybe this patch is heading in the right direction,
> but its description has to be reworded IMHO.
> 
> (while here, maybe we can convert to SysemuCPUOps::translate_for_debug?)

Do you have an example? maybe we could squash it in this patch or, if needed,
we can add a prep patch.


Daniel

> 
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu.c     | 6 ++++--
>>   target/riscv/monitor.c | 2 ++
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 4e96bbeb60..0a7e6f6ed0 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2669,11 +2669,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
>>   static const struct SysemuCPUOps riscv_sysemu_ops = {
>>       .has_work = riscv_cpu_has_work,
>> -    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
>>       .write_elf64_note = riscv_cpu_write_elf64_note,
>>       .write_elf32_note = riscv_cpu_write_elf32_note,
>> -    .monitor_get_register = riscv_monitor_get_register_legacy,
>>       .legacy_vmsd = &vmstate_riscv_cpu,
>> +#ifdef CONFIG_TCG
>> +    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
>> +    .monitor_get_register = riscv_monitor_get_register_legacy,
>> +#endif
>>   };
>>   #endif
>> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
>> index 3e89dcaf7c..7aacd1d89c 100644
>> --- a/target/riscv/monitor.c
>> +++ b/target/riscv/monitor.c
>> @@ -245,6 +245,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>>       mem_info_svxx(mon, env);
>>   }
>> +#ifdef CONFIG_TCG
>>   static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>>                                    target_ulong *val, bool is_gprh)
>>   {
>> @@ -379,3 +380,4 @@ int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
>>       return -EINVAL;
>>   }
>> +#endif
> 


