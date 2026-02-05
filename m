Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B97AECD9B0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 23:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo90O-0001VW-9g; Thu, 05 Feb 2026 18:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vo90M-0001Th-Bb; Thu, 05 Feb 2026 18:43:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vo90J-0007JE-SE; Thu, 05 Feb 2026 18:43:21 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615LdJYD027311;
 Thu, 5 Feb 2026 23:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zzxVth
 kXdZgQxIlCSit76vT459lsqPsYWzlyOq6QWlY=; b=C0Em0jTIVOFIgqfYzgHHr4
 f1v1y2iUzser0tBQlgiAlkUui0eJKvuI8NOP6uMGfEqz7GdjtrPXe3OEYjb7j6YV
 bgvo3tXlSWCSVFe1gJCIc7+LM8f6zad9/hP5EMzXW5ntm0yJTjS3Cu5STS6TbPw4
 PwYXvWHyaEE0Uu3UA5c+T1ry2D8BE7dVyRzwh3XxWu5RjB61piR7GDVHKHHdk+vl
 zcv7k4e4/jiOM02UFdkOG7gr7k303iW4wMxriJKM33Uju+ytuhJcYvE2l19uL46w
 jJoo+B1Zi9oCYNo+Z57ykpiB0hFnVD832CGybHWGgpEHnj+slwZK1jNvpdic3PIQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986s9e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 23:43:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615JFKUx015734;
 Thu, 5 Feb 2026 23:43:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c4gsgv8eg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 23:43:15 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 615NhDLF61800954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Feb 2026 23:43:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3C0558050;
 Thu,  5 Feb 2026 23:43:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA6F358045;
 Thu,  5 Feb 2026 23:43:12 +0000 (GMT)
Received: from [9.61.250.67] (unknown [9.61.250.67])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Feb 2026 23:43:12 +0000 (GMT)
Message-ID: <62317e7b-c992-46cf-9df8-faad2fcc4b9c@linux.ibm.com>
Date: Thu, 5 Feb 2026 15:43:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] pc-bios/s390-ccw: Add support for virtio-blk-pci
 IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-12-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260127161547.459443-12-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE3OSBTYWx0ZWRfX6/JRzpUZKESg
 scHeRWl8zkdfLt8AwLyGKLbWLzlrufl9woysCuiJM3tsaaEVwEVUGV86Pv1as2AGZH0iUGfFIvl
 Og+e1Kx8Dw3qJyWmtKwI0atkUr13V2W6BkAwhGrnYmzO3PxAuIibByLDpEF3YFV0GdXd8KziA8U
 3hRBaNXf1jEOBvcefjGOHjqB4qyoKkUP34Oe0oyzdVWt0I/z6XZUw/RfpedqpQTfYMvg5Y70DhN
 cIPxGMwwGHBwZdvj666BfODAMgzbdJjCM7rimN5QDRznigdFUf4zyhwI0PDtwsSf3/cJmUHclan
 ZD2PnnCD8EuAZYtbbXGtc/ow64iBZVn8ZOx2K1t9qqNXMjUb+l5TixPpQXbD7W0MDxWC4+CImW4
 wXTzuhnj2tNm0f+JD1C9qZfd6GP5ot9dJi0BSWxgUiCUJPAPEIR2JxNPm/swbL4kY2GSBWTgq/e
 yjdmGk44kiPjYRTuCkQ==
X-Proofpoint-GUID: BPI5U0Q6IQCZwBu9_5W9DTgezvdd1g_r
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=69852b14 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t_0_BxdfAAAA:20
 a=VnNF1IyMAAAA:8 a=TqYFoeTA7eKLJz2AZNEA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: BPI5U0Q6IQCZwBu9_5W9DTgezvdd1g_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_06,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050179
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

<...snip...>

On 1/27/2026 8:15 AM, jrossi@linux.ibm.com wrote:
> int virtio_pci_setup(VDev *vdev)
> +{
> +    VRing *vr;
> +    int rc;
> +    uint8_t status;
> +    int i = 0;
> +
> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
> +    vdev->cmd_vr_idx = 0;
> +
> +    if (virtio_reset(vdev)) {
> +        return -EIO;
> +    }
> +
> +    status = VPCI_S_ACKNOWLEDGE;
> +    if (virtio_pci_set_status(status)) {
> +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
> +        return -EIO;
> +    }
> +
> +    rc = virtio_pci_read_pci_cap_config();
> +    if (rc) {
> +        puts("Invalid virtio PCI capabilities");
> +        return -EIO;
> +    }
> +
> +    vdev->guest_features[1] = VIRTIO_F_VERSION_1;
> +    if (virtio_pci_negotiate()) {
> +        panic("Virtio feature negotation failed!");
> +    }
> +
> +    switch (vdev->dev_type) {
> +    case VIRTIO_ID_BLOCK:
> +        vdev->nr_vqs = 1;
> +        vdev->cmd_vr_idx = 0;
> +        vdev->config.blk.blk_size = 0;
> +        virtio_pci_get_blk_config();
> +        break;
> +    default:
> +        puts("Unsupported virtio device");
> +        return -ENODEV;
> +    }
> +
> +    status |= VPCI_S_DRIVER;
> +    rc = virtio_pci_set_status(status);
> +    if (rc) {
> +        puts("Set status failed");
> +        return -EIO;
> +    }
> +
> +    /* Configure virt-queues for pci */
> +    for (i = 0; i < vdev->nr_vqs; i++) {
> +        VqInfo info = {
> +            .queue = (unsigned long long) virtio_get_ring_area(i),
> +            .align = KVM_S390_VIRTIO_RING_ALIGN,
> +            .index = i,
> +            .num = 0,
> +        };
> +
> +        vr = &vdev->vrings[i];
> +
> +        if (vpci_read_flex(VPCI_C_COMMON_NUMQ, c_cap.bar, &info.num, 2)) {
> +            return -EIO;
> +        }
> +
> +        vring_init(vr, &info);
> +
> +        if (vpci_set_selected_vq(vr->id)) {
> +            puts("Failed to set selected virt-queue");
> +            return -EIO;
> +        }
> +
> +        if (vpci_set_queue_size(VIRTIO_RING_SIZE)) {
> +            puts("Failed to set virt-queue size");
> +            return -EIO;
> +        }
> +
> +        rc = set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
> +        rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
> +        rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
> +        if (rc) {
> +            puts("Failed to configure virt-queue address");
> +            return -EIO;
> +        }
> +
> +        if (vpci_set_queue_enable(true)) {
> +            puts("Failed to set virt-queue enabled");
> +            return -EIO;
> +        }
> +    }
> +
> +    status |= VPCI_S_FEATURES_OK | VPCI_S_DRIVER_OK;
> +    return virtio_pci_set_status(status);

Should we also enable Bus master bit as part of the device setup? QEMU 
though has a workaround where if we have setup the ACKNOWLEDGE and 
DRIVER status flags set then it would enable the Bus master by default 
since older Linux virtio-pci drivers didn't do it 
(https://github.com/qemu/qemu/blob/cd5a79dc98e3087e7658e643bdbbb0baec77ac8a/hw/virtio/virtio-pci.c#L480-L487). 
But latest virtio-pci drivers seems to be doing the right thing, so not 
sure how long this workaround would be supported :) .


> +}
> +

<..snip..>


> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
> index 96c17ac3c7..883b00e0c6 100644
> --- a/pc-bios/s390-ccw/virtio-pci.h
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -71,6 +71,8 @@ typedef struct VirtioPciCap  VirtioPciCap;
>   void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
>   int virtio_pci_reset(VDev *vdev);
>   long virtio_pci_notify(int vq_id);
> +int virtio_pci_setup(VDev *vdev);
> +int virtio_pci_setup_device(void);
>   
>   int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
>   int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 956b34ff33..f65571a920 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -17,6 +17,7 @@
>   #include "virtio.h"
>   #include "virtio-scsi.h"
>   #include "virtio-ccw.h"
> +#include "virtio-pci.h"
>   #include "bswap.h"
>   #include "helper.h"
>   #include "s390-time.h"
> @@ -112,6 +113,8 @@ bool vring_notify(VRing *vr)
>       case S390_IPL_TYPE_CCW:
>           vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
>           break;
> +    case S390_IPL_TYPE_PCI:
> +        vr->cookie = virtio_pci_notify(vr->id);
>       default:
>           return 1;
>       }
> @@ -119,8 +122,43 @@ bool vring_notify(VRing *vr)
>       return vr->cookie >= 0;
>   }
>   
> +/*
> + * Get endienness of the IPL type
> + * Return true for s390x native big-endian
> + */
> +bool be_ipl(void)
> +{
> +    switch (virtio_get_device()->ipl_type) {
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        return true;
> +    case S390_IPL_TYPE_PCI:
> +        return false;
> +    default:
> +        return true;
> +    }
> +}
> +
> +/*
> + * Format the virtio ring descriptor endianness
> + * Return the available index increment in the appropriate endianness
> + */
> +static uint16_t vr_fmt_descriptor(VRingDesc *desc)
> +{
> +    if (!be_ipl()) {
> +        desc->addr = bswap64(desc->addr);
> +        desc->len = bswap32(desc->len);
> +        desc->flags = bswap16(desc->flags);
> +        desc->next = bswap16(desc->next);
> +    }
> +
> +    return be_ipl() ? 1 : bswap16(1);
> +}
> +
>   void vring_send_buf(VRing *vr, void *p, int len, int flags)
>   {
> +    uint16_t increment;
> +
>       /* For follow-up chains we need to keep the first entry point */
>       if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
>           vr->avail->ring[vr->avail->idx % vr->num] = vr->next_idx;
> @@ -131,11 +169,13 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
>       vr->desc[vr->next_idx].flags = flags & ~VRING_HIDDEN_IS_CHAIN;
>       vr->desc[vr->next_idx].next = vr->next_idx;
>       vr->desc[vr->next_idx].next++;
> +
> +    increment = vr_fmt_descriptor(&vr->desc[vr->next_idx]);

If we are only returning 1 from the function vr_fmt_descriptor(), why 
not just set increment=1 or remove it completely and keep 
vr->avail->idx++? That way we don't need to do any endian conversion?

Thanks

Farhan


>       vr->next_idx++;
>   
>       /* Chains only have a single ID */
>       if (!(flags & VRING_DESC_F_NEXT)) {
> -        vr->avail->idx++;
> +        vr->avail->idx += increment;
>       }
>   }

