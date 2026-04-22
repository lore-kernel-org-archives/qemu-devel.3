Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95857F94CC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 05:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFQEJ-0006jG-Va; Wed, 22 Apr 2026 01:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wFQEG-0006ib-2q; Wed, 22 Apr 2026 01:34:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wFQEE-0007aP-FM; Wed, 22 Apr 2026 01:34:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIlimv970279; Wed, 22 Apr 2026 05:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iZpY0n
 yQ2OVuODi7hSlR5YxsHLY4A5doJtW7z8Ad8qc=; b=pGy0xdbvBox1c7N19pmIa3
 aYdmsUWRSI7k4z0+xRYTaV23Ce6LqOKCGupSAuqm+crJV/e6vHmFn52TcJRgu1ST
 Iam81xePPr+Tc0SIwqJcx8JhjaHuJlQDmOch0IWmdZTpGFNyZL+FJUQ//WR7zr0c
 7hWsnGXeQcaRp+Y/CSbOgzwPoc64GFWiVa6pJScsmVbn9KJavmXrU2SRw6ayT3rJ
 6KdmuVlEOJ0tY7Ed4cCG8cvgKJuyLm47s6tiP67A5E9dlWd6Yu9G4ZxCowHqtyCQ
 6zGft4O0fhw5NCPprMq52xyyHMAFQmuzizco8e0fUimMi+3MeB239iloUbBsTFnw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3hpdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 05:34:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63M5KOhl024819;
 Wed, 22 Apr 2026 05:34:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkygxch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 05:34:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63M5YBoq3670718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 05:34:11 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 204CD58059;
 Wed, 22 Apr 2026 05:34:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EEDE58043;
 Wed, 22 Apr 2026 05:34:07 +0000 (GMT)
Received: from [9.124.218.220] (unknown [9.124.218.220])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Apr 2026 05:34:07 +0000 (GMT)
Message-ID: <65a09509-d8f4-4248-8a9f-911a773ae675@linux.ibm.com>
Date: Wed, 22 Apr 2026 11:04:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] target/ppc: Forbid to use legacy ldst_phys() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _r6D6lo5ruYDl3fMTv4x3hqzj1wwnk2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1MSBTYWx0ZWRfX2SaXh2wVlyge
 yDbeACvJIGY2gnOdjvKDdTTu3GYN7f1da5moZr4lvNSYJWqmCv4tn1GXE0LN0Ch21KHbDNd7ZGZ
 ixRUjDDEZr4JGs7DxaiUE9uBdr0fpKk1xV4hV7Trh9SfbEVLA272EmacbEbQqpVA1inMcBh4vrp
 BQ1ptVrguO2EVg/tiHZnS+inJTPSRtXMimIr5PcFB5Q5cgK7P82I30ewKeNcl6p/SMNhzKDdnn0
 KqCmXGeh78osX5/ER8YWLfPRxp9eu1l8X51j0TZW+3gJJSExnUv7X0DU1g6RpXtLJetWni2hn44
 DJBiZA4rJAvuoVfxAUPhmHoYPrWOL1+LK9eLDTaLIryyyeLv1KMtsv3uzNjWDC44VaobMmgjG8y
 uneKhlunr0JSvkC2GRzZUtOt8gDiPcUdEuHE5ZkYZ6O4wXp2sD803Bxj3Dxl7K9jQyOT4VhnhtC
 F7rl0Y5qCzM31g59iIQ==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e85dd5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Z_4kFmmcfVntF39L71EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lj9arOlVpmH88Gt3iEWMOzcnkcx_hWhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220051
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 3/19/26 16:49, Philippe Mathieu-Daudé wrote:
> Replace legacy ld/st_phys() by address_space_ld/st()
> then lock the target again further legacy API uses.
>
> Philippe Mathieu-Daudé (8):
>    hw/ppc/spapr: Un-inline rtas_load/store() helpers
>    target/ppc: Factor common ppc_load_epr() helper out
>    target/ppc/mmu: Remove unused hash32_store_hpte() helpers
>    target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
>    target/ppc/mmu: Replace legacy ld/st_phys() -> address_space_ld/st()
>    hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
>    hw/ppc/pegasos: Replace legacy ld/st_phys() -> address_space_ld/st()
>    configs/targets: Restrict the legacy ldst_phys() API on PPC
>
>   configs/targets/ppc-softmmu.mak |  1 +
>   include/hw/ppc/spapr.h          | 18 ++-------
>   target/ppc/cpu.h                |  2 +
>   target/ppc/mmu-hash32.h         | 32 ----------------
>   hw/ppc/pegasos.c                | 67 +++++++++++++++++++--------------
>   hw/ppc/spapr_rtas.c             | 15 ++++++++
>   target/ppc/cpu.c                |  9 +++++
>   target/ppc/excp_helper.c        |  3 +-
>   target/ppc/kvm.c                |  2 +-
>   target/ppc/mmu-hash32.c         | 24 +++++++++++-
>   10 files changed, 93 insertions(+), 80 deletions(-)
LGTM.
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>

