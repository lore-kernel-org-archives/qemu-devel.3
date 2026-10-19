Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83754606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OFKaeckk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIssU-0006SI-2a; Mon, 19 Oct 2026 15:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xIssO-0006Qt-80; Mon, 19 Oct 2026 15:18:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xIssM-0002Fp-DN; Mon, 19 Oct 2026 15:18:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJEDPC437936; Mon, 19 Oct 2026 19:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9zxF5A
 56aRcgaq/agghsJLdN3V/LUdMS/l+r8zs+0nU=; b=OFKaeckkjr2A7pb9REZDzg
 d4DNjEf0sJCRX5TLyjIBlFz31lpq0kY/DLzZMvAmvDvA8ujKqrCQ2qz7aWwCFPfP
 LSU2lp3zOWN8t560opLNmP7Z4A0IitnGDfRw6big3rYB864epiNa25EPUzvCDJGX
 G9vmy1Au7aoXuTZNwy537wo+XTDM4EBv+DLgB98Sia1fY2MbBpancYZqbQQCTbhT
 xC3C/Uvak7Goj1v1iPOPbQaLl/ZyYFFF2oL9uyn5Eos8L7MqwNl+5bMqsA1S9Qs2
 a+3n08CMZhZd8bQq4LwMKIs5rHwFBG3YJYlYORcGlTtoc4cgIrVrhOlv0WqfpQMA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7n5ra-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 19:18:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJ7EuJ3365157; Mon, 19 Oct 2026 19:18:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgxy6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 19:18:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JJHWPm2949814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 19:17:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AE4D58052;
 Mon, 19 Oct 2026 19:18:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14C0258056;
 Mon, 19 Oct 2026 19:18:17 +0000 (GMT)
Received: from [9.61.29.21] (unknown [9.61.29.21])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 19:18:16 +0000 (GMT)
Message-ID: <5e9b8aa7-c157-43cd-99b1-7afecda27cd1@linux.ibm.com>
Date: Mon, 19 Oct 2026 15:18:15 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x/pci: re-fetch DMA slot shadow count from VFIO
 upon IOMMU disable
To: Omar Elghoul <oelghoul@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, cam@linux.ibm.com, farman@linux.ibm.com,
 qemu-stable@nongnu.org
References: <20261019153729.40823-1-oelghoul@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261019153729.40823-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfX2SytS7lbwNTA
 XJ/+tRvaPXhRazZ3H3FYwlgafS/O6vMbfd2Iy3fHrLaVdXHOglvTekV0CzN+DcJClXVJyT8LmZw
 lNKSfUqjTaEEQSBWfmFKmdLQHNFjROE=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad66cfd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=hu6-uX0OaFMob9n2U04A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfX6drd3ugF+wBU
 cBsw4FiWZfgu+DD//1px7vw0JX+o+vlNQkjwsoffOy89uF799NkKmqWAHhKANLxp+3ANO4JFEj+
 r6EX4wQSOpSP43UgEFb6SsnbxMGTA/1jCkvDBgS6meRy97X6nkR/BEaihyhBPam/NrubxsHJXOJ
 MDIAbLrnQfdBSc9jmhHHxXadsCizRRjnyUSclPsoZ7kA1Q32YdGd4UbRtgN/LAN4b1qRqDVLbMo
 wOX7VzI6yuWo9Qknf2MuU5YFp10dXqxZ2yZbOvwDUh+D+rlkRoFFqZrwIcT+bfupEPsNlCqIH/g
 ZLidTlyiWRo/bNQngZde6geQ3E/OYbH+1LONh5N4Ufg/qUm5qXLFKVzvce8qvtB8MVtg8Xbz1Rb
 je2GqMG9+z0Y1VWeYdAFsHej0K4pT3KkoalxlNA0u3twBQDg9T6Xn2jDrNlKWWjGvcFwpxmMXEz
 DTaoi95hOks9o/UtvgQ==
X-Proofpoint-GUID: ysYGVDXwcd60EjnZ9-klDJK1dEIR-sdP
X-Proofpoint-ORIG-GUID: ysYGVDXwcd60EjnZ9-klDJK1dEIR-sdP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190076
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

On 10/19/26 11:37 AM, Omar Elghoul wrote:
> s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
> mappings, but it doesn't reset the available DMA slot counter back to
> the VFIO-advertised limit. This is problematic when an IOMMU is disabled
> and re-enabled while reusing the container (e.g. during a guest reboot),
> which may cause the RPCIT path to fail with DMA slot exhaustion errors,
> manifesting as unexplained ENOMEMs in the guest.
> 
> Fix it by refactoring s390_pci_update_dma_avail() to take a pointer to
> S390PCIBusDevice instead of the plain file descriptor. Call it in
> s390_pci_iommu_disable() after the host mappings have been unpinned.
> 
> Further print a warning if the VFIO-advertised counter doesn't match the
> in-use shadow counter, to reduce the likelihood of introducing new

Maybe something like 'doesn't match the previously-stashed limit' ?

> similar DMA accounting bugs in the future.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
> v1 -> v2: rebase on latest master, ensure that the device is a vfio-pci
> device before calling vfio-specific code.
> ---
>  hw/s390x/s390-pci-bus.c          | 21 +++++++++++++++++++++
>  hw/s390x/s390-pci-vfio-stubs.c   |  2 +-
>  hw/s390x/s390-pci-vfio.c         | 18 ++++++++++++------
>  include/hw/s390x/s390-pci-vfio.h |  2 +-
>  4 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 2724b27ec2..9938191c4d 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -825,6 +825,8 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
>  void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
>  {
>      S390PCIIOMMU *iommu = pbdev->iommu;
> +    unsigned int dma_avail;
> +
>      pbdev->iommu_enabled = false;
>      g_hash_table_remove_all(pbdev->iotlb);
>      if (pbdev->dm_mr) {
> @@ -837,6 +839,25 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
>                                      MEMORY_REGION(&pbdev->iommu_mr));
>          object_unparent(OBJECT(&pbdev->iommu_mr));
>      }
> +
> +    /*
> +     * update shadow counter from vfio after having unpinned all host mappings.
> +     * if this value mismatches our previous shadow count, then we likely have
> +     * DMA remapping, unmapping, or accounting bugs

comment nit: This is related to the commit message -- we aren't looking
at the previous shadow count here (dma_limit->avail) but rather at the
previously stashed limit (max_dma_limit) to make sure the vfio count got
back to the value we expected.

> +     */
> +    if (object_dynamic_cast(OBJECT(pbdev->pdev), "vfio-pci")) {

Could you just check for if (pbev->dma_avail) here?

We should only have that if s390_pci_start_dma_count() was called
successfully, and that should only happen for a vfio-pci device.

> +        if (s390_pci_update_dma_avail(pbdev, &dma_avail)) {
> +            if (pbdev->max_dma_limit != dma_avail) {
> +                warn_report("DMA limit %u from vfio != %" PRIu64 " shadowed",
> +                            dma_avail, pbdev->max_dma_limit);
> +                pbdev->max_dma_limit = dma_avail;
> +            }
> +
> +            if (pbdev->dma_limit) {

Then you also don't need this check.

> +                pbdev->dma_limit->avail = dma_avail;
> +            }
> +        }
> +    }
>  }

