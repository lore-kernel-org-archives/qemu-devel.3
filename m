Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EA3D26D9B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veIiM-0007hH-LM; Fri, 09 Jan 2026 15:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1veIhV-0007Sy-E6; Fri, 09 Jan 2026 15:03:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1veIhT-0000g7-GY; Fri, 09 Jan 2026 15:03:13 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6099XWOf007458;
 Fri, 9 Jan 2026 20:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wRK/q0
 tkw7dkqNRpiYakQEm2ArFMv4vRGjHGjFMWOEw=; b=H/iwQ1OhdXrZkDFjnZQ32R
 Ss3d1yG1ofbRLlRPfhIvhlVjAYHReHTtjxEo6i6DIkcIf8Xqu4v8+CQC6VsTqG77
 ThLNEB6qa+CBiGZ4WKyo6vnHhWNVHcKCptSoGzZBFby6NKjpao5KPPKqwT47eRN3
 yd5B+sqUmIs2aN2hAIbtgrv6l0BbsIwGb3cg9Oe8P+ImPL3WaUdSTjiLIzW5JE4t
 dS7kOn50b7i16idr1AFY0Tf45hZb6EyPI54ZYKS3hYEJrAPEbylUp69ODVM1vgQS
 /d4YurAIqzyMiXexqXk39DAPs8w/1al6i7zIHFC+zyOzw/xwSfTqNVfA0Gwa1Few
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshfbmky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 20:03:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 609Japwp014542;
 Fri, 9 Jan 2026 20:03:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeenevgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 20:03:05 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 609K33HP30081758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Jan 2026 20:03:04 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1B8A58065;
 Fri,  9 Jan 2026 20:03:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6376558052;
 Fri,  9 Jan 2026 20:03:02 +0000 (GMT)
Received: from [9.61.246.33] (unknown [9.61.246.33])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Jan 2026 20:03:02 +0000 (GMT)
Message-ID: <d6fe47aa-6ee7-4ecd-a230-d5ac81b2c837@linux.ibm.com>
Date: Fri, 9 Jan 2026 12:03:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/29] crypto/x509-utils: Add helper functions for DIAG
 508 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-12-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251208213247.702569-12-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE1MCBTYWx0ZWRfXx4CqTkX3pFUd
 eTpWeT6MZsquFqriVmCLVLe5gneUmDU3RInpBx+0ZX52MnlIw23eYjujOGX9EfYBWzXlGTJxgGT
 NlZOVaEs7C1jWRf2YuMYimZZRwpjx6rCVMJKhPG1Xsli8W3NuoiEzgNTXyLRHNQ+B5vDz1oF1UT
 K5oKczrHhWtKldW0T/k17E0YTUsyoNKcOv8HTiu8ATYelQl0Aq+WQjXYH8KdW2Hx0TLQRBCYXwi
 xMCBbPD1ZEBZ1A0Bi4RVupmmZmmayJ3S1KpFXZ9RJC8En0wKpv8gUNFbdg641GOwZx1w45OlejQ
 ifj0tgKz1kGXTrkB1GqStOU/BqgY1t1voA2t3JfiACyAATkscqAr0Mu39YIWoS8QURPKP/OsZJA
 AV4QvP1tiaPN12yipssAuFIw++urL/9Hcrl1aw1qk9Wi37HJ7IX3wDExNG/nfI7FOBOxxA44uLL
 y8BcWb3RsCuQ6G+WBcg==
X-Proofpoint-GUID: CUZ1XwhqznDGKvW9mWmG9aqQ7gCZ3K6J
X-Proofpoint-ORIG-GUID: CUZ1XwhqznDGKvW9mWmG9aqQ7gCZ3K6J
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=69615efa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jPPqZkirAdYMJfI717YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601090150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 12/8/2025 1:32 PM, Zhuoying Cai wrote:
> Introduce helper functions to support signature verification required by
> DIAG 508 subcode 1:
>
> qcrypto_pkcs7_convert_sig_pem() – converts a signature from DER to PEM format
> qcrypto_x509_verify_sig() – verifies the provided data against the given signature
>
> These functions enable basic signature verification support.
>
> Signed-off-by: Zhuoying Cai<zycai@linux.ibm.com>

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



