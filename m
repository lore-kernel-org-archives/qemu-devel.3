Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BFAC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3TU-0004wO-Fi; Thu, 06 Feb 2025 10:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tg3TQ-0004u2-3O
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:07:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tg3TO-0008G7-F9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:07:23 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516ESKiW020846;
 Thu, 6 Feb 2025 15:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gi5PSf
 OFKapwHlcPVN+fLgIcAmdNWSdW1jxURSZtMPI=; b=VLLBHDX9haf8k8jAJv1IgF
 9Y4DIxXU7QqSXF+B9ssJcJP+cZvVqxatHk8/+Pi07BTJR7RUArbE+kM8VYlblnzm
 gJek5cW6OiZ8Vtjij14Kjnt16t7UYPGvjo2IcUTUERX9pH9TnjfB+6mruyP4k3Td
 vkeqRM9qoXrjwpAbol11mY6zr6n5iQWcswjX3wqcR6NtU/3mjyxlfzL14pD32awU
 9Iythlq6HBZiWCC3BROvAtWu7t/2hgpxQteEQ9lEniH92mBt2/Bi1R9VJCYXes5w
 XcRw8S099cH7y+JAbk9731jMJuV1/IwjDeNN7+IMfXI9uAQMLnGLBcTEqbY8jmAA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44matte8nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2025 15:07:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 516BbHjm024492;
 Thu, 6 Feb 2025 15:07:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxnewww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2025 15:07:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 516F7Ifc32375408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2025 15:07:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5ABD5805D;
 Thu,  6 Feb 2025 15:07:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B095158052;
 Thu,  6 Feb 2025 15:07:16 +0000 (GMT)
Received: from [9.124.218.154] (unknown [9.124.218.154])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Feb 2025 15:07:16 +0000 (GMT)
Message-ID: <861e43f2-aac5-457d-bb11-bb6fe1f44dec@linux.ibm.com>
Date: Thu, 6 Feb 2025 20:37:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] vfio: Remove superfluous error report in
 vfio_listener_region_add()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
References: <20250206131438.1505542-1-clg@redhat.com>
 <20250206131438.1505542-8-clg@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250206131438.1505542-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UlAh9dgs0lmTa1hvKPX2c-Xq25NhbGCs
X-Proofpoint-ORIG-GUID: UlAh9dgs0lmTa1hvKPX2c-Xq25NhbGCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/6/25 18:44, Cédric Le Goater wrote:
> For pseries machines, commit 567b5b309abe ("vfio/pci: Relax DMA map
> errors for MMIO regions") introduced 2 error reports to notify the
> user of MMIO mapping errors. Consolidate both code paths under one.
> 
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4fca4c6166f761acceb7b57b52e379603ea53876..abbdc56b6dbb5eed22e7a2d2d55ee5695279661e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -594,8 +594,9 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           return;
>       }
>   
> +    /* PPC64/pseries machine only */
>       if (!vfio_container_add_section_window(bcontainer, section, &err)) {
> -        goto fail;
> +        goto mmio_dma_error;
>       }
>   
>       memory_region_ref(section->mr);
> @@ -680,6 +681,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                      "0x%"HWADDR_PRIx", %p) = %d (%s)",
>                      bcontainer, iova, int128_get64(llsize), vaddr, ret,
>                      strerror(-ret));
> +    mmio_dma_error:
>           if (memory_region_is_ram_device(section->mr)) {
>               /* Allow unexpected mappings not to be fatal for RAM devices */
>               VFIODevice *vbasedev =
> @@ -694,11 +696,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
>       return;
>   
>   fail:
> -    if (memory_region_is_ram_device(section->mr)) {
> -        error_reportf_err(err, "PCI p2p may not work: ");

Not sure if this specific error msg was intended for a specific case, 
but since both ifs check for same condition before returning with error, 
looks logically same.

Shiva, any concerns here from vfio perspective?

Otherwise,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> -        return;
> -    }
> -
>       if (!bcontainer->initialized) {
>           /*
>            * At machine init time or when the device is attached to the
> @@ -806,6 +803,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>   
>       memory_region_unref(section->mr);
>   
> +    /* PPC64/pseries machine only */
>       vfio_container_del_section_window(bcontainer, section);
>   }
>   

