Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE4CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgrk-0007hO-7r; Wed, 06 May 2026 14:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKgrd-0007bc-A6; Wed, 06 May 2026 14:20:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKgra-0007MS-Qi; Wed, 06 May 2026 14:20:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646B4pXe2210426; Wed, 6 May 2026 18:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9ZYUF4
 RVBCvEAO5FC4oupHp8SeGGy68yg/B2vlnmH0o=; b=Tl43lO2h5l/uBZjw4H244t
 5kopGUskLJTq9GdE8WWmT7LjuQVy+uMrWoUWv+LlZNoxG+eJHXHO8VsfqHDutcLC
 2ZhRDl9XN2RqT5ePX1KAEYxkPaAyMcWpWpdSrf4OeRI/MdzZT7gsZBRQAprrL9RG
 xJQq80w1fE/jLHNyHppCO/jNEvJMB7flUdv4KDDVnvUU8v4c6bYGeBQ95mnleWJr
 Sdw9ovo5eQvcy8U/1ituprH+Nccy1E4HAIlTNw6rLGX14ulwGu2201cxThtfFyH0
 lbh/y/rf9N1aQ8iSfQv6va7uWbsJLdAFg0bKF9diQaxxLZrmI+N61Fw49tDHpttw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1j6rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 18:20:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646I9WCY025534;
 Wed, 6 May 2026 18:20:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h7dy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 18:20:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646IKkdn6095784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 18:20:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF28058043;
 Wed,  6 May 2026 18:20:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6643B58059;
 Wed,  6 May 2026 18:20:45 +0000 (GMT)
Received: from [9.61.184.19] (unknown [9.61.184.19])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 18:20:45 +0000 (GMT)
Message-ID: <fe2f10ad-f935-4465-81e2-f469846a0828@linux.ibm.com>
Date: Wed, 6 May 2026 14:20:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pc-bios/s390-ccw: Add per-queue notification offset
 for multi-queue virtio configurations
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
 <20260504221613.826825-3-jrossi@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20260504221613.826825-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QhXUyAR3aNkdVQaEULtEALnc5Vl5lS64
X-Proofpoint-GUID: QhXUyAR3aNkdVQaEULtEALnc5Vl5lS64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3NyBTYWx0ZWRfX4Yc4f7btbEBX
 G42rfaec++4aHj8rhd2esNMRACZIJovvGCU3QDZsTBU15DiW41kLchilRYXtzcfTiM5xhstynX+
 E+8lzy5aU/GkEvks7qB7UxW9MjNQ7P1am8IGPwY/P/I8dEU/4HyAovTtb1gu/ATvn4slpA10VD+
 Q/eT0tCybQ3wbU7IVxvH+SPhfJkypKgU4aFo6SFzfmXlFDgsbmNQafYX1H7RLplLqyWnSkSbpnE
 qQqgcdqHG+hk0h84veVqpFoyyG1pla1FDMMFHqTIVNrzBAfSqC8wfSFsnQ0jjdSh2xzw6QxSKcU
 gjlo82rJgjVhkSVGfiMmPqMB61NA0yQSw67i9lDaZjU4fq9dJp/39EtzmCM21D6LBPSQAODlCYw
 zZywr4O5tsEq2tge0ZQT+xCAR1nNb+mmEAt0y8QsRYgVNG1zXK1ypFZDLG76WP8eh1H3eTrwVpR
 04ZstyZ66QG6ej9ZF8g==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb8680 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=lWE6Ke99UggxnlHRUC0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060177
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

On 5/4/26 6:16 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The initial support for virtio-blk-pci IPL devices used a single virt-queue, but
> other device types require multiple queues, and for PCI device types this also
> requires a per-queue notification offset.
> 
> Add a PCI notify field to the VRing struct so that each queue has a unique
> notify offset.  Also re-select the target queue before writing buffers to
> ensure the proper queue is active.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio-pci.c | 36 ++++++++++++++++++++++-------------
>  pc-bios/s390-ccw/virtio-pci.h |  3 ++-
>  pc-bios/s390-ccw/virtio.c     |  4 +++-
>  pc-bios/s390-ccw/virtio.h     |  1 +
>  4 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index 53bdb52e76..736869f4f5 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -74,10 +74,10 @@ int virtio_pci_reset(VDev *vdev)
>      return 0;
>  }
>  
> -long virtio_pci_notify(int vq_id)
> +long virtio_pci_notify(VRing *vr)
>  {
> -    uint32_t offset = n_cap.off + notify_mult * q_notify_offset;
> -    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vq_id);
> +    uint32_t offset = n_cap.off + notify_mult * vr->pci_notify;
> +    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vr->id);
>  }
>  
>  /*
> @@ -166,7 +166,7 @@ int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len)
>      return 0;
>  }
>  
> -static int vpci_set_selected_vq(uint16_t queue_num)
> +int vpci_set_selected_vq(uint16_t queue_num)
>  {
>      return vpci_bswap16_write(c_cap.off + VPCI_C_OFFSET_Q_SELECT, c_cap.bar, queue_num);
>  }
> @@ -332,7 +332,6 @@ int virtio_pci_setup(VDev *vdev)
>      VRing *vr;
>      int rc;
>      uint8_t status;
> -    uint16_t vq_size;
>      int i = 0;
>  
>      vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
> @@ -380,28 +379,39 @@ int virtio_pci_setup(VDev *vdev)
>          return -EIO;
>      }
>  
> -    if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
> -        puts("Failed to read virt-queue configuration");
> -        return -EIO;
> -    }
> -
>      /* Configure virt-queues for pci */
>      for (i = 0; i < vdev->nr_vqs; i++) {
> +        uint16_t vq_size;
> +        uint16_t vq_notify;
>          VqInfo info = {
>              .queue = (unsigned long long) virtio_get_ring_area(i),
>              .align = KVM_S390_VIRTIO_RING_ALIGN,
>              .index = i,
> -            .num = vq_size,
> +            .num = 0,
>          };
>  
>          vr = &vdev->vrings[i];
> -        vring_init(vr, &info);
>  
> -        if (vpci_set_selected_vq(vr->id)) {
> +        if (vpci_set_selected_vq(i)) {
>              puts("Failed to set selected virt-queue");
>              return -EIO;
>          }
>  
> +        if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {

Small nit: c_cap.off + VPCI_C_OFFSET_Q_SIZE

> +            puts("Failed to read virt-queue configuration");
> +            return -EIO;
> +        }
> +
> +        info.num = vq_size;
> +
> +        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar, &vq_notify)) {
> +            puts("Failed to read virt-queue configuration");
> +            return -EIO;
> +        }

Since the notification offset is now read per queue, should we remove
the same read in virtio_pci_read_pci_cap_config() as well as the global
q_notify_offset variable?

if (rc || vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar,
&q_notify_offset))

> +
> +        vr->pci_notify = vq_notify;
> +        vring_init(vr, &info);
> +
>          rc = set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
>          rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
>          rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
> index 90d07cb9a7..993fc285ac 100644
> --- a/pc-bios/s390-ccw/virtio-pci.h
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -62,9 +62,10 @@ struct VirtioPciCap {
>  };
>  typedef struct VirtioPciCap  VirtioPciCap;
>  
> +int vpci_set_selected_vq(uint16_t queue_num);
>  void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
>  int virtio_pci_reset(VDev *vdev);
> -long virtio_pci_notify(int vq_id);
> +long virtio_pci_notify(VRing *vr);
>  int virtio_pci_setup(VDev *vdev);
>  int virtio_pci_setup_device(void);
>  
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 30e6b2bc16..00850acc2f 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -114,7 +114,8 @@ bool vring_notify(VRing *vr)
>          vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
>          break;
>      case S390_IPL_TYPE_PCI:
> -        vr->cookie = virtio_pci_notify(vr->id);
> +        vr->cookie = virtio_pci_notify(vr);
> +        break;
>      default:
>          return 1;
>      }
> @@ -154,6 +155,7 @@ static void vr_bswap_descriptor(VRingDesc *desc)
>  void vring_send_buf(VRing *vr, void *p, int len, int flags)
>  {
>      if (!be_ipl()) {
> +        vpci_set_selected_vq(vr->id);
>          vr->avail->idx = bswap16(vr->avail->idx);
>      }
>  
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index d32a4830ca..75ae5bdbc2 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -107,6 +107,7 @@ struct VRing {
>      VRingUsed *used;
>      long cookie;
>      int id;
> +    uint16_t pci_notify;
>  };
>  typedef struct VRing VRing;
>  


