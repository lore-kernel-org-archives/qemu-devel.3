Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C5DC52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 03:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbu3l-0008Ll-2e; Wed, 07 Aug 2024 23:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3k-0008IJ-7r
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3h-0006it-Qf
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477I28Ml016385;
 Thu, 8 Aug 2024 03:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XIZJnrfp3fogwk40dNFdoApof3MEhFL0lZXJqJ9upZw=; b=ZKNVzmZQ9VEgXAGB
 A7Geo8CD9NbZULzvJfTQ/kQ4F93KwvretrPR/TLudS5SIiAtVv9lfqBgtNNPynue
 ILw8Cp30CWX0chWZ/pDIdXzEAoCsGScgxBDIGHJEEyjmOizLkDtdYuVnGlwQRV6z
 AHP/6Mx75l69YjZYQIEKFgcB2UqphPC9T5xBWG8A2EW14IXFVO/8IKXOohfEtZwJ
 jNC6BSPJgYeww/5oC4Ot2wAer7gI2oSI6rbX7R/3vtQWwSHIkq68pOD4rhT1FAv4
 mwEE9deppr4lNbpCGKGW7RsyoogatxThHQBrXb5rEIX/og0+PC3+sefHy7FjgDoh
 DmwesA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vduph1g5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Aug 2024 03:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4783hLT2022317
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Aug 2024 03:43:21 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 Aug 2024 20:43:20 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 4/6] MAINTAINERS: Add my hexagon git tree
Date: Wed, 7 Aug 2024 20:42:42 -0700
Message-ID: <20240808034244.4139757-5-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808034244.4139757-1-bcain@quicinc.com>
References: <20240808034244.4139757-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 11tJmGIvQlpKqOlZuduGYx7vBNsiTI6F
X-Proofpoint-GUID: 11tJmGIvQlpKqOlZuduGYx7vBNsiTI6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_03,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=807 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408080024
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

QWRkIG15IGdpdCB0cmVlIGZvciBoZXhhZ29uLiAgTm90ZSB0aGF0IHRoZSBicmFuY2ggaXMgImhl
eC1uZXh0IiBhbmQgbm90CiJoZXgubmV4dCIgYXMgaGFkIGJlZW4gdXNlZCBwcmV2aW91c2x5LiAg
QnV0IEknbGwga2VlcCB0aGUgImhleC5uZXh0IiBicmFuY2gKaW4gc3luYyB3aXRoICJoZXgtbmV4
dCIgdW50aWwgdGhpcyBjb21taXQgbGFuZHMgdG8gYXZvaWQgY29uZnVzaW9uLgoKU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+ClRlc3RlZC1ieTogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPgotLS0KIE1BSU5UQUlORVJTIHwgMSAr
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVS
UyBiL01BSU5UQUlORVJTCmluZGV4IDc0YTg1MzYwZmQuLjEwYWYyMTI2MzIgMTAwNjQ0Ci0tLSBh
L01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0yNDUsNiArMjQ1LDcgQEAgRjogZGlz
YXMvaGV4YWdvbi5jCiBGOiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1saW51eC11c2VyL2RlZmF1
bHQubWFrCiBGOiBkb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2Vy
CiBGOiBnZGIteG1sL2hleGFnb24qLnhtbAorVDogZ2l0IGh0dHBzOi8vZ2l0aHViLmNvbS9xdWlj
L3FlbXUuZ2l0IGhleC1uZXh0CiAKIEhleGFnb24gaWRlZi1wYXJzZXIKIE06IEFsZXNzYW5kcm8g
RGkgRmVkZXJpY28gPGFsZUByZXYubmc+Ci0tIAoyLjM0LjEKCg==

