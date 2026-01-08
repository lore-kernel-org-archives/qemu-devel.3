Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923C3D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 19:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdvkD-0000Lk-P6; Thu, 08 Jan 2026 14:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vdvk9-00007m-0Y; Thu, 08 Jan 2026 14:32:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vdvk5-0000N4-Hg; Thu, 08 Jan 2026 14:32:24 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608A8IZo002998;
 Thu, 8 Jan 2026 19:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FNKBYW
 1ttYfNlZI8/9c2VfLu8QO6jvvs8SxwTGS2JBs=; b=esO18d1xFyEB/L83NAxGeQ
 HmRgkoRDIOPWiYMk6spCsfqotQMFMc2QDDhlScOqsWWLwuiw0Cc+se3Uov4MNgvU
 hoZg03pUMXCWUBwJ5BTawGfZgEAY5Grh5TLP+A3Jkfy72AXHP3mEQjtw/jKx3yk1
 yIbwY0KxrAS2z63UAFE8xko2DQB797JM+5VWpih2C3GiTKHSzwvPEB/R4Y5TQL+q
 6eueZ+o3meOSj98Y16w1eLp0YzK+UJ3qkK7xR+cuPvrPriEVTXK/E4+QAYs8wlQV
 XziAEAV+cOLKe3gKE4eYEN+cf6KDUHErTNvj+utq762sZMEC6Rgi133EDqcsKKKA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshf6ney-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 19:32:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 608I7NTN015656;
 Thu, 8 Jan 2026 19:32:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdess4by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 19:32:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 608JWFxI28508700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Jan 2026 19:32:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6692858045;
 Thu,  8 Jan 2026 19:32:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8E6B58054;
 Thu,  8 Jan 2026 19:32:13 +0000 (GMT)
Received: from [9.61.253.86] (unknown [9.61.253.86])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Jan 2026 19:32:13 +0000 (GMT)
Message-ID: <c721a64e-fc9d-4abd-842d-934fe3311793@linux.ibm.com>
Date: Thu, 8 Jan 2026 11:32:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/29] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-9-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251208213247.702569-9-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE0NCBTYWx0ZWRfXwM54YBFBJ0Qq
 Cp7uEUtEXJJZaYsLZ5iZXpn7JODrkg7ZydIUWpOlRzQw9Jca+6DuA2cJGx+jDtdBpgFnvZu2uG7
 a9Me+Qpt4Rl/EkPi/e/3yzzQ8NIRfIhyMEAChcD65fW8QelaMsDproOpMR1hRR1mdrYa9YFv7IS
 yb/ZYVxoBWGQ6zDx4VygTu8HmN/p/Shtn1ysrSKVOTR2EYeKp2cNMQy+YiZRZyDCtP1XZISo3eH
 KQ3z/Ma5EslEyPA6dsc0e1Pjctv1hk+Vcit8ZQOt0mnhDpzJDICFTKNUiG6W+yCJT5Nh+Xp3hP/
 /NV8QyZNU76SFpNKDSjE5dkYBvQ313mbXA/CqPhMxO0273h473BoXkUf1nPDwDv+DvK3ajLLlUk
 zAd96QzmsL4xgz2vTTptCdmr35t3fg51Hxf/NC58EJQhWeoJWE00gfj4xQJpNHJGZl2/WrLBbtV
 Gpu9OwLukR3rpQwdI+w==
X-Proofpoint-GUID: 95kPO4j0FxVwjrOWKdXOevx8ax1sgwUA
X-Proofpoint-ORIG-GUID: 95kPO4j0FxVwjrOWKdXOevx8ax1sgwUA
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=69600642 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=j3SwWdo30wvGsQaUlywA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601080144
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Introduce new helper functions to extract certificate metadata:
>
> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
> qcrypto_x509_is_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve

I think this function name has changed to qcrypto_x509_check_ecc_curve_p521?

> These functions provide support for metadata extraction and validity checking
> for X.509 certificates.
>
> Signed-off-by: Zhuoying Cai<zycai@linux.ibm.com>
> ---

The patch LGTM

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



