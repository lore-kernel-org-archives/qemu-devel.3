Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B62606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jNNXih9h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaWG-0000oT-5Q; Wed, 21 Oct 2026 13:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xJaWB-0000o6-CG; Wed, 21 Oct 2026 13:54:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xJaW9-00067P-PC; Wed, 21 Oct 2026 13:54:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFiDs61594255; Wed, 21 Oct 2026 17:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RKxptn
 TTMidd8+YejVuenqx57MJAH6UUQ63Z25WUABM=; b=jNNXih9hDf5H7pcNuAfch5
 tHl10NmuOyaatl6sowEWRvkqEMe/NpL8PfE6BrKW81GhBHW2/Wt6pcgFCD4xwjLG
 O8/2IfNf4O3i71xq158WF8aWLALlWsySdr2mEOuRjieb44w+rah14jclUGAXeqrY
 LdOJpfKQGTZoZtHvLk4+JwIB4gK55MIhoo32DcEnTiDf2tMZnTmCRJtSKfSFnPje
 4Ial2A0UcmfQK3FSL2QxOcphpM4o2k1nnTh9+K6d1nTIInZf1gcqXxq2Zidh6+0i
 z/V9+/5apjDHx/mm1jUeDzMMto5Pi1o2nznvNxzVDS8xEf6ue1+aREWt9y1AGC/A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a2caf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 17:54:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHooL32270317; Wed, 21 Oct 2026 17:54:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss47tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 17:54:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69LHsLpY12059150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2026 17:54:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83EB658061;
 Wed, 21 Oct 2026 17:54:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A209E58043;
 Wed, 21 Oct 2026 17:54:20 +0000 (GMT)
Received: from [9.61.252.137] (unknown [9.61.252.137])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 21 Oct 2026 17:54:20 +0000 (GMT)
Message-ID: <16706ed6-6233-41f0-8ec0-c168bcfcaf5d@linux.ibm.com>
Date: Wed, 21 Oct 2026 13:54:19 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: reclaim DMA slots upon IOMMU disable
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, cam@linux.ibm.com,
 farman@linux.ibm.com, qemu-stable@nongnu.org
References: <20261021175031.23840-1-oelghoul@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261021175031.23840-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX6iM+q/rkDIkN
 rHKuhNBdg0GqslpQYC7TFQjrMp/BUTFS+Oe5Aw0nIcfXHNvdgJDK5GoMv0KKMiTGtgCHjIZRlEH
 61VVHN9K5PSFM1nmCfUY1+Nq3SMGTzFLGinZ5gAuml5vSQglVwsc3Mh/NO7waE/KCid/mTbau2s
 3rxcGrBAf/FYdGuXEkfOgACy0OQPBvSSSubo7lLFPR1ZrN25UtOmmsVOhROHOrGMa4WdJ7y76kB
 qOQcf/IAw8yqobxU3vz6qmkvLnSRz4wW4Qb5giVz+deHDGXHF8E6owP6O4v5+8cElF+Eicv7NgP
 hxH7euWysJkdIJcxY0g/49usJ13PKLnHoV9Da2Tyq/fquuQlANwMtlVezEzSn0z92TA9hZVhvgn
 DVSYHgWa153otCcv8OzoarNBNlSe9MNxD55a0JJrUKvtrAF3rJMeJn8aIKSzbF3SvR7G6NfW9pf
 slXRrxZcxsSGGyhN3iw==
X-Proofpoint-ORIG-GUID: 271yEl-3UpC1IIw85yvaB_r1ClcTaVWD
X-Proofpoint-GUID: 271yEl-3UpC1IIw85yvaB_r1ClcTaVWD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX/WCh5L36rfxU
 kHxn66QJhTBoonrVvYvHA4cmssC0OJiscbD7qWw+v69Z00rli5E5eXPfAgEfsT7mjqXiRe7zxcw
 fj6nHiYqFzCpBPDLPL3MlFNSidKicvk=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad8fc4f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=Wh_gcl-PEBYzPn2ilxAA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210070
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
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
For context, this patch addresses the same issue as the patch linked
below [1], but after some internal discussion, it was decided that this
approach is safer than overwriting the container's max DMA limit and
current DMA usage every time an IOMMU gets disabled.

The reasoning is that multiple devices can, in theory at least, share
the same vfio container and IOMMU. This isn't true for zpci devices in
practice today, but the code is already built to handle that case.

[1] 
https://lore.kernel.org/all/20261019153729.40823-1-oelghoul@linux.ibm.com/


