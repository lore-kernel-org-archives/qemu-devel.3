Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13314C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wupSF-0002n6-TP; Fri, 14 Aug 2026 06:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wupSE-0002mu-UQ; Fri, 14 Aug 2026 06:48:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wupSB-0007FX-Jp; Fri, 14 Aug 2026 06:48:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E82PEJ534480; Fri, 14 Aug 2026 10:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KqUIDr
 HWYJQHLVmzmeZfLpZdbBFSdsRTSb6S3nRU3dM=; b=QXHjtUcYRv8mdcj0Zx1GZI
 P383QQjFnFE8lIHlvzlxnlbX/TCN7kmFys2tW7cvg0iBs7qlYdqpFzpjZWhm/5kT
 razgGBcQvegYjKbzCQ476p2IIwCv3omVq+ZkEPUQxIz2LnEP0v+6ahyStrzrji3H
 +aNnDr2PV9+BYjPVlHLcCAZwNMINZrckzRQCcguGnxlLk/asMb27wL10XRvMnxw+
 KN0mIxBDPNQK8DP6FhYcODjKmg4iZa2zcs2qLSMaWJdgu2afTctl5+wK7+u55mK1
 a4aiWzY7IgK4U192EqEWoXrPMze3KEZTp7jviDfNn+pqT1g5cuIAAghKhEgRnNmA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9vbde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 10:47:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EAfeWW016198;
 Fri, 14 Aug 2026 10:47:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gpufk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 10:47:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67EAliJm15139492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2026 10:47:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1869F58058;
 Fri, 14 Aug 2026 10:47:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10A1358059;
 Fri, 14 Aug 2026 10:47:40 +0000 (GMT)
Received: from [9.124.210.243] (unknown [9.124.210.243])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Aug 2026 10:47:39 +0000 (GMT)
Message-ID: <9906f082-bc01-4ab6-9f10-5c546dc2bd46@linux.ibm.com>
Date: Fri, 14 Aug 2026 16:17:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] powernv: boot OpenBSD on POWER9
To: "Kirill A. Korinsky" <kirill@korins.ky>, shivangu@linux.ibm.com,
 adityag@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 brad@comstyle.com
References: <20260719145559.94342-1-kirill@korins.ky>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260719145559.94342-1-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: sthLg9TOaHN68NxuNekoT-Q9GOXsL93r
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ef252 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ZXJNRhq1AAAA:8
 a=VnNF1IyMAAAA:8 a=cFAuUl7JGljrGlWkidAA:9 a=QEXdDO2ut3YA:10
 a=v5IQ3Wrm8lavPYTLLTww:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MCBTYWx0ZWRfX/XPHnWquc9cu
 tma1eVQtbN3K4ASuXGcg0NGzCuJkiyYpLJ4X1Xxw9xGkphSRKsustCeJkMqP/AbOqkSIDfu1uvf
 L2EMH3GKs89GR02stPE7n49kosQ+iLBwqQAXDN8BMSVnCe6QwevVPQkOqbfsilI1n7rAy558CW+
 f7uvo/FgJ5GfDUuyk8VpOs0DUlsPOKTAc2rTlXMsvLBzFw081iAQRQmYUJDuBf76BHlROhsueP6
 nl06yrpJi1n3tVdXkkQDPcy+3zq898i4idtkjQxdXl7WioTzwgqkoIo0zCfcdOmJfuiQ6yzNIiu
 IJQ1Fa26J/U1grpx4enelKtjDjxOOD2kWB1zoBtkJBUtqABt5GYwY/SJIXsKe9QfZf7MhRUrOEd
 PWH9GSmF7TiqznodB6OqNzCVMA+bnHH8nzoYaoAkiu9ph3M1ESLctub5yDq9gkFetlFTqjTJZAd
 XAqKz86nY2fNbcPa9ow==
X-Proofpoint-ORIG-GUID: LAMjxmIPB5UW64-8EL4u-ZXHUayrUcnT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MCBTYWx0ZWRfX6fcSfW/4ciH2
 oTanSSiY65k81maGCEFfgDyzQEHG/uEALfMb8fdIRk/h9Bgazh5lUzckmE979sxAnTOp7ERhisz
 Ug7U4X9Nnpz7DM3D0BV5PoSO4aBKDhU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140080
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 7/19/26 20:25, Kirill A. Korinsky wrote:
> The POWER9 Processor User's Manual, section 4.9.4, specifies that POWER9
> ignores PTCR[PATS] and only supports a 64 KiB partition table. Use an
> effective PATS value of 4 on POWER9; other processors keep the existing
> ISA v3.0 interpretation.
>
> The PSI model now exposes POWER9 IRQ level and pending status registers,
> and keeps both updated while delivering through the existing XIVE LSI
> source. This lets guests that select the POWER9 PSI LSI IRQ method
> continue to receive LPC interrupts.
>
> The blast radius is probably minimal: the PTCR change is limited to
> POWER9, while the PSI change only touches POWER9 PSI state and reuses
> the existing delivery path.
> ---
>   hw/ppc/pnv_psi.c                       | 11 ++++--
>   target/ppc/mmu-book3s-v3.c             | 21 +++++++++--
Acked-by: Chinmay Rath <rathc@linux.ibm.com>
>   tests/functional/ppc64/meson.build     |  2 +
>   tests/functional/ppc64/test_openbsd.py | 52 ++++++++++++++++++++++++++
>   4 files changed, 79 insertions(+), 7 deletions(-)
>   create mode 100755 tests/functional/ppc64/test_openbsd.py
>
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index e8701c6100..39ec448f3c 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -688,6 +688,8 @@ static uint64_t pnv_psi_p9_mmio_read(void *opaque, hwaddr addr, unsigned size)
>       case PSIHB9_ESB_CI_BASE:
>       case PSIHB9_ESB_NOTIF_ADDR:
>       case PSIHB9_IVT_OFFSET:
> +    case PSIHB9_IRQ_LEVEL:
> +    case PSIHB9_IRQ_STAT:
>           val = psi->regs[reg];
>           break;
>       default:
> @@ -818,17 +820,20 @@ static void pnv_psi_power9_set_irq(void *opaque, int irq, int state)
>   {
>       PnvPsi *psi = opaque;
>       uint64_t irq_method = psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CONTROL)];
> +    uint64_t irq_bit = PPC_BIT(irq);
>   
>       if (irq_method & PSIHB9_IRQ_METHOD) {
>           qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no supported\n");
>           return;
>       }
>   
> -    /* Update LSI levels */
> +    /* Update LSI levels and pending status */
>       if (state) {
> -        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |= PPC_BIT(irq);
> +        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |= irq_bit;
> +        psi->regs[PSIHB_REG(PSIHB9_IRQ_STAT)] |= irq_bit;
>       } else {
> -        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &= ~PPC_BIT(irq);
> +        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &= ~irq_bit;
> +        psi->regs[PSIHB_REG(PSIHB9_IRQ_STAT)] &= ~irq_bit;
>       }
>   
>       qemu_set_irq(psi->qirqs[irq], state);
> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> index 3865556310..f329a7a0f2 100644
> --- a/target/ppc/mmu-book3s-v3.c
> +++ b/target/ppc/mmu-book3s-v3.c
> @@ -23,24 +23,37 @@
>   #include "mmu-hash64.h"
>   #include "mmu-book3s-v3.h"
>   
> +#define PPC64_V3_PATE_SIZE 16 /* two 64-bit words */
> +
>   bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
>   {
>       uint64_t patb = cpu->env.spr[SPR_PTCR] & PTCR_PATB;
>       uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
> +    uint64_t table_size;
> +    uint64_t entries;
> +
> +    /*
> +     * The POWER9 Processor User's Manual, section 4.9.4, specifies that
> +     * POWER9 ignores PTCR[PATS] and only supports a 64 KiB partition table.
> +     */
> +    if (cpu->env.excp_model == POWERPC_EXCP_POWER9) {
> +        pats = 4;
> +    }
> +    table_size = 1ULL << (pats + 12);
>   
>       /* Check if partition table is properly aligned */
> -    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
> +    if (patb & (table_size - 1)) {
>           return false;
>       }
>   
>       /* Calculate number of entries */
> -    pats = 1ull << (pats + 12 - 4);
> -    if (pats <= lpid) {
> +    entries = table_size / PPC64_V3_PATE_SIZE;
> +    if (entries <= lpid) {
>           return false;
>       }
>   
>       /* Grab entry */
> -    patb += 16 * lpid;
> +    patb += PPC64_V3_PATE_SIZE * lpid;
>       entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
>       entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
>       return true;
> diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
> index f0f8ab8f61..cb3c745624 100644
> --- a/tests/functional/ppc64/meson.build
> +++ b/tests/functional/ppc64/meson.build
> @@ -4,6 +4,7 @@ test_ppc64_timeouts = {
>     'fadump' : 480,
>     'hv' : 1000,
>     'mac99' : 120,
> +  'openbsd' : 240,
>     'powernv' : 480,
>     'pseries' : 480,
>     'replay' : 210,
> @@ -20,6 +21,7 @@ tests_ppc64_system_thorough = [
>     'fadump',
>     'hv',
>     'mac99',
> +  'openbsd',
>     'powernv',
>     'pseries',
>     'replay',
> diff --git a/tests/functional/ppc64/test_openbsd.py b/tests/functional/ppc64/test_openbsd.py
> new file mode 100755
> index 0000000000..bdbef6bf82
> --- /dev/null
> +++ b/tests/functional/ppc64/test_openbsd.py
> @@ -0,0 +1,52 @@
> +#!/usr/bin/env python3
> +#
> +# Test that OpenBSD boots on a ppc powernv machine and reaches the installer.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +
> +
> +class OpenBSDPowerNV(QemuSystemTest):
> +
> +    ASSET_MINIROOT = Asset(
> +        'https://kirill.korins.ky/pub/qemu-powerpc64-openbsd/miniroot79.img',
> +        '7829e42b75d81cafd732038b9d63228b79c1f5828d8375872a4bb655e1d6b13c')
> +
> +    ASSET_BOOTKERNEL = Asset(
> +        'https://kirill.korins.ky/pub/qemu-powerpc64-openbsd/pnor.BOOTKERNEL',
> +        '397ce43ce61910e1a2c4f13d301f957e61513a9ec5371bc3e87d3095411fae7b')
> +
> +    def test_powernv9_openbsd_installer(self):
> +        self.set_machine('powernv9')
> +        self.require_accelerator('tcg')
> +
> +        miniroot_path = self.ASSET_MINIROOT.fetch()
> +        bootkernel_path = self.ASSET_BOOTKERNEL.fetch()
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-cpu', 'power9',
> +                         '-accel', 'tcg,thread=single',
> +                         '-smp', '1,cores=1,threads=1',
> +                         '-m', '2g',
> +                         '-kernel', bootkernel_path,
> +                         '-device',
> +                         'ich9-ahci,id=sata0,bus=pcie.0,addr=0x0',
> +                         '-drive',
> +                         f'file={miniroot_path},format=raw,if=none,'
> +                         'id=bootdisk,snapshot=on',
> +                         '-device',
> +                         'ide-hd,bus=sata0.0,unit=0,drive=bootdisk,'
> +                         'bootindex=1')
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'OpenBSD 7.9 (RAMDISK)', 'panic:')
> +        wait_for_console_pattern(
> +            self,
> +            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
> +            'panic:')
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

