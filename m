Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4778AC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x92mO-0001Jt-LI; Tue, 22 Sep 2026 11:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x92mM-0001Is-JT; Tue, 22 Sep 2026 11:51:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x92mK-0004zO-ND; Tue, 22 Sep 2026 11:51:34 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5inr752724; Tue, 22 Sep 2026 15:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wIxAe8
 5DlwPIb6wxKlZq/4du46PW6fHrwatoyutBPJQ=; b=mqGn6DgUiSXQm3IPzf1nOh
 z8z6mkJBW8vx8TTvxOKcp3j7lFCMRd8ASO5J2rJ8G/h8ytJID4WjcsZdQy5oa/wF
 AT2o3QML78NA4AvfY+quUJrN6lcZMmZlOY+Uo2xubM3ssByyq+FbJMACQbHPIijw
 cteZLqWsTYyMzQT7pPoH2P+K34/k5O+ZAw3HjXTo52L4OicAugQUO5W/EYC3N0Ni
 /7b75xze5ehEX5DP5B1TtRXijgkixKmxvjeJaXLRYBJQoazaH6yUcYWnvGjgR/Gb
 GndWulwr5FwFzg3tZEZb6/BxReUjsG9fBAifRgVbiD6z5HY+7JTElFQYVbC00yzQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs6pw4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 15:51:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MElgeh2988073; Tue, 22 Sep 2026 15:51:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vjjf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 15:51:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MFpQix21561856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 15:51:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 749BA58059;
 Tue, 22 Sep 2026 15:51:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48AEF58058;
 Tue, 22 Sep 2026 15:51:25 +0000 (GMT)
Received: from [9.12.79.241] (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 15:51:25 +0000 (GMT)
Message-ID: <1b240379-9a84-4445-8cef-ee90c0518ba7@linux.ibm.com>
Date: Tue, 22 Sep 2026 11:51:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-5-zycai@linux.ibm.com>
 <775ca6a7-18b3-437e-992d-cc366daa84d9@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <775ca6a7-18b3-437e-992d-cc366daa84d9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2a401 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=ctsVLiZ_AAAA:8 a=OJOUDSZ1EHGthsF5biMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-ORIG-GUID: SpIKwdvpqsapSVCoTvcqvEEejKbPgzi1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIyNyBTYWx0ZWRfX0I4uZh0AS1m1
 FSAptFlrfep0WPmbtdKjvq4BqglPxW2tibkmfgEkIch7H7nKM44P28JRhwpeAOyoHpD6dbWOE94
 efnlLCZzCMub9ny5hF+z4VZaS4tu4Tx2mjmCvby78ejzEfSxV1BbEDsqbXPwdvqW8QU+FzjI+Ah
 hOJIaepQ1wZ29udxFM/wX+sRgNVJb5NRyLDQV2LcJuiZUZtXnlnLxIeaqlnOnv2HEnDbIj59tem
 +s1Uhesv0n/EPRkMMeoF6NJEblbJCe+ZGdCQ7NzvsxXTtwifGSVPZ9dPoFIFzfiNM/sVtffk8SD
 2HJUh+SZAB5vOOvPPFG/9KizXtC/KnboeY1Lq+qtHFQS5wlyral2f62/KNT87fDwFAJcH90iZtC
 kSqB58ZACPZSJBTo9k/J71ukvNywxjFymjE36luRHZrlxDzqIKhb7z2p1qvXvkFKqteZJ3ciTiF
 afni74agO+WHnR68+gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIyNyBTYWx0ZWRfX/YsBEyCSp3FS
 rTcsl7Av0mjOmec1H77wBoJSCeUaR8l+SXs84eo/pLiYK5xpBz7snmMHBunXLK4o2dru6lha/en
 I30z/W8kgNRrwQXlxPak0WYgJChYXPY=
X-Proofpoint-GUID: SpIKwdvpqsapSVCoTvcqvEEejKbPgzi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220227
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

On 9/22/26 11:35 AM, Joshua Daley wrote:
> FYI, now that Jared's virtio-scsi-pci boot series is merged, this patch does not apply.
>

Thanks for the heads-up! I’ll update the patch accordingly in the next
version.

> On 9/14/2026 3:34 PM, Zhuoying Cai wrote:
>> Enable network booting via virtio-net-pci by implementing PCI transport
>> support for virtio-net.
>>
>> This patch also extends endianness handling for virtio PCI ring operations in
>> little-endian to ensure correct behavior on s390x.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/main.c       |  1 +
>>   pc-bios/s390-ccw/netmain.c    |  9 +++++++-
>>   pc-bios/s390-ccw/virtio-net.c | 41 ++++++++++++++++++++++++++++-------
>>   pc-bios/s390-ccw/virtio-pci.c | 20 +++++++++++++++++
>>   4 files changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 8fc1cbf653..28cab3b411 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -332,6 +332,7 @@ static void ipl_pci_device(void)
>>       }
>>   
>>       switch (vdev->dev_type) {
>> +    case VIRTIO_ID_NET:
>>       case VIRTIO_ID_BLOCK:
>>           if (virtio_setup() == 0) {
>>               zipl_load(); /* only return on error */
> case VIRTIO_ID_SCSI has been added here
> 
> ..snip...
> 
>> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
>> index f501252c81..fd794bad8f 100644
>> --- a/pc-bios/s390-ccw/virtio-pci.c
>> +++ b/pc-bios/s390-ccw/virtio-pci.c
>> @@ -52,6 +52,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>>       case 0x1001:
>>           vdev->dev_type = VIRTIO_ID_BLOCK;
>>           break;
>> +    case 0x1041:
>> +    case 0x1000:
>> +        vdev->dev_type = VIRTIO_ID_NET;
>> +        break;
>>       default:
>>           vdev->dev_type = 0;
>>       }
> some new cases were added here also
> 
>> @@ -199,6 +203,17 @@ static int virtio_pci_get_blk_config(void)
>>       return rc;
>>   }
>>   
>> +static int virtio_pci_get_net_config(void)
>> +{
>> +    VirtioNetConfig *cfg = &virtio_get_device()->config.net;
>> +
>> +    /*
>> +     * Byte-swapping is not needed as only the MAC address (byte array)
>> +     * is used here. Byte-swap if other fields are added.
>> +     */
>> +    return vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioNetConfig));
>> +}
>> +
>>   static int virtio_pci_negotiate(void)
>>   {
>>       int i, rc;
>> @@ -330,6 +345,7 @@ bool virtio_pci_is_supported(VDev *vdev)
>>       if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
>>           switch (vdev->dev_type) {
>>           case VIRTIO_ID_BLOCK:
>> +        case VIRTIO_ID_NET:
>>               return true;
>>           default:
>>               return false;
> here also
> 
>> @@ -384,6 +400,10 @@ int virtio_pci_setup(VDev *vdev)
>>           vdev->cmd_vr_idx = 0;
>>           virtio_pci_get_blk_config();
>>           break;
>> +    case VIRTIO_ID_NET:
>> +        vdev->nr_vqs = 2;
>> +        virtio_pci_get_net_config();
>> +        break;
>>       default:
>>           puts("Unsupported virtio device");
>>           return -ENODEV;
> here also


