Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECAFCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4qi-0007DS-LD; Wed, 14 Oct 2026 15:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH4qe-0007CZ-07
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:41:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH4qc-0001Wm-Ft
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:41:11 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbKHX152564
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zzkaOcGK41tH3xorOl6vNl
 0quD1w7Ocvy19G4XmlrOw=; b=TI9Argm0A6zRrvtvt2SxMP2MRwHzLk7oHxYJpz
 jdaS4gPg8g80ltbh0hijDovFzoWAQjZ7GCi1N+I1AIidaBVDlO+QjmLLeWgLYYZl
 WTij0eFAqr/y/LMiq3q+KqbikeS/930Ck6p0I71V3+sphep7B3OoD7klcKqsch5c
 PfEwnGRNUhzMhwaCSIPj2My8J/WNypVM7DVD2AcHU3QU0XqkrIgm0whykT247Gga
 wZX6oPrAxded6wNtUsSf7dHI2Bn1FGebHQh6yyEYN5YoCTCQnbVPHCaKTQKCCu0O
 k0tFgMitQrE08KwmNLGqxzLuqv+JafrBh9lCW9FtwhXnzeEg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aejc4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:41:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso61232eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792006868; x=1792611668; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zzkaOcGK41tH3xorOl6vNl0quD1w7Ocvy19G4XmlrOw=;
 b=Y+8Gvw2SFK57hH4no4U8r2Kv5xdluPTox09Y21f6iIjGboKStaNOpB+qqwWaTtcY9N
 hxHzN9IcbX+A27WXysmodNJWv2etuAc8kmgJBcHgYfECzNRppMaUmN8p3pM4IkXzwBf1
 95AA4QBgOBiJRyPjPLUJaL/DPvKpQJbk1dtljAV9ZdvseKaZj2DkOtHQmVmBzCfUdqTq
 Tb06GTOe2sfsBuWFTWJCSJNhMuNxWei6G7szHHf5NSKMj73hjFQ6QexTgvJyczQurEbF
 g+42BX6On/VwMQi12gmHUdcmD0YeIRAcPNKp0QTreYVgpgJSjWKknU3LnJgPbxCduMua
 vMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006868; x=1792611668;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zzkaOcGK41tH3xorOl6vNl0quD1w7Ocvy19G4XmlrOw=;
 b=ewPUxK5/D/ReJiAdFdZNRraJdaObOjHcQhQkmmOUrxi2xGMhNrNCApunfQv0JRVj7a
 jrDkHOusQb48tBLojGRth6DIkfQ0CntdvEDklsDfXO3A0Hs3SL/LW5swqjfqa9DlTlH1
 H2s2StSpSRhsj7EhoIRAYiA6Sz1F1JH/vLWuMDeFJHM7jjcw4xPLX3dFBfHOWO8+mQSp
 UFnuK8uZLUpkrzxDWC1ijedYCJvlwtoAZH8WrR203w2gy30W9xjCH+yBqSzp6Gb9/LM3
 SEjnjhszdd3x7TNQj/KY8PgpXYnG04DnIU7KtSi27obLDKU7d5Hjq3c+VdrFuigcCPSy
 OWkw==
X-Gm-Message-State: AFq9FYLHd/odEC3vxmx2N4ym6JTXam8KoR0hTcPhWYOQFrbWBduzaMGc
 p0KdUlh0DuJWbpAE7EVohLr0DrOzNXn/sUBfrzv2c9kmN8p+4FekOduPr0JfMScLzOjwxi3PUr8
 pkhr56lRGqL522Dk9jlWA8EbWVfcoJHdV1JhsozbdwB8LnE1gIQQYjRi2rduezX+4aA==
X-Gm-Gg: AYBFou00+El6BwiZzhi7CJzzAXkIHNbkbw/NwEMOg5GkulUvR3fe+D189ao67U4lDMG
 l5WZ3KPnn2MWeK5ogr8N5VEzOA9Rl6pEHCoovTgtVHjnLakGpfzn9C0E3esCEzTNWyyqPiCcjZu
 fNHshWMGAHWTLbPMOy777aJxJKCKEah8+axgsdsrWmBr0HvBuCWqn74VkKZqZgGFj1RZDRlJN+h
 0Xxy1tU0FHqsFPlWlJJY80wTnJxxrdNfm+gW4oQteloTD5TovNG92R6/i3nMwG9cju4MCvFNkHn
 V1mJmMNn1Fz9YKzU8lS8HXM6QFcA12dxDO3QaTxf46lAXHBe6Ik8akAiFLtq9x5d2vH1bPx+6+b
 flEqoCMCl7oJa1cUu/Wn3lAscS5RUtGUPdAya/i5L49YYsxO7
X-Received: by 2002:a05:7301:1c90:b0:35d:119b:edb with SMTP id
 5a478bee46e88-35d119b109fmr5711706eec.23.1792006868310; 
 Wed, 14 Oct 2026 12:41:08 -0700 (PDT)
X-Received: by 2002:a05:7301:1c90:b0:35d:119b:edb with SMTP id
 5a478bee46e88-35d119b109fmr5711674eec.23.1792006867482; 
 Wed, 14 Oct 2026 12:41:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2954bsm57393658eec.26.2026.10.14.12.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:41:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/4] hexagon: model the PCYCLE registers
Date: Wed, 14 Oct 2026 12:41:02 -0700
Message-Id: <20261014194106.3205338-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7_IqHAPQvxx-SOLGBz6u3hSDSzx61gOY
X-Proofpoint-GUID: 7_IqHAPQvxx-SOLGBz6u3hSDSzx61gOY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX/YUUGVTr+DdN
 bB++bSEE5mY7omA5aHbvenvnHoPZv6ip0gR08IpydiFnIZeYcH7xpZUtMb964w7Pk3/vloqZCjY
 W78vofC91ArqVhm8xYcMN8KPW4wHmUI=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfdad5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P14OSNEmHmakkKT7keYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX0SkB6eaBkE70
 Uod7cx6MYSn6ipuC/Yb2ZME3EXXg+h+unbTqsZoIXM5TNa+9+h6ohmI6+V2fAUEGs4cPkOatF/j
 6sCI7sUZaFOLeKZ+p1UEud9HXrm8QXLpsNJ2D7Bp92YTrPkkJ+n3GbWKAtINruWSRzc7qxwQin3
 z5Y2YqpG+XLjn9L7n/jA1wcO6mpvDIKWPu0V+KBuVnDRU4LKtBp98agc1cwBs/rdm0tg2PpcsTy
 oiWJBxJfLpKQMWZmaW4ACQ+FK2R5wMbLW+9ULEhdl8qUjophgyYBvnR0COmykZUvT787p6lbMxE
 UDvbZLWMb20Dkcm+HSVq69d4nFMMY3dl6TnJTaSgv522Qnp4XZlTdD217LUC7doquNeIq8Th3DA
 5KFR2K+ZlIHT85TrTpOLt/wts7Q7jyCNJPV1oumsjqn6GpA2Xd4RLIYqKVWKQIKMe1kODvUQLfm
 wvjVRUDQrsYDdQG06Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhlIHBjeWNsZSByZWdpc3RlcnMgbWVhc3VyZSBhY3Rpdml0eSAtIGEgdmVyeSBjb2Fyc2UgYW5k
IHNpbXBsZSBQTVUtbGlrZQpmZWF0dXJlLiAgVGhlIGJhc2VsaW5lIGhhZCBhICJjb3VudCB0aGUg
aW5zdHJ1Y3Rpb25zIHBlciBUQiBhbmQgc2NhbGUgYQpjb3VudGVyIiBtb2RlbCAodG8gYmUgc3Vt
bWVkIGFjcm9zcyB2Q1BVcyB1cG9uIHJlZyByZWFkKS4gIEJ1dCB0aGF0J3Mgbm90CmEgZ29vZCBt
b2RlbCBhbmQgaXQgYWRkcyB3b3JrIHRvIGFsbCBUQnMuCgpJbnN0ZWFkOiB3ZSdsbCB1c2UgdGlt
ZSBhcyBhIHNsaWdodGx5IGJldHRlciBtb2RlbCwgYnV0IG9ubHkgYWNjdW11bGF0aW5nCndoZW4g
dGhlcmUncyBhY3Rpdml0eS4gIFVzaW5nIGEgY2xvY2sgaXMgdW5mb3J0dW5hdGVseSBsZXNzIHN0
YWJsZSBhY3Jvc3MKaG9zdHMgYW5kIGNoYW5nZXMgdG8gdHJhbnNsYXRpb24sIGJ1dCBzdGlsbCBh
IG5ldCBpbXByb3ZlbWVudCBhbGwgdGhpbmdzCmNvbnNpZGVyZWQuCgpJbiB2MjoKLSBSZW1vdmVk
ICJwY3ljbGVfZnJlcV9oeiIgcHJvcGVydHkuCi0gTW92ZWQgZGVsZXRpb25zIGludG8gInJlbW92
ZSBwYWNrZXQtY291bnQgUENZQ0xFIGltcGxlbWVudGF0aW9uIiBwYXRjaAphdCB0aGUgc3RhcnQg
b2YgdGhlIHNlcmllcy4KLSBSZW1vdmVkIHRyYW5zbGF0b3JfaW9fc3RhcnQoKSBmcm9tIHN0YXJ0
L3N0b3Avd2FpdC9yZXN1bWUgaW5zdHJ1Y3Rpb25zOgp0aGVzZSBkbyBub3QgdHJpZ2dlciBJL08u
Ci0gYWRkZWQgY29tbWVudCB1cGRhdGUgZm9yIHRyYW5zbGF0b3JfaW9fc3RhcnQoKQoKdjE6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjEwMDkwMDM1MjEuMjIyNzE1NS0x
LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENhaW4gKDQpOgogIHRhcmdldC9o
ZXhhZ29uOiByZW1vdmUgcGFja2V0LWNvdW50IFBDWUNMRSBpbXBsZW1lbnRhdGlvbgogIGh3L2hl
eGFnb246IG1vZGVsIFBDWUNMRSB3aXRoIHZpcnR1YWwgY2xvY2sKICB0YXJnZXQvaGV4YWdvbjog
bWFyayBjbG9jay1iYWNrZWQgcmVnaXN0ZXIgcmVhZHMgYXMgSS9PCiAgZXhlYzogY29ycmVjdCB0
cmFuc2xhdG9yX2lvX3N0YXJ0IGRvY3VtZW50YXRpb24KCiBpbmNsdWRlL2V4ZWMvdHJhbnNsYXRv
ci5oICAgICAgICAgICAgICB8ICAgNSArLQogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fZ2xv
YmFscmVnLmggfCAgIDUgKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAg
fCAgIDIgLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oICAgICAgICAgICAgfCAgIDYgLS0K
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggICAgICAgICAgIHwgICA4ICstCiB0YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaCAgICAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuaCAgICAgICAgICAgICB8ICAgMiAtCiBody9oZXhhZ29uL2hleGFnb25fZ2xvYmFs
cmVnLmMgICAgICAgICB8IDEyOSArKysrKysrKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4
YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICB8ICAxMCArLQogdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jICAgICAgICAgICAgfCAgNzkgLS0tLS0tLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYyAgICAgICAgICAgICAgICB8ICAzOCArKysrKysrLQogdGFyZ2V0L2hleGFnb24v
aGV4c3dpLmMgICAgICAgICAgICAgICAgfCAgMTAgKy0KIHRhcmdldC9oZXhhZ29uL21hY2hpbmUu
YyAgICAgICAgICAgICAgIHwgICAyICstCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAg
ICAgICAgICB8ICA0NSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAg
ICAgICAgIHwgIDIxIC0tLS0KIGh3L2hleGFnb24vdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAg
IHwgICAxICsKIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgICAgICAgICAgIHwgICA4ICst
CiAxNyBmaWxlcyBjaGFuZ2VkLCAyNDQgaW5zZXJ0aW9ucygrKSwgMTI5IGRlbGV0aW9ucygtKQoK
LS0gCjIuMzQuMQoK

