Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721D0C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4grx-0005BG-OT; Thu, 10 Sep 2026 11:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x4got-0004Ix-QQ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:36:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x4gor-0006GW-Li
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 11:36:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF4HTs1326007
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CkBuYnVEFqNmecdCOzz0NMVW
 zRY9PTfV5IY+HOIFOr0=; b=kVhQ6dj4dyitSieXxsX0jbEK0MDGtEyx8z658+0r
 yAwDZz9uqwZY8/X0cNXrPPNaw/38ZNAot88rpzQeaqfdCP0xgUUSOZ7uE80O7zWZ
 2whHJl1ZHZCojb5MLMtva2C4nvbaBjxlRbPQ3ERc2llQ7cq0iuLIeK336AuzFLlw
 DONtMBxlkwks9XxTmY2ogd+b4jApTu4TKuKG1zUlkrGXxwP5AJIta/KKSniNsymK
 HZ5i85lKniPot/me9wWtj/EH/vY0T28gjM7QSevLTH5AmJd93SyVz/CYuWdG/DqA
 0L8l7gs7ojl7RC2FKpaE9W6f5TPqKmXu+cABLDSBDV6XXA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwts0k9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 15:36:08 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c0fb008616so1246659e0c.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789054567; x=1789659367; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CkBuYnVEFqNmecdCOzz0NMVWzRY9PTfV5IY+HOIFOr0=;
 b=Jc9pdeM7QhkTVJexeLEtwuVPwKaA1umKEIdTdQytN3xRYOrHPUfJKaDfHj98xCEkYx
 iH3yRkQE3un9YMhZ3vCliJartx7cbDCoiwAjJBPDpkUzRClw/NNxgJnrPMvFGEU8GO2j
 edlZNRj9dpJLmlvUEcjcwTnG3mbZP9H4S9Emiai1qD3/dJbfEn998pKSgD+aIsubLhBY
 FPtNeaCjmow+2ce/2tk+PDRfag7xfk406DCQMe6b+sDhME92Y+vZ85LT1AucaLmKTSWi
 +ADoYZkAgAjHTsn5OvDt6qCI32DngU5YzZJsPNZvWGmH4pfrMCAx0mFaLpZKhfbnKpz5
 iYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789054567; x=1789659367;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CkBuYnVEFqNmecdCOzz0NMVWzRY9PTfV5IY+HOIFOr0=;
 b=GQzEX0OEfmRaKH/W4SJ52qHvI2qhxy9yOBHaEUIJ/dZnDR1OSPvqBZAtz8ohRxL9H+
 noVb1lTr1TfGaYkm5EJGhpnVXpg62TVkjDR4TH7HRJkE+97/3C4pwOPqGcevyQ0UYwkW
 6Ga9in2u83B0i6x/ZKxCltb6QhJkiFEKO/UKna3NbTrAGzQ7P5+aWTMUrkzQWjNB8ybt
 oPPcnfXM1odIATujPuoUC328qEK3mUFJSWQkIchKbq1nKqe2Vy6aNGcR1q4B/wYx4IDb
 uB7fKhUMKojYD9WfsA5AUL/1r720EGryj2fOjkkOecOU6rse/KuB4qeaoLZTwOIH4WyH
 9DFw==
X-Gm-Message-State: AFuF++nEODBS9G/LDx5YUPnPzCirNF+QL0LO/nfrgNrkgoKCi9bidR18
 mCkFugk1VBcdfBXfMJEideXt7dHZsujryZ3SSpbT0q+Pvq7iUB2q3y3KTZIGe/sAE5Paddv9J4h
 CDGd04ypDZn1p6BnDTRmYuCc6YqrS29jIbDXtRVEaW4LmQ8sukPh0sKhipQ==
X-Gm-Gg: AYBFou1bjGTyFGqdVvICM7odBXcEYJ/U6zaoE87Q4Sn15dJ//EfoKK7mYgfC83GAYUy
 QZ7jxOTlJZfeRLjQjyugdFNAThJVnMLlteFogF6bgRTjIVLBl18dVivWzDSIU2Xri4XEDoFtnKv
 +ZTUIS53tUeqkZjnFruN25X/byUKRvg+o/KbI/sCljksoqpflly7OoIqb/wrDJpSsXkQ89B14oO
 VqH9+xXZ1vHpjwTsaiwGkruTKw0Z0HvWJ98W7WTNPAt8LcBEGvEq02jfY3tA5NRCxNKm3o7pma4
 HaFIs/WJRUxQOa70NHBqhjufV3Z+74d6S4MWnn8H2ncu6naOO32FUZ/uM0PP/bTaXJY9Ij0Zeng
 hVxo11YzCf3tOwdDp20TpANFUiUgiYqwt1jAoRQ==
X-Received: by 2002:a05:6122:811b:10b0:5bd:b47d:1865 with SMTP id
 71dfb90a1353d-5c837caeca2mr2319315e0c.5.1789054567067; 
 Thu, 10 Sep 2026 08:36:07 -0700 (PDT)
X-Received: by 2002:a05:6122:811b:10b0:5bd:b47d:1865 with SMTP id
 71dfb90a1353d-5c837caeca2mr2319259e0c.5.1789054566630; 
 Thu, 10 Sep 2026 08:36:06 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60a8a812sm3359125e9.2.2026.09.10.08.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:36:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 17:36:04 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Nutty Liu <nutty.liu@hotmail.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v11 3/5] hw/riscv: server platform reference machine
Message-ID: <zvil6c7jl5erlz5g4ukwj7p4x5if7tqkjvkm3lrp2appofd2us@q4ovbwbtpprj>
References: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
 <20260909210756.1767711-4-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909210756.1767711-4-daniel.barboza@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=PIaaavqC c=1 sm=1 tr=0 ts=6aa2ce68 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=CW-XEwPB8W0jjLA3ZmoA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: 5ibIkCYR5JVFfGAdZ3XG5JZX_yhIDrR5
X-Proofpoint-ORIG-GUID: 5ibIkCYR5JVFfGAdZ3XG5JZX_yhIDrR5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE4OSBTYWx0ZWRfX2P5qoPOw/7JY
 VZQKLeftiy5Ky0Hck+zNqEP8Rw5o4qY0C7y5WiP5KOoWaKhLdLgRzo+bJ7DSXwDVQC/aksR6UUC
 Hux0DUr/7me3dp6N6lKCdGV6Kt/2ulo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE4OSBTYWx0ZWRfX0tS0z1kYymp4
 TtU6n58T/a+NzHfmXJQZ7Tyvy62kQANmShZ/CZN8p6TjHKOikCwV+LUYHox70kldnYGGUjXtNMO
 +qUgZKlmWPVB5vxOVMc7kc86bjB7pmj47m2eWlhtg7fBmnh7aY4guLklRZnA14lQdfFIDhRKjK4
 ooAbEDfpAIS9X2VwD8579CuMLTFWSkzqZwb9fI9cGYtQAa5Ex0Om0TN1eg4w6TFDqtVnRhQVuHG
 8u5PsiddiEI1Q51xqmOrm/893rpSLFuEuRwYiiKi430rdMqP6GPigNP5BToFfW/nspv+xhL//fq
 kXqa2fUD6l5BfALVxhFtPONEOMEoAWtX364Vbhy571U+IgeTTasZL/UrqTuvxQhQiOQTjwsvyQ0
 d53NfKsOJIbjmUq6Fsa48kCO2F7klt1nphKJaA793cyf0OmxqLEHOa8J4B9fFg2n6Dl5astGD77
 UJlxboQjrRChL78KZMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Wed, Sep 09, 2026 at 06:07:53PM -0300, Daniel Henrique Barboza wrote:
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d06ac26648..da59eb2155 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -69,6 +69,22 @@ config RISCV_VIRT
>      select ACPI
>      select ACPI_PCI
>
> +config RISCV_SERVER_PLATFORM_REF
> +    bool
> +    default y
> +    depends on RISCV64
> +    imply TPM_TIS_SYSBUS
> +    select RISCV_NUMA
> +    select GOLDFISH_RTC
> +    select PCI
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select SERIAL

This needs to select SERIAL_MM rather than SERIAL, since the machine calls
serial_mm_init(). It also directly uses the platform bus, so it needs

    select PLATFORM_BUS

The machine also creates an ICH9 AHCI controller, so keeping it would require
selecting AHCI_ICH9.

However, SATA is optional for Server Platform v1.0, so I suggest dropping the
default ICH9 AHCI controller instead. That would also remove the IDE/AHCI
includes, NUM_SATA_PORTS, the AHCI-specific state, and its initialization.
The base machine would then have no default storage controller, and users
could add NVMe explicitly when needed.

Likewise, networking hardware is optional, so I suggest dropping the e1000e
default NIC. pci_init_nic_devices() may remain for explicit -nic requests.

To make suitable optional devices such as NVMe available, I suggest

    imply PCIE_DEVICES

rather than the broader PCI_DEVICES set.

> +#include "system/kvm.h"
> +#include "system/qtest.h"
> +#include "system/tcg.h"
> +#include "kvm/kvm_riscv.h"
> +#include "system/tpm.h"
> +#include "system/qtest.h"

Duplicate system/qtest.h include.

> +#define RVSERVER_IRQCHIP_NUM_MSIS 255
> +#define RVSERVER_IRQCHIP_NUM_SOURCES 96
> +#define RVSERVER_IRQCHIP_NUM_PRIO_BITS 3
> +#define RVSERVER_IRQCHIP_MAX_GUESTS_BITS 3
> +#define RVSERVER_IRQCHIP_MAX_GUESTS \
> +    ((1U << RVSERVER_IRQCHIP_MAX_GUESTS_BITS) - 1U)
> +#define RVSERVER_IRQCHIP_DEFAULT_AIA_GUESTS 5

nit: Please align these definitions with the related definitions above.
Also, the two nearby #error strings have "accomodate" rather than
"accommodate".

> +enum {
> +    RVSERVER_UART0_IRQ = 10,
> +    RVSERVER_RTC_IRQ = 11,
> +    RVSERVER_PCIE_IRQ = 32, /* 32 to 35 */
> +    IOMMU_SYS_IRQ = 36, /* 36 to 39 */
> +    RVSERVER_PLATFORM_BUS_IRQ = 40, /* 40 to 48 */
> +};

RVSERVER_PLATFORM_BUS_NUM_IRQS is 8, so this should say 40 to 47. Please
also align the assignments.

> +static const MemMapEntry rvserver_ref_memmap[] = {
> +    [RVSERVER_DEBUG] =          {        0x0,         0x100 },

RVSERVER_DEBUG does not appear to be used.

> +        riscv_aclint_mtimer_create(memmap[RVSERVER_ACLINT].base +
> +                i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +                RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +                base_hartid, hart_count,
> +                RISCV_ACLINT_DEFAULT_MTIMECMP,
> +                RISCV_ACLINT_DEFAULT_MTIME,
> +                RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);

Server SoC v1.0 CTI_010 requires the time CSR to count in units of 1 ns,
so we should define a machine-specific 1 GHz timebase rather than using
the 10 MHz virt default, for example

    #define RVSERVER_ACLINT_TIMEBASE_FREQ 1000000000

and use RVSERVER_ACLINT_TIMEBASE_FREQ in this call. The CPU FDT
timebase-frequency property should use

    kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
                    RVSERVER_ACLINT_TIMEBASE_FREQ

> +    if (!rvserver_aclint_allowed()) {
> +        error_report("'aclint' is only available with TCG acceleration");
> +        exit(1);
> +    }

This makes the machine TCG/qtest only. We can follow virt's support of KVM
to enable it. The documentation can state that a conformant guest requires
a conformant host, while allowing nonconformant hosts to be used for
functional KVM testing.

> +static void rvserver_ref_machine_instance_init(Object *obj)
> +{
> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
> +
> +    s->flash[0] = riscv_flash_create(OBJECT(s),
> +                                     "riscv-server-ref.flash0",
> +                                     "pflash0",
> +                                     RVSERVER_FLASH_SECTOR_SIZE);
> +    s->flash[1] = riscv_flash_create(OBJECT(s),
> +                                     "riscv-server-ref.flash1",
> +                                     "pflash1",
> +                                     RVSERVER_FLASH_SECTOR_SIZE);

virt has an instance finalizer which unreferences either flash device when
initialization fails before realization. This machine should have the same
cleanup and set instance_finalize in its TypeInfo.

> +    static const char * const valid_cpu_types[] = {
> +        TYPE_RISCV_CPU_RVSERVER_REF,
> +    };

This needs a NULL terminator. MachineClass.valid_cpu_types is walked until
NULL. For example, testing this with "-cpu max" printed:

    The valid models are: riscv-server-ref, (null), (null)

KVM also needs TYPE_RISCV_CPU_HOST in the valid CPU types.

Thanks,
drew

