Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED73EC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1rQn-00024V-Os; Wed, 02 Sep 2026 16:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x1rQl-00024G-UI; Wed, 02 Sep 2026 16:19:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x1rQj-0002YR-Kv; Wed, 02 Sep 2026 16:19:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682I1c2D776343; Wed, 2 Sep 2026 20:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=s+UWLK
 I/C5OyLcA3YgWqGCAKso1c3qjyAv/ls1mgru8=; b=qref36084qbFfodwMjKyOn
 2zPRw14KQKKHvxQK0n/cLVFMdzp9Xe287ESo90shIJC1IAZAwrV2297BP4FEal7K
 PNMYMyGXrwRT0B19lOZ+wW3k+uQF12SMba49xxDAUH9xP0h48b1t/w4cnfnefREE
 q7stVQZeQjPVpjCI0ff67e8KMJYC8VbJ91E+tz1xSe8RlYJT3xZoDcme4A+ZZSE3
 3RKl0hGJrobXm8tfAFdmL6vqbn1HnnjNyoY/r0cHdy6VQ/PY+6Hf4gj24UEWRpM8
 Zzwhue2KvL2xLX/Z8uB1kn6nIH/pX4NtSPvisY2molGv19psa0TlTJv+OCXVuF0Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tgrew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 20:19:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682KBGsZ023316;
 Wed, 2 Sep 2026 20:19:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqmbyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 20:19:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682KJTnS20841100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 20:19:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8864858055;
 Wed,  2 Sep 2026 20:19:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB0895804B;
 Wed,  2 Sep 2026 20:19:28 +0000 (GMT)
Received: from [9.61.24.241] (unknown [9.61.24.241])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 20:19:28 +0000 (GMT)
Message-ID: <f7bc61d3-ef37-4b2d-808f-944623bc8e66@linux.ibm.com>
Date: Wed, 2 Sep 2026 16:19:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] s390x: Find scsi-pci boot device and build IPLB
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: jjherne@linux.ibm.com, zycai@linux.ibm.com
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-8-jrossi@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260831194919.3830270-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9884d3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=XZqmmwc2_RSGVIpnDLcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3NyBTYWx0ZWRfX1cOIWeNYBm0p
 TutmsgLsNVq0lEICZgHU1TRuUrCL50DHRuO45qOLyxDhiUvaMI5TPOhsN2tEqH2HAXzvs+esgZY
 40juK2VWOyIg4gcyp6euPiDVTebNH/o=
X-Proofpoint-ORIG-GUID: nFiSCVFwZoF7Lvmhc29YxC0qwbHSLOcZ
X-Proofpoint-GUID: nFiSCVFwZoF7Lvmhc29YxC0qwbHSLOcZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3NyBTYWx0ZWRfX9cufsk1tZQDE
 aGidnPC56E2Cfq9XXMq/zx/86bVUUD+B/gB21wdsAd9MgnjmZqrdUR0yPAsW+ZwvD9EQ0viRbms
 CvTHQFp3dJTyPSXrnhr40Q3Fgv5rWASqUCIQEi2YDqFfSrfyZW3XvHP3U+eJyHpaEfY30J+4UoU
 25Svk7S4nwJbkTc4RY52yXywPtJnIGkmXqkAn7zeBNs1nRpxlHDG6f5N/WOZtZvyx0DAi3o/D7w
 ux6w2PPBgeGMRxegf6XIy5csihOa8PeUzFTfXbGL98zdSOYNkwmV50KU/1fSa9JeawrnWAwrl6P
 LkIDfgcHppNulUhi2ozdrne0k5obI5CevIZU4kiLLl7Vr3+Alcri1h/q63+Fh6q5/4ZojXBtUb1
 f2i+5gIghXc/IWgCscuhZistM8KGndNj68HTa0R9FS6XIQHU4wzpZTHSlfYNY7iaU7ciZrR0i5H
 XEnQN7Xz6xdA2VLLr3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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



On 8/31/26 3:49 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add logic to identify a virtio-pci scsi controller and target lun with
> assigned bootindex, then build IPLB for it.
> 
> Unfence PCI case for scsi devices in BIOS.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.c          | 37 +++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/main.c |  3 +++
>   2 files changed, 40 insertions(+)

Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>

> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 6969e11b27..0cab043b12 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -402,6 +402,7 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>   }
>   
>   #define PCI_DEVTYPE_VIRTIO       0x05
> +#define PCI_DEVTYPE_SCSI         0x06
>   
>   static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
>   {
> @@ -417,6 +418,26 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
>               if (pbdev) {
>                   tmp_dt = PCI_DEVTYPE_VIRTIO;
>               }
> +        } else {
> +            SCSIDevice *sd = (SCSIDevice *)
> +                object_dynamic_cast(OBJECT(dev_st), TYPE_SCSI_DEVICE);
> +            if (sd) {
> +                SCSIBus *sbus = scsi_bus_from_device(sd);
> +                VirtIODevice *vdev = (VirtIODevice *)
> +                    object_dynamic_cast(OBJECT(sbus->qbus.parent),
> +                                                TYPE_VIRTIO_DEVICE);
> +                if (vdev) {
> +                    pci_dev = (PCIDevice *)
> +                        object_dynamic_cast(OBJECT(qdev_get_parent_bus(DEVICE(vdev))->parent),
> +                                            TYPE_PCI_DEVICE);
> +                    if (pci_dev) {
> +                        pbdev = s390_pci_find_dev_by_pci(s390_get_phb(), pci_dev);
> +                        if (pbdev) {
> +                            tmp_dt = PCI_DEVTYPE_SCSI;
> +                        }
> +                    }
> +                }
> +            }
>           }
>       }
>       if (devtype) {
> @@ -621,6 +642,22 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               iplb->pbt = S390_IPL_TYPE_PCI;
>               iplb->pci.fid = cpu_to_be32(pbdev->fid);
>               break;
> +        case PCI_DEVTYPE_SCSI:
> +            sd = SCSI_DEVICE(dev_st);
> +            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
> +            if (scsi_lp && strlen(scsi_lp) > 0) {
> +                lp = scsi_lp;
> +            }
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
> +            iplb->blk0_len =
> +                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
> +            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
> +            iplb->scsi.lun = cpu_to_be32(sd->lun);
> +            iplb->scsi.target = cpu_to_be16(sd->id);
> +            iplb->scsi.channel = cpu_to_be16(sd->channel);
> +            iplb->scsi.bus = S390_IPL_TYPE_PCI;
> +            iplb->scsi.fid = cpu_to_be32(pbdev->fid);
> +            break;
>           default:
>               return false;
>           }
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a2a24b024f..d2a2ac3138 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -267,6 +267,9 @@ static bool find_boot_device(void)
>               blk_schid.ssid = iplb->scsi.ssid & 0x3;
>               found = find_subch(iplb->scsi.devno);
>               break;
> +        case S390_IPL_TYPE_PCI:
> +            found = find_fid(iplb->scsi.fid);
> +            break;
>           default:
>               puts("Unrecognized SCSI controller");
>               break;


