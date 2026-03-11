Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F778FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Asa-0000z5-76; Wed, 11 Mar 2026 00:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsW-0000xE-Hp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsS-000075-G8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3PlB12179858
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ff4FH4KD/KqDDp9J54RDLlHX3Ej/XN2N2unxc6XHPMI=; b=p0a6G6XA3d4tqzLV
 YTRjWtS3R3f8u2sLzM95fK3Z8TbFlI4WJeShxHKYFbbNyzEIXNeImp5CIo0rcA4B
 H8QYf9yRvYkLpVlThvyd/ZLImUCsys0KCXWSzvw2CMo1iRWD8poQoD8DiDw2jTgD
 jARrqaNLmmBQnmo9rGdh5O3CNy/tCHVePMcf0C5vkHyhS0+QbtSdPi4DVfEqnkhj
 PEIBwrmJj/WQpvB4jUfCHmb2mCXO4TOopYgBJP5FWYLoM+VefDkxLCUsXll1xF1Y
 pkODRJ9k10coVHSj33Bp0PQ56sE1jNW97IDl+4QsQB8JGjYNELUAxel3APA6Jq6W
 RAmWIA==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvsstgd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:45 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-415e1e9aa5dso63639971fac.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202124; x=1773806924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ff4FH4KD/KqDDp9J54RDLlHX3Ej/XN2N2unxc6XHPMI=;
 b=ZxEFdkBkzc56NwwZJ9UgQ/jdEWGtluOg3nvgzc9GrFYrC7B4MrOomCdIm0HxAmuBV2
 PZhe3esRRO7ix2zadZu/4h9HnVLbYhJycPffKpBaDyZQ6pchq9Qs5gFY8wqe1ze7prxg
 b1ghKSSftSGsOhrnoRCssusowFO8q0VbH0Hnaktt2kgFot3f5WxcZwh2mxbDb5oMr4ah
 fnmwdS1wmlgGdVWy/wkaNwY9BMAd8inzzlee0locAXN3ql/ycGNWOrwVDSA9i6PZKu9Z
 S0HuTAuD57s0REzA3waKbNuwRSO65/0daXQfDGvkMcngSlv3CQ8M7GxXq5FyEfJ45eJQ
 ZLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202124; x=1773806924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ff4FH4KD/KqDDp9J54RDLlHX3Ej/XN2N2unxc6XHPMI=;
 b=gvbJS08/gUoAufQOmiyrE+Fpa/DVrcSzECvghD9Ivbpfzas1sDi7j4PiKa0mhQSWkZ
 HkJhfiYWYO+8Qk1QeWcyyAqGq0ejIl3FB5G+GCGxJsewgFrInsTsa+XJjl2MnnyJvjHX
 Miq2xwzESC3+h/V7AtJgZ8yOImuwDxnV0P2UjCqO2P6isFIuVb9YZx7b3oY0sl0DAjrm
 ZWKlfUw3KMRg5ws4Op1l+VhRUA+WTlumbr3A4+jfuM0x3Ui3PwAE7UP9nwSKqdkyZE7S
 zQyyXvnjorfesOYxiNFZJGCASlrIJLWATM5nKML75dh8iIyM43bohFp8yAmxaq8w75G9
 mlwQ==
X-Gm-Message-State: AOJu0Yx3paEMRkznyH9mgVwa4MxI41gIOSqXw0lePJkxG0znQCj8WbAl
 o6pjloSXUrLEewhEX9wGTBXE+0zdKU/0kLRYMgTR/v+Bppxef2tDBUR9KFEPoJxjDXoK/PXGhyQ
 45/1wWlhNsgL41zFwsrQPFHdFTnxxfuWs0ihNtIyoP5FVsHWvNl5tiv0AX+u27D6AoQ==
X-Gm-Gg: ATEYQzyEm9Z6Okz+cletqV6EuXq7vNLf3MQasl0mRqtVh6El3V6CHv21x56ANt03MvZ
 yioHHbRQVusPMKPAf7IR6IEGlUYKSQAE1MABNCtvTgjprl4CscRbhJA++nUski77kJdgKPhUrlt
 M5bfM7CheK1Gd6WBtOSj2X8WCu8Bb/Vj+9seTI3YziFIIi6VwXCzHhDOKxWJSj5Uz63tpQ188Y5
 NMmido6inrYB9IQSzDfbUHaAI/9jkplIIfcTGHGlOU1enpEMyXv7EzZvFxNDUVjB3g2xXGuvIIC
 kVpDybqQTq4Ss6/VyKRYbkhe7y3RXt8tOdvq477AmOKf0m77tf1Zr00aC0CQX/0aHM0yH+PIzj4
 k9c5fLvVmbIAL9DElKO9Ut8S4va6nAKuhv3jM+Wdu4IfoBAViuNJM/oqvXwr4twJCwZUyWg==
X-Received: by 2002:a05:6871:5d05:b0:40e:dadc:4a01 with SMTP id
 586e51a60fabf-4177c969755mr916488fac.46.1773202124537; 
 Tue, 10 Mar 2026 21:08:44 -0700 (PDT)
X-Received: by 2002:a05:6871:5d05:b0:40e:dadc:4a01 with SMTP id
 586e51a60fabf-4177c969755mr916468fac.46.1773202124077; 
 Tue, 10 Mar 2026 21:08:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 28/32] target/hexagon: Add PC to raise_exception,
 use fTRAP() helper
Date: Tue, 10 Mar 2026 21:07:54 -0700
Message-Id: <20260311040758.1068731-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfXygdR5CR269sR
 dvT7K7rMdMYNQa8LZh1DYPZvVDeQrbkUapYv85FAqIRKeAXy0uc0SEuu+Sk2hGi1eEvCaFOCuBC
 eC3FpmGRUtUEiTmYfxNx4REih3Iw8i9HQSRjJBnYqlheBpZEA7zlyAszYy8C3qGcsN64Uu0O58G
 MMJus8GTaYba+C5/vahT+vSpqRwJl4LxFjnpIPp9lYmxmdRms2brTHfoPb8lV8yoCxrNV3BTmNN
 ZvJSOHtazeVPlMQrg7zA/zNgY7Gfr8imLL4bBrDJu5IVBS0gJn27QAHC5yIEHVn6E+ZRop+dlnR
 NcS7NvGMVhw0dmitvfXOSdk5rRk1WynqU/phDLO7o62JMfvMZNoGfD/eVDP9g5hvDDJwPQwYXkk
 i1tudpTiqUltNYurmL5REIuub3E+WlAZP2kl2DCOy5eaQE1kPAH10Oi8tJKvAelJLZ2C82JmYPR
 AUjjatMNzLJTZBp9A5A==
X-Proofpoint-ORIG-GUID: 7qmXktXxaTmG7c0jB8ZgiUVYTsL1Pmim
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b0eacd cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=4FQt9sIIQT5CW9ciUtIA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7qmXktXxaTmG7c0jB8ZgiUVYTsL1Pmim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgUEMgdG8gcmFpc2VfZXhj
ZXB0aW9uIGhlbHBlcgoKUmVwbGFjZSB0aGUgZkdFTl9UQ0dfSjJfdHJhcDAgbWFjcm8gb3ZlcnJp
ZGUgd2l0aCB0aGUgZlRSQVAoKS1nZW5lcmF0ZWQKc3lzdGVtIGhlbHBlciBpbnN0ZWFkLgoKU2ln
bmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgIHwgIDcgLS0tLS0tLQogdGFyZ2V0L2hleGFnb24v
aGVscGVyLmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCAxMCArKysr
LS0tLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDIwICsrKysrKysrKysrKysrKy0t
LS0tCiA0IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCBiL3RhcmdldC9oZXhhZ29uL2dl
bl90Y2cuaAppbmRleCBiZDA0Mzg2ZDg2MC4uNTA3ZDUyOWM0YjIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2cuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKQEAgLTEz
NjksMTMgKzEzNjksNiBAQAogI2RlZmluZSBmR0VOX1RDR19TMl9zdG9yZXdfcmxfc3RfdmkoU0hP
UlRDT0RFKSAgICAgICAgICBTSE9SVENPREUKICNkZWZpbmUgZkdFTl9UQ0dfUzRfc3RvcmVkX3Js
X3N0X3ZpKFNIT1JUQ09ERSkgICAgICAgICAgU0hPUlRDT0RFCiAKLSNkZWZpbmUgZkdFTl9UQ0df
SjJfdHJhcDAoU0hPUlRDT0RFKSBcCi0gICAgZG8geyBcCi0gICAgICAgIHVpViA9IHVpVjsgXAot
ICAgICAgICB0Y2dfZ2VuX21vdmlfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgY3R4LT5wa3QtPnBj
KTsgXAotICAgICAgICBUQ0d2IGV4Y3AgPSB0Y2dfY29uc3RhbnRfdGwoSEVYX0VWRU5UX1RSQVAw
KTsgXAotICAgICAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCBleGNwKTsg
XAotICAgIH0gd2hpbGUgKDApCiAjZW5kaWYKIAogI2RlZmluZSBmR0VOX1RDR19BMl9ub3AoU0hP
UlRDT0RFKSBkbyB7IH0gd2hpbGUgKDApCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxw
ZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCmluZGV4IDE3ZTc0YjEyZjNjLi5hODk3NThi
NWRmNSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hl
eGFnb24vaGVscGVyLmgKQEAgLTE4LDcgKzE4LDcgQEAKICNpbmNsdWRlICJpbnRlcm5hbC5oIgog
I2luY2x1ZGUgImhlbHBlcl9wcm90b3NfZ2VuZXJhdGVkLmguaW5jIgogCi1ERUZfSEVMUEVSX0ZM
QUdTXzIocmFpc2VfZXhjZXB0aW9uLCBUQ0dfQ0FMTF9OT19SRVRVUk4sIG5vcmV0dXJuLCBlbnYs
IGkzMikKK0RFRl9IRUxQRVJfRkxBR1NfMyhyYWlzZV9leGNlcHRpb24sIFRDR19DQUxMX05PX1JF
VFVSTiwgbm9yZXR1cm4sIGVudiwgaTMyLCBpMzIpCiBERUZfSEVMUEVSXzIoY29tbWl0X3N0b3Jl
LCB2b2lkLCBlbnYsIGludCkKIERFRl9IRUxQRVJfMyhnYXRoZXJfc3RvcmUsIHZvaWQsIGVudiwg
aTMyLCBpbnQpCiBERUZfSEVMUEVSXzEoY29tbWl0X2h2eF9zdG9yZXMsIHZvaWQsIGVudikKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMKaW5kZXggODk3MTJiZjhlMDkuLjM3MjBmMjY3OWRhIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpA
QCAtNjUsMTUgKzY1LDEzIEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlv
bl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludHB0cl90IHBjKQogewotICAgIENQVVN0YXRlICpj
cyA9IGVudl9jcHUoZW52KTsKLSAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULCAiJXM6ICVk
XG4iLCBfX2Z1bmNfXywgZXhjZXB0aW9uKTsKLSAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gZXhj
ZXB0aW9uOwotICAgIGNwdV9sb29wX2V4aXRfcmVzdG9yZShjcywgcGMpOworICAgIGRvX3JhaXNl
X2V4Y2VwdGlvbihlbnYsIGV4Y2VwdGlvbiwgcGMsIDApOwogfQogCi1HX05PUkVUVVJOIHZvaWQg
SEVMUEVSKHJhaXNlX2V4Y2VwdGlvbikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4
Y3ApCitHX05PUkVUVVJOIHZvaWQgSEVMUEVSKHJhaXNlX2V4Y2VwdGlvbikoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHVpbnQzMl90IGV4Y3AsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgUEMpCiB7Ci0gICAgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJy
KGVudiwgZXhjcCwgMCk7CisgICAgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKGVudiwgZXhj
cCwgUEMpOwogfQogCiB2b2lkIGxvZ19zdG9yZTMyKENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJn
ZXRfdWxvbmcgYWRkciwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIv
dGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggZGRmMzI4ZTBhNjIuLmU0YTA5OTNjODhh
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYwpAQCAtMTI0LDEyICsxMjQsMTkgQEAgaW50cHRyX3QgY3R4X3RtcF92
cmVnX29mZihEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJlZ251bSwKICAgICByZXR1cm4gb2Zmc2V0
OwogfQogCi1zdGF0aWMgdm9pZCBnZW5fZXhjZXB0aW9uX3JhdyhpbnQgZXhjcCkKK3N0YXRpYyB2
b2lkIGdlbl9leGNlcHRpb24oaW50IGV4Y3AsIHVpbnQzMl90IFBDKQogewotICAgIGdlbl9oZWxw
ZXJfcmFpc2VfZXhjZXB0aW9uKHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIoZXhjcCkpOworICAg
IGdlbl9oZWxwZXJfcmFpc2VfZXhjZXB0aW9uKHRjZ19lbnYsIHRjZ19jb25zdGFudF9pMzIoZXhj
cCksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50X2kzMihQQykp
OwogfQogCiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5f
cHJlY2lzZV9leGNlcHRpb24oaW50IGV4Y3AsIHVpbnQzMl90IFBDKQoreworICAgIHRjZ19nZW5f
bW92aV9pMzIoaGV4X2NhdXNlX2NvZGUsIGV4Y3ApOworICAgIGdlbl9leGNlcHRpb24oSEVYX0VW
RU5UX1BSRUNJU0UsIFBDKTsKK30KKwogc3RhdGljIGlubGluZSB2b2lkIGdlbl9wY3ljbGVfY291
bnRlcnMoRGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgaWYgKGN0eC0+cGN5Y2xlX2VuYWJsZWQp
IHsKQEAgLTIxMyw4ICsyMjAsMTEgQEAgc3RhdGljIHZvaWQgZ2VuX2VuZF90YihEaXNhc0NvbnRl
eHQgKmN0eCkKIHZvaWQgaGV4X2dlbl9leGNlcHRpb25fZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4
LCBpbnQgZXhjcCkKIHsKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwotICAgIHRjZ19nZW5f
bW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPm5leHRfUEMpOwotICAgIGdlbl9leGNl
cHRpb25fcmF3KGV4Y3ApOworI2lmZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBnZW5fZXhjZXB0
aW9uKGV4Y3AsIGN0eC0+cGt0LT5wYyk7CisjZWxzZQorICAgIGdlbl9wcmVjaXNlX2V4Y2VwdGlv
bihleGNwLCBjdHgtPnBrdC0+cGMpOworI2VuZGlmCiAgICAgY3R4LT5iYXNlLmlzX2ptcCA9IERJ
U0FTX05PUkVUVVJOOwogfQogCkBAIC0yMjgsNyArMjM4LDcgQEAgc3RhdGljIHZvaWQgZ2VuX2V4
Y2VwdGlvbl9kZWNvZGVfZmFpbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG53b3JkcywgaW50IGV4
Y3ApCiAKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5fbW92aV90bCho
ZXhfZ3ByW0hFWF9SRUdfUENdLCBmYWlsX3BjKTsKLSAgICBnZW5fZXhjZXB0aW9uX3JhdyhleGNw
KTsKKyAgICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGZhaWxfcGMpOwogICAgIGN0eC0+YmFzZS5pc19q
bXAgPSBESVNBU19OT1JFVFVSTjsKICAgICBjdHgtPmJhc2UucGNfbmV4dCA9IGZhaWxfcGM7CiB9
Ci0tIAoyLjM0LjEKCg==

