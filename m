Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7297BF01826
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySjo-0004m2-I6; Fri, 06 Mar 2026 05:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vySjf-0004kT-WA; Fri, 06 Mar 2026 05:48:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vySjd-0007sp-Rf; Fri, 06 Mar 2026 05:48:47 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625L490C329165; Fri, 6 Mar 2026 10:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+AP79i
 fkjfhMER60db9jG5G7pQkrj7KQUPObrBNDwIA=; b=N86LzA6aOaM1O0vEvzOKVY
 UobkSfxgsLp+xrKdqOJXiQr1LyNfepTPB6jIXO4cKlty0XUKNxhvFPYHr0piWH9x
 KrsFSidMYbsMzswyJmLIdtv/kypkDmUZgTNZIICzsvHwb1C5YpXntzYfroSq+vOU
 q07wG73465i/MFE9B1DP4BYE6+f04piV/9sHr6mQiLomK0oLCupfT6TiXrQJ2kyo
 CEhbJdWgw0Vjxpn+nzjeU1SMBSNI9eXlYq4c6WlRebxoTlOvJfoemdrQNtPg2630
 2t3YhRgXELHma+6BXqofLt/URaQk2xxpiwrrYa/i9P+ipSLDbkBhhP1+w93sPAIA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmyjhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:48:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6268AEgo011312;
 Fri, 6 Mar 2026 10:48:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cqau2v0yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:48:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 626Ama7B33816856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 10:48:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9060B20043;
 Fri,  6 Mar 2026 10:48:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE6E120040;
 Fri,  6 Mar 2026 10:48:34 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2026 10:48:34 +0000 (GMT)
Message-ID: <b8f14d86-25a5-48c4-a982-b728371964a8@linux.ibm.com>
Date: Fri, 6 Mar 2026 16:18:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] ppc/mpipl: Implement S0 SBE interrupt
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
 <20260225124633.1841222-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260225124633.1841222-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwMSBTYWx0ZWRfX8c5Pe1wFdpWP
 0mQzSKY8zm7Wo/4RJfCvwaLMqYAip3Q9zrO5vfBaqd3WxV28PwPscnHOx+Zn4QT4Z+qcm0P6/h3
 ThWbTfB3z8tmaKXGxGDJeS0Nyy59Qxc4lJIu9QSzDjuJtBsNKXzx1FgAGoEKx2+/DbRAsMS6qb4
 GUUDjtHXfDUXTiYz+OQ6IC0uRjIheQ57sq54x64MkGlVnNmDkmqLPtfiAm8MCia+pkVC/xM+qQs
 HNbUsAG2zE37sMJcWvJPxP50usQZpgIORA+CJeVyYE3XxSbQ3eS1Zl6hzpWXqrFF5CTQKLDdgB/
 2aN5mqhZYlP5Qko5j9x6UhpWDD75ZAk4vfX6qZ/Je3BhxzJ641Vu9oBbHoFtd/eFIv1iWsk2NjO
 jpwGWP0br2q4ravYEPlKVTxE785k52R3N1/aaIFR7KY7UqgCMPKN1mwEK6AolH6rCIHVZb59yd+
 N2pyYNC7zZOwm1M9QPw==
X-Proofpoint-ORIG-GUID: _5UFQnn_i0tiCGlnObgSosVCj_f1ujI8
X-Proofpoint-GUID: sW_4L2GlnL4xAGvrWiwiL93zj-m9yp0V
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69aab109 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=PLBsYqVowcRC1OSvligA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060101
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=hbathini@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 25/02/26 6:16 pm, Aditya Gupta wrote:
> During MPIPL (aka fadump), after a kernel crash, the kernel does
> opal_cec_reboot2 opal call, signifying an abnormal termination.

Minor nit..

> When OPAL recieves this opal call, it further triggers SBE S0 interrupt,

s/recieves/receives/

> to trigger a MPIPL boot.
> 
> Currently S0 interrupt is unimplemented in QEMU.
> 
> Implement S0 interrupt as 'pause_vcpus' + 'guest_reset' in QEMU, as the
> SBE's implementation of S0 seems to be basically "stop all clocks" and
> then "host reset".
> 
> pause_vcpus is done in a later patch when register preserving support is
> added
> 
> See 'stopClocksS0' in SBE source code for more information.
> 
> Also log both S0 and S1 interrupts.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/meson.build         |  1 +
>   hw/ppc/pnv_mpipl.c         | 26 ++++++++++++++++++++++++++
>   hw/ppc/pnv_sbe.c           | 29 +++++++++++++++++++++++++++++
>   include/hw/ppc/pnv.h       |  6 ++++++
>   include/hw/ppc/pnv_mpipl.h | 19 +++++++++++++++++++
>   5 files changed, 81 insertions(+)
>   create mode 100644 hw/ppc/pnv_mpipl.c
>   create mode 100644 include/hw/ppc/pnv_mpipl.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index f7dac87a2a48..c61fba4ec8f2 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_pnor.c',
>     'pnv_nest_pervasive.c',
>     'pnv_n1_chiplet.c',
> +  'pnv_mpipl.c',
>   ))
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
> new file mode 100644
> index 000000000000..d8c9b7a428b7
> --- /dev/null
> +++ b/hw/ppc/pnv_mpipl.c
> @@ -0,0 +1,26 @@
> +/*
> + * Emulation of MPIPL (Memory Preserving Initial Program Load), aka fadump
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/runstate.h"
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_mpipl.h"
> +
> +void do_mpipl_preserve(PnvMachineState *pnv)
> +{
> +    /* Mark next boot as Memory-preserving boot */
> +    pnv->mpipl_state.is_next_boot_mpipl = true;
> +
> +    /*
> +     * Do a guest reset.
> +     * Next reset will see 'is_next_boot_mpipl' as true, and trigger MPIPL
> +     *
> +     * Requirement:
> +     * GUEST_RESET is expected to NOT clear the memory, as is the case when
> +     * this is merged
> +     */
> +    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +}
> diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
> index 247617338a0d..5a2b3342d199 100644
> --- a/hw/ppc/pnv_sbe.c
> +++ b/hw/ppc/pnv_sbe.c
> @@ -26,6 +26,9 @@
>   #include "hw/ppc/pnv.h"
>   #include "hw/ppc/pnv_xscom.h"
>   #include "hw/ppc/pnv_sbe.h"
> +#include "hw/ppc/pnv_mpipl.h"
> +#include "system/cpus.h"
> +#include "system/runstate.h"
>   #include "trace.h"
>   
>   /*
> @@ -113,11 +116,37 @@ static uint64_t pnv_sbe_power9_xscom_ctrl_read(void *opaque, hwaddr addr,
>   static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
>                                          uint64_t val, unsigned size)
>   {
> +    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> +    PnvSBE *sbe = opaque;
>       uint32_t offset = addr >> 3;
>   
>       trace_pnv_sbe_xscom_ctrl_write(addr, val);
>   
>       switch (offset) {
> +    case SBE_CONTROL_REG_RW:
> +        switch (val) {
> +        case SBE_CONTROL_REG_S0:
> +            qemu_log_mask(LOG_UNIMP, "SBE: S0 Interrupt triggered\n");
> +
> +            pnv_sbe_set_host_doorbell(sbe, sbe->host_doorbell | SBE_HOST_RESPONSE_MASK);
> +
> +            /* Preserve memory regions and CPU state, if MPIPL is registered */
> +            do_mpipl_preserve(pnv);
> +
> +            /*
> +             * Control may not come back here as 'do_mpipl_preserve' triggers
> +             * a guest reboot
> +             */
> +            break;
> +        case SBE_CONTROL_REG_S1:
> +            qemu_log_mask(LOG_UNIMP, "SBE: S1 Interrupt triggered\n");
> +            break;
> +        default:
> +            qemu_log_mask(LOG_UNIMP,
> +                "SBE: CONTROL_REG_RW: Unknown value: Ox%."
> +                  HWADDR_PRIx "\n", val);
> +        }
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "SBE Unimplemented register: Ox%"
>                         HWADDR_PRIx "\n", addr >> 3);
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 24f8843a4090..7d73629f112a 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -25,6 +25,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/ipmi/ipmi.h"
>   #include "hw/ppc/pnv_pnor.h"
> +#include "hw/ppc/pnv_mpipl.h"
>   
>   #define TYPE_PNV_CHIP "pnv-chip"
>   
> @@ -111,6 +112,8 @@ struct PnvMachineState {
>   
>       bool         big_core;
>       bool         lpar_per_core;
> +
> +    MpiplPreservedState mpipl_state;
>   };
>   
>   PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
> @@ -290,4 +293,7 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
>   
>   #define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
>   
> +/* MPIPL helpers */
> +void do_mpipl_preserve(PnvMachineState *pnv);
> +
>   #endif /* PPC_PNV_H */
> diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
> new file mode 100644
> index 000000000000..c544984dc76d
> --- /dev/null
> +++ b/include/hw/ppc/pnv_mpipl.h
> @@ -0,0 +1,19 @@
> +/*
> + * Emulation of MPIPL (Memory Preserving Initial Program Load), aka fadump
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PNV_MPIPL_H
> +#define PNV_MPIPL_H
> +
> +#include "qemu/osdep.h"
> +
> +typedef struct MpiplPreservedState MpiplPreservedState;
> +
> +/* Preserved state to be saved in PnvMachineState */
> +struct MpiplPreservedState {
> +    bool       is_next_boot_mpipl;
> +};
> +
> +#endif


