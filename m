Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767F1CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByOK-0000GC-NV; Wed, 30 Sep 2026 13:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xByOF-0008Qs-Sc; Wed, 30 Sep 2026 13:46:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xByOD-00019b-UY; Wed, 30 Sep 2026 13:46:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5vJl3167177; Wed, 30 Sep 2026 17:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UNcEha
 bxsoSCJlYPtYFnc2Emf4vmUDCDeudrTU+7b70=; b=Up53393V4CQJjwjplcb+ru
 dWAXqRtilyjNFQVGjrF3NL7QQyL6WlXHlL02XyUGzSIxD3qijxDrcFCIJFH9nuiB
 OWaqCxBlNApopl1b/phnM8oYl6vLtZkUtItN3DDiSBmn4nwFxtTkWIn7+22yRYNX
 w1Ok5IyADz/j6hyzMec6V0AZQRowB935A8SMlIjMBPHlAORtaL76hHncFSNt9T0K
 bdJawB6IDtwbbLgol1XDkWo2wxWHXQYPOoRSRDRgFgh/OhGZB9Bc+RgRJsL9ZKGn
 ibEruJElNtd9ywMKj0qQrfYimV4XuHgSf6vpbYw5u8qbD4k1V27HidhZkV41eCsA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptdkxd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 17:46:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHjYiD3605919; Wed, 30 Sep 2026 17:46:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhqmt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 17:46:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UHkfCW62456178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 17:46:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5ABA58056;
 Wed, 30 Sep 2026 17:46:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B8B058068;
 Wed, 30 Sep 2026 17:46:41 +0000 (GMT)
Received: from [9.61.244.222] (unknown [9.61.244.222])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 17:46:41 +0000 (GMT)
Message-ID: <28cc3141-6db8-418d-bd7f-5ed6efe51a01@linux.ibm.com>
Date: Wed, 30 Sep 2026 10:46:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20260922171756.920-1-alifm@linux.ibm.com>
 <20260922171756.920-2-alifm@linux.ibm.com>
 <2ee98743-546b-4726-904a-6fe828dbb175@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <2ee98743-546b-4726-904a-6fe828dbb175@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vKdwrNP_fLOCGOsf_2LtknZ02TlRKZVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX2CmwBA/haQu0
 xwKF/JstT0RN5JRvf3rlZT8puA5wKIXyR2ryWmXaVt3cvmmIf9WdqbEWhL4avNUkVA27TqYKFcQ
 Aw94PKtSzqszWiOKG886EkicY4rOtVjBkz2kSp0R5tvTqBIXK8A79e6axy5JYflBq+qJGyAOOl/
 golgmLani/3KnRBNipFMXcLTkKeMEZNmln3ZITS3XMN/g9TIRS/C8sH0CZl5ZPjFKQxpBEqzpF8
 UBq42Umt1aBDiDVPGf/QUQ+37/Wp1IpDpGLHOWkFSpvP5Wh4pgYCGzi32batpcvmnvBIu584Tg7
 N6zneVPF04d6WJ4CUCaLHOYHlu01FMiZE3zyi6RQU4P8voc9bowAcan1ptPKIKDLOpYfB+ZICwa
 s+wQQ+b9Thh9Lgr65VVJrHkaHMK5QqpMCL0D1+Djc53lxNe+lWvEgZHE90t71CtTdksBdXl1qYq
 gxl6lI76obZBJeCU/jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXxUd4k8Go52+V
 //g2AU5D6SKbUWyqi+V7QQKJyyLkRdAMcr1oGKVYWCA/V6lnUkiZytzmEMGV2eoENdl/7mnMatO
 h8YQVxrcfmrP4EGd4+puZG9BiGurAQ4=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd4b03 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=P-IC7800AAAA:8
 a=LRaPCR-D77ovgF5VUQ0A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: vKdwrNP_fLOCGOsf_2LtknZ02TlRKZVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300070
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


On 9/30/2026 9:30 AM, Matthew Rosato wrote:
>> +static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
>> +                                    PciCcdfErr *ccdf,
>> +                                    uint32_t ccdf_err_length,
>> +                                    Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +    int ret;
>> +    size_t total_size;
>> +    struct vfio_device_feature_zpci_err *err;
>> +    g_autofree void *buf = NULL;
>> +    g_autofree struct vfio_device_feature *feature = NULL;
>> +
>> +    total_size = sizeof(*feature) + sizeof(*err);
>> +    feature = g_malloc(total_size);
>> +    feature->argsz = total_size;
>> +    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>> +
>> +    buf = g_malloc(ccdf_err_length);
>> +    err = (void *)feature->data;
>> +    err->data = (uint64_t)buf;
>> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
>> +
>> +    if (ret) {
>> +        error_setg(errp, "Failed feature get VFIO_DEVICE_FEATURE_ZPCI_ERROR"
>> +                   " (rc=%d)", ret);
> I see this was changed from last version, but doesn't this fall under
> 'avoid useless error object creation and destruction' described in
> qapi/error.h for the -ENOMSG return value?
>
> We create it here only to explicitly destroy it from the caller.
>
> Can we instead switch to the negative/non-negative return structure with
> something like...
>
> <0: error as defined (so we set errp)
> 0-N: number of errors to process (and we do not set errp)
>
> For the non-negative case we can realistically only have 0 (-ENOMSG maps
> to this) or 1 (the feature found something - it is reporting 1 error to
> handle).

I was trying to follow what I assumed to be existing pattern for 
handling expected errno[1]. I am okay to change it, but I would like to 
understand what is the preferred approach here.

[1] https://elixir.bootlin.com/qemu/v11.1.2/source/hw/vfio/iommufd.c#L408


>> +        return ret;
>> +    }
>> +
>> +    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);
> You already had err->data in void *buf, can we just
>
> memcpy(ccdf, buf, ccdf_err_length);
>
Sure, I can make the change.


>> +
>> +    return 0;
>> +}
>> +
>> +static void s390_pci_err_handler(void *opaque)
>> +{
>> +    VFIOPCIDevice *vfio_pci;
>> +    S390PCIBusDevice *pbdev;
>> +    Error *local_err = NULL;
>> +    PciCcdfErr ccdf;
>> +    int ret = 0;
>> +
>> +    vfio_pci = opaque;
>> +    if (!event_notifier_test_and_clear(&vfio_pci->err_notifier)) {
>> +        return;
>> +    }
> Another one I should have commented on during v5...  You're right about
> the recent patch and Z support, but what if the patch is missing on the
> host kernel?
>
> I'm fine with the feature not working with AER is off rather than doing
> our own setup, but don't we need to avoid referencing this in that case
> and ideally give some log message?

Discussed this offline and will add a check to see if the err_notifier 
is registered. Though this is not strictly necessary, but better to add 
a defensive check.


>> +
>> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
>> +                                        DEVICE(&vfio_pci->parent_obj)->id);
>> +
> We can get the pci device from the vfio-pci device, so would it work to
> just do this?
>
> s390_pci_find_dev_by_pci(s390_get_phb(), PCI_DEVICE(vfio_pci));
>
> Then we cut out the strcmps

Yup, can change this.

Thanks

Farhan


