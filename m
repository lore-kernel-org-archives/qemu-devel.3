Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A51DC531DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 19:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf2Ht-0002BQ-WB; Fri, 16 Aug 2024 15:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sf2Hp-00022F-Ur
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 15:06:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sf2Hn-00079g-2y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 15:06:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GACbZ1025763;
 Fri, 16 Aug 2024 19:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iPFLWsO2ILgEOJ70nf7HP+F3islwW4ItHhi4sOT7iMw=; b=V++S1slXaIeKIExC
 N2is7yS2ytUFUwrPTsdwuMzYLiURpHj2x5tm0ZQgY3gX7axUB8wIbTednPFYhsMw
 CDlYNu9K8wB9Tb68/QTlL6yXVXxtugVLKbiAUPWZF1z7cxufG4l4hl4tBDorSHjR
 64lm1BhBUMU5dyA/+FoZ9r5NdrqLwytHuPps0/8i+js3kR0rkJAv9L4Vs3aEthmq
 VF9aLhiLDaYFxiZBKdtxb17/aUNskcykvfPMsASzUIDbNC89H0IY9/Md+AljcPge
 TrZTh+em6cdSNCdPeRgNau3uhAdVcxomSN3Lf0c7BH0Womk9GL+BMzRYSEjdXMOT
 2jwkHQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411s5pjrkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2024 19:06:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GJ6nJd007097
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2024 19:06:49 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 16 Aug 2024 12:06:48 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH 2/3] target/hexagon: rename HEX_EVENT_TRAP0=>HEX_CAUSE_TRAP0
Date: Fri, 16 Aug 2024 12:06:18 -0700
Message-ID: <20240816190620.1418311-2-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816190620.1418311-1-bcain@quicinc.com>
References: <20240816190620.1418311-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 8hpZPflLBI34d3jc3mXjl1aJQSgB7IhB
X-Proofpoint-ORIG-GUID: 8hpZPflLBI34d3jc3mXjl1aJQSgB7IhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_13,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 mlxlogscore=812 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160135
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
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

VGhlIHZhbHVlIHByZXZpb3VzbHkgdXNlZCBmb3IgIkhFWF9FVkVOVF9UUkFQMCIgd2FzIHRoZSBj
YXVzZSBjb2RlCmRlZmluaXRpb24gYW5kIG5vdCB0aGUgZXZlbnQgbnVtYmVyLiAgU28gaW4gdGhp
cyBjb21taXQsIHdlIHVwZGF0ZQp0aGUgbmFtZSB0byByZWZsZWN0IHRoZSBjYXVzZSBjb2RlIGFu
ZCBhZGQgYSBuZXcgIkhFWF9FVkVOVF9UUkFQMCIKd2l0aCB0aGUgY29ycmVjdCBldmVudCBudW1i
ZXIuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVf
Yml0cy5oIGIvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAppbmRleCA1YTcxYWYyNDY5Li5lZWM0
NTZkOGY5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdV9iaXRzLmgKQEAgLTIzLDYgKzIzLDcgQEAKICNkZWZpbmUgUENBTElHTiA0
CiAjZGVmaW5lIFBDQUxJR05fTUFTSyAoUENBTElHTiAtIDEpCiAKKyNkZWZpbmUgSEVYX0VWRU5U
X1RSQVAwICAgICAgICAgICAweDAwOAogI2RlZmluZSBIRVhfRVZFTlRfRkVUQ0hfTk9fVVBBR0Ug
IDB4MDEyCiAjZGVmaW5lIEhFWF9FVkVOVF9JTlZBTElEX1BBQ0tFVCAgMHgwMTUKICNkZWZpbmUg
SEVYX0VWRU5UX0lOVkFMSURfT1BDT0RFICAweDAxNQpAQCAtMzAsNyArMzEsNyBAQAogI2RlZmlu
ZSBIRVhfRVZFTlRfUFJJVl9OT19VUkVBRCAgIDB4MDI0CiAjZGVmaW5lIEhFWF9FVkVOVF9QUklW
X05PX1VXUklURSAgMHgwMjUKIAotI2RlZmluZSBIRVhfRVZFTlRfVFJBUDAgICAgICAgICAgIDB4
MTcyCisjZGVmaW5lIEhFWF9DQVVTRV9UUkFQMCAgICAgICAgICAgMHgxNzIKIAogI2RlZmluZSBQ
QUNLRVRfV09SRFNfTUFYICAgICAgICAgNAogCi0tIAoyLjM0LjEKCg==

