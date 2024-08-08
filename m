Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA073C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 03:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbu3k-0008Jb-Qw; Wed, 07 Aug 2024 23:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3i-0008Gj-R0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3h-0006ie-6m
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477HLYpX007155;
 Thu, 8 Aug 2024 03:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Y5l+642gCuPFBeG2sRcwkW
 kOv32uX1BpLuroPRHYbJY=; b=kjER+DGYxt0mnjQdFvjiI2ZhSXUNL1H2HzcDX3
 CRUCq+zs60bLTnyUqHgkrdqHyJ2B5SOoy/9PFlUnpu32IzGmNDiSLBtrnC1073i1
 Sx326YURMAHJq7RYlFblw4xXclsi6QowhrkJ2ye053o5vR5ZB7zRmA0q3kl2svWu
 MLiHpwNec/u57isTd4XOuU3BvPclQcxFwrR5iqWY3YxYHRK2qSSjcM/i6ILeiq6K
 BHCQ+YQR/VUCWZCL3ILK9EJxBmLKCHOPtaD7P0Y2y5BB9GPHxIAmdbajnFD97J/t
 V45l+q7XZsm13RTLVd6QWW9WTFFcRqIx51YTcAAlY41XZpTg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scx6vq07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Aug 2024 03:43:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4783hJCJ014941
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Aug 2024 03:43:20 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 Aug 2024 20:43:19 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 0/6] hex queue
Date: Wed, 7 Aug 2024 20:42:38 -0700
Message-ID: <20240808034244.4139757-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: kXvDuhRLs93957Kwu9LL7L-riFW9n-GC
X-Proofpoint-GUID: kXvDuhRLs93957Kwu9LL7L-riFW9n-GC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_03,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=714 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080024
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA0YzM5NWFjNDJlNTVmZjhlOWZkNGM5
OTJlMzUxYTA0YjEwNzg1NTAzOgoKICBNZXJnZSB0YWcgJ3B1bGwtdGNnLTIwMjQwODA4JyBvZiBo
dHRwczovL2dpdGxhYi5jb20vcnRoNzY4MC9xZW11IGludG8gc3RhZ2luZyAoMjAyNC0wOC0wOCAw
OTowNzowMCArMTAwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoK
ICBodHRwczovL2dpdGh1Yi5jb20vcXVpYy9xZW11IHRhZ3MvcHVsbC1oZXgtMjAyNDA4MDcKCmZv
ciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA0N2YzMzYxYTNhZjlkNzA5MjE4MDM4YTIzYjg5
MDc1MjUzMTBkMmMzOgoKICB0YXJnZXQvaGV4YWdvbjogc3dpdGNoIHRvIGRjIHNldF9wcm9wcygp
IGxpc3QgKDIwMjQtMDgtMDcgMjA6Mzc6MjEgLTA3MDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkhleGFnb24gdXBkYXRl
czogbGxkYiBwcmVkcywgdjY2IENQVSwgRjJfY29udiogZml4CgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkFudG9uIEpvaGFu
c3NvbiAoMSk6CiAgICAgIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyOiBSZW1vdmUgc2VsZi1h
c3NpZ25tZW50CgpCcmlhbiBDYWluICgzKToKICAgICAgTUFJTlRBSU5FUlM6IEFkZCBteSBoZXhh
Z29uIGdpdCB0cmVlCiAgICAgIHRhcmdldC9oZXhhZ29uOiBkZWZpbmUgYSB2NjYgQ1BVCiAgICAg
IHRhcmdldC9oZXhhZ29uOiBzd2l0Y2ggdG8gZGMgc2V0X3Byb3BzKCkgbGlzdAoKTWF0aGV1cyBU
YXZhcmVzIEJlcm5hcmRpbm8gKDEpOgogICAgICBIZXhhZ29uOiBmaXggRjJfY29udl8qIGluc3Ry
dWN0aW9ucyBmb3IgbmVnYXRpdmUgemVybwoKVGF5bG9yIFNpbXBzb24gKDEpOgogICAgICBIZXhh
Z29uOiBsbGRiIHJlYWQvd3JpdGUgcHJlZGljYXRlIHJlZ2lzdGVycyBwMC9wMS9wMi9wMwoKIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCiBnZGIteG1sL2hl
eGFnb24tY29yZS54bWwgICAgICAgICAgICAgICAgIHwgIDYgKysrKystCiB0YXJnZXQvaGV4YWdv
bi9jcHUtcW9tLmggICAgICAgICAgICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vY3B1LmMg
ICAgICAgICAgICAgICAgICAgICB8IDIwICsrKysrKysrKystLS0tLS0tLS0tCiB0YXJnZXQvaGV4
YWdvbi9nZGJzdHViLmMgICAgICAgICAgICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrLQog
dGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIueSB8ICAxIC0KIHRhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAgICAgICAgfCAxOCArKysrKysrKystLS0tLS0tLS0K
IHRlc3RzL3RjZy9oZXhhZ29uL3Vzci5jICAgICAgICAgICAgICAgICAgfCAxMiArKysrKysrKysr
Ky0KIDggZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCg==

