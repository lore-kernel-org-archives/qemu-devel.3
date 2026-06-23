Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE8DCDB47C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc8Sj-0000y1-Ok; Tue, 23 Jun 2026 17:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc8Sh-0000tm-Do
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 17:15:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc8Sf-0002ZO-GL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 17:15:15 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwkUS3454664
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 21:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 magXe6KtTlLD03dhum2nDQzDN1jU9apHm5SsCHwrUvs=; b=OPWG6xVHB2rEjAJR
 1wsZ/8SvF2340D7s60Wg6e9y7Hp57niszl8C4wTGOMbL/x7zdYSTH8iUp31Xdt08
 TJeIagBbgxIn61hlJ0ZoMFyf7YqfU3V65u0535xVB3iEReo7giPYqpnG8amSA099
 6XrcsDp1tGO2uZ5vUAmDDRkxxRtCTy2iHOsxGvQMZeaBCTYNVT5miKLBRoZr5NIZ
 NgPMtgHGIyHBoltJo+fyTGppmFjOxUtJrnvM9ADzEhn9bWKSupbn/LUqlMsHct/D
 FnF0h2RJAl9KHe9KCbeigs4hOsGTIsVvKMVc3lTLwAXAYx03g4qtRVVyHvo2he9n
 ZM0VqA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp1gub6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 21:15:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91598ab3a1aso25440785a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782249310; x=1782854110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=magXe6KtTlLD03dhum2nDQzDN1jU9apHm5SsCHwrUvs=;
 b=GmHJM6EMb1+7C2tKZdAOrGOJlnwdz0KKfftx6iwDF1b62db7iuehbxwnBqr14SYfLL
 ycKWZt5hT4aLKngJI0uYkfy4T8YQEgcoTgCNwzohHg2gWnNxDxj40bh7NBmWFx9gFPgz
 /VKGxkk+Ea5cZ09uxrzXQvJMVmRPDWVCIgC34nS+2RzXVyN1z1tMAoQ+ktT3+lCWxZhp
 l0ttHIdyW/Z5I32R6t6i/M9/j5PuoNhBydPln9RQGAgJ+1bL6/BXcdqOEA9J+SQNHWTM
 gJgIDKQALwW49ZWs4Mi7UQyE43qcYcVh3F+sWV0MSSTvtmo6tnOf6ymG+R7Q8DTsvfdO
 PltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782249310; x=1782854110;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=magXe6KtTlLD03dhum2nDQzDN1jU9apHm5SsCHwrUvs=;
 b=qukMQd7u0n3Orl6czG1dUVl38Tx87MkFB3wEYnVZLwZIS2A966VqGfySGV/NnDsPNz
 DHfYz9VBwKGV0yOi5SvUIVEKEqdfmnnWkV28opCGCeXBiuO9enJ2mCAJw+C0QJ3tB0u0
 cyH2mOcnzCji8dfsOQVCq6GbZ/79wF1lX02HtWhs+h3Sr5gc/dSijKaCn4hLOr7hgKU3
 WN5quiEgeJ7XWlkt/WncHxT1M4xmXQSQLANOsA2EXvZGi4zJ/zKBvXpPSihq5eZ2tDDX
 CNlGP1sP2rNbfIUf9Q2vm6Yc6SZr9WyZrsiSB3kxr18pRr42NuzgcqAVHl0OXl2B1/jQ
 glKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Gqg/PRbRmdvB9VloSifmppzMCNRs3Dn2uYMRR8kv1vQp6ETgwJdgFb0PS1elqiB+3UcDwOeTxmIkD@nongnu.org
X-Gm-Message-State: AOJu0YwmwRCj/+jif/ufc8njPsX4xL3yhdWk1I//e9G73yB4mRgSYWDI
 g69lWHle6QY7ZaojBHQTYPuTtrzl4+Y4jbe9x097HJPYGajzNABE6vFcKNsVHbMPkQNq1NYA/LL
 x2aRPKeeFu5sOJN3KI4Z5BKzVvDtBW4+HetKmkGG72HMdZPfsaQ+E68j0Mg==
X-Gm-Gg: AfdE7cm7n5iTs6T2FlfM75P71YqoAI/MRq6f6K+UuIo/iXiFVBfACvplY7mrPk0mcrA
 27HyrQAZmP2UanfTwxCFRGhG1A3BxKIeB7hRZA3vgS+ZadUT3ld9rfuY1gY8JW1mXXZn7NV7iah
 mbiM/UOBmEqKbF65iijgl95+J2uztqMOms9jwRQWbUizo6y39dan187XJfqdMuCE5TkPCBn/HhU
 M1Cs0bjapNidb9utvkrv8YG9cOeh2U4ffHBylw7z/Y+BzgMjV+sauEaIRnom28NsTop58c7Unl/
 5fx9qmAz5YqcC1BizC09eb97sCawJ0vF7ymMv6amqXxn4cBxShYmqO/80VgboMn4ZEC277EYWeb
 8KKcbXOzBWK9auZP9RCmHuIxuCazcShfme3VSFXl0aaO6
X-Received: by 2002:a05:620a:170f:b0:915:9e84:85d1 with SMTP id
 af79cd13be357-92645da2097mr754205885a.23.1782249309984; 
 Tue, 23 Jun 2026 14:15:09 -0700 (PDT)
X-Received: by 2002:a05:620a:170f:b0:915:9e84:85d1 with SMTP id
 af79cd13be357-92645da2097mr754196485a.23.1782249309418; 
 Tue, 23 Jun 2026 14:15:09 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926000c0c0csm371464085a.25.2026.06.23.14.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 14:15:08 -0700 (PDT)
Message-ID: <daa5f524-1b44-457f-bc23-b93a281cf4f6@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:15:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] target/riscv: make some riscv_sysemu_ops TCG only
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-6-daniel.barboza@oss.qualcomm.com>
 <5bbeb7ee-2826-453d-b50c-60240df47954@oss.qualcomm.com>
 <3b91c2ad-479a-4d08-ada4-b9af24ebf697@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3b91c2ad-479a-4d08-ada4-b9af24ebf697@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Zs0m3_u7cTq2WuY7t1dO9dRlGRTpyyRr
X-Proofpoint-GUID: Zs0m3_u7cTq2WuY7t1dO9dRlGRTpyyRr
X-Authority-Analysis: v=2.4 cv=QJhYgALL c=1 sm=1 tr=0 ts=6a3af75f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=GlbM3WHAALaB_hmt5SQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE3NSBTYWx0ZWRfXwY9UPz2qqyZ4
 6QZS5h/Ec7bW1MaUfjl5U4YA3WEr89zdwY/dF5MJfBHyFvqVf+RJSeBTdh+JemMP5vi+2uRBlAp
 m5A9IG6uSJVvVDu4uofycR/tX8Z7sqg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE3NSBTYWx0ZWRfX+AumllvBBBPU
 w3+Hat5fpuWYdYURmipobLoe00XJ6fEb/3qx8LnQCWhICghyV8J9LtDxwlCX1TwnzLNtJIKC7uI
 5HoWz0filfgo8Yo4hYSBN3rsMzXtRE+VHtBwH/OlTIAq/Mm1xy8oZQtTGrmv3HYyP8ajZLLiexW
 aJ3kGmgLmE85f0BUOz9dikt1WQ91d+Le/GF1Z9qc7jnMXUOi7rjljBbm+ClrM5nSeJilgFFC98X
 AnnBFKWt5hWBk4PROn/eWNsAFR2TRoLuySROx7zIao1CiEaV5rjZ6ME1/YEA363o4ljeE4w6dIY
 YgQbLyQvovOFXrAb/65GuEy4uRO1nDtqgUBh8x/cm9QL1Fs3iHQAaYfRyWcnacPYgGSqB1CnU7S
 vDoeXFDCJZW9k2beTo/btJCrmF7oStukL7zxzbSPmVljM+WkM+vNqqJiM7kvHp5gpCckVr9vwfr
 0j8liwn+HMDi9X1RqTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230175
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 6/23/2026 2:25 PM, Daniel Henrique Barboza wrote:
> 
> 
> On 6/22/2026 6:30 PM, Philippe Mathieu-Daudé wrote:
>> On 22/6/26 21:31, Daniel Henrique Barboza wrote:
>>> monitor_get_register and phys_add_debug are TCG only.
>>
>> They aren't... And get_phys_addr_debug() seems mandatory.
>>
>> Maybe it happens the RISCV implementation only considers TCG?
> 
> Yeah, the wording I used is bad.  What I wanted to say is that the RISC-V
> impls of these 2 interfaces are TCG only.
> 
>>
>> If so, maybe this patch is heading in the right direction,
>> but its description has to be reworded IMHO.
>>
>> (while here, maybe we can convert to SysemuCPUOps::translate_for_debug?)
> 
> Do you have an example? maybe we could squash it in this patch or, if needed,
> we can add a prep patch.

Just found an easy example in the microblaze code.  I'll make the conversion
in this same patch.


Thanks,
Daniel

> 
> 
> Daniel
> 
>>
>>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>> ---
>>>   target/riscv/cpu.c     | 6 ++++--
>>>   target/riscv/monitor.c | 2 ++
>>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 4e96bbeb60..0a7e6f6ed0 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -2669,11 +2669,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
>>>   static const struct SysemuCPUOps riscv_sysemu_ops = {
>>>       .has_work = riscv_cpu_has_work,
>>> -    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
>>>       .write_elf64_note = riscv_cpu_write_elf64_note,
>>>       .write_elf32_note = riscv_cpu_write_elf32_note,
>>> -    .monitor_get_register = riscv_monitor_get_register_legacy,
>>>       .legacy_vmsd = &vmstate_riscv_cpu,
>>> +#ifdef CONFIG_TCG
>>> +    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
>>> +    .monitor_get_register = riscv_monitor_get_register_legacy,
>>> +#endif
>>>   };
>>>   #endif
>>> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
>>> index 3e89dcaf7c..7aacd1d89c 100644
>>> --- a/target/riscv/monitor.c
>>> +++ b/target/riscv/monitor.c
>>> @@ -245,6 +245,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>>>       mem_info_svxx(mon, env);
>>>   }
>>> +#ifdef CONFIG_TCG
>>>   static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>>>                                    target_ulong *val, bool is_gprh)
>>>   {
>>> @@ -379,3 +380,4 @@ int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
>>>       return -EINVAL;
>>>   }
>>> +#endif
>>
> 


