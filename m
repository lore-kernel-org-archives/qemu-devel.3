Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8CFC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH51b-0005Ne-Gc; Wed, 14 Oct 2026 15:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51a-0005Mv-2i
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51Y-0002UV-4C
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb0Va905393
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uBg72mYBea5q5vrq4G/WaN
 jh9GFvsO3jb7qoqDEoZVM=; b=jZg05kEG4Js++FyFCroZKY4j+giMWSkt605JLw
 pvYjDVcItHta1TVPf3ShDXS+bC2fO1Z7zyL00na2kVBYALEUPdVjtrHaE7+qrzJ4
 vxdMiZ8UYMlHA5dfu5Us9otZ7QUF2HQN2PBMNgah5+8q2KWuSu1/iE7AUNWiZnX8
 7t+GBn6HcTurH20pav+X6re6BzDOOWRN26fOmcPRnK/R4dVoU4ehZkXffXKSVhuR
 u+KPAh1MjpO5JX00MHfxcO4Uxp5LdLKReeW0W2NELvBta9I3ElOul1udC6zuny1i
 qnAGoSRRumnNQNtiKilXCfGCyTGnEvbf1RPyTgFOGYzwLjyg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p3ak6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso9616223eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007545; x=1792612345; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uBg72mYBea5q5vrq4G/WaNjh9GFvsO3jb7qoqDEoZVM=;
 b=KjIwQfptw2LKSlsWj1yuTuNupNrNL4X1LhKXMQb7B+yLKdEC2j1xof32lzWTZz3Yxc
 wJ5BIjCLu5v56KWQOXdyXWpDxO1j3eeJEdL5/x0ju0vZ04+od72OyxqmbHtjuGuT8SZ+
 D8zlGBWP+D5aH1MfENQCOv4/9M0x9lvKpVe6o3vd3sIqSeCapWQQD7qCaphQrNydiUZZ
 4RpR7yAWrjkGnxb1y6Nm38Wb0wOaeAJhax8/IfuRa/oOdvgNcNsyonzPB5xG7usi83X0
 GBp5UlW01hAZnx25vA9Tdx2WYkFGaAMClL10MEqCQqg0Biajo7ZdazohY+qBYivIy/IV
 kNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007545; x=1792612345;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uBg72mYBea5q5vrq4G/WaNjh9GFvsO3jb7qoqDEoZVM=;
 b=kO8NUttDw7zJoxqgVBLRyiLnkU+9QnC2XAN7+cGOhfvUypS7zB3MSuO7aM2RjOEwVf
 Cl8kIRwRjW41pL2wBTsDvEj4RZMDMTR9NhEdoB2pbLzrJ/8z2NWT5o1/Zj2v8v9SlV7M
 dSEwQF4zAmwCneMBFUy3vGzlX2j+diW2PoUUVU5NO08cGQSQTA/FvmdoGbZTFyVFpVMh
 76q2+2j9lbYh6wcdQ9HErm3a4PyRzOrJTpeY1UWTl/I6mtV9TZzpyUXx9b8RMgi8DrQg
 fmi+mdCVMPZHfdHrB9YyfXzIhlg6b4z8JO9eEEj6Rc/eH9x7lL9PjfKc0ppHSezetZxm
 KLeA==
X-Gm-Message-State: AFq9FYKPdXLvcpUx1UntY6e6JPW7baONtKb3/XvvlSIGO5ysvX49v9E9
 MrL+ou0424QLAmKNhReRHHJPNrezvvUNs1SKKWK7A212tCKx76XrJvP06ooR+Dal7/pTrMAlPYo
 zaxvELjJMOjoYzfCiUSmpu/e9iNOlpEtrq65KZblf1P8AJe+Zft+fWwJBjO/ERoOknw==
X-Gm-Gg: AYBFou3gFFX0RuI4DJ3dNv2tEh6kCVB8IpEzn8TWYCZW3dOW3uIIRGAVKyMDuh57OxT
 k6cFxwiqZ27npHdWgbk2CBasYaSbmwy3pByNiuVCKT+z9kPJugMh0BaQhbACHA3dRTq7osn/Cnr
 O0KxW7zCLmBNFY9lkQvziCLD/KkkEQ0Ihk4Hywp8SFQYdb+Y+reJw0XWc8b+6FvuwV0StthBtzQ
 f/MMGQHScuhjErWqxChyVDBEtFZlennLgESCBiahOl8hNebWG3tNCpjgy1APAZNWGd45hcgeksF
 oJIQI9sd5XN3OSEMYjly0m3sVvaTwdk3Av6CYCm52tS2PEJYbMv4DzNmqI+NhgTqhaJPI0jI79v
 lnjqzTAb0BGHbjB72/tWrXmAMs5jMzUS3WgN65FzOWyldHKQ=
X-Received: by 2002:a05:7300:e5c4:b0:353:5d9a:9971 with SMTP id
 5a478bee46e88-3537e088be4mr23170350eec.18.1792007545271; 
 Wed, 14 Oct 2026 12:52:25 -0700 (PDT)
X-Received: by 2002:a05:7300:e5c4:b0:353:5d9a:9971 with SMTP id
 5a478bee46e88-3537e088be4mr23170317eec.18.1792007544662; 
 Wed, 14 Oct 2026 12:52:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35f0c3bcf80sm547069eec.7.2026.10.14.12.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:52:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 00/12] Hexagon: Add support for v83, v85
Date: Wed, 14 Oct 2026 12:52:11 -0700
Message-Id: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfXy+0tAACv3LD3
 nr9gTc1TCX4GQ29rNmlTi83oEKSoTxLu9/nwgOwt15ixlk1CK642aceRjnOSF+Zj0Tmftu8H+i/
 fZOEzPJ9i/lTeW/1eObsRKR5Fw9C0rk=
X-Proofpoint-ORIG-GUID: 9AkUdcOYABLSTJNtitTjdIMRjzbzbIIz
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfdd7a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6M-G-syCC1cE1g_PqpkA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX5qMlzqHg8HQs
 8MxGOCo/pFnNqtlbK1xGHUo6aEuh7TVWAaYHa2h5Nn0XIrCMc+1usAi8kWdNXIUj5E2IPLOfCqD
 ucacZFH9pdFvg9yZswRBqggzNnAaPfxnEi/8erFhKgNicwaD/HJZAeMKpO+N0MxwYWjiYcFzpfu
 aAhfKiCtExhUSjuD4TL2KtRX7zIy0gq5Pm2N8jVHj1L3pzKJSw02ji1QAeWexuWxzaOlfosckWH
 UDSHXKgKCTRcaZY1huzhkhNCF5DFE/1rSkWjGVeT5MuSELoFooz3xo2TwM8pLVJVM1iLqg1g39l
 eTYW8M/hag9idBAmsMR/PJ6d649aOKsrdA0fX0bct8bwInOQWvmeSU2+5XNXT2dIX3cs9RcbyJ2
 mAErMqxDXLLWQMKm1YeFk1nQYehSST09OhKgTyy9NYOpy5gugmVOBu7AsuDrmaUGmEQo67c/F3H
 mXblZWcApjO3GKBPl1w==
X-Proofpoint-GUID: 9AkUdcOYABLSTJNtitTjdIMRjzbzbIIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140079
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

djgzIGFuZCB2ODUgaW50cm9kdWNlIG5ldyBJU0EgZXh0ZW5zaW9uczoKLSBDRkkvcmVzdHJpY3Rl
ZCBicmFuY2hlcwotIHNjYWxhciBhdG9taWMgb3BlcmF0aW9ucwotIHNjYWxhciBmbG9hdCBvcGVy
YXRpb25zCi0gdHJhcDIgaW5zdHJ1Y3Rpb24KLSB2ZWN0b3Igc3RhY2ssIHVzZWQgYnkgSExYCgpU
aGUgSExYIHZlY3RvciBjb3Byb2Nlc3NvciwgYWxzbyBpbnRyb2R1Y2VkIGJ5IHRoZXNlIG5ldyBy
ZXZpc2lvbnMsIGlzCm5vdCBpbmNsdWRlZCBpbiB0aGlzIHNlcmllcy4KClRoZSBjcm9zcy10b29s
Y2hhaW4gZG9lc24ndCB5ZXQgc3VwcG9ydCB0aGVzZSBvcGNvZGVzLiAgU28gaW4gb3VyIHRlc3Rz
LAp3ZSd2ZSBtYW51YWxseSBlbmNvZGVkIHRoZSBpbnN0cnVjdGlvbnMgdXNpbmcgIi53b3JkIiBk
aXJlY3RpdmVzIGFuZCB3ZQppbnZva2UgdGhlIHRlc3RzIHdpdGggdGhlIGV4cGxpY2l0ICctY3B1
Jy4gIFRoZSBkaXJlY3RpdmVzIHdpbGwgYmUgcmVwbGFjZWQKd2l0aCB0aGUgbW5lbW9uaWNzIGFu
ZCBleHBsaWNpdCAnLWNwdScgcmVtb3ZlZCBvbmNlIHRoZSBhc3NlbWJsZXIgaGFzIHRoZQpuZWNl
c3Nhcnkgc3VwcG9ydC4gIEkgZXhwZWN0IExMVk0gMjQueCB3aWxsIGluY2x1ZGUgdGhlc2UgaW5z
dHJ1Y3Rpb25zLgoKQnJpYW4gQ2FpbiAoMTIpOgogIHRhcmdldC9oZXhhZ29uOiBzb3J0IHRhZ19y
ZXZfaW5mbyBlbnRyaWVzIGJ5IHZlcnNpb24KICBIZXhhZ29uOiBhZGQgdjg1IENQVSBtb2RlbAog
IGh3L2hleGFnb246IGFkZCB2ODUgbWFjaGluZXMKICBsaW51eC11c2VyL2hleGFnb246IHJlcG9y
dCBJU0EgSFdDQVAgdGhyb3VnaCB2ODUKICB0YXJnZXQvaGV4YWdvbjogYWRkIHY4NSBzY2FsYXIg
YXRvbWljcwogIHRhcmdldC9oZXhhZ29uOiBhZGQgdjgzIHRyYXAyIGFuZCB2ZWN0b3Igc3RhY2sg
aW5zdHJ1Y3Rpb25zCiAgdGFyZ2V0L2hleGFnb246IGdlbmVyYXRlIHZlY3RvciBmcmFtZSBpbnN0
cnVjdGlvbnMgd2l0aCBJREVGIHBhcnNlcgogIHRhcmdldC9oZXhhZ29uOiByZWplY3QgcmVzZXJ2
ZWQgTDRfbG9hZHdfcGh5cyBlbmNvZGluZyBmcm9tIHY4MwogIHRhcmdldC9oZXhhZ29uOiBwcmVz
ZXJ2ZSBjYWxsciB0YXJnZXQgd2hlbiBScyBpcyBMUgogIHRhcmdldC9oZXhhZ29uOiBpbXBsZW1l
bnQgY29udHJvbCBmbG93IGludGVncml0eSAoQ0ZJKQogIHRhcmdldC9oZXhhZ29uOiBhZGQgdnNm
KiBpbnN0cnVjdGlvbnMKICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIHY4NSBzY2FsYXIgdGVzdHMK
CiBkb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgICAgICAgICAgIHwgICAyICstCiBp
bmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgICAgICAgIHwgICA2ICstCiBsaW51
eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9o
ZXhhZ29uL2NwdS1xb20uaCAgICAgICAgICAgICAgICAgICAgfCAgIDQgKwogdGFyZ2V0L2hleGFn
b24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiB0YXJnZXQvaGV4YWdvbi9j
cHVfYml0cy5oICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2dlbl90
Y2cuaCAgICAgICAgICAgICAgICAgICAgfCAgOTMgKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX3N5cy5oICAgICAgICAgICAgICAgIHwgICA2ICsKIHRhcmdldC9oZXhhZ29uL2dl
bnB0ci5oICAgICAgICAgICAgICAgICAgICAgfCAgMTIgKysKIHRhcmdldC9oZXhhZ29uL2hlbHBl
ci5oICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKwogdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3Mu
aCAgICAgICAgICAgICAgICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9w
YXJzZXItaGVscGVycy5oIHwgICAxICsKIHRhcmdldC9oZXhhZ29uL21hY3Jvcy5oICAgICAgICAg
ICAgICAgICAgICAgfCAgMTIgKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAg
ICAgICAgICAgfCAgIDQgKwogdGVzdHMvdGNnL2hleGFnb24vY2ZpX3RndHMuaCAgICAgICAgICAg
ICAgICB8ICAxNiArKwogaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192ODVuYV8xLmguaW5jICAgICAg
ICB8ICA1MCArKysrKysrCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y4NXFhXzEuaC5pbmMgICAg
ICAgIHwgIDUxICsrKysrKysKIHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jICAgICAg
ICAgICAgfCAgIDIgKwogdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgICAgICAg
ICB8ICAgMSArCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgICAgICAgIHwg
IDQ4ICsrKysrLQogbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgICAgICAgICAgICAgICB8
ICAxMCArKwogbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICAgICAgICAgICAgICB8ICAx
MCArKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMCAr
LQogdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgICAgICAgICAgICAgICAgICAgICB8ICAgNSArCiB0
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICAgIHwgIDk1ICsrKysrKysr
KysrLQogdGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYyAgICAgICAgICAgICB8ICAgMyAr
CiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICsrCiB0
YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgIDE0ICsrCiB0YXJn
ZXQvaGV4YWdvbi9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICAgIHwgICAzICstCiB0YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgIDczICsrKysrKysrKwogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICB8ICA1MyArKysrKystCiB0
ZXN0cy90Y2cvaGV4YWdvbi9hdG9taWNzLmMgICAgICAgICAgICAgICAgIHwgMTAyICsrKysrKysr
KysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL2NmaV91c2VyLmMgICAgICAgICAgICAgICAgfCAgNjMg
KysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL2NoZWNrX3Jldl9nYXRpbmcuYyAgICAgICAgfCAg
MTAgKysKIHRlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYyAgICAgICAgfCAgMjAg
KysrCiB0ZXN0cy90Y2cvaGV4YWdvbi90cmFwMi5jICAgICAgICAgICAgICAgICAgIHwgIDM0ICsr
KysrCiB0ZXN0cy90Y2cvaGV4YWdvbi92ODNfc2NhbGFyX2ZwLmMgICAgICAgICAgIHwgIDk4ICsr
KysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vdmFsbG9jZnJhbWUuYyAgICAgICAgICAgICB8
IDExMSArKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jICAg
ICAgICAgICB8ICA4MiArKysrKysrKy0tCiB0YXJnZXQvaGV4YWdvbi9nZW5faWRlZl9wYXJzZXJf
ZnVuY3MucHkgICAgIHwgICA0ICstCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBh
cnNlci5sZXggIHwgICA4ICsKIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFyc2Vy
LnkgICAgfCAgIDkgKy0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2FsdS5pZGVmICAgICAgICAg
ICAgfCAgIDMgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvYnJhbmNoLmlkZWYgICAgICAgICB8
ICAzOCArKysrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZiAgICAgICB8
ICA0MyArKysrKy0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9zdWJpbnNuLmRlZiAg
fCAgIDEgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZmxvYXQuaWRlZiAgICAgICAgICB8ICA0
OSArKysrKysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRlZiAgICAgICAgICAgfCAg
MTUgKysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21hY3Jvcy5kZWYgICAgICAgICAgfCAgMTAg
KysKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N1Ymluc25zLmlkZWYgICAgICAgfCAgIDIgKwog
dGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvc3lzdGVtLmlkZWYgICAgICAgICB8ICAgOSArKwogdGVz
dHMvdGNnL2hleGFnb24vY2ZpX3RndHMuUyAgICAgICAgICAgICAgICB8IDE1NyArKysrKysrKysr
KysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICB8
ICAxOSArKy0KIDUzIGZpbGVzIGNoYW5nZWQsIDE0NzAgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRp
b25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vY2ZpX3RndHMuaAog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjg1bmFfMS5oLmluYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjg1cWFfMS5oLmluYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29uL2NmaV91c2VyLmMKIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi90cmFwMi5jCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvdGNnL2hleGFnb24vdjgzX3NjYWxhcl9mcC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvdGNnL2hleGFnb24vdmFsbG9jZnJhbWUuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Rj
Zy9oZXhhZ29uL2NmaV90Z3RzLlMKCi0tIAoyLjM0LjEKCg==

