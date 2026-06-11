Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A2CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXz0-0007jB-P7; Thu, 11 Jun 2026 01:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyu-0007ha-0y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyq-0000pv-Hc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:31 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GSk73835182
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=; b=UgwztdH87/7MnzeX
 OiSwLnZ3x4NoJYijaf389s8FkZwgd/c60z165YfsbVqVHoajpPHlHD+2jK+yDshl
 MPSCqdo07f96fAbKr/3Q4ZpMsFxK304x0oV5naWTTTtVnG3UuhjvUy+afyZMl/YC
 ZLUCuuDmqiDfuwymlWbmMG56AoYMufwLWUFGh3n+C8q16/srwNRNEe+S1iQ+Mt6k
 7RmUx3EUMekpZpzBy0zqA1dv67PUTVadqkEnuzmGBwNoOh/zk7he1em3im5OD+oY
 BaQlIHb2UWUIpOaHErIR7/C4Z4kbyxO8fpnNl06wZ2bjNgXjvtxqs5oBbOiOgHiu
 WtrOIA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ths68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30761ab3483so6222322eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155766; x=1781760566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=QyxyzuCBn5S3dWurvG9Yjx0U3Gde+bTij+3vFObqbdGVDO0afz3LUp8fkkDdAa71Ft
 N/+I0QWPCg2blx8M1lgoi2J6Hg5St6CfnFtIGRq9lW5Q0+g92trS096daUcaXWK56rlR
 oTXS4zezYLWuSZ9syuVbk5Zm9BKMT3tuL71uXdt1ZbHjZHX3gAZGTC6ahO9lIJ6IpVUp
 c05moflyGH+Qtsb3yurvkvv6KxY8WpyJxLeH07+ISxMCwou5ynzP7f0IexnvYm9jE9pW
 e+oXCCuKGkje65CMm+7yO/jBP97MSG/TzezPLlGSmJLeiNQrGHAH4wuapmejIMjqSOET
 fQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155766; x=1781760566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=Sm1ns6jMNh2LJRRnnAiwXwhCuHPMHw1Z841meSEvBthSSiooFSeJjmSFajezqjIG8p
 dznKCVlUT+CImJejSfZUvEqSLoBi8fAWTfuML+8v+svl7kAL1b/iJ0Hp1pK92c/P4R1Z
 tqEmxVJEUJIo4YC1a/mD0KXCU4b5jb2gCmplf0CQiKG3x4UV21QDmjQbGMrUOuKl4wye
 cIU6fMHTQY7yHJOW4uQj6YIH7N7ExTqhVc1XsxgSkBJHuMsGnQ+QrEASbR7dfAhZ+G47
 DoGew69Ts+WoomqC/pMzFCRluiJEvqUJZPadaSUFpP2F+EqocjFqnnjoJlk5IFDvNo4J
 ZQSg==
X-Gm-Message-State: AOJu0Ywfn+K8ba8WLE3ByTpw84E7O4UsG31+4Jp5aQUknau5oiE7rgFb
 IGTxK51rQWOsdEhPScYxIXNd0dNS+/TUGwIm68RC5HSGtlUio0pqOQAjxb0kRxKVPldgk4ZrGwB
 E03aNpqWYSZ8dbD9u2c4sd9eCVRrRrs6X+LRic4FGmAZKAtlsO/Dqa+iircP/hqULqA==
X-Gm-Gg: Acq92OHZ+GdZKKnI9u/hgpV8Rkpf3DYD3asIrfzlkJ7+1RDoH6yf1GSrdS0Otey7MXb
 qp9cqqtV2ujIs6lnMjzqP1e5IetbVtndkYfdmp9z7LfcpZDfqNhMG7bLySSavReFOdtBABtHf+G
 na1sQt4Nmx6fjXm7kCe11+V6EI6+TxgsPEaUEVJDi1FqHpqHerW+Td1J2Zm4V9ejEoOGrPWm+dz
 M+NBQC5NTnQ4YLhmMfBo3ZPKvVbZWlJ15qsKPP8B2AiDJJ6v+xJlCR/cKDILli114ViT9C7WUlg
 57bJlCLD5dfnLDpzP9hZgCVUZNIypoEF6b+SObPWLt/cgL7XL+pVZUs54+oQfuoFbwXnQ6fHrg1
 JgTD7iOJlvTxVcQBXJN9qUY+KiUHaQ32lY6kubOwm4O9PKMMUgVZwU6tAThPj+pFL3jCfpMmcUZ
 6eQiq7
X-Received: by 2002:a05:7300:5713:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-308047f2728mr1098104eec.9.1781155765897; 
 Wed, 10 Jun 2026 22:29:25 -0700 (PDT)
X-Received: by 2002:a05:7300:5713:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-308047f2728mr1098081eec.9.1781155765466; 
 Wed, 10 Jun 2026 22:29:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add guest/sys reg writes to DisasContext
Date: Wed, 10 Jun 2026 22:28:34 -0700
Message-Id: <20260611052857.3911981-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX9xECwzHCCE5T
 /AhRvtd05xqpMjfyTuwyL1ihfvoaqfBD+pHcdZ1a7pzQ/phPB95zesAxRytBEmEJTok4GvnhvtC
 PytMySsLHDQ1h8aIkiKyk2S9RpgiTQqbOlBoFjelnp/BsSqhM4KnCvBu3/48QPy0zc1+QmhuZrT
 jNqC/qPtPWzXRsMFfEXsX4lX9LsEbmLHDot3nMx1F7AYxg734hOsIoEnUs1jrJvDyZ3ZMATtFg1
 YfYdpyLwnS2AAZorv6mfzsGI+FVeXJMJKsg1g8EhjmZ4ukVAdD7mXuFa95AD5DfQ0OSkyU21VOx
 /+H3yw1ZUvIMUdu3NKy/QQ5s21rIvx9npCUtG/wkSZe4imAZNv1FcBlDe6on+dULTIwWEQVA76R
 5nUgU55l4bmzYFBa391+lJBGaXfU+JY4wamV6jRzRTUfdAcSvyBWvPHdlF3youKshl1DF2f3WyP
 FMsFkECmEGTDvI5r1Lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX3w3u7rpIyqRY
 EGz5lgPlyhrPzAFH/D/U/9n6a4dGOtcEMv0eW4Ms1z02edu3dNG0N+Wn+GfNmueoMKTzfO8CG1W
 0OYNqcwr1pXDNbMBJtkTErba25sPE6U=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a47b6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NHRSwdWwPX1htiK6Vbht0Ie-ZOcbW8yG
X-Proofpoint-GUID: NHRSwdWwPX1htiK6Vbht0Ie-ZOcbW8yG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggZDhlZWE1NjE5
MWQuLjU3NzY3YWNmMDAyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDEsNiArNDEsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4s
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9y
ZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRl
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaW50IGdyZWdfbG9nW0dSRUdfV1JJVEVT
X01BWF07CisgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklU
RVNfTUFYXTsKKyAgICBpbnQgc3JlZ19sb2dfaWR4OworICAgIFRDR3ZfaTMyIHRfc3JlZ19uZXdf
dmFsdWVbTlVNX1NSRUdTXTsKKyAgICBUQ0d2X2kzMiBncmVnX25ld192YWx1ZVtOVU1fR1JFR1Nd
OworI2VuZGlmCiAgICAgaW50IHByZWdfbG9nW1BSRURfV1JJVEVTX01BWF07CiAgICAgaW50IHBy
ZWdfbG9nX2lkeDsKICAgICBERUNMQVJFX0JJVE1BUChwcmVnc193cml0dGVuLCBOVU1fUFJFR1Mp
OwpAQCAtODEsNiArODksMzQgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKIAogYm9v
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

