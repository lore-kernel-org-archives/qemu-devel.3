Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D286EDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWGO-0008Rq-Ay; Tue, 03 Mar 2026 15:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vxWGL-0008Qy-W5; Tue, 03 Mar 2026 15:22:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vxWGJ-0007ZB-HT; Tue, 03 Mar 2026 15:22:37 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623JniBk2154446; Tue, 3 Mar 2026 20:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4I1Doy
 dm5udE3wBXzB+yAvYD1I83aUCnHP6VH4Pg8WU=; b=l3LrfKXcWFKLkP6ObYsxhd
 B60ueCBHoxUEyYKfqrTN4HJZ6mhJyV2TwKO6Lkb2Qa81zZXPRD/+oTRmd68q6rZq
 1SVFIfuGv7674ToRlHhIVx7zewNnG90wSaE3FwFldvEHAR9K5uFCwLuoW17zl81+
 NFBhKv2UaccSJ9K/ze+TtGJkp0Qxxx68DkVIm/qB8ESP+brwPN5pZAB8F2efPd2L
 6pQ+xJOF9lnznX+fxpSpWdrpRkAOToCKjnrYyN0KJDH3U9m40qCSiftlCrjDhrSZ
 PzNm7Ss0scMBRTPpNqwi0+brIzYwhBHMybFFzBZMiqYpt/nuthNOWYBKu15bI8gw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbveca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 20:22:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623KBiBW008769;
 Tue, 3 Mar 2026 20:22:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1bn32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 20:22:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 623KMRaf22676034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2026 20:22:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FD1258050;
 Tue,  3 Mar 2026 20:22:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F6E658045;
 Tue,  3 Mar 2026 20:22:25 +0000 (GMT)
Received: from [9.61.253.239] (unknown [9.61.253.239])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2026 20:22:25 +0000 (GMT)
Message-ID: <3135b985-9c3c-4689-b780-a6e41cc708ae@linux.ibm.com>
Date: Tue, 3 Mar 2026 12:22:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/30] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-13-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260212204352.1044699-13-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sCZGkBhWbzpxTZvdQ75pCDFBMS3BzN_3
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a74305 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=Tgzwo3mTLxb0sD9omHwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE2NCBTYWx0ZWRfX63RkHW1He2hZ
 73GBlnQZghipy81f+VYCBUHg0nGomOYXHn5vRVCg5YYeJo+fxKj/gm3HwSpcZfo23ZvvQ25n2mQ
 NW8dQfTs1RdzwTKsXQF87AathMgHmTGnKs30wEAhg1cEvgTSbxnUwqXxEMDrzUnuLJORmVUTCEm
 QZovldxcDkVp8z+SagIhY2S0dCkwwyeJv2sHKDJgOp70BIFypdS9kIZJfIu43SJPOtREyQg2AlX
 8o5KfpQEMjyfz4MyDcettdbf3VsQJpSjIIovI+dXgBNEhC9FjYPBYU9KOkmDxGFUH48hC1e3e5i
 vzEeZs6QXeySXFvLnWX8oEAEhv8l5J7dbdKZb2a54L4KdQmt3/jHQRZ3QotZCAMdMZaQq9TD54T
 I+dz9egPdKVz5bR81HJ8AG+Y9bmwultGKRtICuaMHn9cofq5Lj3Li5kofvjhQCQWB9rd9I0eP1R
 DxxhmIxC2hWMPjpOClw==
X-Proofpoint-GUID: sCZGkBhWbzpxTZvdQ75pCDFBMS3BzN_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030164
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 2/12/2026 12:43 PM, Zhuoying Cai wrote:
> From: Collin Walling<walling@linux.ibm.com>
>
> DIAG 508 subcode 1 performs signature-verification on signed components.
> A signed component may be a Linux kernel image, or any other signed
> binary. **Verification of initrd is not supported.**
>
> The instruction call expects two item-pairs: an address of a device
> component, an address of the analogous signature file (in PKCS#7 DER format),
> and their respective lengths. All of this data should be encapsulated
> within a Diag508SigVerifBlock.
>
> The DIAG handler will read from the provided addresses
> to retrieve the necessary data, parse the signature file, then
> perform the signature-verification. Because there is no way to
> correlate a specific certificate to a component, each certificate
> in the store is tried until either verification succeeds, or all
> certs have been exhausted.
>
> A return code of 1 indicates success, and the index and length of the
> corresponding certificate will be set in the Diag508SigVerifBlock.
> The following values indicate failure:
>
> 	0x0102: no certificates are available in the store
> 	0x0202: component data is invalid
> 	0x0302: PKCS#7 format signature is invalid
> 	0x0402: signature-verification failed
> 	0x0502: length of Diag508SigVerifBlock is invalid
>
> Signed-off-by: Collin Walling<walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai<zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   docs/specs/s390x-secure-ipl.rst |  17 +++++
>   include/hw/s390x/ipl/diag508.h  |  30 +++++++++
>   target/s390x/diag.c             | 111 +++++++++++++++++++++++++++++++-
>   3 files changed, 157 insertions(+), 1 deletion(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



