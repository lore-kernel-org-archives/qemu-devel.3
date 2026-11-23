Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD4606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fQ3iRoIe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aEdnk7CU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVuz-0003eD-Db; Mon, 23 Nov 2026 10:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVVs1-0001Zq-K0
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:22:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVVrx-0003h6-To
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:22:17 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKx6v2442745
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 15:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xJJIVmZsr/azCupOcwZm5Gpu3ieYBgSkOHh2c8v4qhw=; b=fQ3iRoIe4Cy1g6Xz
 /X0xV/BTuaEvwnYMMsy5zOffnf1tHj5it0CxtOVublaQLRO7ROvkYa9woudyNo0b
 yxFB6pNHEU7kiEIBO17GNTpyneI2Uy1Y2cqRAA/h5z6Qu3/AieCXLZtcJkaFy3k/
 RpZrvo59uVEr4t3CpT9GjqJTC4l7jKHt92cNpmLN/XeCtckCnypyfztHnvDu4Bhz
 me16LguIA7X7Fqe+sQetmcGhhqez+La34Il6dOJKMnpuCEH+gP0qrobFEq+8rQ7Q
 +iIgsyUVkoDPz3JfROIIF601KgYeuJHE2lRsByWr0156qC86AE7rMSI+gNQ4oRfu
 vZNODQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k21m8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 15:22:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94960131b4eso633374185a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795447330; x=1796052130; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xJJIVmZsr/azCupOcwZm5Gpu3ieYBgSkOHh2c8v4qhw=;
 b=aEdnk7CUTk9RMyo9JSQJ7EHMW/c9Q8qqWVhICyaBdJnfgclVqgSxn8hgmRaU+qd0eT
 5LyS7aUdB7GwupLy1iIN7Govk6REWdE1yAMQRayOJzIuUd0aHmoLjw25780FmhJoDlYA
 o0PyeHUxFiw1fOW8THXKTp+nvhAPPLqIdlwsoY7AtxsknRBm9Qgm1hRJcf/rb+7J2qrL
 RgGX7W2gu4j56oGaXq8j2mn8mJs/HmLwOEIt6RX/YsqnvWafS+A+fjNu4dVvaTk+oGZf
 BhQ4nU1WSKV6rkbmew7im8GNIE0F8ZqZoAHg8rDAx+/D7Cih8Z8w/RPdNO9+oaqtbdn/
 jU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795447330; x=1796052130;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJJIVmZsr/azCupOcwZm5Gpu3ieYBgSkOHh2c8v4qhw=;
 b=RUgvt5VqRG6gEN4A23KUWSCtO1vP2uifjwiSr1lg6CPIqgb8r/bxVwSpbC6fyU2hEp
 RrOkwH/V+hfKGm4M709IVZ2CbfZdIJbKYetBLJrGnxDYxIHt1DW1wCeqiuaPGGDbCTTs
 xi7781BrakKPEEAAJYx3LZEX0N6Ve+kEDfOVraVyrcr+MeF14Unx3M1BbUO3acvA/p0p
 fO3QdySL09ahcMT5V3JRbd13ZJDuUam0jm3aOw68Yos4tY1KvSdcUGa9xwDiZPFaamC0
 qwDNuEB9IMd6TvhmvDXdksOz/CgCTS3sC4VFqI1ucLu7T0OMWbKHCQJjyVhIk7SmkYWa
 f1bA==
X-Forwarded-Encrypted: i=1;
 AL+hErGApo5VOSwz5j+ACdYLNTh7oUfMs8/RPkUOMolDpAnSE3AQU7FfgTkppqUVi36QiNxh1/Qklrc4hKSi@nongnu.org
X-Gm-Message-State: APuU4Z9+qj9BDkOPFmKpsDc3Xctp7Nveb580NysRcr+ueoS9AYIf+EfR
 l+6PxqmQQVUWatp7D8xoW/LhDgbNI44e8s9nJANQJp2ozDoY9N0/3136H+ZI05zeF5P29/9w9s3
 asAYZ63ARB0JUb3Y0nO4AhCzrKrKlT6a/acaGRo2hR7aoI9cJIhxa0X6SxQ==
X-Gm-Gg: AZFdTZfCXSTZW7eDcXjRlcV7FrhaNOA/i8BmJCN8gL/n1YClSXLixsP0N3yUZlK1wxH
 Apzn36IZ2+SOdmBdqzQYzwAAcMsKG5s91qjGnQDcukP9tq2YrfCsMgq4oCY6xuhmEZNtkk2Alj9
 pZxlkP4UyKSV2zyLyjkKd+dkASWIjpiz7BferbeIlX9Ar3eXa1u0E2qs/IgGADfGxQt0TNKAd9k
 3JX7QHql5prmk/DIN7lWzToF3gZi0zvfLmeHBkn6T9pAFWv+SdTALzx7cVix8Hw0zCB9PXhbADM
 ng7QQh2EngebQXahex/lYETj/XXFE/9HuSTKgnAbotzcz4dWFD5xGFqZhY4Wx+b90GyUMJDDm7x
 /BGuRJMKyC2wocYgokugalq9ALbSVUsn7p6n9EvTMak59V2+D5zs30jIfWq7Tu7DeEd/B7PJmnN
 rZBihX1IWt
X-Received: by 2002:a05:620a:3715:b0:944:2e2e:69cc with SMTP id
 af79cd13be357-949bab310efmr2076052985a.49.1795447329361; 
 Mon, 23 Nov 2026 07:22:09 -0800 (PST)
X-Received: by 2002:a05:620a:3715:b0:944:2e2e:69cc with SMTP id
 af79cd13be357-949bab310efmr2076045585a.49.1795447328511; 
 Mon, 23 Nov 2026 07:22:08 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3f1ee7sm822069885a.28.2026.11.23.07.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 07:22:07 -0800 (PST)
Message-ID: <87e5d269-d875-4afb-87cf-2b2658a7b740@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 12:22:03 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] hw/riscv: implement CBQRI bandwidth controller
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
References: <20261111-riscv-ssqosid-cbqri-v8-0-121f6dcfb573@kernel.org>
 <20261111-riscv-ssqosid-cbqri-v8-4-121f6dcfb573@kernel.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111-riscv-ssqosid-cbqri-v8-4-121f6dcfb573@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfXxFhkR6tcAmze
 f5VHFaZ+9/SsNQ2SYaGQSPji6AJOcu4gXmYM8P9mB2ppx745lbIByFcRmTfrYC4uJaOP6gNKrIi
 yBXUCLo/G0o7ZPMEe2LVTqBNtj6wzS8=
X-Proofpoint-GUID: bLFiYkmCMc50Kv-K90Vmf0EUEocbRprr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfXwa2nGSAbFWMu
 9DRERryDAP4TQDdOjYMdSSM3DX+04f8Od1jgOdXncNC/9Arr0vFy1OzvZU19kndpx6IbvknRxZv
 6XqcmVAtipto6YmazGXkbfH/G//7Bd1JBCgZaLOaSiaBMCRH70V3Rgc2iFjG/dPtvasNDf+220I
 aF/HU9Ffj9oBTAp5DSt3FTKKNdW1XE1PZOw4dpWl0AlBz4j+DUGcbWU9P1h0Yg9gTII24v5cBJ2
 H5ojJqFHt3e7jtgTLmfygdAwK0Vc2z+0O1UfG1a7EJjkQIiwnJLceuvccEszFEVTPXJTEdeWoSe
 1aqRKshm5YcbMfGU645nZbxhkwc21wuih4PDD7RnyNEO5KNSUS/WgGfF7a27l29tvO7Tx+dFjml
 BqgvhOkBAyYYMSm8vC4BDemKmIiAHCowUTXtJ1Bq63v86As4Y7lqInBCahoMj34QVbe0kNlsdS0
 MMtxJ/i46E9wP82JQ8Q==
X-Proofpoint-ORIG-GUID: bLFiYkmCMc50Kv-K90Vmf0EUEocbRprr
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b045a22 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=V1jnuoLLAAAA:20 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=GlkQm2ccxiN7A8ySaBkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=IawgGOuG5U0WyFbmm1f5:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230061
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 8:38 PM, Drew Fustini wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Implement a bandwidth controller according to the Capacity and Bandwidth
> QoS Register Interface (CBQRI) which supports these capabilities:
> 
>    - Number of access types: 2 (code and data)
>    - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>    - Event IDs supported: None, Total read/write byte count, Total
>                           read byte count, Total write byte count
>    - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
> 
> The controller gives the Linux resctrl support for CBQRI a device to
> configure and read back bandwidth limits per RCID on the virt machine.
> Only the register interface is modeled. The configured limits are not
> enforced and the monitoring counters are always marked INVALID because
> QEMU does not model memory bandwidth usage.
> 
> Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> [fustini: rebase, add fields introduced in the ratified spec]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                |   1 +
>   hw/riscv/cbqri_bandwidth.c | 750 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 751 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f230cdbbe1b8..6d68b839febc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -408,6 +408,7 @@ M: Nicolas Pitre <npitre@baylibre.com>
>   M: Drew Fustini <fustini@kernel.org>
>   L: qemu-riscv@nongnu.org
>   S: Supported
> +F: hw/riscv/cbqri_bandwidth.c
>   F: hw/riscv/cbqri_capacity.c
>   F: include/hw/riscv/cbqri.h
>   
> diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
> new file mode 100644
> index 000000000000..bd8cf2b50e4c
> --- /dev/null
> +++ b/hw/riscv/cbqri_bandwidth.c
> @@ -0,0 +1,750 @@
> +/*
> + * RISC-V Capacity and Bandwidth QoS Register Interface
> + * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> + *
> + * Copyright (c) 2023 BayLibre SAS
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This file contains the Bandwidth-controller QoS Register Interface.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/cbqri.h"
> +
> +/* Property defaults, shared with riscv_cbqri_bc_caps_init() */
> +#define BC_DEFAULT_MAX_MCIDS    256
> +#define BC_DEFAULT_MAX_RCIDS    64
> +#define BC_DEFAULT_NBWBLKS      1024
> +#define BC_DEFAULT_MRBWB        819
> +
> +/* Encodings of `AT` field */
> +enum {
> +    BC_AT_DATA = 0,
> +    BC_AT_CODE = 1,
> +    BC_NB_ATS,
> +};
> +
> +/* Capabilities */
> +REG64(BC_CAPABILITIES, 0);
> +FIELD(BC_CAPABILITIES, VER, 0, 8);
> +FIELD(BC_CAPABILITIES, VER_MINOR, 0, 4);
> +FIELD(BC_CAPABILITIES, VER_MAJOR, 4, 4);
> +FIELD(BC_CAPABILITIES, NBWBLKS, 8, 16);
> +FIELD(BC_CAPABILITIES, RPFX, 24, 1);
> +FIELD(BC_CAPABILITIES, P, 25, 4);
> +FIELD(BC_CAPABILITIES, MRBWB, 32, 16);
> +
> +/* Usage monitoring control */
> +REG64(BC_MON_CTL, 8);
> +FIELD(BC_MON_CTL, OP, 0, 5);
> +FIELD(BC_MON_CTL, AT, 5, 3);
> +FIELD(BC_MON_CTL, MCID, 8, 12);
> +FIELD(BC_MON_CTL, EVT_ID, 20, 8);
> +FIELD(BC_MON_CTL, ATV, 28, 1);
> +FIELD(BC_MON_CTL, STATUS, 32, 7);
> +FIELD(BC_MON_CTL, BUSY, 39, 1);
> +
> +/* Usage monitoring operations */
> +enum {
> +    BC_MON_OP_CONFIG_EVENT = 1,
> +    BC_MON_OP_READ_COUNTER = 2,
> +};
> +
> +/* Bandwidth monitoring event ID */
> +enum {
> +    BC_EVT_ID_None = 0,
> +    BC_EVT_ID_RDWR_count = 1,
> +    BC_EVT_ID_RDONLY_count = 2,
> +    BC_EVT_ID_WRONLY_count = 3,
> +};
> +
> +/* BC_MON_CTL.STATUS field encodings */
> +enum {
> +    BC_MON_CTL_STATUS_SUCCESS = 1,
> +    BC_MON_CTL_STATUS_INVAL_OP = 2,
> +    BC_MON_CTL_STATUS_INVAL_MCID = 3,
> +    BC_MON_CTL_STATUS_INVAL_EVT_ID = 4,
> +    BC_MON_CTL_STATUS_INVAL_AT = 5,
> +};
> +
> +/* Monitoring counter value */
> +REG64(BC_MON_CTR_VAL, 16);
> +FIELD(BC_MON_CTR_VAL, CTR, 0, 62);
> +FIELD(BC_MON_CTR_VAL, INVALID, 62, 1);
> +FIELD(BC_MON_CTR_VAL, OVF, 63, 1);
> +
> +/* Bandwidth Allocation control */
> +REG64(BC_ALLOC_CTL, 24);
> +FIELD(BC_ALLOC_CTL, OP, 0, 5);
> +FIELD(BC_ALLOC_CTL, AT, 5, 3);
> +FIELD(BC_ALLOC_CTL, RCID, 8, 12);
> +FIELD(BC_ALLOC_CTL, STATUS, 32, 7);
> +FIELD(BC_ALLOC_CTL, BUSY, 39, 1);
> +
> +/* Bandwidth allocation operations */
> +enum {
> +    BC_ALLOC_OP_CONFIG_LIMIT = 1,
> +    BC_ALLOC_OP_READ_LIMIT = 2,
> +};
> +
> +/* BC_ALLOC_CTL.STATUS field encodings */
> +enum {
> +    BC_ALLOC_STATUS_SUCCESS = 1,
> +    BC_ALLOC_STATUS_INVAL_OP = 2,
> +    BC_ALLOC_STATUS_INVAL_RCID = 3,
> +    BC_ALLOC_STATUS_INVAL_AT = 4,
> +    BC_ALLOC_STATUS_INVAL_BLKS = 5,
> +};
> +
> +/* Bandwidth allocation */
> +REG64(BC_BW_ALLOC, 32);
> +FIELD(BC_BW_ALLOC, Rbwb, 0, 16);
> +FIELD(BC_BW_ALLOC, Mweight, 20, 8);
> +FIELD(BC_BW_ALLOC, sharedAT, 28, 3);
> +FIELD(BC_BW_ALLOC, useShared, 31, 1);
> +
> +
> +typedef struct RiscvCbqriBandwidthAllocation {
> +    uint32_t Rbwb:16;
> +    uint32_t Mweight:8;
> +    uint32_t sharedAT:3;
> +    bool useShared:1;
> +} RiscvCbqriBandwidthAllocation;
> +
> +typedef struct RiscvCbqriBandwidthState {
> +    SysBusDevice parent_obj;
> +    MemoryRegion mmio;
> +
> +    /* cached value of some registers */
> +    uint64_t bc_mon_ctl;
> +    uint64_t bc_mon_ctr_val;
> +    uint64_t bc_alloc_ctl;
> +
> +    RiscvCbqriMonitorCounter *mon_counters;
> +    RiscvCbqriBandwidthAllocation *bw_allocations;
> +
> +    /* properties */
> +
> +    uint64_t mmio_base;
> +    uint16_t nb_mcids;
> +    uint16_t nb_rcids;
> +
> +    uint16_t nbwblks;
> +    uint16_t mrbwb;
> +
> +    bool supports_at_code;
> +
> +    bool supports_alloc_op_config_limit;
> +    bool supports_alloc_op_read_limit;
> +
> +    bool supports_mon_op_config_event;
> +    bool supports_mon_op_read_counter;
> +
> +    bool supports_mon_evt_id_none;
> +    bool supports_mon_evt_id_rdwr_count;
> +    bool supports_mon_evt_id_rdonly_count;
> +    bool supports_mon_evt_id_wronly_count;
> +} RiscvCbqriBandwidthState;
> +
> +#define RISCV_CBQRI_BC(obj) \
> +    OBJECT_CHECK(RiscvCbqriBandwidthState, (obj), TYPE_RISCV_CBQRI_BC)
> +
> +/*
> + * All bandwidth allocation records are contiguous to simplify
> + * allocation. The first one is used to hold the BC_BW_ALLOC register
> + * content, followed by respective records for each AT per RCID.
> + *
> + * Records are indexed by the AT encoding, so each RCID has one record
> + * per AT value whether or not the controller supports the code access
> + * type. is_valid_at() rejects an unsupported AT before a record is
> + * selected.
> + */
> +static unsigned int bw_alloc_index(uint32_t rcid, uint32_t at)
> +{
> +    g_assert(at < BC_NB_ATS);
> +
> +    return 1 + rcid * BC_NB_ATS + at;
> +}
> +
> +static RiscvCbqriBandwidthAllocation *get_bw_alloc(RiscvCbqriBandwidthState *bc,
> +                                                   uint32_t rcid, uint32_t at)
> +{
> +    return &bc->bw_allocations[bw_alloc_index(rcid, at)];
> +}
> +
> +static uint32_t bandwidth_config(RiscvCbqriBandwidthState *bc,
> +                                 uint32_t rcid, uint32_t at,
> +                                 bool *busy)
> +{
> +    RiscvCbqriBandwidthAllocation *bw_alloc = get_bw_alloc(bc, rcid, at);
> +    RiscvCbqriBandwidthAllocation *end = get_bw_alloc(bc, bc->nb_rcids, 0);
> +    RiscvCbqriBandwidthAllocation *cur;
> +    uint32_t rbwb = bc->bw_allocations[0].Rbwb;
> +    uint64_t sum = rbwb;
> +
> +    /*
> +     * When useShared is set the allocation of sharedAT applies instead
> +     * and the Rbwb and Mweight fields are ignored.
> +     */
> +    if (bc->bw_allocations[0].useShared) {
> +        *bw_alloc = bc->bw_allocations[0];
> +        return BC_ALLOC_STATUS_SUCCESS;
> +    }
> +
> +    /*
> +     * Bandwidth is allocated in multiples of bandwidth blocks, and the
> +     * value in Rbwb must be at least 1 and must not exceed the MRBWB value.
> +     */
> +    if (rbwb < 1 || rbwb > bc->mrbwb) {
> +        return BC_ALLOC_STATUS_INVAL_BLKS;
> +    }
> +
> +    /*
> +     * The sum of Rbwb allocated across all RCIDs must not exceed MRBWB
> +     * either. The allocation being replaced and allocations shared with
> +     * another access type do not count.
> +     */
> +    for (cur = &bc->bw_allocations[1]; cur < end; cur++) {
> +        if (cur != bw_alloc && !cur->useShared) {
> +            sum += cur->Rbwb;
> +        }
> +    }
> +    if (sum > bc->mrbwb) {
> +        return BC_ALLOC_STATUS_INVAL_BLKS;
> +    }
> +
> +    /* Save contents of BC_BW_ALLOC register for this rcid and at */
> +    *bw_alloc = bc->bw_allocations[0];
> +    return BC_ALLOC_STATUS_SUCCESS;
> +}
> +
> +static uint32_t bandwidth_read(RiscvCbqriBandwidthState *bc,
> +                               uint32_t rcid, uint32_t at,
> +                               bool *busy)
> +{
> +    RiscvCbqriBandwidthAllocation *bw_alloc = get_bw_alloc(bc, rcid, at);
> +
> +    /* Populate BC_BW_ALLOC register with selected content */
> +    bc->bw_allocations[0] = *bw_alloc;
> +    return BC_ALLOC_STATUS_SUCCESS;
> +}
> +
> +static bool is_valid_at(RiscvCbqriBandwidthState *bc, uint32_t at)
> +{
> +    switch (at) {
> +    case BC_AT_DATA:
> +        return true;
> +    case BC_AT_CODE:
> +        return bc->supports_at_code;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static void riscv_cbqri_bc_write_mon_ctl(RiscvCbqriBandwidthState *bc,
> +                                         uint64_t value)
> +{
> +    if (!bc->supports_mon_op_config_event &&
> +        !bc->supports_mon_op_read_counter) {
> +        /* monitoring not supported: leave mon_ctl set to 0 */
> +        return;
> +    }
> +
> +    /* extract writable fields */
> +    uint32_t op = FIELD_EX64(value, BC_MON_CTL, OP);
> +    uint32_t at = FIELD_EX64(value, BC_MON_CTL, AT);
> +    uint32_t mcid = FIELD_EX64(value, BC_MON_CTL, MCID);
> +    uint32_t evt_id = FIELD_EX64(value, BC_MON_CTL, EVT_ID);
> +    bool atv = FIELD_EX64(value, BC_MON_CTL, ATV);
> +
> +    /* extract read-only fields */
> +    uint32_t status = FIELD_EX64(bc->bc_mon_ctl, BC_MON_CTL, STATUS);
> +    bool busy = FIELD_EX64(bc->bc_mon_ctl, BC_MON_CTL, BUSY);
> +
> +    if (busy) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: busy flag still set, ignored\n",
> +                      __func__);
> +        return;
> +    }
> +
> +    if (!bc->supports_at_code) {
> +        /* AT not supported: hardwire to 0 */
> +        at = 0;
> +        atv = false;
> +    }
> +
> +    if (mcid >= bc->nb_mcids) {
> +        status = BC_MON_CTL_STATUS_INVAL_MCID;
> +    } else if (op == BC_MON_OP_CONFIG_EVENT &&
> +               bc->supports_mon_op_config_event) {
> +        if (evt_id == BC_EVT_ID_None &&
> +            bc->supports_mon_evt_id_none) {
> +            bc->mon_counters[mcid].active = false;
> +            status = BC_MON_CTL_STATUS_SUCCESS;
> +        } else if ((evt_id == BC_EVT_ID_RDWR_count &&
> +                    bc->supports_mon_evt_id_rdwr_count) ||
> +                   (evt_id == BC_EVT_ID_RDONLY_count &&
> +                    bc->supports_mon_evt_id_rdonly_count) ||
> +                   (evt_id == BC_EVT_ID_WRONLY_count &&
> +                    bc->supports_mon_evt_id_wronly_count)) {
> +            if (atv && !is_valid_at(bc, at)) {
> +                status = BC_MON_CTL_STATUS_INVAL_AT;
> +            } else {
> +                /*
> +                 * The model does not account for bandwidth usage, so the
> +                 * counter is marked INVALID and stays that way.
> +                 */
> +                bc->mon_counters[mcid].ctr_val =
> +                    FIELD_DP64(0, BC_MON_CTR_VAL, INVALID, 1);
> +                bc->mon_counters[mcid].evt_id = evt_id;
> +                bc->mon_counters[mcid].at = atv ? at : -1;
> +                bc->mon_counters[mcid].active = true;
> +                status = BC_MON_CTL_STATUS_SUCCESS;
> +            }
> +        } else {
> +            status = BC_MON_CTL_STATUS_INVAL_EVT_ID;
> +        }
> +    } else if (op == BC_MON_OP_READ_COUNTER &&
> +               bc->supports_mon_op_read_counter) {
> +        bc->bc_mon_ctr_val = bc->mon_counters[mcid].ctr_val;
> +        status = BC_MON_CTL_STATUS_SUCCESS;
> +    } else {
> +        status = BC_MON_CTL_STATUS_INVAL_OP;
> +    }
> +
> +    /* reconstruct updated register value */
> +    value = 0;
> +    value = FIELD_DP64(value, BC_MON_CTL, OP, op);
> +    value = FIELD_DP64(value, BC_MON_CTL, AT, at);
> +    value = FIELD_DP64(value, BC_MON_CTL, MCID, mcid);
> +    value = FIELD_DP64(value, BC_MON_CTL, EVT_ID, evt_id);
> +    value = FIELD_DP64(value, BC_MON_CTL, ATV, atv);
> +    value = FIELD_DP64(value, BC_MON_CTL, STATUS, status);
> +    value = FIELD_DP64(value, BC_MON_CTL, BUSY, busy);
> +    bc->bc_mon_ctl = value;
> +}
> +
> +static void riscv_cbqri_bc_write_alloc_ctl(RiscvCbqriBandwidthState *bc,
> +                                           uint64_t value)
> +{
> +    if (bc->nbwblks == 0 ||
> +        (!bc->supports_alloc_op_config_limit &&
> +         !bc->supports_alloc_op_read_limit)) {
> +        /* bandwidth allocation not supported: leave bc_alloc_ctl set to 0 */
> +        return;
> +    }
> +
> +    /* extract writable fields */
> +    uint32_t op = FIELD_EX64(value, BC_ALLOC_CTL, OP);
> +    uint32_t at = FIELD_EX64(value, BC_ALLOC_CTL, AT);
> +    uint32_t rcid = FIELD_EX64(value, BC_ALLOC_CTL, RCID);
> +
> +    /* extract read-only fields */
> +    uint32_t status = FIELD_EX64(bc->bc_alloc_ctl, BC_ALLOC_CTL, STATUS);
> +    bool busy = FIELD_EX64(bc->bc_alloc_ctl, BC_ALLOC_CTL, BUSY);
> +
> +    if (busy) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: busy flag still set, ignored\n",
> +                      __func__);
> +        return;
> +    }
> +
> +    bool atv = true;
> +    if (!bc->supports_at_code) {
> +        /* AT not supported: hardwire to 0 */
> +        at = 0;
> +        atv = false;
> +    }
> +
> +    if (rcid >= bc->nb_rcids) {
> +        status = BC_ALLOC_STATUS_INVAL_RCID;
> +    } else if (atv && !is_valid_at(bc, at)) {
> +        status = BC_ALLOC_STATUS_INVAL_AT;
> +    } else if (op == BC_ALLOC_OP_CONFIG_LIMIT &&
> +               bc->supports_alloc_op_config_limit) {
> +        status = bandwidth_config(bc, rcid, at, &busy);
> +    } else if (op == BC_ALLOC_OP_READ_LIMIT &&
> +               bc->supports_alloc_op_read_limit) {
> +        status = bandwidth_read(bc, rcid, at, &busy);
> +    } else {
> +        status = BC_ALLOC_STATUS_INVAL_OP;
> +    }
> +
> +    /* reconstruct updated register value */
> +    value = 0;
> +    value = FIELD_DP64(value, BC_ALLOC_CTL, OP, op);
> +    value = FIELD_DP64(value, BC_ALLOC_CTL, AT, at);
> +    value = FIELD_DP64(value, BC_ALLOC_CTL, RCID, rcid);
> +    value = FIELD_DP64(value, BC_ALLOC_CTL, STATUS, status);
> +    value = FIELD_DP64(value, BC_ALLOC_CTL, BUSY, busy);
> +    bc->bc_alloc_ctl = value;
> +}
> +
> +static void riscv_cbqri_bc_write_bw_alloc(RiscvCbqriBandwidthState *bc,
> +                                          uint64_t value)
> +{
> +    if (bc->nbwblks == 0) {
> +        /* bandwidth allocation not supported: leave bw_alloc set to 0 */
> +        return;
> +    }
> +
> +    RiscvCbqriBandwidthAllocation *bc_bw_alloc = &bc->bw_allocations[0];
> +
> +    /* extract writable fields */
> +    bc_bw_alloc->Rbwb = FIELD_EX64(value, BC_BW_ALLOC, Rbwb);
> +    bc_bw_alloc->Mweight = FIELD_EX64(value, BC_BW_ALLOC, Mweight);
> +    bc_bw_alloc->sharedAT = FIELD_EX64(value, BC_BW_ALLOC, sharedAT);
> +    bc_bw_alloc->useShared = FIELD_EX64(value, BC_BW_ALLOC, useShared);
> +
> +    if (!bc->supports_at_code) {
> +        /* AT not supported: hardwire to 0 */
> +        bc_bw_alloc->sharedAT = 0;
> +        bc_bw_alloc->useShared = false;
> +    } else if (!is_valid_at(bc, bc_bw_alloc->sharedAT)) {
> +        /* sharedAT is WARL: an unsupported AT reads back as AT 0 */
> +        bc_bw_alloc->sharedAT = BC_AT_DATA;
> +    }
> +}
> +
> +static void riscv_cbqri_bc_write(void *opaque, hwaddr addr,
> +                                 uint64_t value, unsigned size)
> +{
> +    RiscvCbqriBandwidthState *bc = opaque;
> +
> +    g_assert((addr % 8) == 0);
> +
> +    switch (addr) {
> +    case A_BC_CAPABILITIES:
> +        /* read-only register */
> +        break;
> +    case A_BC_MON_CTL:
> +        riscv_cbqri_bc_write_mon_ctl(bc, value);
> +        break;
> +    case A_BC_MON_CTR_VAL:
> +        /* read-only register */
> +        break;
> +    case A_BC_ALLOC_CTL:
> +        riscv_cbqri_bc_write_alloc_ctl(bc, value);
> +        break;
> +    case A_BC_BW_ALLOC:
> +        riscv_cbqri_bc_write_bw_alloc(bc, value);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: out of bounds (addr=0x%x)\n",
> +                      __func__, (uint32_t)addr);
> +    }
> +}
> +
> +static uint64_t riscv_cbqri_bc_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RiscvCbqriBandwidthState *bc = opaque;
> +    uint64_t value = 0;
> +
> +    g_assert((addr % 8) == 0);
> +
> +    switch (addr) {
> +    case A_BC_CAPABILITIES:
> +        value = FIELD_DP64(value, BC_CAPABILITIES, VER_MAJOR,
> +                           RISCV_CBQRI_VERSION_MAJOR);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, VER_MINOR,
> +                           RISCV_CBQRI_VERSION_MINOR);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, RPFX, 0);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, P, 0);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, NBWBLKS, bc->nbwblks);
> +        value = FIELD_DP64(value, BC_CAPABILITIES, MRBWB, bc->mrbwb);
> +        break;
> +    case A_BC_MON_CTL:
> +        value = bc->bc_mon_ctl;
> +        break;
> +    case A_BC_MON_CTR_VAL:
> +        value = bc->bc_mon_ctr_val;
> +        break;
> +    case A_BC_ALLOC_CTL:
> +        value = bc->bc_alloc_ctl;
> +        break;
> +    case A_BC_BW_ALLOC:
> +        RiscvCbqriBandwidthAllocation *bc_bw_alloc = &bc->bw_allocations[0];
> +        value = FIELD_DP64(value, BC_BW_ALLOC, Rbwb, bc_bw_alloc->Rbwb);
> +        value = FIELD_DP64(value, BC_BW_ALLOC, Mweight, bc_bw_alloc->Mweight);
> +        value = FIELD_DP64(value, BC_BW_ALLOC, sharedAT, bc_bw_alloc->sharedAT);
> +        value = FIELD_DP64(value, BC_BW_ALLOC, useShared,
> +                           bc_bw_alloc->useShared);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: out of bounds (addr=0x%x)\n",
> +                      __func__, (uint32_t)addr);
> +    }
> +
> +    return value;
> +}
> +
> +static uint64_t riscv_cbqri_bc_read_wrapper(void *opaque, hwaddr addr,
> +                                            unsigned size)
> +{
> +    uint64_t value = riscv_cbqri_bc_read(opaque, QEMU_ALIGN_DOWN(addr, 8), 8);
> +    if (size == 4) {
> +        if (addr & 0x7) {
> +            return value >> 32;
> +        } else {
> +            return value & MAKE_64BIT_MASK(0, 32);
> +        }
> +    }
> +    return value;
> +}
> +
> +static void riscv_cbqri_bc_write_wrapper(void *opaque, hwaddr addr,
> +                                             uint64_t value, unsigned size)
> +{
> +    hwaddr reg_addr = QEMU_ALIGN_DOWN(addr, 8);
> +
> +    if (size == 4) {
> +        uint64_t reg = riscv_cbqri_bc_read(opaque, reg_addr, 8);
> +        if (addr & 0x7) {
> +            /*
> +             * The upper half of the control registers holds only the
> +             * read-only STATUS and BUSY fields. Writing it must not run
> +             * the operation held in the lower half again.
> +             */
> +            if (reg_addr == A_BC_MON_CTL || reg_addr == A_BC_ALLOC_CTL) {
> +                return;
> +            }
> +            value = value << 32 | (reg & MAKE_64BIT_MASK(0, 32));
> +        } else {
> +            value = value | (reg & MAKE_64BIT_MASK(32, 32));
> +        }
> +    }
> +    riscv_cbqri_bc_write(opaque, reg_addr, value, 8);
> +}
> +
> +
> +static const MemoryRegionOps riscv_cbqri_bc_ops = {
> +    .read = riscv_cbqri_bc_read_wrapper,
> +    .write = riscv_cbqri_bc_write_wrapper,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 8,
> +};
> +
> +static void riscv_cbqri_bc_realize(DeviceState *dev, Error **errp)
> +{
> +    RiscvCbqriBandwidthState *bc = RISCV_CBQRI_BC(dev);
> +
> +    if (!bc->mmio_base) {
> +        error_setg(errp, "mmio_base property not set");
> +        return;
> +    }
> +
> +    if (bc->nb_rcids == 0) {
> +        error_setg(errp, "max_rcids must be at least 1");
> +        return;
> +    }
> +
> +    if (bc->mrbwb > bc->nbwblks) {
> +        error_setg(errp, "mrbwb must not exceed nbwblks");
> +        return;
> +    }
> +
> +    if (bc->nbwblks != 0 && bc->mrbwb == 0) {
> +        error_setg(errp, "mrbwb must be at least 1 when nbwblks is not 0");
> +        return;
> +    }
> +
> +    g_assert(bc->mon_counters == NULL);
> +    bc->mon_counters = g_new0(RiscvCbqriMonitorCounter, bc->nb_mcids);
> +
> +    g_assert(bc->bw_allocations == NULL);
> +    bc->bw_allocations = g_new0(RiscvCbqriBandwidthAllocation,
> +                                bw_alloc_index(bc->nb_rcids, 0));
> +
> +    memory_region_init_io(&bc->mmio, OBJECT(dev), &riscv_cbqri_bc_ops,
> +                          bc, TYPE_RISCV_CBQRI_BC".mmio", 4 * 1024);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &bc->mmio);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, bc->mmio_base);
> +}
> +
> +static void riscv_cbqri_bc_reset_hold(Object *obj, ResetType type)
> +{
> +    RiscvCbqriBandwidthState *bc = RISCV_CBQRI_BC(obj);
> +    RiscvCbqriBandwidthAllocation *bw_alloc;
> +    unsigned int i;
> +
> +    /*
> +     * The spec requires that the reset value is 0 for the bc_mon_ctl.BUSY
> +     * and bc_alloc_ctl.BUSY fields, and that the reset value is UNSPECIFIED
> +     * for all other register fields, so every allocation and counter is
> +     * cleared and a rebooted guest starts from a known state.
> +     */
> +    bc->bc_mon_ctl = 0;
> +    bc->bc_alloc_ctl = 0;
> +    bc->bc_mon_ctr_val = 0;
> +    for (i = 0; i < bc->nb_mcids; i++) {
> +        bc->mon_counters[i] = (RiscvCbqriMonitorCounter) {
> +            .ctr_val = FIELD_DP64(0, BC_MON_CTR_VAL, INVALID, 1),
> +        };
> +    }
> +    memset(bc->bw_allocations, 0,
> +           bw_alloc_index(bc->nb_rcids, 0) * sizeof(*bc->bw_allocations));
> +
> +    /*
> +     * The bandwidth controllers at reset must allocate all available
> +     * bandwidth to RCID value of 0. All available bandwidth is MRBWB,
> +     * the most that can be reserved.
> +     *
> +     * When the bandwidth controller supports bandwidth allocation per
> +     * access type, AT 0 of RCID=0 is allocated all available bandwidth
> +     * and the other access types share the allocation with AT 0.
> +     *
> +     * A controller with NBWBLKS of 0 does not support bandwidth
> +     * allocation and has nothing to allocate.
> +     */
> +    if (bc->nbwblks == 0) {
> +        return;
> +    }
> +    bw_alloc = get_bw_alloc(bc, 0, BC_AT_DATA);
> +    *bw_alloc = (RiscvCbqriBandwidthAllocation) {
> +        .Rbwb = bc->mrbwb,
> +    };
> +    if (bc->supports_at_code) {
> +        bw_alloc = get_bw_alloc(bc, 0, BC_AT_CODE);
> +        *bw_alloc = (RiscvCbqriBandwidthAllocation) {
> +            .sharedAT = BC_AT_DATA,
> +            .useShared = true,
> +        };
> +    }
> +}
> +
> +static const Property riscv_cbqri_bc_properties[] = {
> +    DEFINE_PROP_UINT64("mmio_base", RiscvCbqriBandwidthState, mmio_base, 0),
> +
> +    DEFINE_PROP_UINT16("max_mcids", RiscvCbqriBandwidthState, nb_mcids,
> +                       BC_DEFAULT_MAX_MCIDS),
> +    DEFINE_PROP_UINT16("max_rcids", RiscvCbqriBandwidthState, nb_rcids,
> +                       BC_DEFAULT_MAX_RCIDS),
> +    DEFINE_PROP_UINT16("nbwblks", RiscvCbqriBandwidthState, nbwblks,
> +                       BC_DEFAULT_NBWBLKS),
> +    DEFINE_PROP_UINT16("mrbwb", RiscvCbqriBandwidthState, mrbwb,
> +                       BC_DEFAULT_MRBWB),
> +
> +    DEFINE_PROP_BOOL("at_code", RiscvCbqriBandwidthState,
> +                     supports_at_code, true),
> +
> +    DEFINE_PROP_BOOL("alloc_op_config_limit", RiscvCbqriBandwidthState,
> +                     supports_alloc_op_config_limit, true),
> +    DEFINE_PROP_BOOL("alloc_op_read_limit", RiscvCbqriBandwidthState,
> +                     supports_alloc_op_read_limit, true),
> +
> +    DEFINE_PROP_BOOL("mon_op_config_event", RiscvCbqriBandwidthState,
> +                     supports_mon_op_config_event, true),
> +    DEFINE_PROP_BOOL("mon_op_read_counter", RiscvCbqriBandwidthState,
> +                     supports_mon_op_read_counter, true),
> +
> +    DEFINE_PROP_BOOL("mon_evt_id_none", RiscvCbqriBandwidthState,
> +                     supports_mon_evt_id_none, true),
> +    DEFINE_PROP_BOOL("mon_evt_id_rdwr_count", RiscvCbqriBandwidthState,
> +                     supports_mon_evt_id_rdwr_count, true),
> +    DEFINE_PROP_BOOL("mon_evt_id_rdonly_count", RiscvCbqriBandwidthState,
> +                     supports_mon_evt_id_rdonly_count, true),
> +    DEFINE_PROP_BOOL("mon_evt_id_wronly_count", RiscvCbqriBandwidthState,
> +                     supports_mon_evt_id_wronly_count, true),
> +};
> +
> +static const VMStateDescription vmstate_riscv_cbqri_bc = {
> +    .name = "riscv-cbqri-bandwidth",
> +    .unmigratable = 1,
> +};
> +
> +static void riscv_cbqri_bc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = riscv_cbqri_bc_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->desc = "RISC-V CBQRI Bandwidth Controller";
> +    device_class_set_props(dc, riscv_cbqri_bc_properties);
> +    rc->phases.hold = riscv_cbqri_bc_reset_hold;
> +    dc->vmsd = &vmstate_riscv_cbqri_bc;
> +    dc->user_creatable = true;
> +}
> +
> +static const TypeInfo riscv_cbqri_bc_info = {
> +    .name          = TYPE_RISCV_CBQRI_BC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RiscvCbqriBandwidthState),
> +    .class_init    = riscv_cbqri_bc_class_init,
> +};
> +
> +static void riscv_cbqri_bc_register_types(void)
> +{
> +    type_register_static(&riscv_cbqri_bc_info);
> +}
> +
> +void riscv_cbqri_bc_caps_init(RiscvCbqriBandwidthCaps *caps)
> +{
> +    *caps = (RiscvCbqriBandwidthCaps) {
> +        .nb_mcids = BC_DEFAULT_MAX_MCIDS,
> +        .nb_rcids = BC_DEFAULT_MAX_RCIDS,
> +        .nbwblks = BC_DEFAULT_NBWBLKS,
> +        .mrbwb = BC_DEFAULT_MRBWB,
> +        .supports_at_code = true,
> +        .supports_alloc_op_config_limit = true,
> +        .supports_alloc_op_read_limit = true,
> +        .supports_mon_op_config_event = true,
> +        .supports_mon_op_read_counter = true,
> +        .supports_mon_evt_id_none = true,
> +        .supports_mon_evt_id_rdwr_count = true,
> +        .supports_mon_evt_id_rdonly_count = true,
> +        .supports_mon_evt_id_wronly_count = true,
> +    };
> +}
> +
> +DeviceState *riscv_cbqri_bc_create(hwaddr addr,
> +                                   const RiscvCbqriBandwidthCaps *caps)
> +{
> +    DeviceState *dev = qdev_new(TYPE_RISCV_CBQRI_BC);
> +
> +    qdev_prop_set_uint64(dev, "mmio_base", addr);
> +    qdev_prop_set_uint16(dev, "max_mcids", caps->nb_mcids);
> +    qdev_prop_set_uint16(dev, "max_rcids", caps->nb_rcids);
> +    qdev_prop_set_uint16(dev, "nbwblks", caps->nbwblks);
> +    qdev_prop_set_uint16(dev, "mrbwb", caps->mrbwb);
> +
> +    qdev_prop_set_bit(dev, "at_code",
> +                      caps->supports_at_code);
> +    qdev_prop_set_bit(dev, "alloc_op_config_limit",
> +                      caps->supports_alloc_op_config_limit);
> +    qdev_prop_set_bit(dev, "alloc_op_read_limit",
> +                      caps->supports_alloc_op_read_limit);
> +    qdev_prop_set_bit(dev, "mon_op_config_event",
> +                      caps->supports_mon_op_config_event);
> +    qdev_prop_set_bit(dev, "mon_op_read_counter",
> +                      caps->supports_mon_op_read_counter);
> +    qdev_prop_set_bit(dev, "mon_evt_id_none",
> +                      caps->supports_mon_evt_id_none);
> +    qdev_prop_set_bit(dev, "mon_evt_id_rdwr_count",
> +                      caps->supports_mon_evt_id_rdwr_count);
> +    qdev_prop_set_bit(dev, "mon_evt_id_rdonly_count",
> +                      caps->supports_mon_evt_id_rdonly_count);
> +    qdev_prop_set_bit(dev, "mon_evt_id_wronly_count",
> +                      caps->supports_mon_evt_id_wronly_count);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    return dev;
> +}
> +
> +type_init(riscv_cbqri_bc_register_types)
> 


