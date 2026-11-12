Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017B606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pcrUb2Qf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRD6-0005yn-Ue; Thu, 12 Nov 2026 04:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xRRCs-0005w4-C7; Thu, 12 Nov 2026 04:34:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xRRCo-0000X2-Fw; Thu, 12 Nov 2026 04:34:56 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC4NWfK3274555; Thu, 12 Nov 2026 09:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NV7NCh
 jEJIC61dpGZKBnad0YpNhYnmuo+x5n9NkUJhI=; b=pcrUb2QfM7XQjQ83sjqv+p
 hLdiF5RX2XNDIkTfCtyL8KhJlG9OUS2WcGcZOgibNw0OJcK5RGsgHaIWPreE4hzt
 rCoDLryjWUof5PW0T1fdsSHfEqCF/MUMKjTt+8NsFsg7ZKZGVx2hzlaQVZf+jhs8
 gqBmzmOGcyUHeK0LZQgasIKkgzhIrwK/0LFNDq8o8Dy9wwB8mtKv8LuEGIIL7QWd
 1cRCr7YYPBt+8VHnpO686wI2n0Sb89m1V9yjUhJl1ddzAULeOvsgXCWbVs4EHedb
 tM6JDTYXG8dDFJ69WWW2qErV7iMlAL+GJiYhqonVC1F7WI+vdtXcezm8oxKkPb3w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6esj7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 09:34:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC8HH8x097815; Thu, 12 Nov 2026 09:34:50 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0vq36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 09:34:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AC9Yn2O34079298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 09:34:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A85A5805A;
 Thu, 12 Nov 2026 09:34:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BAD258052;
 Thu, 12 Nov 2026 09:34:47 +0000 (GMT)
Received: from [9.111.49.39] (unknown [9.111.49.39])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 09:34:47 +0000 (GMT)
Message-ID: <4c1a9bb8-a205-46a0-8ade-87076989ef86@linux.ibm.com>
Date: Thu, 12 Nov 2026 15:04:46 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Mark PPC TCG CPUs as Maintained
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com,
 Glenn Miles <milesg@linux.ibm.com>
References: <20261112092750.1821470-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20261112092750.1821470-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: bLfJSssdlTxrabXmDmxlGMt2yuINsJ4e
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af5883b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=v6HyfjuJ19asQ0KlDJUA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: _A3k_s6syhxYAUk5o2daPpAuZ7qyf3A2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNiBTYWx0ZWRfX9jpw+JIl36Sw
 tkQvciyxkBsRjkt29enB/mLHoBmaLzfP7EvrBGB6GiYQlM8246kxSSFJH9lOExa0kXabWkqSvYJ
 J0O+FXzHj1fZaixzebQ/87VWnUI2ASCC+bt1CoGPOVyZW+rWSVOPWZME72y+IWYJomzuXK5rMI8
 niBFMQDS5bEJsTizKO+1G5kjza/IJfUnbDV9i8Htw3q9QA87Zp2TIkUS24NBNUVpVvT3QuGavtp
 teos5n7G2QZwEGN2yH9FEyoxezbrqnik+tQTIgDaEAz6uz9qeZMvFQepLVd5aIUYGmH8vQFHjGf
 SMbQ06PW7Oa9Vf8IdrPcDTdJWPiHe5LwhQR/tFShkAdHH+1rau16bufyk1dwaD1Si5JH1yFBhwv
 QH5rXkuT7eFjhJaGWPzkci2Rn1oyxV54UPiXdjX1W/FSw6yzJ+y4z7nUXjKMkLJlWJysOhP4y+b
 NEmqFp8CPciVBDGpVRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNiBTYWx0ZWRfXzBH3jes9/RK8
 CmjuJWLlCiYImviIMdgvB23A5abtx9vesi84ZpRJGJF5lox56YawjX5D4Y4B2ZJuzv1AG5V8vv0
 0jL0s+J5Kjqoiaby2HBWHxY91MF/kfY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120036
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/12/26 14:57, Chinmay Rath wrote:
> Update the status of PowerPC TCG CPUs from "Odd Fixes" to "Maintained"
> to reflect their active maintenance.
>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa0c6d0c9b..d268243fdb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -348,7 +348,7 @@ M: Nicholas Piggin <npiggin@gmail.com>
>   R: Glenn Miles <milesg@linux.ibm.com>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
> -S: Odd Fixes
> +S: Maintained
>   F: target/ppc/
>   F: hw/ppc/ppc.c
>   F: hw/ppc/ppc_booke.c
+ Glenn

