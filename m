Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A34C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 19:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf2Hq-00022c-VJ; Fri, 16 Aug 2024 15:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sf2Ho-00021D-Lz
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 15:06:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sf2Hn-00079i-32
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 15:06:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G8Ykh5026844;
 Fri, 16 Aug 2024 19:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xgA5wU65XRlW0tuFfHeXs0wJuPPnpaaaFwCSeJrNZkM=; b=LBGpdSATHw1HLUdY
 GAoxjukyi4AQuGt8cKHwzXTccX3ibsKqVPASOl63KTe2T4yehOsI8yeFcuL4EA8o
 ClB7xFKHaGZJe3MGh17S/J2C/gzmR6GM0ND9/Ztt/zP6jQZ29dnGkmKVH3hXtFI2
 ZtkqxfiVKu3ETaMC3vILlVrgYFdRX75wuSdHXOlMvTgfYJmxBnT2TBv62F9sJSK1
 2YFcb2a7L+Q0dQ4dzNuucce2OdDYXAvvOZOPzDH++t1S9+pPmqP1pvlf3m3Q86CE
 f7q5Bc7BI99JisxZ5ZqOKXprS9IH5mlIVXt8285bvSi/XqBSVamGwZJzYAB3Mrr2
 4JoFLQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4123cr9h6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2024 19:06:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GJ6nd3016883
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2024 19:06:49 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 16 Aug 2024 12:06:49 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH 3/3] target/hexagon: add enums for event, cause
Date: Fri, 16 Aug 2024 12:06:19 -0700
Message-ID: <20240816190620.1418311-3-bcain@quicinc.com>
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
X-Proofpoint-GUID: 4VRy0erSGpxr7ZH4nLubrdCl1MdVSK-r
X-Proofpoint-ORIG-GUID: 4VRy0erSGpxr7ZH4nLubrdCl1MdVSK-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_13,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 mlxlogscore=781 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160135
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vY3B1X2JpdHMuaCB8IDIyICsrKysrKysrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2NwdV9iaXRzLmggYi90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCmluZGV4
IGVlYzQ1NmQ4ZjkuLjI0NTRlZjcyYmYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9i
aXRzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaApAQCAtMjMsMTUgKzIzLDIxIEBA
CiAjZGVmaW5lIFBDQUxJR04gNAogI2RlZmluZSBQQ0FMSUdOX01BU0sgKFBDQUxJR04gLSAxKQog
Ci0jZGVmaW5lIEhFWF9FVkVOVF9UUkFQMCAgICAgICAgICAgMHgwMDgKLSNkZWZpbmUgSEVYX0VW
RU5UX0ZFVENIX05PX1VQQUdFICAweDAxMgotI2RlZmluZSBIRVhfRVZFTlRfSU5WQUxJRF9QQUNL
RVQgIDB4MDE1Ci0jZGVmaW5lIEhFWF9FVkVOVF9JTlZBTElEX09QQ09ERSAgMHgwMTUKLSNkZWZp
bmUgSEVYX0VWRU5UX1BDX05PVF9BTElHTkVEICAweDAxZQotI2RlZmluZSBIRVhfRVZFTlRfUFJJ
Vl9OT19VUkVBRCAgIDB4MDI0Ci0jZGVmaW5lIEhFWF9FVkVOVF9QUklWX05PX1VXUklURSAgMHgw
MjUKK2VudW0gaGV4X2V2ZW50IHsKKyAgICBIRVhfRVZFTlRfTk9ORSAgICAgICAgICAgPSAtMSwK
KyAgICBIRVhfRVZFTlRfVFJBUDAgICAgICAgICAgPSAgMHgwMDgsCisgICAgSEVYX0VWRU5UX0ZF
VENIX05PX1VQQUdFID0gIDB4MDEyLAorICAgIEhFWF9FVkVOVF9JTlZBTElEX1BBQ0tFVCA9ICAw
eDAxNSwKKyAgICBIRVhfRVZFTlRfSU5WQUxJRF9PUENPREUgPSAgMHgwMTUsCisgICAgSEVYX0VW
RU5UX1BDX05PVF9BTElHTkVEID0gIDB4MDFlLAorICAgIEhFWF9FVkVOVF9QUklWX05PX1VSRUFE
ICA9ICAweDAyNCwKKyAgICBIRVhfRVZFTlRfUFJJVl9OT19VV1JJVEUgPSAgMHgwMjUsCit9Owog
Ci0jZGVmaW5lIEhFWF9DQVVTRV9UUkFQMCAgICAgICAgICAgMHgxNzIKK2VudW0gaGV4X2NhdXNl
IHsKKyAgICBIRVhfQ0FVU0VfTk9ORSA9IC0xLAorICAgIEhFWF9DQVVTRV9UUkFQMCA9IDB4MTcy
LAorfTsKIAogI2RlZmluZSBQQUNLRVRfV09SRFNfTUFYICAgICAgICAgNAogCi0tIAoyLjM0LjEK
Cg==

