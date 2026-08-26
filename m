Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E5CC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHVz-0004Gt-FT; Wed, 26 Aug 2026 13:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzHVw-0004GF-RL; Wed, 26 Aug 2026 13:34:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzHVv-0003Mr-5F; Wed, 26 Aug 2026 13:34:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1Twi2742621; Wed, 26 Aug 2026 17:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XAdf1R
 n+pUVeFDY+eDl58k2DK0LBQLlusd0ClQoTeEI=; b=qpoApCThQW84PuZM63s2Ee
 yn5NNumUDe5s9effujv6hnUmI69+l061JRQmTpDUdgtTeQgn78NIacnWTfI+Fw9A
 WBXNPRbu9d+6kviHw8NxVLEsnFOd1+4M9KT/VYqJ1sw8HOSRrBI9eF4VT4sQslwy
 rs57glcHedF+kCBwcEttB8xgde4Arf/c6ra/tHDtZQKEEXB+2YYg1McDfUg0yCfL
 NrGnpwJCKJjoMt8VAlTkqTVKkA3AiuKnizeVTW4Y9Nw/aZUndtzDyP2OgSFRQaRJ
 ySp4QmcajGn6+BmAsZE9n4+9/XurpYAZLNKC8BEiaezi0AZ7Jv4pme0n+nur01zQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er046h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:34:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QHQFnS029760;
 Wed, 26 Aug 2026 17:34:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyaxy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:34:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QHYBOL28836480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 17:34:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D12C5805D;
 Wed, 26 Aug 2026 17:34:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45A0C58058;
 Wed, 26 Aug 2026 17:34:10 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 17:34:10 +0000 (GMT)
Message-ID: <c2362f22-3074-45ec-bef4-d76b94cd4956@linux.ibm.com>
Date: Wed, 26 Aug 2026 13:34:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] pc-bios/s390-ccw: Add dynamic net header size
 handling
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-3-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818205324.580199-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nSwei-8EN2KKXSw4w_BwC-b8KRmhz44n
X-Proofpoint-ORIG-GUID: nSwei-8EN2KKXSw4w_BwC-b8KRmhz44n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NiBTYWx0ZWRfX/GKdmA5klgXE
 zBetWlpxURDopKZp3sQwK9CFKTPnzI5Y+oKS+rPEgNDbGODt++c5onL87dGC8yasVnmzvq6Jiu6
 zH+t9+r841MTDo33+Hrn/k/75U5GpZARJmLT3EJ87OHUHbDNUnflPftjxaUnkenAelJyBWWK8cl
 s1m8AaTDnM0lfWngvZyWRyr0YEias2qnMKHpsD1ZMcpj99/dziR9I1bmzu7esAsmX67ue0EbRZm
 u4sMnx1MbYAhZ87HSGKxm/ChVlr04B0iyB+fTlUGBw2B1WD7385R/cwptDkb1U5amca3mbtrd2Y
 gGTnoYewjWhKE8W/N/8hPd17wYdFyvbsHhkAuV056eYcS1wvYxTKRn8lphD8XyoELGufIJj7MtR
 JouVyL1/OgWdbiPWftad9AU5jM5BRrMARWgHIpVdzz8AJAKb3VgbRXF41MZwRi4Jipg5y2PCED+
 wyAlrAojdZs1EkWpAbQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f2394 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BmpXMd1MHor7H2XxycEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NiBTYWx0ZWRfX3Ews0cum+S+2
 xcNzYr/qLPRt4RqtKC4MwsPm3hMU/zKFadigcbJovIzGdk8daoO1sOXnXIfT0YYxWba0uhbq02S
 MVwBfQFTSHH5jgilT2QSwGyZPBTh6N4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260146
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 8/18/26 4:53 PM, Zhuoying Cai wrote:
> The virtio-net device used a fixed header size that did not account for
> the num_buffers field used in VirtIO 1.0 or for the mergeable receive
> buffers feature.
> 
> Use dynamic header sizing: 10 bytes for legacy mode and 12 bytes for
> VirtIO 1.0 or when VIRTIO_NET_F_MRG_RXBUF is enabled. This ensures
> correct packet handling across different VirtIO configurations.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio-net.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> index 0ee51653ab..3a9ae789cf 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -20,6 +20,7 @@
>  #include "s390-ccw.h"
>  #include "virtio.h"
>  #include "virtio-ccw.h"
> +#include "virtio-pci.h"
>  #include "s390-time.h"
>  #include "helper.h"
>  
> @@ -28,10 +29,15 @@
>  #endif
>  
>  #define VIRTIO_NET_F_MAC_BIT  (1 << 5)
> +#define VIRTIO_NET_F_MRG_RXBUF_BIT (1 << 15)
>  
>  #define VQ_RX 0         /* Receive queue */
>  #define VQ_TX 1         /* Transmit queue */
>  
> +/* Header sizes for different modes */
> +#define VIRTIO_NET_HDR_SIZE_LEGACY  10  /* Without num_buffers */
> +#define VIRTIO_NET_HDR_SIZE_V1      12  /* With num_buffers */
> +

See my comment on Jared virtio-scsi series; you already have a structure
defined for this, and this would just be a versioned variation on it;
can you basically make a split structure and then calculate these
constants using the sizeof() each struct, rather than using constant
values here that circumstantially match the size of well-defined structures?

FWIW, this looks to be exactly what the kernel does with virtio_net_hdr
vs virtio_net_hdr_mrg_rxbuf in linux/uapi/linux/virtio_net.h (or
qemu/include/standard-headers/linux/virtio_net.h)

I am not suggesting we pull the standard-headers into s390-ccw, but I
would recommend using that layout as a basis of the structures in this
patch.

Thanks,
Matt


