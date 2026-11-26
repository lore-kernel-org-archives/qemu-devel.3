Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571E606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jdfm8wTQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MXZG4Xi9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWeMV-0006Yl-Sf; Thu, 26 Nov 2026 13:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWeMN-0006Wy-93
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:38:19 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWeML-0008NR-MC
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 13:38:18 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQFuJWY1848275
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 18:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PlW5bXNcB8w3C+QV1fDf9v
 XFL8v7xpeU97s5+k+kOIA=; b=jdfm8wTQo2R0c/iQJJYcNLLR03yucDV1/U0xMB
 CLaQ7H8fx++YUZujwiO9T0agDZwdjX55HSHo+BbYrA5XESkYOAgkjKu6VBOT8YJT
 9Uqf1tNRbh8JRdHHLOEH49JAc5+/Sv129RizsDXVoPKhCrIhcw3xjhQetWJGl5Sw
 1zc7gFuGJpauFNe/tM9WwZyoms8dnRWSbZ3xsAxzvhN4d0uzGVvL0M4hERMLvptr
 NO9q2ZUPw1TzR7hohe24D0Hw1+zUg/Zl4qYPy5P0kTiCGzv/wc+HJ2ihn/DWMZcn
 bLUWvgfxTMwfKoOEvzK09PibeQ2HZXRY4ceSYJOblZ/8nv4w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6fw7tf4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 18:38:15 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-382af5cfc58so3890865eec.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795718294; x=1796323094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PlW5bXNcB8w3C+QV1fDf9vXFL8v7xpeU97s5+k+kOIA=;
 b=MXZG4Xi97S4L6xSwcM/4O6bKuj4RVM3BHYFiBvGvaHXDbS6/kjWvKYdYn7/A6fSlYk
 S+3JFdenkEtSLYfmH/A9QqH1Xkf1lejQqGfGX+WprcTuFHBYrKlsa6AeFkOWIUtDii26
 jJTou4Cgk0gsQZL3Xgg8Da1/eMQ6ZylUcWFD5d5t0YnBEtFfc+bUVVphqWJeEBVyAs0x
 zWI6eUBM9DXTsSSFA2GlVJj4pds1IH9JpwgmvdkCnDnWEk9JOQfZC58XOiFXG5WrMRX2
 GAO/lxT7k4YHwYQxzGHvb19D7680jD1pbJKeJ4HUTyua1CFUTlRemV5aqNBnyoAV14Y1
 OQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795718294; x=1796323094;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PlW5bXNcB8w3C+QV1fDf9vXFL8v7xpeU97s5+k+kOIA=;
 b=InD+SwhMoZOboVo+U03KFGGY8wu41YboygCXUdH0ha3nmV6bmZgUbALOSFtdNQDl9y
 PLIy1tK5nAK/yoz5m8M7wUNroxhw3CV9lDRGNNQlJ8kKfiF9r2N18ugnyppCY5f5wfHK
 NOVg98uRV4gJ6qBf+QMsGZ+/i380CYt4QNZnYagle/BadgfhWsUUvA1A3s3SburICq7R
 Nj0zo1QgGAoXc7cgnZZzUu9p9yeeZetttpKYEprQ+YSl3ItbSltkuuPUnxOhS2pFDx2V
 VRmoJWzIo6jgXxpXen/p5ebjT8GmMcenhCYzY+XxwKV5Du6QXZSIM+T9fqiGqHH7/zR4
 0XnA==
X-Gm-Message-State: APuU4Z95WPjjePqOLwteCDPhT4rhVnjFMMH+tm/RcqYfFV2mDJK9Kp4D
 EmaqB8aTdfKT4U35cnwktbS01fT2pIgI0r2OIxN3DDQ9PuvIjmiCbth/W/nXHMA0GjfcamLMAJ8
 s7d8GTwUzgbrcPZlwIR0bDA+vxcCOkSktra1X56xX3CdauFTUuTCTAveDj/4rAl63Bg==
X-Gm-Gg: AZFdTZcsHpVu9SqsgotVtKQGdzFbd3Uu6MsezOG6iZmIIYu4YUjwwR971HeujkiW809
 p08+3bNRc5G3xOKwTfOVp4E5uPSbsvhHXxpjGG8IGP3OLVJYWBKwlIq5PLVDGYzs+yA87L+vfHp
 1Mr7vQAseZomqCePhF0x9QvLgHdLOfXKqS9mIe10QpBd61dvm0xUkXkGP93LZEE1gl76An2PhqE
 8MYofA5HuOJClbQOZdxRwDjTNGYQ0TbJGIwu1vahIcsUR1NU5d5/hz3dL5QDTFgi6c4p9kDF6H2
 TB61Sdw8boMQw3FFRxFX5sIiRIOG4PKvrfzjIPGDv2AlCxeFKcmopXHGCx9E92EscwM0XY5Ckit
 AjKpybYOY81xGj/oFlzRULqsrbijT5k8AGiNYARP+Vd3V5gHpoCD3+ukfP7ChiLazKAnIys3YWI
 NVRiTUIKCejaxlFHGRZ1NQ+g==
X-Received: by 2002:a05:7300:2728:b0:383:c2f0:e753 with SMTP id
 5a478bee46e88-3856c0d0a68mr25073069eec.3.1795718294355; 
 Thu, 26 Nov 2026 10:38:14 -0800 (PST)
X-Received: by 2002:a05:7300:2728:b0:383:c2f0:e753 with SMTP id
 5a478bee46e88-3856c0d0a68mr25073051eec.3.1795718293778; 
 Thu, 26 Nov 2026 10:38:13 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm78687512eec.4.2026.11.26.10.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 10:38:13 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH for-12.0 0/3] Hexagon: add PMU support
Date: Thu, 26 Nov 2026 10:38:09 -0800
Message-Id: <20261126183812.1366883-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3MyBTYWx0ZWRfX4XhNvaCZ2jH5
 LmNXJVEWx+afD12w1iJfdIjQ82DFjZbxY5LQquzVjw2LmkMRm+F3X4YwWfEPZsPP2Yl5kV3rgCB
 oeJ+7J3ndGlZUJaQ+WOlD2PGD/cK/WQ=
X-Proofpoint-GUID: 4C9txj9ZAZC8OWt9L82S1ARE_ziMpY4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3MyBTYWx0ZWRfX6eczavIVFv04
 sP/5tq/uGFpFBGaJPGGKpreb/Z6CidMg0tqz8wLFpoxwp2c8yi8E07IAeh2ECrb3CBl4QuIPVk2
 wwVs0ZnHtVa1XtIyrg/Xyyks8jVMVhVvePyQFT/KnsV9hn2AZzTb0CAZLamB0/+KnJSSXkNOBKL
 JaN/3hcChG7SesjP6klrEPfESoo2lSJJRsAn2+bOIGxlBRoLgV0FMkcAzB2rZ2gIPD4/K2ErspB
 WEpGY/xc0ptcOfsHc9YOmT7FesB2yhTkeOP1rJJJUKVkvJgbI4IpqPGeE7Fq3+LhhUXD8g0ESv5
 w1pF5CaEE8ZmOxtSLSDBqXjj4jEA4gnxYmZYfwiWvmX0BfoRSOhzOt8ZXqX/wdQxoOFTTSah7HD
 pHTq7vT3YukO9s0nxHV6YZmEX2vQYERQloAIgkLYihGCFab0B/lwtwJH7sbOAmru22DbDixYprJ
 QmnmaqqiWgQ+8/4psvQ==
X-Proofpoint-ORIG-GUID: 4C9txj9ZAZC8OWt9L82S1ARE_ziMpY4w
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6b087c97 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=uQMfvy4OE9UeSEhqcpMA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260073
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SW1wbGVtZW50IHRoZSBIZXhhZ29uIFBNVQoKQnJpYW4gQ2FpbiAoMyk6CiAgdGFyZ2V0L2hleGFn
b246IHJlbW92ZSBRRU1VLXByaXZhdGUgZXhlY3V0aW9uIGNvdW50ZXJzCiAgdGFyZ2V0L2hleGFn
b246IGltcGxlbWVudCBQTVUKICBkb2NzL3N5c3RlbS9oZXhhZ29uOiBkb2N1bWVudCBQTVUgYW5k
IGxpbWl0YXRpb25zCgogZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0ICAgfCAgMzQg
KysrKwogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCAgICAgICAgfCAgIDEgKwogaW5jbHVk
ZS9ody9oZXhhZ29uL2hleGFnb25fcG11LmggICAgfCAgNTEgKysrKysKIHRhcmdldC9oZXhhZ29u
L2NwdS5oICAgICAgICAgICAgICAgIHwgIDM2ICsrKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuaCAgICAgICAgIHwgICAzICsKIHRhcmdldC9oZXhhZ29uL2hlbHBlci5oICAgICAgICAgICAg
IHwgICAxICsKIHRhcmdldC9oZXhhZ29uL2hleF9yZWdzLmggICAgICAgICAgIHwgIDI0ICsrLQog
dGFyZ2V0L2hleGFnb24vcG11LmggICAgICAgICAgICAgICAgfCAyMDAgKysrKysrKysrKysrKysr
KysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAgIHwgIDM4ICsrKy0KIHRh
cmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIHwgIDIxICsrKwogaHcvaGV4YWdvbi9o
ZXgtc3Vic3lzLmMgICAgICAgICAgICAgfCAgMTQgKysKIGh3L2hleGFnb24vaGV4YWdvbl9nbG9i
YWxyZWcuYyAgICAgIHwgIDIzICsrLQogaHcvaGV4YWdvbi9oZXhhZ29uX3BtdS5jICAgICAgICAg
ICAgfCAxMTMgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAgICAgICAg
IHwgIDI3ICsrLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jICAgICAgICAgfCAyODAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQogdGFyZ2V0L2hleGFnb24vZ2Ric3R1Yi5jICAgICAg
ICAgICAgfCAgIDYgKy0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgIHwgIDU4
ICsrKy0tLQogdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jICAgICAgICAgICAgfCAgNDAgKysrLQog
dGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgfCAgMjIgKysrCiB0YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICB8IDIzMSArKysrKysrKysrKysrKysrKysrKy0tLQog
Z2Ric3R1Yi9nZGIteG1sL2hleGFnb24tc3lzLnhtbCAgICAgfCAgNzkgKysrKy0tLS0KIGh3L2hl
eGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgICAxICsKIDIyIGZpbGVzIGNoYW5nZWQs
IDExNzggaW5zZXJ0aW9ucygrKSwgMTI1IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3BtdS5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFy
Z2V0L2hleGFnb24vcG11LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL2hleGFnb25f
cG11LmMKCi0tIAoyLjM0LjEKCg==

