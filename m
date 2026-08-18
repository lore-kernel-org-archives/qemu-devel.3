Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149E6C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCge-0005b8-Sb; Tue, 18 Aug 2026 01:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wwCgc-0005aP-2x; Tue, 18 Aug 2026 01:48:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wwCgZ-0003uP-R4; Tue, 18 Aug 2026 01:48:33 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HM1aeh758716; Tue, 18 Aug 2026 05:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3H0mmm
 4xDZMKgKjPjp0Rw3HaIL0Cb/GekitjlvCMhyo=; b=PtbGNoiRbuG84ncUGggCdG
 XMU9wDv+rR+oUuY2rzu1AIQ8pzKi8ZgNyM8jk5URe3tYe6oMdowf6XonTgNbs8GB
 oA0xjbA/QdgmidQAgwCpKa4ygoFZSTmCEuhSx3RiRhwP7hCcFGWufjJKyy3f6UPD
 xYu1UYkZtIyaHCIudEdiB8U5KVMtyLKHrgEFkmHrJDz/li8cIRtFoR7R9B6k98Ds
 cICBJzFeOwHTJGgmRNADDMpY5dPSRd20jCaWC8awA61bZHrUNsPG7WYgRAECyb1H
 yG59CEXgC7a0H0qnuaUnhs59QCI5oFJeKlG7cZEd4WMvOy+mwFgtR/lHmvKjgxpA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqp9uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:48:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I5QPgp008386;
 Tue, 18 Aug 2026 05:48:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh1jwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:48:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67I5mMwU49414474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 05:48:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4299220043;
 Tue, 18 Aug 2026 05:48:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C883B20040;
 Tue, 18 Aug 2026 05:48:18 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 05:48:18 +0000 (GMT)
Message-ID: <c20076d0-609c-41c4-b873-2e8805e622c5@linux.ibm.com>
Date: Tue, 18 Aug 2026 11:18:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] MAINTAINERS: add dedicated PowerPC RAS section
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, harshpb@linux.ibm.com, 
 rathc@linux.ibm.com, npiggin@gmail.com, mahesh@linux.ibm.com
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
 <20260714164745.573141-3-shivangu@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260714164745.573141-3-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzOSBTYWx0ZWRfXwZ5t/07dGkOZ
 m+2ugb7Rh1uLNsxcylDY+fLid21z9XJQKb42KgsIAhbaT8dE14zGsNEmFMllG+EKDPKoQMk/uG2
 d+CJFdWSqCFemZfMN9gI7A+33zv6HfeZZt0bmiDNbO8d9s0GnfBpUIjKqxU2hPjQkrbZflOekKV
 HDOxwgYp4YRgIbD+0EVx8lNwz2Lv8ZiTWRiokKRfPne1QQ16egphOkBS3SMai5Uyy5KmRo5EuXC
 U6XlhrpWaRtvZQHNsWyHVhHf2e7PUMqNIbXecRG0zbG5cAahFPrdxdtoJCLt9cbAh2C9QNKH8vi
 P+gSn4JEu6CArL1pvs/GJTYojesiOevtApD5JPaTa4pfY0jDkxheBEkFRJtOdoNlnZOZJ90ZgSx
 UZLk2l9UUUhzMGDZp/0AqJ8D3GDX0tWcHLfR0t/O4lQ6Oid6OWpwovgnJi1ZNlN9HPt75nAgnIK
 8fx+ERlMfUuMB8tMyNg==
X-Proofpoint-ORIG-GUID: V9Asw4XgPakq8bO-7U8fulFCCcesA0B6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzOSBTYWx0ZWRfX6NR2xi1113AR
 MPK2KBa0/VtBMq+ayEE8+L/YoMdhX2kUwl7hcO8EdD3pWBJMDEUgzqbfUJyhNIQqFNcs7Ei5zs6
 4SxAt4jZG1/MUNxDKsbD91u4vaV0F6I=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a83f22c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=NLDyFlFtZwag4_lYDPYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rk_WBpcg7s73ANKyeDUuGPeu4wmo6ns-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/07/26 22:17, Shivang Upadhyay wrote:

> Introduce a new "PowerPC RAS (Reliability, Availability and
> Serviceability)" entry in the PowerPC Machines block, replacing the
> existing Fadump/MPIPL sections. Retaining the maintainer and
> reviewer entries from Fadump/MPIPL sections for this broader umbrella.
>
> Additionally adding spapr_events.c, as it implements RTAS error logging
> infrastructure and spapr_pci_vfio.c, since its all EEH related code.
>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Good to have a common entry for RAS. Looks good to me.

Acked-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G



