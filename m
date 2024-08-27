Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBD0C5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 00:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sik37-0005VL-Lw; Mon, 26 Aug 2024 20:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sik32-0005Fm-B2
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:27:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sik2z-0007Ly-5w
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:26:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJH9So023942;
 Tue, 27 Aug 2024 00:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pOTSfsBCN3ongbGBkqnRjZTjN4uF78YnvzrrgnfuEaU=; b=TGqKwZjxPPFH9Wmf
 8GZNcQtp1GSqjlHERAbuaHLmB+uJjM7GTab2YS+Uz4pix2G0twlUK9SyrxdpjvWd
 hDsw7YuxQCZvbGiIG1eZIVEiHOSELTLOp2a/4dyKDCOs+rtHTxB1dYIvN99M3LOT
 CvSnuP3wjLQfomyz4uCgiXfrXE/GCclAuhKAXeOH/IwCJ0oR6GP+4yDA2JFDYPU3
 qHJl9qasEM/cvo7rBkoI9YMy8EC7zo+i2gqF7Tip0aaQYPcsP6DYDhsCGp3k2yWR
 TifofaCkdN7jxaCiDWwVGWEBwZbAkkUrSgC984wZ+EES8CZh1aGl3VgLx80CHc/1
 liJDBQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41798kd5aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Aug 2024 00:26:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R0QpgB015009
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Aug 2024 00:26:51 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 17:26:51 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH v2 2/2] target/hexagon: add enums for event, cause
Date: Mon, 26 Aug 2024 17:26:31 -0700
Message-ID: <20240827002631.3492200-3-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827002631.3492200-1-bcain@quicinc.com>
References: <20240827002631.3492200-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: yrNHkQq5k3WwSbBvB_j6Jrk7x3cShOJK
X-Proofpoint-ORIG-GUID: yrNHkQq5k3WwSbBvB_j6Jrk7x3cShOJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_17,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=780
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270002
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
IDJlNjBjMGZhZmUuLmZmNTk2ZTJhOTQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9i
aXRzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaApAQCAtMjMsMTUgKzIzLDIxIEBA
CiAjZGVmaW5lIFBDQUxJR04gNAogI2RlZmluZSBQQ0FMSUdOX01BU0sgKFBDQUxJR04gLSAxKQog
Ci0jZGVmaW5lIEhFWF9FVkVOVF9UUkFQMCAgICAgICAgICAgMHgwMDgKK2VudW0gaGV4X2V2ZW50
IHsKKyAgICBIRVhfRVZFTlRfTk9ORSAgICAgICAgICAgPSAtMSwKKyAgICBIRVhfRVZFTlRfVFJB
UDAgICAgICAgICAgPSAgMHgwMDgsCit9OwogCi0jZGVmaW5lIEhFWF9DQVVTRV9UUkFQMCAgICAg
ICAgICAgMHgxNzIKLSNkZWZpbmUgSEVYX0NBVVNFX0ZFVENIX05PX1VQQUdFICAweDAxMgotI2Rl
ZmluZSBIRVhfQ0FVU0VfSU5WQUxJRF9QQUNLRVQgIDB4MDE1Ci0jZGVmaW5lIEhFWF9DQVVTRV9J
TlZBTElEX09QQ09ERSAgMHgwMTUKLSNkZWZpbmUgSEVYX0NBVVNFX1BDX05PVF9BTElHTkVEICAw
eDAxZQotI2RlZmluZSBIRVhfQ0FVU0VfUFJJVl9OT19VUkVBRCAgIDB4MDI0Ci0jZGVmaW5lIEhF
WF9DQVVTRV9QUklWX05PX1VXUklURSAgMHgwMjUKK2VudW0gaGV4X2NhdXNlIHsKKyAgICBIRVhf
Q0FVU0VfTk9ORSA9IC0xLAorICAgIEhFWF9DQVVTRV9UUkFQMCA9IDB4MTcyLAorICAgIEhFWF9D
QVVTRV9GRVRDSF9OT19VUEFHRSA9ICAweDAxMiwKKyAgICBIRVhfQ0FVU0VfSU5WQUxJRF9QQUNL
RVQgPSAgMHgwMTUsCisgICAgSEVYX0NBVVNFX0lOVkFMSURfT1BDT0RFID0gIDB4MDE1LAorICAg
IEhFWF9DQVVTRV9QQ19OT1RfQUxJR05FRCA9ICAweDAxZSwKKyAgICBIRVhfQ0FVU0VfUFJJVl9O
T19VUkVBRCAgPSAgMHgwMjQsCisgICAgSEVYX0NBVVNFX1BSSVZfTk9fVVdSSVRFID0gIDB4MDI1
LAorfTsKIAogI2RlZmluZSBQQUNLRVRfV09SRFNfTUFYICAgICAgICAgNAogCi0tIAoyLjM0LjEK
Cg==

