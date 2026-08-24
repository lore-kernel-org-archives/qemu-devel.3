Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D0AC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycCe-0000Ka-3O; Mon, 24 Aug 2026 17:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wycCc-0000KL-Jj; Mon, 24 Aug 2026 17:27:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wycCb-00062U-4d; Mon, 24 Aug 2026 17:27:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJVVrN984541; Mon, 24 Aug 2026 21:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Msa2UZ
 AxAIEFXZvCzxo3FgoeF2EjhvQP6KPPmx3seIs=; b=PcQbbeqVhaiz/e7/OiBeWi
 vduMVshixBu5uPUSt9gbkHtp7LMxyHucvKg3oJ3JzEpT/trpaXhW1CBayq6tW9j/
 wV1cozYpBJDun9t7+QqdK1CO10tHUPYxu9wzv+4BqfrEBuWK77hUbsxRRGhuNu5W
 Aweooyr6b5r8Eg/dzLxMy9qYZe18bbpYLIZJFarI2LN+sXTeppDKsE1919isssd9
 RglSBZBq2hbAHc8gD6A9v3nOLz0YB4zPK97m6fFa55s7bUhldL1KQ/aoEgV/DsgI
 pmjnQrLxRoUUduFJod4aPXbcxpZFP4Wr7seqloXmIOWRKVD9NXybLmcU3Wp1MKBQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqm9fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:27:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLQFoa016118;
 Mon, 24 Aug 2026 21:27:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag8e3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:27:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OLRRCH14353102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 21:27:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90C075805A;
 Mon, 24 Aug 2026 21:27:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB1E358056;
 Mon, 24 Aug 2026 21:27:26 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 21:27:26 +0000 (GMT)
Message-ID: <8c78f978-eb13-4dd1-bb92-f39d0623230b@linux.ibm.com>
Date: Mon, 24 Aug 2026 17:27:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/15] s390x/pci: Create function to contain
 translation status check
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-3-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-3-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UuPiFLN3oGxtT5GIsA4mrydDqQUcOCkG
X-Proofpoint-ORIG-GUID: UuPiFLN3oGxtT5GIsA4mrydDqQUcOCkG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfX4EZ8B69RrL5a
 y/XcIs62y3poMgsq989sHRYAIZOhMp1w7JAAXvODDaTGQckCnpdoP9fZyZW58qwLDMmHwdMl7bu
 93iWzsP1BHZCfTXZIjE3tNOivbJbn3Kk27yecd4/ERVqzqy7nFB+l+xXE4RzWx4rY7HPEphrQBZ
 gwWiRR3OYrO6EDpr/o7VADLnCqIrRbof2IW8CQRk0tGoOqmqsTPqZxbm6Lxert/DdYeHrK+nZAD
 evLtCJp/22ACx0xhK/DsNynawOkiFzCgi5UamEFQUHptp/rhH8eoYpoltEIIFQvo6tzocdtKkjR
 cFcQfI9ukQb/ic5NK3qXHCFUlsWV7FZIs46Uf74cNLK6rxdmuop+HzOYgLTbJDyw4IYTexp1Tsp
 ieFn2m6Ci24CaH86stdZ3B8LE/IdXYuTBA33m/efwMTxb/qvjUglJIqmFPk5M24/vIALJwPT4Yi
 GThw3Y7LmTb2oZ2Mm0A==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8cb741 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=hku6z8kztkKjzKdHO3YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfXyYEsS7klm1Mj
 eXsdtS2L1E306RkgWn3wYaomHy2B/p2FWLM045KNX9yGXPuYBvmoa/VKHIqL2z3EDEXhXohCmoo
 ZYC7AoX7BoRd2rk9KrmgXr4MT1ovpko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240178
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> Make it more clear what the bit means, and the new function will be called
> from yet another place in the future.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

Nit:
s/"Ali<"/"Ali <"/

All of Farhan's review tags on this series need a space between name and
email.

Not your fault, looks like that's what Farhan sent.  And it looks like
b4 resolved it for me when I applied this series -- but better to fix it
for v8 just in case.


