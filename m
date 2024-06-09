Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B04C25B76
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 00:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG6sH-0007mM-ES; Sat, 08 Jun 2024 20:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sE-0007kN-Nx
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sA-0003tK-MD
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45908Q5u019232;
 Sun, 9 Jun 2024 00:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eDsHNaWPkVU37Yv+C7qUcnL0MRskm6pncNLd1vlWLPg=; b=XEcM3CL22yFjB+OJ
 q8jsGe54P041LQP4e3zTRmqt3G4GvD9PLlD9Y7672hDF/shjjckrlqIbDriLG49M
 xHfKo6mJjNLIRZKPdkwD3VNRR4Aki4fMUoqXCly2TzWEsXKt5Hx5I95qGh7ObKPY
 afd/5jmRAAXLmVzDzdQiI1CuqUG+bZCZILzcgc+fNzQa/7h8fShaO6C+K6rXUA3v
 Q0+0TNOa/9amHKpOgVtWBltN9lnOAVxwC1Yh3LLR3AlFKMoH70s1Xs4GumMEVc8Y
 ShFbpCQkUsRbOn9MUWCn5Kq30w0snzs8EVmiE1qSKYuaXGioKKfJ7yIERVe7ZDTD
 HcyQ8g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnms9j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 00:57:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4590vLGu012008
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 9 Jun 2024 00:57:21 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 17:57:20 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 3/6] target/hexagon: idef-parser remove unused defines
Date: Sat, 8 Jun 2024 17:57:02 -0700
Message-ID: <20240609005705.2809037-4-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609005705.2809037-1-bcain@quicinc.com>
References: <20240609005705.2809037-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: ZufR8sx57KWXN5REkiDhII2gvHVOylaJ
X-Proofpoint-ORIG-GUID: ZufR8sx57KWXN5REkiDhII2gvHVOylaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=708 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090006
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCkJlZm9yZSBzd2l0Y2hpbmcgdG8g
R0FycmF5L2dfc3RyaW5nX3ByaW50ZiB3ZSB1c2VkIGZpeGVkIHNpemUgYXJyYXlzIGZvcgpvdXRw
dXQgYnVmZmVycyBhbmQgaW5zdHJ1Y3Rpb25zIGFyZ3VtZW50cyBhbW9uZyBvdGhlciB0aGluZ3Mu
CgpNYWNyb3MgZGVmaW5pbmcgdGhlIHNpemVzIG9mIHRoZXNlIGJ1ZmZlcnMgd2VyZSBsZWZ0IGJl
aGluZCwgcmVtb3ZlCnRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBBbnRvbiBKb2hhbnNzb24gPGFuam9A
cmV2Lm5nPgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWls
LmNvbT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPgpNZXNzYWdl
LUlkOiA8MjAyNDA1MjMxMjU5MDEuMjc3OTctMi1hbmpvQHJldi5uZz4KU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaWRlZi1w
YXJzZXIvaWRlZi1wYXJzZXIuaCB8IDEwIC0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVm
LXBhcnNlci5oIGIvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIuaAppbmRl
eCAzZmFhMWRlZWNkLi44NTk0Y2JlM2EyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVm
LXBhcnNlci9pZGVmLXBhcnNlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lk
ZWYtcGFyc2VyLmgKQEAgLTIzLDE2ICsyMyw2IEBACiAjaW5jbHVkZSA8c3RkYm9vbC5oPgogI2lu
Y2x1ZGUgPGdsaWIuaD4KIAotI2RlZmluZSBUQ0dWX05BTUVfU0laRSA3Ci0jZGVmaW5lIE1BWF9X
UklUVEVOX1JFR1MgMzIKLSNkZWZpbmUgT0ZGU0VUX1NUUl9MRU4gMzIKLSNkZWZpbmUgQUxMT0Nf
TElTVF9MRU4gMzIKLSNkZWZpbmUgQUxMT0NfTkFNRV9TSVpFIDMyCi0jZGVmaW5lIElOSVRfTElT
VF9MRU4gMzIKLSNkZWZpbmUgT1VUX0JVRl9MRU4gKDEwMjQgKiAxMDI0KQotI2RlZmluZSBTSUdO
QVRVUkVfQlVGX0xFTiAoMTI4ICogMTAyNCkKLSNkZWZpbmUgSEVBREVSX0JVRl9MRU4gKDEyOCAq
IDEwMjQpCi0KIC8qIFZhcmlhZGljIG1hY3JvcyB0byB3cmFwIHRoZSBidWZmZXIgcHJpbnRpbmcg
ZnVuY3Rpb25zICovCiAjZGVmaW5lIEVNSVQoYywgLi4uKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgIGRvIHsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKLS0gCjIuMjUuMQoK

