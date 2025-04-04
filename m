Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61889C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XAY-0005vH-Ig; Thu, 03 Apr 2025 22:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAW-0005uU-6C
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAR-0006lF-04
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:31 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341OBZG012942
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 02:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Gstu/tBqXRTw6kzgDYlTuH
 sTlQMsY3iKtjphp97K9WI=; b=PIfThtAvQ2ODFrZq78vqDw2fBj3iil/sePilqg
 g/vZVGkMgxTTqEcS5lBRdFZuwxDLEiFAPKnEcDfTvWu3fZ7NJc7/4EaJbHC5G3ca
 JpNLICGshrU8PBFkXhGUxL0S90JaZa5Xt8VZ/VrkBLfOWrF8NtrNNv127y5PsFmy
 Httv+IOZ5LmEO/4cioDKYIgkHnhBTmOdKiCEnSHwf9VRW11NOHqb9W4maLeFj/Ex
 YeG+HtyB5dBAGDMDficpCyr9G1sCi8PtIG7C4or1QmicdbZTXFqLSupfa1rBiVzm
 3hz1Kv/DfwnaGr8iYitl036zrK4FzSznYIvHr6n9+I7VhyJQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d88fxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:52:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2241e7e3addso14040725ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 19:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735142; x=1744339942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gstu/tBqXRTw6kzgDYlTuHsTlQMsY3iKtjphp97K9WI=;
 b=oJPomkMf4cjjdTBEst6zip5ndyDoSqCHhjc1822uCMK/ZeHiGoQPus2cbuB2SzZhwc
 IqhA4slZAVZWeg0wos5/duG0di8LxIlHaQyzhn3lhPbQ/POf/bRsBVJVCpD9WUMZDXWy
 VSW5yBuU/RQ0QpyYOqXWtwr2f4FrJhivWjJ97m4o9Moh9H7UhuBM17VE1+qtFJUNEoiR
 rghNIIACqjGHKlE3QfeuPEVgj0PhkFtXsDfe9RWQBgJcQh5swQosSEM8wJ+2DTPZQMNQ
 u4TegIzqqpHgkG0ksmCBFnazjnnK0JWLvXTFNjwGDjxCKAKOv7Ks7cn8g2x6KqT5oENZ
 nmrA==
X-Gm-Message-State: AOJu0Yy2rXwcETPrGgnB9F7GEJhbGqzACVRIPKOVcvl7M2sfNMj2QFY/
 jkKvosoQ9+ZhofebLpAdx0a0yXtkx+td243CujXYRcCyJ5OjTs/6H+YiYfiFQx8c6bPH8lyRjzx
 qUvK9B6i5vQIfXtmJadZXwh6ga/dmonlTExiYy6NhqQNrnHQrVFeLDV7Rrc0UuQ==
X-Gm-Gg: ASbGnctPvNwbsmJBw0xBu0KdZWGD+aNJDcqp44xHcmTqK4dFAnfiGwRTYSfrRWjjot3
 daJlaVmaNfKENfzWNgiNOtD25A29ZZ3D3eLZfrMdMPoHRGjz+KpolImEqN924kMJFHYzGVrfX5y
 zDhh8KtKcKfIW8d4rQBdyTfOjc1kxftAeZF/VApnR8IUZWPTpMPB/IoxeOPcFrKibVpupexBFRG
 jrQ8icZU4VwqCWQ4vTq+0KJs5nWBp40bNaZtbcO5F2xzxcT9e14rl8wqluzCeChQuXnj8gsYWE9
 fVQpNozPjGHBKLyZJ9c2OdC7Z2ffbbupTBsO3/IFU4QErbYB12/dMAzigF1K3KBT
X-Received: by 2002:a17:902:7049:b0:224:1c41:a4cd with SMTP id
 d9443c01a7336-22a8a04a7admr14007745ad.3.1743735142246; 
 Thu, 03 Apr 2025 19:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4lRXUBF5/VqyifTqTQz5CjR020VG20L/EQhCcib4Xl8o6/Y+2faPykN8f3YFycSuRNScmWA==
X-Received: by 2002:a17:902:7049:b0:224:1c41:a4cd with SMTP id
 d9443c01a7336-22a8a04a7admr14007455ad.3.1743735141795; 
 Thu, 03 Apr 2025 19:52:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ea16bsm22014865ad.106.2025.04.03.19.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 19:52:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH 0/6] misc hexagon patches
Date: Thu,  3 Apr 2025 19:51:57 -0700
Message-Id: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=PqmTbxM3 c=1 sm=1 tr=0 ts=67ef4967 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=I1QJYFklsTE04U9Y_lgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: pLSnUXEwnGcaJagk-qxbbc0hLMMFPNc0
X-Proofpoint-GUID: pLSnUXEwnGcaJagk-qxbbc0hLMMFPNc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=903 mlxscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

V2hpbGUgcHJlcGFyaW5nIHRoZSBzeXN0ZW0gZW11bGF0aW9uIHBhdGNoZXMsIHRoZXNlIG9uZXMg
c3R1Y2sgb3V0IGFzCm5vdC1zdHJpY3RseS1yZWxhdGVkIHRvIHN5c2VtdS4gIFdlIGNhbiByZXZp
ZXcgYW5kIGFwcGx5IHRoZW0gaW5kZXBlbmRlbnRseQpvZiB0aG9zZS4KCkJyaWFuIENhaW4gKDYp
OgogIHRhcmdldC9oZXhhZ29uOiBoYW5kbGUgLm5ldyB2YWx1ZXMKICB0YXJnZXQvaGV4YWdvbjog
Rml4IGJhZHZhIHJlZmVyZW5jZSwgZGVsZXRlIENBVVNFCiAgdGFyZ2V0L2hleGFnb246IEFkZCBt
aXNzaW5nIEFfQ0FMTCBhdHRyLCBoaW50anVtcHIgdG8gbXVsdGlfY29mCiAgdGFyZ2V0L2hleGFn
b246IHMvcGt0X2hhc19zdG9yZS9wa3RfaGFzX3NjYWxhcl9zdG9yZQogIHRhcmdldC9oZXhhZ29u
OiBSZW1vdmUgdW5yZWFjaGFibGUKICB0YXJnZXQvaGV4YWdvbjogQWRkIG1lbW9yeSBvcmRlciBk
ZWZpbml0aW9uCgogdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvUkVBRE1FLnJzdCAgICAgICB8
ICAyICstCiB0YXJnZXQvaGV4YWdvbi9jcHUtcGFyYW0uaCAgICAgICAgICAgICAgICAgIHwgIDUg
KysrCiB0YXJnZXQvaGV4YWdvbi9pbnNuLmggICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0t
CiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICAgICAgICAgICAgIHwgIDggKystLS0K
IHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArLQogdGFy
Z2V0L2hleGFnb24vZGVjb2RlLmMgICAgICAgICAgICAgICAgICAgICB8IDEwICsrKystLQogdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgICAgICAgICB8ICAzICstCiB0YXJnZXQv
aGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgIDQgKy0tCiB0YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgIDQgKy0tCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgIHwgIDkgKysrLS0tCiB0YXJnZXQvaGV4YWdv
bi9nZW5faGVscGVyX2Z1bmNzLnB5ICAgICAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgICAgICAgICAgICAgICAgfCAzNCArKysrKysrKysrKysrKysrLS0tLS0KIDEy
IGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQoKLS0gCjIu
MzQuMQoK

