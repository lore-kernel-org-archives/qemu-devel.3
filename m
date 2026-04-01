Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98AD10F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV8-000216-2l; Wed, 01 Apr 2026 11:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xV6-0001xb-3M
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:29:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xV4-0008GP-Fl
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631FFEZw1562707
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z8Us83zLUbX2M9VvBxeV8Cr0l/114WWLghqDSjaR9/A=; b=gRLfiu8UZ1oINdZA
 fi5I1SyEIYFIgSOkXcck0pZHZGu8D8bB+yApSaUk7KdGQPBaI5JXlpLEX0BUl7vf
 CUdryy5oZLz0DTWf0iPFD9KJHI83UY2UgDIKDU1p41KFVtT6cPO3kuZZJwIae8Nj
 17jiDvAZXTEEs9gwSsPsf7ccmT0RnLUBCpZu3WGydrkduJCljiFyudnpz015EZ2x
 uML79PchMDJgY/RMzYq17lxU/21OD88oDec+nJ0wpaDX3RSc8DsTCmMw2gEBUpws
 P4H74AGMh9mU6Ks2YTC2anRpPIuYALO1kAk4toykYRIlUqMkjiPx+6cxnYbY3KpW
 WRCIjw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8va3tqa9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c5b48baf75so8792504eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057279; x=1775662079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8Us83zLUbX2M9VvBxeV8Cr0l/114WWLghqDSjaR9/A=;
 b=OFmRuE8KzCDZpaU6oblHr8yLjuYk9ps7/Ov7dCPlXcTAyJ6zSqYFxtDjBn5fYAvcGt
 I/GZ9NF3VvDw5Gd1/hGqQrFHYEAGI36FRWzYwzC4rr03tjUsMQhrxSTRQOmWzTtmlXyX
 oeqJwisxd56Xz3anM2QMPr1yIEyG9sQ7BfVdb2VPfsm4zzf92vAgp08dm/pNiGe3VQfi
 FCW9/3HN36k6kughc5Wt4djKeQ/MO6+AP6ATULG3t0dSp7NuXPO9PJKuSnsa0TcQgVSh
 gU0MaRZWV8Yto9RXvN0SzV5FtCdH/eWhgwRCCX4khp/4pX/rAOZblQNPFgfCjL+osOhn
 UthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057279; x=1775662079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8Us83zLUbX2M9VvBxeV8Cr0l/114WWLghqDSjaR9/A=;
 b=XfJYFgLuNmHrM8ygMwV+29zY1PuhBH51M/Zl+hR/kayNl4xgs546oVDoExWy4k/ht8
 0FiuLWcd2815RVM/OgQlxT7irK6SdNoXUoXZMspTrs5phmDeh0PXHq9TiE2MuvdCJiTL
 pJ4j18VO2NvZkid8A7BPlm159k7JC8PtECtWVyovWwEc8VzwFzSYDR7x0cREfElWxg6q
 3lmiRMZ7/Jx2IdY+K9Dz7f+/e81QLGkR00Dd1a0jSRacDGB9fX7EIlU3HJxYtdgfRQVt
 t/sqv84P7MOmNX+o/Gkvtsy/MOzHp9lmUk/UH3Qj9l3yqz49+ggjWdg4UHyxfbXTKQ0i
 v4/g==
X-Gm-Message-State: AOJu0YxQMVQcXejDuYbUKKpP6sbQD4Ty1y7aXsD5C7pX47MVnx1xYpqt
 EP789wtlYLWxKC/Kmp5SkxEDGbg3EYpj/RJHuoXJNf1QsrphUGtKxS+mz/8O3NYSkgyqZP3fW3t
 w6mAGmEjKLf6Oc2CJ+0m9Hh8Cgb9WjXTLN6Dm6QvmXesssqQmY89coaJgMjwuNB4o3A==
X-Gm-Gg: ATEYQzzwK9fGPeoaBdEO9PIY1siBN1B8LGdHDplMg+KYWPueBLT6Fr7dK8aTIfdIoSJ
 LugGHkhGziToylW/drD/ffYNOTpy/CS6kYhhVx96Pd+mCySBCX73uCjRlsaCdUVHGebhWKuA6Fg
 YFW0yVyHt7ej8bG48gpbSu6GFWA5PrtkuPwlGG4c6X4pF9DHu7maMqSt3tRr01Fyn0lhtgZrEB8
 ZTIal684ufbpLB9YxlxBZiQH8s51u58kVo8YIjmOs+i+Wwow93QIzp9vHZBrhuMQNvOkNwg7MxZ
 Rie0LMocdDSJNAfg5woS+z69Do5vbZFPMHg7tnOLpHf7USpxQB8ufl6bFuXELY+NdhxQWQne8XN
 Fxo/+LV2x27WtH9k2C6AjxGJ1VLvwhl+OcikVFMh2UBQZoPmHj80nW5r166mC0dhwsV3EyQ==
X-Received: by 2002:a05:7301:fa08:b0:2be:2953:fd74 with SMTP id
 5a478bee46e88-2c931281111mr2164112eec.14.1775057279384; 
 Wed, 01 Apr 2026 08:27:59 -0700 (PDT)
X-Received: by 2002:a05:7301:fa08:b0:2be:2953:fd74 with SMTP id
 5a478bee46e88-2c931281111mr2164091eec.14.1775057278810; 
 Wed, 01 Apr 2026 08:27:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 14/37] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Wed,  1 Apr 2026 08:26:34 -0700
Message-Id: <20260401152657.314902-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Ix5ZGl46EdZdMkop-uNTWTUyuMoTwSpz
X-Proofpoint-ORIG-GUID: Ix5ZGl46EdZdMkop-uNTWTUyuMoTwSpz
X-Authority-Analysis: v=2.4 cv=B/C0EetM c=1 sm=1 tr=0 ts=69cd39ae cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX0ClvuCgCd6mg
 AlnizqvPAvl4BZ8yDF7BUqK1/0oZrzSjaMppiucYWbIHHe1ol3fKIO44bKuBsKKkFZCHcmicEvr
 TZJZ8xaIolh9g+mtABmw7yvnfU+lxoPvaabWa1Kb6cyBJRSN74DOK+FgBqf3ut8Ek+xmzLeaWXJ
 NdLkk4uKA2BoiX1RvqnqQZnrJf/C8QHbREHN09eIIJmVn9H2g9Z7jaA/DxaDcodlShh4OmprJCQ
 ny7xKm0V4vNZQB6BY7GDpyysMe46OqIUajMkJPYOyy31TzYEydtVlABledN1+2W7TpLBYJ0LN7i
 TZvy43eDZH5Z5X9IzWpXut8G4BTLGGWFCN6GOn8h3DvJqaY0QOfg8ZrBpVA4aWMl5+/7PzHTiwe
 HjdJRzIl9y/mbWggmbWAth3vvjn9OY5loZTeSxPH+yln5i2CsG0BJNmOmewR8DH5OJKN9ePrsYt
 Gy05BStM4EqZg3IG+Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggNDBkMzY1ZjQy
NTAuLjdlNTI4Mzc5ZGI2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDAsNiArNDAsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4s
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9y
ZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRl
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaW50IGdyZWdfbG9nW0dSRUdfV1JJVEVT
X01BWF07CisgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklU
RVNfTUFYXTsKKyAgICBpbnQgc3JlZ19sb2dfaWR4OworICAgIFRDR3ZfaTMyIHRfc3JlZ19uZXdf
dmFsdWVbTlVNX1NSRUdTXTsKKyAgICBUQ0d2X2kzMiBncmVnX25ld192YWx1ZVtOVU1fR1JFR1Nd
OworI2VuZGlmCiAgICAgaW50IHByZWdfbG9nW1BSRURfV1JJVEVTX01BWF07CiAgICAgaW50IHBy
ZWdfbG9nX2lkeDsKICAgICBERUNMQVJFX0JJVE1BUChwcmVnc193cml0dGVuLCBOVU1fUFJFR1Mp
OwpAQCAtODAsNiArODgsMzQgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKIAogYm9v
bCBpc19nYXRoZXJfc3RvcmVfaW5zbihEaXNhc0NvbnRleHQgKmN0eCk7CiAKKyNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQorc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0ZShEaXNh
c0NvbnRleHQgKmN0eCwgaW50IHJudW0pCit7CisgICAgYXNzZXJ0KHJudW0gPD0gSEVYX0dSRUdf
RzMpOworICAgIGN0eC0+Z3JlZ19sb2dbY3R4LT5ncmVnX2xvZ19pZHhdID0gcm51bTsKKyAgICBj
dHgtPmdyZWdfbG9nX2lkeCsrOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19ncmVn
X3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBybnVtKQoreworICAgIGFzc2VydCgh
KHJudW0gJSAyKSk7CisgICAgY3R4X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSk7CisgICAgY3R4
X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSArIDEpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQg
Y3R4X2xvZ19zcmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBj
dHgtPnNyZWdfbG9nW2N0eC0+c3JlZ19sb2dfaWR4XSA9IHJudW07CisgICAgY3R4LT5zcmVnX2xv
Z19pZHgrKzsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfc3JlZ193cml0ZV9wYWly
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUo
Y3R4LCBybnVtKTsKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUoY3R4LCBybnVtICsgMSk7Cit9Cisj
ZW5kaWYKKwogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfcHJlZF93cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHBudW0pCiB7CiAgICAgaWYgKCF0ZXN0X2JpdChwbnVtLCBjdHgtPnByZWdz
X3dyaXR0ZW4pKSB7Ci0tIAoyLjM0LjEKCg==

