Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D9AC41513
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 00:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG6sF-0007kd-MC; Sat, 08 Jun 2024 20:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sC-0007jn-Ij
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6s9-0003tH-UG
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4590rZvq008678;
 Sun, 9 Jun 2024 00:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rnp9BnqG5V6n3HcmqslTpm
 +ngWs30LzmQPYx0MVvw1E=; b=eoSlvKfAxpPEhKBQC01uwHRNbcyaV9BsRbnX4b
 ozCMOOQoHeCuQnPJp6d2McMyjKbutieo6sJRa2Dlq62i0qgENP7hcT6WOnyjyFO1
 eMLFFKyjiN8ATaIxYOUe0IishHF96iUCqVtEKzUWo4zj4ynPhdMbzAvmleGfCyD+
 uXGht4+1dsOuRnEpZJHrvUkZvE8HkhEa/tmkxdksqPZivNdydiU76LVrXxT7LxnJ
 JMXlFtOsDoC4s2N9xu85juPom/u/W9f+tOIi/GE8tgOLSxLAbY0BSlOBI0xnFbWf
 RsLeYD9GjhnsdUKbKqtXQ1UmKHcqe7kg2thDTKGXCekTDJRg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfp793cu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 00:57:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4590vKNR012843
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 9 Jun 2024 00:57:20 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 17:57:19 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 0/6] hex queue
Date: Sat, 8 Jun 2024 17:56:59 -0700
Message-ID: <20240609005705.2809037-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: sQPCKOh4BieUsl68K02vXOhknXGXEj9j
X-Proofpoint-ORIG-GUID: sQPCKOh4BieUsl68K02vXOhknXGXEj9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090005
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAzZTI0NmRhMmMzZjg1Mjk4YjUyZjhh
MTE1NGI4MzJhY2YzNmFhNjU2OgoKICBNZXJnZSB0YWcgJ2Zvci11cHN0cmVhbScgb2YgaHR0cHM6
Ly9naXRsYWIuY29tL2JvbnppbmkvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjQtMDYtMDggMDc6NDA6
MDggLTA3MDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAgaHR0
cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdSB0YWdzL3B1bGwtaGV4LTIwMjQwNjA4Cgpmb3IgeW91
IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gMTk2N2ExZWE5ODUyOTljMDkwZGZkM2VmYzFlNTMyM2Nl
NjBkNzVkZjoKCiAgdGFyZ2V0L2hleGFnb246IGlkZWYtcGFyc2VyIHNpbXBsaWZ5IHByZWRpY2F0
ZSBpbml0ICgyMDI0LTA2LTA4IDE3OjQ5OjM2IC0wNzAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoqIGhleGFnb246IGlk
ZWYtcGFyc2VyIGNsZWFudXAKKiBoZXhhZ29uOiBpbXBsZW1lbnQgUEMgYWxpZ25tZW50IGV4Y2Vw
dGlvbiwgdGVzdHMKKiBoZXhhZ29uOiBmaXggZm9yIEhWWCBuZXctdmFsdWUgc3RvcmUKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KQW50b24gSm9oYW5zc29uICg0KToKICAgICAgdGFyZ2V0L2hleGFnb246IGlkZWYtcGFyc2Vy
IHJlbW92ZSB1bnVzZWQgZGVmaW5lcwogICAgICB0YXJnZXQvaGV4YWdvbjogaWRlZi1wYXJzZXIg
cmVtb3ZlIHVuZGVmaW5lZCBmdW5jdGlvbnMKICAgICAgdGFyZ2V0L2hleGFnb246IGlkZWYtcGFy
c2VyIGZpeCBsZWFrIG9mIGluaXRfbGlzdAogICAgICB0YXJnZXQvaGV4YWdvbjogaWRlZi1wYXJz
ZXIgc2ltcGxpZnkgcHJlZGljYXRlIGluaXQKCk1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vICgy
KToKICAgICAgSGV4YWdvbjogZml4IEhWWCBzdG9yZSBuZXcKICAgICAgSGV4YWdvbjogYWRkIFBD
IGFsaWdubWVudCBjaGVjayBhbmQgZXhjZXB0aW9uCgogbGludXgtdXNlci9oZXhhZ29uL2NwdV9s
b29wLmMgICAgICAgICAgICAgICB8ICAgNCArKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNyArKwogdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaCAgICAg
ICAgICAgICAgICAgICB8ICAgNCArKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5
ICAgICAgICAgICB8ICAgOSArKy0KIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFy
c2VyLmggICAgfCAgMTAgLS0tCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNl
ci55ICAgIHwgICAyIC0KIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJz
LmMgfCAgMzUgKysrKystLS0tCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVs
cGVycy5oIHwgIDEzIC0tLS0KIHRhcmdldC9oZXhhZ29uL21hY3Jvcy5oICAgICAgICAgICAgICAg
ICAgICAgfCAgIDMgLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAg
ICB8ICAgOSArKy0KIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCAgICAgICAgICAg
fCAgIDIgKwogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyAgICAgICAgICAgICAgICB8ICAy
MyArKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3VuYWxpZ25lZF9wYy5jICAgICAgICAgICAgfCAx
MDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMTMgZmlsZXMgY2hhbmdlZCwgMTc5IGlu
c2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Rj
Zy9oZXhhZ29uL3VuYWxpZ25lZF9wYy5jCg==

