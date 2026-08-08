Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57108C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 11:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsfXh-0007M4-SG; Sat, 08 Aug 2026 07:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsfXg-0007LS-4I
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 07:48:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsfXc-0003vy-G8
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 07:48:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678AJ0Qw3403183
 for <qemu-devel@nongnu.org>; Sat, 8 Aug 2026 11:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WRwc/sohiKgmeEgxTF5wA1YWsHI/7tr4xBJTo10LBis=; b=BiAvZxmVsYxvPJoJ
 0oWZIB7r56hmPpjDP2Y8uTgWq20+Xt4M4V4YzkwLau8vkNRVKMgVYcJcKbYOummF
 kdJuHeXGnVoFL5Pz/9Z6rW1UuLabjyCHL2v7bj/AwNC6njlRcEushHuuzRkpuCVh
 4E2npWSk5EqR4lkSX7knMtXm5mvHhmf+fs+nT8JTCjSPmOF450i4a7i0QyviOLte
 JiQo5KQ6S0Qhg03LhIxIE1gDd84LY19q4jzseog7bv2hwbdeliyd55hiH3n9bNXp
 b2djqj+7ploRbaa61vg2IJGNLfn926vzJrDnJeS9HbJ6dFkL2V9ifIqFG17SiLvF
 EZdQ0A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9gm7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 11:48:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so36767585a.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786189717; x=1786794517; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WRwc/sohiKgmeEgxTF5wA1YWsHI/7tr4xBJTo10LBis=;
 b=EjPJgDvH5mu/GO6RrF7hac2MVLcZPtl3OtzIn1K2+9iWR44eZ7jYOXgLMrHLFPJwuZ
 85awTQdGHBwJOAgWyQlvYgPL2ZV+bn+MFaPEBfZIp2VI2EXnHOsYnPcAohaXPDRtCVFs
 ydXwavUakTBMqZBHCH5UEy2MP+WZ39G7q4YGofELbKr6So6o6NL/L5k0Ox2SUN61W9qm
 f4qlyWFV0zHnDq5+pN6aNDAXByXuuNggWIpy5qD6M7m+GisMf/DxY8Q6xMfbT/xAPY0V
 L96xz/akYbVUoKEjWoZI7JIIJnQr17FZ1xpZVhRXbYTtSh3MhgKykTh+54CozD7ydo70
 viiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786189717; x=1786794517;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WRwc/sohiKgmeEgxTF5wA1YWsHI/7tr4xBJTo10LBis=;
 b=szUwZz/ygnTNnk4xqOz7Plewx9PTJLIvpWoauBkm9Ky+UwIxF538xM/YZqxPQoOZSD
 yxNo1VuOjpm+FC5Gne0FdlNpeD497FgXlpgh278rR7rZ7cZJx1tfPr7zfVQNoz6ZqQAC
 qThcuYyQ/P5gMBaDWEJZg1mzHOnqsiBVCnzXc2MJlV8N1J5AgSXQjZNqTxwOiVuNeLSh
 buJu31157IvlMTgS0765//qLa2jXkxeySi+WCGSrV9vzb02noja0/ZWP1kN1ERE/4ozd
 N0x0mipXy33X34vfJ3chN2/h68/3sfTD/yNHSyu0vEjkdKzYPZnID+YQno+h06PQExN2
 1w/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpZ7TQVp5o4wBnFzBB9MOwScupvI+wmIwwpWjh/NC9y/xUSh2EfM+K9+ANXPuZBUkn6utdB1svld2r@nongnu.org
X-Gm-Message-State: AOJu0YwfihzA/OJRaOnhQBBsSHC6JPsQrY5IBGFHIByE8ryb6JgbVolc
 mOir2RD/Zkr5B39gKJ8pQVm97PwFS/p9lq/QCIpUpUCIE6A9GqjqlwWT/iUE1LUtVeLU2RoLj1A
 qM4bpnbeh0b5GZ3huhZ/pm5cjSbaQZFUk2lpPQFqhNajOgDoiWKMs2Qb8Lg==
X-Gm-Gg: AR+sD119P3tTMnJpS7fyapeqfIbDZC5Qs93prfudm5gsZRlNlcCJUrpWji0WlZC8r0G
 36XUimW3smoVL5Zk7mndLMZ5T7ou1Gfbv5uLB7TkcSnig7rQjqFdcqok4crRaROANiQMqXoSz+M
 Y2I/B0Uw5qpBw6FtAH1CE3ABuayfZ453BCAZQrFOXRL9rPyTmo02MfRn9NR+TXJYudT/Y3c9LUB
 sJ+qmE5y2XR/4vz8m0nvkX+EU3eaE+Nl4mRZShagP/qWGmOUVboyE1kEDINmxu3yxwrr4m7DPxt
 Fl4U3RMjJ8t+Y6D2sX3Gzprlgu+k9SaBVs9mGTOMNuUPzDWV8IIusGg8c/jl5EW36WqbNK2PZuK
 EembuVxZ6Sesz1irZp11SH4DUgZEvjGsvRtTm
X-Received: by 2002:a05:620a:1a22:b0:930:f6f9:51eb with SMTP id
 af79cd13be357-93649192893mr2872276485a.44.1786189717048; 
 Sat, 08 Aug 2026 04:48:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1a22:b0:930:f6f9:51eb with SMTP id
 af79cd13be357-93649192893mr2872271585a.44.1786189716407; 
 Sat, 08 Aug 2026 04:48:36 -0700 (PDT)
Received: from [192.168.68.100] ([177.198.100.18])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e0ad602sm361313485a.20.2026.08.08.04.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Aug 2026 04:48:35 -0700 (PDT)
Message-ID: <eed3abad-684a-46dc-81ed-9567af04c751@oss.qualcomm.com>
Date: Sat, 8 Aug 2026 08:48:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] hw/dma: add K230 gsdma
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 caojunze424@gmail.com
References: <20260808062227.66961-1-dingtao0430@163.com>
 <20260808062227.66961-2-dingtao0430@163.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260808062227.66961-2-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a771796 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=el0UrXJS4K3zujXh0Vdy/w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Rull5dLDAAAA:8 a=Byx-y9mGAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8
 a=kQcnN2SSmwezVYGd1rsA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=WpjELI0oDsu8BIz5_MMC:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: T9z5xUEmjT5q6aKs3G2ol3a95eDZtl-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDA5OSBTYWx0ZWRfX5DOREdgVkx83
 OR4ByQiTCM2s8wKD1O5fp+XalQ6uebZ3qbPBf9gCQlLvNpFfzVrAso5NFeMnsUybZjVYosWL85o
 UXc6tUiwcHLJE4vYIqWDuwJjBg7zQBJASUB56/4qfDKRYMQh4PSD6cAvL7rNo8jAxqTrBc9HrXi
 VmOIIVSOmqSBRbHfkgqp6ADY+vApIDuvDXH8PI5gD/PFEccoiDTBdQPsCIaY3MmKrkQ9L9draJc
 ABwEOpOGIdK/dlnUGRW44BZ7xox/fOPbQOQfxnMrlCjP6YJNPAY/ldMYFVJ90UPrCmJG0XWk/P+
 cak2tVu+aneVEx6J+MwTYspUwieaQc6B+MKxWumJKS8crshWSUNLzPZ0aYM4oAu0TmP9QNZI4FB
 LjjKdgA0qMWVTw+CXIm+kdq3OMmbpETJvJOIhY3Gpe8THmx7xE3ApJfsVBnZUl647XaRYEKYLcH
 X+pZu4YLbGz1hRmrp2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDA5OSBTYWx0ZWRfXwxlOeKrLYwAy
 L+hQQXiAAI33EroEo43uTFvAQBBFJSQLu8jagVZc0BEv5Y29onVtmQUvPQqtFJnn0NjCFlCYtfR
 V4wmJ9AqhCLTdnwM0RPnsrL5UK5d8gE=
X-Proofpoint-GUID: T9z5xUEmjT5q6aKs3G2ol3a95eDZtl-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080099
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



On 8/8/2026 3:22 AM, Tao Ding wrote:
> K230 GSDMA includes SDMA (System Direct Memory Access) and GDMA (Graphic Direct Memory Access).
> In this patch, add SDMA for k230 board. The following features have not been implemented:
> 1. axi protocol related
> 2. channel arbitration
> 3. lower power mode
> 
> SDMA supports transfer data between memory, in which case SDMA is the controller.
> It also supports transfer data to decomp_gzip and caching it through SRAM.
> In this case, decomp_gzip is the controller, which controls SDMA through handshake signals.
> 
> According to "K230 Technical Reference Manual v0.3.1" section 2.5.2.
> https://download.kendryte.com/developer/k230/HDK/K230%E7%A1%AC%E4%BB%B6%E6%96%87%E6%A1%A3/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> 
> This commit includes:
> - K230 SDMA (System Direct Memory Access) model (k230_gsdma.c, k230_gsdma.h)
> - GSDMA trace log (trace-events)
> - Kconfig and meson.build
> - update MAINTAINERS
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> In patchv2, the reviewer suggests removing unimplemented registers.
> Added print for unimplemented register access in this commit with qemu_log_mask.
> 
>   MAINTAINERS                 |   2 +
>   hw/dma/Kconfig              |   3 +
>   hw/dma/k230_gsdma.c         | 551 ++++++++++++++++++++++++++++++++++++
>   hw/dma/meson.build          |   1 +
>   hw/dma/trace-events         |   6 +
>   include/hw/dma/k230_gsdma.h | 130 +++++++++
>   6 files changed, 693 insertions(+)
>   create mode 100644 hw/dma/k230_gsdma.c
>   create mode 100644 include/hw/dma/k230_gsdma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a28935c898..49c8013d5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1829,8 +1829,10 @@ S: Maintained
>   F: docs/system/riscv/k230.rst
>   F: hw/riscv/k230.c
>   F: hw/watchdog/k230_wdt.c
> +F: hw/dma/k230_gsdma.c
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
> +F: include/hw/dma/k230_gsdma.h
>   F: tests/functional/riscv64/test_k230.py
>   F: tests/qtest/k230-wdt-test.c
>   
> diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
> index 98fbb1bb04..0a23e7d7b8 100644
> --- a/hw/dma/Kconfig
> +++ b/hw/dma/Kconfig
> @@ -30,3 +30,6 @@ config SIFIVE_PDMA
>   config XLNX_CSU_DMA
>       bool
>       select REGISTER
> +
> +config K230_GSDMA
> +    bool
> \ No newline at end of file
> diff --git a/hw/dma/k230_gsdma.c b/hw/dma/k230_gsdma.c
> new file mode 100644
> index 0000000000..7635cd19e8
> --- /dev/null
> +++ b/hw/dma/k230_gsdma.c
> @@ -0,0 +1,551 @@
> +/*
> + * Kendryte K230 GSDMA
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * GSDMA includes SDMA (System Direct Memory Access, K230 TRM section 10.2) and
> + * GDMA (Graphic Direct Memory Access, K230 TRM section 2.5.2).
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "migration/vmstate.h"
> +#include "system/address-spaces.h"
> +#include "hw/dma/k230_gsdma.h"
> +#include "hw/core/irq.h"
> +#include "trace.h"
> +
> +static void k230_gsdma_update_irq(K230GSDMAState *s)
> +{
> +    qemu_set_irq(s->irq, !!(s->dma_int_stat & ~s->dma_int_mask));
> +}
> +
> +static bool k230_gsdma_decomp_enabled(K230GSDMAState *s)
> +{
> +    /* Only sdma channel 0 has decomp enable flag */
> +    return !!(s->channels[0].cfg & K230_GSDMA_CH0_CFG_DECOMP_CTRL_EN);
> +}
> +
> +static bool k230_gsdma_read_sdma_llt(hwaddr addr, K230GSDMALLT *llt)
> +{
> +    bool ok = address_space_read(&address_space_memory, addr,
> +                                 MEMTXATTRS_UNSPECIFIED, llt,
> +                                 sizeof(*llt)) == MEMTX_OK;
> +
> +    if (ok) {
> +        trace_k230_gsdma_read_sdma_llt(addr, le32_to_cpu(llt->cfg),
> +                                       le32_to_cpu(llt->src_addr),
> +                                       le32_to_cpu(llt->line_size),
> +                                       le32_to_cpu(llt->line_cfg),
> +                                       le32_to_cpu(llt->dst_addr),
> +                                       le32_to_cpu(llt->next_llt_addr));
> +    } else {
> +        trace_k230_gsdma_read_sdma_llt_failed(addr);
> +    }
> +
> +    return ok;
> +}
> +
> +static unsigned int k230_gsdma_usr_data_size(uint32_t cfg)
> +{
> +    /* decode usr_dat_size in CH_CFG register */
> +    switch (extract32(cfg, K230_GSDMA_CH_CFG_USR_DATA_SIZE_SHIFT, 2)) {
> +    case 0:
> +        return 1;
> +    case 1:
> +        return 2;
> +    default:
> +        return 4;
> +    }
> +}
> +
> +static void k230_gsdma_convert_endian(uint8_t *buf, uint32_t len, uint32_t cfg)
> +{
> +    unsigned int mode = extract32(cfg,
> +                                  K230_GSDMA_CH_CFG_DAT_ENDIAN_SHIFT, 2);
> +    unsigned int unit_size;
> +    unsigned int offset;
> +
> +    if (mode == 0) {
> +        return;
> +    }
> +
> +    unit_size = 1U << mode;
> +    for (offset = 0; offset + unit_size <= len; offset += unit_size) {
> +        unsigned int i;
> +
> +        for (i = 0; i < unit_size / 2; i++) {
> +            uint8_t tmp = buf[offset + i];
> +
> +            buf[offset + i] = buf[offset + unit_size - i - 1];
> +            buf[offset + unit_size - i - 1] = tmp;
> +        }
> +    }
> +}
> +
> +static bool k230_gsdma_transfer_llt(K230GSDMAChannel *c, const K230GSDMALLT *llt)
> +{
> +    uint32_t llt_cfg = le32_to_cpu(llt->cfg);
> +    hwaddr src = le32_to_cpu(llt->src_addr);
> +    hwaddr dst = le32_to_cpu(llt->dst_addr);
> +    uint32_t line_size = le32_to_cpu(llt->line_size);
> +    uint32_t line_cfg = le32_to_cpu(llt->line_cfg);
> +    /* Number of lines required for 2d mode */
> +    uint32_t line_num =
> +            (llt_cfg & K230_GSDMA_LLT_2D_MODE) ? extract32(line_cfg, 0, 16) : 1;
> +    /* Stride line size required for 2d mode */
> +    uint32_t line_space = extract32(line_cfg, 16, 16);
> +
> +    bool dat_mode = c->cfg & K230_GSDMA_CH_CFG_DAT_MODE;
> +    bool src_fixed = c->cfg & K230_GSDMA_CH_CFG_SRC_FIXED;
> +    bool dst_fixed = c->cfg & K230_GSDMA_CH_CFG_DST_FIXED;
> +
> +    uint8_t buf[8]; /* K230 sdma axi data width is 64-bit */
> +    uint8_t fill[4];    /* Usr data is 32-bit*/
> +    unsigned int fill_len = k230_gsdma_usr_data_size(c->cfg);
> +    uint32_t i;
> +
> +    memcpy(fill, &c->usr_data, sizeof(fill));
> +
> +    for (i = 0; i < line_num; i++) {
> +        uint32_t remaining = line_size;
> +        hwaddr line_src = src;
> +        hwaddr line_dst = dst;
> +
> +        while (remaining) {
> +            uint32_t chunk = MIN(remaining, (uint32_t)sizeof(buf));
> +
> +            if (dat_mode) {
> +                uint32_t j;
> +
> +                for (j = 0; j < chunk; j++) {
> +                    buf[j] = fill[j % fill_len];
> +                }
> +            } else if (address_space_read(&address_space_memory, line_src,
> +                                          MEMTXATTRS_UNSPECIFIED, buf,
> +                                          chunk) != MEMTX_OK) {
> +                return false;
> +            }
> +
> +            k230_gsdma_convert_endian(buf, chunk, c->cfg);
> +
> +            if (address_space_write(&address_space_memory, line_dst,
> +                                    MEMTXATTRS_UNSPECIFIED, buf,
> +                                    chunk) != MEMTX_OK) {
> +                return false;
> +            }
> +
> +            if (!dat_mode && !src_fixed) {
> +                line_src += chunk;
> +            }
> +            if (!dst_fixed) {
> +                line_dst += chunk;
> +            }
> +            remaining -= chunk;
> +        }
> +
> +        if (!dat_mode && !src_fixed) {
> +            if (llt_cfg & K230_GSDMA_LLT_2D_MODE) { /* 2d mode */
> +                src += line_size + line_space;
> +            } else {
> +                src += line_size;
> +            }
> +        }
> +
> +        if (!dst_fixed) {
> +            dst += line_size;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static void k230_gsdma_sdma_set_idle(K230GSDMAChannel *c)
> +{
> +    c->status &= ~(K230_GSDMA_SDMA_STATUS_BUSY | K230_GSDMA_SDMA_STATUS_PAUSE);
> +    c->next_llt = 0;
> +}
> +
> +static void k230_gsdma_sdma_set_paused(K230GSDMAChannel *c, hwaddr next_llt)
> +{
> +    c->status &= ~K230_GSDMA_SDMA_STATUS_BUSY;
> +    c->status |= K230_GSDMA_SDMA_STATUS_PAUSE;
> +    c->next_llt = next_llt;
> +}
> +
> +static void k230_gsdma_run_sdma(K230GSDMAState *s, unsigned int ch, hwaddr addr)
> +{
> +    K230GSDMAChannel *c = &s->channels[ch];
> +
> +    c->status &= ~K230_GSDMA_SDMA_STATUS_PAUSE;
> +    c->status |= K230_GSDMA_SDMA_STATUS_BUSY;
> +    c->next_llt = 0;
> +    c->current_llt = addr;
> +
> +    while (addr) {
> +        K230GSDMALLT llt;
> +        uint32_t cfg;
> +        hwaddr next;
> +
> +        if (!k230_gsdma_read_sdma_llt(addr, &llt)) {
> +            k230_gsdma_sdma_set_idle(c);
> +            return;
> +        }
> +
> +        cfg = le32_to_cpu(llt.cfg);
> +        next = le32_to_cpu(llt.next_llt_addr);
> +        c->current_llt = addr;
> +
> +        if (!k230_gsdma_transfer_llt(c, &llt)) {
> +            k230_gsdma_sdma_set_idle(c);
> +            return;
> +        }
> +
> +        if (cfg & K230_GSDMA_LLT_NODE_INTR) {
> +            s->dma_int_stat |= K230_GSDMA_SDMA_ITEM_INT(ch);
> +        }
> +
> +        if (cfg & K230_GSDMA_LLT_PAUSE) {
> +            s->dma_int_stat |= K230_GSDMA_SDMA_PAUSE_INT(ch);
> +            k230_gsdma_sdma_set_paused(c, next);
> +            k230_gsdma_update_irq(s);
> +            return;
> +        }
> +
> +        addr = next;
> +    }
> +
> +    s->dma_int_stat |= K230_GSDMA_SDMA_DONE_INT(ch);
> +    s->dma_ch_en &= ~BIT(ch);
> +    k230_gsdma_sdma_set_idle(c);
> +    k230_gsdma_update_irq(s);
> +}
> +
> +/* Decomp gzip request step sdma */
> +static void k230_gsdma_step_sdma(K230GSDMAState *s, unsigned int ch, hwaddr addr)
> +{
> +    K230GSDMAChannel *c = &s->channels[ch];
> +    K230GSDMALLT llt;
> +    uint32_t cfg;
> +    hwaddr next;
> +
> +    if (!addr || !k230_gsdma_read_sdma_llt(addr, &llt)) {
> +        k230_gsdma_sdma_set_idle(c);
> +        return;
> +    }
> +
> +    cfg = le32_to_cpu(llt.cfg);
> +    next = le32_to_cpu(llt.next_llt_addr);
> +
> +    c->status |= K230_GSDMA_SDMA_STATUS_BUSY;
> +    c->status &= ~K230_GSDMA_SDMA_STATUS_PAUSE;
> +    c->current_llt = addr;
> +
> +    if (!k230_gsdma_transfer_llt(c, &llt)) {
> +        k230_gsdma_sdma_set_idle(c);
> +        return;
> +    }
> +
> +    if (cfg & K230_GSDMA_LLT_NODE_INTR) {
> +        s->dma_int_stat |= K230_GSDMA_SDMA_ITEM_INT(ch);
> +    }
> +
> +    c->status &= ~K230_GSDMA_SDMA_STATUS_BUSY;
> +    c->next_llt = next;
> +    if (next == 0) {
> +        s->dma_int_stat |= K230_GSDMA_SDMA_DONE_INT(ch);
> +        s->dma_ch_en &= ~BIT(ch);
> +    }
> +
> +    k230_gsdma_update_irq(s);
> +}
> +
> +static const VMStateDescription vmstate_k230_gsdma_channel = {
> +    .name = "k230.gsdma.channel",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(ctl, K230GSDMAChannel),
> +        VMSTATE_UINT32(status, K230GSDMAChannel),
> +        VMSTATE_UINT32(cfg, K230GSDMAChannel),
> +        VMSTATE_UINT32(usr_data, K230GSDMAChannel),
> +        VMSTATE_UINT32(llt_saddr, K230GSDMAChannel),
> +        VMSTATE_UINT32(current_llt, K230GSDMAChannel),
> +        VMSTATE_UINT32(next_llt, K230GSDMAChannel),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_k230_gsdma = {
> +    .name = "k230.gsdma",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(dma_ch_en, K230GSDMAState),
> +        VMSTATE_UINT32(dma_int_mask, K230GSDMAState),
> +        VMSTATE_UINT32(dma_int_stat, K230GSDMAState),
> +        VMSTATE_UINT32(dma_cfg, K230GSDMAState),
> +        VMSTATE_UINT32(dma_weight, K230GSDMAState),
> +        VMSTATE_STRUCT_ARRAY(channels, K230GSDMAState,
> +                             K230_GSDMA_NUM_SDMA_CHANNELS, 2,
> +                             vmstate_k230_gsdma_channel, K230GSDMAChannel),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static uint64_t k230_gsdma_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    K230GSDMAState *s = K230_GSDMA(opaque);
> +    unsigned int ch;
> +    hwaddr ch_off;
> +    uint64_t ret = 0;
> +
> +    switch (addr) {
> +    case K230_GSDMA_DMA_CH_EN:
> +        ret = s->dma_ch_en;
> +        break;
> +    case K230_GSDMA_DMA_INT_MASK:
> +        ret = s->dma_int_mask;
> +        break;
> +    case K230_GSDMA_DMA_INT_STAT:
> +        ret = s->dma_int_stat;
> +        break;
> +    case K230_GSDMA_DMA_CFG:
> +        ret = s->dma_cfg;
> +        break;
> +    case K230_GSDMA_DMA_WEIGHT:
> +        ret = s->dma_weight;
> +        break;
> +    default:
> +        if (addr < K230_GSDMA_CH_BASE) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                        "%s: not implement gdma at offset 0x%" HWADDR_PRIx
> +                        "\n", __func__, addr);
> +        }
> +        break;
> +    }
> +
> +    ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
> +    ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
> +    if (ch < K230_GSDMA_NUM_SDMA_CHANNELS) {
> +        switch (ch_off) {
> +        case K230_GSDMA_CH_CTL:
> +            break;
> +        case K230_GSDMA_CH_STATUS:
> +            ret = s->channels[ch].status;
> +            break;
> +        case K230_GSDMA_CH_CFG:
> +            ret = s->channels[ch].cfg;
> +            break;
> +        case K230_GSDMA_CH_USR_DATA:
> +            ret = s->channels[ch].usr_data;
> +            break;
> +        case K230_GSDMA_CH_LLT_SADDR:
> +            ret = s->channels[ch].llt_saddr;
> +            break;
> +        case K230_GSDMA_CH_CURRENT_LLT:
> +            ret = s->channels[ch].current_llt;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    trace_k230_gsdma_read(addr, size, ret);
> +    return ret;
> +}
> +
> +static void k230_gsdma_write_channel(K230GSDMAState *s, unsigned int ch,
> +                                     hwaddr ch_off, uint32_t value)
> +{
> +    K230GSDMAChannel *c = &s->channels[ch];
> +    bool handshake_mode = ch < 2 && k230_gsdma_decomp_enabled(s);
> +
> +    switch (ch_off) {
> +    case K230_GSDMA_CH_CTL:
> +        c->ctl = value;
> +        if ((value & K230_GSDMA_CTL_STOP) != 0) {
> +            c->started = false;
> +            k230_gsdma_sdma_set_idle(c);
> +            break;
> +        }
> +        if ((value & K230_GSDMA_CTL_RESUME) != 0 &&
> +            (c->status & K230_GSDMA_SDMA_STATUS_PAUSE) && c->next_llt != 0) {
> +            k230_gsdma_run_sdma(s, ch, c->next_llt);
> +            break;
> +        }
> +        if (handshake_mode && (value & K230_GSDMA_CTL_START) != 0) {
> +            c->started = true;
> +            c->status &= ~(K230_GSDMA_SDMA_STATUS_BUSY |
> +                           K230_GSDMA_SDMA_STATUS_PAUSE);
> +            c->current_llt = 0;
> +            c->next_llt = 0;
> +            break;
> +        }
> +        if ((value & K230_GSDMA_CTL_START) != 0 &&
> +            (s->dma_ch_en & BIT(ch)) && c->llt_saddr != 0) {
> +            c->started = true;
> +            k230_gsdma_run_sdma(s, ch, c->llt_saddr);
> +        }
> +        break;
> +    case K230_GSDMA_CH_CFG:
> +        c->cfg = value;
> +        break;
> +    case K230_GSDMA_CH_USR_DATA:
> +        c->usr_data = value;
> +        break;
> +    case K230_GSDMA_CH_LLT_SADDR:
> +        c->llt_saddr = value;
> +        break;
> +    case K230_GSDMA_CH_CURRENT_LLT:
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static void k230_gsdma_write(void *opaque, hwaddr addr,
> +                             uint64_t value, unsigned int size)
> +{
> +    K230GSDMAState *s = K230_GSDMA(opaque);
> +    unsigned int ch;
> +    hwaddr ch_off;
> +    uint32_t v = value;
> +
> +    trace_k230_gsdma_write(addr, size, value);
> +
> +    switch (addr) {
> +    case K230_GSDMA_DMA_CH_EN:
> +        s->dma_ch_en = v & K230_GSDMA_DMA_CH_EN_MASK;
> +        return;
> +    case K230_GSDMA_DMA_INT_MASK:
> +        s->dma_int_mask = v;
> +        k230_gsdma_update_irq(s);
> +        return;
> +    case K230_GSDMA_DMA_INT_STAT:
> +        s->dma_int_stat &= ~v;
> +        k230_gsdma_update_irq(s);
> +        return;
> +    case K230_GSDMA_DMA_CFG:
> +        s->dma_cfg = v;
> +        return;
> +    case K230_GSDMA_DMA_WEIGHT:
> +        s->dma_weight = v & 0x00ffffff;
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    if (addr < K230_GSDMA_CH_BASE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: not implement gdma at offset 0x%" HWADDR_PRIx
> +                      "\n", __func__, addr);
> +        return;
> +    }
> +
> +    ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
> +    ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
> +    if (ch >= K230_GSDMA_NUM_SDMA_CHANNELS) {
> +        return;
> +    }
> +
> +    k230_gsdma_write_channel(s, ch, ch_off, v);
> +}
> +
> +static void k230_gsdma_handle_signal(void *opaque, int n, int level)
> +{
> +    K230GSDMAState *s = opaque;
> +    K230GSDMAChannel *c;
> +    hwaddr addr;
> +    unsigned int ch;
> +
> +    if (!level || n == K230_GSDMA_GPIO_DECOMP_CTRL_EN) {
> +        return;
> +    }
> +
> +    ch = n - 1;
> +
> +    c = &s->channels[ch];
> +    if (!k230_gsdma_decomp_enabled(s) || !(s->dma_ch_en & BIT(ch)) || !c->started) {
> +        return;
> +    }
> +
> +    if (c->current_llt == 0) {
> +        addr = c->llt_saddr;
> +    } else {
> +        addr = c->next_llt;
> +    }
> +    if (!addr) {
> +        return;
> +    }
> +
> +    k230_gsdma_step_sdma(s, ch, addr);
> +    qemu_set_irq(s->handshake_out[n - 1], 1);
> +    qemu_set_irq(s->handshake_out[n - 1], 0);
> +}
> +
> +static const MemoryRegionOps k230_gsdma_ops = {
> +    .read = k230_gsdma_read,
> +    .write = k230_gsdma_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void k230_gsdma_reset_hold(Object *obj, ResetType type)
> +{
> +    K230GSDMAState *s = K230_GSDMA(obj);
> +
> +    memset(s->channels, 0, sizeof(s->channels));
> +    s->dma_ch_en = 0;
> +    s->dma_int_mask = 0;
> +    s->dma_int_stat = 0;
> +    s->dma_cfg = K230_GSDMA_DMA_CFG_RESET;
> +    s->dma_weight = 0;
> +}
> +
> +static void k230_gsdma_realize(DeviceState *dev, Error **errp)
> +{
> +    K230GSDMAState *s = K230_GSDMA(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &k230_gsdma_ops, s,
> +                          TYPE_K230_GSDMA, K230_GSDMA_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +    qdev_init_gpio_in(DEVICE(dev), k230_gsdma_handle_signal,
> +                      K230_GSDMA_NUM_GPIOS_IN);
> +    qdev_init_gpio_out(DEVICE(dev), s->handshake_out,
> +                       K230_GSDMA_NUM_GPIOS_OUT);
> +}
> +
> +static void k230_gsdma_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = k230_gsdma_realize;
> +    rc->phases.hold = k230_gsdma_reset_hold;
> +    dc->vmsd = &vmstate_k230_gsdma;
> +    dc->desc = "Kendryte K230 GSDMA";
> +}
> +
> +static const TypeInfo k230_gsdma_info = {
> +    .name = TYPE_K230_GSDMA,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230GSDMAState),
> +    .class_init = k230_gsdma_class_init,
> +};
> +
> +static void k230_gsdma_register_types(void)
> +{
> +    type_register_static(&k230_gsdma_info);
> +}
> +
> +type_init(k230_gsdma_register_types)
> diff --git a/hw/dma/meson.build b/hw/dma/meson.build
> index cc7810beb8..45db5e7357 100644
> --- a/hw/dma/meson.build
> +++ b/hw/dma/meson.build
> @@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
>   system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
>   system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.c'))
> +system_ss.add(when: 'CONFIG_K230_GSDMA', if_true: files('k230_gsdma.c'))
> diff --git a/hw/dma/trace-events b/hw/dma/trace-events
> index 4c09790f9a..a494755b5a 100644
> --- a/hw/dma/trace-events
> +++ b/hw/dma/trace-events
> @@ -47,3 +47,9 @@ pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"
>   
>   # xilinx_axidma.c
>   xilinx_axidma_loading_desc_fail(uint32_t res) "error:%u"
> +
> +# k230_gsdma.c
> +k230_gsdma_read(uint64_t addr, unsigned int size, uint64_t data) "K230 GSDMA read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
> +k230_gsdma_write(uint64_t addr, unsigned int size, uint64_t data) "K230 GSDMA write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
> +k230_gsdma_read_sdma_llt(uint64_t addr, uint32_t cfg, uint32_t src_addr, uint32_t line_size, uint32_t line_cfg, uint32_t dst_addr, uint32_t next_llt_addr) "K230 GSDMA read SDMA LLT: addr=0x%"PRIx64" cfg=0x%"PRIx32" src=0x%"PRIx32" line_size=0x%"PRIx32" line_cfg=0x%"PRIx32" dst=0x%"PRIx32" next=0x%"PRIx32
> +k230_gsdma_read_sdma_llt_failed(uint64_t addr) "K230 GSDMA read SDMA LLT failed: addr=0x%"PRIx64
> diff --git a/include/hw/dma/k230_gsdma.h b/include/hw/dma/k230_gsdma.h
> new file mode 100644
> index 0000000000..629cce29f8
> --- /dev/null
> +++ b/include/hw/dma/k230_gsdma.h
> @@ -0,0 +1,130 @@
> +/*
> + * K230 GSDMA
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_DMA_K230_GSDMA_H
> +#define HW_DMA_K230_GSDMA_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_K230_GSDMA "riscv.k230.gsdma"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230GSDMAState, K230_GSDMA)
> +
> +#define K230_GSDMA_MMIO_SIZE          0x4000
> +#define K230_GSDMA_NUM_SDMA_CHANNELS  4
> +
> +#define K230_GSDMA_CH_STRIDE          0x30
> +#define K230_GSDMA_CH_BASE            0x50
> +
> +/* K230 SDMA request input */
> +enum {
> +    K230_GSDMA_GPIO_DECOMP_CTRL_EN,
> +    K230_GSDMA_GPIO_DMA_WRITE_REQ,
> +    K230_GSDMA_GPIO_DMA_READ_REQ,
> +    K230_GSDMA_NUM_GPIOS_IN,
> +};
> +
> +/* K230 SDMA ACK output */
> +enum {
> +    K230_GSDMA_GPIO_DMA_WRITE_ACK,
> +    K230_GSDMA_GPIO_DMA_READ_ACK,
> +    K230_GSDMA_NUM_GPIOS_OUT,
> +};
> +
> +/* K230 GSDMA Registers Map */
> +#define K230_GSDMA_DMA_CH_EN          0x00
> +#define K230_GSDMA_DMA_INT_MASK       0x04
> +#define K230_GSDMA_DMA_INT_STAT       0x08
> +#define K230_GSDMA_DMA_CFG            0x0c
> +#define K230_GSDMA_GDMA_CTRL          0x10
> +#define K230_GSDMA_GDMA_LLI_BASE      0x14
> +#define K230_GSDMA_GDMA_CH_CNT0       0x18
> +#define K230_GSDMA_GDMA_CH_CNT_LAST   0x34
> +#define K230_GSDMA_GDMA_CURRENT_LLT   0x38
> +#define K230_GSDMA_DMA_WEIGHT         0x48
> +
> +/* K230 GSDMA SDMA Channel Register Map */
> +#define K230_GSDMA_CH_CTL             0x00
> +#define K230_GSDMA_CH_STATUS          0x04
> +#define K230_GSDMA_CH_CFG             0x08
> +#define K230_GSDMA_CH_USR_DATA        0x0c
> +#define K230_GSDMA_CH_LLT_SADDR       0x10
> +#define K230_GSDMA_CH_CURRENT_LLT     0x14
> +
> +/* K230 SDMA Control bit */
> +#define K230_GSDMA_CTL_START          BIT(0)
> +#define K230_GSDMA_CTL_STOP           BIT(1)
> +#define K230_GSDMA_CTL_RESUME         BIT(2)
> +
> +/* K230 SDMA States bit */
> +#define K230_GSDMA_SDMA_STATUS_BUSY   BIT(0)
> +#define K230_GSDMA_SDMA_STATUS_PAUSE  BIT(1)
> +
> +/* K230 SDMA Interrupt bit */
> +#define K230_GSDMA_SDMA_DONE_INT(ch)  BIT(ch)
> +#define K230_GSDMA_SDMA_ITEM_INT(ch)  BIT((ch) + 4)
> +#define K230_GSDMA_SDMA_PAUSE_INT(ch) BIT((ch) + 8)
> +
> +
> +#define K230_GSDMA_DMA_CH_EN_MASK     MAKE_64BIT_MASK(0, 5)
> +#define K230_GSDMA_DMA_CFG_RESET      0x000007ff
> +
> +/* K230 SDMA Linked List bit */
> +#define K230_GSDMA_LLT_2D_MODE        BIT(28)
> +#define K230_GSDMA_LLT_PAUSE          BIT(29)
> +#define K230_GSDMA_LLT_NODE_INTR      BIT(30)
> +#define K230_GSDMA_GDMA_LLT_GCH_SHIFT 16
> +#define K230_GSDMA_GDMA_LLT_GCH_MASK  0x7
> +#define K230_GSDMA_CH_CFG_DAT_MODE    BIT(0)
> +#define K230_GSDMA_CH_CFG_USR_DATA_SIZE_SHIFT 1
> +#define K230_GSDMA_CH_CFG_USR_DATA_SIZE_MASK  0x3
> +#define K230_GSDMA_CH_CFG_DAT_ENDIAN_SHIFT 4
> +#define K230_GSDMA_CH_CFG_DAT_ENDIAN_MASK  0x3
> +#define K230_GSDMA_CH_CFG_SRC_FIXED   BIT(8)
> +#define K230_GSDMA_CH_CFG_DST_FIXED   BIT(9)
> +#define K230_GSDMA_CH0_CFG_DECOMP_CTRL_EN BIT(10)
> +
> +/* K230 SDMA channel state */
> +typedef struct K230GSDMAChannel {
> +    uint32_t ctl;
> +    uint32_t status;
> +    uint32_t cfg;
> +    uint32_t usr_data;
> +    uint32_t llt_saddr;
> +    uint32_t current_llt;
> +    uint32_t next_llt;
> +    bool started;
> +} K230GSDMAChannel;
> +
> +/* K230 SDMA Linked List */
> +typedef struct K230GSDMALLT {
> +    uint32_t cfg;
> +    uint32_t src_addr;
> +    uint32_t line_size;
> +    uint32_t line_cfg;
> +    uint32_t dst_addr;
> +    uint32_t next_llt_addr;
> +} K230GSDMALLT;
> +
> +/* K230 GSDMA state */
> +struct K230GSDMAState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +    qemu_irq handshake_out[K230_GSDMA_NUM_GPIOS_OUT];
> +
> +    uint32_t dma_ch_en;
> +    uint32_t dma_int_mask;
> +    uint32_t dma_int_stat;
> +    uint32_t dma_cfg;
> +    uint32_t dma_weight;
> +
> +    K230GSDMAChannel channels[K230_GSDMA_NUM_SDMA_CHANNELS];
> +};
> +
> +#endif


