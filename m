Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABF606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZDqyf/Dt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1DS-0000R9-71; Thu, 22 Oct 2026 18:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xK1DH-0000Oa-PM; Thu, 22 Oct 2026 18:24:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xK1DF-00058l-Uk; Thu, 22 Oct 2026 18:24:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMEH6N1132252; Thu, 22 Oct 2026 22:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UkXMRb
 OUfuzFRQTZHESBF72ZdBcSy6ZZx32mam0ziBQ=; b=ZDqyf/DtiOsR5n2/QOO4q0
 FRCjVdLrHcoKpfwrt+ErBoWInvkPwg0HL54BaZYg5Uz+JGS+mpSSGTEGZXPjZMi9
 mswuligrC2N7Ye93E7TjWGNRU+0RVzVS/gIe/3KRZtaNWTHCqUBSRx2YX+SgdRq8
 XAXiZayIPbr9DPunmzK5C0j+bWSeg74h0sXyypehD8t4teDybbI3a+gK4rnQe0Kf
 tvH21KUyc/Lsy9+CMxRJh8iIGGnRuDjU0Tzo2oHRLa0UQB/0DA8jDVq4UBZ2tNOy
 oe4g5CYswkjvRMwGp1yvZso/yt/+ppQc6WUErvvDnPpnCzrhx6NmwtzniHUmVEXw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5ahvye-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 22:24:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMK63v4157008; Thu, 22 Oct 2026 22:24:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss9yb1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 22:24:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69MMOZCV6292102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2026 22:24:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27E405805A;
 Thu, 22 Oct 2026 22:24:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E90F58054;
 Thu, 22 Oct 2026 22:24:34 +0000 (GMT)
Received: from [9.61.29.21] (unknown [9.61.29.21])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Oct 2026 22:24:34 +0000 (GMT)
Message-ID: <6094c11d-dea0-4896-ac35-78b264ee0d08@linux.ibm.com>
Date: Thu, 22 Oct 2026 18:24:33 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/pci: Reset device before tearing down IOMMU
 mappings
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, oelghoul@linux.ibm.com,
 qemu-stable@nongnu.org
References: <20261022185829.11835-1-alifm@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261022185829.11835-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4OCBTYWx0ZWRfX5r17NHjoYGJ0
 779i++3z1SPknt6fAJX5aH6//u7/BUzSK3yB/vhaT/1xn3PECfRs87ftsnY9w/Zdu8oWLWvBpOV
 1sRkijQiuf6Q16jea4VeYu2J0KcqTeA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4OCBTYWx0ZWRfX3UKYQjdmJy57
 y3rj8Lzk+HWv7hKKJg78M03FZcwKyv/HWPgvvOtPQN7ytaiGVeBxpwGO5AeN7oV5NcdsxqTHBUb
 AKc0sSnjjPEyJEQa9hELoYB9g72t7YEj/gU0RIcGHy5fDA22zvrAxizUxxE0afXrO7BseZrHaIx
 rILWc20BuxwgSbfo0+Z6rEqistDZwRsZ+XspgWwmOU+GcEBYtAW4jqBP/pP5izsvmahDuiQzROC
 b71QVnm7gtcZ9vsXX+0V9p2AlKD/Ne2T+Ma99S0t5ssau02qVAdZSaKfK57uf5oic6NpXrs5qjI
 6eEJt6wmS79T7E2zW9gVkkC7kB0Gy9iKfufrfv/HXH7ikTAle2uAs+XnoiN7XJlI/0MfAbIam8V
 6tRwnpB9PcB8Qp4wBYWa6yC5Tw8Mfwpl1XO6tUZvPzTme0eHmE6MCExqbTFkFp2HcIc6fhfpJiQ
 D8H3b1+5tm1fVyX0bwg==
X-Proofpoint-GUID: YQ8iu2dmui0h499YldvUuJGgJ4QEksFw
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ada8d25 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=7-Xny0QU0bubpB26h7oA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: YQ8iu2dmui0h499YldvUuJGgJ4QEksFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220088
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

On 10/22/26 2:58 PM, Farhan Ali wrote:
> In s390_pci_device_reset(), IOMMU mappings are torn down without first
> resetting the device. For a PCI passthrough device this opens a window
> where the device may issue DMA to addresses that no longer have valid IOMMU
> mappings, causing an error (PEC 0x7) for the device on the host.
> 
> Fix this by calling pci_device_reset() before tearing down IOMMU mappings
> in the default case.  The dedicated ERROR-state case existed to issue
> that same reset before falling through, so it can now be removed.
> 
> Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

I spent some time discussing this with Farhan off-list and asked him to
explore a possible alternate solution.  To summarize:

While I believe this would fix the issue (by forcing the vfio-pci device
to be reset before the IOMMU is wiped), I wonder if we can do this more
cleanly by moving s390_pci_device_reset() from the legacy reset
interface to the multi-phase interface described in
docs/devel/reset.rst, and basically move all of s390_pci_device_reset(),
especially the IOMMU teardown, to the exit() call.

When the host bridge (TYPE_S390_PCI_HOST_BRIDGE) is reset during
subsystem_reset(), both the S390PCIBus and the PCIBus are reset. All
hold() handlers will complete before any exit() handler runs, so moving
pci_dereg_ioat() to exit() should guarantee that it runs after
vfio_pci_reset() has run in hold(), independent of the order of the two
buses on the bridge.

This should satisfy the following from reset.rst:
DMA capable devices are expected to cancel all outstanding DMA
operations during either 'enter' or 'hold' phases. IOMMUs are expected
to reset during the 'exit' phase and this sequencing makes sure no
outstanding DMA request will fault.

Thanks,
Matt

> ---
>  hw/s390x/s390-pci-bus.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 2724b27ec2..7182d97a33 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1786,22 +1786,8 @@ static void s390_pci_device_reset(DeviceState *dev)
>          return;
>      case ZPCI_FS_STANDBY:
>          break;
> -    case ZPCI_FS_ERROR:
> -        /*
> -         * Attempt a reset to recover the device. A device in ERROR state
> -         * can be transitioned to ENABLED or DISABLED state via guest
> -         * driven actions.  Since this code path is also executed on
> -         * subsystem_reset() and the expected state of a configured device
> -         * after subsystem_reset() is to be in a DISABLED state, we need to
> -         * transition from ERROR to DISABLED.
> -         *
> -         * Linux guests drive the state transition from ERROR to DISABLED
> -         * via CLP_SET_DISABLE_PCI_FN. So it should be safe to transition
> -         * from ERROR to DISABLED state.
> -         */
> -        pci_device_reset(pbdev->pdev);
> -        /* fallthrough */
>      default:
> +        pci_device_reset(pbdev->pdev);
>          pbdev->fh &= ~FH_MASK_ENABLE;
>          pbdev->state = ZPCI_FS_DISABLED;
>          break;


