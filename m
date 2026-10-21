Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5348606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=doP7MSSN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJeb8-000512-1p; Wed, 21 Oct 2026 18:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xJeb1-0004zj-Bw; Wed, 21 Oct 2026 18:15:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xJeaz-0007W0-O0; Wed, 21 Oct 2026 18:15:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKiiwL2218303; Wed, 21 Oct 2026 22:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XubFuf
 74jTvmJrcjKfPOinuj9YWCQJbzjEajQGNj2UI=; b=doP7MSSNniuRKHZqFBRfAy
 ZgehkY5XwJMAJDlXc8MNaCpcZlQLL3/TTfSxcSFvIsRrr4+TK4dv5WP1JyT6pXkq
 KK2ViMr/bUIWBFijTcBxSDsHH5HVpW7srVb/nXTcXqNENNAh03VpqpY5OOZVgKPu
 IuAV0YU9ZYs8Mr26P29aLAOctlNYHCDxoTLR9+pvviWGucOIG+vlxJfmKRwlckuz
 JVAps2v0Giw2/4hWOsnRN+66ub619eIwKJ39YRo55nfDMD3k2y48szHA6uSpKkHr
 ur7MdzJyYk8a9sS2CS9UKayLguFXaGcjPoneo7PxG8QvxPShAiI9LfaeVECz3fGw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a3g76-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 22:15:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKo1ix3616366; Wed, 21 Oct 2026 22:15:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs7d09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 22:15:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69LMFZx59896532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2026 22:15:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D31B858059;
 Wed, 21 Oct 2026 22:15:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49A8258065;
 Wed, 21 Oct 2026 22:15:35 +0000 (GMT)
Received: from [9.61.29.21] (unknown [9.61.29.21])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Oct 2026 22:15:35 +0000 (GMT)
Message-ID: <9d56879b-641d-46f2-a68f-00815d7b597f@linux.ibm.com>
Date: Wed, 21 Oct 2026 18:15:34 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: reclaim DMA slots upon IOMMU disable
To: Omar Elghoul <oelghoul@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, cam@linux.ibm.com, farman@linux.ibm.com,
 qemu-stable@nongnu.org
References: <20261021175031.23840-1-oelghoul@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261021175031.23840-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4OCBTYWx0ZWRfX3YnRpuIQEcIk
 Ui7gGBbZUEI1jNpI3N4U5ToohCldqpFG2nqf2vq+MECb1rzaz3Dt7R+4NJmqoZKI7ozB3AP1iRT
 SkpLhrRNfheM/BtYwn0bU9M5jl3ssO+l+7XTxa0yUntKwS/uwf9KJglYKQRbg4yrGCu/3vmVKYz
 yJTMaSgQPxaqsMF89TBCnere9iFfSpccLKqUuuy9bIKIt+vf/ZmZypaBAoabMz9/Rk8nLe/zVj7
 p2X6707E+lb1nY22cna0g8zxRObAQQgBZrvWDbWBRIeZmYB9Ke3CJupKSt2+jhYiU0kRYMCNg0F
 QP6nmj59+jt/W0RO/eKkFitYomhwpVRYVDVV+N1sWEjGLZVUTkLPAKsV+ZoagzhQsGs0bChfVeB
 JsxfZB7UjVspfAnIQFvDbtie50kAAc2CMT0nkL3/73v0q0d5IsG/x0AcSUHrHnn7NqSdursRAh/
 RYwyw4wB3uPR+Aokdeg==
X-Proofpoint-ORIG-GUID: HgCHcL2_p4WIFEBMKPPMst1ZLlgw1VOZ
X-Proofpoint-GUID: HgCHcL2_p4WIFEBMKPPMst1ZLlgw1VOZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4OCBTYWx0ZWRfXxUOFVA7CGIve
 o8nT/Kt64N52Xl3qM7UBHQ094P/lkgeS4713TVrtxWQLHTxafQtt+OMVJKPCfkZXI/0sOOzbMjW
 Y8F9DekiWVilSr57n/hmJ3x/z7LOUVM=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad93989 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=iqqYe-VzZC4VjoPhcDAA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210088
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 1:50 PM, Omar Elghoul wrote:
> s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
> mappings, but it doesn't account for reclaiming the freed DMA slots.
> This is problematic when an IOMMU is disabled and re-enabled while
> reusing the container (e.g. during a guest reboot), which may cause the
> RPCIT path to fail with DMA slots exhaustion errors, manifesting as
> unexplained ENOMEMs in the guest.
> 
> Fix it by reclaiming all the entries in the I/O TLB's hash table before
> removing all its entries. The actual DMA slots consumed by the IOMMU are
> already relinquished to vfio when the memory subregion is deleted in the
> same function.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

Thanks Omar, I like this alot better for a fix!  It is minimal and
accounts for exactly what was not getting reclaimed.

This approach does lose the re-validation with the vfio-reported value
as compared to your prior approach, which might be handy for detecting
any other leaks in the future; but that is something we could consider
adding as a non-fix add-on later.

Thanks,
Matt

> ---
>  hw/s390x/s390-pci-bus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 2724b27ec2..cdd75cdfd2 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -826,6 +826,14 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
>  {
>      S390PCIIOMMU *iommu = pbdev->iommu;
>      pbdev->iommu_enabled = false;
> +    if (pbdev->dma_limit) {
> +        /*
> +         * Account for all the DMA mappings still in the IOTLB; they will be
> +         * returned to vfio when we delete the memory subregion via
> +         * memory_region_del_subregion() below.
> +         */
> +        pbdev->dma_limit->avail += g_hash_table_size(pbdev->iotlb);
> +    }
>      g_hash_table_remove_all(pbdev->iotlb);
>      if (pbdev->dm_mr) {
>          memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);


