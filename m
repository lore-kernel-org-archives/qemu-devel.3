Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE34C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyYZg-0001Eb-Km; Mon, 24 Aug 2026 13:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wyYZe-0001CA-C9; Mon, 24 Aug 2026 13:35:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wyYZc-0006iQ-Cp; Mon, 24 Aug 2026 13:35:06 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OG1aEP500883; Mon, 24 Aug 2026 17:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aF/IQN
 /A8gy0rrieVy3fPOITSXLweYQF15B/wnnysxI=; b=QqXofjnf2hqahMCUNgni7x
 iphHVtu0j5+g+muzqOftCbJLk1Iwhw5Mn7g4/AHtPXHU8t03UrV5grJYjc7pTl81
 o0jdDbr0Pn7ezgIwWO0qttFCK3px8QImGo3CeOtypgIqQJC7keLUTv+v+HQXlSvm
 P7M5/aXd7eJgLXJVt7vMgotCZMa2EGYYO0EX0/TqlG1dqqHysrVXJlZpiLeJrMFA
 86eu904jrAOv1itvBJ7GydGTxN2hx6pdRyysNlXvgU6AfG9UEs9QmOcLPLuSneiI
 X479z200fvwuneiftjko4fk5NNr5pLNpRBG7JorPtJ21qtCSvWjD1T2l1EqEwgFg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqk1rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 17:35:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OHQJti027439;
 Mon, 24 Aug 2026 17:35:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag7amk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 17:35:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OHYxpV39387636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 17:34:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F0EA58056;
 Mon, 24 Aug 2026 17:34:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D910E5805E;
 Mon, 24 Aug 2026 17:34:58 +0000 (GMT)
Received: from [9.61.26.206] (unknown [9.61.26.206])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 17:34:58 +0000 (GMT)
Message-ID: <6ee092fa-ac88-415c-820b-e1fb99e2d0d2@linux.ibm.com>
Date: Mon, 24 Aug 2026 13:34:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] pc-bios/s390-ccw: Check if a PCI function is
 already enabled before trying to enable it
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-2-jrossi@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20260811144629.866641-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 10GNmR8NO6v0iz-WZLbUhX_nnix2SzKR
X-Proofpoint-ORIG-GUID: 10GNmR8NO6v0iz-WZLbUhX_nnix2SzKR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0OCBTYWx0ZWRfX+DY853YMVr0n
 yphELtwU5K4HmpDG5h554AIdTGmaQItNlYFCtDmvLukYp/P28oxkNmDa1KQi4+MwnvaQEEnGm4u
 ZMdbFU1B+tqP26ov/F+mjqv7AjPGOHqcOafZ01LG8bgY38UwKRzpuk+R4Xo6id9+d+HHZpDdqM3
 2TKZN/+IoUKKtgcFz+WJIowuoz1mP4jEvFbc5NPfA/GKRk5xvpUTlwVoxVq+8ImdgIhroeSQV5p
 G6oIdKAoIFo/NUsOqHQBhOvKWQ63JZ1FyHBdM0S0tOJoR4nLf6hR2FEMulgizKNh8jWs8sfkupw
 Fkt+7CLVR7kehesCPNiqBv9DfQ44xdO8SX1xaaFP3V7RJVoYFb7xrL9lxY/kGbOcopDBcFdyO27
 8pceGDSXFqzsNwtH6tJs00SqsYSaREzwSXCTEFgzPHkp+VtnNDysAZwYzDztmGVzaiVjLik1flW
 f9cSUYjPoikXJWlTx3Q==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c80c5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=rOHUGBc37_MNbdIC:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=HYvq9ckTOeKvRyG_iYoA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0OCBTYWx0ZWRfXz99DxxskMCii
 UpZGrWitGKlwtHvomFMAp/9pn4ho1WfkN4uzR0AgLg0Wz3SqExGCEi0DA0suE7B32szviTwFjwR
 JnShB/4XWXhXfTlIGdZTrdjJ/agry5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240148
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

Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>

On 8/11/26 10:46 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Enabling a PCI function that is already configured will result in an error.
> Simply check if the device has already been enabled, and if so, return
> without doing anything further; otherwise, enable it as usual.
> 
> Also, because enable_pci_function() prints its own message, let's remove
> the duplicate message emitted during the virtio PCI setup steps.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/clp.c        | 4 ++++
>  pc-bios/s390-ccw/virtio-pci.c | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
> index ca9565d8de..7917f13345 100644
> --- a/pc-bios/s390-ccw/clp.c
> +++ b/pc-bios/s390-ccw/clp.c
> @@ -82,6 +82,10 @@ int enable_pci_function(uint32_t *fhandle)
>  {
>      ClpReqRspSetPci rrb;
>  
> +    if (*fhandle & CLP_FHLIST_MASK_CONFIG) {
> +        return 0;   /* already enabled */
> +    }
> +
>      rrb.request.hdr.len = sizeof(ClpReqSetPci);
>      rrb.request.hdr.cmd = 0x05;
>      rrb.request.fh = *fhandle;
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> index f501252c81..231ab6e04d 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -452,7 +452,6 @@ int virtio_pci_setup_device(void)
>      VDev *vdev = virtio_get_device();
>  
>      if (enable_pci_function(&vdev->pci_fh)) {
> -        puts("Failed to enable PCI function");
>          return -ENODEV;
>      }
>  


