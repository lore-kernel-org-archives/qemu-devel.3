Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185CFC2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKDW-0007p2-OW; Fri, 07 Aug 2026 09:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsKCv-0007kF-Kd
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:01:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsKCp-0001pG-L7
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:01:51 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CgMT71294633
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 13:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XRHEM92ZOiFpbc3jPIRd6JaK4XEiMck3C0BdUiQTBfg=; b=NlFV+2uq/+aiT8hi
 k2n+g4JedgZXe8KeYJiFVB7ssjUMMWCliyZHwSwIHjRhoEeG/nvAPUubKKSD2gfj
 dHQ2bjasohs8rrkkc7/mtp9aVewOp9F7M0EaBNUFgLjeL/Negja728ecxZ2fpaj7
 0zU+pCqG/CYAbBViFYkKRVGk00ICsFHu5dvXqFubHUwAKo2Dv9pL3iQL+Y9fQ3eF
 AEBtNj2s3SBJCKBtOFLegvTfoIXRPaArHXIX2CYJtE59J31UvU5N0UuiGfY7qjFP
 gMfIFVGsHhIIeAeRo9H/Qc3LZXCjgtRgBATm+qic33X1Gjr7DOCwKZaioGb7nquw
 fToHsg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gv1fj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 13:01:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso49778201cf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786107705; x=1786712505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XRHEM92ZOiFpbc3jPIRd6JaK4XEiMck3C0BdUiQTBfg=;
 b=icJ6vGAUxgA2RCQ/9F6o3XGgS/6+mO4fwfejOGRS2BP0eu83PmNXfbCF9pAgbTmZSQ
 pxaJ57lK3z67oPT/K8rbXMQSOBfungSZBKZihIa0GwqihT03VAyuuzAqwpMRF0Ijne3B
 RYcPjuXo/2Wg3RwFEdfOILkAAHqlRXst+AmnhKiegQF+yFkW5JVTh39iJ7VLajYN7Cvm
 TfzaRqp9KYIreWoWiWYtpzqYoXjND/s57WSXdQaNpmKQ3m83cDIZTDoa0W3vQ00t76Ub
 dNXjiletqMtF1KKKdPhgCsPfe6UCAQPzDT+kzzGtkM9ZsUvmbYtlYpRDvVtxj4iRo+yJ
 t3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786107705; x=1786712505;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRHEM92ZOiFpbc3jPIRd6JaK4XEiMck3C0BdUiQTBfg=;
 b=M+vKdK+8zZl79umz7NhwY39wqqsGqN+UBqpHl+ZDCo5hDuXUBbp7A/4ubU69PjDoBF
 GIFauOAtF5rVnp5WzWgFmUebtXil4KmL35gkXwXaiBPkcIUr0DgZO4YgAXztS+XbYPTo
 +P7H8tR3khN7sYbGBr57G+zHQ/p6aobGAhbPsF4LitcyV81zodGxBk3fjj7sn1mHEVpk
 2OXs6gTi1Wi1fqj/2v/DKtrXCQ+ZqD6VLqbnbuPb1Wza3z8Hn50tTHyNuavGq93oFHwR
 LPLG6GQPAB+TzidXJ/SqjxJ3g5TO97043yPg07evbvgSGXO9FLF4tgpPVWtXAH9zz2/V
 GEyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRGpaOjNNH6VQxKN6YtE/DC0AtP062ys4hWVNKRYgbdbF5zt4ihVKhTLOdXb1Ykez6XGmhOaDYKAqA@nongnu.org
X-Gm-Message-State: AOJu0YxD0IqO6+qX0XgBVKAMysQ5Rpgy9Jgn1DtQ7Yme6DGSk/xF7XRg
 cSvqfQAZ4wOTVtZpsU065Q5Kupx1Wcx2YdsKFhDC0L6KHzp0OHNgJoTAokP471SZrTBZUJsSgVY
 wGr9hucA3MU+8utCk2EsK0SVJtgZIvit371SYWsG8xONFK7+IpfOYkhTCZQ==
X-Gm-Gg: AR+sD12XoWnMoAJ1cxWR+30Sa8hSqyDxe0gE+bFRwHAaof99hXKop6Zxhm4JEA4KovO
 inPOGWxBg90xFkjRZmd2k1BJ97uDFYVgk+WmlIjYM53HMZZ9wnezTY3Fs+PEFgTkex9YPvJu9rS
 BMFi3QtOfCju0DpKA5+kx+tWi1ACDBnMPycDBlj0sQKeyn467EXpdss/Y6qff27sjoiuDYH/m05
 KH8sNEyPi8KXYVWNQvZJPc/dNyqACbBUiCx6h+ZbVFBQKMSFoZAcVxwpiLO9w0cYA7ZuGIG2ifZ
 m+9Zirf9XsgaM8E1cRhmkpKG+7FeSaXNrK7Wm0fh0YJKVH0t1SLwvQJiT7GczzgDUfcjzRjNszm
 WQ8lPw8Cag2hNn//etZBbTqhY8/PKb3Vq3RFI
X-Received: by 2002:ac8:59c5:0:b0:51c:1d0c:605f with SMTP id
 d75a77b69052e-52d0b19328fmr102595441cf.20.1786107704888; 
 Fri, 07 Aug 2026 06:01:44 -0700 (PDT)
X-Received: by 2002:ac8:59c5:0:b0:51c:1d0c:605f with SMTP id
 d75a77b69052e-52d0b19328fmr102594471cf.20.1786107704246; 
 Fri, 07 Aug 2026 06:01:44 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d1659b9fbsm11398841cf.15.2026.08.07.06.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 06:01:43 -0700 (PDT)
Message-ID: <ed5e32ef-db57-4065-afd8-b7f4522d7989@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 10:01:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/misc: Add Tenstorrent Atlantis PRCM model
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260729-atlantis_prcm-v1-0-502882933e51@oss.tenstorrent.com>
 <20260729-atlantis_prcm-v1-1-502882933e51@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729-atlantis_prcm-v1-1-502882933e51@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a75d73a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=ID6ng7r3AAAA:8 a=t9496tuAAAAA:8 a=69wJf7TsAAAA:8 a=vs0fyi-O4r42exvmjJAA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=AkheI1RvQwOzcTXhi5f4:22
 a=4wQ91nGE5lQcD7eh5OX0:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 3My9ZAJTO4cezwUUccSTsu7tWok88l5O
X-Proofpoint-GUID: 3My9ZAJTO4cezwUUccSTsu7tWok88l5O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMiBTYWx0ZWRfX+cgK+5H/vtOs
 hhAcLoTquDMw8KkRdphQNQQgo/WwBLdhIRCDKUQ0CUgWW78dy8r8MnrMxZmyTJFwi2aJ7zc31/0
 FQbXx3w42sM1IaaXxg8rve96FG8Ygao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMiBTYWx0ZWRfXzAiZsRWcH2BI
 fqOn2EBLsai83l7U430Ip+z9kwgY6zTUSTbqdFodKPlSQ1QRBuxKiL+GXDnRzTcnDgh1vpdqz22
 jhL1RZeDBBnrOIzBP+pV4n2j64d8/wL9ZNB5kn3t/Jpqs68Vl65bNdBAInDnihhycl+MBXtYQgV
 BOPrtTMMW0E3MsjlL1F2WVzoqhT2rOkNWk1vogLku3jKNMd8KkFF7x6QHdRWUSWQRN3IUDFO+Ql
 O5xub5iELwlvMFJDnitKLmTXEywveI/Ji83Xpb6EThHg1grqiURIq/2U/1ToKFCl5Udguz/vwUu
 EAOzvO24bF+4Tx2oN2zf3aBQ3Fr8iAZkyJhVCfTj4B92cIBVURtvZwIb1BGWVJ++CJfJ1FsCxvs
 fPNamNZ3VIpfw5PjRHaT0SngiT93G/uaCZ4lZFKr8dO5AEbHo/Vnvsb/jGlCP4bt0c3XfOULaQv
 Tvltjy9K7hXe35oNdoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070102
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

Hello,

On 7/29/2026 12:21 PM, Anirudh Srinivasan wrote:
> This device present in Tenstorrent Atlantis has registers that control
> clocks, reset and other misc functionality in the SoC. This commit adds
> models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
> 
> Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
>   MAINTAINERS                        |   2 +
>   hw/misc/meson.build                |   1 +
>   hw/misc/trace-events               |   4 +
>   hw/misc/tt_atlantis_prcm.c         | 436 +++++++++++++++++++++++++++++++++++++
>   include/hw/misc/tt_atlantis_prcm.h |  51 +++++
>   5 files changed, 494 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e25df9493c..49c1a5ad76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1802,7 +1802,9 @@ R: Portia Stephens <portias@oss.tenstorrent.com>
>   L: qemu-riscv@nongnu.org
>   S: Supported
>   F: docs/system/riscv/tt_*.rst
> +F: hw/misc/tt_*.c
>   F: hw/riscv/tt_*.c
> +F: include/hw/misc/tt_*.h
>   F: include/hw/riscv/tt_*.h
>   F: tests/functional/riscv64/test_tt_*.py
>   
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 23265f6035..26627013f3 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -36,6 +36,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> +system_ss.add(when: 'CONFIG_TENSTORRENT', if_true: files('tt_atlantis_prcm.c'))
>   
>   subdir('macio')
>   
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..9359a4e66d 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -442,3 +442,7 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
>   iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
>   iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
>   iommu_testdev_dma_armed(bool armed) "armed=%d"
> +
> +# tt_atlantis_prcm.c
> +tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> +tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> diff --git a/hw/misc/tt_atlantis_prcm.c b/hw/misc/tt_atlantis_prcm.c
> new file mode 100644
> index 0000000000..d341e1a8c3
> --- /dev/null
> +++ b/hw/misc/tt_atlantis_prcm.c
> @@ -0,0 +1,436 @@
> +/*
> + * PRCM (Clock and Reset Controller) in Tenstorrent Atlantis SoC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2026 Tenstorrent
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/irq.h"
> +#include "trace.h"
> +
> +#define TO_REG(offset) ((offset) >> 2)
> +
> +#define PLL_LOCK_BIT        31
> +#define PLL_FBDIV_LSB       14
> +#define PLL_POSTDIV2_LSB    11
> +#define PLL_POSTDIV1_LSB    8
> +#define PLL_REFDIV_LSB      2
> +#define PLL_BYPASS_BIT      1
> +
> +#define PLL_RESET_VAL(BYPASS, REFDIV, POSTDIV1, POSTDIV2, FBDIV, LOCK)         \
> +  ((LOCK << PLL_LOCK_BIT) | (FBDIV << PLL_FBDIV_LSB) |                         \
> +   (POSTDIV2 << PLL_POSTDIV2_LSB) | (POSTDIV1 << PLL_POSTDIV1_LSB) |           \
> +   (REFDIV << PLL_REFDIV_LSB) | (BYPASS << PLL_BYPASS_BIT))
> +
> +#define RCPU_PLL_RCPU_CFG   TO_REG(0)
> +#define RCPU_PLL_NOCC_CFG   TO_REG(0x4)
> +#define RCPU_NOCC_CLK_CFG   TO_REG(0x8)
> +#define RCPU_RCPU_DIV_CFG   TO_REG(0xc)
> +#define RCPU_RCPU_BLK_CG    TO_REG(0x14)
> +#define RCPU_LSIO_BLK_CG    TO_REG(0x18)
> +#define RCPU_RCPU_BLK_RST   TO_REG(0x1c)
> +#define RCPU_LSIO_BLK_RST   TO_REG(0x20)
> +#define RCPU_PLL_RCPU_EN    TO_REG(0x11c)
> +#define RCPU_PLL_NOCC_EN    TO_REG(0x120)
> +#define RCPU_PLL_MM_EN      TO_REG(0x0124)
> +#define RCPU_PLL1_MM_EN     TO_REG(0x0128)
> +#define RCPU_PLL_HSIO_EN    TO_REG(0x12c)
> +#define RCPU_PLL_PCIE_EN    TO_REG(0x138)
> +#define RCPU_PLL_I2S_EN     TO_REG(0x13C)
> +#define RCPU_PLL_MM_CFG     TO_REG(0x19c)
> +#define RCPU_PLL_HSIO_CFG   TO_REG(0x1a0)
> +#define RCPU_PLL_PCIE_CFG   TO_REG(0x1ac)
> +#define RCPU_BOOT_MODE_CFG  TO_REG(0x1b0)
> +#define RCPU_PLL_I2S_CFG    TO_REG(0x1f4)
> +#define RCPU_I2S_DIV_CFG    TO_REG(0x1f8)
> +#define RCPU_BUS_CFG        TO_REG(0x1fc)
> +#define RCPU_PLL1_MM_CFG    TO_REG(0x2a4)
> +
> +#define HSIO_HSIO_DIV_CFG       TO_REG(0x0)
> +#define HSIO_HSIO_DIV_CFG1      TO_REG(0x4)
> +#define HSIO_HSIO_BLK_CG        TO_REG(0x8)
> +#define HSIO_HSIO_BLK_RST       TO_REG(0xc)
> +#define HSIO_HSIO_GMAC_DIV_CFG  TO_REG(0x10)
> +
> +#define PCIE_SUBS_RST_CTL   TO_REG(0x0)
> +#define PCIE_SUBS_CG_CTL    TO_REG(0x4)
> +#define PCIE_SUBS_CK_CTL    TO_REG(0x8)
> +
> +#define MM_MM_CLK_GATE_CFG  TO_REG(0x8)
> +#define MM_MM_CLK_DIV_CFG   TO_REG(0xC)
> +#define MM_MM_CLK_SEL_CFG   TO_REG(0x10)
> +#define MM_MM_RSTN          TO_REG(0x14)
> +#define MM_MM_CLK_DIV_CFG1  TO_REG(0x130)
> +
> +#define DDRC_STAT           TO_REG(0x10014)
> +#define DDRC_DFISTAT        TO_REG(0x10514)
> +#define DDRC_SWSTAT         TO_REG(0x10c84)
> +
> +#define PLL_EN              BIT(0)
> +#define RCPU_PLL_BUS_CG_EN  BIT(7)
> +#define HSIO_PLL_BUS_CG_EN  BIT(3)
> +#define PCIE_PLL_BUS_CG_EN  BIT(1)
> +#define NOCC_PLL_BUS_CG_EN  BIT(0)
> +
> +#define RCPU_BOOT_MODE_UART      (0x0 << 4)
> +#define RCPU_BOOT_MODE_NOR       (0x1 << 4)
> +#define RCPU_BOOT_MODE_SD        (0x2 << 4)
> +
> +#define RCPU_DOMAIN_SIZE   0x10000
> +#define HSIO_DOMAIN_SIZE   0x510
> +#define PCIE_DOMAIN_SIZE   0x100
> +#define MM_DOMAIN_SIZE     0x1000
> +#define DDRC0_DOMAIN_SIZE  0x101000
> +#define DDRC1_DOMAIN_SIZE  0x101000
> +
> +static uint64_t tt_atlantis_prcm_read(void *opaque, hwaddr offset,
> +                                               unsigned size) {
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +    uint32_t data;
> +
> +    if (offset >= c->regs_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +    data = s->regs[TO_REG(offset)];
> +
> +    trace_tt_atlantis_prcm_read(c->domain, offset, data);
> +    return data;
> +}
> +
> +static void tt_atlantis_prcm_write(void *opaque, hwaddr offset,
> +                                            uint64_t data, unsigned size) {
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    trace_tt_atlantis_prcm_write(c->domain, offset, data);
> +
> +    if (offset >= c->regs_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
> +                      __func__, offset);
> +        return;
> +    }

I'm a bit confused here: in tt_atlantis_prcm_read() we're doing a qemu_log_mask() and
return, and then do a "trace_tt_atlantis...".  So in an error case you'll have just
the qemu_log_mask().   Here we're doing a trace at the start of prcm_write() and then
a qemu_log_mask() if something wrong happens.

There's no rule on how you use trace so there's nothing wrong with both approaches but
would be nice if we could stick with one single approach: either do trace_tt_... during
function start or in function success.  From what I can tell the most common pattern is
the one used in prcm_read(), i.e. qemu_log_mask on errors and trace_ on success.

> +
> +    switch (TO_REG(offset)) {
> +    default:
> +        s->regs[TO_REG(offset)] = data;
> +        break;
> +    }

This switch is doing nothing.  Just do s->regs[TO_REG(offset)] = data directly.


> +}
> +
> +static void tt_atlantis_prcm_rcpu_write(void *opaque, hwaddr offset,
> +                                            uint64_t data, unsigned size) {
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(opaque);
> +
> +    tt_atlantis_prcm_write(opaque, offset, data, size);
> +
> +    bool pll_en_written = false;
> +    uint32_t pll_reg_offset;
> +    switch TO_REG(offset)
> +    {
> +        case RCPU_PLL_RCPU_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_RCPU_CFG;
> +            break;
> +        case RCPU_PLL_NOCC_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_NOCC_CFG;
> +            break;
> +        case RCPU_PLL_HSIO_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_HSIO_CFG;
> +            break;
> +        case RCPU_PLL_PCIE_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_PCIE_CFG;
> +            break;
> +        case RCPU_PLL_MM_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_MM_CFG;
> +            break;
> +        case RCPU_PLL1_MM_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL1_MM_CFG;
> +            break;
> +        case RCPU_PLL_I2S_EN:
> +            pll_en_written = true;
> +            pll_reg_offset = RCPU_PLL_I2S_CFG;
> +            break;
> +    }
> +    if (pll_en_written) {
> +        if (data & PLL_EN) {
> +            s->regs[pll_reg_offset] |= BIT(PLL_LOCK_BIT);
> +        } else {
> +            s->regs[pll_reg_offset] &= ~BIT(PLL_LOCK_BIT);
> +        }
> +    }

Seems like you're using pll_en_written as a flag to detect if we have a match
in the 'switch' and nothing else, since pll_en_written is always being set to
'true'.  And if there's no match in the switch() the function just returns.

I suggest removing pll_en_written and doing a return in a default label.
Something like this:

 > +    uint32_t pll_reg_offset;
 > +    switch TO_REG(offset) {
 > +    case RCPU_PLL_RCPU_EN:
 > +        pll_reg_offset = RCPU_PLL_RCPU_CFG;
 > +        break;
 > +    case RCPU_PLL_NOCC_EN:
 > +        pll_reg_offset = RCPU_PLL_NOCC_CFG;
 > +        break;
 > +    case RCPU_PLL_HSIO_EN:
 > +        pll_reg_offset = RCPU_PLL_HSIO_CFG;
 > +        break;
 > +    case RCPU_PLL_PCIE_EN:
 > +        pll_reg_offset = RCPU_PLL_PCIE_CFG;
 > +        break;
 > +    case RCPU_PLL_MM_EN:
 > +        pll_reg_offset = RCPU_PLL_MM_CFG;
 > +        break;
 > +    case RCPU_PLL1_MM_EN:
 > +        pll_reg_offset = RCPU_PLL1_MM_CFG;
 > +        break;
 > +   case RCPU_PLL_I2S_EN:
 > +        pll_reg_offset = RCPU_PLL_I2S_CFG;
 > +        break;
       default:
            return;
 > +   }

 > +  if (data & PLL_EN) {
 > +      s->regs[pll_reg_offset] |= BIT(PLL_LOCK_BIT);
 > +  } else {
 > +     s->regs[pll_reg_offset] &= ~BIT(PLL_LOCK_BIT);
 > +  }


> +}
> +
> +static const MemoryRegionOps tt_atlantis_prcm_ops = {
> +    .read = tt_atlantis_prcm_read,
> +    .write = tt_atlantis_prcm_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static const MemoryRegionOps tt_atlantis_prcm_rcpu_ops = {
> +    .read = tt_atlantis_prcm_read,
> +    .write = tt_atlantis_prcm_rcpu_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void tt_atlantis_prcm_realize(DeviceState *dev, Error **errp)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    if (c->domain >= PRCM_DOMAIN_COUNT) {
> +        error_setg(errp,
> +                   "domain %d is larger than max number of possible domains %d",
> +                   c->domain, PRCM_DOMAIN_COUNT);
> +        return;
> +    }
> +    s->regs = g_new0(uint32_t, TO_REG(c->regs_size));
> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), c->ops, s,
> +                          TYPE_TT_ATLANTIS_PRCM, c->regs_size);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static void tt_atlantis_prcm_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_GET_CLASS(s);
> +
> +    memset(s->regs, 0, c->regs_size);
> +}
> +
> +static void tt_atlantis_prcm_rcpu_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[RCPU_PLL_RCPU_CFG] = PLL_RESET_VAL(1, 0, 4, 0, 100, 1);
> +    s->regs[RCPU_PLL_NOCC_CFG] = PLL_RESET_VAL(0, 2, 2, 2, 267, 1);
> +    s->regs[RCPU_NOCC_CLK_CFG] = (0x25f31 << 1) | BIT(0);
> +    s->regs[RCPU_RCPU_DIV_CFG] = (0xb8c2 << 1);

There's a lot of the so called 'magic numbers' around the code.  Please put
them in macros and, preferrably, explain where they're coming from (a combination
of reg values, a hardcoded value that the manual/spec dictates, etc).


One more thing:

> +    s->regs[RCPU_RCPU_BLK_CG] = 0;
> +    s->regs[RCPU_LSIO_BLK_CG] = 0;
> +    s->regs[RCPU_RCPU_BLK_RST] = 0xffffffff;
> +    s->regs[RCPU_LSIO_BLK_RST] = 0xffffffff;
> +    s->regs[RCPU_PLL_RCPU_EN] = PLL_EN;
> +    s->regs[RCPU_PLL_NOCC_EN] = PLL_EN;
> +    s->regs[RCPU_PLL_HSIO_EN] = 0;
> +    s->regs[RCPU_PLL_MM_EN] = 0;
> +    s->regs[RCPU_PLL1_MM_EN] = 0;
> +    s->regs[RCPU_PLL_I2S_EN] = 0;
> +    s->regs[RCPU_PLL_PCIE_EN] = 0;
> +    s->regs[RCPU_PLL_HSIO_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 0);
> +    s->regs[RCPU_PLL_PCIE_CFG] = PLL_RESET_VAL(0, 2, 3, 1, 250, 0);
> +    s->regs[RCPU_BOOT_MODE_CFG] = RCPU_BOOT_MODE_SD;
> +    s->regs[RCPU_PLL_MM_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
> +    s->regs[RCPU_PLL1_MM_CFG] = PLL_RESET_VAL(0, 1, 2, 1, 50, 1);
> +    s->regs[RCPU_PLL_I2S_CFG] = PLL_RESET_VAL(0, 1, 6, 6, 33, 0);
> +    s->regs[RCPU_I2S_DIV_CFG] = 0xde69ad31;
> +    s->regs[RCPU_BUS_CFG] = NOCC_PLL_BUS_CG_EN | HSIO_PLL_BUS_CG_EN;
> +}
> +
> +static void tt_atlantis_prcm_ddrc_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[DDRC_STAT] = 0x1;
> +    s->regs[DDRC_DFISTAT] = 0x1;
> +    s->regs[DDRC_SWSTAT] = 0x1;
> +}
> +
> +static void tt_atlantis_prcm_hsio_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[HSIO_HSIO_DIV_CFG] = 0x20821731;
> +    s->regs[HSIO_HSIO_DIV_CFG1] = 0x8;
> +    s->regs[HSIO_HSIO_BLK_CG] = 0;
> +    s->regs[HSIO_HSIO_BLK_RST] = 0;
> +    s->regs[HSIO_HSIO_GMAC_DIV_CFG] = 0;
> +}
> +
> +static void tt_atlantis_prcm_pcie_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[PCIE_SUBS_RST_CTL] = 0;
> +    s->regs[PCIE_SUBS_CG_CTL] = 0;
> +    s->regs[PCIE_SUBS_CK_CTL] = 0x44908;
> +}
> +
> +static void tt_atlantis_prcm_mm_reset(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +    tt_atlantis_prcm_reset(dev);
> +
> +    s->regs[MM_MM_CLK_GATE_CFG] = 0;
> +    s->regs[MM_MM_CLK_DIV_CFG] = 0xddc8312;
> +    s->regs[MM_MM_CLK_SEL_CFG] = 0;
> +    s->regs[MM_MM_RSTN] = 0;
> +    s->regs[MM_MM_CLK_DIV_CFG1] = 0x333;
> +}
> +
> +static void tt_atlantis_prcm_unrealize(DeviceState *dev)
> +{
> +    TTAtlantisPRCMState *s = TT_ATLANTIS_PRCM(dev);
> +
> +    g_free(s->regs);
> +}
> +
> +static void tt_atlantis_prcm_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    dc->unrealize = tt_atlantis_prcm_unrealize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_reset);
> +    dc->desc = "Tenstorrent Atlantis PRCM Controller";
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_rcpu_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_rcpu_reset);
> +    dc->desc = "Tenstorrent Atlantis RCPU PRCM Controller";
> +    c->domain = PRCM_DOMAIN_RCPU;
> +    c->regs_size = RCPU_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_rcpu_ops;
> +}
> +
> +static void tt_atlantis_prcm_hsio_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_hsio_reset);
> +    dc->desc = "Tenstorrent Atlantis HSIO PRCM Controller";
> +    c->domain = PRCM_DOMAIN_HSIO;
> +    c->regs_size = HSIO_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_pcie_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_pcie_reset);
> +    dc->desc = "Tenstorrent Atlantis PCIE PRCM Controller";
> +    c->domain = PRCM_DOMAIN_PCIE;
> +    c->regs_size = PCIE_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_mm_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_mm_reset);

Let's not use the legacy reset interface for new devices - we should use the
Resetabble interface instead.  Here's a straightforward example from
riscv-iommu-sys.c:


static void riscv_iommu_sys_reset_hold(Object *obj, ResetType type)
{
    // reset procedure
}

static void riscv_iommu_sys_class_init(ObjectClass *klass, const void *data)
{
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);

     rc->phases.hold = riscv_iommu_sys_reset_hold;
    (...)


In this case you would do "rc->phases.hold = tt_atlantis_prcm_mm_reset".  Similar
thing for all the other 4 devices that are using legacy_reset() up above too.


Note that if the device requires a more elaborated reset procedure you would need
to do more stuff, but from what I can tell this would be enough for all devices
being added here.  I suggest taking a look at the docs in case you're in doubt
about which reset phases you should implement:

https://www.qemu.org/docs/master/devel/reset.html


Thanks,
Daniel

> +    dc->desc = "Tenstorrent Atlantis MM PRCM Controller";
> +    c->domain = PRCM_DOMAIN_MM;
> +    c->regs_size = MM_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_ddrc0_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_ddrc_reset);
> +    dc->desc = "Tenstorrent Atlantis DDR Memory Controller 0 PRCM";
> +    c->domain = PRCM_DOMAIN_DDRC0;
> +    c->regs_size = DDRC0_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_ddrc1_class_init(ObjectClass *klass,
> +                                                 const void *data) {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TTAtlantisPRCMClass *c = TT_ATLANTIS_PRCM_CLASS(klass);
> +
> +    dc->realize = tt_atlantis_prcm_realize;
> +    device_class_set_legacy_reset(dc, tt_atlantis_prcm_ddrc_reset);
> +    dc->desc = "Tenstorrent Atlantis DDR Memory Controller 1 PRCM";
> +    c->domain = PRCM_DOMAIN_DDRC1;
> +    c->regs_size = DDRC1_DOMAIN_SIZE;
> +    c->ops = &tt_atlantis_prcm_ops;
> +}
> +
> +static const TypeInfo tt_atlantis_prcm_types[] = {
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(TTAtlantisPRCMState),
> +        .class_init = tt_atlantis_prcm_class_init,
> +        .class_size = sizeof(TTAtlantisPRCMClass),
> +        .abstract = true,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_RCPU,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_rcpu_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_HSIO,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_hsio_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_PCIE,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_pcie_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_MM,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_mm_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_DDRC0,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_ddrc0_class_init,
> +    },
> +    {
> +        .name = TYPE_TT_ATLANTIS_PRCM_DDRC1,
> +        .parent = TYPE_TT_ATLANTIS_PRCM,
> +        .class_init = tt_atlantis_prcm_ddrc1_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(tt_atlantis_prcm_types);
> diff --git a/include/hw/misc/tt_atlantis_prcm.h b/include/hw/misc/tt_atlantis_prcm.h
> new file mode 100644
> index 0000000000..acb8a9b38b
> --- /dev/null
> +++ b/include/hw/misc/tt_atlantis_prcm.h
> @@ -0,0 +1,51 @@
> +/*
> + * Clock, Reset, Pinctrl PRCM in Tenstorrent Atlantis SoC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2026 Tenstorrent
> + */
> +
> +#ifndef TT_ATLANTIS_PRCM_H
> +#define TT_ATLANTIS_PRCM_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_TT_ATLANTIS_PRCM "tt.atlantis.prcm"
> +#define TYPE_TT_ATLANTIS_PRCM_RCPU "tt.atlantis.prcm.rcpu"
> +#define TYPE_TT_ATLANTIS_PRCM_HSIO "tt.atlantis.prcm.hsio"
> +#define TYPE_TT_ATLANTIS_PRCM_PCIE "tt.atlantis.prcm.pcie"
> +#define TYPE_TT_ATLANTIS_PRCM_MM "tt.atlantis.prcm.mm"
> +#define TYPE_TT_ATLANTIS_PRCM_DDRC0 "tt.atlantis.prcm.ddrc0"
> +#define TYPE_TT_ATLANTIS_PRCM_DDRC1 "tt.atlantis.prcm.ddrc1"
> +OBJECT_DECLARE_TYPE(TTAtlantisPRCMState, TTAtlantisPRCMClass,
> +                           TT_ATLANTIS_PRCM);
> +
> +
> +enum {
> +    PRCM_DOMAIN_RCPU = 0,
> +    PRCM_DOMAIN_HSIO = 1,
> +    PRCM_DOMAIN_PCIE = 2,
> +    PRCM_DOMAIN_MM = 3,
> +    PRCM_DOMAIN_DDRC0 = 4,
> +    PRCM_DOMAIN_DDRC1 = 5,
> +    PRCM_DOMAIN_COUNT = 6
> +};
> +
> +struct TTAtlantisPRCMState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t *regs;
> +};
> +
> +struct TTAtlantisPRCMClass {
> +    SysBusDeviceClass parent_class;
> +
> +    uint32_t domain;
> +    uint32_t regs_size;
> +    const MemoryRegionOps *ops;
> +};
> +
> +#endif
> 


