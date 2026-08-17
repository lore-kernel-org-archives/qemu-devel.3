Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD39BC5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvshC-0003GD-VG; Mon, 17 Aug 2026 04:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvsh5-00039D-Vu; Mon, 17 Aug 2026 04:27:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvsh3-00034d-OY; Mon, 17 Aug 2026 04:27:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVXlW1865918; Mon, 17 Aug 2026 08:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L7tc+u
 3GKMBhJRdYhUukzNGppn9KBTBePNn25gBHXIg=; b=Ka668Y2UGArYV2FLfsYYJl
 mRCPNp0XOxHIPlsLQbRDY+IwFlRiwnvU1uXghzB0wBgCjf/qrJfBK7vfvEu4ktmB
 ua7mK113OfZAvchuQ+fKi4UQFMQTrd9OKyfyzWv9qmtagYy1s2ck7Xe5qyeYYxB0
 5Fak14nLp7/rByyqwwsvJ7ASg1P0VkPBDgrTG5ZwEQPt74e9JdMWIQEmZct+XTgy
 9MTS7XyzSOBsY55RvHnp6aDzUr05BGbAprKOPh4OZtxMtY3AuSFhQbKepqidOTDw
 uRPcvvZ2dsYOEloX5W0XOOItGaax7RahtYEUwJqeqloyitrErsV63siybmdOb7Hw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqh68y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 08:27:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8QI7Y016273;
 Mon, 17 Aug 2026 08:27:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng4xcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 08:27:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67H8RXB951904902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 08:27:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D53520049;
 Mon, 17 Aug 2026 08:27:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB04B20040;
 Mon, 17 Aug 2026 08:27:32 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 08:27:32 +0000 (GMT)
Message-ID: <0e7a428f-398e-44f4-9c0b-5920bc49ac0d@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 14/19] target/s390x: Support protected key AES CBC for
 cpacf kmc instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-15-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-15-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX/b4Cnu1yda9u
 EDymkZKKyAPwpC3KS7yb/0Of93KYNxP/qHMIz0HrttGeCmOCxRDl3nkAK6XYIdnnX+dzis+p4iu
 lfvpjaDpw5mSwEKOayQoq6rPIsFT12vhCqHn2NpyCJ3UHNYoe2486jk8kYweF34AbhETYMsOlrP
 F2HHWmD53ZqjQJ926SR5wJfzYuJmcAmIP4/P5857ONLkX2i9KX3uwaPJY/YTUHVaG+cTEHrOXho
 fCvMh13CdIO4zZUsRFsQ3SwxEfeEwaGJApeX9X+6LdwHgOdDvBW8nMehww2VtmYY8EJSsgRXPW3
 ekIP0BsAzPdEOSebQvhD1mUEvEdgUr548GuKJfFRdXso8Xl7CScNcPGn90thAUcUkC6MUtOMgpA
 5eZsddXZSHoF225dEhVLq4FyJvix+J6w3iHOrGW1xDB71MhTpLq+qmHgwpNcGeF6XcV58tE+t+a
 rBycV1jbmQTxT1gzFuw==
X-Proofpoint-ORIG-GUID: dz3wwLzultQcJS4Wu1EAMaEyDSbb4LUy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfXyMi/4cueGlDl
 91/zeV5jk0wHYoPWyClEwC8d5blfqRniTsz1sSPLvaX2cizNzuBVXfZCgdNJxfEBEYU0uwYI1WG
 68yUrfxD51mnkiqHgvIH7LytC9INBeU=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82c5fa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=69gJmUcqiJ46Oaki9FoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dz3wwLzultQcJS4Wu1EAMaEyDSbb4LUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059
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



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KMC_PAES_128, CPACF_KMC_PAES_192
> and CPACF_KMC_PAES_256 for the cpacf kmc instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 90 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 104 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



