Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF7C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x989F-0007xX-KO; Tue, 22 Sep 2026 17:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9897-0007v0-C1; Tue, 22 Sep 2026 17:35:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9895-0007ZA-M5; Tue, 22 Sep 2026 17:35:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI8AFK3449238; Tue, 22 Sep 2026 21:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oQVGfe
 BqcgiY1UxvgTPK7v9V4qANqJJlJ982NIff9A0=; b=CLPY7Q4iHyseOZQI4jb6ic
 +fbH/oh+ppKAzOllQV1M4RHLW6VVhm6ctHICOtVqWHfRLa2yicQLmQaD6mYFQ2CG
 aATCRNhCJOf3/Wii4wCmtqMnv2vpqcQWVfsgjIgSlnG010o2cJwHe5T7PJ5/R4Jl
 TYmsb3fDxRYIYEezo04v2T1E8ntjUS9a5s+o8ZZFv3M27+NWFPnBVhvmCun99HYu
 4txBuNNQDwnKhaoT14cfe8nX57zblXCZowENP9X34saBUC4HXlOtw4G+//SdveQ8
 7L80Z3q9tr0BLa9VqaaryLauqqXmwm077Ar8a/sgd9V9bnbItIMHsIQTPguTzgsA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1r2f4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 21:35:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHseA3279998; Tue, 22 Sep 2026 21:35:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqbqxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 21:35:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MLZIFu54657386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 21:35:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EAA55805E;
 Tue, 22 Sep 2026 21:35:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F7F358043;
 Tue, 22 Sep 2026 21:35:17 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 21:35:17 +0000 (GMT)
Message-ID: <165b19bf-cc35-4727-b117-53174a8ae58b@linux.ibm.com>
Date: Tue, 22 Sep 2026 17:35:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-5-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260914193438.526407-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A2JBb6VAGxZpdFOQ7mOhNEtbO_qByg18
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2f499 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ZPvrVXSYuDfJ2_nnyT4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5OSBTYWx0ZWRfXwCZJ/wSN5ypH
 SniU4i622d7P2Vi5FFIB0gY6nePW+ADpWuIQS+7Z6ffPRdlDuryPBrFpnUG9schzCcD/wtNEvXd
 vtWXa/095eyPFandYt+81xjvaQGW5PI=
X-Proofpoint-GUID: A2JBb6VAGxZpdFOQ7mOhNEtbO_qByg18
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5OSBTYWx0ZWRfX0jEJ/ks7vApx
 zmrnXapcOvjdYI7naULynrtlAg+ICcJ+FArPX+DJcRuX2tjZFEbrA0lcasPkorxil0jw+E6zO1N
 Y5NJa9HBPNJDi+gmBtXRD/dQXviGq7P/XIWs3jyL44gO65Cn8XjVQNQG7iMtuJxs8/VsbaazG7r
 cpwVYyc4DPNHfG9MOoVnn1/BioO+JQ9qXRkut081Y8UxyUwWhDKgDb6OmSoK+2mjgCKsSIOmJv5
 G0+GS9AtKHibjOGnMQgmDTSdNTjCU3I/cxeqnOBkE64Pw9Il2tBicRxGx98Go1WkzFt6FCz/O1R
 zGdgw7WljkX5Y8Q/p0oCAsou1R+V1X7EBRzQNEWMTgfuffrsX0WzWiRA9N4n8PV1X9MCReDqQbq
 Wya+KRqvr8kDCPTmm2l2hl1Et+FU7ylOmV8H2DeBmWfuXRWz9bZ2yWZ8poqIMR81SoZYlks82F4
 EfZiYSWjMqK9C3d/0HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220299
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

On 9/14/26 3:34 PM, Zhuoying Cai wrote:
> Enable network booting via virtio-net-pci by implementing PCI transport
> support for virtio-net.
> 
> This patch also extends endianness handling for virtio PCI ring operations in
> little-endian to ensure correct behavior on s390x.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c       |  1 +
>  pc-bios/s390-ccw/netmain.c    |  9 +++++++-
>  pc-bios/s390-ccw/virtio-net.c | 41 ++++++++++++++++++++++++++++-------
>  pc-bios/s390-ccw/virtio-pci.c | 20 +++++++++++++++++
>  4 files changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 8fc1cbf653..28cab3b411 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -332,6 +332,7 @@ static void ipl_pci_device(void)
>      }
>  
>      switch (vdev->dev_type) {
> +    case VIRTIO_ID_NET:

block, scsi (when you rebase on top of Jared's series) and now net will
all use the exact same code here by falling through.

How about a comment block above the switch statement explaining they all
intentionally fall through / use the same shared setup

>      case VIRTIO_ID_BLOCK:
>          if (virtio_setup() == 0) {
>              zipl_load(); /* only return on error */
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index bcb62bf6ca..e42e049063 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -498,7 +498,14 @@ int netmain(void)
>      sclp_setup();
>      puts("Network boot starting...");
>  
> -    if (!virtio_ccw_net_setup()) {
> +    /*
> +     * CCW devices require subchannel enumeration here.
> +     * PCI devices don't require specific setup: the transport is already
> +     * initialized by ipl_pci_device(), and virtio_is_supported() is checked
> +     * later in virtio_net_init().
> +     */

This comment seems not quite accurate?

AFAICT ipl_pci_device() is just going to enable the PCI device, the
transport isn't setup until
virtio_net_init()->virtio_pci_setup()

With those 2 minor issues addressed:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



