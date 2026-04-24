Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36394F34C45
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 02:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6P1-0006ji-VS; Thu, 23 Apr 2026 22:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P0-0006jS-Pw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6Oy-0008Hm-MH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NJATBJ3804009
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tj79ILTkVGPm92sqtI4iWU
 VVYAB5ApY7GTvJMbO9Ipo=; b=mJuaitSbLCOWOfzmZGRM0igq02WmPiNWlhOp0g
 JcoXjUPVMnbkfm/aDJBXYHwGBXjsLim0wba8cRqiJ95TP7bswEvGp0zBjiRgjamh
 ynWiLIe+GkYJRKlpzPaUkxIPmRiNa+gdS29JXM4xuelsT18dQOO31S9UysajVoAN
 ekSPo+rpG2UKHU+W+sdh9VRfUpUvPY+pfShcEvtYeMZ4TDqDf8do2fz7kLZGGsPE
 6TjMQAv8yyoirwo24U9AywV7xTtH59a/AWgpWycRksjgN4OXSZ7R6wzEELJ5AhfS
 9/4tLYKmnJo20AFn/EjdxqvNm6+BQCVciRkZ7oi8+q125aag==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqkqfu16p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so10328452eec.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 19:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776998177; x=1777602977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tj79ILTkVGPm92sqtI4iWUVVYAB5ApY7GTvJMbO9Ipo=;
 b=DGpgzHdyjODdedxcXMmPNYUT5QD+e6rTrAUIM/Sd9QJTVnjUbvQ2zxo12BQgQ7o0Xx
 NNaRxY1m3rp3pjqrTMWR7ul/jJzpmOLmxq4wZrtnOv5iLrUTOWmikGeg71mfHnH/Gpvd
 Yoxq7I97bXqx/b2/dW8GicavEa6oqDAJo+uFlvEEGZfnOsOLj7aIT51kALZ7KZ6yIhbq
 wYBjTrU+DX/W7HkLxrbEFyEDrHMFyXpzGJSoJnFlmkiV6tk8mqmtoxDFefteNYVDotxF
 PsuxLoa4pmZ0d1ATVGoppDHBzVO8aR3E3FqOxmfuh2gFEL8KpcltG+AAoqQnMqunzTMo
 uDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776998177; x=1777602977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tj79ILTkVGPm92sqtI4iWUVVYAB5ApY7GTvJMbO9Ipo=;
 b=KfkUj4U8mbVUakUhlgzC9ue2kEnUREoh51ZZupTRYfWJFEUoVomkp63jJgZW+Gdnac
 N9moSls3wkfQOLyvXdOIPhEG8lgcGBntw+dXQ9ukHGdxMhfiUMiddcH7Ckb/jl9voHVG
 V4y2OHFxXbYvvzC7Mbi/uP06Gr5gDN2ghQWvxzs8Uf75fUSPSPniCdSliwFwsBElMQUU
 hczY0c+uYAt0Mkii+GTZA3+x4ORZC/YiDoov06EkenzP6QFLFv9mL8s+sqxGasw+YMDx
 Uei+rgf3rE4EloBKJuy3IPpLBtZ2aLYinImMsqF42CO5GXJN6fcBVx/BH/AyLzW6T271
 7vzw==
X-Gm-Message-State: AOJu0YyUTMETHK3ngVChMRP0mQadbNXT480/exGwcIXYj9ZSIFfi0ark
 6Ic8IzFZ7wdPkCAjSW3zYVZJmFEHeA3zLgwOutOkPIZ6MzN1jTDgSdMu+g6AO3ThFrIQJ34EZE+
 bBWGBZWW8vN7cUAYgpzNjbi+Xo3JfgYgUgJ62iSMg67G6jBp/3C9c8L6EfbvjiDU9eQ==
X-Gm-Gg: AeBDiet7OEOr1TTmi/zPnSC/JAzRjC1nNtJR69fEYTQQYkAyZoVsQXSD6G8qX1bAgLC
 DgUhfvoNaNrmRHdC4r6WYGWx5RBUR2zLSr9zxLKUS2pGNL1fjHs56zOH5q5ygVYcmKVxlr6GbZt
 w8w68u5UJJ72iQ+d3xs2Tj3WgRaf3/5xp+Imc53wBgRAIcFT3atEHV1VWW37pcc9NNDGllGN01d
 p3v7fYOa4iCu/mL5pFVDFf58asvBlm18ln0/39cZ0x8WFcN9se0ruAW5sZfG45CA3sxmUn9iAys
 WM72erzbjNi3EqbZfIOGeFkO2qwD5TJFVm9OjAeyiStS0beB5T0o3vpT6mTrOjW+246MNQ6qQvm
 HwvELxAZeU8Yx2/o6WktYG3luimWjPI+545OZQvEdi5d6d7Zy+042qww6gdn8iomE8MIOaU1JDH
 uC3LyTJXAkUDnfb4o=
X-Received: by 2002:a05:693c:2c09:b0:2df:c5bb:3720 with SMTP id
 5a478bee46e88-2e47873a9demr16779979eec.15.1776998176913; 
 Thu, 23 Apr 2026 19:36:16 -0700 (PDT)
X-Received: by 2002:a05:693c:2c09:b0:2df:c5bb:3720 with SMTP id
 5a478bee46e88-2e47873a9demr16779965eec.15.1776998176345; 
 Thu, 23 Apr 2026 19:36:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm31240868eec.3.2026.04.23.19.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 19:36:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 0/9] hex queue
Date: Thu, 23 Apr 2026 19:35:57 -0700
Message-Id: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: qkn4HAdvKR6A3ZOstLUw2m2ngOLoMfHh
X-Proofpoint-ORIG-GUID: qkn4HAdvKR6A3ZOstLUw2m2ngOLoMfHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAyMCBTYWx0ZWRfX9b3JkBW4k2aj
 DXUsKI46UKQru+7PAEtcXGT1+e/nhWd5/PiRGX4IGufwPp60uE+M8aVL+uzHRwo8wbDh7+4lTWs
 To//Kqm2VXou3jeXvfa/SVomFO+A7qHHN5oCPxnHOcN8yUHwrVI7K9avQrk8pUCjUnUlqQ/nCrh
 e6DQnyl/8Gn1saeLRqc2bP+xNRfDr2oyDbNkUOfBC/l6lVdCf3vORcULFdXe+7bLWQfzZnPjab3
 JAFK9OH95mzl+M1Pmx2H6n7uTQktLR9jE/5tvbgauOLNE5sGCeJF+Gc6wb2ChS0DtHWwCAxUPou
 ow56PUjgjn3xJQ0b89WOMZQHS4cUkLgqXlWkpPIP4saDhjywoT7afRSU0a15NeNumKtbMKsxngt
 +59FsEJ4L8OXaXEped0y9rM0RP7EeBUVehAV5+6GqP+jV98RU/1dKo9W1/yB/ssvN6SMdAQdecs
 02R24+T/bIcBDL6V9fA==
X-Authority-Analysis: v=2.4 cv=ablRWxot c=1 sm=1 tr=0 ts=69ead721 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=YCRxHI6lGQgpWZJnlDgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240020
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiYjIzMDc2OWI0ZDAxZGU3MTRiZWQ2
ODYxNjFhZDM5YThmNGYzZmQxOgoKICBNZXJnZSB0YWcgJ3VpLXB1bGwtcmVxdWVzdCcgb2YgaHR0
cHM6Ly9naXRsYWIuY29tL21hcmNhbmRyZS5sdXJlYXUvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjYt
MDQtMjIgMTQ6MzA6MDQgLTA0MDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9y
eSBhdDoKCiAgaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdSB0YWdzL3B1bGwtaGV4LTIwMjYw
NDIzCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYjRiYmQ2ODg4MmYyNGIwZjk5NTkz
YjQ4ZmM1MDEyMmU1ZGFjNWM0MToKCiAgdGFyZ2V0L2hleGFnb246IENoYW5nZSBEaXNhc0NvbnRl
eHQgcGFja2V0IHR5cGUgKDIwMjYtMDQtMjMgMTQ6NDk6MzggLTA3MDApCgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkhleGFn
b24gYXJjaCByZXYgc3BlY2lmaWMgYmVoYXZpb3IKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQnJpYW4gQ2FpbiAoMSk6CiAg
ICAgIHRlc3RzL3RjZy9oZXhhZ29uOiBBZGQgdGVzdCBmb3IgcmV2aXNpb24tZ2F0ZWQgaW5zdHJ1
Y3Rpb24gZGVjb2RpbmcKCk1hcmNvIExpZWJlbCAoMSk6CiAgICAgIHRhcmdldC9oZXhhZ29uOiBD
aGFuZ2UgRGlzYXNDb250ZXh0IHBhY2tldCB0eXBlCgpNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlu
byAoMSk6CiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBJbnRyb2R1Y2UgdGFnX3Jldl9p
bmZvLmMuaW5jCgpUYXlsb3IgU2ltcHNvbiAoNik6CiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhh
Z29uKSBQcm9wZXJseSBoYW5kbGUgSGV4YWdvbiBDUFUgdmVyc2lvbgogICAgICBIZXhhZ29uIChs
aW51eC11c2VyL2hleGFnb24pIElkZW50aWZ5IEhleGFnb24gdmVyc2lvbiBpbiBFTEYgZmlsZQog
ICAgICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgQWRkIEhleGFnb24gZGVmaW5pdGlvbiBmaWVs
ZCB0byBEaXNhc0NvbnRleHQKICAgICAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIENoZWNrIGVh
Y2ggb3Bjb2RlIGFnYWluc3QgY3VycmVudCBDUFUgZGVmaW5pdGlvbgogICAgICBIZXhhZ29uICh0
YXJnZXQvaGV4YWdvbikgRGlzYXNzZW1ibHkgb2YgaW52YWxpZCBwYWNrZXRzCiAgICAgIEhleGFn
b24gKHRhcmdldC9oZXhhZ29uKSBSZW1vdmUgc25wcmludF9hX3BrdF9kZWJ1ZwoKIHRhcmdldC9o
ZXhhZ29uL2NwdS1xb20uaCAgICAgICAgICAgICB8ICAyNyArKwogdGFyZ2V0L2hleGFnb24vY3B1
LmggICAgICAgICAgICAgICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggICAg
ICAgICAgICB8ICAgNCArLQogdGFyZ2V0L2hleGFnb24vZGVjb2RlLmggICAgICAgICAgICAgIHwg
ICAyICsKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgICAgICAgICAgICB8ICAgMiArLQogdGFy
Z2V0L2hleGFnb24vbWFjcm9zLmggICAgICAgICAgICAgIHwgICA2ICstCiB0YXJnZXQvaGV4YWdv
bi9wcmludGluc24uaCAgICAgICAgICAgfCAgIDQgKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5oICAgICAgICAgICB8ICAgMyArLQogZGlzYXMvaGV4YWdvbi5jICAgICAgICAgICAgICAgICAg
ICAgIHwgICAzICstCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jICAgICAgICAgfCAgNDMg
KystCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgfCAgNDggKystCiB0YXJn
ZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgfCAgNTggKysrLQogdGFyZ2V0L2hleGFn
b24vZ2VucHRyLmMgICAgICAgICAgICAgIHwgIDE0ICstCiB0YXJnZXQvaGV4YWdvbi9wcmludGlu
c24uYyAgICAgICAgICAgfCAgNDAgKy0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAg
ICAgICAgfCAxMTQgKysrLS0tLQogdGVzdHMvdGNnL2hleGFnb24vY2hlY2tfcmV2X2dhdGluZy5j
IHwgMTQxICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMgICAgfCA2
MTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfZnVuY3MucHkgICAgICB8ICAgMiArLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSAgICAgICAgIHwgICA0ICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgICAg
fCAgIDYgKwogMjAgZmlsZXMgY2hhbmdlZCwgOTc2IGluc2VydGlvbnMoKyksIDE2MCBkZWxldGlv
bnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9jaGVja19yZXZfZ2F0
aW5nLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5p
bmMK

