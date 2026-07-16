Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39918C43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 04:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkDyz-0001LW-BI; Thu, 16 Jul 2026 00:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1wkDyx-0001LF-F8; Thu, 16 Jul 2026 00:45:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1wkDyu-0007IG-Nr; Thu, 16 Jul 2026 00:45:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G4D13H2162863; Thu, 16 Jul 2026 04:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TmYKuA
 nqgglGQh6TNlNe8jZyBCjgGnfXBtzeWpsPBTE=; b=DxwZP/oX1kf1/XzUZB7LZ4
 qakz0Hqq/g/RvipuNz5XXX71vdIp7F5q9t7dTZY5iNDrg5MzkDzeohpjbsVpQlWz
 evUWd/EaIoVKylfaFigSI7j3VZuyU7tlQl1WWkAN2DVDYBhZpwqx5DiXPed5XWmj
 gSt47AJ31RjmrrG68KOMD5hUSDJ585ebPC/Muv1eiWozbLai3aE3yKANhUeSgUPn
 sW1l9B9tgAMT0Vf+o+O81wzQuK028mTrSvKL1URC1cZSwmFUVcV58FmqyzfmVSIn
 LaarWmmvMk5kDhW8fPboh8d4aA6X/WDLlRMTr/FNhZU0ZPg+RY1LsAqnKkMwsarA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtf193-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 04:45:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G4YbG6010076;
 Thu, 16 Jul 2026 04:45:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyb35y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 04:45:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66G4jjrW14877132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 04:45:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF3B20040;
 Thu, 16 Jul 2026 04:45:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D08E20043;
 Thu, 16 Jul 2026 04:45:42 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 04:45:42 +0000 (GMT)
Message-ID: <0afdda10-c446-4fe9-aff5-5131701fe75c@linux.ibm.com>
Date: Thu, 16 Jul 2026 10:14:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/ppc: move RAS-specific RTAS handlers to
 spapr_rtas_ras.c
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, npiggin@gmail.com, mahesh@linux.ibm.com,
 Shivang Upadhyay <shivanug@linux.ibm.com>
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
 <20260714164745.573141-2-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260714164745.573141-2-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 4gqvCXhZXDs05N3ToAP4yYS_STh9lL-y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA0NSBTYWx0ZWRfX4zK7ddmfOSfu
 tsIYTRIVcpxqumTRMz5d5u9yYpBg2cqj4A2esIWieaHczrq6O47jN7vT/mQmIxIpFsAkRTigarx
 gTIrzlNr6UrUYw46yw4jr18LsDzcztU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA0NSBTYWx0ZWRfX6AOyvIk6qaHQ
 GpviFckNPLXfsvrriSkib41YllBPSIqr+t6kCzj6UouuRkZJC+pJFJ7lZLKL5G/LupVTdanspAj
 WMynM8XBT+eSvA6F0Qp/S33/aByJcep21l9p5+VUucdhG79H+m8RlIFP5Qrlw482iufkelPIebM
 zxi/v55ST6BuhwjlPVilAekKhA6e66TEpOGKO222BiFlwowtmK/NzZwSd5bL9s36pulVtLaW1t6
 QvEJPtpfvps/4uHpgKcQSBlSKaLG7RVANvRUAkAV55Ngai7STBqxYEmUsemW0wQMC0aobYq+yIB
 sRZlPpR6H+LdYLyyLtFquR992HNhDo/cWUIIwyIWL4WmWuqBj+27mTwXv/18wkwtJ+W7PNza/x3
 VzTce7XXcpj/VrZDhF4M/9TXdsLhrIpvkloJhFrMyw1RRjhqYxaxqa4vExoWTN97wRZysj6NU35
 cfLJaGyQX2oe9042Asg==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a586200 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=2sJ748kMt6RusM_KV0UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LirxWS2_7dVoNK30Rb9WNg2GalM67sVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160045
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 14/07/26 22:17, Shivang Upadhyay wrote:
> Following RTAS calls are moved to spapr_rtas_ras.c file
> - ibm,os-term
> - ibm,nmi-register
> - ibm,nmi-interlock
> - ibm,configure-kernel-dump
>
> The rtas calls are initialized with a new rtas_register_types
> constructor.
>
> No functional changes.
>
> Signed-off-by: Shivang Upadhyay <shivanug@linux.ibm.com>
> ---
>   hw/ppc/meson.build      |   1 +
>   hw/ppc/spapr_rtas.c     | 189 --------------------------------
>   hw/ppc/spapr_rtas_ras.c | 232 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 233 insertions(+), 189 deletions(-)
>   create mode 100644 hw/ppc/spapr_rtas_ras.c
>
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 37aa535db2..83edb3d852 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -14,6 +14,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
>     'spapr_events.c',
>     'spapr_hcall.c',
>     'spapr_nested.c',
> +  'spapr_rtas_ras.c',
>     'spapr_iommu.c',
>     'spapr_rtas.c',
>     'spapr_pci.c',
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 328fc27c40..f8538735a4 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -361,96 +361,6 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
>       rtas_st(rets, 0, ret);
>   }
>   
> -/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
> -static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
> -                                   SpaprMachineState *spapr,
> -                                   uint32_t token, uint32_t nargs,
> -                                   target_ulong args,
> -                                   uint32_t nret, target_ulong rets)
> -{
> -    target_ulong cmd = rtas_ld(args, 0);
> -    uint32_t ret_val;
> -
> -    /* Number of outputs has to be 1 */
> -    if (nret != 1) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -            "FADump: ibm,configure-kernel-dump called with nret != 1.\n");
> -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        return;
> -    }
> -
> -    /* Number of inputs has to be 3 */
> -    if (nargs != 3) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -            "FADump: ibm,configure-kernel-dump called with nargs != 3.\n");
> -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        return;
> -    }
> -
> -    switch (cmd) {
> -    case FADUMP_CMD_REGISTER:
> -        ret_val = do_fadump_register(spapr, args);
> -        if (ret_val != RTAS_OUT_SUCCESS) {
> -            rtas_st(rets, 0, ret_val);
> -            return;
> -        }
> -        break;
> -    case FADUMP_CMD_UNREGISTER:
> -        if (spapr->fadump_dump_active) {
> -            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
> -            return;
> -        }
> -
> -        spapr->fadump_registered = false;
> -        spapr->fadump_dump_active = false;
> -        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> -        break;
> -    case FADUMP_CMD_INVALIDATE:
> -        if (!spapr->fadump_dump_active) {
> -            qemu_log_mask(LOG_GUEST_ERROR,
> -                "FADump: Nothing to invalidate, no dump active\n");
> -
> -            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        }
> -
> -        spapr->fadump_registered = false;
> -        spapr->fadump_dump_active = false;
> -        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> -        break;
> -    default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                "FADump: Unknown command: " TARGET_FMT_lu "\n", cmd);
> -
> -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        return;
> -    }
> -
> -    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -}
> -
> -static void rtas_ibm_os_term(PowerPCCPU *cpu,
> -                            SpaprMachineState *spapr,
> -                            uint32_t token, uint32_t nargs,
> -                            target_ulong args,
> -                            uint32_t nret, target_ulong rets)
> -{
> -    target_ulong msgaddr = rtas_ld(args, 0);
> -    char msg[512];
> -
> -    if (spapr->fadump_registered) {
> -        /* If fadump boot works, control won't come back here */
> -        return trigger_fadump_boot(spapr, rets);
> -    }
> -
> -    physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
> -    msg[sizeof(msg) - 1] = 0;
> -
> -    error_report("OS terminated: %s", msg);
> -    qemu_system_guest_panicked(NULL);
> -
> -    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -}
> -
>   static void rtas_set_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                                    uint32_t token, uint32_t nargs,
>                                    target_ulong args, uint32_t nret,
> @@ -501,95 +411,6 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       rtas_st(rets, 1, 100);
>   }
>   
> -static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> -                                  SpaprMachineState *spapr,
> -                                  uint32_t token, uint32_t nargs,
> -                                  target_ulong args,
> -                                  uint32_t nret, target_ulong rets)
> -{
> -    hwaddr rtas_addr;
> -    target_ulong sreset_addr, mce_addr;
> -
> -    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
> -        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> -        return;
> -    }
> -
> -    rtas_addr = spapr_get_rtas_addr();
> -    if (!rtas_addr) {
> -        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> -        return;
> -    }
> -
> -    sreset_addr = rtas_ld(args, 0);
> -    mce_addr = rtas_ld(args, 1);
> -
> -    /* PAPR requires these are in the first 32M of memory and within RMA */
> -    if (sreset_addr >= 32 * MiB || sreset_addr >= spapr->rma_size ||
> -           mce_addr >= 32 * MiB ||    mce_addr >= spapr->rma_size) {
> -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        return;
> -    }
> -
> -    if (kvm_enabled()) {
> -        if (kvmppc_set_fwnmi(cpu) < 0) {
> -            rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> -            return;
> -        }
> -    }
> -
> -    spapr->fwnmi_system_reset_addr = sreset_addr;
> -    spapr->fwnmi_machine_check_addr = mce_addr;
> -
> -    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -}
> -
> -static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> -                                   SpaprMachineState *spapr,
> -                                   uint32_t token, uint32_t nargs,
> -                                   target_ulong args,
> -                                   uint32_t nret, target_ulong rets)
> -{
> -    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
> -        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> -        return;
> -    }
> -
> -    if (spapr->fwnmi_machine_check_addr == -1) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -"FWNMI: ibm,nmi-interlock RTAS called with FWNMI not registered.\n");
> -
> -        /* NMI register not called */
> -        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> -        return;
> -    }
> -
> -    if (spapr->fwnmi_machine_check_interlock != cpu->vcpu_id) {
> -        /*
> -         * The vCPU that hit the NMI should invoke "ibm,nmi-interlock"
> -         * This should be PARAM_ERROR, but Linux calls "ibm,nmi-interlock"
> -         * for system reset interrupts, despite them not being interlocked.
> -         * PowerVM silently ignores this and returns success here. Returning
> -         * failure causes Linux to print the error "FWNMI: nmi-interlock
> -         * failed: -3", although no other apparent ill effects, this is a
> -         * regression for the user when enabling FWNMI. So for now, match
> -         * PowerVM. When most Linux clients are fixed, this could be
> -         * changed.
> -         */
> -        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -        return;
> -    }
> -
> -    /*
> -     * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> -     * hence unset fwnmi_machine_check_interlock.
> -     */
> -    spapr->fwnmi_machine_check_interlock = -1;
> -    qemu_cond_signal(&spapr->fwnmi_machine_check_interlock_cond);
> -    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -    migrate_del_blocker(&spapr->fwnmi_migration_blocker);

Nit: since |migrate_del_blocker| is being moved out of this file, we can 
remove
|#include "migration/blocker.h"| from here.

> -}
> -
>   static struct rtas_call {
>       const char *name;
>       spapr_rtas_fn fn;
> @@ -737,20 +558,10 @@ static void core_rtas_register_types(void)
>       spapr_rtas_register(RTAS_IBM_SET_SYSTEM_PARAMETER,
>                           "ibm,set-system-parameter",
>                           rtas_ibm_set_system_parameter);
> -    spapr_rtas_register(RTAS_IBM_OS_TERM, "ibm,os-term",
> -                        rtas_ibm_os_term);
>       spapr_rtas_register(RTAS_SET_POWER_LEVEL, "set-power-level",
>                           rtas_set_power_level);
>       spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
>                           rtas_get_power_level);
> -    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> -                        rtas_ibm_nmi_register);
> -    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> -                        rtas_ibm_nmi_interlock);
> -
> -    /* Register fadump rtas call */
> -    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kernel-dump",
> -                        rtas_configure_kernel_dump);
>   
>       qtest_set_command_cb(spapr_qtest_callback);
>   }
> diff --git a/hw/ppc/spapr_rtas_ras.c b/hw/ppc/spapr_rtas_ras.c
> new file mode 100644
> index 0000000000..2f7ee3bb24
> --- /dev/null
> +++ b/hw/ppc/spapr_rtas_ras.c
> @@ -0,0 +1,232 @@
> +/*
> + * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Emulator
> + *
> + * RAS (Reliability, Availability and Serviceability) RTAS call handlers:
> + *   - ibm,configure-kernel-dump  (FADump)
> + *   - ibm,os-term                (FADump-aware OS termination)
> + *
> + * Copyright (c) 2010-2011 David Gibson, IBM Corporation.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qemu/units.h"
> +#include "system/physmem.h"
> +#include "system/runstate.h"
> +#include "kvm_ppc.h"
> +#include "migration/blocker.h"
> +
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_fadump.h"
> +
> +/* PAPR Section 7.4.9 ibm,configure-kernel-dump RTAS call */
> +static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
> +                                       SpaprMachineState *spapr,
> +                                       uint32_t token, uint32_t nargs,
> +                                       target_ulong args,
> +                                       uint32_t nret, target_ulong rets)
> +{
> +    target_ulong cmd = rtas_ld(args, 0);
> +    uint32_t ret_val;
> +
> +    /* Number of outputs has to be 1 */
> +    if (nret != 1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: ibm,configure-kernel-dump called with nret != 1.\n");
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    /* Number of inputs has to be 3 */
> +    if (nargs != 3) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: ibm,configure-kernel-dump called with nargs != 3.\n");
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    switch (cmd) {
> +    case FADUMP_CMD_REGISTER:
> +        ret_val = do_fadump_register(spapr, args);
> +        if (ret_val != RTAS_OUT_SUCCESS) {
> +            rtas_st(rets, 0, ret_val);
> +            return;
> +        }
> +        break;
> +    case FADUMP_CMD_UNREGISTER:
> +        if (spapr->fadump_dump_active) {
> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
> +            return;
> +        }
> +
> +        spapr->fadump_registered = false;
> +        spapr->fadump_dump_active = false;
> +        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> +        break;
> +    case FADUMP_CMD_INVALIDATE:
> +        if (!spapr->fadump_dump_active) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Nothing to invalidate, no dump active\n");
> +
> +            rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        }
> +
> +        spapr->fadump_registered = false;
> +        spapr->fadump_dump_active = false;
> +        memset(&spapr->registered_fdm, 0, sizeof(spapr->registered_fdm));
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "FADump: Unknown command: " TARGET_FMT_lu "\n", cmd);
> +
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
> +static void rtas_ibm_os_term(PowerPCCPU *cpu,
> +                             SpaprMachineState *spapr,
> +                             uint32_t token, uint32_t nargs,
> +                             target_ulong args,
> +                             uint32_t nret, target_ulong rets)
> +{
> +    target_ulong msgaddr = rtas_ld(args, 0);
> +    char msg[512];
> +
> +    if (spapr->fadump_registered) {
> +        /* If fadump boot works, control won't come back here */
> +        return trigger_fadump_boot(spapr, rets);
> +    }
> +
> +    physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
> +    msg[sizeof(msg) - 1] = 0;
> +
> +    error_report("OS terminated: %s", msg);
> +    qemu_system_guest_panicked(NULL);
> +
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> +                                  SpaprMachineState *spapr,
> +                                  uint32_t token, uint32_t nargs,
> +                                  target_ulong args,
> +                                  uint32_t nret, target_ulong rets)
> +{
> +    hwaddr rtas_addr;
> +    target_ulong sreset_addr, mce_addr;
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    rtas_addr = spapr_get_rtas_addr();
> +    if (!rtas_addr) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    sreset_addr = rtas_ld(args, 0);
> +    mce_addr = rtas_ld(args, 1);
> +
> +    /* PAPR requires these are in the first 32M of memory and within RMA */
> +    if (sreset_addr >= 32 * MiB || sreset_addr >= spapr->rma_size ||
> +           mce_addr >= 32 * MiB ||    mce_addr >= spapr->rma_size) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    if (kvm_enabled()) {
> +        if (kvmppc_set_fwnmi(cpu) < 0) {
> +            rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +            return;
> +        }
> +    }
> +
> +    spapr->fwnmi_system_reset_addr = sreset_addr;
> +    spapr->fwnmi_machine_check_addr = mce_addr;
> +
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)
> +{
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    if (spapr->fwnmi_machine_check_addr == -1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +"FWNMI: ibm,nmi-interlock RTAS called with FWNMI not registered.\n");
> +
> +        /* NMI register not called */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    if (spapr->fwnmi_machine_check_interlock != cpu->vcpu_id) {
> +        /*
> +         * The vCPU that hit the NMI should invoke "ibm,nmi-interlock"
> +         * This should be PARAM_ERROR, but Linux calls "ibm,nmi-interlock"
> +         * for system reset interrupts, despite them not being interlocked.
> +         * PowerVM silently ignores this and returns success here. Returning
> +         * failure causes Linux to print the error "FWNMI: nmi-interlock
> +         * failed: -3", although no other apparent ill effects, this is a
> +         * regression for the user when enabling FWNMI. So for now, match
> +         * PowerVM. When most Linux clients are fixed, this could be
> +         * changed.
> +         */
> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +        return;
> +    }
> +
> +    /*
> +     * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> +     * hence unset fwnmi_machine_check_interlock.
> +     */
> +    spapr->fwnmi_machine_check_interlock = -1;
> +    qemu_cond_signal(&spapr->fwnmi_machine_check_interlock_cond);
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    migrate_del_blocker(&spapr->fwnmi_migration_blocker);
> +}
> +
> +static void ras_rtas_register_types(void)
> +{
> +    spapr_rtas_register(RTAS_IBM_OS_TERM, "ibm,os-term",
> +                        rtas_ibm_os_term);
> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> +                        rtas_ibm_nmi_register);
> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> +                        rtas_ibm_nmi_interlock);
> +    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kernel-dump",
> +                        rtas_configure_kernel_dump);
> +}
> +
> +type_init(ras_rtas_register_types)


