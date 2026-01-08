Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2F1D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxVj-00063p-EI; Thu, 08 Jan 2026 16:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vdxVW-0005rs-9c; Thu, 08 Jan 2026 16:25:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vdxVU-00074G-MF; Thu, 08 Jan 2026 16:25:26 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608C4Z8M016351;
 Thu, 8 Jan 2026 21:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LiSzdr
 v0qNm2UbdsMTKIvcZg9MnvbqU+T/8QGc7P7YA=; b=ghn8slW+2BD+L3zOie86e3
 4tDg4FKNVIDnwaQiJecc/qu6i3YMZOpsnZFrvKmyweiRPNIcnBCIP1phQCDv7swm
 c7QC23NPoW91vIHaVoDtuAcQwLvArx4Qmwb5RsFAWN5cw61Y7r91nYp8hQVfVBFE
 O9kScs1T4PhQzFxWYhTZsime+AQbDBw4IzZa7iMNk2X4jCFHN51RUORkrhheTGCg
 PAKkyExRaX03Pr3HNJQFEKEBgN901VHlbnkqDVyLkNgjfCGPoaL/QlewmM03Y8v4
 tUMZIjHvligwQmD0dWPQVmuiw+q0n1eqsdK6uCqUmGo98uEI/LOvq/85Twz6MjYg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu6gcx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 21:25:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 608KrKAq023487;
 Thu, 8 Jan 2026 21:25:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rmp3a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jan 2026 21:25:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 608LPGR428246764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Jan 2026 21:25:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 687E15803F;
 Thu,  8 Jan 2026 21:25:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 624E358056;
 Thu,  8 Jan 2026 21:25:15 +0000 (GMT)
Received: from [9.61.151.176] (unknown [9.61.151.176])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Jan 2026 21:25:15 +0000 (GMT)
Message-ID: <a4d55c63-e5ba-4664-bad5-1dc17363d5d1@linux.ibm.com>
Date: Thu, 8 Jan 2026 16:25:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/29] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: Farhan Ali <alifm@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-9-zycai@linux.ibm.com>
 <c721a64e-fc9d-4abd-842d-934fe3311793@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <c721a64e-fc9d-4abd-842d-934fe3311793@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=696020bf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=yPBx-lMp1vgs5263aUkA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: Qzcz2bFDHyX_xxZutBufjQTlR_226s37
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE2MCBTYWx0ZWRfX16+M+s7KG8cI
 nEYtIW7iGGUtjWdlYqdVVwbrhXZ6dLqyYOcIVBwRqU4PATRR53QXHIafSYblaXtskmAS25DMqis
 lAQEzMX6JnNYRl7dQ5nNBp7oXh7BKiime3OagNkgkY2ocYKOBwBbffm96P1KUvhCjpKF75Gaad5
 wCEBV6e/zXhPKl/TWpok3VBM1zdHzO7a7kuAo6OrxUAuElnry+u7Kfn0QZDmHeZOlczdyx8tTzr
 cxhnLuWk0Qre8xVSXDvcmsN8b9n0rQRjLsNmYilo2+ZhwOpOzKWTFzgwcOnrwKBJGMOCzK3bVWb
 R5rFL2lQVJ2vHSdYJYxWXagUFJE1JffhZiSqmLKtBo3q2nkp6/bOzg2XsSXSm1Of9FKAICR3ZSH
 co2tydvTuHfBhm3KCZ4omZekjZfrd4eRoPpXAQoFbxVI30ggCPlvyEOwbT8H7QrscO6+XhBgeja
 nRKnzslPOjXrN/HIOgQ==
X-Proofpoint-GUID: Qzcz2bFDHyX_xxZutBufjQTlR_226s37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601080160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 1/8/26 2:32 PM, Farhan Ali wrote:
> 
> On 12/8/2025 1:32 PM, Zhuoying Cai wrote:
>> Introduce new helper functions to extract certificate metadata:
>>
>> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
>> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
>> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
>> qcrypto_x509_is_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
> 
> I think this function name has changed to qcrypto_x509_check_ecc_curve_p521?
>

Thanks for pointing it out! I'll fix it in the next version.

>> These functions provide support for metadata extraction and validity checking
>> for X.509 certificates.
>>
>> Signed-off-by: Zhuoying Cai<zycai@linux.ibm.com>
>> ---
> 
> The patch LGTM
> 
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> 
> 


