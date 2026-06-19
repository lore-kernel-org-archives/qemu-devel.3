Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5971CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifc-0003u2-LF; Fri, 19 Jun 2026 19:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifa-0003te-JS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifY-0007Qh-Ta
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:42 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYAJJ1336520
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=; b=AjXIKFvkTUqNEye8
 qSPJW/ombn8CVdri08VJr4kvrMe9fSI+ig5eYg6VaF184Gmyg7iETyYu8ayCpI0t
 4clDKilqgm4h+bhZ1JyZTvo323B0SV1DKftnEF1wgCQW7exI0vThgrm4YAVJJhEb
 4cZDOi7r/3FUMkuegWbPtvgErEvnMcG7wdRJetvFRnCCS+BIhvShRyOt/beOnBR2
 gMeQyhiu3KEwPpI7N69B198aHQ0HvwmF0xLZq7gQm0nC98KeXrPcQYVL4sqOBB4s
 aZ7AbICX/N5MIy3cO+qnMDrE/SKiJDmjQBuC+pzDofqtDjkfvfhyYHJwjKIm2aqf
 JF977g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp67579w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so4641065eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911829; x=1782516629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=;
 b=YBGTBhN6R1+dnjwB5CC9up9NClJW7GVa2Ptx96RAZTOb8p5UBGs8QrInUia/tIXR3Y
 3v4dAagOHbKotKMKDBz7quzrq4AOlmO6XF4r6zd+l650MZ/EFkC3sGSk+YuKTKryHBLj
 FWPNCofvswYncr9t6bth4GdMefBWzHrjgRfL++DnHfnMkFIQL6KWicvWzvMmMXOWZEC4
 uvRgS/90qZ+EFDExEAQgpwlDQKpgsM4DIyK1qOaHSQd71zdP3GerqojIX1Jz29HUrOLz
 3Tjye5yfhMdlrb9tEzLG8n/XZFXa3eolKE9/Q96hAIpKMx/mpHwcf4Ax9xvlgh1T+xL0
 jABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911829; x=1782516629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=;
 b=V7eUvHCvx1+K5eELen8hFK5FXosPLu/3+8s5wRA/Aq8C1cvQ3p0nSCHp+XuxZ8r/+O
 f8lNOiDkT/94qTOW5B8Gkq6JUXg1M2XlnxKk85hDgrtEsVP0tFBF7p1WUMTMvzED/Vi6
 A3CU0fuRfX5o9IAvXnmjrbvm/0kaIgAq2kFgie/hh7kT1zO3VzvVBHga0ERcKQZJsbvP
 q8uwriv5kJCI0bD8xc4HJFpXD4rs1TmljG5L6Viq/+iHgDAv5hCX1J3Xuu8ANAerSpid
 3FgEfphoswCSIU2wxxkrpPJooesNzNUee7A78BaWx58PPLM5RtnsjUCPvh+K+JZ+14cD
 nxMA==
X-Gm-Message-State: AOJu0YxieNBbBS6aGfHgwRFcymn3pIs/hTUi+R5iTc8dvFu8DuwIsod4
 YATQvhSHzXF0fqdoXqxkTHH9vHTuHlDfIROCs79MGMNYGxIvV+vl14yrAYt6sqkYdSiAw3MTMqq
 D/4DRo2vQFUeV7+xZV2qrq7UVWZruOcZ+7tV0paq64FvfCXJ8+PeCvGKlEw4/QYm0iw==
X-Gm-Gg: AfdE7cmuXrHAgCE5dH69GwEMsaaLDQ6xSebDt1O6NR22zGXhQm1o1+x0ThnbD+Xl0Ba
 QHe7D+2+gm7c8NQCZTecA/287Y49QJfS0rEPyf8CzWDVWCcxO3X7PAgbvyR9Ny6NoxE1Bi55gHW
 zh39oafx04hgLGs5QCj/v6KJwxaiqIAM2rpz496gGOUWBRwq3nOdTrnRuU0ivAAukbZ0g7JcEYn
 nYXHsOqnnIfJkggiHdWhkYlOaDQ5eaYFFZEiznblAJ0TESC0XH1xJE+pTT/B2pClfPPM/kGYt8o
 yqj3rWq0OENYm72OYPyD2P34KbZtEjPGysIk8KppMiaPWY9dRewTUtlewoUHiMp0J71m+a6vtls
 Ld5G0AxHexHU3KWy7N8oizmZJckSRD394bWxQzjZkyTfzykqoshQd4SikjiQ=
X-Received: by 2002:a05:693c:830d:b0:30c:1707:e4b0 with SMTP id
 5a478bee46e88-30c1707ea2bmr938634eec.25.1781911828854; 
 Fri, 19 Jun 2026 16:30:28 -0700 (PDT)
X-Received: by 2002:a05:693c:830d:b0:30c:1707:e4b0 with SMTP id
 5a478bee46e88-30c1707ea2bmr938625eec.25.1781911828287; 
 Fri, 19 Jun 2026 16:30:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 51/74] target/hexagon: Implement setprio, resched
Date: Fri, 19 Jun 2026 15:58:48 -0700
Message-Id: <20260619225911.159473-52-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: oRQc-Z7ZMvCLW3Q8GJkgmZUWy4YAveiC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX89Ley1n/QgH5
 pOOigtjM7anP4+fozaQkAvnEV2eVOFfgFQ0xOkinG3iDpph+ATOBECn59hlSOSpDMINbkZHtfM0
 vigw4v289zXwPmFYQdS/LiSSVyHdV+nCJbs6IutKRkFjKkHKyZajomDNVij4jjuZgqjO4mq3dU0
 sJB3opLZs+jXtluDpL1jSvxooaM69Y3UyrFJ7LG3QugupEAlWjlJpQ9qxm5mqf+DKrBhpt5/X7V
 bBK5QRKPW9aLSp3He2UKQnhGfuwdMM56UWDWjb09pCFtH4g/UZ8+0L0LWA+6V64olOpVGY5FcGU
 j7eQ2mi81pO30jfuSL/wQk/RT9Kt5F3JU/5dspI9DNR1Iu9Fxixo3sVs7kExFeVn/g7QkJKgioJ
 pviycaSWo3Rvb+xDfRXOOKrg8wArpxPSiBVGXls+qq0pIZECzpYulad9n7nMHTg/bC9UnjXzfk/
 MRMagWGhymywz02HLvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX4RDo6X8MJwtN
 YgdzBi2YRSCIp/k/gPeOS/aE29p4MHakcycBIziis0qUOzDiOR+ZKxBPnFY5kvMJfD52C7WNj3Q
 /e9u9YsaA/6wnSqw0FDL1j7VBmtYJh8=
X-Proofpoint-GUID: oRQc-Z7ZMvCLW3Q8GJkgmZUWy4YAveiC
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d115 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9hY_xzidxOicKg_qOOkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgaGFyZHdhcmUtYXNzaXN0
ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVuIHF1ZXVlCmFuZCBpbnRl
cnJ1cHQgc3RlZXJpbmcuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
fCA3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDc3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDM0YzU1YjU2MGNhLi4zYzI1
M2IzOTFlNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE1OTAsNiArMTU5MCw2NCBAQCBzdGF0aWMgdm9p
ZCBoZXhhZ29uX3dhaXRfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykK
ICAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOwogfQogCitzdGF0aWMg
aW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCit7CisgICAgdWludDMyX3Qgc2NoZWRjZmc7CisgICAgdWludDMyX3Qgc2NoZWRjZmdfZW47
CisgICAgaW50IGludF9udW1iZXI7CisgICAgQ1BVU3RhdGUgKmNzOworICAgIHVpbnQzMl90IGxv
d2VzdF90aF9wcmlvID0gMDsgLyogMCBpcyBoaWdoZXN0IHByaW8gKi8KKyAgICB1aW50MzJfdCBi
ZXN0d2FpdF9yZWc7CisgICAgdWludDMyX3QgYmVzdF9wcmlvOworICAgIEhleGFnb25DUFUgKmNw
dTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lO
VCwgIiVzOiBjaGVjayByZXNjaGVkXG4iLCBfX2Z1bmNfXyk7CisgICAgY3B1ID0gZW52X2FyY2hj
cHUoZW52KTsKKyAgICBzY2hlZGNmZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgIGhleGFn
b25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19TQ0hFRENGRywKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7CisgICAgc2No
ZWRjZmdfZW4gPSBHRVRfRklFTEQoU0NIRURDRkdfRU4sIHNjaGVkY2ZnKTsKKyAgICBpbnRfbnVt
YmVyID0gR0VUX0ZJRUxEKFNDSEVEQ0ZHX0lOVE5PLCBzY2hlZGNmZyk7CisKKyAgICBpZiAoIXNj
aGVkY2ZnX2VuKSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICBDUFVfRk9SRUFDSChj
cykgeworICAgICAgICBIZXhhZ29uQ1BVICp0aHJlYWQgPSBIRVhBR09OX0NQVShjcyk7CisgICAg
ICAgIENQVUhleGFnb25TdGF0ZSAqdGhyZWFkX2VudiA9ICYodGhyZWFkLT5lbnYpOworICAgICAg
ICB1aW50MzJfdCB0aF9wcmlvID0gR0VUX0ZJRUxEKAorICAgICAgICAgICAgU1RJRF9QUklPLCB0
aHJlYWRfZW52LT50X3NyZWdbSEVYX1NSRUdfU1RJRF0pOworICAgICAgICBpZiAoIWhleGFnb25f
dGhyZWFkX2lzX2VuYWJsZWQodGhyZWFkX2VudikpIHsKKyAgICAgICAgICAgIGNvbnRpbnVlOwor
ICAgICAgICB9CisKKyAgICAgICAgbG93ZXN0X3RoX3ByaW8gPSAobG93ZXN0X3RoX3ByaW8gPiB0
aF9wcmlvKQorICAgICAgICAgICAgPyBsb3dlc3RfdGhfcHJpbworICAgICAgICAgICAgOiB0aF9w
cmlvOworICAgIH0KKworICAgIGJlc3R3YWl0X3JlZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19CRVNU
V0FJVCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7
CisgICAgYmVzdF9wcmlvID0gR0VUX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIGJlc3R3YWl0X3JlZyk7
CisKKyAgICAvKgorICAgICAqIElmIHRoZSBsb3dlc3QgcHJpb3JpdHkgdGhyZWFkIGlzIGxvd2Vy
IHByaW9yaXR5IHRoYW4gdGhlCisgICAgICogdmFsdWUgaW4gdGhlIEJFU1RXQUlUIHJlZ2lzdGVy
LCB3ZSBtdXN0IHJhaXNlIHRoZSByZXNjaGVkdWxlCisgICAgICogaW50ZXJydXB0IG9uIHRoZSBs
b3dlc3QgcHJpb3JpdHkgdGhyZWFkLgorICAgICAqLworICAgIGlmIChsb3dlc3RfdGhfcHJpbyA+
IGJlc3RfcHJpbykgeworICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULAorICAgICAg
ICAgICAgICAgICIlczogcmFpc2luZyByZXNjaGVkIGludCAldSwiCisgICAgICAgICAgICAgICAg
IiBjdXIgUEMgMHglIiBQUkl4MzIgIlxuIiwKKyAgICAgICAgICAgICAgICBfX2Z1bmNfXywgKHVu
c2lnbmVkKWludF9udW1iZXIsIGVudi0+Z3ByW0hFWF9SRUdfUENdKTsKKyAgICAgICAgU0VUX1NZ
U1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX0JFU1RXQUlULCBCRVNUV0FJVF9QUklPLCB+MCk7Cisg
ICAgICAgIGhleF9yYWlzZV9pbnRlcnJ1cHRzKGVudiwgMSA8PCBpbnRfbnVtYmVyLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CisgICAgfQorfQorCiB2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgUEMpCiB7CiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKQEAgLTE2OTgs
OCArMTc1NiwyNyBAQCB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25T
dGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0K
IAorLyoKKyAqIHNldHByaW8vcmVzY2hlZCAtIGhhcmR3YXJlLWFzc2lzdGVkIHNjaGVkdWxlciBo
ZWxwZXJzIGZvciBtYW5hZ2luZworICogdGhlIHJ1biBxdWV1ZSBhbmQgaW50ZXJydXB0IHN0ZWVy
aW5nLgorICovCiB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgdGhyZWFkLCB1aW50MzJfdCBwcmlvKQogeworICAgIENQVVN0YXRlICpjczsKKworICAg
IEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgSGV4YWdv
bkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgICAgICBDUFVIZXhhZ29uU3Rh
dGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAgICAgICAgaWYgKHRocmVhZCA9PSBm
b3VuZF9lbnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5k
X2VudiwgSEVYX1NSRUdfU1RJRCwgU1RJRF9QUklPLCBwcmlvKTsKKyAgICAgICAgICAgIHFlbXVf
bG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICIlczogdGlk
ICUiIFBSSXUzMiAiIHByaW8gPSAweCUiIFBSSXgzMiAiXG4iLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX2Z1bmNfXywgZm91bmRfZW52LT50aHJlYWRJZCwgcHJpbyk7CisgICAgICAgICAg
ICByZXNjaGVkKGVudik7CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICB9CiAg
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KIAotLSAKMi4zNC4xCgo=

