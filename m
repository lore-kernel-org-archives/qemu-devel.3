Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DDC282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNU-0002uj-GI; Sat, 01 Mar 2025 00:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNS-0002u5-8q
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNQ-00087b-P3
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:06 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213LK0q029173
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ahHIV6BCVwDBuw3XkaPs46Y4JOBTvn8AwBXLM/Zq4fw=; b=VnyEzRweDjdKyQVs
 A70nZ51aZoxxLjhNde+L2+QTv7cwP0Ub+ukXkqHYCpncMAvwHdKvr5UqX147l3oZ
 SYTBFT/Q7MM7ojqSoplVp5+mRBEKSdWxY7U/NpnWGjWmvWgOYQgE33sqapNUVskX
 hBOM+JwQygsDSCrZu9VnbLd1gjAO9isW99XNriSfnw5J4gWZw/Gvjt+TmKyT93aC
 vmxrEOBHV2M6IXpfdVOwi+7S/s1XUTJ2s/CTYNCUQADhqqBoRPaLBeGfXi62AsZr
 OeQITtbZ9plfka9ensPmhMYwWOEeJQdN49A0qR8TxJPWRpXCQHzJy/GzMLjKOf8e
 ZIdD4w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t89r637-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fee4c7ef4dso22546a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806822; x=1741411622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahHIV6BCVwDBuw3XkaPs46Y4JOBTvn8AwBXLM/Zq4fw=;
 b=TtTxZaXFVsQe/nVNTg2cXklY+pIUMGxLfP5mH6O9hsRmDK0Q1OOzN0ftZvQGv3gHje
 X7syvgCx5hLH0qnHJlz9MDbwxG9HSeoB9HWtPYjbg9aGgv1xTMVPijh1eM5TQj1l80FX
 xdZt5F10JfU2I1WuO5ppx4mHDtx/VbVLhfupsiftrBivNZsRgCVXormTaoVa5Js03SJD
 lFU/M9WlzrNyYfWgkOwQxRA67y3Q+VqFu10snyIOXxtR28/kZa6oJyZVLL43AoTg4WvB
 PXM7lHCOdfq6kCZmA8f1Jt+KT18NH3SB2k6ckua44BYv2Tk+LYMV3O36IJfvW1oY1FvG
 QdtA==
X-Gm-Message-State: AOJu0YzL8/wAN/5bnQrL+OlmuR9TsVtAlNcup5rKZP/TfPRR2J5XgPjo
 X8aKJUHdUjjRcFYu7qPFWGNYfVtETaF9e1qip2HAXEdD7JVD1sECu/5NoFdyJSDJVPN8feRNnVk
 ipKiAbbLBFYt0VAcLhVphhH1ycoctcxXmPw45q9Vy7WuzBa2Eg6K9Ax4AQ3ciMg==
X-Gm-Gg: ASbGncvvgwdaK0rs0u9+A/QjilK/FiY8I4jJbHKJtzR16RCuxnUNcCORsJkkUlGrI8+
 ltFC5cQERRxY/4PfZjW1eJ9Plx2NCUNNEWxZTpZzvYconaWmfqD1tJF0LJpvXsM/GNYMhDj6zTt
 1OcYSMK0Bz8soe643aErnN+hPAgiuYPPlNAhpZo1YytMKuRw2FNP3ZJtZ4zsvdujsxAgZxLKs0Z
 bPKtMb9YK9BRmlf3UCObvvMPjClO8tNUaWB05Pw1qI95/O1kaSrsQF0GKAHD3L9zw0i+0Y832jI
 he9r8zeitzHBmN0ZVsotIyAYtut+90sK5BG+6jqzXMUwaqfR4WOinuOIB5ui3pV1
X-Received: by 2002:a17:90b:3c88:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2febab2ecd6mr10866212a91.7.1740806822351; 
 Fri, 28 Feb 2025 21:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd5pCQhVLzSbywtIB/TaqQYdT54MxjULCFy1TM9GJaEGqDT4ad3laDCgYmMAhkHQ49Eu34UA==
X-Received: by 2002:a17:90b:3c88:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2febab2ecd6mr10866180a91.7.1740806821962; 
 Fri, 28 Feb 2025 21:27:01 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:01 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 11/38] target/hexagon: Add guest/sys reg writes to DisasContext
Date: Fri, 28 Feb 2025 21:26:01 -0800
Message-Id: <20250301052628.1011210-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: O-SRAhQ_zrApoo6qPNloJuX7PxSq8gRi
X-Proofpoint-GUID: O-SRAhQ_zrApoo6qPNloJuX7PxSq8gRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=844
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBmNjExYzg1
NGRjLi4wZWFhM2RiMDNlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtMzksNiArMzksMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBpbnQgcmVnX2xvZ19pZHg7CiAgICAgREVDTEFS
RV9CSVRNQVAocmVnc193cml0dGVuLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIERFQ0xB
UkVfQklUTUFQKHByZWRpY2F0ZWRfcmVncywgVE9UQUxfUEVSX1RIUkVBRF9SRUdTKTsKKyNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGludCBncmVnX2xvZ1tHUkVHX1dSSVRFU19NQVhdOwor
ICAgIGludCBncmVnX2xvZ19pZHg7CisgICAgaW50IHNyZWdfbG9nW1NSRUdfV1JJVEVTX01BWF07
CisgICAgaW50IHNyZWdfbG9nX2lkeDsKKyAgICBUQ0d2IHRfc3JlZ19uZXdfdmFsdWVbTlVNX1NS
RUdTXTsKKyAgICBUQ0d2IGdyZWdfbmV3X3ZhbHVlW05VTV9HUkVHU107CisjZW5kaWYKICAgICBp
bnQgcHJlZ19sb2dbUFJFRF9XUklURVNfTUFYXTsKICAgICBpbnQgcHJlZ19sb2dfaWR4OwogICAg
IERFQ0xBUkVfQklUTUFQKHByZWdzX3dyaXR0ZW4sIE5VTV9QUkVHUyk7CkBAIC03OSw2ICs4Nywz
NCBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogCiBib29sIGlzX2dhdGhlcl9zdG9y
ZV9pbnNuKERpc2FzQ29udGV4dCAqY3R4KTsKIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitz
dGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19ncmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBp
bnQgcm51bSkKK3sKKyAgICBpZiAocm51bSA8PSBIRVhfR1JFR19HMykgeworICAgICAgICBjdHgt
PmdyZWdfbG9nW2N0eC0+Z3JlZ19sb2dfaWR4XSA9IHJudW07CisgICAgICAgIGN0eC0+Z3JlZ19s
b2dfaWR4Kys7CisgICAgfQorfQorCitzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19ncmVnX3dy
aXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBybnVtKQoreworICAgIGN0eF9sb2dfZ3Jl
Z193cml0ZShjdHgsIHJudW0pOworICAgIGN0eF9sb2dfZ3JlZ193cml0ZShjdHgsIHJudW0gKyAx
KTsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfc3JlZ193cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHJudW0pCit7CisgICAgY3R4LT5zcmVnX2xvZ1tjdHgtPnNyZWdfbG9nX2lk
eF0gPSBybnVtOworICAgIGN0eC0+c3JlZ19sb2dfaWR4Kys7Cit9CisKK3N0YXRpYyBpbmxpbmUg
dm9pZCBjdHhfbG9nX3NyZWdfd3JpdGVfcGFpcihEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0p
Cit7CisgICAgY3R4X2xvZ19zcmVnX3dyaXRlKGN0eCwgcm51bSk7CisgICAgY3R4X2xvZ19zcmVn
X3dyaXRlKGN0eCwgcm51bSArIDEpOworfQorI2VuZGlmCisKIHN0YXRpYyBpbmxpbmUgdm9pZCBj
dHhfbG9nX3ByZWRfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBwbnVtKQogewogICAgIGlm
ICghdGVzdF9iaXQocG51bSwgY3R4LT5wcmVnc193cml0dGVuKSkgewotLSAKMi4zNC4xCgo=

