Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C967606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ea1w4fTy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jSOs+Hsg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPRC1-0002NY-9m; Fri, 06 Nov 2026 16:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPRBx-0002Mu-H9
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 16:09:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPRBv-00031m-F6
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 16:09:45 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JLDY33254412
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 21:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e2YrQjyFUxkII149OdfENGvKLB8j3GDSUxcOdOhJkGI=; b=ea1w4fTy3yYtDM52
 Yq00Fm2AcOZMgO581FiF0QCEgdo3qVHAPSfChPkIeliTSmO2vUVp3WSyscmJGUqf
 mZyJZScFw8/pV8DoxlIL5fzCdu6iFIFMar5JVk3nqRriikDkUlBiFsQsaSVBccjg
 J9oJbCPqpyFKrgMSmfA9fC2riIL65JOCJeM+3QUKm/iX89Fe7ylSpj1V/WN4HzEi
 MPLJy18y8Uqdm71tkoVm+pplKZidkPhX9HFba4kE9nRFMf+DxqnR95QrY1Odlmg0
 E0ik2ExHOSgqRDuXY4wgtO8czEhHXI22ztc/YdBgtDTUPPulzLTeiOH8PK2Ir6k3
 SOGmew==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyqrbmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 21:09:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c7bf2d734so23424466d6.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 13:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793999379; x=1794604179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e2YrQjyFUxkII149OdfENGvKLB8j3GDSUxcOdOhJkGI=;
 b=jSOs+HsgB6F+qvmoR6JXfOELFYF0t6c1pN13IPrbHYBvb9OgEHKF3+Lx1J1Pd4t3yy
 aVA/StxZbYsyzPzn9BXMJ251PQRA0Pqx8yjs9qcMsjNxGS4yfL/ralbbs6WvV8V5qJjx
 job1tbTQBXp8mPhKofwOIBz3COWMoMVKQVUJPDEq4jL8ZJB7xJcbbMo14BgIvJatuFoG
 +F5mFRCe4ZKK+wPWB0OqNQHSMHkL+SZWGf8/vNeH8X6rZl0pBAbhejbUkgsIFS4+HUya
 MUnTWWaPQRzqxBcbvFvftACj/VPQV6uZQ6uVbNxPVbcLxA/sT6cd6UKPmZUqW4SAG743
 8bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793999379; x=1794604179;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e2YrQjyFUxkII149OdfENGvKLB8j3GDSUxcOdOhJkGI=;
 b=UwIZr98HN8q4IjussfrNZg0w7vrS6JhWsvs1l4kRdS8YcUzoWoO5i6VgHt30F3EJys
 o40jH0f25kIJZx+M2bK+M3fwEW/FSfrJe9sTxBIbOKmKILkemKAw8pChYn22OWj+VUdb
 WpOgSmxK+Sixa4JqyQwC4PyKUZd5vHbgqAg77rxpOGBg6PrNuAvsXifzaqlePUTwgTaZ
 RJ9w8yx+Y9IupYHvS0BcjfP2wQJM/WF5+XCsMjEdXvC0jMUbHWx/UFMDjS+xOZb8E6lP
 vYopCP6KtGxN69rqA3r+kRTVHJ4kGraqSR+wOrrVAB8S+vbAgbLYJxlHLKVZwsNedAes
 scSg==
X-Gm-Message-State: APuU4Z+LuW0+KIWUlSZBgrnJV4E+FdrY19umoqHwl0UVNmB3lmkuYAYU
 hAMIJRE8A8WNvlYyYsPPLsyquCTcUYbJof6hYi4JpjKW/YTug/E7I7CXjZ2SCquFFa/QwqXlqdB
 y1ltDFruTz9Tg7aq7EV4Dulw5O6p7ce9GMKw9wCw6nIVNCOEy2ReMQNt4cA==
X-Gm-Gg: AYBFou104fqAJbos579sLHxZhhr+yCrPQUe8v9qWq32OBgbbl0sO93nA+sqb/RHkuxr
 8fuypZfUZ1YjuLaKwmvHYK6W0EuaNoRVQ2pQryN0pQ1RCgvu8Vd5BeHkzlOixH3wDGYnmAs6wT0
 H7FGvYx/u8rHvusEdp/pmk/hLXZCTicqWQtm8v34xURuIuvPMB8sEyE0cqodflXENAFRmI5C/g9
 Q5iv+uNJRTFhK3PEKfgTYpWbhylnFV3daGD+33iARXnLpw7kK11HeVJu6j59o4h+m/IEHxdw3fz
 1d6RFLdgveLYmoXFOVoRHFThhJdbRaQeb6V3dR/ZvjE9kNdKDa8bWu0IO+tsteuTbBBiM90AlR6
 V0JyuasOXsUEguFRL70dAdtyn/LFCL97INCIpYb8+45Ew+mUBskrBBboW1HDUfsY8EyJLrc0Fom
 PPJx/gm/3R
X-Received: by 2002:a05:6214:5099:b0:917:aa8e:474f with SMTP id
 6a1803df08f44-91ea979271dmr53392706d6.23.1793999379397; 
 Fri, 06 Nov 2026 13:09:39 -0800 (PST)
X-Received: by 2002:a05:6214:5099:b0:917:aa8e:474f with SMTP id
 6a1803df08f44-91ea979271dmr53392316d6.23.1793999378952; 
 Fri, 06 Nov 2026 13:09:38 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea6acc4a7sm28897936d6.44.2026.11.06.13.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:09:37 -0800 (PST)
Message-ID: <3f8c0c2c-208a-405e-9c7d-8a9fc90f9cfd@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 18:09:34 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] target/riscv: Capture Sspesa sample PC and
 counter ID on overflow
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261029131011.3715081-1-mayuresh.chitale@oss.qualcomm.com>
 <20261029131011.3715081-3-mayuresh.chitale@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029131011.3715081-3-mayuresh.chitale@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: J51ga3ihhNuVmvQFd5yd0f2PtrYkwgU_
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6aee4214 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=q22TOjIvAmAaVgBwKQYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4NCBTYWx0ZWRfXzjQPMI9n3GDy
 U5tXxAVIW8gLRK0RZgwsXEF6oxao7S0DrnAz/FUPghJHrgNs4FUD5SnaiqiFD2XpAR2LcFetJdL
 gjPFuKzhIYsc4+whi5l7SOv+lkw0YVM=
X-Proofpoint-GUID: J51ga3ihhNuVmvQFd5yd0f2PtrYkwgU_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4NCBTYWx0ZWRfX8dkm0TmrD2Cs
 7xi/uTm1jvucnSBytEmyaniZVxiVMnIljK/zk9fFLLUlLDmIMNtgaFEe4YKLLIzC7dxdQNbNB/R
 ilD1UfJjO6875zwHD+cupBmed37p+R5kxmbvnRSyY9znL3asQrzZ6Cqj8tT57nJH3uhGNzeMMDS
 3ZBlhHcnNAPsF8jWDu+s0KyQraM9v9aEtOMvIGkx4ryY0y5/Gf8Ecuf28Y2Ke3Cv/WhTAa/53eh
 +G1QezLkscpt56+F8/DqFDU8Evi54f5FuN0jqHK14SQDx9dEuJwqcWx3ROoDoXQeutlRHE8B8ni
 VQB7cTucLJxehgVFKvfhBAJNp/cHyuBc9I3rd8szN503TNqhMLDIOgdzCikbEp2DsWN/lmaFync
 neMtm3/ZT09o3xwz8T2DgPXHpISg1vWhCJkb62H1pw24Z+SPtypNFEc3X6HDZ6mkZ5YU4EoLk+4
 Q/BvZoMQiUGZbBm5doQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/29/2026 10:10 AM, Mayuresh Chitale wrote:
> Capture shpmspc and shpmsdata just before updating mip.LCOFIP.
> As required by the spec, record the current PC, counter ID and effective
> privilege mode. When supervisor counter delegation is enabled,
> only overflows of delegated counters update the sample CSRs.
> 
> Preserve shpmspc and shpmsdata while LCOFIP remains pending so later
> overflows do not replace the pending sample. Currently, cntrid is not
> updated if two counters overflow simultaneously.
> 
> The captured PC is QEMU's current env->pc, so it provides best-effort
> attribution rather than guaranteed precise attribution.
> 
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> ---
>   target/riscv/cpu_bits.h |  3 +--
>   target/riscv/tcg/pmu.c  | 39 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 61258ce6e1..e99da434d5 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -642,9 +642,8 @@
>   #define SHPMSDATA_CNTRID    0x1f
>   #define SHPMSDATA_MODE      0x60
>   #define SHPMSDATA_V         0x80
> -#define SHPMSDATA_MODE_U    0x00
> -#define SHPMSDATA_MODE_S    0x20

These 2 macros were added in patch 1, never used there, and are now being removed
here.  Let's remove them in patch 1 instead (i.e. never add them in the first
place).



>   #define SHPMSDATA_VALID_MASK (SHPMSDATA_CNTRID | SHPMSDATA_MODE | SHPMSDATA_V)
> +#define SHPMSDATA_MODE_SHIFT 5
>   
>   /* Crypto Extension */
>   #define CSR_SEED            0x015
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 1a4658319b..31edd31117 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -178,6 +178,43 @@ void riscv_pmu_decr_instret(CPURISCVState *env)
>       env->pmu_ctrs[2].mhpmcounter_prev++;
>   }
>   
> +static void riscv_pmu_sspesa_capture(CPURISCVState *env, uint32_t ctr_idx)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);

I believe this is something we should document somewhere, but env_archcpu() is a
not the nicest call to make and we would like to avoid it every time we can.  One
of its main usages back in 2023 was to access the cpu->cfg pointer to check if a
given extension is available.  We ended up creating an inline called riscv_cpu_cfg()
to allow access to the CFG struct without having to call env_archcpu().

So, if the code doesn't do anything else with the RISCVCPU pointer aside from reading
cpu->cfg, we recommend using riscv_cpu_cfg() instead.

For this code I suggest not using env_archcpu() and:

> +    target_ulong sdata;
> +    bool cde, ctr_enabled;
> +
> +    if (!cpu->cfg.ext_sspesa) {

     if (!riscv_cpu_cfg(env)->ext_sspesa) {
        return;
     }


Thanks,
Daniel

> +        return;
> +    }
> +
> +    /*
> +     * When supervisor counter delegation is enabled only overflows of
> +     * delegated counters update the sample CSRs.
> +     */
> +    cde = get_field(env->menvcfg, MENVCFG_CDE);
> +    ctr_enabled = get_field(env->mcounteren, BIT(ctr_idx));
> +    if (cde && !ctr_enabled) {
> +        return;
> +    }
> +
> +    sdata = ctr_idx;
> +    sdata |= env->priv << SHPMSDATA_MODE_SHIFT;
> +    if (env->virt_enabled) {
> +        sdata |= SHPMSDATA_V;
> +    }
> +
> +    /*
> +     * Only the first overflow that raises LCOFIP updates the sample PC and
> +     * metadata.  Currently updating CNTRID on simultaneous overflows is
> +     * not supported.
> +     */
> +    if (!(env->mip & MIP_LCOFIP)) {
> +        env->shpmspc = env->pc;
> +        env->shpmsdata = sdata;
> +    }
> +}
> +
>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>   {
>       uint32_t ctr_idx;
> @@ -211,6 +248,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>           /* Generate interrupt only if OF bit is clear */
>           if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
>               env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
> +            riscv_pmu_sspesa_capture(env, ctr_idx);
>               riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
>           }
>       } else {
> @@ -403,6 +441,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>   
>       if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
>           if (pmu_hpmevent_set_of_if_clear(env, ctr_idx)) {
> +            riscv_pmu_sspesa_capture(env, ctr_idx);
>               riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
>           }
>       }


