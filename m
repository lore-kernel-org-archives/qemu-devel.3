Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E07C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTKn-0004tQ-JY; Thu, 16 Jul 2026 17:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTKl-0004rm-TP; Thu, 16 Jul 2026 17:09:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTKk-0002By-GT; Thu, 16 Jul 2026 17:09:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GKC25S2320899; Thu, 16 Jul 2026 21:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vJ0mKd
 ld6YmmIAYUu4o2Z/agepx4kUjJitkaYzvyVPk=; b=rC+2N/aUW2maF5QtJJR+IB
 /nX4PGCp1hhqHhrYyr/vTZZMS8QgFEtL+ROknl1FT82JjKTmE2sGoveTtM8tmNrw
 6aThhIlwk2xOd68OG5F5AsIZ+rBAwYn4RqoJT07JC3hKvTHXDved6KB79JHjEVqy
 FHJGx3iJfVP1RIPNgjk2CcI+GmbAzWetOrlwzPwieHVOIZM651NMAKU4ZrYaAnrS
 Ak2+piLWULlmtMKl9akNFvkQq4WO1sTVxVyPJtmfVdW41eP+9NSxGpavnChaLGTu
 oH3o3km+KjyNrEehDiOG+p/hK9mYKyfAftBHGHK96tlJnXSvabzLMsi5YOFlBc0A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33kn8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:09:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GL4g6b004455;
 Thu, 16 Jul 2026 21:09:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhpsh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:09:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GL9NdP49479980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 21:09:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B528720043;
 Thu, 16 Jul 2026 21:09:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63AC220040;
 Thu, 16 Jul 2026 21:09:23 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.65.221])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 21:09:23 +0000 (GMT)
Message-ID: <bfa8082a-ca32-485c-881c-b0c417367916@linux.ibm.com>
Date: Thu, 16 Jul 2026 23:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/51] cpu-common: Validate flags in
 cpu_breakpoint_insert
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-24-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX5oyQqmrEdP0B
 ljHwpALlDDiifDeMjKQQ3oMfYdv6EBDW5H1II0KPuBij+u7AZFPYzFFyB4TUH0ZGy3bc+I7UPUn
 nXIOO6EWv0wY5AyE2gZE1yZSC7DEGvE=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a594887 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=WBp_s3Dhk2Tf1VEGzG4A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hyWC3ag3C4F8l5SHh8soROp2dJVNtzzq
X-Proofpoint-ORIG-GUID: adlZX0Vccwypbl6SGo3iyyl2kkkedLp7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX19ZnWcpeTYwZ
 HRloh4WQ5WtKMY+6QfvitjfZwIjvk0QXgzzeiYCFY2xjWHFrPcx1UGLs40xSEAKZgzx8Ty4jPhP
 754Xb2Nf05eIrpP32z3wUZQ46XF4k2LmNpNimUXA6AQuNuQ/4G9WZssNp4CB+vs9WuzCgkImdFO
 6eDk8/crMc0BAvroqFUActSQOSKzLB5YbwQMwUky5wX8mB9IU/Y/nHFmzWSr/3Lx4nPZcmncU7v
 Qx3Ho0TGD9+zAjJj00uGqNnTmi+2+HshslcXNCB+b63vmOKxXfKSerMMrmlnYEH19klEZbxy2Ey
 UbwKdg5F1+uHTl733JCOLoTH+uoWsKTai18oi54PyxqBDFz88wNTeVeqzZkscYl7rFqKWyXGFN5
 Cdn6Rdq/tGvbY/ETO8hcUYYTt6KyqLnbR7InHxJoL86dX+3Xdc2tYhVJD/yMAjslb1vNF1eP1Jz
 LWU3kDvAXoj+AmBBl8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160211
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/10/26 22:53, Richard Henderson wrote:
> Flags must specify GDB or CPU but not both.
> Flags must not contain extraneous bits.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   cpu-common.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


