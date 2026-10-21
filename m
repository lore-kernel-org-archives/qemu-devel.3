Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F05606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OQ0x/iG1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dB3T1Eko
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKPZ-0002OQ-Rj; Tue, 20 Oct 2026 20:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKPM-0002HK-0u
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:42:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKPJ-00071r-Ud
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:42:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtiN23818756
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 48XaNEhdi2CXpZ2OiYRzTDErtu1d4rVLSi/9r3SFsnw=; b=OQ0x/iG1CtEr7+l6
 eJ2wwPJgmQcWIHj1WLfUXEyRLC/VDWHf21gJWbvjDXnhGtsQL04CP/0yLOSV0MWB
 Hu+YKxqx3ES6OISWfDoOKnsL+z5lhpZiXVQ5FMrVRjTa5dGUSGH2YcpxF379CiWd
 +tqq0TYJ0iyVk0+nuTQSeONtYUmAZc2SR+XI8pqsv6F484NG728iqCZSwVTES5fY
 OJq01ACAyemR1wzhLafuA2c+bd3pywXTOedAYvPM5qJVEsOv9QSxfsnzWNgkHOou
 Vs1/FXpsmbexESzM6rmAQkSUbspm6V74NvuKCPkK5PVcCk3qKE+Wok4J4O4A7q+A
 ysYX0A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4s674-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:42:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1665200f4c2so270186c88.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792543334; x=1793148134; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=48XaNEhdi2CXpZ2OiYRzTDErtu1d4rVLSi/9r3SFsnw=;
 b=dB3T1EkoVCJOQ3nYfYkG6MZ/yaAumJtq3i2PME2Zoa2xwA1Rx13NKreVr6dyRCTkv3
 qDmC9WCzgwyEFs10mJhZZzWvurwvi+ux4zWVbJhTV0sxu83BWalKb8Ql/XIqhYcH+FEW
 BxsHyPOHPeX9fov1nC34uQ9NyNfdGUpDi6NO+WmuY4xbeAGYTsfD98w7E0TIDvYjCE0c
 vGD9x9xAJv9uf/RfBJsqY0kB5CpAXy2v9aOUhcQuRO1HYDOBv/X6HJ9NWQ520ShdPyeJ
 ZMwxVFcPDvenJrDbrUqBOcfm5f2kmgXIEkWJ133sajWERBSkbVP/H6KAf677jCACJoYH
 0A+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792543334; x=1793148134;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=48XaNEhdi2CXpZ2OiYRzTDErtu1d4rVLSi/9r3SFsnw=;
 b=UduOX8hejxT5kyX6BoxqKFbU8X/Cm7KxrFvRRZb3ZSJ1ONnhUwT8auebiqgZ90dmJV
 NHFxOy8JJUFujrcp49Inm7FenwApcmrrWLT9QFtTxEWsD/edq5eIx5QbaN4TR1qV/f09
 tfbK4BvQVQa5VebDIddf/v1BVAUBGZb6Oixi+alJYnqy3SfwYAUdOZiTPhYl05yO5dJb
 BsDmuv0ckjcgxO8+n0/TKTZjlrtiqJhNN6S1Q6D3q3N8RghcPJqrG8SU8Bnhms9FbTsq
 uIzPog83QIQXDrkyMVYgwbH+8dalNpUM1jCxYBXzNDG4NhjahSIkXU6aDNzEaxsAp+qg
 VpzA==
X-Gm-Message-State: AFq9FYI2h1mQSbIQpJOTFdkIYrWTNGw9zx0gMP/cFDHJjbfhrzUOQdiN
 oe5G+gno+AzZp/Dhf/vtlP7FPzG24SN2ltyvMCJa6IcHLbtMwGHCRuelHDnlCNrTNWVNtRbf4Sn
 gayNjENOtf9+AjFbpWv4jZdPYS47ezYyhWuxoKjqOmyekj80Nt5sybfb7TrGquhVogA==
X-Gm-Gg: AYBFou1FqqjtPAq2RN6+ppQMOG89mesAa3jQ5PpiT7Z4yk/3DeJpV3UiTLGbitKx1Zp
 MLqeai6/xhTzraM++llzw4bMqYlMx6IGoq0vswS4KVd/JrGmZlrtWydgWNyKsJdXw2FRn7KIvIU
 HhgUtTX/yOPbbdJRjzmKuaatGYEKc3qhi93yv5aApt99IEHsXCaAQok4HVDGgZhj5mgMyc0A9CQ
 YpehxWtfZy4Zr9Rw1qViwWl3PUQ/2+r9U5KGg8Vd21e2zXV47N474oioDHMkOCikoftbLMSk7m/
 9h00gy605Oj52goXsbGYwS02IwvR8bpjo3CPaSokPTRxhq2ti1DCzIaMl02fNMxnhG1byFuFUxV
 8e12sR2QCU/pX2hFQUhltGntHOMqrxaqdKmOX5UrIPzoS9nA=
X-Received: by 2002:a05:701b:2314:b0:151:2e62:fe4b with SMTP id
 a92af1059eb24-190a57ac854mr527382c88.23.1792543333927; 
 Tue, 20 Oct 2026 17:42:13 -0700 (PDT)
X-Received: by 2002:a05:701b:2314:b0:151:2e62:fe4b with SMTP id
 a92af1059eb24-190a57ac854mr527344c88.23.1792543333197; 
 Tue, 20 Oct 2026 17:42:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d87ab1bsm2005788c88.21.2026.10.20.17.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 17:42:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Alessandro Di Federico <ale@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 15/15] tests/functional/hexagon: boot DSP firmware
Date: Tue, 20 Oct 2026 17:41:45 -0700
Message-Id: <20261021004145.1693260-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
References: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: DbzQCGoxk3b16hCB_tby_BIVQ9_AwZCi
X-Proofpoint-GUID: DbzQCGoxk3b16hCB_tby_BIVQ9_AwZCi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX5xtl2gKWfqsC
 6iVzdkmXDOTStVK5N915FpoIvc8x/XS8gBXr2Qt+BBRJ88JX57IYCB9ue/FfVwhdT8zLn50iMIR
 tI/roBeyEu4+bqaTTT81KPl2CtK6rro=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad80a66 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=FjKqm1ytYyOSSueK_-UA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXy4zcC6F2LbqN
 /s5IYgnQK/luM0isaVRjVGVRcmWkKQYoEcKx29XwWZ5mnJu/Ta8KJQEvbD36f6pn0iXzZKjjB5O
 CDsmYAKc2xRKJpTCRF+1n9knV2dWCJBVW7amuLOXTpwf5ilbyL+6fzMQaCzoMKGtZTd2PT9jLFk
 GvNgdcEQ2EfNTvtaHxRlTXqzewr+YCfvW3YJJ3j0K0q01NBazEsSaYB2myOcGIY9L3W7rz6tVdl
 5dsboMuIjCS/lIYt7pOQUmZw42AQV7vcBMv7nSk4mTht3wjq0kEOas4ZS+z3QiXF118IGB9pupj
 RzZOR4BG78WfLHRy1sAU8gLCS+XfcNd4oWJOInHLS2zVOHnB7+U0IMPCU1MqgKp7K8mlDsUXKjx
 J4M0VK00+2Gc67Ifpoc3QJWZUHxvugUu8/IdbhxPf1tJpxzI5k4KWleTqOKiWQKYPxpL5HX0NY0
 aHk4NmYwFggMjcnix7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210001
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RG93bmxvYWQgdGhlIGZpcm13YXJlIGFuZCBydW4gaXQgb24gdGhlIGNvcnJlc3BvbmRpbmcgRFNQ
IG1hY2hpbmUuCgpUaGUgaW1hZ2VzIGFyZSB0aGlyZC1wYXJ0eSBiaW5hcmllcywgc28gdGhlIHRl
c3RzIHJ1biBvbmx5IHdoZW4gdW50cnVzdGVkCmNvZGUgaXMgYWxsb3dlZC4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgfCAgMiArCiAuLi4vaGV4YWdv
bi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5ICAgICAgICAgfCA5MiArKysrKysrKysrKysrKysr
KysrCiAyIGZpbGVzIGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDc1
NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9xY29tX2RzcF9maXJtd2FyZS5weQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCBiL3Rlc3RzL2Z1
bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBlMTgyYmM5OGEwNi4uMGZkOTBlNDkx
YTIgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZAorKysg
Yi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIsMTAgKzIsMTIgQEAK
IAogdGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCiAgICdhcmNoX3Rlc3RzJywKKyAg
J3Fjb21fZHNwX2Zpcm13YXJlJywKICAgJ3N5c3Rlc3RzJywKICAgJ21pbml2bScsCiBdCiAKIHRl
c3RfaGV4YWdvbl90aW1lb3V0cyA9IHsKKyAgJ3Fjb21fZHNwX2Zpcm13YXJlJzogMjQwLAogICAn
c3lzdGVzdHMnOiAxODAsCiB9CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24v
dGVzdF9xY29tX2RzcF9maXJtd2FyZS5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X3Fjb21fZHNwX2Zpcm13YXJlLnB5Cm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAw
MDAwLi4zMWJlYWJjMjM3NAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5CkBAIC0wLDAgKzEsOTIgQEAKKyMhL3Vzci9i
aW4vZW52IHB5dGhvbjMKKyMKKyMgQm9vdCB0aGUgcHJvZHVjdGlvbiBEU1AgZmlybXdhcmUgb24g
dGhlIFF1YWxjb21tIERTUCBtYWNoaW5lcworIworIyBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRl
Y2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyMKKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworZnJvbSBxZW11X3Rlc3QgaW1wb3J0
IFFlbXVTeXN0ZW1UZXN0LCBBc3NldCwgc2tpcFVudHJ1c3RlZFRlc3QKK2Zyb20gcWVtdV90ZXN0
IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4KKworCitjbGFzcyBRY29tRHNwRmlybXdh
cmVUZXN0KFFlbXVTeXN0ZW1UZXN0KToKKyAgICAiIiJCYXNlIGNsYXNzOiB0aGUgZmlybXdhcmUg
aXMgdGhlIEVMRiB0aGF0IC1rZXJuZWwgc3RhcnRzIHJ1bm5pbmcuIiIiCisKKyAgICBNQUNISU5F
ID0gTm9uZQorICAgIEFTU0VUID0gTm9uZQorICAgIE1JTEVTVE9ORSA9ICdFbnRlcmluZyBtYWlu
KCkgLi4uJworCisgICAgZGVmIGJvb3RfZmlybXdhcmUoc2VsZik6CisgICAgICAgIHNlbGYuc2V0
X21hY2hpbmUoc2VsZi5NQUNISU5FKQorICAgICAgICBmaXJtd2FyZSA9IHNlbGYuQVNTRVQuZmV0
Y2goKQorCisgICAgICAgIHNlbGYudm0uc2V0X2NvbnNvbGUoc2VtaWhvc3Rpbmc9VHJ1ZSkKKyAg
ICAgICAgc2VsZi52bS5hZGRfYXJncygnLWtlcm5lbCcsIGZpcm13YXJlKQorICAgICAgICBzZWxm
LnZtLmxhdW5jaCgpCisgICAgICAgIHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybihzZWxmLCAnUVVS
VCBrZXJuZWwgc3RhcnRlZCcsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYWls
dXJlX21lc3NhZ2U9J0ZhdGFsIEVycm9yJykKKyAgICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0
ZXJuKHNlbGYsIHNlbGYuTUlMRVNUT05FLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZmFpbHVyZV9tZXNzYWdlPSdGYXRhbCBFcnJvcicpCisgICAgICAgIHNlbGYudm0ua2lsbCgp
CisKKworQHNraXBVbnRydXN0ZWRUZXN0KCkKK2NsYXNzIFFjczY0OTBDZHNwRmlybXdhcmVUZXN0
KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1BQ0hJTkUgPSAncWNzNjQ5MC1jZHNwJworCisg
ICAgQVNTRVQgPSBBc3NldCgnaHR0cHM6Ly9naXRsYWIuY29tL2tlcm5lbC1maXJtd2FyZS9saW51
eC1maXJtd2FyZS8tL3Jhdy8nCisgICAgICAgICAgICAgICAgICAnMjAyNjEwMTkvcWNvbS9xY202
NDkwL2Nkc3AubWJuJywKKyAgICAgICAgICAgICAgICAgICc0M2U5Yzg5ZTE1ZWU4MmRhZjgzMjE0
Y2FlMzQwMDZhODUxNWZkZGY5ZGI3ZjY0NWY1ZWZmNGI4ZTNjNGViYjY0JykKKworICAgIGRlZiB0
ZXN0X3FjczY0OTBfY2RzcF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2VsZi5ib290X2Zpcm13
YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3MgU2E4Nzc1cENkc3BGaXJtd2Fy
ZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6CisgICAgTUFDSElORSA9ICdzYTg3NzVwLWNkc3An
CisgICAgQVNTRVQgPSBBc3NldCgnaHR0cHM6Ly9naXRsYWIuY29tL2tlcm5lbC1maXJtd2FyZS9s
aW51eC1maXJtd2FyZS8tL3Jhdy8nCisgICAgICAgICAgICAgICAgICAnMjAyNjEwMTkvcWNvbS9z
YTg3NzVwL2Nkc3AwLm1ibicsCisgICAgICAgICAgICAgICAgICAnMWQ5ZDhjZDFlOTEzYjBkM2I0
OWE3N2I0ZTk2MjU2NGFiNDgxMTkzZTZhNTY5N2M4ZjA2NDA2YjNmZDg1YThmYycpCisKKyAgICBk
ZWYgdGVzdF9zYTg3NzVwX2Nkc3BfZmlybXdhcmUoc2VsZik6CisgICAgICAgIHNlbGYuYm9vdF9m
aXJtd2FyZSgpCisKKworQHNraXBVbnRydXN0ZWRUZXN0KCkKK2NsYXNzIFNjODQ4MHhwTnNwMEZp
cm13YXJlVGVzdChRY29tRHNwRmlybXdhcmVUZXN0KToKKyAgICBNQUNISU5FID0gJ3NjODQ4MHhw
LW5zcDAnCisgICAgQVNTRVQgPSBBc3NldCgnaHR0cHM6Ly9naXRsYWIuY29tL2tlcm5lbC1maXJt
d2FyZS9saW51eC1maXJtd2FyZS8tL3Jhdy8nCisgICAgICAgICAgICAgICAgICAnMjAyNjEwMTkv
cWNvbS9nbHltdXIvY2RzcC5tYm4nLAorICAgICAgICAgICAgICAgICAgJzdiMjJmMzNhZTI3M2Qz
ZGZjNWY3NDFhOTY3ODMxZTdkNGZkNzlhZDE0MWU2YTFlY2VlMTc1MDllYWMyMDcxMDknKQorCisg
ICAgZGVmIHRlc3Rfc2M4NDgweHBfbnNwMF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2VsZi5i
b290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3MgU2E4Nzk3cE5z
cDBGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6CisgICAgTUFDSElORSA9ICdzYTg3
OTdwLW5zcDAnCisgICAgQVNTRVQgPSBBc3NldCgnaHR0cHM6Ly9naXRsYWIuY29tL2tlcm5lbC1m
aXJtd2FyZS9saW51eC1maXJtd2FyZS8tL3Jhdy8nCisgICAgICAgICAgICAgICAgICAnMjAyNjEw
MTkvcWNvbS9ub3JkL2Nkc3AubWJuJywKKyAgICAgICAgICAgICAgICAgICc0MTBlN2NhM2IzNDBl
ODA4MzVlNDY0NTQ1YTIxOGQ5Mzc2MzEwYTA5ZjI0YmM4N2RlNDBiYzI1ZjdmNWUzMjQwJykKKwor
ICAgIGRlZiB0ZXN0X3NhODc5N3BfbnNwMF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2VsZi5i
b290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3MgU204OTc1TnNw
RmlybXdhcmVUZXN0KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1BQ0hJTkUgPSAnc204OTc1
LW5zcCcKKyAgICBNSUxFU1RPTkUgPSAnUVVSVCByb290IHRhc2sgc3RhcnRlZCcKKyAgICBBU1NF
VCA9IEFzc2V0KCdodHRwczovL2dpdGxhYi5jb20va2VybmVsLWZpcm13YXJlL2xpbnV4LWZpcm13
YXJlLy0vcmF3LycKKyAgICAgICAgICAgICAgICAgICcyMDI2MTAxOS9xY29tL2hhd2kvY2RzcC5t
Ym4nLAorICAgICAgICAgICAgICAgICAgJzczNzM5NTI0MTNjMTQxZmM2MzZhYTkzM2FiMGM3MWU3
YmUxZDEwZjVmN2RkMzZiZTUzNzQ4MjdiMjUzYzNkYjUnKQorCisgICAgZGVmIHRlc3Rfc204OTc1
X25zcF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2VsZi5ib290X2Zpcm13YXJlKCkKKworCitp
ZiBfX25hbWVfXyA9PSAnX19tYWluX18nOgorICAgIFFlbXVTeXN0ZW1UZXN0Lm1haW4oKQotLSAK
Mi4zNC4xCgo=

