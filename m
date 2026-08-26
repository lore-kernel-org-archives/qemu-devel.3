Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10C0C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGjd-0004XM-Fy; Wed, 26 Aug 2026 12:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzGjb-0004Wd-90; Wed, 26 Aug 2026 12:44:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzGjZ-0008C9-5o; Wed, 26 Aug 2026 12:44:19 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1cbO3084670; Wed, 26 Aug 2026 16:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Qzj8Cg
 wGqplz3ML+s5oZo5aGC6g6Tso3K6cdZMFAuxg=; b=MJz6CTxkzOVJqYvhGCS4KD
 YU3lZKrj5cojetQxQ20CF/QfjvhbslFWrisTDnlAak8WrL0ibplv7ZRbboF7npDR
 KinZihL4q4lpWNqlBogezjI62DQ8aAWpKbp0+6hgw5R/cqw9l9li5RmnMqadn8zQ
 GqO7wLMn3USvVxxKwGKzszj+RTI9iIPI/VhofYlT3niNfrBj6+DCFIJiVN9HcHbT
 9ELasftIZtMRs1wCs5Fyj5ah960JKhb2gg+V07NwirGEaHTNRvXHd4lsuX5NqU29
 BYROH0yD+vxAmYuJnPHHtBZRW+6Q5fjVyfSFX8EJLhXbNtrIpW+n6lH8bgKryX4A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726equwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 16:44:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QGfMNf022906;
 Wed, 26 Aug 2026 16:44:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qb7er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 16:44:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QGiDs523200418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 16:44:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB6C558055;
 Wed, 26 Aug 2026 16:44:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74D0758043;
 Wed, 26 Aug 2026 16:44:12 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 16:44:12 +0000 (GMT)
Message-ID: <5a7ed440-ed57-448a-9baa-4626464ee9f8@linux.ibm.com>
Date: Wed, 26 Aug 2026 12:44:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-5-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260818205324.580199-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f17df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ctsVLiZ_AAAA:8 a=DwueQANkowgNhn0VcN8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfXx6DdekL7yRUc
 2EuISiGYa0xjYsFpgmvy+N4LfxwlMbNV2b2Yjr52etKjccQsTJkFXay1vxw3m2SlNOpB4ljOKfb
 TlPr/ZW+X9RWhLheT/2wjKd0ge55SC4=
X-Proofpoint-GUID: XF8PuiH2XW5XJKOXL7O8BPW05KeFrrzc
X-Proofpoint-ORIG-GUID: XF8PuiH2XW5XJKOXL7O8BPW05KeFrrzc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX3IOevqpLoI5J
 rcV3B8TZMhSfa8q0iFvFderMUEbWcsEXq8Zzm/GT37+0MWwKbU6RPCejh7cp4KAIRmL9WB67MqY
 2ZEYKErGPrveWRhq2DNMQ4d68ZpjpnilCrTa/zZ+2EZjmEmjsv8+e3adn8tbkYOoYp/Dkbd/5En
 BztWDsFVDPVb8SuReguKFGTGQRUbw8CtZ4LBVJ1if0TLAnxKcntg4raZIP8+twvpF3bc3UnD1sP
 wCLjGv2nOZwBWKZYq+Rwko9qnJP7cZTH/IRyFB9jschYVhOgAGDuVPw8f9pmfsCM8ikJHsqhv3R
 hqcAkAUu9mSYgas13c2g1+vCa/NMz7+nX4KPFXxXFv+2/oyeg6h0peFj/USHAfoRe4dBDvxosT8
 Z+Y0A59OrCQgNPZ+KMvQhmjFmf6GhvxCKrhjJIsE0CvNd6WiIjg2WaVqOIB5OU52JieDB3I810N
 Sx7OBcZ78XCF+AzCW7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 8/18/26 4:53 PM, Zhuoying Cai wrote:
> Enable network booting via virtio-net-pci by implementing PCI transport
> support for virtio-net.
>
> This patch also adds endianness handling for virtio PCI ring operations in
> little-endian to ensure correct behavior on s390x.

Endianness handling was actually added in the previous patch.  Is this a
misplaced message? Or perhaps it should say extends, rather than adds?

> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c       |  1 +
>   pc-bios/s390-ccw/virtio-net.c | 37 +++++++++++++++++++++++-------
>   pc-bios/s390-ccw/virtio-pci.c | 43 +++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/virtio-pci.h |  2 ++
>   4 files changed, 75 insertions(+), 8 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 8bc6e8eaa3..0eeb53a2bf 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -328,6 +328,7 @@ static void ipl_pci_device(void)
>       }
>   
>       switch (vdev->dev_type) {
> +    case VIRTIO_ID_NET:
>       case VIRTIO_ID_BLOCK:
>           if (virtio_setup() == 0) {
>               zipl_load(); /* only return on error */
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> index 3a9ae789cf..209f98a0e3 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -62,7 +62,16 @@ int virtio_net_init(void *mac_addr)
>       rx_last_idx = 0;
>   
>       vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
> -    virtio_ccw_setup(vdev);
> +    switch (virtio_get_device()->ipl_type) {
> +    case S390_IPL_TYPE_CCW:
> +        virtio_ccw_setup(vdev);
> +        break;
> +    case S390_IPL_TYPE_PCI:
> +        virtio_pci_setup(vdev);
> +        break;
> +    default:
> +        return -1;
> +    }
>   
>       if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
>           puts("virtio-net device does not support the MAC address feature");
> @@ -115,22 +124,30 @@ int recv(int fd, void *buf, int maxlen, int flags)
>       VRing *rxvq = &vdev->vrings[VQ_RX];
>       int len, id;
>       uint8_t *pkt;
> +    uint16_t rx_used_idx, rx_avail_idx;
> +    uint32_t rx_used_len, rx_used_id;
> +    uint64_t rx_desc_addr;
>   
> -    if (rx_last_idx == rxvq->used->idx) {
> +    rx_used_idx = virtio_tswap16(rxvq->used->idx);
> +    if (rx_last_idx == rx_used_idx) {
>           return 0;
>       }
>   
> -    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - virtio_net_hdr_size;
> +    rx_used_len = virtio_tswap32(rxvq->used->ring[rx_last_idx % rxvq->num].len);
> +    rx_used_id = virtio_tswap32(rxvq->used->ring[rx_last_idx % rxvq->num].id);
> +
> +    len = rx_used_len - virtio_net_hdr_size;
>       if (len > maxlen) {
>           puts("virtio-net: Receive buffer too small");
>           len = maxlen;
>       }
> -    id = rxvq->used->ring[rx_last_idx % rxvq->num].id % rxvq->num;
> -    pkt = (uint8_t *)(rxvq->desc[id].addr + virtio_net_hdr_size);
> +    id = rx_used_id % rxvq->num;
> +    rx_desc_addr = virtio_tswap64(rxvq->desc[id].addr);
> +    pkt = (uint8_t *)(rx_desc_addr + virtio_net_hdr_size);
>   
>   #if DEBUG_VIRTIO_NET   /* Dump packet */
>       int i;
> -    printf("\nbuf %p: len=%i\n", (void *)rxvq->desc[id].addr, len);
> +    printf("\nbuf %p: len=%i\n", (void *)rx_desc_addr, len);
>       for (i = 0; i < 64; i++) {
>           printf(" %02x", pkt[i]);
>           if ((i % 16) == 15) {
> @@ -144,8 +161,10 @@ int recv(int fd, void *buf, int maxlen, int flags)
>       memcpy(buf, pkt, len);
>   
>       /* Mark buffer as available to the host again */
> -    rxvq->avail->ring[rxvq->avail->idx % rxvq->num] = id;
> -    rxvq->avail->idx = rxvq->avail->idx + 1;
> +    rx_avail_idx = virtio_tswap16(rxvq->avail->idx);
> +    rxvq->avail->ring[rx_avail_idx % rxvq->num] = virtio_tswap16(id);
> +    rx_avail_idx++;
> +    rxvq->avail->idx = virtio_tswap16(rx_avail_idx);
>       vring_notify(rxvq);
>   
>       /* Move index to next entry */
> @@ -164,6 +183,8 @@ bool virtio_net_setup(void)
>       switch (virtio_get_device()->ipl_type) {
>       case S390_IPL_TYPE_CCW:
>           return virtio_ccw_net_setup();
> +    case S390_IPL_TYPE_PCI:
> +        return virtio_pci_net_setup();
>       default:
>           return false;
>       }
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index f501252c81..c7d62766b8 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -52,6 +52,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>       case 0x1001:
>           vdev->dev_type = VIRTIO_ID_BLOCK;
>           break;
> +    case 0x1041:
> +    case 0x1000:
> +        vdev->dev_type = VIRTIO_ID_NET;
> +        break;
>       default:
>           vdev->dev_type = 0;
>       }
> @@ -199,6 +203,14 @@ static int virtio_pci_get_blk_config(void)
>       return rc;
>   }
>   
> +static int virtio_pci_get_net_config(void)
> +{
> +    VirtioNetConfig *cfg = &virtio_get_device()->config.net;
> +    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioNetConfig));
> +
> +    return rc;
> +}
> +
>   static int virtio_pci_negotiate(void)
>   {
>       int i, rc;
> @@ -330,6 +342,7 @@ bool virtio_pci_is_supported(VDev *vdev)
>       if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
>           switch (vdev->dev_type) {
>           case VIRTIO_ID_BLOCK:
> +        case VIRTIO_ID_NET:
>               return true;
>           default:
>               return false;
> @@ -384,6 +397,11 @@ int virtio_pci_setup(VDev *vdev)
>           vdev->cmd_vr_idx = 0;
>           virtio_pci_get_blk_config();
>           break;
> +    case VIRTIO_ID_NET:
> +        vdev->nr_vqs = 2;
> +        vdev->cmd_vr_idx = 0;
> +        virtio_pci_get_net_config();
> +        break;
>       default:
>           puts("Unsupported virtio device");
>           return -ENODEV;
> @@ -458,3 +476,28 @@ int virtio_pci_setup_device(void)
>   
>       return 0;
>   }
> +
> +static bool find_pci_net_dev(void)
> +{
> +    if (!virtio_is_supported(virtio_get_device())) {
> +        return false;
> +    }
> +
> +    if (virtio_get_device_type() != VIRTIO_ID_NET) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +bool virtio_pci_net_setup(void)
> +{
> +    bool found = false;
> +
> +    if (have_iplb || store_iplb(&iplb)) {
> +        IPL_assert(iplb.pbt == S390_IPL_TYPE_PCI, "IPL_TYPE_PCI expected");
> +        found = find_pci_net_dev();
> +    }
> +
> +    return found;
> +}

As far as I can tell the net specific setup/find are not needed for PCI
devices.  By the time we reach the the call to virtio_pci_net_setup() we
know vdev->ipl_type == S390_IPL_TYPE_PCI because that is the prerequisite
to call the function in the first place, and vdev->ipl_type was previously
set based on the PBT.  We also already know that our device type is
VIRTIO_ID_NET because otherwise the call to virtio_setup() in main.c
would have fallen through to the default case and failed and/or netmain()
would not be called from bootmap.c.

Although we haven't checked virtio_is_supported() yet, we will do that
verification in virtio_net_init(), which is the very next step.

For PCI devices, everything checked from virtio_net_setup() appears to be
guaranteed by the call chain or validated by subsequent net code. Maybe
virtio_net_setup() only needs to be called for CCW devices?

Regards,
Jared Rossi
> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
> index 33b683bd92..2c3136fd05 100644
> --- a/pc-bios/s390-ccw/virtio-pci.h
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -70,6 +70,8 @@ long virtio_pci_notify(VRing *vr);
>   bool virtio_pci_is_supported(VDev *vdev);
>   int virtio_pci_setup(VDev *vdev);
>   int virtio_pci_setup_device(void);
> +bool virtio_pci_is_supported(VDev *vdev);
> +bool virtio_pci_net_setup(void);
>   
>   int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
>   int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);


