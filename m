Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE77606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LG1MvEf9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIsY7-0000RG-2R; Mon, 19 Oct 2026 14:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xIsY0-0000Ig-2P; Mon, 19 Oct 2026 14:57:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xIsXy-0000NT-28; Mon, 19 Oct 2026 14:57:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFiDuB006395; Mon, 19 Oct 2026 18:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qe9DP5
 /3nchaY064Jf0Ws70Vv7QvB9hyr7OTuxG7yT0=; b=LG1MvEf9aTJ57zD4DRPZqJ
 tQ/JSUrJb/ehzTLW1PEdFt3FJq8tei7GNuvLTyMFaJrtHE2AVxdYF8Bw+CZ2OnhS
 QJZ7kl9TzjEd/v603gieaDdH6unDWc28apNGbAuZ5KZUYY7/ZqOg9yqRJUdqQDnD
 DTq7CtTx60LCiJzVPinGFbvgPOrJeCOog1CxMvylDP9PEJnjBP7LRHtOfEnqPVap
 /cFMpPqZI02PDDWc6ylJ/JFJSx1V+F5+dYFiaBTUNeckdzaBK7btYw0I5ZQjBO4y
 NcwkRrExfbh46ABVDbY+vuyeUJUr/OgigF3a4l/tcgG13h+zvSlfCA/dxi1lVXyQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7n2yg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 18:57:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ6Pq168450; Mon, 19 Oct 2026 18:57:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmugy096-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 18:57:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JIvCfW53018994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 18:57:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 298F42004E;
 Mon, 19 Oct 2026 18:57:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D44D2004D;
 Mon, 19 Oct 2026 18:57:11 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.79.27])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 18:57:11 +0000 (GMT)
Message-ID: <2be3455d-929e-46de-864c-09675ee9c71f@linux.ibm.com>
Date: Mon, 19 Oct 2026 20:57:11 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] hw/i386: ELF endianness fixes
To: Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
 <20261019151233.230172-2-farman@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261019151233.230172-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NCBTYWx0ZWRfX8P4vCDoEzBB9
 hZ1mqcEGac7ibr975Yd4trOfPpPNHPwMM8gJG004OXbLu8/gtcFMKLhs4SOYjvwJz7P/hvlh3h6
 KC8sKx4vrDdgnnkq9ci3StyFKDhzk6s=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad6680d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vduKVk_dJG_DsMz-FTcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NCBTYWx0ZWRfX0n7YGSz+zVEw
 jrppC/K9SvpoU8LDRbuYzFS9rChxXXwjG3/ZVL8la9Bp+BUWgDLUsjOOyNdxRPALViFq4EMNT+m
 SKsOTY8NnNd5LlLwHpIxYnZP1JZEIwU6Em1kFPnYJnrIpFJaNYUzw2q+Fcfay7XO6h0GqdU7onX
 x8ugj6gL6sNfQM/0wCzI08H+apRFT8d/knytCO/K2KRZhH1cPMhc697+lc43JNKQqsM20ivDrC/
 lJw6O8A7/cHtW4G662CDWoYBZ4WX31t8XjvmY3XOXPKIoGJJZFy+aiD5srqhp/sA0gKbSC7bV8Z
 Cr/nmRfvU3SlajjuASgrVnvHidFZXLF+F7yaABhiyG6KDhC05izA4DElcQxK9Yorphp7snzCEqh
 5AKruvJ3K4WzFrZX4VU1whlMRbCzPxQd2aXYPK9nr6DAcurLBbfFrGme4Vqq+vsSlMY3YgoePE8
 TPnA1L6XrmNo1trCnvA==
X-Proofpoint-GUID: 4bxFmDIktYBOQfH9ZtdzDCaCLvs2CdUt
X-Proofpoint-ORIG-GUID: CBXvJrI0VwnHKLEOZZY33_U5Nk1vroNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 10/19/26 17:12, Eric Farman wrote:
> Running make check-tcg-x86_64 on a big-endian host (e.g., s390x) fails due
> to problems reading/parsing the ELF data:
> 
>    qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note
> 
> There already exists logic in include/hw/elf_ops.h.inc to handle byte-swaps
> where necessary, but it does not perform this logic for ELF notes itself.
> 
> Fixing that improves matters, but yields other errors: most of the tests
> timeout while some generate confusing assertions. Both appear to be related
> to the data addresses in those notes, which are incorrect when running on a
> big-endian host.
> 
> Adding tswap wrappers, which will conditionally swap if the host and target
> endianness don't match, fixes that such that check-tcg-x86_64 runs cleanly
> on an s390 host.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/i386/x86-common.c     |  6 ++++--
>   include/hw/elf_ops.h.inc | 20 ++++++++++++++++++--
>   2 files changed, 22 insertions(+), 4 deletions(-)

This looks similar to [1], which I've been desperately pinging for a
while.

[1] 
https://lore.kernel.org/qemu-devel/20240929180659.3598-1-ardb@kernel.org/

