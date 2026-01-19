Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F65D29C28
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq1q-0002Nn-7W; Mon, 19 Jan 2026 09:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhjtk-0001DA-I2; Mon, 19 Jan 2026 02:42:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhjtf-0001yD-Qa; Mon, 19 Jan 2026 02:42:03 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60IJjZAY015668;
 Mon, 19 Jan 2026 07:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9C5nP+
 m69LiZHr3dyRAWPj5y6k/YPPCUrTxamZrbuI4=; b=D57+hmGn/s6LGkQNpO0biC
 wKHSfnvMdv8+gYy+JkKNkjI8DrvuklhA3P2q+p0AKV2paPetOikqmoTq3rySn1hx
 DwrUlwSNsygcrdZSHw17Q9ETflkF0leqkLpctiFFS0nC5JCdH/4tD16zfH8wJeE2
 sxIBI6ZFhUQmGO9/6tvc8lWHxoQEZC2tCVGvWJQcShxbTEn5v30UtkYW76wqUMdR
 sdKTUXtLGf32lQSJNb96zr6tU3pnLadNuyJ4SQrpoGHF+oUYfAXl3sNEgagnCgnw
 FCt4mQQkgeO7HurmCHex8LzG7DAYDfMARubwiY78DYRZwhcV4fB3SLYtYM0j3WNw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br22u6c9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:41:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J4w6lT006424;
 Mon, 19 Jan 2026 07:41:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf15498-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:41:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60J7fpIn54985178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 07:41:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31C0F20049;
 Mon, 19 Jan 2026 07:41:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DB2F20040;
 Mon, 19 Jan 2026 07:41:50 +0000 (GMT)
Received: from [9.43.98.125] (unknown [9.43.98.125])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jan 2026 07:41:50 +0000 (GMT)
Message-ID: <9b6db774-cba5-49f7-b0ec-d56232cbeb99@linux.ibm.com>
Date: Mon, 19 Jan 2026 13:11:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/ppc: Implement S0 SBE interrupt as cpu_pause
 then host reset
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20251206055648.1908734-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ch2O7VnnfY1fX1epofQ0t_ddifr1zhSI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1OSBTYWx0ZWRfX+e/FSs7bwj8m
 pCtP9SZtSwqVJgrx2tUu42juGpxXKOPdEWlYjEJlf1BCGe9LZ+9C+VeiCB/GIYPnZPZ8YTYPD3N
 4FPmU1fEadpAQwEvRYL01StH2dvWC12hVNMZur7+egFcOrVzVuLYp79P0yfC77sLmPCA3I6J+d3
 2Hkyn1opQ9tRuVMgj7d1GzuGSGBhRbWyX5ZUBX1lGDBUfq+yczXEZY2CCPjFQyJbW+sN6PdCO/c
 jQlVtwfVJFO61A/9WXwZUpiM55uLeAJu/0+XLx+Rdx8We0nuuJkUVw+wcq8LSwe203/bk7L1a3X
 bgQlHw63j8BcE921wG1CAqvUrcyBdBsjF5F779fOdGRLpl3JXkXv1MbmOk5BCh0Gn5YF3hT5mpJ
 yv86y5cf1SXGFTR4YjCuuAJeyvVLLe/YpOmTWntmdV63BtUrqzYDwMCTqZS5Ab9j5uLcT2y6qKm
 lser/l0diIB7SHG51GA==
X-Proofpoint-ORIG-GUID: ch2O7VnnfY1fX1epofQ0t_ddifr1zhSI
X-Authority-Analysis: v=2.4 cv=Sp2dKfO0 c=1 sm=1 tr=0 ts=696de043 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7D9Lvq5MW1BEjtAf3oIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190059
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=hbathini@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Jan 2026 09:14:03 -0500
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



On 06/12/25 11:26 am, Aditya Gupta wrote:
> During MPIPL (aka fadump), OPAL triggers the S0 SBE interrupt to trigger
> MPIPL.

As mentioned in cover letter, add more clarity by mentioning that
kernel initiates fadump with OPAL call. Skiboot then triggers S0
SBE interrupt...

- Hari

