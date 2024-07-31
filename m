Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BC1C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 20:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZG6Z-0003Uu-N4; Wed, 31 Jul 2024 16:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sZG6X-0003Tr-AF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 16:39:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sZG6V-0000hh-7O
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 16:39:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VF2WU1021468;
 Wed, 31 Jul 2024 20:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=z3dTzFvi4JLpyNlelRGOQR
 BGcTToQ/G5wCJDX3gor60=; b=gsGQ3njjkj9HyYNtsOvKBOji5TLSuptitpn0Vv
 ssSNrLI6cd8fTo1/ZWmoj5pZYM2Sjw5mdJwlHPwNxS6N/fHdPwCeCRPGOI9PcTLg
 6KQaMyxLnY5MQvMo9rEqWqiQQgoBSQI+hNCp0ZMJqRoFmT9PJo+gs2T8yujPwnul
 j/OHQ6KmHhqH35aAKr0MQNx2/ISLarIy4sfS5UObF2eZ8SmmAZ5xfqINlkTrvCve
 pCwBwp23hyYstEA604UNXgmEnaeW6acF7xborChxhttDoJArRWauQvXA8hfM5mJi
 AK0pC7lr1cZwW18QqSyQScwoeoOoyI5cc9gXaw3ReB9O/v4A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms43cefa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 20:39:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46VKdIwl001468
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 20:39:18 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 31 Jul 2024 13:39:18 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH] MAINTAINERS: Add my hexagon git tree
Date: Wed, 31 Jul 2024 13:39:10 -0700
Message-ID: <20240731203910.2570047-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: tFm55n5W3xln1L-8XML-UyOYg5ERsc3E
X-Proofpoint-ORIG-GUID: tFm55n5W3xln1L-8XML-UyOYg5ERsc3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=786 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310144
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
Zi1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Ci0tLQogTUFJTlRBSU5FUlMgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL01BSU5UQUlO
RVJTIGIvTUFJTlRBSU5FUlMKaW5kZXggNzJiM2M2NzM2MC4uMTI1ZmI1YzkwYSAxMDA2NDQKLS0t
IGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI0NSw2ICsyNDUsNyBAQCBGOiBk
aXNhcy9oZXhhZ29uLmMKIEY6IGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLWxpbnV4LXVzZXIvZGVm
YXVsdC5tYWsKIEY6IGRvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2Nr
ZXIKIEY6IGdkYi14bWwvaGV4YWdvbioueG1sCitUOiBnaXQgaHR0cHM6Ly9naXRodWIuY29tL3F1
aWMvcWVtdS5naXQgaGV4LW5leHQKIAogSGV4YWdvbiBpZGVmLXBhcnNlcgogTTogQWxlc3NhbmRy
byBEaSBGZWRlcmljbyA8YWxlQHJldi5uZz4KLS0gCjIuMzQuMQoK

