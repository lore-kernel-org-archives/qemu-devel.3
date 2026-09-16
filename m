Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562CEC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ton-0007WV-Pt; Wed, 16 Sep 2026 13:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6tob-0007Tx-9C; Wed, 16 Sep 2026 13:53:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6toX-0000Pp-24; Wed, 16 Sep 2026 13:52:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1uWw3041771; Wed, 16 Sep 2026 17:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5v3P6/
 EZybNhXjom24C8B0XDkQfpM6w64AAlcIaAlKE=; b=jfI/ZPZJj291Uo3GDidzIx
 s6BcorDKCaUv51DSVwAv6s6hmVgB3fnnWKKR7aL4iI7L02LtIn8m3spdw4E4yDlS
 nZhoIqxjcW+k6GrbLaaNCPjTzz7qMSXdcdV1LDmw7I6kl15uv8QagmbOA3lNX+4q
 2skrNsXCIkypBy/fLxFdOaRKp7nqo9vpnGqFlxdqv4yCVllFQUcqCE5ibszCEGcR
 DD86X1pMFXVl/QB+sDzfPqJmwzt/VXfHTpKs3GgbJNZ7dcxLcGczfQHPU8jaQW/o
 WT9Xy2d3DkOcr8pQoHqCTtFEOTbt7PS5tA3e6GV3166ezd3S/7WV7RpZ0Gt2lB/Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e5tsx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 17:52:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFe4xD1663482; Wed, 16 Sep 2026 17:52:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089qj6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 17:52:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GHqrY333227396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 17:52:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E74E58055;
 Wed, 16 Sep 2026 17:52:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FDAD58043;
 Wed, 16 Sep 2026 17:52:53 +0000 (GMT)
Received: from [9.61.255.212] (unknown [9.61.255.212])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 17:52:52 +0000 (GMT)
Message-ID: <6071779c-9323-4217-9b57-10353ee781b3@linux.ibm.com>
Date: Wed, 16 Sep 2026 10:52:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] s390x/pci: Add PCI error handling for vfio pci
 devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com
References: <20260914174420.12309-1-alifm@linux.ibm.com>
 <20260914174420.12309-3-alifm@linux.ibm.com>
 <b71cc588-f0f9-4c1e-9207-5ddd103a002e@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <b71cc588-f0f9-4c1e-9207-5ddd103a002e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI0MCBTYWx0ZWRfX4elTYcSOv1nw
 HbfrXDQJmuFY6Fw2AQby6RYgOuYBBpssw2/EEYOaCALWyBdu/O/gZ6kAsNpNr0LRMEsFr6SBuQN
 DlvcR1HIJEih4KuacMXEPDNHKEeDLHL7SduSsqPvGHTXisSBo7AD8EU6c6rs38VczRkjQSfVulc
 dtHMo3hHuaybat7mmLCHBwCqf9V6ExT6sK6AIwd9DHE6GkJHT4Gvc23PfnRgfpa2AZ5eKD6pn6J
 pezgvNkgev7UvUuCkfR/RUY7RnNNJ4r0ZbfWMbIPtzptFlSBnJaCrWQOXKrs1HODmTiB+Ks7vh0
 o2ICkhjdH3m4W8u2BtY3SrRPAqHpK8jg7+H+k422z3ia8Ut99BoosHC2bc9GnkBN1WJonwgpJUv
 2Q1GJUyIXo8K9eyCUY0XTnW91SKLIeASzO6fu7NXLdEF3ttuyALfGba58Xg3wUpLp50tlD3YUo/
 c1LA9lD2V8wYjB5nNtg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaad777 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HgwitAlsePsqkMRBPHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EBTn2r6R5FwesCpNcA0mzR2cvQjeE5OP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI0MCBTYWx0ZWRfXy5FtZxV9LFS6
 dQeYGbquYuXAbqS+POS3zlwuCST0Do+spV/v3q/Eh8ACcY1dJZsaFcdplqPdasB7HOEgn2hCVIH
 8uaiYSIT7jq6qynv4rUcX3Z/DH1FkD4=
X-Proofpoint-GUID: EBTn2r6R5FwesCpNcA0mzR2cvQjeE5OP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160240
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hi Cedric,

On 9/16/2026 1:13 AM, Cédric Le Goater wrote:
> On 9/14/26 19:44, Farhan Ali wrote:
>> Add an s390x specific handler for vfio error notifier. For s390x pci 
>> devices,
>> we have platform specific error information. We need to retrieve this 
>> error
>> information for passthrough devices. This is done via a 
>> VFIO_DEVICE_FEATURE
>> ioctl which exposes that information.
>>
>> Once this error information is retrieved we can then inject an error 
>> into
>> the guest, and let the guest drive the recovery.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c          |   6 ++
>>   hw/s390x/s390-pci-vfio-stubs.c   |   6 ++
>>   hw/s390x/s390-pci-vfio.c         | 115 +++++++++++++++++++++++++++++++
>>   include/hw/s390x/s390-pci-bus.h  |   1 +
>>   include/hw/s390x/s390-pci-vfio.h |   1 +
>>   5 files changed, 129 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 2eb4e8cec4..b2967dacba 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -1085,6 +1085,7 @@ static void s390_pcihost_plug(const 
>> HotplugHandler *hotplug_dev, DeviceState *de
>>       S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>       PCIDevice *pdev = NULL;
>>       S390PCIBusDevice *pbdev = NULL;
>> +    Error *local_err = NULL;
>>       int rc;
>>         if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>> @@ -1175,6 +1176,11 @@ static void s390_pcihost_plug(const 
>> HotplugHandler *hotplug_dev, DeviceState *de
>>               pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, 
>> pbdev);
>>               /* Fill in CLP information passed via the vfio region */
>>               s390_pci_get_clp_info(pbdev);
>> +            /* Setup error handler for error recovery */
>> +            if (!s390_pci_setup_err_handler(pbdev, &local_err)) {
>> +                warn_report_err(local_err);
>> +            }
>> +
>>               if (!pbdev->interp) {
>>                   /* Do vfio passthrough but intercept for I/O */
>>                   pbdev->fh |= FH_SHM_VFIO;
>> diff --git a/hw/s390x/s390-pci-vfio-stubs.c 
>> b/hw/s390x/s390-pci-vfio-stubs.c
>> index d9882b7aad..9fc84ca135 100644
>> --- a/hw/s390x/s390-pci-vfio-stubs.c
>> +++ b/hw/s390x/s390-pci-vfio-stubs.c
>> @@ -30,3 +30,9 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, 
>> uint32_t *fh)
>>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>>   {
>>   }
>> +
>> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
>> +{
>> +    error_setg(errp, "VFIO not available, cannot setup error handler");
>> +    return false;
>> +}
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> index db6de00bd2..6c072005fd 100644
>> --- a/hw/s390x/s390-pci-vfio.c
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -10,6 +10,7 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>     #include <sys/ioctl.h>
>>   #include <linux/vfio.h>
>> @@ -105,6 +106,85 @@ void s390_pci_end_dma_count(S390pciState *s, 
>> S390PCIDMACount *cnt)
>>       }
>>   }
>>   +static bool s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
>> +                                    PciCcdfErr *ccdf,
>> +                                    uint32_t ccdf_err_length,
>> +                                    Error **errp)
>> +{
>> +    int ret;
>> +    size_t total_size;
>> +    struct vfio_device_feature_zpci_err *err;
>> +    g_autofree void *buf = NULL;
>
> could be  buf = g_malloc(ccdf_err_length);

okay, will change.


>
>
>> +    g_autofree struct vfio_device_feature *feature = NULL;
>> +
>> +    total_size = sizeof(*feature) + sizeof(*err);
>> +    feature = g_malloc(total_size);
>> +    feature->argsz = total_size;
>> +    feature->flags = VFIO_DEVICE_FEATURE_GET | 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>> +
>> +    buf = g_malloc(ccdf_err_length);
>> +    err = (void *)feature->data;
>> +    err->data = (uint64_t)buf;
>> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
>> +
>> +    if (ret) {
>> +        if (ret != -ENOMSG) {
>> +            error_setg(errp, "Failed feature get 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR"
>> +                              " (rc=%d)", ret);
>> +        }
>> +        return false;
>
> returning false without setting errp :/

An ENOMSG would indicate there are no more pending errors to be handled 
for the device. It doesn't indicate a critical error. So I don't think 
we want to set the errp? I am open to suggestion on this, should errp be 
set to warn in this case?


>
>> +    }
>> +
>> +    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);
>> +
>> +    return true;
>> +}
>> +
>> +static void s390_pci_err_handler(void *opaque)
>> +{
>> +    VFIOPCIDevice *vfio_pci;
>> +    S390PCIBusDevice *pbdev;
>> +    Error *errp = NULL;
>
> a 'local_err' name would be preferred.

okay, will change.

>
>> +    PciCcdfErr ccdf;
>> +    bool ret = true;
>> +
>> +    vfio_pci = opaque;
>> +    if (!event_notifier_test_and_clear(&vfio_pci->err_notifier)) {
>
> This means that the vfio_pci->err_notifier eventfd was initialized.
> IOW, pci_aer is true.
>
> Is that the case for Z ? If not, this needs its own eventfd setup.

Yes, it is. AFAIU the pci_aer is set if VFIO_PCI_ERR_IRQ_INDEX is 
supported, which it is on Z. The recent kernel change [1] enables it on 
all supported devices on Z.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e3c1fc8abcb8eff062150b4340fa4569696d645


>
>
>> +        return;
>> +    }
>> +
>> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
>> + DEVICE(&vfio_pci->parent_obj)->id);
>> +
>> +    if (!pbdev) {
>> +        error_report("No matching zpci device found");
>> +        return;
>> +    }
>> +    pbdev->state = ZPCI_FS_ERROR;
>> +
>> +    if (sizeof(ccdf) != pbdev->ccdf_err_length) {
>> +        error_report(
>> +                   "CCDF size mismatch expected size=%zu, provided 
>> size=%d",
>> +                   sizeof(ccdf), pbdev->ccdf_err_length);
>> +        return;
>> +    }
>> +
>> +    while (ret) {
>> +        ret = s390_pci_get_feature_err(vfio_pci, &ccdf,
>> + pbdev->ccdf_err_length, &errp);
>> +        if (!ret) {
>> +            if (errp) {
>> +                error_report_err(errp);
>> +            }
>> +            break;
>
> The 'local_err' not being set with a 'false' returned value is not
> following the qapi/error.h guidelines. This is unexpected.
> It is also wrong. ERRP_GUARD() is needed. please read qapi/error.h.

Should the ERRP_GUARD() be added here for local_err or in 
s390_pci_get_feature_err()?
I am open to suggestions on how we can handle the case of ENOMSG which 
is not a critical error.

>
>
>
>> +        }
>> +        s390_pci_generate_error_event(ccdf.pec, pbdev->fh, pbdev->fid,
>> +                                      ccdf.faddr, ccdf.e);
>> +    }
>> +
>> +    return;
>> +}
>> +
>>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>>                                  struct vfio_device_info *info)
>>   {
>> @@ -134,6 +214,10 @@ static void s390_pci_read_base(S390PCIBusDevice 
>> *pbdev,
>>       /* Store function type separately for type-specific behavior */
>>       pbdev->pft = cap->pft;
>>   +    if (hdr->version >= 3) {
>> +        pbdev->ccdf_err_length = cap->ccdf_err_length;
>
> So ccdf_err_length can be 0. Is that expected ?

On kernels that don't support the vfio device feature, the kernel 
doesn't provide ccdf_err_length. So in that case pbdev->ccdf_err_length 
can be 0.


>
>> +    }
>> +
>>       /*
>>        * If the device is a passthrough ISM device, disallow relaxed
>>        * translation.
>> @@ -371,3 +455,34 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>>       s390_pci_read_util(pbdev, info);
>>       s390_pci_read_pfip(pbdev, info);
>>   }
>> +
>> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
>> +{
>> +    int ret;
>> +    int32_t fd;
>> +    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>> +                              sizeof(uint64_t))] = {};
>> +    struct vfio_device_feature *feature = (struct 
>> vfio_device_feature *)buf;
>> +
>> +    feature->argsz = sizeof(buf);
>> +    feature->flags = VFIO_DEVICE_FEATURE_PROBE | 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>> +
>> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
>> +
>> +    if (ret != 0) {
>> +        if (ret == -ENOTTY) {
>> +            error_setg(errp, "Automated error recovery unavailable 
>> for device");
>> +        } else {
>> +            error_setg(errp,
>> +                       "Failed to probe for 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR (ret=%d)",
>> +                       ret);
>> +        }
>> +        return false;
>> +    }
>> +
>> +    fd = event_notifier_get_fd(&vfio_pci->err_notifier);
>> +    qemu_set_fd_handler(fd, s390_pci_err_handler, NULL, vfio_pci);
>
> Shouldn't we check ccdf_err_length before installing the handler ? 
> because
> it won't run cleanly anyhow.
>
> Thanks,
>
> C.
>
I can move the ccdf check before installing the handler.

Thanks

Farhan

>
>> +
>> +    return true;
>> +}
>> diff --git a/include/hw/s390x/s390-pci-bus.h 
>> b/include/hw/s390x/s390-pci-bus.h
>> index 9228523ce8..c2348ede86 100644
>> --- a/include/hw/s390x/s390-pci-bus.h
>> +++ b/include/hw/s390x/s390-pci-bus.h
>> @@ -364,6 +364,7 @@ struct S390PCIBusDevice {
>>       bool forwarding_assist;
>>       bool aif;
>>       bool rtr_avail;
>> +    uint32_t ccdf_err_length;
>>       QTAILQ_ENTRY(S390PCIBusDevice) link;
>>   };
>>   diff --git a/include/hw/s390x/s390-pci-vfio.h 
>> b/include/hw/s390x/s390-pci-vfio.h
>> index f7d6149daf..c7886b63ea 100644
>> --- a/include/hw/s390x/s390-pci-vfio.h
>> +++ b/include/hw/s390x/s390-pci-vfio.h
>> @@ -20,5 +20,6 @@ S390PCIDMACount 
>> *s390_pci_start_dma_count(S390pciState *s,
>>   void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
>>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
>> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
>>     #endif
>

