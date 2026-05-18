Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D96CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwy4-00016L-Iq; Mon, 18 May 2026 08:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOwxo-0000zb-Fh
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:20:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOwxm-0006G5-EF
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:20:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I77ivT756636
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WyckBP08/sBIuV8gRx+1nVHE8ygGEez5/s4uENr6iJE=; b=A5PEQI9QcdHMLoQM
 5nupbNlQT3YoyHKTHOQbdx3MWJ29NC0oxZiX9KgFWp6u0CBr/rR7ccxY9jmB+twJ
 L0joVzbTsII8SUtxwd3Je/qJysnVFW+s2CgNqQVBZIrKU5VyRQjJsCXGkD7yTdAA
 UpJU/uQjSfYsS6pPvTc2umzuPiVaYrjyMdEg9ynKlPPtT6nQWfYhnEA6yiD/YWPe
 JcnzXoODXR9Y8sohcbw1DqXp/zhi+k/Ff0T8tJ6sE/nyIg5b7CZHG9Ihx+qleN68
 3Nbl9ta23F+fgL7Od5s+xFO+t8K8Ay/qm7q3ZenRhvwhXKLUJzIHHcbh7s0Lh0jC
 1AY7ug==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvcn8pb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:20:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ca1eb491d7so63449266d6.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779106846; x=1779711646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WyckBP08/sBIuV8gRx+1nVHE8ygGEez5/s4uENr6iJE=;
 b=FqEb2dSwaK8okIefxsSzeczXJOeOVd6feHxUksu6calhmKJGcrCAJdOmZz0lJu6f9P
 kOHV4TnsNyiYJpPVKd//3z1d7KPg8uXgjvv1SwbHRdhC+u3XwegV7bPx01ImUZGbejjs
 iFm6lFKetUKBMUPrFR5j9CFAzvBIs10x2zOg8zkKQhHRSHlgtrJZAsqnmh5mtkWi/Lk0
 ZOLtW8Dwiu6W4kUqELYVrYgCmK1NA3s7iqvI/yOomEIWfVDAi5XX9I45NL9AKm4qwe0I
 Xsa+eLoVk2AUOR2cgNjqwjTQ91C55/HNjjTkbTduMRMO147ThdOTalr1SGUQa1Tx61EP
 O2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779106846; x=1779711646;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WyckBP08/sBIuV8gRx+1nVHE8ygGEez5/s4uENr6iJE=;
 b=hrXHCk36xRYT/plkZE+QzeAJzFG2udOOHMQ/JcKIDzKUz+kQTAkm7cnm7vct6D+xO5
 Q0GGFoQ+lOJhF4aiJXpXdqLRrPSt8tcQj3QMZ8UpFv74HY8DVuhCawqPiKkyOULiMPAp
 nl+11+jB15mBTgRT7MwD02CW/VlLgvfPvS8LKbUljC+F/hb7wxHkFjREOHymZa5SEqdw
 jnlv4pB9JrY82J2uS1D7AQGmNOKebo9IWKAF7OJfmEpd9QnhvU7rrGghRJ6zXZaLnCw2
 7TZZeLoK4XiSnrNSgiPu999LN+ohOu19qPmmYbuq+FUh4j4cqBn+GlMimR+pBFxKYgEh
 JpPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pS+I4tb1g7hecHfBUtBM5zvHGp6cZF29ZfS+opQ1xzdp6GNnQ5+Y3dWTEmeMCu75IbCe7pwpILIEy@nongnu.org
X-Gm-Message-State: AOJu0Yw+kU2yXkw4CietYHS1BqsBWnBFucR5Ypp7BvkG/mYboUAteD8G
 6jNAVD5gSRQxV05bjszHT4dyAc00IT/uJECMMqjrbo9vHbKjRPrtkoM9kcnHfPZXQb6/N4vQ8q0
 IpPaQDur5vNrethOd8qhEEOffQcYmsuUD8JzNP33ejJfFKEU2lefo3SUJaw==
X-Gm-Gg: Acq92OEAQVXSHtQvihA4LYey7aQgYd37ugnANDjnz1UR20bXDSNAJjQJtp8cq9aQhbm
 Gbamx87s7q+t/SCMWANubKhhj9AM1Ksz4ucGdgVqAcq3xv9aiGYxtSfAqA/t5lA6XMvQHtybEXQ
 jG0T/3HVImRP0Bq7KcHWaUXrHMM4GeBlf4za6SYYLmbCl5b2NLuO3aGBr6YRQTtE89IWtZ3yYqV
 PKrxvcGllGYrKeI9AyqmkCrJy5mJPtgxOREYYvHA9T6x3+82xAeTkecoGz5dlCltJ/Ym8MLdBEv
 qLRcY2SLT4hcN+WwSSfYIaGuga/QWolnWPaY0wRgnCQAKofxxjJqLqdF4eHthDJgiCtPF1Jt4jO
 mrt3fCSqI20m1eEzwHy8qVK2zT+wyyrSP5a2QSMAJu+wsoSPRH6g8r4GBUgU=
X-Received: by 2002:a05:6214:2342:b0:8ca:190c:8ff4 with SMTP id
 6a1803df08f44-8ca190c9a80mr200000116d6.33.1779106846190; 
 Mon, 18 May 2026 05:20:46 -0700 (PDT)
X-Received: by 2002:a05:6214:2342:b0:8ca:190c:8ff4 with SMTP id
 6a1803df08f44-8ca190c9a80mr199999386d6.33.1779106845595; 
 Mon, 18 May 2026 05:20:45 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca36097a26sm54130606d6.17.2026.05.18.05.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 05:20:44 -0700 (PDT)
Message-ID: <c2820023-28a8-4219-8c20-d7ecbbb88eea@oss.qualcomm.com>
Date: Mon, 18 May 2026 09:20:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/intc: riscv_aplic: add trace events of APLIC
 read/write function
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
 <20260428160103.3551125-5-jim.shu@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428160103.3551125-5-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f9ewFfHmVS5RFJvVjl-OshV5ONT3gbcq
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a0b041f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=vi5uu3yPI8l8lTwkUGEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: f9ewFfHmVS5RFJvVjl-OshV5ONT3gbcq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExOSBTYWx0ZWRfX8Uo+JXfuQ8ZQ
 EuLbMlv0OfteOJ2hh2aM6WcTs42Y1qmg3H4Vt7Dzbl3COHlEnJCti9NPASgGCzGBTQePGZ54Mks
 5mn1+la9tCmBsBM1FZY5NHVl9JHZIvKWlYgjxASiYYfqs1FOGn9DqntPvOZ1G3MqZkiYIxaYbg1
 ZKNwgTFRvI3xQE4Bfu18trw2ViI4PpSzeepXZ9BxRZ8mi8yrfjgPMioxhMcA8mf1vfnOG3grek5
 csKbqB7Mq396ulrlMVkfsokuy6D3s3z/Vb/guWL79RAB2nnRqNNRuVOz1abEZE58qVgeFlIhoLN
 X4/c2R7SdB/vxQmgo20gqukmmlAxEn4waQ2l4h5jMELzVWR+HVTp7goEoF4jx14Iqt7xlt2Trea
 VTjPkwDP29eo65FDLKWSJSlYiBogWqFY5YSxmgvAuuHImxsTrbI6USr4Bxi4H6wodTSI8UGoDDk
 FCIPyJX+UfpBk4dOJeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/28/2026 1:01 PM, Jim Shu wrote:
> Add the trace events for APLIC read/write functions.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/intc/riscv_aplic.c | 63 ++++++++++++++++++++++++++-----------------
>   hw/intc/trace-events  |  4 +++
>   2 files changed, 42 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index a04e0e1a898..55515d1a085 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -35,6 +35,7 @@
>   #include "system/tcg.h"
>   #include "kvm/kvm_riscv.h"
>   #include "migration/vmstate.h"
> +#include "trace.h"
>   
>   #define APLIC_MAX_IDC                  (1UL << 14)
>   #define APLIC_MAX_SOURCE               1024
> @@ -626,6 +627,7 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
>   static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       uint32_t irq, word, idc;
> +    uint64_t val;
>       RISCVAPLICState *aplic = opaque;
>   
>       /* Reads must be 4 byte words */
> @@ -634,18 +636,18 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
>       }
>   
>       if (addr == APLIC_DOMAINCFG) {
> -        return APLIC_DOMAINCFG_RDONLY | aplic->domaincfg |
> -               (aplic->msimode ? APLIC_DOMAINCFG_DM : 0);
> +        val = APLIC_DOMAINCFG_RDONLY | aplic->domaincfg |
> +              (aplic->msimode ? APLIC_DOMAINCFG_DM : 0);
>       } else if ((APLIC_SOURCECFG_BASE <= addr) &&
>               (addr < (APLIC_SOURCECFG_BASE + (aplic->num_irqs - 1) * 4))) {
>           irq  = ((addr - APLIC_SOURCECFG_BASE) >> 2) + 1;
> -        return aplic->sourcecfg[irq];
> +        val = aplic->sourcecfg[irq];
>       } else if (aplic->mmode && aplic->msimode &&
>                  (addr == APLIC_MMSICFGADDR)) {
> -        return aplic->mmsicfgaddr;
> +        val = aplic->mmsicfgaddr;
>       } else if (aplic->mmode && aplic->msimode &&
>                  (addr == APLIC_MMSICFGADDRH)) {
> -        return aplic->mmsicfgaddrH;
> +        val = aplic->mmsicfgaddrH;
>       } else if (aplic->mmode && aplic->msimode &&
>                  (addr == APLIC_SMSICFGADDR)) {
>           /*
> @@ -657,65 +659,74 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
>            *     only zero in at least one of the supervisor-level child
>            * domains).
>            */
> -        return (aplic->num_children) ? aplic->smsicfgaddr : 0;
> +        val = (aplic->num_children) ? aplic->smsicfgaddr : 0;
>       } else if (aplic->mmode && aplic->msimode &&
>                  (addr == APLIC_SMSICFGADDRH)) {
> -        return (aplic->num_children) ? aplic->smsicfgaddrH : 0;
> +        val = (aplic->num_children) ? aplic->smsicfgaddrH : 0;
>       } else if ((APLIC_SETIP_BASE <= addr) &&
>               (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {
>           word = (addr - APLIC_SETIP_BASE) >> 2;
> -        return riscv_aplic_read_pending_word(aplic, word);
> +        val = riscv_aplic_read_pending_word(aplic, word);
>       } else if (addr == APLIC_SETIPNUM) {
> -        return 0;
> +        val = 0;
>       } else if ((APLIC_CLRIP_BASE <= addr) &&
>               (addr < (APLIC_CLRIP_BASE + aplic->bitfield_words * 4))) {
>           word = (addr - APLIC_CLRIP_BASE) >> 2;
> -        return riscv_aplic_read_input_word(aplic, word);
> +        val = riscv_aplic_read_input_word(aplic, word);
>       } else if (addr == APLIC_CLRIPNUM) {
> -        return 0;
> +        val = 0;
>       } else if ((APLIC_SETIE_BASE <= addr) &&
>               (addr < (APLIC_SETIE_BASE + aplic->bitfield_words * 4))) {
>           word = (addr - APLIC_SETIE_BASE) >> 2;
> -        return riscv_aplic_read_enabled_word(aplic, word);
> +        val = riscv_aplic_read_enabled_word(aplic, word);
>       } else if (addr == APLIC_SETIENUM) {
> -        return 0;
> +        val = 0;
>       } else if ((APLIC_CLRIE_BASE <= addr) &&
>               (addr < (APLIC_CLRIE_BASE + aplic->bitfield_words * 4))) {
> -        return 0;
> +        val = 0;
>       } else if (addr == APLIC_CLRIENUM) {
> -        return 0;
> +        val = 0;
>       } else if (addr == APLIC_SETIPNUM_LE) {
> -        return 0;
> +        val = 0;
>       } else if (addr == APLIC_SETIPNUM_BE) {
> -        return 0;
> +        val = 0;
>       } else if (addr == APLIC_GENMSI) {
> -        return (aplic->msimode) ? aplic->genmsi : 0;
> +        val = (aplic->msimode) ? aplic->genmsi : 0;
>       } else if ((APLIC_TARGET_BASE <= addr) &&
>               (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
>           irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
>           if (!riscv_aplic_source_active(aplic, irq)) {
> -            return 0;
> +            val = 0;
> +        } else {
> +            val = aplic->target[irq];
>           }
> -        return aplic->target[irq];
>       } else if (!aplic->msimode && (APLIC_IDC_BASE <= addr) &&
>               (addr < (APLIC_IDC_BASE + aplic->num_harts * APLIC_IDC_SIZE))) {
>           idc = (addr - APLIC_IDC_BASE) / APLIC_IDC_SIZE;
>           switch (addr - (APLIC_IDC_BASE + idc * APLIC_IDC_SIZE)) {
>           case APLIC_IDC_IDELIVERY:
> -            return aplic->idelivery[idc];
> +            val = aplic->idelivery[idc];
> +            break;
>           case APLIC_IDC_IFORCE:
> -            return aplic->iforce[idc];
> +            val = aplic->iforce[idc];
> +            break;
>           case APLIC_IDC_ITHRESHOLD:
> -            return aplic->ithreshold[idc];
> +            val = aplic->ithreshold[idc];
> +            break;
>           case APLIC_IDC_TOPI:
> -            return riscv_aplic_idc_topi(aplic, idc);
> +            val = riscv_aplic_idc_topi(aplic, idc);
> +            break;
>           case APLIC_IDC_CLAIMI:
> -            return riscv_aplic_idc_claimi(aplic, idc);
> +            val = riscv_aplic_idc_claimi(aplic, idc);
> +            break;
>           default:
>               goto err;
>           };
>       }
>   
> +    trace_riscv_aplic_read(addr, size, val);
> +    return val;
> +
>   err:
>       qemu_log_mask(LOG_GUEST_ERROR,
>                     "%s: Invalid register read 0x%" HWADDR_PRIx "\n",
> @@ -734,6 +745,8 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
>           goto err;
>       }
>   
> +    trace_riscv_aplic_write(addr, size, value);
> +
>       if (addr == APLIC_DOMAINCFG) {
>           /* Only IE bit writable at the moment */
>           value &= APLIC_DOMAINCFG_IE;
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 018c609ca5e..36ea75049ab 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -330,3 +330,7 @@ loongarch_msi_set_irq(int irq_num) "set msi irq %d"
>   loongarch_extioi_setirq(int irq, int level) "set extirq irq %d level %d"
>   loongarch_extioi_readw(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64 "val: 0x%" PRIx64
>   loongarch_extioi_writew(uint64_t addr, uint64_t val) "addr: 0x%"PRIx64 "val: 0x%" PRIx64
> +
> +# riscv_aplic.c
> +riscv_aplic_read(uint64_t offset, unsigned size, uint64_t value) "offset: 0x%" PRIx64 ", size: %u, value: 0x%" PRIx64
> +riscv_aplic_write(uint64_t offset, unsigned size, uint64_t value) "offset: 0x%" PRIx64 ", size: %u, value: 0x%" PRIx64


