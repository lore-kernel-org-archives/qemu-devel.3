Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2934BD6B06C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlU54-0005aU-02; Thu, 29 Jan 2026 10:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vlU52-0005aF-Gy; Thu, 29 Jan 2026 10:37:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vlU51-0007Ww-1t; Thu, 29 Jan 2026 10:37:12 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEuLWU012093;
 Thu, 29 Jan 2026 15:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1FZQj6
 Snv8y89E/htyKO+rZn/L5b2Phu0P/IFthMdaU=; b=OOz5LatOn4mirutUVgDbdS
 MpDQw6GlRxLXLMKHtTke6TsLUh8Zr0hkc5+jcsCd3NJqUisVu/7wXm5KN/x1OSBJ
 WUg7k7U1aDGiGooFIQEoZm/47gnmgfasmFsKvz0UBt9mB+hU7cvVAa8ScbXeNKLb
 MlPiftvSjw3aQc4HeptE1DAPHLZtdfSIX9dlE5y6PznXNaEpQK6wFU3/jXA9ZZp7
 hF5vpagoB14dc1V8jNjzsY56M9vZ83g6EOYwbZnKw7f2ZpS6hwlbSPBX/MR/fdv1
 Kh7A4s83EloexHaAGkhQDK5wqU7jaU+ZPT5JGWSsc3hjeOYxTWMouCxZvPJHCBBA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr6egqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 15:37:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TBci1R031024;
 Thu, 29 Jan 2026 15:37:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dstbfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 15:37:07 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TFb6wt29295136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 15:37:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 292765805D;
 Thu, 29 Jan 2026 15:37:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BCEF5805C;
 Thu, 29 Jan 2026 15:37:05 +0000 (GMT)
Received: from [9.61.177.101] (unknown [9.61.177.101])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 15:37:05 +0000 (GMT)
Message-ID: <eb30e0ed-3750-4ca1-b1da-503ba7614400@linux.ibm.com>
Date: Thu, 29 Jan 2026 10:37:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] pc-bios/s390-ccw: Introduce CLP Architecture
To: Thomas Huth <thuth@redhat.com>, jrossi@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-8-jrossi@linux.ibm.com>
 <e694cacf-8156-4ba7-9a64-8f6fa06a48d0@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <e694cacf-8156-4ba7-9a64-8f6fa06a48d0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwNiBTYWx0ZWRfXxAH6IsredNy2
 OdonOfYm7Hts1xPzJM1QnhZIAR4iSVl5sFQ9EAqQ9KEtDD+R3jH6Yt4MVKWeGPW+Ruxq0PrkaK5
 kPHkItygu7wN8ek3pwqW/2pZJFrILf+CrXJBfv7HMapw/NiuRa4MbzNNFDuMbBxAst3rsn35Q/c
 9YIVgn1b4LJswMmSNtdOkaNhBagYn7MLKYL3AGIUIyPFXm+Q8/uv5CKJuSKPYmuMma7DltaPto7
 4GK+0mpjJZnqN6j9uS4p93U1+Ms0HRhgGBrn60SRNyrsq8rV8iFcTaUjYrrJY42bWztZUeaS2aR
 3peak8h1WeyQbWr8XQiVY/lOYmXz0DNU2lzsmNawrQfQ8yM9RLPrKJaBPr0MH3pjR4Kx3ElhA01
 y5xou5PMsO744NyJcsFxevOGVwAFtRYpdJCtA92VFrVsokB1pm5QXHxjRfog/k0n9WL/QRq48ob
 svUp4mwSLXS7ZzGGLvQ==
X-Proofpoint-GUID: muCyQ4fS2ux06PnSM5Oc2mkM5DcthSJ6
X-Proofpoint-ORIG-GUID: muCyQ4fS2ux06PnSM5Oc2mkM5DcthSJ6
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=697b7ea4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RStlCdrDjo8yFNkQr78A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290106
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> Since this instruction is not part of the public Principles of Operation, I'd appreciate if someone from IBM could review this patch.
> 

ACK, will get to this in the next couple of days if someone else (e.g. Eric or Farhan) doesn't beat me to it.

Thanks,
Matt


