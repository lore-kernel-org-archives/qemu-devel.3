Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF522CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbiV-0004dr-8P; Tue, 29 Sep 2026 13:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xBbiN-0004d1-9b; Tue, 29 Sep 2026 13:34:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xBbiK-0003pN-NO; Tue, 29 Sep 2026 13:34:02 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5T2W4017548; Tue, 29 Sep 2026 17:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UDQg9W
 K2Z49J+gmV/1KCNCoIMEO2nyA5sHKKyhev5G0=; b=C7rZtQz/RC13izDK6l9aMn
 0twz7lZTMQs7qzX/CgPVaHA+eYQSuIBPPRd0Jpxot9TV8WhY++bVQkVXWrDjCGRp
 e4TuRuEvoqiRWUZXKCLM7GT24QqB/8aTb8i8QE37DIFhxPeuDt4hJdCNXVQhwSFd
 2kbHVQxpM6hE6PfbjLf4zmt/U0Xed4GrpAPo1NHM7cutqCjtuh5RYQYcRwnLlJnH
 YmX638WMQM3TNTyLV+t5C11u4osfk7V/akbhEIje0sgOmEr2khB3oVL8OPzR5B0D
 R2UG/nnajlvcV2nY7RFZPLJTlvOF4te2Po7l7iEpVs//4eKOjwYu2pZ0Yc2FlKug
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt7mbd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 17:33:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TH8vsB2116592; Tue, 29 Sep 2026 17:33:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfp82sf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 17:33:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68THXoJe34013858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 17:33:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 494C05805D;
 Tue, 29 Sep 2026 17:33:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AEA258052;
 Tue, 29 Sep 2026 17:33:49 +0000 (GMT)
Received: from [9.61.250.47] (unknown [9.61.250.47])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 17:33:49 +0000 (GMT)
Message-ID: <f6980226-c8b7-48be-af35-ebe5655a3a91@linux.ibm.com>
Date: Tue, 29 Sep 2026 10:33:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] s390x/pci: Fix frame stepping in
 rpcit_service_call()
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260929153012.774530-1-mjrosato@linux.ibm.com>
 <20260929153012.774530-2-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260929153012.774530-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 897CPaMhAvIS0rkiT9C0tses0REgLK49
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2OCBTYWx0ZWRfXxEoKOGOU0sGl
 o/+emBkiWO6VQKRKApBHGR9sDrjLR6ZPxwkTxiJ7c8o1QRByaDLyT7zpeRSVasd5tHQOpVAa9de
 NNMknAtWvdCSjnw7+HSVJgzWq92kjZ/4oV/wn+XTR5Ix470yFPbkc3jDntQcwVs1zWlDmkbunRY
 ykP0mNlf9/DDsZ8JgiHVrMvGYRi0/KZmMFCbc/jmLE2Bqq+AV+mhssYdAfxg3i8oP3PsaQV7M4k
 I8BYzWyKTcmQ6/X1ZfUOMbIg2XN/QuPgby4IN0cPYsVe2FEO0odchv3tbBvvuPclaD6TwHpfFp1
 q9OFpoME9cDmSyN+tWjjk2431GETabTHqYkQn2ouCXPRIbB5R/sOf8zPxZXMqrSFjxWEj8sf1ZF
 L1JqZloFokbNtUhPYHTZgBmi4CBBuUbe0OVr9shyM2oJ+sfsjlPTbfP7WP/NS+HzgC7um3Plucz
 ntgcqjVrjBJAT5X5foA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2OCBTYWx0ZWRfX/Bcs88uHDUCZ
 pRd/eGK+l4u3UVLJt9ge9Ozg5/Wr97jj5Oye5YwEPgDRSVBt1WCKLkoKUFFVvw+qp/jhBHPmtDt
 HSDucheFcQUzOlr4vTSpAIoHDt1LHdk=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbf680 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=ADrvnKAIorB1Y6qdRlwA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 897CPaMhAvIS0rkiT9C0tses0REgLK49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290068
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 9/29/2026 8:30 AM, Matthew Rosato wrote:
> When walking the guest IO address table, an invalid segment or region
> entry causes table_translate() to return entry.len equal to the frame
> size for that table level (1 MiB for ST, 2 GiB for RT).  Adding
> entry.len directly to start only advances to the correct next frame
> boundary if start is already frame-aligned at that level -- which is
> true for a well-behaved Linux guest but not a general requirement.
>
> Add logic to advance start to the next frame boundary rather than
> simply adding entry.len.  For a frame-aligned start (the typical,
> well-behaved case) the result is identical.
>
> Fixes: 0125861eacc3 ("s390x/pci: fixup the code walking IOMMU tables")
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



