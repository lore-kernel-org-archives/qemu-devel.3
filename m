Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B911910F6FD9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV4-0001qm-Vx; Wed, 01 Apr 2026 11:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUz-0001IR-PS
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUy-00084R-9T
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631F8kDj1580398
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=; b=BNS5rvFnovyXTVHx
 rZuL00X9D9XrsOMtDuCulDdyt8Xfdu7FYe9p1cnc9ZG+D1l887pZkFmjraFIfIHm
 SvLHpH186wgfhkuMb9KQ+JYpETTdv7F0+YNwEM33yAWytJOeViALKHR8OEsiCr8c
 U9isbyBwpxXJDAilsGQHJSXaImTQiVZXlQjxlFqFQwu/S6+GYwE7NbZburb1Mp5H
 jpnElbf8cDh8LhzdGzwmY5xbQKgZ9qRisNIGbCFoqVo7J1+/QGkWz4OLoXqs79tq
 6TXTZbUSjVZYwDe3Iu/vkVZWX5FRspo0Q73+tbOEC0rRp0znyl15XQytWIMTZ4rJ
 NK+SVQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2vbjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c5b48baf75so8793133eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057285; x=1775662085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=MXsAWH5GaOoqGCI+9yecMKYWOoTol3LxTxCjqpdX2UtwRSU27HL0mu3iAcOa7b919k
 hEwPBCuXad/vJmxZdZzwX8OsqRb0No1BslOgQkjnmtgUF4NI0CNrF8yxIWLWXzD7ikDp
 ojEAUFspTVZtKF2jZizqeUpJhetpTOQYxMNs1d3fvWaxOHronfX1Ct3LSG5s15/INEwC
 XTyexV43VwIPvKlkqGIYt4PC9Jn7e9T+Y+k29x8sCndnpJn/cF4YHA3KzK8/wFBp8OLa
 iLj1s1S/8NB5X1mYVMbbh2kgEpHTnQMpNyXpwCcY0E5wRbB8VWkD2uwiWno2/h9puOuC
 qzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057285; x=1775662085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=rIVY9wIo0a1piPW673LhJQjA1apG06kFP7hcaLWriskBPKfhcMU8s1FZ6ew8R1S0WD
 UkKvRkWO0PmWZEDmjVEn9ZhAoM1echuBcRNyAWjYDOkE0zHknGipu+8ank2aWiPzH4Ic
 6oiwOOER+6VPQCztJzWyTETgTj8rPNqZVzTr9bifZsEKYNqY8S7fjdK9Ind3lHk4hO5k
 NwvEFAIySAZiylOT5EmAglQ2Ek19jWS1EPp0bcujLTrtk+ymxFjoC59L0dD6tOy4GaJ3
 5Lup8g2cJj7+pu7eTZvHPuJqSBHzfHdeaqsFKOEXFepj51MBcwEPM+SbTMP7S5SkFljM
 /+BA==
X-Gm-Message-State: AOJu0Yw57HJDUxE7ow47nHCo0L2JZsQOqCzXJFBbAVUWxCKHRPyZEWAR
 DTihPWM1zabb2rRX8aWn64VlRbhHpLqs4sg/vigO531o3jvz7WqmxjoNxgX9daRoLv6hbu8MbUf
 bDg9PCw8dwls0S7BYrMKQSpsVzVfwZ/ZXzpXMDDPAHCT0+L8unrGGTfq7CC+BAdDWTg==
X-Gm-Gg: ATEYQzzMt/VOsIsOC3Vz8QSnzJOogQvQH5jCBVuhz/fXCnC1BeR62Ey5yACaRoiR/hV
 M+kbZ6jb3ibbRwCHDYf37x8y049HfZfqryyZHchK0hU4hUV/PQF1W6trBY375T6Sao2qjdZOOmr
 uNNFyh5i66kT+y3ilV9wO0BZgTE84Blf8101/mNL+eWsr92W/8vA0ZBBsqZ6udjngtdOMfwbnpa
 2LTAKRpV7ZWESIdt+0elbUY5Q0M4Lf3PglPEvq68SNOgN7GbQU+WSZ+fTFN6HdHYZ/Kx2sIhpl7
 YtdAwPWEHNeBwvQpmVcgMv7WyJX8XNyNE+ye7SuH3UR/kc0pILC2BpMbJh4Jab1Qrh+4XMyS5c2
 lvJvFpP7ts8qpcct4BxGY7bN6I51jW922waZOQWidHLaHvhGnVApjzbsZlZes3bfnb1vBmw==
X-Received: by 2002:a05:7301:6790:b0:2c8:7172:3b86 with SMTP id
 5a478bee46e88-2c9323b91a5mr2466932eec.22.1775057285467; 
 Wed, 01 Apr 2026 08:28:05 -0700 (PDT)
X-Received: by 2002:a05:7301:6790:b0:2c8:7172:3b86 with SMTP id
 5a478bee46e88-2c9323b91a5mr2466907eec.22.1775057284876; 
 Wed, 01 Apr 2026 08:28:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 21/37] target/hexagon: Define register fields for system
 regs
Date: Wed,  1 Apr 2026 08:26:41 -0700
Message-Id: <20260401152657.314902-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69cd398b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UAyLp9M6nUPA2EoZ1MNDpW8hdVgrQ1A4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX6TkxFgLprvqX
 B+vA4oacmCHNQmURfJF1fh0+Rg93nKSFX9COiJJzjLY4W3OBmAlAIy7hNmTVromK+m8pxjQR3WN
 tseW6FrPXVAD0c3H8+xwFC8GiqIok17NIWYmEOhxP1wqQSLlikyzC2iFox9xdUxiWmwzg9bXeS+
 cZLQ7Ktpomllv9USrJ3lZnuua1QP1rzVKB2OgAXt4b4MQiUNjvxJsXa+CV0FIj3/gTGSia/mQYg
 cjU5eSX90PhBFL0l8YkicwhFm+TnXCGNrVVcrkdIAl618AbuS3uDn7rKKsmaWsFViOO0Fo1Bgdu
 sR8h8N7SDaw2hIO0TWmNQMI66HBCtpV40lj7+cJoyVsmlB+LepgJ3T3tIw1andKN4ZLCBkJ3tYw
 ul/spCjm1+8IG+ZErCW96ZLnY+OA+8SYiqZ4pG8N8wzrPwR7VPc+yxOmFHbrQbTmP91JMshxLLs
 ez9j/ImId37P+MEw6Wg==
X-Proofpoint-GUID: UAyLp9M6nUPA2EoZ1MNDpW8hdVgrQ1A4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgdGhlIHJlZ2lzdGVy
IGZpZWxkcyBmb3Igc3NyLCBzY2hlZGNmZywgc3RpZCwgYmVzdHdhaXQsIGNjciwKbW9kZWN0bCwg
aW1hc2ssIGlwZW5kYWQuCgpEZWZpbmUgdGhlIGZpZWxkcyBmb3IgVExCIGVudHJpZXMuCgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyB8IDk2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24v
cmVnX2ZpZWxkc19kZWYuaC5pbmMKaW5kZXggZjJhNThkNDg2YzUuLjliMTEyY2NlYzY0IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYworKysgYi90YXJnZXQv
aGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwpAQCAtMzksMyArMzksOTkgQEAgREVGX1JFR19G
SUVMRChVU1JfRlBEQlpFLCAgICAgICAgMjYsIDEpCiBERUZfUkVHX0ZJRUxEKFVTUl9GUE9WRkUs
ICAgICAgICAyNywgMSkKIERFRl9SRUdfRklFTEQoVVNSX0ZQVU5GRSwgICAgICAgIDI4LCAxKQog
REVGX1JFR19GSUVMRChVU1JfRlBJTlBFLCAgICAgICAgMjksIDEpCisKK0RFRl9SRUdfRklFTEQo
SVBFTkRBRF9JQUQsIDE2LCAxNikKK0RFRl9SRUdfRklFTEQoSVBFTkRBRF9JUEVORCwgMCwgMTYp
CisKK0RFRl9SRUdfRklFTEQoU0NIRURDRkdfRU4sIDgsIDEpCitERUZfUkVHX0ZJRUxEKFNDSEVE
Q0ZHX0lOVE5PLCAwLCA0KQorREVGX1JFR19GSUVMRChCRVNUV0FJVF9QUklPLCAwLCA5KQorCisK
Ky8qIFBURSAoYWthIFRMQiBlbnRyeSkgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKFBURV9QUEQs
IDAsIDI0KQorREVGX1JFR19GSUVMRChQVEVfQywgMjQsIDQpCitERUZfUkVHX0ZJRUxEKFBURV9V
LCAyOCwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX1IsIDI5LCAxKQorREVGX1JFR19GSUVMRChQVEVf
VywgMzAsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9YLCAzMSwgMSkKK0RFRl9SRUdfRklFTEQoUFRF
X1ZQTiwgMzIsIDIwKQorREVGX1JFR19GSUVMRChQVEVfQVNJRCwgNTIsIDcpCitERUZfUkVHX0ZJ
RUxEKFBURV9BVFIwLCA1OSwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX0FUUjEsIDYwLCAxKQorREVG
X1JFR19GSUVMRChQVEVfUEEzNSwgNjEsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9HLCA2MiwgMSkK
K0RFRl9SRUdfRklFTEQoUFRFX1YsIDYzLCAxKQorCisvKiBTWVNDRkcgZmllbGRzICovCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19NTVVFTiwgMCwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0lDRU4s
IDEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19EQ0VOLCAyLCAxKQorREVGX1JFR19GSUVMRChT
WVNDRkdfSVNEQlRSVVNURUQsIDMsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19HSUUsIDQsIDEp
CitERUZfUkVHX0ZJRUxEKFNZU0NGR19JU0RCUkVBRFksIDUsIDEpCitERUZfUkVHX0ZJRUxEKFNZ
U0NGR19QQ1lDTEVFTiwgNiwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX1YyWCwgNywgMSkKK0RF
Rl9SRUdfRklFTEQoU1lTQ0ZHX0lHTk9SRURBQk9SVCwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU1lT
Q0ZHX1BNLCA5LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfVExCTE9DSywgMTEsIDEpCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19LMExPQ0ssIDEyLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfQlEs
IDEzLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfUFJJTywgMTQsIDEpCitERUZfUkVHX0ZJRUxE
KFNZU0NGR19ETVQsIDE1LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJDRkcsIDE2LCAzKQor
REVGX1JFR19GSUVMRChTWVNDRkdfSVRDTSwgMTksIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19M
Mk5XQSwgMjEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMk5SQSwgMjIsIDEpCitERUZfUkVH
X0ZJRUxEKFNZU0NGR19MMldCLCAyMywgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyUCwgMjQs
IDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19TTFZDVEwwLCAyNSwgMikKK0RFRl9SRUdfRklFTEQo
U1lTQ0ZHX1NMVkNUTDEsIDI3LCAyKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJQQVJUU0laRSwg
MjksIDIpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMkdDQSwgMzEsIDEpCisKKy8qIFNTUiBmaWVs
ZHMgKi8KK0RFRl9SRUdfRklFTEQoU1NSX0NBVVNFLCAwLCA4KQorREVGX1JFR19GSUVMRChTU1Jf
QVNJRCwgOCwgNykKK0RFRl9SRUdfRklFTEQoU1NSX1VNLCAxNiwgMSkKK0RFRl9SRUdfRklFTEQo
U1NSX0VYLCAxNywgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0lFLCAxOCwgMSkKK0RFRl9SRUdfRklF
TEQoU1NSX0dNLCAxOSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1YwLCAyMCwgMSkKK0RFRl9SRUdf
RklFTEQoU1NSX1YxLCAyMSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0JWUywgMjIsIDEpCitERUZf
UkVHX0ZJRUxEKFNTUl9DRSwgMjMsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9QRSwgMjQsIDEpCitE
RUZfUkVHX0ZJRUxEKFNTUl9CUCwgMjUsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9YRTIsIDI2LCAx
KQorREVGX1JFR19GSUVMRChTU1JfWEEsIDI3LCAzKQorREVGX1JFR19GSUVMRChTU1JfU1MsIDMw
LCAxKQorREVGX1JFR19GSUVMRChTU1JfWEUsIDMxLCAxKQorCisvKiBtaXNjIHJlZ2lzdGVycyAq
LworREVGX1JFR19GSUVMRChJTUFTS19NQVNLLCAwLCAxNikKKworREVGX1JFR19GSUVMRChTVElE
X1BSSU8sIDE2LCA4KQorREVGX1JFR19GSUVMRChTVElEX1NUSUQsIDAsIDgpCisKKy8qIE1PREVD
VEwgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKE1PREVDVExfRSwgMCwgOCkKK0RFRl9SRUdfRklF
TEQoTU9ERUNUTF9XLCAxNiwgOCkKKworREVGX1JFR19GSUVMRChDQ1JfTDFJQ1AsIDAsIDIpCitE
RUZfUkVHX0ZJRUxEKENDUl9MMURDUCwgMywgMikKK0RFRl9SRUdfRklFTEQoQ0NSX0wyQ1AsIDYs
IDIpCisKK0RFRl9SRUdfRklFTEQoQ0NSX0hGSSwgMTYsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9I
RkQsIDE3LCAxKQorREVGX1JFR19GSUVMRChDQ1JfSEZJTDIsIDE4LCAxKQorREVGX1JFR19GSUVM
RChDQ1JfSEZETDIsIDE5LCAxKQorREVGX1JFR19GSUVMRChDQ1JfU0ZELCAyMCwgMSkKKworREVG
X1JFR19GSUVMRChDQ1JfR0lFLCAyNCwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX0dURSwgMjUsIDEp
CitERUZfUkVHX0ZJRUxEKENDUl9HRUUsIDI2LCAxKQorREVGX1JFR19GSUVMRChDQ1JfR1JFLCAy
NywgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX1ZWMSwgMjksIDEpCitERUZfUkVHX0ZJRUxEKENDUl9W
VjIsIDMwLCAxKQorREVGX1JFR19GSUVMRChDQ1JfVlYzLCAzMSwgMSkKLS0gCjIuMzQuMQoK

