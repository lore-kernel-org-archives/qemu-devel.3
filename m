Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01747CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqTi-0004Dh-7P; Mon, 05 Oct 2026 17:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDqTg-0004D9-H4; Mon, 05 Oct 2026 17:44:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDqTe-00032H-Hj; Mon, 05 Oct 2026 17:44:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZWKl1257186; Mon, 5 Oct 2026 21:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Gdq0S3
 muZfkrSxDWvw5BdOxBUyoswj/pvTJtFu4p7Hg=; b=PrTrrGEd2spDa7XO+iAEqB
 TP8phR1b22ropjCZz/PESlPow1LfPCQHmqCMMUw/Nk+2OI7m06xNQrQxd0I9BYlW
 0l5mAaoUt18KBzypHlEvK4/kw/7slWli8xHgXU1AWt01YTJb6l6/PgFYxVZZ9GIo
 e5psdPT/cHuS1T7N3V50uTm39tkeTlgSYzj6IAuxR4WxHwwMoUGSZEtXcyOGaeV4
 4m2woBu3qvrpBeKGitaMfRS5e+hixmfDjddGPajizov8/ACsg5WSEt7y9qXHzW2s
 M8qd7T7C7+LW6jvbowxtExP2uEywiUHvAlLIjzExqzNsvg+6wTE0uocTdOA+7bUQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5cknt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 21:44:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HMlZT3252176; Mon, 5 Oct 2026 21:44:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy71x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 21:44:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695Li2n623069348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 21:44:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95A275805A;
 Mon,  5 Oct 2026 21:44:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1999B58051;
 Mon,  5 Oct 2026 21:44:02 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 21:44:02 +0000 (GMT)
Message-ID: <643768e6-0033-438d-896e-748000056b66@linux.ibm.com>
Date: Mon, 5 Oct 2026 17:44:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20261005174314.871-1-alifm@linux.ibm.com>
 <20261005174314.871-2-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261005174314.871-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfX4eolBsaigkLZ
 tIjLoRPtGFKi+UHgYQK+9AiMbaEdJDbPP+TGlzTSfgQViGJC1iAj61V4EAsXki6G+lfAGdh6qZk
 VI6g/6FpJGs1v7Tcr2B3Tf1odB664PA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfX3IMFcj7fjUE0
 G8PcCRKHsDqE9EWo8r5dqy8OZ7v1gvo2a6mQArLRPJURrEQ6+I6XJOBZUvjB1Y6TsAKke9r4vjm
 0auPWjIhQnpvO9gFITBHsKiCfU2uWVcaaRih7kVyHd7/a3nQ2Zis3e01ABqIF7I7K2L1MEfaDqg
 T2b3Gdv6J9z/OVc8dXU/XlO05HGiISF2O4QinrobHYpvvEQtmybpCoBDUp/p4dROJTauAeG8MZ7
 7Km4Pc30CiDfAPmkZlfOm2avvGzk57tPb3ILFYH3zRw9an9kR4sSZU8yrGN3YY5+f+5p9P/8k7s
 WlhFUbkUVV/IzmXXDn/+0ms6YWRyUwQ10nTQ9yMMxG5Slm7Z0Sl4DID5XnJrAg0YDv0zOXbw67s
 tDM/j/J2wRgej+G7/S+nKsAxjHN3EP1/RxcfurslepvieBkIQngPkZ1UH7h1nzXIc0xogH0G3n5
 T5OVrnRgAETZcOr/42Q==
X-Proofpoint-GUID: QPk5BZHgr-CYshAWfh7KttW35jecnQi6
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac41a24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=z-RzcOww8-3YTEisZwcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QPk5BZHgr-CYshAWfh7KttW35jecnQi6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050085
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 10/5/26 1:43 PM, Farhan Ali wrote:
> Add an s390x specific handler for vfio error notifier. For s390x pci devices,
> we have platform specific error information. We need to retrieve this error
> information for passthrough devices. This is done via a VFIO_DEVICE_FEATURE
> ioctl which exposes that information.
> 
> Once this error information is retrieved we can then inject an error into
> the guest, and let the guest drive the recovery.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

A few comments below but I think no changes required...

[...]

> diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
> index d9882b7aad..9fc84ca135 100644
> --- a/hw/s390x/s390-pci-vfio-stubs.c
> +++ b/hw/s390x/s390-pci-vfio-stubs.c
> @@ -30,3 +30,9 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
>  void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>  {
>  }
> +
> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
> +{
> +    error_setg(errp, "VFIO not available, cannot setup error handler");
> +    return false;
> +}

I wondered for a bit about whether g_assert_not_reached() makes sense
here, since we never call it without first detecting a vfio-pci device,
which should be impossible without VFIO.

But this should also be fine: it satisfies error.h if we were ever to
get here, I just don't expect we will.

[...]
> @@ -134,6 +209,10 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>      /* Store function type separately for type-specific behavior */
>      pbdev->pft = cap->pft;
>  
> +    if (hdr->version >= 3) {
> +        pbdev->ccdf_err_length = cap->ccdf_err_length;
> +    }
> +

This value won't be migrated if we also take Konstantin's migration
series.  But that's OK since it's vfio-pci-only and we still won't allow
migration of s390x vfio-pci with his series.

It also looks like a value we want to re-acquire on the target system,
not migrate.

>      /*
>       * If the device is a passthrough ISM device, disallow relaxed
>       * translation.
> @@ -371,3 +450,47 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>      s390_pci_read_util(pbdev, info);
>      s390_pci_read_pfip(pbdev, info);
>  }
> +
> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
> +{
> +    int ret;
> +    int32_t fd;
> +    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
> +                              sizeof(uint64_t))] = {};
> +    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> +
> +    feature->argsz = sizeof(buf);
> +    feature->flags = VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
> +
> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
> +
> +    if (ret != 0) {
> +        if (ret == -ENOTTY) {
> +            error_setg(errp, "Automated error recovery unavailable for device");
> +        } else {
> +            error_setg(errp,
> +                       "Failed to probe for VFIO_DEVICE_FEATURE_ZPCI_ERROR (ret=%d)",
> +                       ret);
> +        }
> +        return false;
> +    }
> +
> +    if (sizeof(PciCcdfErr) != pbdev->ccdf_err_length) {
> +        error_setg(errp,
> +                   "CCDF size mismatch expected size=%zu, provided size=%d",
> +                   sizeof(PciCcdfErr), pbdev->ccdf_err_length);
> +        return false;
> +    }
> +
> +    if (!vfio_pci->pci_aer) {
> +        error_setg(errp, "%s: VFIO error notifier not registered for device",
> +                   vfio_pci->vbasedev.name);
> +        return false;
> +    }
> +
> +    fd = event_notifier_get_fd(&vfio_pci->err_notifier);
> +    qemu_set_fd_handler(fd, s390_pci_err_handler, NULL, vfio_pci);
> +
> +    return true;
> +}
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index f182bab246..63cf2b7222 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -365,6 +365,7 @@ struct S390PCIBusDevice {
>      bool forwarding_assist;
>      bool aif;
>      bool rtr_avail;
> +    uint32_t ccdf_err_length;
>      QTAILQ_ENTRY(S390PCIBusDevice) link;
>  };
>  
> diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
> index f7d6149daf..c7886b63ea 100644
> --- a/include/hw/s390x/s390-pci-vfio.h
> +++ b/include/hw/s390x/s390-pci-vfio.h
> @@ -20,5 +20,6 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
>  void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
>  bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>  void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
>  
>  #endif


