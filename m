Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FCDCA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 01:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEzbh-0003QF-4B; Thu, 08 Oct 2026 21:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xEzab-0003AO-2j; Thu, 08 Oct 2026 21:40:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xEzaY-0007P6-1C; Thu, 08 Oct 2026 21:39:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990ZXGJ2711613; Fri, 9 Oct 2026 01:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XX4GHS
 5PQgZ3MQMyPNaQ3MFIu2tzTF7OTi06rxNYCvc=; b=nQUKz8nCn6pmgGVfi5ONU/
 upd8gBK05/32eETmDHYOQZxOkinjL2pe3z4tYU8tABfGP1nSjrE95BhIe4A0jk2V
 agbMKruZNkJDR72WSiAA1zPIjcY+xt0bb/p3/koGB9NrgJ9AObTqHJ4Llwdxcfy4
 U/xm03advmMIu0yZQKAg2gkPIwgM/N759bEiErk5rw7sr67hkpgAAjknNHhx1XWY
 85DxvEfyVAE7yy22TFySAucdyGhVWZmKmX7FTBtz5A/njUBKLuGfgeb1JjGize2l
 GIvxunaNpQczxHtpSy68tis1D7XQTHPp4nVVrPlpiriMtx3VAq39/bkZa1Xic5MA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw76d7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 01:39:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990WTjX115882; Fri, 9 Oct 2026 01:39:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dsvcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 01:39:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6991dgvd53608946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 01:39:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6808520040;
 Fri,  9 Oct 2026 01:39:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 945A720049;
 Fri,  9 Oct 2026 01:39:39 +0000 (GMT)
Received: from [9.124.216.92] (unknown [9.124.216.92])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 01:39:39 +0000 (GMT)
Message-ID: <68fab557-b118-4f32-9abe-23ab60315a43@linux.ibm.com>
Date: Fri, 9 Oct 2026 07:09:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ppc/spapr: Temporarily disable VFIO BAR mmap
 during EEH PE reset
To: mahesh@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 sourabhjain@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, adityag@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com
References: <20260902114758.85160-1-nnmlinux@linux.ibm.com>
 <20260902114758.85160-3-nnmlinux@linux.ibm.com>
 <asJlgfvC0UfgPWKd@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <asJlgfvC0UfgPWKd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNiBTYWx0ZWRfX3NuIQtJKBHts
 JnBmPu3rnK68wEjn5AUPKwNNdrwpNU8VDWAP0VvNvyh46LwUTtZ/KcNsv4bTlhDRXHaRYxzHxlW
 xrL6dJtmvrfyBq/b/hAPID2UgHJjfAU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNiBTYWx0ZWRfXzuw3grBwzBpK
 r3TNNRXoWVDmBqs26vqW+LQdgMpuQ5NaDB+2BMmFOJLB/YB1Oa8BZfl5PSJoYIOTJTm6o7IrTr2
 bOMhs88Hlq7jvDNK2VyC4ZLaAAj4F99FfrE4hxyvSD1YrYXrMK8ZzR0kUMvmDPM0/3UvDT0/z/2
 U8c1PnSAglVXERV2Y6CqKGAJnNQUb/5nn6GnQo3+tiBdYpi0/SMYH/yza1ZFaFL0Ve3soB8keGA
 ZzvqBG/zbaUuZeySbIM302XgZsNO7IFp8l/uagMJQH65IOshmAny6BMNwjsnrrAla4XKIxj7u4/
 d143FmuUWb6Wlx95PcVkGHwvzJzvH0hlUmPyCT0bnGFvyR8OxjKzOZLTXRctCMJOTdgSUNX/ae7
 /OgH2g1CQOwMtYmhmszvAZjUO3KStvZVU1kd8OeLFTw3fPn4UPZEN2qn0VDcGmRBdzrC/D7FXky
 F7uPmedGgktZa+Erm9g==
X-Proofpoint-GUID: 82pzD3puT6rO9wiHzmH8nqAppgobpdv8
X-Proofpoint-ORIG-GUID: W4svjUrdFGYq0SoDF4e_Mhi-8UquripB
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac845e5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=rbiQkOqF3RILFAqqlzYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090006
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Mahesh,

Thanks for the review.

On 04/10/26 9:11 PM, Mahesh J Salgaonkar wrote:
> On 2026-09-02 17:17:58 Wed, Narayana Murty N wrote:
>> An EEH PE hot or fundamental reset involves a synchronous kernel ioctl
>> (VFIO_EEH_PE_RESET_HOT / VFIO_EEH_PE_RESET_FUNDAMENTAL) that asserts
>> then de-asserts a PCI reset signal to the endpoint.  During this window
>> the device's BARs are inaccessible, but QEMU may still have those BARs
>> memory-mapped for direct guest access.  A guest MMIO fault that arrives
>> while the hardware is in reset can cause an unexpected host kernel page
>> fault or an indeterminate read value.
>>
>> Fix this by disabling the BAR mmap windows for every VFIO PCI device
>> under the PHB before issuing the PE reset ioctl, and re-enabling them
>> after VFIO_EEH_PE_CONFIGURE succeeds.
>>
>> A new spapr_phb_vfio_eeh_post_configure() bus walker calls
>> vfio_region_mmaps_set_enabled(..., true) on the configure success
>> path inside spapr_phb_vfio_eeh_configure().  On failure the mmaps
>> remain disabled; the next EEH reset attempt will call pre_reset
>> again.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_pci_vfio.c | 68 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
>> index c233822d14..1cf058cbde 100644
>> --- a/hw/ppc/spapr_pci_vfio.c
>> +++ b/hw/ppc/spapr_pci_vfio.c
>> @@ -252,17 +252,28 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
>>    * pci_host_config_write_common() so that the VFIO config-write handler calls
>>    * vfio_msix_disable(), cleanly releasing vectors and KVM irqfd routes while
>>    * leaving the shadow intact.
>> + *
>> + * After disabling interrupts, disable BAR mmap windows so that the host
>> + * kernel PE reset ioctl does not race with QEMU direct-mapped guest accesses.
>> + * The timer that would ordinarily re-enable mmaps after an INTx quiet period
>> + * is cancelled here; mmaps are restored after VFIO_EEH_PE_CONFIGURE succeeds
>> + * in spapr_phb_vfio_eeh_configure().
>>    */
>>   static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
>>                                              PCIDevice *pdev,
>>                                              void *opaque)
>>   {
>> +    VFIOPCIDevice *vdev;
>>       uint16_t flags;
>> +    int i;
>>   
>>       if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
>>           return;
>>       }
>>   
>> +    vdev = VFIO_PCI_DEVICE(pdev);
>> +
>> +    /* Step 1: disable MSI-X without wiping the shadow table (see above). */
>>       if (msix_enabled(pdev)) {
>>           flags = pci_get_word(pdev->config + pdev->msix_cap + PCI_MSIX_FLAGS);
>>           flags &= ~PCI_MSIX_FLAGS_ENABLE;
>> @@ -270,6 +281,19 @@ static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
>>                                        pdev->msix_cap + PCI_MSIX_FLAGS,
>>                                        pci_config_size(pdev), flags, 2);
>>       }
>> +
>> +    /*
>> +     * Step 2: cancel any pending INTx mmap re-enable timer.  The timer is
>> +     * only allocated when PCI_INTERRUPT_PIN is non-zero, so guard the call.
>> +     */
>> +    if (vdev->intx.mmap_timer) {
>> +        timer_del(vdev->intx.mmap_timer);
>> +    }
>> +
>> +    /* Step 3: disable BAR mmaps last, after interrupt teardown. */
>> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
>> +        vfio_region_mmaps_set_enabled(&vdev->bars[i].region, false);
>> +    }
> 
> Maybe you can add a small helper in something like
> vfio_eeh_pci_pre_reset(pdev) in hw/vfio/pci.c to include step 2 and 3 ?
> That way VFIOPCIDevice internals can be hidden under the helper.
> 
Yes, that makes sense.

I will move the INTx mmap timer handling and BAR mmap enable/disable 
into VFIO PCI helpers.
>>   }
>>   
>>   static void spapr_phb_vfio_eeh_prepare_bus(PCIBus *bus, void *opaque)
>> @@ -286,6 +310,43 @@ static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
>>       pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_prepare_bus, NULL);
>>   }
>>   
>> +/*
>> + * Re-enable BAR mmap windows for a single VFIO PCI device after a successful
>> + * EEH PE configure.  Called only on the configure success path; on failure the
>> + * mmaps remain disabled until the next hot/fundamental reset attempt.
>> + */
>> +static void spapr_phb_vfio_eeh_post_configure_dev(PCIBus *bus,
>> +                                                   PCIDevice *pdev,
>> +                                                   void *opaque)
>> +{
>> +    VFIOPCIDevice *vdev;
>> +    int i;
>> +
>> +    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
>> +        return;
>> +    }
>> +
>> +    vdev = VFIO_PCI_DEVICE(pdev);
>> +
>> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
>> +        vfio_region_mmaps_set_enabled(&vdev->bars[i].region, true);
>> +    }
> 
> Same here.
> 
> Also, what about the mmap timer ? Does that get re-armed when INTx is
> re-initialsed during EEH recovery and hence we ignore here ?
> 
The timer itself remains allocated; timer_del() only cancels the pending
expiration.

I don't think we need to explicitly re-arm it from the EEH
post-configure path. After VFIO_EEH_PE_CONFIGURE succeeds we restore the
BAR mmap state. If the device subsequently uses INTx, the next
vfio_intx_interrupt() will disable the mmap regions and arm the mmap
timer again when mmap_timeout is configured.

For the MSI-X case, disabling MSI-X temporarily moves VFIO back to INTx,
and when the guest restores MSI-X, the normal vfio_msix_enable() path
tears that INTx state down again.
>> +}
>> +
>> +static void spapr_phb_vfio_eeh_post_configure_bus(PCIBus *bus, void *opaque)
>> +{
>> +    pci_for_each_device_under_bus(bus,
>> +                                  spapr_phb_vfio_eeh_post_configure_dev,
>> +                                  NULL);
>> +}
>> +
>> +static void spapr_phb_vfio_eeh_post_configure(SpaprPhbState *sphb)
>> +{
>> +    PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
>> +
>> +    pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_post_configure_bus, NULL);
>> +}
>> +
>>   int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
>>   {
>>       uint32_t op;
>> @@ -293,6 +354,11 @@ int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
>>   
>>       switch (option) {
>>       case RTAS_SLOT_RESET_DEACTIVATE:
>> +        /*
>> +         * Deactivate does not perform a full PE reset; BAR mmaps were already
>> +         * disabled by the preceding HOT or FUNDAMENTAL reset call and must not
>> +         * be re-enabled here.
>> +         */
>>           op = VFIO_EEH_PE_RESET_DEACTIVATE;
>>           break;
>>       case RTAS_SLOT_RESET_HOT:
>> @@ -324,6 +390,8 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
>>           return RTAS_OUT_PARAM_ERROR;
>>       }
>>   
>> +    spapr_phb_vfio_eeh_post_configure(sphb);
>> +
>>       return RTAS_OUT_SUCCESS;
>>   }
> 
> 
> Thanks,
> -Mahesh.

Thanks,
Narayana.
> 


