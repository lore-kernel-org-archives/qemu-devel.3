Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE82606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GFC8HNxH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J7osPM5R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3m1-0003uw-OS; Wed, 28 Oct 2026 09:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prajwal.n@oss.qualcomm.com>)
 id 1xM3lt-0003tn-Ad
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:32:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prajwal.n@oss.qualcomm.com>)
 id 1xM3lq-0007Mz-S0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:32:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBduZR2082334
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n6BYAif61YNxLMR26cNQmvYoHVQuGk4/6A2sFyMuB8E=; b=GFC8HNxHhvCPrBuy
 lV4lOl0ARmJDb3yevQWz8ESBhnZO6hkRvajj93RcEjvSOqv2iAPx1CTIxUBJ5BCa
 18jy80uGBXF7mPZOn9fEiAcr8TkORwrOxhGHJW6WSqu81Tqxv+4Ljk8dsKo7ehFN
 5z7Vnese8SVWj+UaRXZR97ttSa4Gflt0UB7ZoqPHqOB+83jDW85pOE7izg1yjXMy
 QqW/fvrI4wleWILg/b1lgLRl8lDbQOJDqpz6hiCFxC5kpTbfJ+iC34tOF2DdEPoT
 U+CDIUEfqOFUk4q3v5EueAneIpPZGb/+Sefcqpa1ctvUFLTT1yyzs7eP6QdU50lY
 6wvFPQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjpv6w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:32:48 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7cc2c29ba27so254402137.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793194367; x=1793799167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n6BYAif61YNxLMR26cNQmvYoHVQuGk4/6A2sFyMuB8E=;
 b=J7osPM5RLTV7HzgB54VuG38Z1ZbkpD9PQc2FY9vZkUNT2tUlMRZGur/lDOxfyZ6Iwb
 v5RrAQiDo5K9AiLCy1cSEyGI1IJPFUmqxK28dbX2Oc14PDpGWGRsfKmr0qrdrPXYJuxl
 CuiKCWEEBjvpHw5W4wTxdhSP/EMDSgkcK+5I5htv7r1ZKBDgccxpY+/SGjHBXlDzmbe9
 5VGmIBfQO0ZBVvoKsiD2OTJjEyte1d0iQn3ie1Srm8GDzGwna25hlPncs+a0OYH+brNK
 k6qaIM92FCLDqk7kXBn0lai7P7PgqAKjktqPPVk1UP5w3rpxtMN/MXI/ckK2AHkEMtgt
 T2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194367; x=1793799167;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n6BYAif61YNxLMR26cNQmvYoHVQuGk4/6A2sFyMuB8E=;
 b=lDuGesmB8tAWt3Yi4tpVktofUQlcn40KYGqEH+SPz9MnXF9t3FX85ghzUCLbg/1omu
 G8A+GUB3WadwTrvaOO+2lfmpAsbwhiFFefZcvDznY1YN2r5yhdNesElGBDpM4gKealM/
 0grq/6A8yQBDN7hzOM3ZJJ9gaRk2ZEh0dVKZ06m+LguDz0H7o4lPY1nAE57voqirF4od
 mklgJ1RZeT0ro4zSjoXvNoux+0ZNJNU1bXmfO+DEqA63U+q1jK5HCg1CS+2wJeGhVuBI
 6jyWTm5iqFW8a0HpQLJ/1mMXK4xqDVd/oVOLvJv+jTz0hz+kqicBx6mQj+Wpe3xvZWkw
 FZcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByPmz5tUVkHYlPtVkG6j0/TtUPDQThy9QNwjoiW1W86b0Boa387b6+zEmc5dMScUUQb36vNcg6gtdkx@nongnu.org
X-Gm-Message-State: AFq9FYLNroa6r7kCuQCAJNUHJzxa0PqEPMuS+6xFCbhjk4tHboTou+4Y
 YjTi2k/IcIWFPciP9/0ENDpDAXdBAzfQ47XzCv7HQBlru6SvexQq6a5UhzRJ9qbhBCzE5FZwZYG
 UA2HTSgQRcD26+d4lxZ0C8B79kX/sieQ9Bq3+1WikSnU85zxPjkDUz6eN9Q==
X-Gm-Gg: AYBFou0s+5kK9RCI9GCWpH30K3/vV3zPj8CFiMdlw5o2sTSStExf01ha+t9W1QZRd5f
 rntZfRNsYC0wPg9OJPLTPMU4VEh1Jp5A4SdMC+OvaXTGwLLgWte3U1mLjCoMwQ6gQWAG77sm1+Y
 A2XVnLa5zxYRNCV1RjX0/AEvjRqUhT3d0iujb9kCUTEgsWBgIC5GDfgS1CsDW1TTtFjpSiKosP2
 bzphw9Y3qzL+vXTOIU3m5UkfMZJ1YdbNwfY9ajAv/wk2rUr87GrL8AOmvzwByuuEApRg0V8PqIg
 /FrQEpNWexk6MDbIrg4wGHyZpTXMK/BD/qjb05zMV7FfVyA+vrqTh+GJ/Sv0AgJq0kMbb6rL+bp
 A1lPW4hBnlEm5st5PdAteY2ywvMurnkvG9DdVEYiq10129wjHvFO7F7vVahpIK4NmkRUaduMemA
 ==
X-Received: by 2002:a05:6102:3fa6:b0:7cc:23e7:e743 with SMTP id
 ada2fe7eead31-7d03a5581a0mr949575137.15.1793194366960; 
 Wed, 28 Oct 2026 06:32:46 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa6:b0:7cc:23e7:e743 with SMTP id
 ada2fe7eead31-7d03a5581a0mr949552137.15.1793194366440; 
 Wed, 28 Oct 2026 06:32:46 -0700 (PDT)
Received: from [192.168.1.6] ([125.99.240.160])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfca5bd75bsm571829e87.79.2026.10.28.06.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 06:32:45 -0700 (PDT)
Message-ID: <b789deea-1d49-4d3e-8203-58ff42fcb930@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 19:02:32 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] hw/riscv: implement CBQRI capacity controller
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn, prajwal.n.oss@gmail.com
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
 <20261026-riscv-ssqosid-cbqri-v6-3-1a367a35cd0e@kernel.org>
Content-Language: en-US
From: Prajwal N <prajwal.n@oss.qualcomm.com>
In-Reply-To: <20261026-riscv-ssqosid-cbqri-v6-3-1a367a35cd0e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1MyBTYWx0ZWRfX5EIq7qLJsBB8
 7BDy3LcXPke/5EISMWpN43wce/P6bHpBhmrFJNbPj2wE+mM3ehhyZsQIHPXBF7wreIm7EaaT01b
 /5TRgptoF0e2/TXgLhB4pZM2PTnJUJm9hiWoAIWCVUZkpZfFlNq0DEwHO4kwq0s/39O+cpsq6aJ
 uYQ8V0lh6I9//wKEcHq1wfH/yPLqnPp8vy6g5dphmgPO24fw2NbM0KGnht+4P0Dl+hSUAktW+3A
 LiP4Y/DKFmCrHrp/KOxMf4E2g9fQYXraPoEPjjCbFTMTay0qoPxb+cXaZtE8s16Fx2Oex+FvrXL
 CvahsNEWyZtJASz6Y7l0Z6J2nQl+uWk/WdjaZUyTNWy7MNFQMA0sSNnhQtPHftEGyoZsdxtVKpT
 fdQZh//A73YIy+82gk68uNPRAs1Wc7Z8ydNoF6/f1U9N4nT5iir9OzUw785leXqQgUyE8NQsKMZ
 htJbAR9nxSp9to9iAwQ==
X-Proofpoint-ORIG-GUID: OUupgFt2Mfl2Jf8zih6TxNVyLG_cxbtX
X-Proofpoint-GUID: OUupgFt2Mfl2Jf8zih6TxNVyLG_cxbtX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1MyBTYWx0ZWRfX1HdkJ8rQCmlT
 WjXc0UGk3/HfDazDY3VrObxA5KnoVnqsNVscThg3Ifj7P+QDs93sgJTC9GEkybgMbPsc6SYuZHk
 G3mnsDLrhDinJytYD1oZwge3GZ8nov0=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae1f980 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=GuUutMOJDLuJj3+4/pSvWA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=V1jnuoLLAAAA:20 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=69wJf7TsAAAA:8 a=2KBuwwOf-fcKeFyZZlUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=IawgGOuG5U0WyFbmm1f5:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280053
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=prajwal.n@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Drew,

On 26-10-2026 23:17, Drew Fustini wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Implement a capacity controller according to the Capacity and Bandwidth
> QoS Register Interface (CBQRI) which supports these capabilities:
> 
>   - Number of access types: 2 (code and data)
>   - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>   - Event IDs supported: None, Occupancy
>   - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID
> 
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> [fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
> Reviewed-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS               |   1 +
>  hw/riscv/cbqri_capacity.c | 727 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 728 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2984779ce43a..f230cdbbe1b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -408,6 +408,7 @@ M: Nicolas Pitre <npitre@baylibre.com>
>  M: Drew Fustini <fustini@kernel.org>
>  L: qemu-riscv@nongnu.org
>  S: Supported
> +F: hw/riscv/cbqri_capacity.c
>  F: include/hw/riscv/cbqri.h
>  
>  RISC-V SiFive (Xsf*) extensions
> diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> new file mode 100644
> index 000000000000..7ea20532b950
> --- /dev/null
> +++ b/hw/riscv/cbqri_capacity.c
> @@ -0,0 +1,727 @@
> +/*
> + * RISC-V Capacity and Bandwidth QoS Register Interface
> + * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> + *
> + * Copyright (c) 2023 BayLibre SAS
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This file contains the Capacity-controller QoS Register Interface.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/bitmap.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/sysbus.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/cbqri.h"

[...]

> +static void riscv_cbqri_cc_write(void *opaque, hwaddr addr,
> +                                 uint64_t value, unsigned size)
> +{
> +    RiscvCbqriCapacityState *cc = opaque;
> +
> +    assert((addr % 8) == 0);
> +
The same comments in the riscv_cbqri_cc_read() below are applicable
here as well.

> +    switch (addr) {
> +    case A_CC_CAPABILITIES:
> +        /* read-only register */
> +        break;
> +    case A_CC_MON_CTL:
> +        riscv_cbqri_cc_write_mon_ctl(cc, value);
> +        break;
> +    case A_CC_ALLOC_CTL:
> +        riscv_cbqri_cc_write_alloc_ctl(cc, value);
> +        break;
> +    case A_CC_MON_CTR_VAL:
> +        /* read-only register */
> +        break;
> +    case A_CC_BLOCK_MASK:
> +        if (cc->ncblks == 0) {
> +            break;
> +        }
> +        /* fallthrough */
> +    default:
> +        uint32_t blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
> +        if (blkmask_slot == get_slots(cc)) {
> +            /* this is cc_cunits register */
> +            break;
> +        } else if (blkmask_slot > get_slots(cc)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: out of bounds (addr=0x%x)",
> +                          __func__, (uint32_t)addr);
> +            break;
> +        }
> +        cc->alloc_blockmasks[blkmask_slot] = value;
> +    }
> +}
> +
> +static uint64_t riscv_cbqri_cc_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RiscvCbqriCapacityState *cc = opaque;
> +    uint64_t value = 0;
> +
> +    assert((addr % 8) == 0);
> +
To access the 64 bit CBQRI register, the Linux kernel is performing two
32 bit reads. The register offsets that are passed to this function are 0x00,
0x04, 0x08 ... The assert is triggered for the addr 0x04, 0x0c.. and the
QEMU exists.
This check should have been:
assert((addr %4) == 0)

The switch statement uses the register offsets that are 8-byte aligned.
A_CC_CAPABILITIES (0x00), A_CC_MON_CTL (0x08) etc.
Since the kernel invokes read twice, the second readl() has the offset addr
0x04. This does not match any offset and falls into the default case.
The following change fixes the problem.

       hwaddr reg_addr = addr & ~7ULL; /* align down to 8-byte boundary */> +    switch (addr) {
       switch (reg_addr) {> +    case A_CC_CAPABILITIES:
> +        value = FIELD_DP64(value, CC_CAPABILITIES, VER_MAJOR,
> +                           RISCV_CBQRI_VERSION_MAJOR);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, VER_MINOR,
> +                           RISCV_CBQRI_VERSION_MINOR);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, NCBLKS,
> +                           cc->ncblks);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, FRCID,
> +                           cc->supports_alloc_op_flush_rcid);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, CUNITS, 0);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, RPFX, 0);
> +        value = FIELD_DP64(value, CC_CAPABILITIES, P, 0);
> +        break;
> +    case A_CC_MON_CTL:
> +        value = cc->cc_mon_ctl;
> +        break;
> +    case A_CC_ALLOC_CTL:
> +        value = cc->cc_alloc_ctl;
> +        break;
> +    case A_CC_MON_CTR_VAL:
> +        value = cc->cc_mon_ctr_val;
> +        break;
> +    case A_CC_BLOCK_MASK:
> +        if (cc->ncblks == 0) {
> +            break;
> +        }
> +        /* fallthrough */
> +    default:
> +        unsigned int blkmask_slot = (addr - A_CC_BLOCK_MASK) / 8;
> +        if (blkmask_slot == get_slots(cc)) {
> +            /*
> +             * The cc_cunits register is always the slot following the
> +             * last slot of cc_blockmask register. Capacity units are
> +             * not supported by this implementation so must return 0.
> +             */
> +            value = 0;
> +            break;
> +        } else if (blkmask_slot > get_slots(cc)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: out of bounds (addr=0x%x)",
> +                          __func__, (uint32_t)addr);
> +            break;
> +        }
> +        value = cc->alloc_blockmasks[blkmask_slot];
> +    }
> +
The logic within the switch statement always computes the full 64-bit register
value. But the Linux kernel requested for 32 bits. The kernel is creating a
64-bit value with the two 32-bit values. This should return only the relevant half.
The following code snippet fixed the problem.
    /* Return the correct 32-bit */
    if (size == 4) {
        if (addr & 4)
            return value >> 32;   // high word
        else
            return value & 0xffffffff;  // low word
    }

Thanks,
Prajwal N


