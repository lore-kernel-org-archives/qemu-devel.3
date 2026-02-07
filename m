Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74A9EE6B76
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 08:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vodz1-0003Ff-7v; Sat, 07 Feb 2026 03:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vodyz-0003F1-DE; Sat, 07 Feb 2026 03:48:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vodyx-0001is-Er; Sat, 07 Feb 2026 03:48:01 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6177bnQd108228; Sat, 7 Feb 2026 08:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0d8GJx
 3H5rOI7VWxEdQOBXipROH/L5ywPyJBjIskLGE=; b=TkNUg7rM7+MLKqvKA7/Ji7
 B/A+uhf22wilVPwHBYUkPPRHKjNQkDhjK6rprWR49CGbtAOT126df+iYJ+pIl9qu
 MYdHWQY2wHVSusFzLQGWny92MSjyjgA6u8bJrG6JDWOqKrqW1ws/7kl6mRgT5Rry
 SNPTTCKCShxBIT1fw4H/Y8yddmjPlpj62hPXzrDpyU+e82qeaMumsi7bEveA6n4e
 iA3Z9KR7e1lrWRnZruQxpRwyvm4E+s84HsHsk+KYbEkXx5StMf65XHEu7geQTu9G
 YUfq2FpHH6WOx7FqusSNAwk8ii4H0OhAEeR96z3j7w9kLtmpnZo2MMC7dhxL8Dxg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c614ng3dv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Feb 2026 08:47:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6177KRiC029082;
 Sat, 7 Feb 2026 08:47:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2ssme2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Feb 2026 08:47:41 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6178lfL144761428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Feb 2026 08:47:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AD1B5803F;
 Sat,  7 Feb 2026 08:47:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA16858054;
 Sat,  7 Feb 2026 08:47:37 +0000 (GMT)
Received: from [9.61.244.143] (unknown [9.61.244.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  7 Feb 2026 08:47:37 +0000 (GMT)
Message-ID: <2bad6bc7-b073-48b4-9d6b-dbc1ae9e1ee9@linux.vnet.ibm.com>
Date: Sat, 7 Feb 2026 14:17:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hw/nvme: Add properties for PCI vendor/device IDs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 nikhilks@linux.ibm.com, stefanha@redhat.com, fam@euphon.net
References: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
 <20251127120322.2997269-2-saif.abrar@linux.vnet.ibm.com>
 <e33572fb-0963-41c8-b7d4-34e22b115a8e@linaro.org>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <e33572fb-0963-41c8-b7d4-34e22b115a8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MbNhep/f c=1 sm=1 tr=0 ts=6986fc2f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=hD80L64hAAAA:8 a=VnNF1IyMAAAA:8 a=tnRFAgtPAQ5wnVArNfQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Kggd-hTU1jyv3E9nMf909nrY9Ay02NTE
X-Proofpoint-ORIG-GUID: G3j0wPtZOVsm3wAj1OrezMJnINNIQbKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDA2OCBTYWx0ZWRfX+fV0arEsmZCg
 P5ChG/ntsN7X9gKH9BA9VIy8mVweukEGmlm8dlnAJCaXGuDDhjqgg0q+Dq5vvBlSEdzON59DlDo
 GwLXjOKdtEupaBn1Amduo0y/YnI8nfPXeJSVX96YHA0qAPh0HE3nLmNcAQ3KGtcNQhbkIWfoVdn
 Osh/zX1mwHl8IS9mUvhLrGKgvs6ArGht9nRx2AH/0sxA50L8eA1yqITqLeObf2ACiohO5U6xoPG
 KImt+DVfai/u+WgkSV5D0f3dmJNnMXQQES4oq1YAYSP1lZWjtLs5Qe+0+8OrSoudjirRjh0UOq6
 2y2wXsIlHUkiUFT1mSVuAX/Ip+pjzpLyUfYPCHaQc4vKJ7YRmDxe9PXV8muEO9TGxR9naagD/r/
 soi1ngjLuYRaIuW4TNEzy5lZYhU1a8AWC9OpsmZNCxoXJ6jEuLOpN4QlMLzliXuK8yQRUr/yVSZ
 iRkyUVOLtccOxdDeDIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602070068
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hello Philippe,

Changes suggested in my commits are now picked up by Jesper Devantier 
<foss@defmacro.it>

in the patch

https://lore.kernel.org/qemu-devel/20260106-q-saif-pci-oui-props-v1-1-c8a1a4ec0dfc@samsung.com/


Regards,

Saif


On 25-01-2026 11:46 pm, Philippe Mathieu-Daudé wrote:
> Hi Saif,
>
> On 27/11/25 13:02, Saif Abrar wrote:
>> Add properties for user specified PCI vendor, device, subsystem vendor
>> and subsystem IDs.
>>
>> e.g. PCI IDs to be specified as follows:
>> -device 
>> nvme,id_vendor=0xABCD,id_device=0xA0B0,id_subsys_vendor=0xEF00,id_subsys=0xEF01
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> ---
>> v3 -> v4: Resolve merge commits when moving to the latest repo.
>>
>>   hw/nvme/ctrl.c | 28 +++++++++++++++++++++++++---
>>   hw/nvme/nvme.h |  5 +++++
>>   2 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>> index cc4593cd42..d857be5496 100644
>> --- a/hw/nvme/ctrl.c
>> +++ b/hw/nvme/ctrl.c
>> @@ -8877,7 +8877,10 @@ static bool nvme_init_sriov(NvmeCtrl *n, 
>> PCIDevice *pci_dev, uint16_t offset,
>>                               Error **errp)
>>   {
>>       uint16_t vf_dev_id = n->params.use_intel_id ?
>> -                         PCI_DEVICE_ID_INTEL_NVME : 
>> PCI_DEVICE_ID_REDHAT_NVME;
>> +                         PCI_DEVICE_ID_INTEL_NVME :
>> +                         (n->params.id_device ?
>> +                         n->params.id_device : 
>> PCI_DEVICE_ID_REDHAT_NVME);
>> +
>>       NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
>>       uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
>> le16_to_cpu(cap->vifrsm),
>> @@ -8953,8 +8956,22 @@ static bool nvme_init_pci(NvmeCtrl *n, 
>> PCIDevice *pci_dev, Error **errp)
>>           pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
>>           pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_INTEL_NVME);
>>       } else {
>> -        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
>> -        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
>> +        uint16_t id_vendor = n->params.id_vendor ?
>> +                             n->params.id_vendor : 
>> PCI_VENDOR_ID_REDHAT;
>> +        pci_config_set_vendor_id(pci_conf, id_vendor);
>> +
>> +        uint16_t id_device = n->params.id_device ?
>> +                             n->params.id_device : 
>> PCI_DEVICE_ID_REDHAT_NVME;
>> +        pci_config_set_device_id(pci_conf, id_device);
>> +
>> +        if (n->params.id_subsys_vendor) {
>
> Just set it directly?
>
>> +            pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID,
>> + n->params.id_subsys_vendor);
>> +        }
>> +
>> +        if (n->params.id_subsys) {
>
> Just set it directly?
>
>> +            pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, 
>> n->params.id_subsys);
>> +        }
>>       }
>>         pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
>> @@ -9409,6 +9426,11 @@ static const Property nvme_props[] = {
>>       DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 
>> 0),
>>       DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, 
>> params.atomic_awupf, 0),
>>       DEFINE_PROP_BOOL("ocp", NvmeCtrl, params.ocp, false),
>> +    DEFINE_PROP_UINT16("id_vendor", NvmeCtrl, params.id_vendor, 0),
>> +    DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device, 0),
>> +    DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
>> + params.id_subsys_vendor, 0),
>> +    DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),
>
> Just curious (I missed the previous version), why not use the default
> value here instead of 0? For example:
>
>   DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device,
>                      PCI_DEVICE_ID_REDHAT_NVME),
>
>>   };
>>     static void nvme_get_smart_warning(Object *obj, Visitor *v, const 
>> char *name,
>> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
>> index 8f8c78c850..65fb168bc9 100644
>> --- a/hw/nvme/nvme.h
>> +++ b/hw/nvme/nvme.h
>> @@ -571,6 +571,11 @@ typedef struct NvmeParams {
>>       uint16_t atomic_awun;
>>       uint16_t atomic_awupf;
>>       bool     atomic_dn;
>> +
>> +    uint16_t id_vendor;
>> +    uint16_t id_device;
>> +    uint16_t id_subsys_vendor;
>> +    uint16_t id_subsys;
>>   } NvmeParams;
>>     typedef struct NvmeCtrl {
>

