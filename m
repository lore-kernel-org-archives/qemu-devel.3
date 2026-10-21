Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D420606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nnzlrD4j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d0WRkVot
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJbC7-0001W0-8V; Wed, 21 Oct 2026 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJbC4-0001Vh-Lu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:37:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJbC2-0002IH-VM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:37:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpQTq2384285
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oJOgvISuOmaFt2hDqXyRxJ6owxwBdx7x8HYqJE5UbeQ=; b=nnzlrD4jm+FjqLda
 V/gDj8ROGGm3rSuWm5fWVRhjLisr7ld6cei5aFOCT5z3e8v1HvqGCTghueS5AvCt
 jDgSJVf34orfTTdeCL1sNDp4k+cIx3KO/x5pBrcYYItZxEO/EvuDPi+zYolSGQeh
 3aV8gCpDUNoAhJCclBELzvuIun6TuuLh9KXoJ8PeF5Jrg5vUvcXsx6MD/Gc5rV4Y
 lQhQR9SBd5kdjPBYMy3CF949ZZdCoPJdxnso9l6omoobbo6c69uiQW8WpYB/8269
 2B8D5MbAWznho4gojs8uYQ+826Sv453KhWu1cPYnIYdlSdcidixL4cf2O7iLGoJ6
 8x1onQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke0nw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:37:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-917b7dd3f1dso18813936d6.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792607860; x=1793212660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oJOgvISuOmaFt2hDqXyRxJ6owxwBdx7x8HYqJE5UbeQ=;
 b=d0WRkVotqtXlweBu3KegS+VRyZ2WZWSUrCtRgQGVEoZOONLX0hdtKrcnKj/KexcGl/
 JAxoCym4XMeLVJaVVdbTJ6vJ8B/4DsfC3BFhZqtGb1JFpbRJOHTXtYSQTylabVmgEKyP
 638v3oJq1iDRwnTP2HYTJvFJUdhspbo6QMsxn37xYXh41/FCYsjpdZhmg9UTnhVZHeEA
 /HCzJoMm2XQ4QEMelY6oNm25NqQ/aKNmMxslpXQph8CY3X5iD4EDD5ADfeD4ruAeH9NY
 CkIFGwLB2Z1g2rI8QMOEa0cW0greXjbqRaSp4iwHDZfu7hkaI8Ztvjel1DWjGDmwlgVH
 xDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792607860; x=1793212660;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oJOgvISuOmaFt2hDqXyRxJ6owxwBdx7x8HYqJE5UbeQ=;
 b=fBsCdlMENZNPeM7XnH0pEcYwrP2zCVLjWl/9a01z1QXlBp6HZ3aO5jWu/abB6MnQzJ
 pxmeZOm9bszj3NEHl0K8+7o03pS2iYUd9W3l9AIBM/A2B/DJksOtsnsVLXXxeAB4asIM
 SKkXjAvB2JHNakrJLF/fQaxyjw7hJqHnZLxgJv8XoytDjaeDhR69jTXyKol1fMMwyf86
 vlCir3asllA5mZMQ9Mds2b5d1pLwvdRmLQmo+lSB2XndvZEV1mrRPZUXsyTRDQ/AhhlJ
 J1gUNyfaMYhnS7euLg25qsA4O8yw8qtIt78zv1lGgzZRWostOxnPYGrn0f/m44H0fJmp
 V9yg==
X-Forwarded-Encrypted: i=1;
 AKwUvByIzgNmZ1fGE6Yo3NKftl6CZwlI+lQkqa3eRxYy5F1+u4fPgDrmRJEcnGykxcNHN/nsE2j9ANmE9kRZ@nongnu.org
X-Gm-Message-State: AFq9FYIyo53CCM8lwelM1HCNt56fKz+6hyYbTP3/rX31nUbCSqZNcNS6
 6IbFyCjL0J7JUwY/2xSpDPnx6uQMhaG/aFrbeHtVkgR4Jt6WaDwpriBkPaFmgyGW/rh+flW6i4e
 GCmohFYDN9+GbsFIDSk/JYWsGleMe+msiLfnL4jXnin9MX3Owlk6MQGsMJg==
X-Gm-Gg: AYBFou2ejCkz6LhCt/irR+J7t5QuOYAKhAaIXESyqcC9j/Z3t7XAabCGfhQ0rl0oqD7
 ZvNSbW6htyesC7sULoJXrWC9jAjiFI7mRm9g0IN3aUkAS75qFeLZVliBaSYheRaP7En3DAqw8XE
 GnevSft/JczWCGLLU/KwfuMdsd22AhEX7PmC2QHbJpbpNif+kmPB9N0XaXuIhyGpYHSjG08n0zD
 z2ovL+80ZscmiR5McT0iCDVtb8cYGCgjFnj62a7gyV4rA7Z7WH420dB/TaoMS9OttAomz7/W5am
 ay5qB8fiIouK8LO9JF/lnCVgUGgkeZ8wbMF0eL0oq82SZ96nkyzw/hrw9+STXT/Dt02ZNheq2/M
 oi2oeoOgCdxD4sR3vJ92JAehjVNyiGV3inwgxW+hodTkkt06Zm7jdvmeaVRV3oz6FmKhN7v3q
X-Received: by 2002:ac8:59c9:0:b0:535:922:ffe with SMTP id
 d75a77b69052e-5369b8c192dmr46128421cf.43.1792607859683; 
 Wed, 21 Oct 2026 11:37:39 -0700 (PDT)
X-Received: by 2002:ac8:59c9:0:b0:535:922:ffe with SMTP id
 d75a77b69052e-5369b8c192dmr46127831cf.43.1792607859022; 
 Wed, 21 Oct 2026 11:37:39 -0700 (PDT)
Received: from [192.168.68.101] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10b71583sm31298336d6.15.2026.10.21.11.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:37:38 -0700 (PDT)
Message-ID: <0c88604e-39c0-4398-9942-f5a69d195af3@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:37:34 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/riscv/sifive_u: derive PLIC contexts from the
 harts
To: Ralf Ramsauer <ralf@vmexit.de>, qemu-devel@nongnu.org
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
References: <20261021110838.3097959-1-ralf@vmexit.de>
 <20261021110838.3097959-4-ralf@vmexit.de>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021110838.3097959-4-ralf@vmexit.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4uXHSjglTSJSLAr_cEV9xOX0-cYHAbQh
X-Proofpoint-ORIG-GUID: 4uXHSjglTSJSLAr_cEV9xOX0-cYHAbQh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX+lUhaKXep/tZ
 vlpBarTBnF0wOu7Vt4Cgdc7tY7BO5fEp4ytyXv/gSdbG6iLtN1wPSqf6JCG8aR+d7whu+6L1xTV
 ti/TRxlVERnJYcexqgK4sScS4qrZEic=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad90674 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=N2i0JmwLw9FRYmOpwrkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX9rr8Pm0RGBAL
 mb8CQlt9CK0MZM5MQ2iX4Q2pE+TB53W/IIDbUjNW6vEyAd3lVM/AOHUz7BtuOXIiJ2bfxA42/i7
 vQh2mgZCpkN1TSdFBjjNzS2q3ltWLWJipkw0c4M25p8ghFlaE5fu3EeIufAUp/Yqc2ksokUC+15
 sguVtqI0Lm7Om/i4GYu/EEwexxZY3Y1wkoMox8xFwYycct0ON6rfezwcPs9+lYrUctcUZd0T6vP
 90CSS5x/UhdhcT3GFRSVKxhGXezrD7iH0mniLDl2gLUD3dzQYalNzfLbV+6X0GD/Jn+WWSPlA1h
 BNjMs9YiNtrMByioN8Mmy+MGNXSJ7ZRseffYcPV+JV3zlWGQi5qhehKZPevPAowunfUFQO8Gz/g
 YQSUmhtqPjR+ABLvxHP2JHwKgjSKfxLViqj9JR7i+IOdDl/em42O8zDPGNG9yQ97jAzjC/zKG9R
 ms/mpweYy17I2TiWUsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210074
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



On 10/21/2026 8:08 AM, Ralf Ramsauer wrote:
> From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> 
> The PLIC device is created from riscv_plic_hart_config_string(), which
> gives a hart a supervisor context only if that hart has supervisor mode.
> The device tree instead hardcodes the fu540 topology: no supervisor
> context for the management hart, one for every other hart.
> 
> Both agree as long as the application harts keep the default CPU type.
> The board sets no valid_cpu_types, though, and passes machine->cpu_type
> on to the U cluster, so -cpu rv64,s=false,u=false builds a PLIC without
> any supervisor context while the device tree still advertises one per
> application hart.  Contexts are numbered by their position in
> 'interrupts-extended', so from the second hart on the numbering drifts
> apart, as it does on the virt machine.
> 
> Ask the harts instead of assuming, like create_fdt_socket_plic() does.
> No change for the default CPU type: the E51 management hart has no RVS,
> the U54 application harts have.
> 
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/sifive_u.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b7d5e7b4da..8f50c67a14 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -99,6 +99,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>       MachineState *ms = MACHINE(s);
>       void *fdt;
>       int cpu;
> +    RISCVCPU *hart;
>       uint32_t *cells, cells_length;
>       char *nodename;
>       uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
> @@ -195,18 +196,18 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>       g_free(nodename);
>   
>       plic_phandle = phandle++;
> -    cells_length = ms->smp.cpus * 4 - 2;
> -    cells =  g_new0(uint32_t, cells_length);
> +    cells = g_new0(uint32_t, ms->smp.cpus * 4 - 2);
> +    cells_length = 0;
>       for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
>           /* cpu 0 is the management hart that does not have S-mode */
> -        if (cpu == 0) {
> -            cells[0] = cpu_to_be32(intc_phandles[cpu]);
> -            cells[1] = cpu_to_be32(IRQ_M_EXT);
> -        } else {
> -            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandles[cpu]);
> -            cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
> -            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -            cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
> +        hart = cpu ? &s->soc.u_cpus.harts[cpu - 1] : &s->soc.e_cpus.harts[0];
> +
> +        cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> +        cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
> +
> +        if (riscv_cpu_has_supervisor_mode(hart)) {
> +            cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> +            cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
>           }
>       }
>   


