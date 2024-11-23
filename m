Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D64E6ADDD
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 16:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEtHq-00062P-V3; Sat, 23 Nov 2024 11:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1tEtHp-00061x-4J
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 11:47:09 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1tEtHn-0000Mz-Kf
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 11:47:08 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ANFvtfp031167;
 Sat, 23 Nov 2024 16:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=BNzmEptSCmcF1mZ7qv63yu
 8CWT1ByQVKWh4C+PLQ8qg=; b=J2prpp/XNKkSfnJ1p9kJVZ9iMQEnyJEW0arXR8
 /8eGIZjj7AtysSoC95yFOEjbpKlxr5jNuwfSq+iAXMXBlDtv+s2cBSpvEq4KqGqJ
 oH++nEkGkXKuUavkbE8JiqgIAq2X3AyjKxTCr+HPLmFIsBHI8Twf7OTMB0CnrQ4v
 c+Gx6y1Xh9dMKz4d2MYkNnyUJPLbvsHqowM6s5jdV7iEsJM790B4wY0Py24bJmQo
 6lCGzWweEs7AiuQr9kBlfWHu1r8iCSnOWkoldT34z1JfQNRB/SpnMDs4U2jcUbqD
 kbc8iOp5oB55ZeTvc3cxbYkdrU3FYBANpii/0Vkxh8d6jXzA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336cfh3ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 Nov 2024 16:47:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ANGl1RK030363
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 23 Nov 2024 16:47:01 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 23 Nov 2024 08:47:00 -0800
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <peter.maydell@linaro.org>, <quic_mathbern@quicinc.com>,
 <stefanha@redhat.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>,
 <alex.bennee@linaro.org>, <quic_mburton@quicinc.com>
Subject: [PATCH 0/1] Update email addr
Date: Sat, 23 Nov 2024 08:46:39 -0800
Message-ID: <20241123164641.364748-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Ue9zpn_taKR884StAH6Pk0NNnMHa-nAx
X-Proofpoint-ORIG-GUID: Ue9zpn_taKR884StAH6Pk0NNnMHa-nAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=632 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411230136
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Rm9yIHJldmlld2Vyczogbm90ZSBhbHNvIHRoYXQgSSBoYXZlIHNpZ25lZCBhIHRhZyB3aXRoIG15
IEdQRyBrZXkKZmluZ2VycHJpbnQgNjM1MDIwRjk2N0E3NzE2NDc5RUY0OUUwMTc1QzQ2NEU1NDFC
NkQ0NyB0aGF0IGhhcyBoYWQKdGhpcyBuZXcgdWlkIGFkZGVkIHRvIGl0LgoKU2VlIGh0dHBzOi8v
Z2l0aHViLmNvbS9xdWljL3FlbXUvdHJlZS9iY2Fpbi1lbWFpbC1hZGRyLXVwZGF0ZS1vc3MucXVh
bGNvbW0uY29tCmFuZCBodHRwczovL2dpdGh1Yi5jb20vcXVpYy9xZW11L3JlbGVhc2VzL3RhZy9i
Y2Fpbi1lbWFpbC1hZGRyLXVwZGF0ZS1vc3MucXVhbGNvbW0uY29tCgpCcmlhbiBDYWluICgxKToK
ICBNQUlOVEFJTkVSUzogdXBkYXRlIGVtYWlsIGFkZHIgZm9yIEJyaWFuIENhaW4KCiAubWFpbG1h
cCAgICB8IDIgKysKIE1BSU5UQUlORVJTIHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCi0tIAoyLjM0LjEKCg==

