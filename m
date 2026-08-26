Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112B4C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzKpv-0002ni-NS; Wed, 26 Aug 2026 17:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wzKpt-0002mh-VN; Wed, 26 Aug 2026 17:07:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wzKps-0003YL-Af; Wed, 26 Aug 2026 17:07:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QL1Yqj3280470; Wed, 26 Aug 2026 21:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=u9IgrP
 A+DbYUNyEZzTbPy/iuBxDHaeqquBTRpgJejRw=; b=U/qmib7n7s+MnhqrrBwKYW
 PdGnaKh9yc624Vp0fkhx03hImGiTXfkKLU/r4gVUw4K/0Fev0x/bsbD80zccu35X
 D0/euHu4bodPAvTYxqO4gcLidodChblVUv2IDhP+UNBuZxxME53TqRkmKybueF7R
 uE4He+tirlADA1pMolwQS1ej4tB8AoAz2n5T8bmB85eVl+sCpBvsvngFuCGOW7et
 7/T6G0MmE6pPoIDhverQCX2uSyhDUowenRp0j28NEfY54xHAkW8NZlDOIMuIPzr5
 Rkc9jhXmIhiPxtH7IjeXXElYpvkz1/K2PksCC9Otj5rn6Yw7f/gsPFzD9Hy8mR/w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er168w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 21:07:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QKuGS7031860;
 Wed, 26 Aug 2026 21:07:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k46tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 21:07:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QL6xsr28639790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 21:07:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCA5C58050;
 Wed, 26 Aug 2026 21:06:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD9BF58045;
 Wed, 26 Aug 2026 21:06:58 +0000 (GMT)
Received: from [9.61.176.10] (unknown [9.61.176.10])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 21:06:58 +0000 (GMT)
Message-ID: <807ca937-02fb-43bf-ae6f-24e1392c310f@linux.ibm.com>
Date: Wed, 26 Aug 2026 13:20:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] pc-bios/s390-ccw: Introduce virtio_tswap helpers
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-4-zycai@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260818205324.580199-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fp7IS3-c99U8hjRm_XUKBlCX8Ugucd9s
X-Proofpoint-ORIG-GUID: Fp7IS3-c99U8hjRm_XUKBlCX8Ugucd9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfX+4YtAQSSg7WS
 zZXMB9+8Pv4oIVTEXsBozk43o8lW1gTsPS33+tXaPOe5DQxcXr0ykKoWAjt1+SMG50Y4mQgiBym
 XjmARpX+iaQFsAmRKYZ6T1PmmU6/Scvty0HTliIjkz2tqNGjgM9rzxWhL7FPdnqKAVLEEdJKJxF
 vCYUJUnCTVqTT7MpwN5rcfvz/ISW7xUgL7OkXSPAxh/nVzHZvUxhaUrpp/XQ8i/kAyU7qoGMKX+
 sTzS+sXL0eY6C0ZEiSEXJwB0CBJ4/BR9QQgJCOetddEXXaGxoUWfnCW4O/ATA7CDtO0fIQasWUa
 qmnTeCMsvO1wEuHtlbNLDF/+cXiYg++hNhDN4gXQmRXfrzlBBWbQTjf8o4DoYd+GL8x1CBC4d4H
 KlxfBIeoCtEJAnRIgr+XGrlC6rq3PXQrdSkYt9/b6En23ZfyQbOMsz9NTfwZXB7B6/bIbZKWg2h
 YBbTd2HyG4ArNdJ7oCQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f5576 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=oSvTa84OmGCE6nrsjowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfX9u6oQSL0qmSZ
 RB7lFVW3tKPLqA8F9yf+T6cN6rF1qx8KtewuudLXY3SegyTWSNZEn7Lr6B1ncZQouvBHr59nFnT
 +2fSN0gvrPdkZrPywfb5xjJemtgWbss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> Replace the repeated pattern:
> 
>      be_ipl() ? x : bswapN(x)
> 
> with helpers that conditionally byte-swap based on the virtio transport
> endianness.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/virtio.c | 27 +++++++++++++++++++++------
>   pc-bios/s390-ccw/virtio.h |  4 ++++
>   2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index a0d249db24..037c00a3e1 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -97,7 +97,7 @@ void vring_init(VRing *vr, VqInfo *info)
>       vr->avail->idx = 0;
>   
>       /* We're running with interrupts off anyways, so don't bother */
> -    vr->used->flags = be_ipl() ? VRING_USED_F_NO_NOTIFY : bswap16(VRING_USED_F_NO_NOTIFY);
> +    vr->used->flags = virtio_tswap16(VRING_USED_F_NO_NOTIFY);
>       vr->used->idx = 0;
>       vr->used_idx = 0;
>       vr->next_idx = 0;
> @@ -140,6 +140,22 @@ bool be_ipl(void)
>       }
>   }
>   
> +/* Conditionally byte-swap between virtio-endian and s390x native big-endian. */
> +uint16_t virtio_tswap16(uint16_t x)
> +{
> +    return be_ipl() ? x : bswap16(x);
> +}
> +
> +uint32_t virtio_tswap32(uint32_t x)
> +{
> +    return be_ipl() ? x : bswap32(x);
> +}
> +
> +uint64_t virtio_tswap64(uint64_t x)
> +{
> +    return be_ipl() ? x : bswap64(x);
> +}
> +
>   /*
>    * Format the virtio ring descriptor endianness
>    * Return the available index increment in the appropriate endianness
> @@ -156,12 +172,11 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
>   {
>       uint16_t avail_idx;
>   
> -    avail_idx = be_ipl() ? vr->avail->idx : bswap16(vr->avail->idx);
> +    avail_idx = virtio_tswap16(vr->avail->idx);
>   
>       /* For follow-up chains we need to keep the first entry point */
>       if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
> -        vr->avail->ring[avail_idx % vr->num] = be_ipl() ? vr->next_idx :
> -                                                          bswap16(vr->next_idx);
> +        vr->avail->ring[avail_idx % vr->num] = virtio_tswap16(vr->next_idx);
>       }
>   
>       vr->desc[vr->next_idx].addr = (unsigned long)p;
> @@ -179,7 +194,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
>       /* Chains only have a single ID */
>       if (!(flags & VRING_DESC_F_NEXT)) {
>           avail_idx++;
> -        vr->avail->idx = be_ipl() ? avail_idx : bswap16(avail_idx);
> +        vr->avail->idx = virtio_tswap16(avail_idx);
>       }
>   }
>   
> @@ -187,7 +202,7 @@ int vr_poll(VRing *vr)
>   {
>       uint16_t used_idx;
>   
> -    used_idx = be_ipl() ? vr->used->idx : bswap16(vr->used->idx);
> +    used_idx = virtio_tswap16(vr->used->idx);
>       if (used_idx == vr->used_idx) {
>           vring_notify(vr);
>           yield();
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index 04dbc65dbd..3c84a480d9 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -287,6 +287,10 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
>   int virtio_reset(VDev *vdev);
>   int virtio_setup_ccw(VDev *vdev);
>   
> +uint16_t virtio_tswap16(uint16_t x);
> +uint32_t virtio_tswap32(uint32_t x);
> +uint64_t virtio_tswap64(uint64_t x);
> +
>   /* virtio-net.c */
>   int virtio_net_init(void *mac_addr);
>   void virtio_net_deinit(void);

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>


