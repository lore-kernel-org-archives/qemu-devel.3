Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878B7C282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFOJ-0004K0-Py; Sat, 01 Mar 2025 00:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOF-0003z7-J1
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOC-0008BY-MW
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:55 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214jQp6007534
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x3Hhsdu3ARt1Cpm7Zgmtm+GcTJbtOBJIiB0WlCtI3Q8=; b=L7U3z/+YikjtGw/J
 iiirZ+Boz/BfH05C5apZc36PYIJGmKyUFhw0W+XeDNji5Waj/Qt1YWvxOsd44Okf
 h2MWXO+aJbR8g7DdYaLuB3bbd3bgqJwlTGV0LFVh0fL0JSvqTkhlecWtHjezHDwj
 4yvjbT3JgscwKp0y+xuRA49x5qRd3pXe1lnOC4Rpxbo9Y75CGKUqhMHAEznJ87S4
 lGPJIIzGWeWaph4a5EnvbpujhQZ0OsbHEWubUQoUGKyT7cWr7PEzFZQWBdkwRDAv
 Mg4CqoVYp2ZsfoQ1flg+JevBtwTHR2xko/lH8rnaLL0GUBZdReWCNAYN20tuI5jq
 S6Nexw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t89r64n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2feb47c6757so3927713a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806847; x=1741411647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3Hhsdu3ARt1Cpm7Zgmtm+GcTJbtOBJIiB0WlCtI3Q8=;
 b=FT6//e5BEcwIM6iLNmZbyZl8nv5zJZw3dY/lIYWT+KHmA6nyipfv2xkuK9DtUOuGdr
 +u1LjelChO1RBsqTwJQSOvHGsSBxCh3mlAWuys1ncwC1kHRPG/LouKu/0LpYAhrjRfKo
 lNVie5hXCOk1xhsMKhD2ovDBc7VhR/50qrsoiHxoum+GoxKZ+9g+dfy+QYscB9IiSCAs
 Wlvo7aFg2we04fnY2YNsoUjti97KHdgqBm7Moq4seWRYfFcGGLSkHE7qY18N0TqaHtgM
 r/26PAAnk9PB8Sp37BweP0Wn3nNNeqbq4/EbgJmjtN1JiCn7g033Ma91yV0VsgZJk4Gb
 Q5wg==
X-Gm-Message-State: AOJu0Yxz442EBzaiD/Ap010MisL4avJaHjpnghO0VaPC+C1lwSSdkrJK
 ObQpbawsA7FyOMsdbFWZV9IUELi1zg4PEVqlr3yXH6pFwhT5ZcnE2HIEQJRcyZ6Y7p+ghlqDug2
 e3VpTbS1P9dm5vx9VQ+3w8Tn60MbxCEuXo0eFU8Iwrvqh3bKAThTZYEoBaBiARw==
X-Gm-Gg: ASbGncszV9BuDjzXqjHZO7JMntCH4I9Y0O7W+1pa2uYw1cnUF2yYH7m5S+8JlePHIc4
 CVAUTxNOOELjj5SP3IkrQ8mDZ4Bwscx4/69qzSVe2slPfwFA87YIwS0Dhus8lfc3CQzyjJU5ATh
 oax2jA4gV3iknBuvf3mmYTc333yrP0o88SrTrKCvKOnE5yRNHxH5DKF8ZJPLUgXDz7CMkuy7gvc
 hb06DMYuSVzqUd1MumuLWu2yjRO/13B+ZSC7RvbBNGRl2U3I+8C7MzEgggFAmzzqCOOT6QPQwYL
 SPjVZFeRJPDXrG/eIRT4Bp0rxiHmCPbv2rDY3aY/t1ca6eFcSQ3rbSfDBV+RU+ig
X-Received: by 2002:a17:90a:d448:b0:2fe:b907:3b05 with SMTP id
 98e67ed59e1d1-2febabda04amr9596133a91.29.1740806846616; 
 Fri, 28 Feb 2025 21:27:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcfzW9a1JSBbOFcyIKkefrl8MHrws0+TY+DMTgOKaMoLrnyoRubdXFjzbxEDEVlNvOAozyBA==
X-Received: by 2002:a17:90a:d448:b0:2fe:b907:3b05 with SMTP id
 98e67ed59e1d1-2febabda04amr9596102a91.29.1740806846245; 
 Fri, 28 Feb 2025 21:27:26 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:25 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 29/38] target/hexagon: Add locks, id, next_PC to state
Date: Fri, 28 Feb 2025 21:26:19 -0800
Message-Id: <20250301052628.1011210-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: SIPx1dpIKHfRcjynQIH2Rqx3I8M8jxZR
X-Proofpoint-GUID: SIPx1dpIKHfRcjynQIH2Rqx3I8M8jxZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010040
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
Y3B1LmggICAgIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogdGFy
Z2V0L2hleGFnb24vY3B1LmMgICAgIHwgIDYgKysrKysrCiB0YXJnZXQvaGV4YWdvbi9tYWNoaW5l
LmMgfCAgNCArKysrCiAzIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdv
bi9jcHUuaAppbmRleCBiNzc4OWEzYzkwLi5mYjY2MTUxYWM5IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNDAsMTAgKzQwLDM3
IEBACiAjZGVmaW5lIFBSRURfV1JJVEVTX01BWCA1ICAgICAgICAgICAgICAgICAgIC8qIDQgaW5z
bnMgKyBlbmRsb29wICovCiAjZGVmaW5lIFZTVE9SRVNfTUFYIDIKIAorI2lmbmRlZiBDT05GSUdf
VVNFUl9PTkxZCisjZGVmaW5lIENQVV9JTlRFUlJVUFRfU1dJICAgICAgQ1BVX0lOVEVSUlVQVF9U
R1RfSU5UXzAKKyNkZWZpbmUgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sgQ1BVX0lOVEVSUlVQVF9U
R1RfSU5UXzEKKyNkZWZpbmUgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLIENQVV9JTlRFUlJVUFRf
VEdUX0lOVF8yCisKKyNkZWZpbmUgSEVYX0NQVV9NT0RFX1VTRVIgICAgMQorI2RlZmluZSBIRVhf
Q1BVX01PREVfR1VFU1QgICAyCisjZGVmaW5lIEhFWF9DUFVfTU9ERV9NT05JVE9SIDMKKworI2Rl
ZmluZSBIRVhfRVhFX01PREVfT0ZGICAgICAxCisjZGVmaW5lIEhFWF9FWEVfTU9ERV9SVU4gICAg
IDIKKyNkZWZpbmUgSEVYX0VYRV9NT0RFX1dBSVQgICAgMworI2RlZmluZSBIRVhfRVhFX01PREVf
REVCVUcgICA0CisjZW5kaWYKKworI2RlZmluZSBNTVVfVVNFUl9JRFggICAgICAgICAwCisjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgTU1VX0dVRVNUX0lEWCAgICAgICAgMQorI2Rl
ZmluZSBNTVVfS0VSTkVMX0lEWCAgICAgICAyCisKK3R5cGVkZWYgZW51bSB7CisgICAgSEVYX0xP
Q0tfVU5MT0NLRUQgICAgICAgPSAwLAorICAgIEhFWF9MT0NLX1dBSVRJTkcgICAgICAgID0gMSwK
KyAgICBIRVhfTE9DS19PV05FUiAgICAgICAgICA9IDIsCisgICAgSEVYX0xPQ0tfUVVFVUVEICAg
ICAgICA9IDMKK30gaGV4X2xvY2tfc3RhdGVfdDsKKyNlbmRpZgorCisKICNkZWZpbmUgQ1BVX1JF
U09MVklOR19UWVBFIFRZUEVfSEVYQUdPTl9DUFUKIAotI2RlZmluZSBNTVVfVVNFUl9JRFggMAot
CiB0eXBlZGVmIHN0cnVjdCB7CiAgICAgdGFyZ2V0X3Vsb25nIHZhOwogICAgIHVpbnQ4X3Qgd2lk
dGg7CkBAIC04OSw2ICsxMTYsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgQ1BVQXJjaFN0YXRlIHsKICAg
ICB0YXJnZXRfdWxvbmcgKmdfc3JlZzsKIAogICAgIHRhcmdldF91bG9uZyBncmVnW05VTV9HUkVH
U107CisKKyAgICAvKiBUaGlzIGFsaWFzIG9mIENQVVN0YXRlLmNwdV9pbmRleCBpcyB1c2VkIGJ5
IGltcG9ydGVkIHNvdXJjZXM6ICovCisgICAgdGFyZ2V0X3Vsb25nIHRocmVhZElkOworICAgIGhl
eF9sb2NrX3N0YXRlX3QgdGxiX2xvY2tfc3RhdGU7CisgICAgaGV4X2xvY2tfc3RhdGVfdCBrMF9s
b2NrX3N0YXRlOworICAgIHRhcmdldF91bG9uZyBuZXh0X1BDOwogI2VuZGlmCiAgICAgdGFyZ2V0
X3Vsb25nIG5ld192YWx1ZV91c3I7CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
IGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggMmI2YTcwN2ZjYS4uOTA4MzM5YzA1MiAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMK
QEAgLTMwMyw2ICszMDMsMTIgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfcmVzZXRfaG9sZChP
YmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpCiAgICAgICAgIGFyY2hfc2V0X3N5c3RlbV9yZWco
ZW52LCBIRVhfU1JFR19NT0RFQ1RMLCAweDEpOwogICAgIH0KICAgICBhcmNoX3NldF9zeXN0ZW1f
cmVnKGVudiwgSEVYX1NSRUdfSFRJRCwgY3MtPmNwdV9pbmRleCk7CisgICAgbWVtc2V0KGVudi0+
dF9zcmVnLCAwLCBzaXplb2YodGFyZ2V0X3Vsb25nKSAqIE5VTV9TUkVHUyk7CisgICAgbWVtc2V0
KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHRhcmdldF91bG9uZykgKiBOVU1fR1JFR1MpOworICAgIGVu
di0+dGhyZWFkSWQgPSBjcy0+Y3B1X2luZGV4OworICAgIGVudi0+dGxiX2xvY2tfc3RhdGUgPSBI
RVhfTE9DS19VTkxPQ0tFRDsKKyAgICBlbnYtPmswX2xvY2tfc3RhdGUgPSBIRVhfTE9DS19VTkxP
Q0tFRDsKKyAgICBlbnYtPm5leHRfUEMgPSAwOwogI2VuZGlmCiB9CiAKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL21hY2hpbmUuYyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwppbmRleCBk
OWQ3MWVkZjc3Li5kYzkwMDQyMmY0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tYWNoaW5l
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCkBAIC0xOSw2ICsxOSwxMCBAQCBjb25z
dCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9IHsKICAgICAgICAgVk1T
VEFURV9VSU5UVExfQVJSQVkoZW52LnByZWQsIEhleGFnb25DUFUsIE5VTV9QUkVHUyksCiAgICAg
ICAgIFZNU1RBVEVfVUlOVFRMX0FSUkFZKGVudi50X3NyZWcsIEhleGFnb25DUFUsIE5VTV9TUkVH
UyksCiAgICAgICAgIFZNU1RBVEVfVUlOVFRMX0FSUkFZKGVudi5ncmVnLCBIZXhhZ29uQ1BVLCBO
VU1fR1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlRUTChlbnYubmV4dF9QQywgSGV4YWdvbkNQ
VSksCisgICAgICAgIFZNU1RBVEVfVUlOVFRMKGVudi50bGJfbG9ja19zdGF0ZSwgSGV4YWdvbkNQ
VSksCisgICAgICAgIFZNU1RBVEVfVUlOVFRMKGVudi5rMF9sb2NrX3N0YXRlLCBIZXhhZ29uQ1BV
KSwKKyAgICAgICAgVk1TVEFURV9VSU5UVEwoZW52LnRocmVhZElkLCBIZXhhZ29uQ1BVKSwKICAg
ICAgICAgVk1TVEFURV9FTkRfT0ZfTElTVCgpCiAgICAgfSwKIH07Ci0tIAoyLjM0LjEKCg==

