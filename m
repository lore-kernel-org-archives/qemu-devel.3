Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63759CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbmE3-0000vl-Kw; Mon, 22 Jun 2026 17:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbmE2-0000vQ-4M
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:30:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbmE0-0002hw-5S
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:30:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZja13222600
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8fA+bwIxngng3BWhLGGWMAchZSbULsqSLjuBoUzfsBc=; b=mNMw5uXSUpk6V1C1
 vAWooOBk89VzdxLh8XaR7XMM9AmE8J/65WNhwgPOjBomyhOlGHJpnOrOvV60JLiJ
 OhBvPoqbZ0gC9eotUvcuiAKIA+ruXP/09NRWoy1Fr+If0QuXhj5CRWsqkgAric6R
 x6CMAvwhDYZ/KEncbzMAAeO0gHE6pCWqki5zAvo9Ka9QnRMSRZd56R7HtPLuo2eD
 pN1befwYtGsCvxiXnrfxGyrb8GVstAAPA5QgbOsx5XX8NfM5c8KrYps0qUtyHcRT
 lq1aTwemr0QTXtiLRs2apJRLBH2T4UJxPtcduct+VLklvX20yDXB0geRgdB05C/g
 jaZ2Vg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn1ru2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:30:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9214bfa3b98so616825085a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782163833; x=1782768633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8fA+bwIxngng3BWhLGGWMAchZSbULsqSLjuBoUzfsBc=;
 b=GfxXCTn7SqU6VyjmJ2e9D2kGZEmvpS2Ww3/qQ6RKnWYBlJ4g5B05nOlLuywS8wYIny
 KM4mwr0IR53+O2eJMwyh959AdzMLkHhbrMddoRT62pgNp2cpQm/dRuMWj9Xf+E8E5Rhd
 wcljPwSvr84IDi3MWt/heQCYaKrx14BRuB2NCtzAuQO2WafPk5c5Aaa9fGjUAtSVIeLr
 esd9xDhS5sPef/FO2BXG02pxZmaCEkIKNz3eHMn7/uO2qPSDDWDZZjKWpXARqbpCqhHB
 mubcE3aFJJQ2B7d1OAhc7iI3Bbbds1vXTVoCAU/yNFQ9UrAERvX8L5+4qQvpT3BK1C8b
 3ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782163833; x=1782768633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fA+bwIxngng3BWhLGGWMAchZSbULsqSLjuBoUzfsBc=;
 b=oU2s17pzNQFULkWFPNzulFuHXbYDFqMAMGoemfVs4tCVdlONlEDzrVWoySWii0/f99
 D0rDjcphtw3diItPjKttswG5MOuuLKEzt88M31s1JZa7Wph9n2Gfe+CnHD36InobTh8N
 iWoHfI2UCUbd+xIKArw98h/VfgQLfLKnOLXY8/oXn4vifXakCI/Th1tPyofkS/8IdKVa
 1kj1CKL4JOLIuoTWJtjNd3hThl1pWiX2SIQVQ7Y7bYX3In08wTLVJ6c98fE6MrvnGnbV
 pLVCOSxLbPEMpg7avOJzKEaGvJyLcMPiu2InEsOC/ezGVaV90c8jfmUf7fWwEoExFNiD
 mtaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xchTmxyLP6vEhJlrWxFEj8WRih4UUtiZy2y/T5TPio+BxuhU2MdbeXZBo643xxVDUw7gQBlw3sbqE@nongnu.org
X-Gm-Message-State: AOJu0YzLBswYvoVEfKqmggg71686DTWnzaucrEvFH4FFFlMIKzcnt3fp
 oAjajkuR592f22n4xXoqxFFYJfTr1B/AX4EGKr7Npc1s7D1uCl6LgP84EwryL0lApxKRtpjIIa4
 zMe1/8MIB57X6Ermr1qGS6CN0/ZHebgmTBov/0amXxY8hj+Ognrqtgj42Kw==
X-Gm-Gg: AfdE7ckvGsvc7ctBLRxY61yLX3q14+tDZ8zS9x+rDE52Vx+kBq5UzyNY/r1CVLm9yZs
 GSxIAX5EacQyyxarHhSYowe9RWTLltDl8/fEKwG1HgIWaMLdPd1Ya0HMxxPkiHy9FKwnAiKwAtr
 QJ9OrPrSMtuuXzmKQgRart6+Y6wUksUyceTA1tcjOAT4R+VPw26CkyhcVwJpDaJWVPmKbKy0smX
 B7f9ZOOYgBthc/owOFCv/Ifsl+cZEV136DxKVfSrdq8owBBd+Y1ONjz1VcrKxXGjBmrsB/Q5SNa
 AcM+m50kLbZ2JuNHmb0ZXQqMIsm2/pcrPwEwu8gDKNt8WvhHzWJqvlVxEkwBSPiiG+lDpCicB0p
 AMcfKuF/G+ZaQdoTtMlD93JwR0wz7j/DLASNvpzPmkHLao8z6FD/zYQnzT8yMag==
X-Received: by 2002:a05:620a:2697:b0:915:cb40:f774 with SMTP id
 af79cd13be357-9209139526fmr2530174485a.31.1782163832704; 
 Mon, 22 Jun 2026 14:30:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2697:b0:915:cb40:f774 with SMTP id
 af79cd13be357-9209139526fmr2530157185a.31.1782163831714; 
 Mon, 22 Jun 2026 14:30:31 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fe7ba08sm323105935e9.11.2026.06.22.14.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:30:30 -0700 (PDT)
Message-ID: <5bbeb7ee-2826-453d-b50c-60240df47954@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] target/riscv: make some riscv_sysemu_ops TCG only
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-6-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-6-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xpQcH_SjuCI-F5g8-8Cbqlf0rg233y1j
X-Proofpoint-ORIG-GUID: xpQcH_SjuCI-F5g8-8Cbqlf0rg233y1j
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a39a97a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-2kRupl4sVHQNeYqIlMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwOCBTYWx0ZWRfXy/GqL7G6TYXj
 M9Qwm4zkj+sq/7YhByLARGh7+zc9w8KPSP7uPaX7Rk9QGIsspfPULH2IMZzJxMQllTEcEUULq9G
 LWz19SrX6ur6fyy8Vt1XAET8NHGaqXU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwOCBTYWx0ZWRfX6s7tFDDWKlJj
 +DASSktZDxD9TW5MJW1Y94Rjk2nO86Ogd8JKCqIMzseyh92ahHXzABviHqTULzxkGYPKRr/asbS
 l7/Hq/YffuabZZeDFPBEjMwJvjSIocQf2hJCNRdpwG6Pd2pmE8NPrHrY+xUqjb8uLDKCBUpqd14
 yEd/xG+Rf2Wehh4cuY1NbSIpOOxS8gU9L5TOAhBA30q9aI1Y/lhQ37FHv6eOGzji3eXiJEL/ipC
 +E1yscgfc84/NU4fHhy12c+/EDlTut1rHPNFgEpZq2Rw+VMYDpX5xDuyEpQs5z9I0v37f5+ih9J
 JVSCkac7ZuJn+2NBJYxrRm0xDFOl7EqFXxmYGY3uDiCmdrcaAX4q0fnUr8vJ450aCQLlAx3LQb4
 0PLkw+zUZyEfq8EBkyGVtXg14BM7HJs21ZNlgwWEunwScGv7tDhyA4jg3/coHEjk4QnjFQs2554
 mCCBNnqFcHa5e2LB+XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220208
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> monitor_get_register and phys_add_debug are TCG only.

They aren't... And get_phys_addr_debug() seems mandatory.

Maybe it happens the RISCV implementation only considers TCG?

If so, maybe this patch is heading in the right direction,
but its description has to be reworded IMHO.

(while here, maybe we can convert to SysemuCPUOps::translate_for_debug?)

> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c     | 6 ++++--
>   target/riscv/monitor.c | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4e96bbeb60..0a7e6f6ed0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2669,11 +2669,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
>   
>   static const struct SysemuCPUOps riscv_sysemu_ops = {
>       .has_work = riscv_cpu_has_work,
> -    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
>       .write_elf64_note = riscv_cpu_write_elf64_note,
>       .write_elf32_note = riscv_cpu_write_elf32_note,
> -    .monitor_get_register = riscv_monitor_get_register_legacy,
>       .legacy_vmsd = &vmstate_riscv_cpu,
> +#ifdef CONFIG_TCG
> +    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
> +    .monitor_get_register = riscv_monitor_get_register_legacy,
> +#endif
>   };
>   #endif
>   
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index 3e89dcaf7c..7aacd1d89c 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -245,6 +245,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>       mem_info_svxx(mon, env);
>   }
>   
> +#ifdef CONFIG_TCG
>   static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>                                    target_ulong *val, bool is_gprh)
>   {
> @@ -379,3 +380,4 @@ int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
>   
>       return -EINVAL;
>   }
> +#endif


