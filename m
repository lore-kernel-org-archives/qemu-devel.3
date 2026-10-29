Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E9606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m+wUMarF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUMx-00015L-7J; Thu, 29 Oct 2026 13:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xMUMY-0000M9-9q; Thu, 29 Oct 2026 13:56:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xMUMV-0005I1-GT; Thu, 29 Oct 2026 13:56:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGE84J3038868; Thu, 29 Oct 2026 17:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=t7PYv9
 QF15ogBDpR9p/sDNZ7atInld+ttzZJt+JK2/U=; b=m+wUMarFp14eK3DxVsIJpZ
 PwitJDH1QAKBu8i0MXEDINcYBVz8BiCy0Q1W/9x9xW0fnVsVcCnrM+L1LymkSAiI
 WnHgyeyOjwjvg/htyNv5J9JDQeplDwwPOShzivZjiLfMXxIqZpFwntBsxCGzUt4Y
 SEF10ex3/rxyOcENwpXgUO7rljYB52Mq9tscAZOhPvfYJuuqx9LLFqos2f/kiVXN
 GZ0lT8EcPMatVaatFy7zkfLxWc4wBa/8bDSSekQuZcI+L2gX5MKgon2YuHc4g39Q
 MJTKDQIhOCNr4hWwyfu7Xwje4LPWKorpUEViyWr4zkp01fBEHNVE/+bA58rSr4Gw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbtbxmu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:56:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGxAhb3486989; Thu, 29 Oct 2026 17:56:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hma5408r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:56:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THuN8g31261366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:56:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 184F558054;
 Thu, 29 Oct 2026 17:56:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D5B458050;
 Thu, 29 Oct 2026 17:56:22 +0000 (GMT)
Received: from [9.61.36.128] (unknown [9.61.36.128])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:56:22 +0000 (GMT)
Message-ID: <956ae61c-281e-44c4-87ed-7a1cdfc70297@linux.ibm.com>
Date: Thu, 29 Oct 2026 13:56:21 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] s390x/pci: Change reset method from legacy to
 resettable exit
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, oelghoul@linux.ibm.com,
 qemu-stable@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261028224611.240515-1-alifm@linux.ibm.com>
 <20261028224611.240515-2-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261028224611.240515-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXxpxYVhwQAEq3
 eyvmaU165xbFPPmupJuwGM+OOjkuE7i5Il4En6i/AhKTUz7kAIjTUCKbxcSqrQSYes0tUUlb7YP
 AvfBltsa2ft4EerYCGoN7XvThBDNs1hXb+lQTDmjZTdmTdLF5bgWDw8k3ZKgNBfJoiy+sMO/8/x
 bSthdCwoCfFrsYoj/2Z3QL7MJc19dVnfrLODuLNI2VVo+1v3w+TUm4gcEzavKANz8Z4yZbrZ3mB
 TlzV6bxkpxbQblAg0j7jhFfcmiMJ6EaiZ5tHZKaVIvINVjW9gPKhI7qftSqaZaJihYTArz4HyKA
 woMtMkObfCz/ex8eMfAY7fiMXnwV05RPDeFP0sRgs8ywD+ARNfP7vZrTg5VZ8VLPCVBSecr3bil
 e7ehBBf6H+o0NK5ZR1GsUxRRtf3pO3VeLVu6S1VoiIA6HGapMTgIk67ptgPBOe+XH06JHSm5KFB
 CI3gEEsqJzLerQefMzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX2PzHXP5YEhWB
 PsZGmKn2KvyOgmoxbTikhDoQcQTDmb0/UIMF6s3KdiybCabXN26v0d7pF0ed5JLhPq4atXnkIU8
 Q6xNcco3b8hbIwzYWUXfP2gxahj7Wgc=
X-Proofpoint-ORIG-GUID: 5uh3KIk4goRpMqAvC2lRgptBJGqdLHV1
X-Proofpoint-GUID: 5uh3KIk4goRpMqAvC2lRgptBJGqdLHV1
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae388c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=dxUtY4db0SHtNY8ba_oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/28/26 6:46 PM, Farhan Ali wrote:
> On subsystem reset of the s390 PCI host bridge (TYPE_S390_PCI_HOST_BRIDGE),
> child buses S390PCIBus and PCIBus are reset in order. Because S390PCIBus
> devices are reset first via the legacy reset hook, IOMMU mappings are torn
> down before the PCI device itself is reset. For a PCI passthrough device
> this opens a window where the device may issue DMA to addresses that no
> longer have valid IOMMU mappings, causing an error (PEC 0x7) on the host.
> 
> The QEMU reset documentation (docs/devel/reset.rst) specifies that IOMMUs
> should perform teardown in the resettable 'exit' phase, after all devices
> have completed their 'hold' phase. Move the S390PCIBusDevice reset logic
> from the legacy reset hook to the resettable exit phase to close this
> window.
> 
> Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



