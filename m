Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81520C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x92XR-0006VU-Ji; Tue, 22 Sep 2026 11:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x92XN-0006VG-Jx; Tue, 22 Sep 2026 11:36:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x92XL-0003fd-Sj; Tue, 22 Sep 2026 11:36:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5TY13768111; Tue, 22 Sep 2026 15:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KEedkk
 5Gx6quG+KYGw7t2PeRLl7mee8aF9M6SVUBTK8=; b=RG3XFuNm6u4yzMgf6W5oDs
 DG+CNyzit0HGzkwik55GNggGavfQVkN1VtBG+QcHf+HLGnlUAHbtUoJd2yXhLkru
 YkLhulaG7xzThwwYRK67IN5VdnzhPWA00Jczy8uGBzTQH0JwWiOK2lXdwPqbgpgb
 w1CWkDE+U+ghYjlJsthayGjA4v98G9Hjne+NilMbG0N1NTfGofrNgJhUI6njKb7G
 bxm1wPhVl9uCHSrE7KoQJCsnfh1gr3lw+P8SCT2TsFpTps17kVFjk2xXBMOjnJX8
 1jr5+q2hGyRQWvnkecHrAxP9XH03/MBUVDDEsUwIvrduNkM9/aZmWuZfnQ3KQmLA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqe97e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 15:36:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MElbBP3046813; Tue, 22 Sep 2026 15:35:59 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqaj0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 15:35:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MFZwLd34538026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 15:35:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E108058059;
 Tue, 22 Sep 2026 15:35:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B08665805B;
 Tue, 22 Sep 2026 15:35:56 +0000 (GMT)
Received: from [9.57.45.223] (unknown [9.57.45.223])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 15:35:56 +0000 (GMT)
Message-ID: <775ca6a7-18b3-437e-992d-cc366daa84d9@linux.ibm.com>
Date: Tue, 22 Sep 2026 11:35:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-5-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260914193438.526407-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab2a060 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ctsVLiZ_AAAA:8 a=8ptc-4uyLhLlwk-ceVIA:9 a=QEXdDO2ut3YA:10
 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIyNyBTYWx0ZWRfX4dOMP8okuKez
 9In1549slctHnL9NE07plAIKCJNMHNS1AL2PjtlmRCUxw3sNnZoApNTIutUV/n2m/tdTdHjcIhW
 9aCrqgHMBCT/deGloVe0cePXuvzYI//61Hm0SrQWtuwAFImEyAgHyqQJIwtyUPTjPOnkaPnVsCS
 qp/Wls1QAh/zs+stzr9aYFaPqws6fmkBB0s2Ktbb0hgmobX+fwnV2yUMQVuJXMt2VX1vtwbEQ4c
 WBs9ceT6GCAhrsDAA5ZmrxEgePIFB6dlx1losqPpeElguKitgnPtSs8NNvGNlT5nDr3BH7fPS31
 JQEuacnCDm7M8LbbAuEtX6O6PrJw0u6+QzsSVb433y4hb4Qoagl76XMDIwjhKGdcx2LW5VAHWN7
 UFSiaSsf4uBLt8GroUjzgMSrnKwfkbDaI4BUnHPAKBpfHqqYtULPu/jLWwu2ZffZ33zJFjd2Dva
 DqxRdQy4NIjKGJ7UZcw==
X-Proofpoint-ORIG-GUID: vTzrPgqIGqg6EVMECtLiEpCDqu5DPGWD
X-Proofpoint-GUID: vTzrPgqIGqg6EVMECtLiEpCDqu5DPGWD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIyNyBTYWx0ZWRfX+ojFcby6qCcz
 hSuuXSpwG7RW1QlafuWgf2ztCxY4WYUA/KsTq/sEp6aqZMS3UubGbJMKQzi5vrdxGIF71Hzv6VP
 r3nsGuO074nfPdTCXCDUxxuNXFT/M3U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220227
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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

FYI, now that Jared's virtio-scsi-pci boot series is merged, this patch does not apply.

On 9/14/2026 3:34 PM, Zhuoying Cai wrote:
> Enable network booting via virtio-net-pci by implementing PCI transport
> support for virtio-net.
> 
> This patch also extends endianness handling for virtio PCI ring operations in
> little-endian to ensure correct behavior on s390x.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c       |  1 +
>   pc-bios/s390-ccw/netmain.c    |  9 +++++++-
>   pc-bios/s390-ccw/virtio-net.c | 41 ++++++++++++++++++++++++++++-------
>   pc-bios/s390-ccw/virtio-pci.c | 20 +++++++++++++++++
>   4 files changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 8fc1cbf653..28cab3b411 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -332,6 +332,7 @@ static void ipl_pci_device(void)
>       }
>   
>       switch (vdev->dev_type) {
> +    case VIRTIO_ID_NET:
>       case VIRTIO_ID_BLOCK:
>           if (virtio_setup() == 0) {
>               zipl_load(); /* only return on error */
case VIRTIO_ID_SCSI has been added here

..snip...

> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index f501252c81..fd794bad8f 100644
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
some new cases were added here also

> @@ -199,6 +203,17 @@ static int virtio_pci_get_blk_config(void)
>       return rc;
>   }
>   
> +static int virtio_pci_get_net_config(void)
> +{
> +    VirtioNetConfig *cfg = &virtio_get_device()->config.net;
> +
> +    /*
> +     * Byte-swapping is not needed as only the MAC address (byte array)
> +     * is used here. Byte-swap if other fields are added.
> +     */
> +    return vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioNetConfig));
> +}
> +
>   static int virtio_pci_negotiate(void)
>   {
>       int i, rc;
> @@ -330,6 +345,7 @@ bool virtio_pci_is_supported(VDev *vdev)
>       if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
>           switch (vdev->dev_type) {
>           case VIRTIO_ID_BLOCK:
> +        case VIRTIO_ID_NET:
>               return true;
>           default:
>               return false;
here also

> @@ -384,6 +400,10 @@ int virtio_pci_setup(VDev *vdev)
>           vdev->cmd_vr_idx = 0;
>           virtio_pci_get_blk_config();
>           break;
> +    case VIRTIO_ID_NET:
> +        vdev->nr_vqs = 2;
> +        virtio_pci_get_net_config();
> +        break;
>       default:
>           puts("Unsupported virtio device");
>           return -ENODEV;
here also

