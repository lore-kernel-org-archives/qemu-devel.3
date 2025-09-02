Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A0ECA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIaA-00058N-Du; Tue, 02 Sep 2025 00:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIa5-0004wi-PN
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:25:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIa3-0001OU-D2
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:25:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rlqv012426
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0R9Gzd58ZDfhbrAyXDalHIKA+k7HY+oGo7SOudJVt0o=; b=hzB5zbaPKqDycOii
 xkRHiTWvR7UVkPy/+aamNdFtbPpEgzy1fHBYIdBWwgTI4azN2hjDtv6wki7pMRmv
 2BToAXvW5tz1KB5fFv7GbgzgcgynE3v6wdh4RCsBLXKWRso/L2fz1qQ7M4khkcpz
 PTHcuKhJCX7H47mTdYfymVZGgh+5l5q7xk3bezX0h4BY3f8drS/6lZ6IxhnhTXsP
 CvNmR+krVtxjEAI4tMyrN5LxSzMUe0pyBbkE4z1PHncprC92SmAZ3ZFq8+95BrUj
 GRxWNm1EI19hzHxgFwGf1sXwa2LcmJAaLapCH31Hrj6QCnaff4zwXj5a1PqgYVJ2
 t9CzzA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eemmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:25:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7ea01ed5d7cso541700285a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787112; x=1757391912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0R9Gzd58ZDfhbrAyXDalHIKA+k7HY+oGo7SOudJVt0o=;
 b=fb1DnQ4WYbv88KySdgDYihdfqoUnbYXeSp9eOrVrRqhUd4wat+Sn5vMEgWreZjlqXn
 Bt+vU10RdN9JHnbS+yu6W/CzST7RAYanHyjQiOL++Vjdntq3cG9Ww17FIPd7Q7hrVsmV
 rwVpF4wjUW43v7WFy+vlN5toUJj2cF90cLsi/mpygZgToEQnRlkv42sQIxQ+iBjvyhOW
 iTs1kT7Hy6+yPI3/RXUkOQSZt1D2RtguFlhS+pGtApCPDxHAEG7P6kMw55dJ1VMbA3ju
 kLVxYCz0p2yn38o4M68mD/h0VQUH/eBDddnPOtTIPeb/5wtmQ//cLjIqxoT7Fv54vPPo
 +/8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3240hy3Rrz0WK0T3QuC5IMk89+zrG/hXa7f2LEWIYoqw9Yby9fdw3w0+gt7OlOkCdl+b8+3+C9Z7t@nongnu.org
X-Gm-Message-State: AOJu0YzZq3BO66uwQkmshuAZOMWCkb+2v3kFbYZUJbAZnXFl+beKqiVV
 7TgZD236ezPfyXwGkYF97iLuSD30bFnjdkGtRHY16+xS00+7FVEr601d03TU136O5tGdC7HkPb6
 pE6pkURSsq/LV68oVe0I2xOteq/1NFK/Gy5NNl3gdCNxCO5O7Y8UZNqkICw==
X-Gm-Gg: ASbGnct5E2atnUC0kmB59b59rKJgUHt4HC4sp9p6eBpvR8GnescfWqQLni2mD3FAz22
 k5NUGT5Uw/ug+DjHtBEgnruGghTaOdk96z/rn4SRtWGCBhixmTP/xDI2qaBM4kgVzh9rH0g5jaD
 Ud20YkW/00riN6u6xhPUFMSOgPB+1+oAf1K4y106+41vgvXIFkSFLrLRXwb+h/Bvg3BDvOIaJyP
 38wEBb6ykGV1uuffSgI+TMWrJ5HiaNH7LBECgPC7npIk439o+/XGaUbk5c69bmdehSDQaXmSGb2
 j5yaoXTNDCTRt+7bnw42xfp64VYOoxpH8DcdwEO1scnv/WvMVU6ZLuWYN8Gmzw==
X-Received: by 2002:a05:6214:21cd:b0:70d:a91c:ca74 with SMTP id
 6a1803df08f44-70fac785710mr95977026d6.20.1756787112195; 
 Mon, 01 Sep 2025 21:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW1ke5PkBCL/1ntHo4X6TDD6POrIEczWenmIAQauRKgZQRmuM4KO1RYXL02duxofC0+onYfg==
X-Received: by 2002:a05:6214:21cd:b0:70d:a91c:ca74 with SMTP id
 6a1803df08f44-70fac785710mr95976866d6.20.1756787111596; 
 Mon, 01 Sep 2025 21:25:11 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:25:11 -0700 (PDT)
Message-ID: <d3899083-275d-4ecc-9a8a-3d38e6814571@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 21:12:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/39] target/hexagon: Add exec-start-addr prop
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-25-brian.cain@oss.qualcomm.com>
 <018601db9777$a2080aa0$e6181fe0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <018601db9777$a2080aa0$e6181fe0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1JnUnPgrtulsebhab9lqot6b9xOfrJTF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX9kp5DP3/wtI9
 k0UwjV1UWyWKPLtCYcL64xgTOxnBn+bPKU9+0ZdsdGzgUDTOWHl0dOVTCXkpp0/+yV39744aKNb
 orcZqhArnBzxmlfMAizkEU7zSyMM07hYU09dGDbD2Vk3sempipPR8TmcowGFquIsnnSq5+OQ4iS
 pzNKSHl9hJfYbtpax50NfrkLnpdBzUlXZgES3hb6/YNgMQkbxfRhIwygv2cHv99G/LF9c9vqrrC
 cMga8h9ZGionogu3kopB2QG9NQv1B97w3dfCgJx/jfZEB5x4PQeZjWsym/ip4P10VPSbLkJ21hA
 kEsGoa/9h8fOJDaNFSMPePvd4l80At+tdVGQzJTCmFq7vokFH9TqIJ5kU9QBMd9ZuhC6sdzN4uD
 ZiGhHYeA
X-Proofpoint-ORIG-GUID: 1JnUnPgrtulsebhab9lqot6b9xOfrJTF
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b671a9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=QVse6DiskFMd_LQVWQcA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 3/17/2025 3:03 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:29 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 24/39] target/hexagon: Add exec-start-addr prop
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h | 1 +
>>   target/hexagon/cpu.c | 7 ++-----
>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
>> baa48ec051..4667a1f748 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -194,6 +194,7 @@ struct ArchCPU {
>>       uint32_t num_tlbs;
>>       uint32_t l2vic_base_addr;
>>       uint32_t hvx_contexts;
>> +    uint32_t boot_addr;
>>   #endif
>>   };
>>
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
>> 9f4cfd03c4..7afdcbf9d0 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -66,6 +66,7 @@ static const Property hexagon_cpu_properties[] = {
>>       DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, l2vic_base_addr,
>>           0xffffffffULL),
>>       DEFINE_PROP_UINT32("hvx-contexts", HexagonCPU, hvx_contexts, 0),
>> +    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr,
>> + 0xffffffffULL),
> Don't put a ULL value for a UINT32 property.


Happy to fix this for v3.


> Ditto for l2vic-base-addr above (must've missed it when it came in).
>
>>   #endif
>>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>>       DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU,
>> lldb_stack_adjust, 0, @@ -362,8 +363,6 @@ static void
>> hexagon_cpu_reset_hold(Object *obj, ResetType type)
>>       mmu_reset(env);
>>       arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index);
>>       hexagon_cpu_soft_reset(env);
>> -    memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>> -    memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
> Why are you removing these here?
>
>>       env->threadId = cs->cpu_index;
>>       env->tlb_lock_state = HEX_LOCK_UNLOCKED;
>>       env->k0_lock_state = HEX_LOCK_UNLOCKED; @@ -372,6 +371,7 @@ static
>> void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>>       env->next_PC = 0;
>>       env->wait_next_pc = 0;
>>       env->cause_code = -1;
>> +    arch_set_thread_reg(env, HEX_REG_PC, cpu->boot_addr);
>>   #endif
>>   }
>>
>> @@ -414,9 +414,6 @@ static void hexagon_cpu_realize(DeviceState *dev,
>> Error **errp)  #ifndef CONFIG_USER_ONLY
>>       CPUHexagonState *env = cpu_env(cs);
>>       hex_mmu_realize(env);
>> -#endif
>> -    cpu_reset(cs);
>> -#ifndef CONFIG_USER_ONLY
> Why are you removing these here?
Fixed in v2.
>>       if (cs->cpu_index == 0) {
>>           env->g_sreg = g_new0(target_ulong, NUM_SREGS);
>>           env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));
>> --
>> 2.34.1
>

