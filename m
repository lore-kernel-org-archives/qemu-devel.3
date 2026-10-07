Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F958CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEVUq-0007D8-PZ; Wed, 07 Oct 2026 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEVTe-000754-SI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 13:30:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEVTc-0003ff-Lo
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 13:30:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697Ggpf61423390
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 17:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SC30Ocf3ftAI6tKBSOsLS47gpVDQ/hdhCPVUUGpHVeU=; b=G/kS4Z/oNaqYZiyD
 tePj61Z+7/R1+nZe2d2V/RlYGX13DJ9/yTHjV9cdjmQumlLbp/eopGTl0A0tmhHG
 q9KVgqZJ40WSjzbyph9oCcpSc1yokfMNY/UlOCEqgQejjdKmkHDnBnql/l/GM4Ls
 qrnJVvumGrL0bsc98qPwho9WiHh22c6f3PcLFcuLX0IrzVAGvHGw3QThBV+inZyP
 YzUm4+nuEBqPp3MPeQ8BTaHi7qpDnQvjevVDyp9tOP72X9XedI+uEnVLeBXSAk7g
 3dP68LyoEPqvhcBx2/Vh8QkNO4savcx2D1zTdQk9hjjhaom0GpC3haCE1j9mVByE
 h5jyNQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5suhr6ue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:30:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so924214285a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791394245; x=1791999045; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SC30Ocf3ftAI6tKBSOsLS47gpVDQ/hdhCPVUUGpHVeU=;
 b=inIHuvpvaigJ7Glfy68A/bOddajy040e0P12NWt0qL2t0KTl6pp2/54sevkOPmJW4O
 cECjg89ntqIvlnGKFQ7yiVE4LdEVCYV5Rh/GBGKPc4cwYX9z+30bpzzJ7JKcCzl0pUIK
 anE5ngz6f/4ROBKrbJa1x+hnolwF+QTZmkPol571d9IAlu9ygVNPDm1jSFHxKjYzKAJq
 iRPF4bxDib3alxNxW49XhmDMhJVpfnQ7ZgFCjI6+O9oE0bMQ/1ixKq66qBj1RJHA+Ed2
 HzxLuaMU66n5RshI3/mEmyh1GD4N9cSb/lD13eGJ/qyhhJRKPd67NwNUcGPzcm3pYhZH
 PFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394245; x=1791999045;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SC30Ocf3ftAI6tKBSOsLS47gpVDQ/hdhCPVUUGpHVeU=;
 b=X4nhbbotTM3SRMOBbmSCKanw8NcSCjSZzr4XTY9sTvIzt4UCRQ6bI1W1SDQ+5iGX6K
 By6gPVB9JX65fMOQqrK9POlhXmddFNQEswMgky732AFrDofEan1l/huyZjMmeTCjY4Hq
 G5BlqT6hIcIx+LbAMH9YDuFJ/Fl6BtZMzwmheBcZfYh4qWv0DVcW6MC1fGAkfzcfVFur
 2GtOApIcPHGl+3NHYzbv8gvjVtq+o0EDsaB8kJzyMFVguhDTSUMDogu88R4eF7Z2WCGQ
 EK3G0jYLzCidmaA0rzX8e9zME4iPzEF4Ypgzb7XYP94IbMA9PFav7awwJh195GTrR5BA
 kQwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3oColLs7NlCce4hgyQp1AS9kpKH28YsudVa+6XfOvkotRAEtOP2+7ZU64hZWDclMFI0OGuAqYaZx7@nongnu.org
X-Gm-Message-State: AFuF++m7O0EBeRdu/Gc+MN5Qav5PF7iaLkLkEJINTszGJ8z5BSrmG2+r
 l/7aV2XuLt3MuMXWnY2A57WljQdhpN0xSfDDsZLeIY/ox/Pil3z6aQCbDLiLnR/itxRgbPUpxH5
 zF5AJjMii1LQ8EsHFvLzX2RrzGt1ZS0z6U1tNt/JKxQpDyVuZIBAkK4Cg1g==
X-Gm-Gg: AYBFou0JBY58Tt3+/Wr9DQLbF8Upwmp+zNMdVtahq+Fqtny5kBuniw4FvRpBpLoyCYb
 U/C4Ub2NTZg5CodcS9wn/i5Dt8L1T1AzdLGtxtBMKHeZ0ClHAspSyDRs1zUQSjW+Y0ektKL6yq0
 N74+bqCptLMU3Wn6lrWJC0p0fwqdNoSsfFE3GKYHKEO4f8TO5w1z0X05jmXVu9XWbA0B7EEbidm
 W5UsFtx5yskY9sdGmm7T44kp2QXrF8AfRrvCDChbjC502UBb3eA6VsBnTAsUDRRXVG/ksRkomsn
 yHgS8ItqydRhbxJvwJDCwodQQTHx9zMm4oppRAJIbrR/IAZvEKTfuyr7KWmf39wJFwGZlRmfEoF
 F9wLHSaHjOfVRYWGsruBV
X-Received: by 2002:a05:620a:444a:b0:93d:23b3:507b with SMTP id
 af79cd13be357-93e9b80306cmr541315185a.57.1791394244689; 
 Wed, 07 Oct 2026 10:30:44 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:93d:23b3:507b with SMTP id
 af79cd13be357-93e9b80306cmr541310185a.57.1791394244051; 
 Wed, 07 Oct 2026 10:30:44 -0700 (PDT)
Received: from [10.251.42.73] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1802e4563sm43202275e9.3.2026.10.07.10.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 10:30:43 -0700 (PDT)
Message-ID: <5df7768b-013f-4686-9ac4-cb8e39773919@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 19:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] target/riscv: Compile arch_dump.c once
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-15-8a2f0f296a7f@rev.ng>
 <b41b3cd4-2f20-4c34-8b8d-da80c23a6990@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b41b3cd4-2f20-4c34-8b8d-da80c23a6990@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZUCU5TMU5ztwGjnrJXXiGqoBrV8rmQHx
X-Proofpoint-ORIG-GUID: ZUCU5TMU5ztwGjnrJXXiGqoBrV8rmQHx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2OSBTYWx0ZWRfX4il6H48s+s1A
 hX8guHwU5PKRdWcWkP91ZIhs1OZvIiJ0TQ0gFEXmEFlDjK5SDKt/AY+suP4OVWkLRE19TohjCx9
 p1D2fQkDn5P2Tpp9WIGVKsEpJioTONc=
X-Authority-Analysis: v=2.4 cv=e9qT2qp/ c=1 sm=1 tr=0 ts=6ac681c6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=uxkZjOOMJT5FjBTOQEUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2OSBTYWx0ZWRfX9A9Pk83OKNbe
 yoI3EzZEmDDh/T0vp0tk0vaiYSRiyhsWNwAm5ddM+MqU2+3aN7MNZQw0EQTJHjqOf0NCSJ4k8D8
 1GzWuFM77xGJ7AfFURIfD3AJqgGwGs7gJmfdikNYySqHKsvKIbU7FkKloPurLkzNaI6TIJmMhBG
 E9P/725uYvkQ2Ibac/ti4cKrOQkMsWzWwDjWQsBARWq+RYVZ41C+OtlhzW4upmkVBsYnwd18Tbn
 DzmXKsjOyyRopxl0okb4nfSFCxYogyrhnw7HjLDQhrMVRNXVs8+/uNRqC1XxRmnc53OBZ5HRvNX
 LSAspfcM3bNFW6bFPvvU/ZPFb8p+TIsgL2PmzVb1GzKSokIERRUkLaqcZbRgLA5PWV/18Ks2uMb
 ie5URMim5Fv4OscrYm27R2e22n67JwYUtgSWKtghhW6W5FNzK7SP9h0nwO5AbnbU4UszrasN5Jt
 r7XOUtucyuLQQEnTgJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2026-10-07 12:34, Philippe Mathieu-DaudÃ© wrote:
> On 7/10/26 10:43, Anton Johansson wrote:
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   target/riscv/arch_dump.c | 13 +++++++------
>>   target/riscv/meson.build |  2 +-
>>   2 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
> 
> 
>> @@ -175,11 +176,11 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>       info->d_machine = EM_RISCV;
>> -#if defined(TARGET_RISCV64)
>> -    info->d_class = ELFCLASS64;
>> -#else
>> -    info->d_class = ELFCLASS32;
>> -#endif
>> +    if (target_riscv64()) {
>> +        info->d_class = ELFCLASS64;
>> +    } else {
>> +        info->d_class = ELFCLASS32;
>> +    }
> If this is good enough to link:
> Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> But FYI the whole "system/dump-arch.h" API is not ready for
> heterogenous emulation. We discussed it once with Marc-André
> and there is no good way to adapt it, since it was not designed
> with that in mind, and is restricted to a single architecture
> which doesn't change (word size, endianness) at runtime.
> IIRC we ended agreeing dump can not be supported in Het.Emu.,
> and the plan was to refactor get_dump_info() as a CPUClass
> handler, if not heterogenous then dispatch if available
> otherwise fallback to "not supported" stub.

FTR for whoever will work on this, this symbol will clash:

$ git grep -w cpu_get_dump_info
dump/dump.c:1856:     * If the target architecture is not supported, 
cpu_get_dump_info() will
dump/dump.c:1859:    ret = cpu_get_dump_info(&s->dump_info, 
&s->guest_phys_blocks);
include/system/dump-arch.h:31:int cpu_get_dump_info(ArchDumpInfo *info,
stubs/dump.c:17:int cpu_get_dump_info(ArchDumpInfo *info,
target/arm/arch_dump.c:388:int cpu_get_dump_info(ArchDumpInfo *info,
target/i386/arch_dump.c:397:int cpu_get_dump_info(ArchDumpInfo *info,
target/loongarch/arch_dump.c:145:int cpu_get_dump_info(ArchDumpInfo *info,
target/ppc/arch_dump.c:232:int cpu_get_dump_info(ArchDumpInfo *info,
target/riscv/arch_dump.c:164:int cpu_get_dump_info(ArchDumpInfo *info,
target/s390x/arch_dump.c:452:int cpu_get_dump_info(ArchDumpInfo *info,


