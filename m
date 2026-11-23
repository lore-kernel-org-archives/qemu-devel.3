Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F98606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MBE1Wb/l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XsM3jGhj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTgc-0006S5-Rz; Mon, 23 Nov 2026 08:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVTgI-0006GO-Ov
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:02:07 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVTgD-0000ML-NM
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:02:01 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANCGFlO2301336
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F1gFJ15/VkXNFitkQMduPe0dWyuv85qy1ddsXjmlDIc=; b=MBE1Wb/lBca325bi
 DdBvkw7l4hXBWU4IPHEeJi8iWphg+DUESfnmEAIO6nZ5sCLNIRjsS1oA2yqdqEz1
 qDcsI4QJUvXA7uTJVeMjJRaHJC2fna9hNMzxRBAKfyWH1DJLQMXoDDM0PnJ//A3L
 IkmGGv0mnZqAWnJ34lIN104R9Y8nQytj0EIMF7neImnLJejdq7SFDMCgHkoFz2jO
 x5tcCaQO8h3aWJEnsl0GlFVRwqmB66uQnNUKpSULrwpR7IXsr3A4P8AUPkHsQibB
 tSpSl0dsVch5iCgEKuV2EMM0g4i0yjdPVMEbE0LGEV8l9jdosEwMDQ4qm3q7bR8c
 VNtD0A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k1fg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:01:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-920fb8b9859so104280396d6.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795438914; x=1796043714; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F1gFJ15/VkXNFitkQMduPe0dWyuv85qy1ddsXjmlDIc=;
 b=XsM3jGhjvla6WV1yDZxONWEcMJgouBWNduAxlwSLsWwj00+cnlvlTejD/AgKSgIfxu
 3JpQdiX0UVPIoGlQa8WO1bdKurLX7kmQSne8+oQWZ9CEIhVGFthXq+P3KJEvHJIkpYvx
 +x7/BjducF66hcpg4gPHNONZ3czrxJsnWb4MPsyFIlzHMa0/5GGbWYoEIVnHqV7KgbLl
 aH6qNxosHrR8wXCpGwSUDXgSzW6oln6WOoKsrN67hyDuiHsDS42BbuaatGz+i/rPWg9R
 OiJBWt3ZG9sqcCmlObhWT7vl8vuXsQDjGL8qgagdPmvpOBrAjaDDI6O/7oOMKzu52MW3
 B46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438914; x=1796043714;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F1gFJ15/VkXNFitkQMduPe0dWyuv85qy1ddsXjmlDIc=;
 b=sghRwGIs/j5wpb59EaXg1bh8AaW1tQeAaq5VGf0pmrM4wPd1urFtuEQnWNEcAf0Yku
 LefqmyDyl3eWM5A3rY6upc7TXWUgBNhDYwd61q0ImIJJ9yUrnpIMXWmacv2AImZDfgKu
 /3gAZOG6XhEigFpIWqAI9AHrTQWxGf33JCZYEEaMssy6BbvPyl/ZykLg4EQkE4y4ymfW
 Ag4uIALYHD7I+D4KF1P4F7JcuFyspMVNkFHI7yOPy+oWPckfOp6sdiwWG/zbLFDYfkTa
 WzvjljXJNsWMsS9xBjrQZieotRqSW17/MFmyOtnNsHSu+pI6R4V8PvJ19JF3UDUdVNtk
 BEiA==
X-Forwarded-Encrypted: i=1;
 AL+hErFiof6g3izctPfUKHO59AXlHitTHc98tl5Xz1k/HFgyMySDKmDmPZahYQjU1yoVoWmnmzlklzRoEvUv@nongnu.org
X-Gm-Message-State: APuU4Z+AV11LZ4Ohu2IO7d2X3mMxPQZQqDJ1YreXTJfP/z7eCVRpuTpd
 EvPoYv/Sdivv746ECpACFwKDNkQJPnfutb9zc5XExezoPyrPCGxvJWtXQhczWMlygcqEXRF9+yv
 Odg9vxdHECsG72DRbf8Bh3sYw0Fb4eQ9rzC1WQRMlGpS3pIWjY3jMV8M4v6ddJ/o=
X-Gm-Gg: AZFdTZcZtrXO2Ou1PjZAqKDABkw9g9dCwZTgxbjP7PBAF8+U0BfntL4lZfIWLwYViHy
 3el0MQpCf4eKECGWD36hnM/QV2gEwL1TQVncNeT0zCXlg1PTiKn5rVmMQdHcut1Zf56F72SPMME
 rR8eKmSwg8qR8JrnoYcHypJwCxr4hI+0WP8cx3OIWBV/dZRPZejf/MMBctAvGeOkhK36zw5Ng53
 G5i2Iec2exAAuWubIUO2e7llQR4ExSCUK+jim7WZcW8ph9rWVEs4giO0OEpo55uikOsWuYREiED
 Pv24EiiKq78/r8f67RSdLNxkbvH4BKtbtQO6vvd51r/fYw2eke83R/Dzz3iy/a42uLiwoBfc/ec
 zoakdG3+1pAc21L55IFO2I5j+Z/3lthrzE6DEM1pYCQotD1L5JrioHLwp5FFnh8MteETAGIyURf
 Eborv5uuQW
X-Received: by 2002:a05:6214:4108:b0:921:3730:b09b with SMTP id
 6a1803df08f44-9213730b141mr186544246d6.45.1795438913820; 
 Mon, 23 Nov 2026 05:01:53 -0800 (PST)
X-Received: by 2002:a05:6214:4108:b0:921:3730:b09b with SMTP id
 6a1803df08f44-9213730b141mr186543856d6.45.1795438913164; 
 Mon, 23 Nov 2026 05:01:53 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm103563256d6.34.2026.11.23.05.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:01:52 -0800 (PST)
Message-ID: <92436cc6-3d05-4404-851c-4b13846cb7f7@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:01:49 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 04/10] hw/riscv/virt: add opt-in RPMI base support
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20261111060403.3777501-5-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111060403.3777501-5-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MSBTYWx0ZWRfX1KdEjz1q+x1x
 zPjzCpn4i3FbBBobmML+1RX2Ed/45H4pbZ7ggl5EEebXpPYf62sTCzWYfpQ4g2focoePmLiIOxo
 DoeEWjLvNQJhxkUURDjEP11Mz2x/1+4=
X-Proofpoint-GUID: I7jbLh3CuJBQ4K9KV_IWbGnkGASOR1xk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MSBTYWx0ZWRfX+vUzJUAaj1S7
 46WIjUp3JaNy6K7ip+c+UjDKZBzKl1qH8EPaSA9nYexVrzNbrPHBiUprSJcoo3XF0+5QFBp9Kds
 96jdlUCkaGUI5sxlPrsi7P7yjseRUrx1QXXzYHkoNRYwNwPdas68py55tEHkNN6NEzY6/ZH0/kl
 Gz4IwGyGprYIWRBhKPnF6uji3aXHtyAjwJ/FB4gXSAb9xlHR1xgOEdjeT9D3/H2sq9U0zAJz3AI
 HDejXb0OYyxYuYSXlxXRKuSBFxWp9vpzC5AlUIfCzhlyll/yxVlrpo1MDsXY9zerfnmjOaSoqta
 MZytHLy50jlddgV8Jb1vbCifuPJZ4G4MxlKNrHEcWZkUxXiBAMRABW51hw/V1wLfmGjXEq5ob38
 R9WVcyZfflYtF+8uAj9dWiBGQYDhZGok1aug2vs0aguSlRPU68+yjzxyu9s6LIdf74+m3E6rr5j
 oo66u6fl5AYd/xOScIA==
X-Proofpoint-ORIG-GUID: I7jbLh3CuJBQ4K9KV_IWbGnkGASOR1xk
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b043942 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QaC23mGSh3G_0Hz8NDYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/2026 3:03 AM, Subrahmanya Lingappa wrote:
> Add the virt machine rpmi=on/off option and wire the initial RPMI
> Base transport into machine realization for firmware clients that use RPMI
> platform management.
> 
> The option remains disabled by default. Enabling it requires a
> librpmi-enabled TCG build; KVM and builds without librpmi reject the
> configuration. The RPMI mailbox node is emitted when enabled, while the
> legacy reset and poweroff nodes remain available until the later service
> patches select the RPMI reset path.
> 
> Size each A2P queue from one quarter of shared memory after
> reserving 8 KiB: 30 KiB per queue on virt.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/Kconfig        |  1 +
>   hw/riscv/virt.c         | 90 +++++++++++++++++++++++++++++++++++++++++
>   include/hw/riscv/virt.h |  3 ++
>   3 files changed, 94 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d89fdfcc86..28d108faf8 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -49,6 +49,7 @@ config RISCV_VIRT
>       imply VIRTIO_VGA
>       imply TEST_DEVICES
>       imply TPM_TIS_SYSBUS
> +    imply RISCV_RPMI
>       select DEVICE_TREE
>       select RISCV_NUMA
>       select GOLDFISH_RTC
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index de1c92463a..8a2ed43029 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -46,6 +46,8 @@
>   #include "hw/intc/riscv_aplic.h"
>   #include "hw/intc/sifive_plic.h"
>   #include "hw/misc/sifive_test.h"
> +#include "hw/misc/riscv_rpmi.h"
> +#include "hw/riscv/rpmi-fdt.h"
>   #include "hw/core/platform-bus.h"
>   #include "chardev/char.h"
>   #include "system/device_tree.h"
> @@ -107,6 +109,8 @@ static const MemMapEntry virt_memmap[] = {
>       /* UART1 supports page isolation from UART0 */
>       [VIRT_UART1] =        { 0x1000a000,         0x100 },
>       [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> +    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
> +    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
>       [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>       [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>       [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -115,6 +119,10 @@ static const MemMapEntry virt_memmap[] = {
>       [VIRT_DRAM] =         { 0x80000000,           0x0 },
>   };
>   
> +#define VIRT_RPMI_A2P_REQ_SIZE \
> +    ((virt_memmap[VIRT_RPMI_SHMEM].size - 0x2000) / 4)
> +#define VIRT_RPMI_P2A_REQ_SIZE 0
> +
>   /* PCIe high mmio is fixed for RV32 */
>   #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
>   #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
> @@ -470,6 +478,35 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
>       s->pci_iommu_bdf = bdf;
>   }
>   
> +static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
> +                                        const uint32_t *hart_ids,
> +                                        uint32_t hart_count)
> +{
> +    return (RiscvRpmiConfig) {
> +        .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
> +        .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
> +        .shmem_size = s->memmap[VIRT_RPMI_SHMEM].size,
> +        .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
> +        .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
> +        .platform_info = "QEMU RISC-V virt RPMI",
> +        .hart_ids = hart_ids,
> +        .hart_count = hart_count,
> +    };
> +}
> +
> +static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle)
> +{
> +    RiscvRpmiFdtMboxConfig cfg = {
> +        .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
> +        .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
> +        .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
> +        .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
> +        .doorbell_size = s->memmap[VIRT_RPMI_DOORBELL].size,
> +    };
> +
> +    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle, NULL);
> +}
> +
>   static void finalize_fdt(RISCVVirtState *s)
>   {
>       uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
> @@ -506,6 +543,9 @@ static void finalize_fdt(RISCVVirtState *s)
>                               s->memmap[VIRT_TEST].base,
>                               s->memmap[VIRT_TEST].size,
>                               FINISHER_RESET, FINISHER_PASS, true);
> +    if (s->have_rpmi) {
> +        create_fdt_rpmi(s, &phandle);
> +    }
>   
>       create_fdt_uarts(s, irq_mmio_phandle);
>   
> @@ -739,6 +779,18 @@ static void virt_machine_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    if (s->have_rpmi) {
> +#ifndef CONFIG_LIBRPMI
> +        error_report("RISC-V RPMI support is not compiled in");
> +        exit(1);
> +#else
> +        if (kvm_enabled()) {
> +            error_report("RISC-V RPMI support is not available with KVM");
> +            exit(1);
> +        }
> +#endif
> +    }
> +
>       /* Initialize sockets */
>       mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
>       for (i = 0; i < socket_count; i++) {
> @@ -897,6 +949,21 @@ static void virt_machine_init(MachineState *machine)
>       /* SiFive Test MMIO device */
>       sifive_test_create(s->memmap[VIRT_TEST].base);
>   
> +    if (s->have_rpmi) {
> +        MachineClass *mc = MACHINE_GET_CLASS(machine);
> +        const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
> +        g_autofree uint32_t *rpmi_hart_ids =
> +            g_new0(uint32_t, machine->smp.cpus);
> +        RiscvRpmiConfig rpmi_cfg;
> +
> +        for (i = 0; i < machine->smp.cpus; i++) {
> +            rpmi_hart_ids[i] = possible_cpus->cpus[i].arch_id;
> +        }
> +
> +        rpmi_cfg = virt_rpmi_config(s, rpmi_hart_ids, machine->smp.cpus);
> +        riscv_rpmi_create(&rpmi_cfg, &error_fatal);
> +    }
> +
>       /* VirtIO MMIO devices */
>       for (i = 0; i < VIRTIO_COUNT; i++) {
>           sysbus_create_simple("virtio-mmio",
> @@ -1050,6 +1117,20 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
>       s->have_aclint = value;
>   }
>   
> +static bool virt_get_rpmi(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    return s->have_rpmi;
> +}
> +
> +static void virt_set_rpmi(Object *obj, bool value, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    s->have_rpmi = value;
> +}
> +
>   bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
>   {
>       return s->iommu_sys == ON_OFF_AUTO_ON;
> @@ -1166,6 +1247,15 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>                                             "enable/disable emulating "
>                                             "ACLINT devices");
>   
> +
> +    object_class_property_add_bool(oc, "rpmi", virt_get_rpmi,
> +                                   virt_set_rpmi);
> +    object_class_property_set_description(oc, "rpmi",
> +                                          "Set on/off to enable/disable "
> +                                          "RISC-V RPMI devices; requires "
> +                                          "librpmi and is unavailable with "
> +                                          "KVM");
> +
>       object_class_property_add_str(oc, "aia", virt_get_aia,
>                                     virt_set_aia);
>       object_class_property_set_description(oc, "aia",
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 6e4fbf4b64..c9fb118fc8 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -55,6 +55,7 @@ struct RISCVVirtState {
>   
>       int fdt_size;
>       bool have_aclint;
> +    bool have_rpmi;
>       RISCVVirtAIAType aia_type;
>       int aia_guests;
>       char *oem_id;
> @@ -82,6 +83,8 @@ enum {
>       VIRT_VIRTIO,
>       VIRT_UART1,
>       VIRT_FW_CFG,
> +    VIRT_RPMI_SHMEM,
> +    VIRT_RPMI_DOORBELL,
>       VIRT_IMSIC_M,
>       VIRT_IMSIC_S,
>       VIRT_FLASH,


