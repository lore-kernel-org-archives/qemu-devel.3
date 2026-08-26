Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53E5C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzKuh-0004Wv-Nl; Wed, 26 Aug 2026 17:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzKuf-0004Wj-Ga; Wed, 26 Aug 2026 17:12:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzKud-0004XQ-OO; Wed, 26 Aug 2026 17:12:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QL1X6Y3280452; Wed, 26 Aug 2026 21:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Aorf4v
 uUfy0EWXP46xCccTZwriwyAjZQog1VR+Ijaio=; b=HdU5pxvpB1024raUKn9c7I
 1y55cpplFv3JOYwsPez2p//Gg/KoVN9u/NR7yhPtErWyuHevUlp13aOVkJ9X2IFR
 ci0kanSNJ6VR3Y2W+BTBadWOd951iDNhhjCTjY/G3Hgq/tvlJJ70y2SnNRKCQM+m
 +afXjTVSrX4haTFSq0FB0/A2IKgBRSkaFhQwnLtZgx1AmYY6VYNnPdTNJ+lfL1e3
 cWnPCV4T39EvMK0+PJFGXO0GRGQq9Ag4iPL2lEieQJLQnvbRG0wOjW8LmW86CqNt
 20Xitzby0pSeI0MZtMSnhZOfx88nbBmfy0qezLOvWF6GH2v/3PhjfPDvDFnTncXA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er177h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 21:11:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QLBJh6018750;
 Wed, 26 Aug 2026 21:11:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhc5xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 21:11:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QLBtAC35521232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 21:11:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E78135805A;
 Wed, 26 Aug 2026 21:11:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62C725803F;
 Wed, 26 Aug 2026 21:11:54 +0000 (GMT)
Received: from [9.61.145.136] (unknown [9.61.145.136])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 21:11:54 +0000 (GMT)
Message-ID: <4bbbb758-45bb-4b98-b782-966bfdf4e544@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:11:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] pc-bios/s390-ccw: Add support for virtio-scsi-pci
 IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-7-jrossi@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260811144629.866641-7-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nqtT3ECh0QOlQM2w4jTBcv0rgLNK4tlV
X-Proofpoint-ORIG-GUID: nqtT3ECh0QOlQM2w4jTBcv0rgLNK4tlV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfX+HiLSQbn7vUq
 xHGy3sJTVpo/bDigkiNO7Q9Kr7M0TkZbzVeG6GokHbu+hBzkxtbN0GZe8/dnjsiYxuCGcdFNfl1
 tgdAakBHn2717RfvVNHikr4vV9GvuwX/UY7/bm1j4tssklXMWhZX73KLsUDgj/ywsVNFYX1RWns
 44A8oJxq30odiVQ47D5VTS2bh9HxbIndFyweOlGutjKk7V8FAWmfw8oyOV2V6ZQ5/8f4uUgSchf
 sYZdd3zdhgNsO2FisznxJChIohQlgD2q0lx/zcmEX1BJhKnscJ9tVMTvmMcGVp5Uok2Fmj+k6Cy
 gfB423Y0eSpYtICAa772jAXqDnIzHpOclxJqYBHjmXJ43gPlvEAVDO8R6Adr+j280QLUVfvb2AC
 M42RyByUqASYdiEXXoOKWNE6nO+I7shPoFnZ2Yii7G2SlaUYmV8J4OgDw77jve/ANYNtFDvaA6/
 pKTFAS8F/069FfmXf5Q==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f569d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=qqEM7WcOFFFwV34jMNkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfXwUr2+YlnIWb/
 dx+yHdJfR3PyOzuQvA2/I64WkDxLRg/alGCcr62fTztXILUAG1h6633Vq08/mcTORiZnADVtj9+
 CBbieFLWfO0PZyGGbBCMjUgq2Z/L3vk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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



On 8/11/26 10:46 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Read virtio-pci configuration and configure virt-queue for scsi devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c        |  3 ++-
>   pc-bios/s390-ccw/virtio-pci.c  | 30 ++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/virtio-scsi.c | 12 +++++++++++-
>   3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 63692260a4..50f455324e 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -269,6 +269,7 @@ static bool find_boot_device(void)
>           }
>           break;
>        case S390_IPL_TYPE_PCI:
> +        vdev->scsi_device_selected = false;
>           found = find_fid(iplb.pci.fid);
>           break;
>       default:
> @@ -329,13 +330,13 @@ static void ipl_pci_device(void)
>   {
>       VDev *vdev = virtio_get_device();
>       vdev->is_cdrom = false;
> -    vdev->scsi_device_selected = false;
>   
>       if (virtio_pci_setup_device()) {
>           return;
>       }
>   
>       switch (vdev->dev_type) {
> +    case VIRTIO_ID_SCSI:
>       case VIRTIO_ID_BLOCK:
>           if (virtio_setup() == 0) {
>               zipl_load(); /* only return on error */
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index 231ab6e04d..277c3ea68d 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -52,6 +52,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>       case 0x1001:
>           vdev->dev_type = VIRTIO_ID_BLOCK;
>           break;
> +    case 0x1048:
> +    case 0x1004:
> +        vdev->dev_type = VIRTIO_ID_SCSI;
> +        break;
>       default:
>           vdev->dev_type = 0;
>       }
> @@ -199,6 +203,26 @@ static int virtio_pci_get_blk_config(void)
>       return rc;
>   }
>   
> +static int virtio_pci_get_scsi_config(void)
> +{
> +    VirtioScsiConfig *cfg = &virtio_get_device()->config.scsi;
> +    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioScsiConfig));
> +
> +    /* all fields of scsi config must be byte swapped */
> +    cfg->num_queues = bswap32(cfg->num_queues);
> +    cfg->seg_max = bswap32(cfg->seg_max);
> +    cfg->max_sectors = bswap32(cfg->max_sectors);
> +    cfg->cmd_per_lun = bswap32(cfg->cmd_per_lun);
> +    cfg->event_info_size = bswap32(cfg->event_info_size);
> +    cfg->sense_size = bswap32(cfg->sense_size);
> +    cfg->cdb_size = bswap32(cfg->cdb_size);
> +    cfg->max_channel = bswap16(cfg->max_channel);
> +    cfg->max_target = bswap16(cfg->max_target);
> +    cfg->max_lun = bswap32(cfg->max_lun);
> +
> +    return rc;
> +}
> +
>   static int virtio_pci_negotiate(void)
>   {
>       int i, rc;
> @@ -330,6 +354,7 @@ bool virtio_pci_is_supported(VDev *vdev)
>       if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
>           switch (vdev->dev_type) {
>           case VIRTIO_ID_BLOCK:
> +        case VIRTIO_ID_SCSI:
>               return true;
>           default:
>               return false;
> @@ -384,6 +409,11 @@ int virtio_pci_setup(VDev *vdev)
>           vdev->cmd_vr_idx = 0;
>           virtio_pci_get_blk_config();
>           break;
> +    case VIRTIO_ID_SCSI:
> +        vdev->nr_vqs = 3;
> +        vdev->cmd_vr_idx = 2;
> +        virtio_pci_get_scsi_config();
> +        break;
>       default:
>           puts("Unsupported virtio device");
>           return -ENODEV;
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
> index 9ea00c6fe6..095d7ac430 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -16,6 +16,7 @@
>   #include "scsi.h"
>   #include "virtio-scsi.h"
>   #include "virtio-ccw.h"
> +#include "virtio-pci.h"
>   #include "s390-time.h"
>   #include "helper.h"
>   
> @@ -479,7 +480,16 @@ static int virtio_scsi_setup(VDev *vdev)
>   
>   int virtio_scsi_setup_device(VDev *vdev)
>   {
> -    virtio_ccw_setup(vdev);
> +    switch (vdev->ipl_type) {
> +    case S390_IPL_TYPE_CCW:
> +        virtio_ccw_setup(vdev);
> +        break;
> +    case S390_IPL_TYPE_PCI:
> +        virtio_pci_setup(vdev);
> +        break;

Why was/is the return code from virtio_*_setup discarded? Shouldn't we 
do -something- if it's nonzero instead of continuing on?

Besides that, this looks good to me.

> +    default:
> +        return 1;
> +    }
>   
>       if (vdev->config.scsi.sense_size != VIRTIO_SCSI_SENSE_SIZE) {
>           puts("Config: sense size mismatch");


