Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76654C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8t6-00079W-76; Fri, 25 Sep 2026 12:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA8sy-00077z-L7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:34:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA8sw-0001pQ-VC
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:34:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PGKY0n1711435
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pnkjJ6iJd7jmbHtPLg5O2ybsJ6JSuZtDibMHamcaJ0c=; b=KBe3yFnXFAClZAWN
 r3iYKJVUHF2VJi1B1gus63C0QVQjVQEO6HjL1uXh2C4xpWz8qgMaJa9L4zSzu+Qf
 N/ebOtjbMC/LBPtp8W1nX1YkHz/zWFlUXbugTjj+crJrYZoFlp6XQ2bWq+0864Zi
 aYonsYS+8llRnFxQmB+GKT9WUY357K/wWKKecgTG8farVoQ4MDsF91a7XDCczsk6
 Coia/DC+FiKRixQ76f8SieT5Bbpj0JL+zlcuQxLh1oSb4NxOf/nYAWD8RrWcfFXZ
 93NQ3Cn3/iB1g15LdNllGOaMrlIkPh3cSxKVh38h+1fxvWY0EzqVspz6eGBkuA6l
 ZO/FFQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvd3r1m0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:34:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-532c2cac078so16802971cf.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790354092; x=1790958892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pnkjJ6iJd7jmbHtPLg5O2ybsJ6JSuZtDibMHamcaJ0c=;
 b=enb30IXW092acYqAMmxNYcre7ANKDbhyBcuYGIpwtT0EzY++lREFWyoAVQDH2g6roW
 RWa3gO8rm2Z30xoAvkhESHYzU1pOYs0JCH1GN6LDkaJ7pY6i7ypkW+QBxqHJZ13ZX+Ak
 L7Yxy9TeiOwBG4d8g1kv/+KHT5b1gHKwPM5qwH0YIg56Wgl/80XPUz/dJJkHtzJtA07u
 +EWAr6SjHVF1ryP8Yrbka6i+jvVbIBx9zRcqhb9CeURQI313JPJH9//24XD4Au6AyF6S
 KraNB3caDgPEpYOuKwY6fNh7XuthwzSrnbJU4rl6fp1JDWlAYyA3NT16h0qImC/EDPDV
 ZbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790354092; x=1790958892;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pnkjJ6iJd7jmbHtPLg5O2ybsJ6JSuZtDibMHamcaJ0c=;
 b=mx73mJbZmlwukvF4fCyktnVNrtxXF1pyeJazIRa4LWbhVYVPFJqg1a9JxpeZXwJW6I
 9bLHP6kfyHUcd3T/2RcSDlUDNSkA86imsk/HGcRLKfLAzLuq0eAwhC1YWKwjsHpOIp80
 6/UIbH/hLxWwmfJPpIPUDFdYpRj3giv++DSZlOkRERmk2Ep7SLjcRUu/CEtHiivF45HH
 nUh7SNDugFYf2XZAy0hCy0EZU5IGO3yNQ+YWj3XGN0WVNd0jHEOPGeoWogT5yvliOj12
 fm7O0vHv4QrW+VCjOIySEpQdvkKX7ULgo8Xv/QV0vIJhIMR85QMbdD1ADO1bIMggVqa/
 bfzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6/a/jIyb272/TF5s+DI7y3nyaA00Sa0FXogMODRnOFK96KUXRDZFw7h2TW/fN333iDfiNKC9bA+M9@nongnu.org
X-Gm-Message-State: AFuF++mchdVeXjPl6DPhBBlAoJBskAlcklI5aAMDZZxYCJQ5H00R25CK
 f53gZAyz6X5F1CPCJDzoM8QrJXCLFPwjop57X/ApexiuukcLlLMMIqy+sD9aI+jF3AIPK6PKWVn
 WPy+TNhmqITauWGqXKasRrNoLUyuXTtlUILSroKsIHpW9I7+sGlNkZQY8ow==
X-Gm-Gg: AYBFou39NKhh85WqC/ncV6e8yoh0SMoVfiQdtDWyTGNyx+0wqLYp4XpPmrIr4O5fYOM
 K3eDA3WQuonD0E0vr1E3ipsF8GCpZOHCscywiWM+Ib4SaFeQqvKYCxcZu6zMvGUnBAmMjcsYeBi
 dz3W7vIIzJW9q+QJkG81l6jCafKB7LD1/EyqB/VDXiDqc5IgMm6ym6afqQMv03AVI/m6H8/UWn/
 Sefpbz75AmdJLMxy4bWPTZdi2oYsZbcA14yapC9A1lwMnMwjAixq69NgagDIc6xoZMo5fwIsUGO
 tlu4x4NiO3mjxrBHQoexiHX6LnWWW7RYXgEVk0989doEKuyXQ0P8L3zcoi5F/RBgmHcAjlb2+Dn
 xulPv9l69n8Be2wVjFMFaAF8zClB9lML9zQ==
X-Received: by 2002:ac8:5d4e:0:b0:532:c82e:7481 with SMTP id
 d75a77b69052e-5330b6d2c68mr56815621cf.51.1790354092524; 
 Fri, 25 Sep 2026 09:34:52 -0700 (PDT)
X-Received: by 2002:ac8:5d4e:0:b0:532:c82e:7481 with SMTP id
 d75a77b69052e-5330b6d2c68mr56815081cf.51.1790354092042; 
 Fri, 25 Sep 2026 09:34:52 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5330beb3a81sm18546511cf.5.2026.09.25.09.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:34:51 -0700 (PDT)
Message-ID: <ac765b6b-15bc-4063-972a-33698f1fdb79@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 13:34:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] target/riscv: Process PMU timer expiry on the
 owner vCPU
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-11-5da5159a0c64@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910-riscv-pmu-correctness-v2-11-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TNz2v8VNQYSYEHrg477KyHkcQkvIEAlK
X-Proofpoint-ORIG-GUID: TNz2v8VNQYSYEHrg477KyHkcQkvIEAlK
X-Authority-Analysis: v=2.4 cv=YL4KWhGx c=1 sm=1 tr=0 ts=6ab6a2ad cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=VsVoKZ9dl8H_e5NpkdEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX4k7QeEhkLa0J
 fgot3w+x7pEhYC/lKLzqOQ90RE0urcdmkXqCqmu5DKLCzfN83BICkClU2Wxm8UPR0Og7Fyh8ClM
 98vcHhihmTi5UZMHIoFYNYjC0OMZB4E/4Cgy6qnYz+NPLp956y56BUWLL9uFedoSOHp28WZCh6a
 QTpyRd+sU07pYMCWtaQiSCC/9hMYXnOMdDW7JJ4X54ApHrcsxBLgGLF6URZlLSaP33iGXcWV3a+
 rjrT0ZbvN4P6D9gOwWp2O7yUZzM6oSDYr+A+Mp2+H/zORpsl2MKcheZptyKo0kXmqSOxTcfc1NU
 oxxejqNpSltIwcRqXNpFaMjVisLE1WCFkr7zLzZHoc0SawPMsLN/9JMX/o3rs1vvxldJVQqHAWU
 uGUnLAQSEshhkrtgkwdy83oSkbAW3bG6hkQbAFWQ7uN7HCeSHh5Fhd4agjE4r5+F6Ee0yAbzMJ2
 JQsvtYLRS3uWz0bOf7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX4nu9oYSbbHjd
 BLe+YP64mggxnkr3Bo8mwwsTE7fIX2qFDVsgFSjrRxk99qSUks7vm9pJKK01lDV0ggTMSYqG8oo
 EAYEKyKcvdTe/9NVSr0V3FNogpmJSio=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 9/10/2026 11:39 AM, TANG Tiancheng wrote:
> The PMU timer callback can race MTTCG execution and CSR writes while
> reading the event map and updating counters, OF and MIP.
> 
> Queue counter checks on the owning vCPU. The callback atomically sets
> pmu_timer_work_pending and queues work only if it was previously false.
> The vCPU clears the flag before checking counters and rebuilding the
> timer. Earlier expiries are covered by that check; the first later expiry
> queues another check.

In case a v3 is needed:  s/expiries/expires or even "Earlier expired counters"


Otherwise Alistair can amend it in-tree.

> 
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   target/riscv/cpu.h     |  1 +
>   target/riscv/tcg/pmu.c | 18 ++++++++++++++++--
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 17b9929785f668487d2ec851b736d588e025fd91..a4d33f55c4e5cb6052cea6bee4c0afa46372b5c5 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -583,6 +583,7 @@ struct ArchCPU {
>       QEMUTimer *pmu_timer;
>       uint64_t pmu_timer_instret_snapshot;
>       bool pmu_timer_stalled;
> +    bool pmu_timer_work_pending;
>       /* A bitmask of Available programmable counters */
>       uint32_t pmu_avail_ctrs;
>       /* Mapping of events to counters */
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 08298010b6d06f5792fa14ff81fe2f7a28c6476f..6286552a4ebf614df0252f84ddfadbc25d8d2258 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -663,15 +663,29 @@ void riscv_pmu_rebuild_timer(CPURISCVState *env)
>       riscv_pmu_rebuild_timer_internal(env, false);
>   }
>   
> +static void riscv_pmu_timer_work(CPUState *cs, run_on_cpu_data data)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +
> +    /*
> +     * An expiry before this exchange is covered by the following counter
> +     * check. The first expiry after it sets pmu_timer_work_pending and queues
> +     * another check.
> +     */
> +    qatomic_xchg(&cpu->pmu_timer_work_pending, false);
> +    riscv_pmu_rebuild_timer_internal(&cpu->env, true);
> +}
> +
>   /* Timer callback for instret and cycle counter overflow */
>   void riscv_pmu_timer_cb(void *priv)
>   {
>       RISCVCPU *cpu = priv;
>   
> -    riscv_pmu_rebuild_timer_internal(&cpu->env, true);
> +    if (!qatomic_xchg(&cpu->pmu_timer_work_pending, true)) {
> +        async_run_on_cpu(CPU(cpu), riscv_pmu_timer_work, RUN_ON_CPU_NULL);
> +    }
>   }
>   
> -
>   void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
>   {
>       if (cpu->cfg.pmu_mask & (COUNTEREN_CY | COUNTEREN_TM | COUNTEREN_IR)) {
> 


