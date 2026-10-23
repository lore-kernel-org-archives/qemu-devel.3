Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6C606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c8icEMWW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKE5m-0002Rb-Gh; Fri, 23 Oct 2026 08:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xKE5a-0002Q3-2G; Fri, 23 Oct 2026 08:09:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xKE5X-0001kG-9q; Fri, 23 Oct 2026 08:09:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAEAkJ2540637; Fri, 23 Oct 2026 12:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=CkthtDR6Mzvv3tLWGZyNRt/lohCzi2
 +29OxOpufvioA=; b=c8icEMWWLiakZkNCVmWDv/NQJwlWOCjqxcr00qvNObYQQu
 xNQi4dgb4y4/CvdGqaBGaCL1d/7A8O2swm4I8X7aWCCKR8kOTksQUQObnaCnMfwV
 zNhNz/b8baHQcDn+jYcqpS/3RG/VImFD4h1c+dpXLjc2TdDW0Yd4AiwWf0yZ37X0
 7zjUpeDpHF0bY6w85i9lqJVlW3lNthOzjA3zD/QE06K5qhDgqLhNu37sg6GMuNvp
 Zmaqw4djEnoS3ImgXQv4yDyJFfzHfFDbSN/A144+MQoh/lH2km20afgeV89uOB3D
 r0cRofp/GfJd6GNzFEqy/SE7qWzyB/zbdESYQBow==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b4efa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 12:09:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAJtJ31966984; Fri, 23 Oct 2026 12:09:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x50ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 12:09:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NC9MpA37552480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 12:09:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7107220043;
 Fri, 23 Oct 2026 12:09:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63F5620040;
 Fri, 23 Oct 2026 12:09:20 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown
 [9.124.219.235])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 23 Oct 2026 12:09:20 +0000 (GMT)
Date: Fri, 23 Oct 2026 17:39:17 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>
Subject: Re: [PATCH] spapr-vscsi: clamp adapter info DMA write length to
 struct size
Message-ID: <attOQdxcEkPMVTnP@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261007144434.374749-1-rathc@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007144434.374749-1-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb4e76 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=UhgCav3_mcCOemU-_X4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ExDbDfwGQU1BdNl4_GksUEoHEJHmpbHV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NSBTYWx0ZWRfX1HYPnlje7lPh
 Pia3KID5mebjG8j4fHeIkntTjSSIb3jv/fznBQhF283nsgb0FMdZOZbzzsoBXJWgPr4mrD7KddJ
 Biu4H0d84PIRAxotv0+0wiaOArZFtSKyWu0r0peIJYIs2Un6GAxAd9oG9XY5ww/yX/JDcDLLy1h
 UzEFUlrDQU78Jf7eL6KfcQ5/OY3rHGvy1b8A2xPumRDoTLBroXtg9L1V+0vk298AT+wugCO7o4e
 ToyWe8RHzUowGq7NAEPva9njKe9RwKWIiNW7/lhg30EFekE0gq4TcXnHZi1oefKZyZwF/WITWDD
 8/NNxi8AgrHP7V7x9Ah9+6VvQ2Tc94qbG2LpAPkvK68bbqNeVD48Nj03rEfRxegMdnuK+KWw0Gb
 3EOoCEvBAZ9u0qhyeLKgG4kXTRIPtBhynf9qlcR/sr3PNq7fDqNZJ6k1FKxX9HxZ7EKG7F42ATv
 CIwM9wPeRTiiE3GVSqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NSBTYWx0ZWRfX1oXFZV4mrO7P
 hDP/QutEs+SoPqMFVF4QutCe9DLtFpoFKpjKY8z9yolm65t9XIiUwIPyVKvkWv1S8wNSDbFsPHt
 sUd/J1UzKOXmPyknFJ9Yb2xZLqRrAhU=
X-Proofpoint-GUID: ExDbDfwGQU1BdNl4_GksUEoHEJHmpbHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 07, 2026 at 08:14:30PM +0530, Chinmay Rath wrote:
> vscsi_send_adapter_info() used the guest-supplied common.length
> field directly as the size argument to spapr_vio_dma_write().
> Since common.length is controlled by the guest, a value larger
> than sizeof(struct mad_adapter_info_data) (148 bytes) caused
> dma_memory_write() to read past the end of the stack-allocated info
> struct, leaking arbitrary host stack contents into guest memory.
> 
> Fix this by clamping the write length to sizeof(info), then using
> spapr_vio_dma_set() to zero-fill any remaining bytes the guest
> requested beyond that size. This mirrors the existing pattern in
> vscsi_send_capabilities().
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
> Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  hw/scsi/spapr_vscsi.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index b4c8f94d22..7ec780da79 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -966,6 +966,8 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi_req *req)
>  {
>      struct viosrp_adapter_info *sinfo;
>      struct mad_adapter_info_data info;
> +    uint16_t len, req_len;
> +    uint64_t buffer;
>      int rc;
>  
>      sinfo = &req_iu(req)->mad.adapter_info;
> @@ -985,11 +987,23 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi_req *req)
>      info.os_type = cpu_to_be32(2);
>      info.port_max_txu[0] = cpu_to_be32(VSCSI_MAX_SECTORS << 9);
>  
> -    rc = spapr_vio_dma_write(&s->vdev, be64_to_cpu(sinfo->buffer),
> -                             &info, be16_to_cpu(sinfo->common.length));
> +    req_len = len = be16_to_cpu(sinfo->common.length);
> +    buffer = be64_to_cpu(sinfo->buffer);
> +    if (len > sizeof(info)) {
> +        fprintf(stderr, "vscsi_send_adapter_info: adapter info size mismatch !\n");
> +        /*
> +         * Just read and populate the structure that is known.
> +         * Zero rest of the structure.
> +         */
> +        len = sizeof(info);
> +    }
> +    rc = spapr_vio_dma_write(&s->vdev, buffer, &info, len);
>      if (rc)  {
>          fprintf(stderr, "vscsi_send_adapter_info: DMA write failure !\n");
>      }
> +    if (req_len > len) {
> +        spapr_vio_dma_set(&s->vdev, (buffer + len), 0, (req_len - len));
> +    }
>  
>      sinfo->common.status = rc ? cpu_to_be32(1) : 0;


Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>


