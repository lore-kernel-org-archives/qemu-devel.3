Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F004C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1o8k-0001nb-Sf; Wed, 02 Sep 2026 12:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x1o8j-0001n7-Cl; Wed, 02 Sep 2026 12:48:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x1o8h-0002XZ-If; Wed, 02 Sep 2026 12:48:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682GXg683600669; Wed, 2 Sep 2026 16:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OULWAG
 7ble3Xb0f8vb3wHXCJUlV0Ldu9AonMjFsNHUM=; b=FIhCsIuvs7LMp6gnqAT+Sp
 knEhoapdLEbvpXJQh+ZnD2rH6oycH+ZYRgeTRnH8iB3bmyGOBEiitcWOpLteFyyV
 PszHm33Nw/R+CI9UmBtnOw9AThUnAH8m/ysDGEDXkxygJraI4Y/FodqLeNEAul9m
 SdrJPFc0Sjv8pA5F5HWo6w06MvqXtcIwRRQwV5bBAW6Af37z/nFT/oD67NHF4aNe
 7bvaQHTZQTYZgGiynFdtuMvplhm+u0TyoPT0lxiakQ6K5/EiFL3pYD431QwzAmfb
 NgwkyB8lbqroOSybCJUtLSpqKvYE17+1i0wwkLQA/9xRVSJU8kZfLTO3MvcHrv4w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudyt9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 16:48:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682GfeiO027441;
 Wed, 2 Sep 2026 16:48:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqk8xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 16:48:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682GlwGO29360830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 16:47:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B3B058054;
 Wed,  2 Sep 2026 16:48:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DB9958052;
 Wed,  2 Sep 2026 16:48:38 +0000 (GMT)
Received: from [9.61.241.1] (unknown [9.61.241.1])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 16:48:38 +0000 (GMT)
Message-ID: <311cd203-f645-4cba-a632-90fdbb717813@linux.ibm.com>
Date: Wed, 2 Sep 2026 09:48:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] s390x/pci: Reset a device in error state
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-5-alifm@linux.ibm.com>
 <7af10759-402d-43de-b590-dab0368d6273@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <7af10759-402d-43de-b590-dab0368d6273@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uI44c4ZRfPjLHtd7Z8tw6zRTSYmDzFsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX+b2Eu1/bGElg
 PbNASWog6XlobEhCPD4hDl+nIZbxu3i37wB6tacJzSTVfbrIMfr/P9OpX5mzdDEUgjP2RXSEqm3
 2vj5jR2K1Cnz5abnFveUpZBFRXk0xKJnpetSJoj77bQq1fRF3Gyg9J9KqNLuI9iB8zJzAjw3TZq
 h5sFua7pkpOubLn2y7N8CupTz9Z9VIutrkSUylI/RYgdpw5xeRrZA+5WwetN6g/9Y3QgU/4K62M
 TULlRIX7Q12K9Sf9Es+lFO5tQmR/nYa9bD6gffDzi6ynKrQmJ7qKjPnE4AQnov72ifKOBNbxmKW
 cbu7CmCww7ftW/QQ/jERx+3pK1ydigRiBTDZ0SAwqX+TftylNofZj+YGmDNrxGtuOI9nDyPOJAo
 3NfVm7huwQ0h9Fhhuufp87RkSielM9NLzZLIcrr/75PCeFZhglbw/byN7hSvcHMQi1uXJxCRXnd
 PfQRBEdpbtJHi+/7Hww==
X-Proofpoint-ORIG-GUID: uI44c4ZRfPjLHtd7Z8tw6zRTSYmDzFsD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX8wt8i2Hp6e6W
 haG55aSngvyqOhuvDPXeU3FqcJakIUbP4VAUD56M4TmYeL5nv6SsfaEhRSYeBm+dzditVL6rNdU
 85V9/COzUTd+UrFpzH5Vy0qccKkxvto=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a985369 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=P-IC7800AAAA:8
 a=VnNF1IyMAAAA:8 a=awqcZlFJCAdavDzQDg8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020146
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


On 9/2/2026 1:27 AM, Cédric Le Goater wrote:
> On 8/31/26 20:31, Farhan Ali wrote:
>> For passthrough devices in error state, for a guest driven reset of the
>> device we can attempt a reset to recover the device. A reset of the 
>> device
>> will trigger a CLP disable/enable cycle on the host to bring the device
>> into a recovered state.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c          |  7 +++++++
>>   hw/s390x/s390-pci-vfio-stubs.c   |  4 ++++
>>   hw/s390x/s390-pci-vfio.c         | 10 ++++++++++
>>   include/hw/s390x/s390-pci-vfio.h |  1 +
>>   4 files changed, 22 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index b2db7f3df4..283b5b62b0 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -1546,6 +1546,8 @@ static void s390_pci_device_reset(DeviceState 
>> *dev)
>>           return;
>>       case ZPCI_FS_STANDBY:
>>           break;
>> +    case ZPCI_FS_ERROR:
>> +        break;
>>       default:
>>           pbdev->fh &= ~FH_MASK_ENABLE;
>>           pbdev->state = ZPCI_FS_DISABLED;
>> @@ -1558,6 +1560,11 @@ static void s390_pci_device_reset(DeviceState 
>> *dev)
>>       } else if (pbdev->summary_ind) {
>>           pci_dereg_irqs(pbdev);
>>       }
>> +
>> +    if (pbdev->state == ZPCI_FS_ERROR) {
>> +        s390_pci_reset(pbdev);
>> +    }
>> +
>>       if (pbdev->iommu->enabled) {
>>           pci_dereg_ioat(pbdev->iommu);
>>       }
>> diff --git a/hw/s390x/s390-pci-vfio-stubs.c 
>> b/hw/s390x/s390-pci-vfio-stubs.c
>> index 9fc84ca135..c68c612038 100644
>> --- a/hw/s390x/s390-pci-vfio-stubs.c
>> +++ b/hw/s390x/s390-pci-vfio-stubs.c
>> @@ -36,3 +36,7 @@ bool s390_pci_setup_err_handler(S390PCIBusDevice 
>> *pbdev, Error **errp)
>>       error_setg(errp, "VFIO not available, cannot setup error 
>> handler");
>>       return false;
>>   }
>> +
>> +void s390_pci_reset(S390PCIBusDevice *pbdev)
>> +{
>> +}
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> index 9a63040e22..64eb28104b 100644
>> --- a/hw/s390x/s390-pci-vfio.c
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -10,6 +10,7 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>     #include <sys/ioctl.h>
>>   #include <linux/vfio.h>
>> @@ -172,6 +173,15 @@ static bool s390_pci_err_handler(VFIOPCIDevice 
>> *vfio_pci, Error **errp)
>>       return success;
>>   }
>>   +void s390_pci_reset(S390PCIBusDevice *pbdev)
>> +{
>> +    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
>> +    if (ioctl(vfio_pci->vbasedev.fd, VFIO_DEVICE_RESET)) {
>> +        error_report("Failed to reset PCI device %s : %s ",
>> +                      vfio_pci->vbasedev.name, strerror(errno));
>> +    }
>
> and pbdev->state remains  ZPCI_FS_ERROR ? I don't see it cleared.
>
> C.

The reset is done as part of CLP disable and on a disable the state is 
set to ZPCI_FS_DISABLED [1]. The device enabled again when the guest 
issues a CLP enabled.

[1] 
https://elixir.bootlin.com/qemu/v11.1.1/source/hw/s390x/s390-pci-inst.c#L271

Thanks

Farhan

>
>> +}
>> +
>>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>>                                  struct vfio_device_info *info)
>>   {
>> diff --git a/include/hw/s390x/s390-pci-vfio.h 
>> b/include/hw/s390x/s390-pci-vfio.h
>> index c7886b63ea..38ccf445ea 100644
>> --- a/include/hw/s390x/s390-pci-vfio.h
>> +++ b/include/hw/s390x/s390-pci-vfio.h
>> @@ -21,5 +21,6 @@ void s390_pci_end_dma_count(S390pciState *s, 
>> S390PCIDMACount *cnt);
>>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
>>   bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error 
>> **errp);
>> +void s390_pci_reset(S390PCIBusDevice *pbdev);
>>     #endif
>

