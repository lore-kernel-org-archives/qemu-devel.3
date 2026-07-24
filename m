Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4191BC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 19:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnLIo-00072P-Qm; Fri, 24 Jul 2026 15:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wnLIn-00071u-Mv; Fri, 24 Jul 2026 15:11:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wnLIl-0006vW-EK; Fri, 24 Jul 2026 15:11:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OHC0c22451444; Fri, 24 Jul 2026 19:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yNgT/d
 7tNA5Y3QDr4JSHzQeT71xvXnK3a5vecMQXyB8=; b=Cchsz+g7OTpQLF0MbI6bww
 SOHtCwqLi5+mwfMsLst+alO7x0d9lkDWWwtNsKjBg0o47MgfphosdUYSTyvh7gSj
 OXy1usJaIRXroj1ovc0Mrb9FItsJyv1JJslVNauqvuPlrVyvjJPVDxc0wKzJdNru
 EiEm9AzQMruyUy6gWdOKdhjdH0oCThM+0gaP0t7+2ACQJy6OszvWUmSNRdx+9Cu7
 wgJKYKZqw9OvVrUnzT31VYBuhHTygA6Vd0+8aAWGUhoZgv2/tGlQGhzmFusFBZj3
 vvF4Led8tHeXP2QxMGmRh+Ig2TdRMVOVfHdbaYaNdWN++eomL4AXDqQVkCAWk59w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahnk0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:11:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OJ4iAs019586;
 Fri, 24 Jul 2026 19:11:14 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqjffg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:11:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66OJBD6f38142464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 19:11:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF18158056;
 Fri, 24 Jul 2026 19:11:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 399A558052;
 Fri, 24 Jul 2026 19:11:12 +0000 (GMT)
Received: from [9.61.253.58] (unknown [9.61.253.58])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 19:11:12 +0000 (GMT)
Message-ID: <5371d844-6483-4127-9f72-e5ebf1ccb95f@linux.ibm.com>
Date: Fri, 24 Jul 2026 12:11:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] s390x/pci: Create function to contain
 translation status check
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-3-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260724030919.123733-3-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VicYY7gAaEsBY8P-l0KRGtSwjLqLxyQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2OCBTYWx0ZWRfX4G3/jHL/KRFg
 efdctwYa05XXFDvUroNlCAkQ2uppl0L4EzBoLcLIgzyH0I+3SoN67IydUdFz3L3Se/EWLk+AjB5
 kcriuYCpiK9+MJUCNZ5RpNn9VdER1gGTIS/BBcWNEBJ1XNpoKp5sHb3W0UKvQhyqT5LDxUrwZms
 AMdfyX2tN4H+g8eZbpa116A6dCHWrwsVNCEJddMQ/BYvmKpn0c+gmhXDHW6dkfr7BXrxdcBSQrm
 Qm2wpptETDZskhgJf4cozYvwZuIq8cM2ArFy3spALUymqhd07lCNczvPHJcqXEV5LrX9FSYSh7e
 yXENM3v9CVVfTUG7T5Q5FUdld/+VcIxQq2Z3PMW6OR4XWHo4+DONhpbUhZyMlAopMPt0ysYRv5t
 JC97ATY7qley6FCVjbO/ed3rSQ57YPqFc/cAW4K9gvoWg7I6uI6PXHXCZFz9YmGbLbBRnJu9B0e
 xUnGXhrf+xiHNJKugeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2OCBTYWx0ZWRfX8H5LyWilcw5r
 GzQ/XAKOkWhdKVXprqOKURIZUG4UWrHh1+DoTaRxiVlpDMf30EZ/iPgF+jISJhXIXWKMFMQ6ctm
 VE5QvlSgcEVAK5hUswQO/UdNzH1zF6E=
X-Proofpoint-GUID: VicYY7gAaEsBY8P-l0KRGtSwjLqLxyQ_
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a63b8d3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=6gS5_8KeV3w0nlSca24A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240168
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 7/23/2026 8:09 PM, Konstantin Shkolnyy wrote:
> Make it more clear what the bit means, and the new function will be called
> from yet another place in the future.
>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c        | 7 ++++++-
>   include/hw/s390x/s390-pci-bus.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 37ca70dcf1..00a847f493 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -1021,6 +1021,11 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
>       return 0;
>   }
>   
> +bool s390_pci_is_translation_enabled(uint64_t g_iota)
> +{
> +    return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */
> +}
> +
>   static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>                       uintptr_t ra)
>   {
> @@ -1029,7 +1034,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>       uint64_t pal = ldq_be_p(&fib.pal);
>       uint64_t g_iota = ldq_be_p(&fib.iota);
>       uint8_t dt = (g_iota >> 2) & 0x7;
> -    uint8_t t = (g_iota >> 11) & 0x1;
> +    bool t = s390_pci_is_translation_enabled(g_iota);
>   
>       pba &= ~0xfff;
>       pal |= 0xfff;
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 9228523ce8..eb15cb8b2d 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -390,6 +390,7 @@ int pci_chsc_sei_nt2_get_event(void *res);
>   int pci_chsc_sei_nt2_have_event(void);
>   void s390_pci_sclp_configure(SCCB *sccb);
>   void s390_pci_sclp_deconfigure(SCCB *sccb);
> +bool s390_pci_is_translation_enabled(uint64_t g_iota);
>   void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
>   void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
>   void s390_pci_iommu_disable(S390PCIIOMMU *iommu);

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



