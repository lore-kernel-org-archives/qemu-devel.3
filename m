Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF148C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqYx-0005UJ-UR; Tue, 13 Feb 2024 06:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1rZqYs-0005Jg-Lz; Tue, 13 Feb 2024 06:02:50 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1rZqYo-0006ij-TW; Tue, 13 Feb 2024 06:02:48 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41D6wNbK009875; Tue, 13 Feb 2024 11:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=Qlpo+NljcDbJnqJhBaPGBqPEqBm1fmlkOzWknR9lYrc=; b=l0
 L61AIjVmFv56LV6ZQ4rq0H8ldtM6WcLX/hU8gJHHRn2oX3ixN2socmXZNNw18Jv3
 nq0FpKcrpKZ6re9GnV2P7tv8YSOats/nowAyAIXHCt2bOMVFz7wZbYnFGsoPQb7c
 Dvmx00s0C8bM75Y8i21i4qPm6lbPQ3kZe+AwM8ta6H0UqTdQVT+rLegEEtSz6ArN
 cLTcIi6Ez+ZlC/HxkXJXbD4sAk1hw3GIMoItROKlEwjtTEtmRNfkhhEDYz7NYtkZ
 5rHcH0tJGdEUW2k7zbmbbVArykP1YOYUcNYlzC3gHmzSrf2vE4kak7nHA/6mUUFG
 T8w3p4qn5ijZ/1jRcWBg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gse2rm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 11:02:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DB2XvA019663
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 11:02:33 GMT
Received: from [10.111.132.144] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 03:02:29 -0800
Message-ID: <eaab2e45-924f-4d9f-89e5-1c0f300e78f7@quicinc.com>
Date: Tue, 13 Feb 2024 11:02:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/ide/ahci: Move SysBus definitions to
 'ahci-sysbus.h'
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, <qemu-arm@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <qemu-block@nongnu.org>, Eduardo Habkost
 <eduardo@habkost.net>, Rob Herring <robh@kernel.org>, Peter Maydell
 <peter.maydell@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>, Marcin
 Juszkiewicz <marcin.juszkiewicz@linaro.org>, Beniamino Galvani
 <b.galvani@gmail.com>, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-10-philmd@linaro.org>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <20240213081201.78951-10-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 7kxB3S0C6Cu4reS6_SaNTY5o4DpTTZv6
X-Proofpoint-ORIG-GUID: 7kxB3S0C6Cu4reS6_SaNTY5o4DpTTZv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=559 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130086
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2024-02-13 08:12, Philippe Mathieu-Daudé wrote:
> Keep "hw/ide/ahci.h" AHCI-generic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/allwinner-a10.h |  2 +-
>   include/hw/arm/allwinner-r40.h |  2 +-
>   include/hw/arm/xlnx-zynqmp.h   |  2 +-
>   include/hw/ide/ahci-sysbus.h   | 35 ++++++++++++++++++++++++++++++++++
>   include/hw/ide/ahci.h          | 29 +---------------------------
>   hw/arm/highbank.c              |  2 +-
>   hw/arm/sbsa-ref.c              |  1 +

Obviously, if the actual functional change happens, I'd be happy for 
sbsa-ref to keep building, so for that aspect:
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>

/
     Leif

>   hw/ide/ahci-allwinner.c        |  3 +--
>   hw/ide/ahci.c                  |  1 +
>   9 files changed, 43 insertions(+), 34 deletions(-)
>   create mode 100644 include/hw/ide/ahci-sysbus.h
> 
> diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
> index 2eb83a17ea..67a9a17b86 100644
> --- a/include/hw/arm/allwinner-a10.h
> +++ b/include/hw/arm/allwinner-a10.h
> @@ -5,7 +5,7 @@
>   #include "hw/intc/allwinner-a10-pic.h"
>   #include "hw/net/allwinner_emac.h"
>   #include "hw/sd/allwinner-sdhost.h"
> -#include "hw/ide/ahci.h"
> +#include "hw/ide/ahci-sysbus.h"
>   #include "hw/usb/hcd-ohci.h"
>   #include "hw/usb/hcd-ehci.h"
>   #include "hw/rtc/allwinner-rtc.h"
> diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
> index 66c38e7d90..614e74b7ed 100644
> --- a/include/hw/arm/allwinner-r40.h
> +++ b/include/hw/arm/allwinner-r40.h
> @@ -22,7 +22,7 @@
>   
>   #include "qom/object.h"
>   #include "hw/timer/allwinner-a10-pit.h"
> -#include "hw/ide/ahci.h"
> +#include "hw/ide/ahci-sysbus.h"
>   #include "hw/intc/arm_gic.h"
>   #include "hw/sd/allwinner-sdhost.h"
>   #include "hw/misc/allwinner-r40-ccu.h"
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 96358d51eb..48f7948092 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -22,7 +22,7 @@
>   #include "hw/net/cadence_gem.h"
>   #include "hw/char/cadence_uart.h"
>   #include "hw/net/xlnx-zynqmp-can.h"
> -#include "hw/ide/ahci.h"
> +#include "hw/ide/ahci-sysbus.h"
>   #include "hw/sd/sdhci.h"
>   #include "hw/ssi/xilinx_spips.h"
>   #include "hw/dma/xlnx_dpdma.h"
> diff --git a/include/hw/ide/ahci-sysbus.h b/include/hw/ide/ahci-sysbus.h
> new file mode 100644
> index 0000000000..7ed6cad496
> --- /dev/null
> +++ b/include/hw/ide/ahci-sysbus.h
> @@ -0,0 +1,35 @@
> +/*
> + * QEMU AHCI Emulation (MMIO-mapped devices)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef HW_IDE_AHCI_SYSBUS_H
> +#define HW_IDE_AHCI_SYSBUS_H
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +#include "hw/ide/ahci.h"
> +
> +#define TYPE_SYSBUS_AHCI "sysbus-ahci"
> +OBJECT_DECLARE_SIMPLE_TYPE(SysbusAHCIState, SYSBUS_AHCI)
> +
> +struct SysbusAHCIState {
> +    SysBusDevice parent_obj;
> +
> +    AHCIState ahci;
> +};
> +
> +#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
> +OBJECT_DECLARE_SIMPLE_TYPE(AllwinnerAHCIState, ALLWINNER_AHCI)
> +
> +#define ALLWINNER_AHCI_MMIO_OFF  0x80
> +#define ALLWINNER_AHCI_MMIO_SIZE 0x80
> +
> +struct AllwinnerAHCIState {
> +    SysbusAHCIState parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
> +};
> +
> +#endif
> diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
> index c0b10c2bb4..ba31e75ff9 100644
> --- a/include/hw/ide/ahci.h
> +++ b/include/hw/ide/ahci.h
> @@ -24,8 +24,7 @@
>   #ifndef HW_IDE_AHCI_H
>   #define HW_IDE_AHCI_H
>   
> -#include "hw/sysbus.h"
> -#include "qom/object.h"
> +#include "exec/memory.h"
>   
>   typedef struct AHCIDevice AHCIDevice;
>   
> @@ -54,30 +53,4 @@ typedef struct AHCIState {
>   
>   void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd);
>   
> -#define TYPE_SYSBUS_AHCI "sysbus-ahci"
> -OBJECT_DECLARE_SIMPLE_TYPE(SysbusAHCIState, SYSBUS_AHCI)
> -
> -struct SysbusAHCIState {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    AHCIState ahci;
> -};
> -
> -#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
> -OBJECT_DECLARE_SIMPLE_TYPE(AllwinnerAHCIState, ALLWINNER_AHCI)
> -
> -#define ALLWINNER_AHCI_MMIO_OFF  0x80
> -#define ALLWINNER_AHCI_MMIO_SIZE 0x80
> -
> -struct AllwinnerAHCIState {
> -    /*< private >*/
> -    SysbusAHCIState parent_obj;
> -    /*< public >*/
> -
> -    MemoryRegion mmio;
> -    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
> -};
> -
>   #endif /* HW_IDE_AHCI_H */
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 9fdac1cc81..c71b1a8db3 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -30,7 +30,7 @@
>   #include "hw/boards.h"
>   #include "qemu/error-report.h"
>   #include "hw/char/pl011.h"
> -#include "hw/ide/ahci.h"
> +#include "hw/ide/ahci-sysbus.h"
>   #include "hw/cpu/a9mpcore.h"
>   #include "hw/cpu/a15mpcore.h"
>   #include "qemu/log.h"
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index f2adf30337..5d3a574664 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -38,6 +38,7 @@
>   #include "hw/boards.h"
>   #include "hw/ide/internal.h"
>   #include "hw/ide/ahci_internal.h"
> +#include "hw/ide/ahci-sysbus.h"
>   #include "hw/intc/arm_gicv3_common.h"
>   #include "hw/intc/arm_gicv3_its_common.h"
>   #include "hw/loader.h"
> diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
> index b173121006..9620de8ce8 100644
> --- a/hw/ide/ahci-allwinner.c
> +++ b/hw/ide/ahci-allwinner.c
> @@ -19,9 +19,8 @@
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
>   #include "sysemu/dma.h"
> -#include "hw/ide/internal.h"
>   #include "migration/vmstate.h"
> -#include "ahci_internal.h"
> +#include "hw/ide/ahci-sysbus.h"
>   
>   #include "trace.h"
>   
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 041cc87c11..54c9685495 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -37,6 +37,7 @@
>   #include "hw/ide/internal.h"
>   #include "hw/ide/pci.h"
>   #include "hw/ide/ahci-pci.h"
> +#include "hw/ide/ahci-sysbus.h"
>   #include "ahci_internal.h"
>   
>   #include "trace.h"


