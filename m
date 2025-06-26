Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91329C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUpKN-0007vP-0B; Thu, 26 Jun 2025 12:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uUpKK-0007tI-Fq; Thu, 26 Jun 2025 12:19:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uUpKH-0006Mb-LU; Thu, 26 Jun 2025 12:19:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QBTrnP019605;
 Thu, 26 Jun 2025 16:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NK6sGk
 4kF/VKRLbO/wxSuJtxWOP8S8a9Pf5m5jDwQWQ=; b=ppSCoWROCaD5agNQlOky7t
 lPNCWL0CST3mkYE7C3mYlpR4F/bow0RTePuHkG87l54PohiC6Oh4xBz7yuwjtnQH
 o4CdpTv71hEucUUCuiZ9Yk52VyBdVSGuczEGquxno3A8+KxgNkQ5jX9BICWMW0bO
 3xQCSITQmtrtjD5qLOCzVFN22YRyCw2ByeHUYLPDOh6GxfeQiHTlW0T1pN0m90lc
 8lXUYnBD98oZKS0OsNPLPo7bXeIpdBKpsCHKlD2b+1K8yWPDhsAnYx5o969Em+Hi
 I+DFabzRQVCIMRfg2+0/F/l0uhu8CWUDp7mOuzh7kptZSShRW1zDel7sK0iW8u0g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3ffcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 16:19:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55QD1ulI002471;
 Thu, 26 Jun 2025 16:19:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmfpr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 16:19:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55QGJdVU30147232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jun 2025 16:19:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E90458059;
 Thu, 26 Jun 2025 16:19:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E98F058058;
 Thu, 26 Jun 2025 16:19:37 +0000 (GMT)
Received: from [9.61.76.9] (unknown [9.61.76.9])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Jun 2025 16:19:37 +0000 (GMT)
Message-ID: <5c6f7f80-cfa3-432f-9ff3-ae57f8b4cf5a@linux.ibm.com>
Date: Thu, 26 Jun 2025 12:19:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v13 4/4] s390: implementing CHSC SEI for AP config
 change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
References: <20250609164418.17585-1-rreyes@linux.ibm.com>
 <20250609164418.17585-5-rreyes@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20250609164418.17585-5-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685d731d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=jyqTrI2o756uUR7Zab8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEzOCBTYWx0ZWRfX7Wguf+rQCnwg
 Uz80nmX97HFl8ygpEdySpwwALIwkOYSMq+lZRGnbXYR6OQgEyw8nKSIz3j5p3Oo68EdXB3VSDLl
 vMXAXJak/AhfZ7t88GHr/J1Q4azhKlyF2TzbH+CwvRRjUTfc9QLiD53HCc2Sjnb5293pdOkZiHu
 IvmetOalCXsHvTUMauDdcqgsgElUBClhLc3NmvYqy7Ukgz6EwplihYQ8rSiFHXBPj4Li2kjq+Fc
 XBMj4DUiLm1TsmlcxWhCC0e4VnbP6m3ULAywi5FmqdY09asV+3XREFXmSICctfdoyqy4dGGB5+Q
 aQC1n/Th84xIRjkksByNd34bXxHsi8dGH/tlJ6p1xtIjVa0htjdHOQoXaQF/+axwo3h4iYRgmEm
 1QW6EJOt2cKuncbD1RqbTUUtmAE/ojM1uoX+GefIkBj4r7/QMFI2TD+4FXrxcVWU83ab/yno
X-Proofpoint-GUID: ZiEaGTYLSM23JD0snoQWDwppe3Fh3OuB
X-Proofpoint-ORIG-GUID: ZiEaGTYLSM23JD0snoQWDwppe3Fh3OuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260138
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/9/25 12:44 PM, Rorie Reyes wrote:
> Handle interception of the CHSC SEI instruction for requests
> indicating the guest's AP configuration has changed.
> 
> If configuring --without-default-devices, hw/s390x/ap-stub.c
> was created to handle such circumstance. Also added the
> following to hw/s390x/meson.build if CONFIG_VFIO_AP is
> false, it will use the stub file.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

FYI, this patch (or some part of this series) breaks hotplug for PCI devices on s390x.  I verified it breaks with both PCI passthrough and virtio-pci via virsh attach-device.

I get greeted with the following message:
qemu-system-s390x: ../util/qemu-thread-posix.c:92: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
2025-06-26 14:12:23.031+0000: shutting down, reason=crashed

As a quick test, reverting this patch resolves the issue.  

Another test shows that if I have a vfio-ap device attached to my guest before I try the zPCI hotplug, everything works fine (because vfio_ap_realize was driven -- see more info below).

I note in the failing call chain that in response to the hotplug event for a zPCI device we end up calling into hw/vfio/ap.c and getting some locks which seems wrong:

(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
#1  0x000003ffa85ad636 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
#2  0x000003ffa8553c20 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x000003ffa8533e3c in __GI_abort () at abort.c:79
#4  0x000003ffa854ac9a in __assert_fail_base
    (fmt=<optimized out>, assertion=assertion@entry=0x2aa3fa76414 "mutex->initialized", file=file@entry=0x2aa3fa763f8 "../util/qemu-thread-posix.c", line=line@entry=92, function=function@entry=0x2aa3fa7647a <__PRETTY_FUNCTION__.23> "qemu_mutex_lock_impl") at assert.c:94
#5  0x000003ffa854acf4 in __assert_fail
    (assertion=0x2aa3fa76414 "mutex->initialized", file=0x2aa3fa763f8 "../util/qemu-thread-posix.c", line=92, function=0x2aa3fa7647a <__PRETTY_FUNCTION__.23> "qemu_mutex_lock_impl") at assert.c:103
#6  0x000002aa3f83ef02 in qemu_mutex_lock_impl (mutex=0x2aa3fed9e08 <cfg_chg_events_lock>, file=0x2aa3f9e653e "/usr/src/qemu/include/qemu/lockable.h", line=56) at ../util/qemu-thread-posix.c:92
#7  0x000002aa3f4c3a70 in qemu_lockable_mutex_lock (x=0x2aa3fed9e08 <cfg_chg_events_lock>) at /usr/src/qemu/include/qemu/lockable.h:56
#8  0x000002aa3f4c3b00 in qemu_lockable_lock (x=0x3fd076f7730) at /usr/src/qemu/include/qemu/lockable.h:110
#9  0x000002aa3f4c3b82 in qemu_lockable_auto_lock (x=0x3fd076f7730) at /usr/src/qemu/include/qemu/lockable.h:120
#10 0x000002aa3f4c3f90 in ap_chsc_sei_nt0_get_event (res=0x3fd076f79b8) at ../hw/vfio/ap.c:110
^^^^^^^^
#11 0x000002aa3f3a59ea in chsc_sei_nt0_get_event (res=0x3fd076f79b8) at ../target/s390x/ioinst.c:579
#12 0x000002aa3f3a5b76 in ioinst_handle_chsc_sei (req=0x3fd076f79a8, res=0x3fd076f79b8) at ../target/s390x/ioinst.c:620
#13 0x000002aa3f3a6062 in ioinst_handle_chsc (cpu=0x2aa40cc9430, ipb=2097152, ra=0) at ../target/s390x/ioinst.c:708
#14 0x000002aa3f4647d2 in handle_b2 (cpu=0x2aa40cc9430, run=0x3ffa4180000, ipa1=95 '_') at ../target/s390x/kvm/kvm.c:1218
#15 0x000002aa3f465db2 in handle_instruction (cpu=0x2aa40cc9430, run=0x3ffa4180000) at ../target/s390x/kvm/kvm.c:1627
#16 0x000002aa3f4661da in handle_intercept (cpu=0x2aa40cc9430) at ../target/s390x/kvm/kvm.c:1709
#17 0x000002aa3f466c10 in kvm_arch_handle_exit (cs=0x2aa40cc9430, run=0x3ffa4180000) at ../target/s390x/kvm/kvm.c:1914
#18 0x000002aa3f523c98 in kvm_cpu_exec (cpu=0x2aa40cc9430) at ../accel/kvm/kvm-all.c:3294
#19 0x000002aa3f527f52 in kvm_vcpu_thread_fn (arg=0x2aa40cc9430) at ../accel/kvm/kvm-accel-ops.c:51
#20 0x000002aa3f840002 in qemu_thread_start (args=0x2aa40ccd090) at ../util/qemu-thread-posix.c:393
#21 0x000003ffa85ab622 in start_thread (arg=0x3fd076fe8c0) at pthread_create.c:448
#22 0x000003ffa862b390 in thread_start () at ../sysdeps/unix/sysv/linux/s390/s390-64/clone3.S:71


Note that PCI devices were already using SEI before this series (e.g. see hw/s390x/s390-pci-bus.c:pci_chsc_sei_nt2_get_event()); I think the problem here is that nt0 events are looked for implicitly in the shared handler (ioinst_handle_chsc_sei()) which is fine -- but you cannot go acquiring locks from ap.c that might have never been initialized (cfg_chg_events_lock which is only initialized in vfio_ap_realize()); that's why we ultimately crash.

AFAICT this portion of the handler including mutex should be moved out of ap.c into chsc_sei_nt0_get_event().  When vfio_ap is not in use, we can't call into it.  Can't you also build without VFIO_AP?  I didn't try it but that sure seems like it would cause issues too.  

I guess the mutex and list would then need to be part of something common to s390x like S390CcwMachineState.

Alternatively, you could leave those in vfio_ap but would need some kind of indicator that vfio_ap is "armed" for these kinds of events and only bother calling into vfio_ap to look at cfg_chg_events when that indicator has been set (e.g. vfio_ap_realize has been called once.  And it actually looks like you already do something like this via lock_initialized in ap.c). 
Otherwise, we should always return EVENT_INFORMATION_NOT_STORED like the old code did (via return 1).

Or maybe someone else has a better idea.


> ---
>  MAINTAINERS           |  1 +
>  hw/s390x/ap-stub.c    | 21 +++++++++++++++++++++
>  hw/s390x/meson.build  |  1 +
>  target/s390x/ioinst.c | 11 +++++++++--
>  4 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 100644 hw/s390x/ap-stub.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa6763077e..1e84bfeaee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -112,6 +112,7 @@ F: hw/intc/s390_flic.c
>  F: hw/intc/s390_flic_kvm.c
>  F: hw/s390x/
>  F: hw/vfio/ap.c
> +F: hw/s390x/ap-stub.c
>  F: hw/vfio/ccw.c
>  F: hw/watchdog/wdt_diag288.c
>  F: include/hw/s390x/
> diff --git a/hw/s390x/ap-stub.c b/hw/s390x/ap-stub.c
> new file mode 100644
> index 0000000000..001fe5f8b0
> --- /dev/null
> +++ b/hw/s390x/ap-stub.c
> @@ -0,0 +1,21 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/s390x/ap-bridge.h"
> +
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    return EVENT_INFORMATION_NOT_STORED;
> +}
> +
> +bool ap_chsc_sei_nt0_have_event(void)
> +{
> +    return false;
> +}
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index 3bbebfd817..99cbcbd7d6 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -33,6 +33,7 @@ s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
>  ))
>  s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
>  s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
> +s390x_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
>  
>  virtio_ss = ss.source_set()
>  virtio_ss.add(files('virtio-ccw.c'))
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index fe62ba5b06..2320dd4c12 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -18,6 +18,7 @@
>  #include "trace.h"
>  #include "hw/s390x/s390-pci-bus.h"
>  #include "target/s390x/kvm/pv.h"
> +#include "hw/s390x/ap-bridge.h"
>  
>  /* All I/O instructions but chsc use the s format */
>  static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
> @@ -574,13 +575,19 @@ out:
>  
>  static int chsc_sei_nt0_get_event(void *res)
>  {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_get_event(res);
> +    }
> +
>      return 1;
>  }
>  
>  static int chsc_sei_nt0_have_event(void)
>  {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_have_event();
> +    }
> +
>      return 0;
>  }
>  


