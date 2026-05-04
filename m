Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3EBFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJyGa-0000MQ-AA; Mon, 04 May 2026 14:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wJyGZ-0000M9-8s
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:43:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wJyGX-00008v-MY
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:43:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644B4IOu636821
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 18:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +AnuHXbvV/GYqEp3MLhCheTPZ5w7fOnuIh5J2RyEzxA=; b=lZ6AsjmfdrU66kee
 ZSPza+Tld7x/LI0lDRXuLqOZsRPagP27WTbay04QkDVmlwDy1Wt/KCZ+azFwYMT4
 rbAJnGEyf0xFFb+OF6SGWWKQ/9IMYaIgJz8wWQduHOuFsHtaVaWBQdKVTq6wf22d
 hvg81JW4NWZ1N57nZExHo30HVYN7EJvbspwRHRhzGEs9lMGbqnKaquGQ9pUNJGjY
 pEY9neOcsI8++62Y057+8ylLUJvMPTUuAVdicBpj6ne+XMn9T9IsC6uKiXzd+ZAh
 rtcQK66T9qpvW7pGCSBHAjg49mG8dccvITr2NAuFNZfoCsny9jDtTKUtOzC+m18w
 qD/mAw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsx49ny3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 18:43:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca29dcd69so122764036d6.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777920214; x=1778525014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+AnuHXbvV/GYqEp3MLhCheTPZ5w7fOnuIh5J2RyEzxA=;
 b=gclRpS7Vv+0Fjqg7uuime8crLWEutpCKvKnoCYIyJixz3pTciWqTPA49k3TsELwIKS
 M01zJCRm71ws/pkSJOAoSm8MRdP3Ge/XPVTHXctNdBL6MAFt+pY85qwnqpWALneSCvog
 10zA0zJGsWNnvHxyLcTS57g2YN5Cyez00WPDpquF3QlI5YXQeS4FVHRaIHmtAUHh4ZM3
 Gl/sM4hOnFXxati7fN1/ygEP1P+9EeFQuYAz4fP6Fza/qIWuL2NGSmyJ0HUeS0mVS8TK
 Y0YuQlLCbVe1KArXyBx9bzhKwyC46fKaeqA455mvSoxHCgc1qpPjeGorpsz8XbTfBOvF
 eugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777920214; x=1778525014;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+AnuHXbvV/GYqEp3MLhCheTPZ5w7fOnuIh5J2RyEzxA=;
 b=s15ka0X7KaS9DF7J1JEQbKTneAMKL39M3El+pAvwDWHUDP5UPxS0CwrPAQukvgy01h
 w17GohCfrKliVWbky06OvYAShp4nDUjOdjqM3zwqsI3FHO8IXWsGyNJ4x+9n3N23hZhH
 5h5pKbHj2Snkn1quhWXaTc4oIkThgJ5GK7XJC8+BmKEHbVn1g65dGDAUlbANcnxIQrKH
 2+ocjGrUHspNnQKY2AGxrwWkCvXHoxwrX6NBC2T/GaHs+aqKXZA30Oyg222wFw3gesFw
 tNkfryc/j8OURslmHvvhfGnaUdSh+JqhLm5uYudsXrZXjP+cvqpjaiY9OC7knH8PYRud
 kgRg==
X-Gm-Message-State: AOJu0YxAIpUySiLnvy347Kq96Rmae7FAOsS0TjsONccLTHj0lr3lZnDi
 5f1/WiGSkNrAqJzMXhdXcU/uRae3kERhv7MQbYurr9jGVZy114ZRX7VYTD1orZJqPidL+uSJdYO
 t93OMqQW/nFAW3rtePV+CMKcRBh7lyUJy4kg5XJVOWC4juPe6qSigLGviKQ==
X-Gm-Gg: AeBDiet3bUhgRlEYiCqbpPvC7geFkyQGe39DrYP3HV+pnBUTcE3uz+15alsFkhxHIGc
 RKlaDN5ohOQ5VngS3bwxD2dFpVL6hHXD9zDVMJvEKTvxhxVkxzYmbsk9+ys1OrwUWpx80MjKJwY
 YGMMSZR5VKY2lZ54gbJz7SmpUyc5ZYHUo4zuL6D8CNvgkzJD4uP1dpGDmzdSdNq/eV4orX5g2OH
 HkvpSuZkxFMughOcxOuOVeqs9OZAaBgzzpTm2uRlochO4De0L6jg4RA284FKHfo1caKPhBQ5abv
 6njseLR0w+BFuo1k2pY4OhLEKB78BTwJvKJwoUJ8KZeT/6ki/mDPpFSlsG9UKBz6hjPiizxlXPw
 7T7ibGi4m7CRE5ZDHOZVG3SAp5b6BUwi13wxE1Gh7hyICtPZ2YUibTqO3iYBJuhsDZ+/Wkw==
X-Received: by 2002:ad4:596c:0:b0:8ae:5fcc:8069 with SMTP id
 6a1803df08f44-8b6671c0b7bmr195748656d6.22.1777920214360; 
 Mon, 04 May 2026 11:43:34 -0700 (PDT)
X-Received: by 2002:ad4:596c:0:b0:8ae:5fcc:8069 with SMTP id
 6a1803df08f44-8b6671c0b7bmr195747896d6.22.1777920213755; 
 Mon, 04 May 2026 11:43:33 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.237.136])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c0e7f27sm150269896d6.32.2026.05.04.11.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 11:43:33 -0700 (PDT)
Message-ID: <35d2eb78-f308-44da-9fd7-0a4ad48ab5db@oss.qualcomm.com>
Date: Mon, 4 May 2026 15:43:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] target/riscv: Add server platform reference cpu
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-3-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKMmYewFC+nJtnwboapFZq_395kk9KeO3_zoC+WMpZfcyg@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKMmYewFC+nJtnwboapFZq_395kk9KeO3_zoC+WMpZfcyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3MSBTYWx0ZWRfX0cMatVUa+KU/
 p4NThHhHSIZA7k9L9GXgKZ4f8k795unX9cUPgv9O9KANosUk3U6i+Rc3uwT7C0U0Xi8Hb8vbnDe
 taUVr2xMytI9xvsUX7luRdBviyquBcjU6GwrJ3tvSoD/0nIBYZhzq6+JOvwM8WoP8oionsASZ+f
 7CdMjmM5Cx7N9ws2A6+M0fhISGA8ZokU2Ro7Fm9WrIS1B7Eyzj3BpnUg5Eaommj4srxMEIJVsXz
 z73+9OQwF7vuQ2ukhap2h/jy/KQOjYa8jrrd7cCR27Uz9CrRNSEmNjKgxKoatU8HDoZZtHbNtYK
 LbjZSMllht8Aj33+C7QepSsvLxwuDoKh+s8dLtwWSZJObHv+c6pG9dUW1dVZWtN6EJ+3EpwAMNA
 GFA/ZehbqJY+1g810AtSq+iIccv5UpLsXhlNC/lLlYFIFw+gRkB5bRD7Awpv3tV/WNGO+h8GB6k
 uIAN6eMSMdj32+oZb9w==
X-Proofpoint-ORIG-GUID: LOVfpGgKKJHfuUxw90si1U-lwe8WXUXV
X-Proofpoint-GUID: LOVfpGgKKJHfuUxw90si1U-lwe8WXUXV
X-Authority-Analysis: v=2.4 cv=LdIMLDfi c=1 sm=1 tr=0 ts=69f8e8d7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IZaa5BNpKBTNMhuJoHisKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=uTRCLKPYAAAA:8 a=kNK2jJtCIcrV3CkMBc8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=T-agBWn15iSmxapsA1lH:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040171
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



On 5/1/2026 12:10 AM, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 5:13 AM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> From: Fei Wu <wu.fei9@sanechips.com.cn>
>>
>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>> profile support and others.
>>
>> This patch provides a new "riscv-server-ref" CPU to go along with the
>> future "riscv-server-ref" board.
>>
>> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>
>> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu-qom.h |  1 +
>>   target/riscv/cpu.c     | 11 +++++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index 30dcdcfaae..a150acd151 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -42,6 +42,7 @@
>>   #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>>   #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>>   #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
>>   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>>   #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 586683b28a..4b59dcabff 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -3401,6 +3401,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>   #endif
>>       ),
>>
>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
>> +        .misa_mxl_max = MXL_RV64,
>> +        .profile = &RVA23S64,
>> +
>> +        .cfg.ext_zkr = true,
>> +        .cfg.ext_svadu = true,
>> +        .cfg.ext_sdext = true,
>> +
>> +        .cfg.max_satp_mode = VM_1_10_SV57,
> 
> Why not SV48?

I tried so hard to come up with a good explanation but failed :) from what I can
tell in the version history we changed it from sv48 to sv57 starting on v3, and
never looked back.  There's no apparent reason/discussion related to this change,
therefore I'll assume that this was a fluke.


I'll change it back to sv48 in v6. Thanks,

Daniel


> 
> Alistair


