Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BC7C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7RFs-0002lY-GC; Fri, 18 Sep 2026 01:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7RFr-0002ku-34; Fri, 18 Sep 2026 01:35:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7RFp-00033i-6D; Fri, 18 Sep 2026 01:35:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2VZAG2364834; Fri, 18 Sep 2026 05:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T3PZdR
 fE5hTzfnvSfQxe5tf0pDWuTssfOByHSRMIxkE=; b=B7BRl9GSXmzkxnVTPgJvLn
 UoqQEoASZXVWwSjbUoQfi5Q7BIGP2WbYXxK0lafEsHPSTZZInNxSno/PnutjQbpe
 bznpSjkqUmOGPVyIJ4JBzCvyFNBAcc2GnHH3c2Nu97EKGL3gOVif7c+boc9LwlxL
 8FzwNrq30xFGDcQ6XxlJsFqu4V5XW1P9UInOjIyFNDsO5sZ7/bRX8yIXBIBQq9tV
 SZpLu19E44Rh9SjyxCMNPmv6z3cAWXa0MWIadiUHO/fAwgAWQYUHDUwMcSILcLvd
 KjLihl7Xu9o/iQurapK3J9J3Ua4CE0WSdqt1EMVFOenhAnTp4u9bm6zc8+0UsW3g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqpd15-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:35:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2Z7Li009697; Fri, 18 Sep 2026 05:35:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffdxrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:35:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68I5ZB7r42992094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 05:35:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89F1B20043;
 Fri, 18 Sep 2026 05:35:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C622020040;
 Fri, 18 Sep 2026 05:35:08 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Sep 2026 05:35:08 +0000 (GMT)
Message-ID: <d55cadda-2d9c-4b25-8137-80bfc159ed0b@linux.ibm.com>
Date: Fri, 18 Sep 2026 11:05:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] ppc/spapr: Advertise RTAS error injection call
 support via FDT property
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
 <20260901174110.45356-5-nnmlinux@linux.ibm.com>
 <8fe89a76-5278-433d-8380-d44e6be22421@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <8fe89a76-5278-433d-8380-d44e6be22421@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA3MiBTYWx0ZWRfX9tNK5DhcB8Oi
 mIWows6lru3ohYDTSDsh8QQSMgjUgohy8L0bS6ZExZEogJqGo7PFIEhld9cvagyv6DVtclnPft4
 EzMxFrXdUDAoRktvSitPIaidlDqJDOZngm2KP5z/GmQkPfpty1bzxGTwOIUnuVSeniZAdK8uogH
 mBO8M5kMczQHYtTm6DyJSWFOoppuGJGhBS/FNrerZxqRo9teU+zmCW3zWG+Yz01QZknvKZIt4oA
 uwhczCtcQMa5b+wi+rD8EgWs59i+/FdCpn+z9Iby+BzqmbgHddU/dpuowPIJvbH2Hlv9hWzozHj
 yUT4gDdFbFfoygafrqAgqKBMzKinBCDbDte3S2O3O2VEI0BxCKEsPck6BtYpf73ngGe8Y1CIsJ+
 XC2wUfX1LmhooqbO3FPiZuzXvLOpb9JGYjpir6xew86HNg5sVzn6k4ORiMEVfmSEKANKhhNbV/W
 YPuwWilXyBjDULuiH3Q==
X-Proofpoint-GUID: 5R4bisHtDluppBy7m9_y9uw11DitnRW9
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaccd96 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=mrAPg8bVk9UARpT045QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: G-SNMX4KWFqgM3csLdgzsMQKKQAb7MUH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA3MiBTYWx0ZWRfX68N7Df10jUjo
 FWqFaCvGFxIr4JYt8q5SvuuGoV2F311cs/LqmzZkfKqX/TVJxYsUDpQPdpZsGPdxIARZMc4g3U4
 icPuuM+urkGQierAYnE0tKH1MbWjdoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180072
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



On 18/09/26 1:33 AM, Nikhil Kumar Singh wrote:
> 
> 
> On 01/09/26 23:11, Narayana Murty N wrote:
>> +            _FDT(fdt_setprop_string(fdt, rtas, "ibm,open-errinjct",
>> +                                    "ibm,open-errinjct"));
>> +            _FDT(fdt_setprop_string(fdt, rtas, "ibm,close-errinjct",
>> +                                    "ibm,close-errinjct"));
> 
> As these 2 calls are already registered via spapr_rtas_register() in 
> Patch 3, QEMU's generic loop will automatically populate their 32-bit 
> integer tokens. By using fdt_setprop_string() here, aren't you 
> overwriting those valid integers with ASCII strings, causing the guest 
> OS to read a garbage token and fail? Can you please clarify on this and 
> drop these two lines?
> 
Agree, will drop.

Regards,
Narayana Murty N
> The rest of the patch looks ok to me. Once this concern is addressed, 
> you can add my tag:
> 
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> 
> Thanks & Regards
> ~ Nikhil


