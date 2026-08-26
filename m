Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A58CC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzKB9-00008m-Dd; Wed, 26 Aug 2026 16:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzKB8-000086-0m; Wed, 26 Aug 2026 16:24:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzKB5-0007Cv-FN; Wed, 26 Aug 2026 16:24:56 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1ZQ9424713; Wed, 26 Aug 2026 20:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3Y2kWY
 zuIyoOyzo7KjnOiqGb7boq5VlnXvEJJqLjXI4=; b=bOZ9d2gIVB1KYyHou+BK5h
 jX5mdV13/iNKabwBMYNB+taT+5RDZL6uS6XpKYrstjmo17WWHlUTGLUNZq+GkaF0
 lER6Okou6E0uP5ltfgIwn+IdmSlDdivTr004m5QopggdmLpJvhxSYs73WVEWOsyO
 SpRYj2peOIG7s80RIBSlqebQyAkPcV44QRShxi+3zJ6pmm3ouI4YYtaN00XdYbIe
 7xaK7VBcE1zAfgjX4ErbqxoaKoYCPzyFx0u3JhUMnbn5y0u2ofq46s17bqPsAJ3S
 XFlgN96Jb4Hv5nd/gWl9VzlZzNQMVuUrd8urZWCrioa4h+xZl/clpdYFv/sP3onw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g512at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 20:24:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QKBI4Z008097;
 Wed, 26 Aug 2026 20:24:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwc4fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 20:24:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QKOo0366388232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 20:24:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D29415803F;
 Wed, 26 Aug 2026 20:24:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 538FB58056;
 Wed, 26 Aug 2026 20:24:50 +0000 (GMT)
Received: from [9.61.145.136] (unknown [9.61.145.136])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 20:24:50 +0000 (GMT)
Message-ID: <8cc0e23b-6741-4fb8-9384-44ca95b07ba8@linux.ibm.com>
Date: Wed, 26 Aug 2026 16:24:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] pc-bios/s390-ccw: Use bus specific IPL_TYPE
 directly for scsi IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-5-jrossi@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260811144629.866641-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7CgsKG7lAPGorAjiF7yORdrGIcvJJ117
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE2OCBTYWx0ZWRfX+LenC9ZpkoFv
 pOcZLVp00EQy3ZQNo+9nzrI9e8gzLTOUsbhg15kWOXQnkSvaJP6v1kxy5vGxi3CN23bSfC6R+E3
 UCFBxLW0hEQUpEnA6vb/9PG8EjElmpk=
X-Proofpoint-GUID: 7CgsKG7lAPGorAjiF7yORdrGIcvJJ117
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8f4b95 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=tULXT7rEgByDIO15at8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE2OCBTYWx0ZWRfX3mbgnV9LKvck
 zVm6cpnwHC5jL5wcyyG7GRh/vZEwTQhMsmVM9tRF4ut24ZNS0/0L/ZMDK5toK0JjC6eUDMiMblO
 lr94JfS21cgFUp0Ka1kd5e0EyB5BtWJKzO3uwFwT314QcifWkwRu2Xwpnrj2SwkHkTYVcioZhnO
 twrjJs7iYgUFfk5BvLmBl1W8NvqP3gxAh3rqdsll2b6RB3Ei3BJ3+DO7hMr2Y1wI9C1cKIopNJq
 /MI47z88yRVOdPoiYV6Xb/RD4kZEHF5ftMWsnTSmr9R2EORUH6Q+UTbt76e9kAPXv3znybedbs3
 mhixJYsnaQfJBCVBniG8m5csRPQ2Kcirgz85TFmXljQ/VlNzw75Kp0BjG7swFPmG/pRgnLCOSzt
 3R70YaZOYFovm1WqJG7TV/Ne6K1oUx4yXJgHrNPKbfHqlApCAUAvUs29jaw6qKiZZfg/gujrvD6
 2GeBWQewqbFe7+oSxEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260168
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
> All existing switch cases that handle S390_IPL_TYPE_QEMU_SCSI directly fall
> through to S390_IPL_TYPE_CCW.  Rather than always fall through, reassign
> vdev->ipl_type to the appropriate bus for the scsi controller and proceed
> as usual, where the bus is designated by the "bus" field and set during
> the IPLB build.
> 
> Because S390_IPL_TYPE_QEMU_SCSI should not appear as an ipl_type once the
> device is found, remove that specific case from other existing switches
> and allow it to land in the default case, which will generally result
> in an immediate error.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c          | 13 ++++++++++---
>   pc-bios/s390-ccw/virtio-blkdev.c |  1 -
>   pc-bios/s390-ccw/virtio.c        |  5 -----
>   3 files changed, 10 insertions(+), 9 deletions(-)

The expected followup described in patch 2 apply to 
S390_IPLB_MIN_QEMU_SCSI_LEN, but this is good...

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 8bc6e8eaa3..63692260a4 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -257,8 +257,16 @@ static bool find_boot_device(void)
>           vdev->selected_scsi_device.channel = iplb.scsi.channel;
>           vdev->selected_scsi_device.target = iplb.scsi.target;
>           vdev->selected_scsi_device.lun = iplb.scsi.lun;
> -        blk_schid.ssid = iplb.scsi.ssid & 0x3;
> -        found = find_subch(iplb.scsi.devno);
> +        vdev->ipl_type = iplb.scsi.bus;
> +        switch (vdev->ipl_type) {
> +        case S390_IPL_TYPE_CCW:
> +            blk_schid.ssid = iplb.scsi.ssid & 0x3;
> +            found = find_subch(iplb.scsi.devno);
> +            break;
> +        default:
> +            puts("Unrecognized SCSI controller");
> +            break;
> +        }
>           break;
>        case S390_IPL_TYPE_PCI:
>           found = find_fid(iplb.pci.fid);
> @@ -342,7 +350,6 @@ static void ipl_pci_device(void)
>   static void ipl_boot_device(void)
>   {
>       switch (virtio_get_device()->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           ipl_ccw_device();
>           break;
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 98b6cec3a0..83a1185dd5 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -253,7 +253,6 @@ int virtio_blk_setup_device(VDev *vdev)
>       puts("Using virtio-blk.");
>   
>       switch (vdev->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return virtio_ccw_setup(vdev);
>       case S390_IPL_TYPE_PCI:
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index a0d249db24..0b33544144 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -61,7 +61,6 @@ char *virtio_get_ring_area(int ring_num)
>   int drain_irqs(void)
>   {
>       switch (vdev.ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return drain_irqs_ccw(vdev.schid);
>       default:
> @@ -109,7 +108,6 @@ void vring_init(VRing *vr, VqInfo *info)
>   bool vring_notify(VRing *vr)
>   {
>       switch (vdev.ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
>           break;
> @@ -130,7 +128,6 @@ bool vring_notify(VRing *vr)
>   bool be_ipl(void)
>   {
>       switch (virtio_get_device()->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return true;
>       case S390_IPL_TYPE_PCI:
> @@ -231,7 +228,6 @@ int vring_wait_reply(void)
>   int virtio_reset(VDev *vdev)
>   {
>       switch (vdev->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return virtio_ccw_reset(vdev);
>       case S390_IPL_TYPE_PCI:
> @@ -244,7 +240,6 @@ int virtio_reset(VDev *vdev)
>   bool virtio_is_supported(VDev *vdev)
>   {
>       switch (vdev->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
>       case S390_IPL_TYPE_CCW:
>           return virtio_ccw_is_supported(vdev);
>       case S390_IPL_TYPE_PCI:


