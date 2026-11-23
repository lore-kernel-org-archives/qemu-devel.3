Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE1A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=irE/OR+V;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g8Vo8j7T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUps-0005mb-8M; Mon, 23 Nov 2026 09:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVUpj-0005mE-MR
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:15:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVUpf-0001Mg-Uk
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:15:51 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKuWJ3329305
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 olLCY1fAu8QDNEh0nxpYLJ/Qqo5dq251K0dK64U7NdQ=; b=irE/OR+VolqVa3A7
 E7JV4oc552jLYYBDyXCauezNxPW/4dphxRlaF7fWtki1iS1W4TVHmQNg0wSUItG2
 v1oPiMlNP4SG6YBmUW94mzMms1do3zhU7a9T7/JcWig6yKJQ/wctFjyUr3BokbsD
 Lgmlg5VFz8TvjagPD0GlFH82pydbeyBe+f1qsJ91rnZ2nmjryt/A8DPY3xpCXXeq
 ymzRPDBnG58KgQDscmNCwqkaTYu5Ir4tec7vpsVKpzQO7PdRkVLQdNcivv3voi5x
 yDRahHLecWYqev+eu7GYXgAG5O3iz4uMR8sG6JgB7vPF27rqO9S8UY3xudyXkxlq
 sgFRvQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyd1rw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:15:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-946038e22f5so684763185a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 06:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795443344; x=1796048144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=olLCY1fAu8QDNEh0nxpYLJ/Qqo5dq251K0dK64U7NdQ=;
 b=g8Vo8j7TvegQLtgLAykHTecA8MvmqVuFDJB+mdruTiffFE8uIZerYFnwqTfaojwnlZ
 lwCf4KWC77pmL3Yp+xOXtSkTANz9nkc55uZAzgVUceGPjkbD3TFuwBO1CHiO0kAyvAN8
 c9ljg4ZPJ3PfeoG5GBQCDZHNkL9BIZSkqX8wAyRcXkfPoXHdWD3YIub8iKT/K3870Adr
 j5aW2JjWCiM8/uATJ7Ishc9XLPZxdV545OtfWYB1ia9RWnsz1VDpD52Szt9e7Hi1zWZd
 Bj/tmtGfKNfacOO6NrEJqjvVurVmqw/xo3DN3kK2CevKxCT7laI6vr9yK0gy7FitbwOk
 zXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795443344; x=1796048144;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=olLCY1fAu8QDNEh0nxpYLJ/Qqo5dq251K0dK64U7NdQ=;
 b=deBL4XvSnTfQQE5nq5CmgFd50UIJY+hsDbvnHUwmZP8lLRnjvFLLDwebCAHb+qxu8O
 bDypEzAWOta4QA3kbkV/CJ7Qdrs4mdtoyfp/wfiCsM1SgPeADrd8kJVvLK1w4PwXPcaJ
 s14DupB76266dlyT/khQRGOvYwZII2TqzBcmqrmN8C+91noQOVt8TtR+2LcrLdtzMUMt
 oTmCfaL0HB94fKIVx0f0wxoqtA1KMO5VDbEmGHc8jUr/ik8mpotO6jUUhsU2M+20whCw
 /9+Fw7H+JpzqJjF2/vSiTcniijIKgoja0pP7jLhdC9JQP24gGrp4+ywPKmd+5r+ayvzY
 M6Xg==
X-Forwarded-Encrypted: i=1;
 AL+hErFEW1QIF7NWS6dUwhVSA6SfHnysbdQ7XHXknUBiQO6z8VDgL5LiXkvpYuwiC7tRBKo84DEyGnIN6juz@nongnu.org
X-Gm-Message-State: APuU4Z/kAWMZcFMNJ2cKbH8pdxzH03dMRXXdrZ3vKebBnEzAuDdobNoY
 xUkddl6S+yfn4Ay+HwquCRvIi0E84sdLrRKYKQt1wjPLJLRmE9EZXY1qYygG9eYd47cA6HPu45c
 P6jtObPyOGPAPryHRNc4iAyj0DaWwgy2wuuoSyxTforQkfwq6hi1liJgRQQ==
X-Gm-Gg: AZFdTZeGEmnwGCZOhP6hMK+2+jrCoqq2Sst12h8WrKd61GKvMPEgMthSqPOo8mDgVb/
 LF+XwiiilVP0MD/5U+XfzFjMjg/KbHmtaimsnmS47wdtsDg3kc3aM0HdoXqPnh4X1Z2p748U2Zu
 kZfdZWUAT/qyDd92UHDSDjVtjOsGMwHu2PMwpeFx5V4Lt0p7aQSiviEH9GzCmlL2+6D/l/iRi+0
 Al/lYoeQa/F40zg/zPgcvZGZXqrp0YYJOE7akIUz7qONumAA+YG82TGixSz01g6iav32qkxkwfo
 xjXcP4nJCxismOm1qsRuMUUTtiwNzE/KMO96c0E2kUFgFS1V5muUobxp2UVC+dCWnvqvAIt+JSp
 hL5agwjiGhpr0CRRH616hF/jdY6befHOz5OPG7ZCJ38jrz8cVuNK2gUgiRnym0u+P3Tb6eyck4C
 KrajpQqwWe
X-Received: by 2002:a05:620a:f0f:b0:949:57b4:388b with SMTP id
 af79cd13be357-949bab0eb6cmr2115113785a.41.1795443344410; 
 Mon, 23 Nov 2026 06:15:44 -0800 (PST)
X-Received: by 2002:a05:620a:f0f:b0:949:57b4:388b with SMTP id
 af79cd13be357-949bab0eb6cmr2115105085a.41.1795443343870; 
 Mon, 23 Nov 2026 06:15:43 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb031617sm812694485a.1.2026.11.23.06.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 06:15:43 -0800 (PST)
Message-ID: <bd116e02-a7b2-4b90-bbee-b855111d2411@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:15:38 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/riscv: add support for ACPI RQSC table
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
 liu.qingtao2@zte.com.cn, Jinjie Ruan <ruanjinjie@huawei.com>,
 Jinjie Ruan <2118537295@qq.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Vasudevan Srinivasan <vasu@rivosinc.com>
References: <20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org>
 <20261113-riscv-rqsc-v2-2-34d47fa4141e@kernel.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261113-riscv-rqsc-v2-2-34d47fa4141e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CEKFBzQr_t0_a3_b06kw4Q3MFN4nMRjf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NiBTYWx0ZWRfX1UIdQSW6XG52
 gKQPfS/BJwDhz9CAQ6ry+WQSG8YDliPfZUS7MXi0cwtQGHTWL+eJsM/Tf19d8/DERjSZs4FZqMp
 cEtVHER8WhxS40J+Opdwc4UJ49YCq8blinrbtv6CZ52B3vC9oYSPFJo1k7/XFOBnc4sF2OO14UV
 WH+Pp+isEN9GxvENf2cHWjdAoCE8cO+mT67teNLFnWPJFLMaU9cN+leyUDAkIiPofeDThbg9Y56
 6tk6nRtrvTt2ff+KLgSVO20lRL9/U1hHWkH73xfUIYosbvc14bT1rcISDBIFLKrzAq2y52PwyJT
 mal1/rLEV8KOsHCqpCpVl/WuS1dMHDOgk/prEmD/+/K9tiAX37S5uctb+zwTqXbU6KMz+pT6Jq5
 lQ/2frxF15jMu69cl78yx6XI76qS2IRSA8pwTzsany8SQJDDnZSTFdUbp23F3h3SQz++YR1hDQ0
 We/VLwwgUjAESLupGIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NiBTYWx0ZWRfX/EjYutfHRYp2
 n0ZspSyu1t4fYhPJj9pT549uoYAUURTlPhzncfGlb8FIHOT8idlxJiE0QxW3dlkbg0DKd/J1dz+
 FhZv8gWwh8h7oN9hSGkKRXyiglCI6is=
X-Proofpoint-GUID: CEKFBzQr_t0_a3_b06kw4Q3MFN4nMRjf
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6b044a91 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=V1jnuoLLAAAA:20 a=h0uksLzaAAAA:8 a=VwQbUJbxAAAA:8 a=vJmiy4lZmNxXquneKHYA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=MSi_79tMYmZZG2gvAgS0:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230056
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/13/2026 8:12 PM, Drew Fustini wrote:
> Build the ACPI RISC-V Quality of Service Controllers (RQSC) table for
> the virt machine when CBQRI controllers are present. A capacity
> controller is described by the PPTT Cache ID of the cache it backs and
> a bandwidth controller by the SRAT proximity domain of its NUMA node.
> 
> Make RISCV_VIRT select RISCV_CBQRI as the table code calls into the
> CBQRI devices.
> 
> Link: https://github.com/riscv-non-isa/riscv-rqsc/releases/tag/v1.0.0
> Co-developed-by: Vasudevan Srinivasan <vasu@rivosinc.com>
> Signed-off-by: Vasudevan Srinivasan <vasu@rivosinc.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>   hw/riscv/Kconfig           |   2 +-
>   hw/riscv/cbqri_bandwidth.c |  13 ++
>   hw/riscv/cbqri_capacity.c  |  13 ++
>   hw/riscv/virt-acpi-build.c | 298 ++++++++++++++++++++++++++++++++++++++++++++-
>   include/hw/riscv/cbqri.h   |  20 +++
>   5 files changed, 344 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 98bdebb4b814..47dda3e52d20 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -71,7 +71,7 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> -    imply RISCV_CBQRI
> +    select RISCV_CBQRI
>   
>   config RISCV_SERVER_PLATFORM_REF
>       bool
> diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
> index 6c33d1738d27..c55709d662f2 100644
> --- a/hw/riscv/cbqri_bandwidth.c
> +++ b/hw/riscv/cbqri_bandwidth.c
> @@ -760,4 +760,17 @@ DeviceState *riscv_cbqri_bc_create(hwaddr addr,
>       return dev;
>   }
>   
> +void riscv_cbqri_bc_get_details(DeviceState *ds, const char *type,
> +                                RqscController *rqsc)
> +{
> +    if (strcmp(type, TYPE_RISCV_CBQRI_BC) == 0) {

The only existing caller for riscv_cbqri_bc_get_details() is already doing this
check:


 > +        bool is_bc = !strcmp(type, TYPE_RISCV_CBQRI_BC);

(...)

 > +        if (is_bc) {
 > +            riscv_cbqri_bc_get_details(kid->child, type, &rqsc[count]);
 > +        }


Unless there are plans to add new callers that will unsafely call the function
without guaranteeing that the device type is correct, I suggest removing the
redundant strcmp().

Same thing with riscv_cbqri_cc_get_details() below.

Otherwise LGTM.  Thanks,
Daniel


> +        RiscvCbqriBandwidthState *bcs = RISCV_CBQRI_BC(ds);
> +        rqsc->type = RQSC_CONTROLLER_TYPE_BANDWIDTH;
> +        rqsc->mmio_base = bcs->mmio_base;
> +        rqsc->rcid_count = bcs->nb_rcids;
> +        rqsc->mcid_count = bcs->nb_mcids;
> +        rqsc->node = bcs->node;
> +    }
> +}
> +
>   type_init(riscv_cbqri_bc_register_types)
> diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> index 1585cad1d073..3ebc8a1cc26d 100644
> --- a/hw/riscv/cbqri_capacity.c
> +++ b/hw/riscv/cbqri_capacity.c
> @@ -776,4 +776,17 @@ DeviceState *riscv_cbqri_cc_create(hwaddr addr,
>       return dev;
>   }
>   
> +void riscv_cbqri_cc_get_details(DeviceState *ds, const char *type,
> +                                RqscController *rqsc)
> +{
> +    if (strcmp(type, TYPE_RISCV_CBQRI_CC) == 0) {
> +        RiscvCbqriCapacityState *ccs = RISCV_CBQRI_CC(ds);
> +        rqsc->type = RQSC_CONTROLLER_TYPE_CAPACITY;
> +        rqsc->mmio_base = ccs->mmio_base;
> +        rqsc->rcid_count = ccs->nb_rcids;
> +        rqsc->mcid_count = ccs->nb_mcids;
> +        rqsc->cache_level = ccs->cache_level;
> +    }
> +}
> +
>   type_init(riscv_cbqri_cc_register_types)
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 8254f1294a72..c8a720eb568c 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -34,6 +34,7 @@
>   #include "hw/pci-host/gpex.h"
>   #include "hw/riscv/virt.h"
>   #include "hw/riscv/numa.h"
> +#include "hw/riscv/cbqri.h"
>   #include "hw/virtio/virtio-acpi.h"
>   #include "kvm/kvm_riscv.h"
>   #include "migration/vmstate.h"
> @@ -279,6 +280,295 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
>   /* RHCT Node[N] starts at offset 56 */
>   #define RHCT_NODE_ARRAY_OFFSET 56
>   
> +/*
> + * RISC-V Quality of Service Controllers (RQSC) table, v1.0
> + * https://github.com/riscv-non-isa/riscv-rqsc/releases/tag/v1.0.0
> + */
> +
> +/* RQSC Resource Type and Resource ID Type */
> +#define RQSC_RESOURCE_TYPE_CACHE                0
> +#define RQSC_RESOURCE_TYPE_MEMORY               1
> +#define RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE   0
> +#define RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE      1
> +
> +#define RQSC_MAX_CONTROLLERS                    10
> +
> +/* PPTT nodes start after the 36-byte table header */
> +#define PPTT_NODE_ARRAY_OFFSET                  36
> +/* PPTT revision 3 Cache Type Structure */
> +#define PPTT_NODE_TYPE_CACHE                    1
> +#define PPTT_CACHE_NODE_LEN                     28
> +#define PPTT_CACHE_ID_OFFSET                    24
> +
> +static bool virt_has_cbqri(RISCVVirtState *vs)
> +{
> +    BusChild *kid;
> +
> +    if (!vs->platform_bus_dev) {
> +        return false;
> +    }
> +
> +    QTAILQ_FOREACH(kid, &vs->platform_bus_dev->parent_bus->children, sibling) {
> +        const char *type = object_get_typename(OBJECT(kid->child));
> +
> +        if (!strcmp(type, TYPE_RISCV_CBQRI_BC) ||
> +            !strcmp(type, TYPE_RISCV_CBQRI_CC)) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static int rqsc_cmp_mmio_base(const void *a, const void *b)
> +{
> +    const RqscController *x = a, *y = b;
> +
> +    return x->mmio_base < y->mmio_base ? -1 : x->mmio_base > y->mmio_base;
> +}
> +
> +static unsigned int gather_cbqri_details(RISCVVirtState *vs,
> +                                         RqscController rqsc[])
> +{
> +    BusChild *kid;
> +    unsigned int count = 0;
> +
> +    if (!vs->platform_bus_dev) {
> +        return 0;
> +    }
> +
> +    QTAILQ_FOREACH(kid, &vs->platform_bus_dev->parent_bus->children, sibling) {
> +        const char *type = object_get_typename(OBJECT(kid->child));
> +        bool is_bc = !strcmp(type, TYPE_RISCV_CBQRI_BC);
> +        bool is_cc = !strcmp(type, TYPE_RISCV_CBQRI_CC);
> +
> +        if (!is_bc && !is_cc) {
> +            continue;
> +        }
> +
> +        if (count == RQSC_MAX_CONTROLLERS) {
> +            error_setg(&error_fatal, "RQSC: more than %d CBQRI controllers",
> +                       RQSC_MAX_CONTROLLERS);
> +        }
> +
> +        if (is_bc) {
> +            riscv_cbqri_bc_get_details(kid->child, type, &rqsc[count]);
> +        } else {
> +            riscv_cbqri_cc_get_details(kid->child, type, &rqsc[count]);
> +        }
> +        count++;
> +    }
> +
> +    /*
> +     * The bus lists its children newest first. Order the controllers by
> +     * address so that the n-th capacity controller of a cache level is
> +     * the one backing the n-th cache of that level.
> +     */
> +    qsort(rqsc, count, sizeof(*rqsc), rqsc_cmp_mmio_base);
> +
> +    return count;
> +}
> +
> +/*
> + * Return the PPTT Cache ID of one unified cache of the given level. The
> + * topology containers that hold a cache of that level are counted from 0
> + * in possible_cpus order, and idx selects the container. build_pptt()
> + * derives the ID with PPTT_CACHE_ID() from the cache type and level plus
> + * the first CPU of the container, so walk possible_cpus the way it does.
> + * Return -1 when there is no such cache and store in num_caches how many
> + * caches of that level the topology has, 0 when no smp-cache option places
> + * that level.
> + */
> +static int64_t rqsc_pptt_cache_id(MachineState *ms, unsigned int level,
> +                                  unsigned int idx, unsigned int *num_caches)
> +{
> +    const CPUArchIdList *cpus = ms->possible_cpus;
> +    int64_t socket_id = -1, cluster_id = -1, core_id = -1;
> +    unsigned int n, found = 0;
> +    CpuTopologyLevel topo;
> +
> +    *num_caches = 0;
> +
> +    switch (level) {
> +    case 2:
> +        topo = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
> +        break;
> +    case 3:
> +        topo = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
> +        break;
> +    default:
> +        return -1;
> +    }
> +
> +    for (n = 0; n < cpus->len; n++) {
> +        const CpuInstanceProperties *p = &cpus->cpus[n].props;
> +        bool first;
> +
> +        switch (topo) {
> +        case CPU_TOPOLOGY_LEVEL_SOCKET:
> +            first = p->socket_id != socket_id;
> +            break;
> +        case CPU_TOPOLOGY_LEVEL_CLUSTER:
> +            first = p->socket_id != socket_id || p->cluster_id != cluster_id;
> +            break;
> +        case CPU_TOPOLOGY_LEVEL_CORE:
> +            first = p->socket_id != socket_id ||
> +                    p->cluster_id != cluster_id || p->core_id != core_id;
> +            break;
> +        default:
> +            return -1;
> +        }
> +
> +        if (!first) {
> +            continue;
> +        }
> +
> +        socket_id = p->socket_id;
> +        cluster_id = p->cluster_id;
> +        core_id = p->core_id;
> +
> +        if (found++ == idx) {
> +            return PPTT_CACHE_ID(UNIFIED_CACHE, level, n);
> +        }
> +    }
> +
> +    *num_caches = found;
> +    return -1;
> +}
> +
> +/*
> + * Whether the PPTT at pptt_start holds a Cache Type Structure with the
> + * given Cache ID. build_pptt() does not emit every cache level for every
> + * smp-cache layout, for example an L3 cache placed at core level.
> + */
> +static bool rqsc_pptt_has_cache_id(GArray *table_data, unsigned int pptt_start,
> +                                   uint32_t id)
> +{
> +    const uint8_t *pptt = (const uint8_t *)table_data->data + pptt_start;
> +    uint32_t len = ldl_le_p(pptt + 4);
> +    uint32_t off = PPTT_NODE_ARRAY_OFFSET;
> +
> +    while (off + PPTT_CACHE_NODE_LEN <= len) {
> +        uint8_t node_len = pptt[off + 1];
> +
> +        if (pptt[off] == PPTT_NODE_TYPE_CACHE &&
> +            node_len >= PPTT_CACHE_NODE_LEN &&
> +            ldl_le_p(pptt + off + PPTT_CACHE_ID_OFFSET) == id) {
> +            return true;
> +        }
> +        if (!node_len) {
> +            break;
> +        }
> +        off += node_len;
> +    }
> +
> +    return false;
> +}
> +
> +static void build_rqsc(GArray *table_data, BIOSLinker *linker,
> +                       RISCVVirtState *s, unsigned int pptt_start)
> +{
> +    MachineState *ms = MACHINE(s);
> +    RqscController rqsc[RQSC_MAX_CONTROLLERS];
> +    unsigned int num, i, nr_cc[4] = {};
> +    AcpiTable table = { .sig = "RQSC", .rev = 1, .oem_id = s->oem_id,
> +                        .oem_table_id = s->oem_table_id };
> +
> +    acpi_table_begin(&table, table_data);
> +
> +    num = gather_cbqri_details(s, rqsc);
> +
> +    /* Number of QoS Controllers */
> +    build_append_int_noprefix(table_data, num, 4);
> +
> +    for (i = 0; i < num; i++) {
> +        bool is_cc = rqsc[i].type == RQSC_CONTROLLER_TYPE_CAPACITY;
> +        /* A Memory resource carries 8 bytes of Bandwidth per Block */
> +        unsigned int res_len = is_cc ? 20 : 28;
> +        uint8_t res_type, id_type;
> +        int64_t id;
> +
> +        if (is_cc) {
> +            unsigned int level = rqsc[i].cache_level;
> +            unsigned int num_caches;
> +
> +            res_type = RQSC_RESOURCE_TYPE_CACHE;
> +            id_type = RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE;
> +            id = rqsc_pptt_cache_id(ms, level, nr_cc[level]++, &num_caches);
> +            if (id < 0 && !num_caches) {
> +                error_setg(&error_fatal,
> +                           "CBQRI capacity controller at 0x%" PRIx64
> +                           " backs an L%u cache, but no smp-cache option"
> +                           " places the L%u cache",
> +                           rqsc[i].mmio_base, level, level);
> +            } else if (id < 0) {
> +                error_setg(&error_fatal,
> +                           "CBQRI capacity controller at 0x%" PRIx64
> +                           " is L%u controller %u, but the smp-cache"
> +                           " topology has only %u L%u cache%s",
> +                           rqsc[i].mmio_base, level, nr_cc[level] - 1,
> +                           num_caches, level, num_caches == 1 ? "" : "s");
> +            } else if (!rqsc_pptt_has_cache_id(table_data, pptt_start, id)) {
> +                error_setg(&error_fatal,
> +                           "CBQRI capacity controller at 0x%" PRIx64
> +                           " backs an L%u cache, but the PPTT has no L%u"
> +                           " cache with ID 0x%" PRIx64,
> +                           rqsc[i].mmio_base, level, level, (uint64_t)id);
> +            }
> +        } else {
> +            res_type = RQSC_RESOURCE_TYPE_MEMORY;
> +            id_type = RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE;
> +            id = rqsc[i].node;
> +        }
> +
> +        /* Controller Type */
> +        build_append_int_noprefix(table_data, rqsc[i].type, 1);
> +        /* Reserved */
> +        build_append_int_noprefix(table_data, 0, 1);
> +        /* Length */
> +        build_append_int_noprefix(table_data, 24 + res_len, 2);
> +        /* Register Interface Address */
> +        build_append_gas(table_data,
> +                AML_AS_SYSTEM_MEMORY,
> +                0,
> +                0,
> +                4,
> +                rqsc[i].mmio_base);
> +        /* RCID Count */
> +        build_append_int_noprefix(table_data, rqsc[i].rcid_count, 2);
> +        /* MCID Count */
> +        build_append_int_noprefix(table_data, rqsc[i].mcid_count, 2);
> +        /* Controller Flags */
> +        build_append_int_noprefix(table_data, 0, 2);
> +        /* Number of Resources, one per controller */
> +        build_append_int_noprefix(table_data, 1, 2);
> +
> +        /* Resource Structure */
> +        /* Resource Type */
> +        build_append_int_noprefix(table_data, res_type, 1);
> +        /* Reserved */
> +        build_append_int_noprefix(table_data, 0, 1);
> +        /* Length of Resource Structure */
> +        build_append_int_noprefix(table_data, res_len, 2);
> +        /* Resource Flags */
> +        build_append_int_noprefix(table_data, 0, 2);
> +        /* Reserved */
> +        build_append_int_noprefix(table_data, 0, 1);
> +        /* Resource ID Type */
> +        build_append_int_noprefix(table_data, id_type, 1);
> +        /* Resource ID 1: PPTT Cache ID or SRAT Proximity Domain */
> +        build_append_int_noprefix(table_data, id, 8);
> +        /* Resource ID 2 */
> +        build_append_int_noprefix(table_data, 0, 4);
> +        if (!is_cc) {
> +            /* Bandwidth per Block, 0 means not provided */
> +            build_append_int_noprefix(table_data, 0, 8);
> +        }
> +    }
> +
> +    acpi_table_end(linker, &table);
> +}
> +
>   /*
>    * ACPI spec, Revision 6.6
>    * 5.2.37 RISC-V Hart Capabilities Table (RHCT)
> @@ -879,7 +1169,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
>   static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>   {
>       GArray *table_offsets;
> -    unsigned dsdt, xsdt;
> +    unsigned dsdt, xsdt, pptt_start;
>       GArray *tables_blob = tables->table_data;
>       MachineState *ms = MACHINE(s);
>       CPUCoreCaches caches[CPU_MAX_CACHES];
> @@ -913,9 +1203,15 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>       }
>   
>       acpi_add_table(table_offsets, tables_blob);
> +    pptt_start = tables_blob->len;
>       build_pptt(tables_blob, tables->linker, ms, s->oem_id,
>                  s->oem_table_id, num_caches, caches);
>   
> +    if (virt_has_cbqri(s)) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_rqsc(tables_blob, tables->linker, s, pptt_start);
> +    }
> +
>       acpi_add_table(table_offsets, tables_blob);
>   
>       if (ms->acpi_spcr_enabled) {
> diff --git a/include/hw/riscv/cbqri.h b/include/hw/riscv/cbqri.h
> index 10b64613599f..bb0b961b3a43 100644
> --- a/include/hw/riscv/cbqri.h
> +++ b/include/hw/riscv/cbqri.h
> @@ -78,4 +78,24 @@ DeviceState *riscv_cbqri_cc_create(hwaddr addr,
>                                      const RiscvCbqriCapacityCaps *caps);
>   DeviceState *riscv_cbqri_bc_create(hwaddr addr,
>                                      const RiscvCbqriBandwidthCaps *caps);
> +
> +/* RQSC QoS Controller Type */
> +#define RQSC_CONTROLLER_TYPE_CAPACITY   0
> +#define RQSC_CONTROLLER_TYPE_BANDWIDTH  1
> +
> +/* What the ACPI RQSC table reports about one CBQRI controller */
> +typedef struct RqscController {
> +    uint8_t type;           /* RQSC_CONTROLLER_TYPE_* */
> +    uint64_t mmio_base;
> +    uint16_t rcid_count;
> +    uint16_t mcid_count;
> +    uint8_t cache_level;    /* capacity controllers */
> +    uint32_t node;          /* bandwidth controllers */
> +} RqscController;
> +
> +void riscv_cbqri_bc_get_details(DeviceState *ds, const char *type,
> +                                RqscController *rqsc);
> +void riscv_cbqri_cc_get_details(DeviceState *ds, const char *type,
> +                                RqscController *rqsc);
> +
>   #endif
> 


