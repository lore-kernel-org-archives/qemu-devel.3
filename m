Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFA606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JvoeKivH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXdg-0004Q9-1f; Mon, 23 Nov 2026 12:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xVXdP-0004Oe-H8; Mon, 23 Nov 2026 12:15:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xVXdI-00074N-8B; Mon, 23 Nov 2026 12:15:13 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGYaHI4123729; Mon, 23 Nov 2026 17:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=C+dw2nnqRMvfBnzMNo9yAb4YQldE
 Shuoc7HYckbxn6M=; b=JvoeKivHBsjnt0EI1vLrvTKCKPZvcrzOPIcSLTKHUJx7
 0kBKE6LmqxHKle6pxW4rGXkOY2ubD22YlhWcCsGPocqmR2YG/HxkUlq7JB6kzIT1
 LI9/6iUCsZEqJEQKar8OpebQ16AMTs6ZOqmleYYyF52SadPMB9uEo/+5nc8FB5+N
 SRYxaPKOVU+0d493fp8Wsko4YBq6m9WXVGetx813o0zMcmBmamXmNK2zyoGF1iCo
 KDEgsjpHN1CyC4x5Hu/uBtq99MlZRDl8Eer4g78xQ9P9zv+8vUYpz0IOOeNaKkZo
 C9jOqADiRctXlCQ/xOsDyF948oK3IrEZso7R5vu5Cg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g13y8r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 17:15:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGJjI72171538; Mon, 23 Nov 2026 17:15:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3rayfaxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 17:15:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ANHF1Vg55574970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Nov 2026 17:15:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A4F55805A;
 Mon, 23 Nov 2026 17:15:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E1615805E;
 Mon, 23 Nov 2026 17:14:59 +0000 (GMT)
Received: from [9.43.114.251] (unknown [9.43.114.251])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Nov 2026 17:14:58 +0000 (GMT)
Message-ID: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
Date: Mon, 23 Nov 2026 22:44:56 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PReP] Maintainer status check for PReP machine
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gu6xbMTd-__fmOurnRSaE2EOXl3-m3sm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2OCBTYWx0ZWRfX+CqDEEbn0NFI
 zuRPkxceYjziCW9MXg+yOCLCEt11+01j+0mo/khIgw2fuhTU5FNJb3JFMNaG7UKFaET03SAf3KF
 zNwKd+r+s5lgKijE1/YTuHQI+O4W3Ww=
X-Proofpoint-GUID: gu6xbMTd-__fmOurnRSaE2EOXl3-m3sm
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b047497 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=MqW5qiURCL0fS7oN7S8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2OCBTYWx0ZWRfX63H0k52mWslV
 tLOGAeVcZc87ZmGj4sD8+PRn2X4dNZHbI9xmo2gFiDE4++I+wE1Sf0QuosK31fvo8dZFmPEAdJ2
 w6syevosjL0h5qarb8LWoNwbDs2DKp6YxhBIT0EOjKdicBo+ZuntuG4X5+dUt+32PSigOhliGDz
 trkZSxxDXzB/lR/6Zzgo6CGa86jFJi2Yte/cMHdcf0agyoTTEjx6ZVnAuIbARqjh/g8EY0tIhsv
 2E2hqkPJnXVcRmQD5t5rFbXvvuNcrDSpuBBALBKxK92JuAjwHwCJr+CeHeq+yY8/UumLc3F9/V4
 tbDhLy4MihRRltRj1CYAjFrQFAeV2tUFleLmIacfCD1cEI/+mKQFcaW3Zw4BE2bEz/FpAd2PzrE
 dcfhudzZ9ffzekjpUFkAoe39zEewpjOGN4ssHOJzY40Eh9rNyhVAM6cJ8h5uET1bLcrkxIMGWBE
 bF/1C5D8NUCGy/uzMzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230068
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hervé,

I wanted to check whether you are still interested in maintaining the 
PReP machine in QEMU.

Your name is currently listed as the maintainer for PReP in the 
MAINTAINERS file. However, we haven't seen much recent maintenance 
activity for this subsystem, and I wanted to check whether you would 
like to continue in this role.

If you are still interested, it would be great to have you continue as 
the maintainer. Alternatively, if you are no longer actively involved or 
would prefer to step down, please let us know.

In the absence of a response, we are considering sending a small 
MAINTAINERS cleanup patch to remove your name from the entry and mark 
PReP as Orphan, so that the file accurately reflects its current 
maintenance status. This would not affect the PReP implementation or its 
functionality.

Please let us know your preference.

Thanks,
Utkarsh

