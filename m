Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC58FC0352
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFw59-0001mt-CX; Thu, 23 Apr 2026 11:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFw53-0001gT-Kx; Thu, 23 Apr 2026 11:35:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFw51-0007t1-UG; Thu, 23 Apr 2026 11:35:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N80INA3657859; Thu, 23 Apr 2026 15:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vvZsAL
 8K2QSrnCvs7j/H8Pm+8gQN+MJUnDV2OT96XAU=; b=PVzzNy9yG8PYrSVaOSdzUZ
 YWCEVpHCKCNsmHfTChotYCr1xDT7Az4o7Ve6L4X7ifKnb1jAkMf+neBqYw5KRyfA
 7STzV0TWND9Ma4JEFX8zQxr/tJ9c77kIWjqckhVp5muoA6NvEesg9cia31oiVX4r
 bXEm2ujCUjThlL7/c9vBbb5/74EGKNlFDRJ+Jxru+dTwg50tRDTaxhBqmPeRr4sF
 rEcYi3V4AmkuU0h1GYRMQCNyLuY4pUzXBLJCUmlnX/zu/oxiBnD+BLa4lT16zZpY
 lvQzgqcFNxVuivLksD3VNMHYiJOx0kjZvsljSFmEcyJAlBulXraSWVTma7GyNTNw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7ru9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:34:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NF5RAe014813;
 Thu, 23 Apr 2026 15:34:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyq62a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:34:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NFYsvE26018404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:34:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3ABB20043;
 Thu, 23 Apr 2026 15:34:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 390BE20040;
 Thu, 23 Apr 2026 15:34:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 15:34:54 +0000 (GMT)
Message-ID: <58b470c7-c648-491a-9b6e-92d2db6d4224@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/s390x: Have MSA helper pass a mmu_idx argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423135035.50126-1-philmd@linaro.org>
 <20260423135035.50126-8-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mrJgaxg1D-FybqzU9rXq3VCDcNFuL580
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69ea3c23 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=unCzzG8B7r6fckoFZIAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mrJgaxg1D-FybqzU9rXq3VCDcNFuL580
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1MyBTYWx0ZWRfXzzOp29B+NWBE
 5JdfEzlyIDTvZ5mX8toJhePz2iO1X1GBFOBpxs65vEPpi+cNiuxbpGseDQxxu3s/ksi/j+1PHSR
 Ero+HiNdY82cMOgn3KVKd9/KdYaty4FUqh6GhxVb8qDOJ5bo2wd0+QLu8Vo+nxHhBJGJ2UOQE9O
 Yz4UAQYmq+vPFdJV32CxiG+NNcAfgo/wNOiL0nlNikPdxetd8+vLOIUlW2GzPQKrbgxqud/MN2A
 1wVjvbMZ+lsJMHKk8d9FHyNS5MkhASogyTsm0IRPOfeoh72UhPgkvwNtOHYwnDX0cLcuQ1jYQMS
 S4t6HaUvQG4llRCb0/pRBDPD62fCyg7NK1m0SPUdWyqI7lKQ+vOre8Hxh3sY3Wxyk+ZQhiHiGCg
 OspB6Cs4SV/H/vCYm4vTDVpx/CK6DHyi51IRxZREb3SicaEciA9u2u7YVw2KhHV8OJwnNiO0Dov
 AV2shNkJG16QqhN5Fwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

On 4/23/26 14:50, Philippe Mathieu-Daudé wrote:
> Next commit will use the cpu_ld/st_mmu() API and thus
> will also use a @mmu_idx. In order to keep it simple to
> review, propate @mmu_idx in a preliminary step.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/crypto_helper.c | 41 +++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 19 deletions(-)


I was worrying that this might break bisectability with -Werror by 
causing unused function argument warnings, but for some reason this does 
not happen.


Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


