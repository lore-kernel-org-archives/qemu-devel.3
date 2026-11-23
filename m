Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A9606A681
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QoU9x9Mk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Eggmcf39
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVOpV-0003Af-EA; Mon, 23 Nov 2026 02:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVOpT-0003AG-PD
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:51:11 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVOpR-0005GA-NV
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:51:11 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN50v451960978
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q/0zW6xxrtosJNHDIkpc0kRXyO4jXKZkWfFTspcd46w=; b=QoU9x9Mkuk9Hnksf
 CTSAa9F1zbVKHgOsFdMMQPvtGsOOHappbuwW9lSBbSewhKu78PFcMfNMNxCkvA6n
 I+JXESGITcUBJR+fuhmmpqEZnEp6xzFYb/WLE6w4vhdPzgVrgUl/fxxdZQE5chAp
 mDEAcEkCBKiuyZ5cM8piAFEcqidQ4NkKvxpZGE3yUzRdTftF30itK+374K/lstqq
 WkIk7e0CenRfm4a2KSe271zKIuZzHTDzCJTD5D3SYEUolJe5k1h5I33Oej0S5v/t
 +8mveNJvMHtsyw1cYDhcnDmujwl/0KLW1L0xhqwiebGdfgGIo9L8A4qV51YW294q
 39CTiQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6nurf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:51:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-55d994579f9so14208661cf.0
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 23:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795420267; x=1796025067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q/0zW6xxrtosJNHDIkpc0kRXyO4jXKZkWfFTspcd46w=;
 b=Eggmcf39G+dsl9DOP88wyQq2WL++fe7MwFn5t6WUG2HsW3C0x10dcHmOizZY8MZwfc
 Ed1Uj7Wet3KDjTJXIlCXk925B+H1jFMjH3jRzPe+zYYy9TMxCaKRxbP54ds0J2s+jnZv
 yzkknginWIfC3vKStZghsvuBM1+7Mnfx/QHoHBfQPWEp9wAnM4/mU2bJN9abva1CsAwl
 YVddCWwaXGoAc7GjDep8oJxY35egqSq2WQjUQIIoR/Z1S8XeCE2HZk0AQ6gacJhlAY6q
 HYIcFJHBzBsQ8JOBtljtLYxRtnrcqx3+dG8M9pva+76v1iF3kxxlrIgPh7A6WtflhyNh
 YKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795420267; x=1796025067;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/0zW6xxrtosJNHDIkpc0kRXyO4jXKZkWfFTspcd46w=;
 b=ejF4WvmjYu/8fWfw+57208qRYFLxUENYEUo/HDfHGcEGGZQg9O0pAQ8qmTQ2yvDrIP
 3wdkuNQHfCZB2A8MlggmXPzIWcqObQmmkH2z5Nr+8mJoI1k9U8gLqbPGj/hkHxKnuHZa
 xdvR0UttZkumC/WFFa81E4+gjE4506yaj7wFub6u6cGC1BIESm7eNjUNr0NphFRfZZEA
 jv0bGv1QWSUUUHA6LPG3SgyQ4B5xgWLGGgVqiVWX8x3lU0FK9Z47lgx+6khmJAJt+xC2
 eZFRrkNmJBEH9fX2u/yt5ZNSb5Wtkwvo2SOo34iBUB5kUh5TWe1BhFV5IYkQNUqFOKen
 Ggbg==
X-Forwarded-Encrypted: i=1;
 AL+hErGPFlln2R9jgo1ptbS6FFgn0JsXcdJLoSO6cQ891CxnF134yRN/V4zY/Dlis6yjd19iQrr10rpDMKyb@nongnu.org
X-Gm-Message-State: APuU4Z87/dO0rwFpXj34Cgy4GPf4Vv34qKqDT8LC8TdmQL6JnRwxrCHR
 X8NJgkrAIHglkd87AscEJXWlPiCmEJjB4d26bCcSBL4fZRci2xKxoqw4SK6MX5n94Fdy45Gi6Qp
 7wFWH+fWoFhpqQsCEEHamev8jTlE8lacVPqU9ezFZ7N64M2q9/7m0zcdYkw==
X-Gm-Gg: AZFdTZfA8fZD8XILbE4EdDVTpsRXID5oboYiVAy/I6nT6hxwIdWgtQFHojuVAn4SLV5
 4d77dOm/1pfWmW4gPr/fp5t3nUd2YSoMz+qsDAEiIpAOkfmtdu8FTdiN2wttzFsDPq6fosZ/4iK
 TfAfk3dHVDJzr7VORiitlfbL1qTIyCJoH63bPr/tXaXM6ParnBNve2BiIebsALh4SYM96SPnc5k
 O7lHzGNTeHmPJLDKsU88mWTUA8j6S2PSphy3jH2lc0JClSQuxGhJTeSxAKUF6xjzCyNOPDgMI5R
 e12CTA6Nl+GofOaLauRAEjZwlf224+IKLN7s4THRqe3Vmr8v762MOODcI3Ykfb7DavvPsdkEfnL
 8QDelzkSnFxCI54NJWvWNQuQmWvtdoMWnS5aDbAz/CXf9uDndU9uUfATqXwaFtKzv/nR4HQUee3
 FInHzkE0c=
X-Received: by 2002:a05:622a:1a89:b0:536:8bb3:ee45 with SMTP id
 d75a77b69052e-55d76a38dadmr189863011cf.30.1795420267085; 
 Sun, 22 Nov 2026 23:51:07 -0800 (PST)
X-Received: by 2002:a05:622a:1a89:b0:536:8bb3:ee45 with SMTP id
 d75a77b69052e-55d76a38dadmr189862801cf.30.1795420266542; 
 Sun, 22 Nov 2026 23:51:06 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm14182147f8f.15.2026.11.22.23.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 23:51:05 -0800 (PST)
Message-ID: <1b05e1f3-b739-44e4-9a56-217455b16dd5@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 08:51:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Keep cycle overflow deadlines in virtual
 nanoseconds
To: TianCheng TANG <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261119222036.71913-1-philmd@oss.qualcomm.com>
 <13a574ec-484d-47e3-8937-2327d296cec8@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <13a574ec-484d-47e3-8937-2327d296cec8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BdBpdnLRu7DZ3a9cfHpJtsqApDP56ClB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX7Ft80iSP+eDi
 awaS7HtL33uSF+p2NmNRB8EP9vQPsr/DcruGY3nUos0Xb53lX8FF8tJi8ddYO8Dy7/Hwx89brkl
 26o+7Ji9lMuB1qDXskr2I4B+sqRfRdg=
X-Proofpoint-ORIG-GUID: BdBpdnLRu7DZ3a9cfHpJtsqApDP56ClB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfXwSbrsDun02OB
 r3ji09VG9slBwaHJkP8JYot7IH2QOs13hw3JIRvMbi7nF+dNKXq33h+I4enyqR3fS9HhllxyDkN
 ez02hiLROGOMXrIdkP7Ep5TZ9dUomQak4d6+1/H/IrGEoHvhu/c/GsQNA8t9bsvQkWLqWiH9Eb4
 JUflUkdLZ/cRmftQAq4qSzSMTKw/2HcJdmC7U1TzbXo1EL8VthaOulCIWiZIzjqdnecXUKYFPs5
 4NFZAU6TJ4TLt3JpUM46tRlaa+tLW7dgTUK96UiPKDq6FhU838AguXfl0RnvWfBLSkC3CCpGeNv
 cab5q5Kcon2K7C3Qt0qf6BhlWpZIcLrzcmOHRVJz1EJ62ss4ebUvHfNXU/zT+V4b8AC8akvn5pO
 z2/ETW9n9I+wSQsBibf01cRc2oIrYfM73vavjdVb3q1ZxtVSOIdBczFNnzcMSnMr/gz7ja4wEdu
 04x3LHKS4LIAyZdimKg==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b03f06b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=xxBewgCzm8hXLYR9PUMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tiancheng,

On 20/11/26 04:01, TianCheng TANG wrote:
> 
> 在 2026/11/20 06:20, Philippe Mathieu-Daudé 写道:
>> The cycle counter uses icount_get(), which already returns virtual
>> time in nanoseconds. The PMU overflow helper applies icount_to_ns()
>> to both cycle and instruction counters, so cycle overflow timers
>> are delayed by the icount shift.
>>
>> Pass the counter context to the helper and scale only instruction
>> counts.
> Hi Philippe,
> 
> Patch 3 of my PMU series [1] includes this fix.

Yes, I noticed your work while preparing mine for submission. I have
the impression your series is too big to get merged as a fix for 11.2
so I sent mine hoping at least this part'd get fixed, it isn't
invasive; still your series would need adapting rebase then.

> Its aim is to keep
> counter accounting and overflow scheduling consistent for each fixed
> event.
> 
> It introduces riscv_pmu_read_fixed_source() so counter reads and
> privilege accounting use the same source. In non-icount mode, this
> switches both paths to VM-elapsed ticks, excluding time spent while
> the VM is stopped.
> 
> Overflow scheduling must respect that source's units. Under icount,
> cycles are already virtual nanoseconds, while instructions remain
> raw counts. In pmu_ticks_to_ns(), icount_to_ns() therefore converts
> only the number of instructions remaining before overflow to virtual
> nanoseconds. The cycle value needs no further conversion.
> 
> This covers the issue addressed by your patch. Patch 3 also includes
> a cycle-overflow regression test with icount shift=3.
> 
> Thanks,
> Tiancheng
> 
> [1] https://lore.kernel.org/qemu-devel/20261119-riscv-pmu-correctness- 
> v5-3-ae9bdc2d2f86@linux.alibaba.com/
> 
>> Fixes: b2d7a7c7e4e30 ("target/riscv: Implement privilege mode 
>> filtering for cycle/instret")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/riscv/tcg/pmu.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
>> index 0165faf06b86..cd4de9cde0ab 100644
>> --- a/target/riscv/tcg/pmu.c
>> +++ b/target/riscv/tcg/pmu.c
>> @@ -281,12 +281,15 @@ static gboolean pmu_remove_event_map(gpointer 
>> key, gpointer value,
>>       return (GPOINTER_TO_UINT(value) == GPOINTER_TO_UINT(udata)) ? 
>> true : false;
>>   }
>> -static int64_t pmu_icount_ticks_to_ns(int64_t value)
>> +static int64_t pmu_icount_ticks_to_ns(CPURISCVState *env, uint32_t 
>> ctr_idx,
>> +                                      int64_t value)
>>   {
>>       int64_t ret = 0;
>>       if (icount_enabled()) {
>> -        ret = icount_to_ns(value);
>> +        /* The cycle counter counts ns of virtual time, see 
>> icount_get() */
>> +        ret = riscv_pmu_ctr_monitor_instructions(env, ctr_idx) ?
>> +              icount_to_ns(value) : value;
>>       } else {
>>           ret = (NANOSECONDS_PER_SECOND / RISCV_TIMEBASE_FREQ) * value;
>>       }
>> @@ -456,8 +459,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, 
>> uint64_t value, uint32_t ctr_idx)
>>       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>> -        overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
>> -        overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
>> +        overflow_ns = pmu_icount_ticks_to_ns(env, ctr_idx,
>> +                                             (int64_t)overflow_delta);
>> +        overflow_left = pmu_icount_ticks_to_ns(env, ctr_idx, 
>> overflow_left);
>>       } else {
>>           return -1;
>>       }
> 


