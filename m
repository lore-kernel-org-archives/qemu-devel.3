Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69215C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPG-0007sS-JP; Sat, 01 Mar 2025 00:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPE-0007mj-2e
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:28:56 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPC-0008Lv-3a
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:28:55 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Yl0K030346
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=/VDPdjihxfsv3fo+p2wMagsyK5muYv1fGLIlWipDUm0=; b=He
 tG6mB2q1hOLve+k68yewBmpAR85xHe/9LdyuWS2OL5heEs7Ylq2LDADbiStzPmzT
 NyONF90WE19OGo0QNUpxz+Ie7ZCV2CzyY5A7Xy3BBVt8gazwQ58l5J5KoqKzCP2h
 wLexrGKbuQxxXRq7MrqeeirruXXz+3EuZiij4F5Bt76B7t3XfAnu5sLYPWG403YE
 xdvrsSAJ+v09iU++4xyz9PotdcJRUdFlU/K04SxIVH7K5nv3V7GnaTUeagALZvS2
 wQt1z7L5ZZ+8I1t8DKDjsLJ7fNGm2LCTFFQuCuEv2vki29TZyv3sfUIMthJtQVo4
 Zwk5QwObIvTT0feyZv1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tf0g5c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:28:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2feb5cd04a0so3858865a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806932; x=1741411732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VDPdjihxfsv3fo+p2wMagsyK5muYv1fGLIlWipDUm0=;
 b=VDbqp4G53SvIiFnbBc8Y6lNb0sZcrSDMvg/R7BBlYBGwYntdvmNX8COcJekRyV6TzS
 SqCu+dyzc9CbW7HI+O/MWnI2DpFDfIwR1m4PA3FzWUVIf3zkoKcxEgL+AcuaqRHj2whP
 Nulck1v3XNszPClFG5S4jx4Mc8rCZJDUivYlofuZLTJuT2VwZjHJBhftb+joqsaGay7P
 qINFW1ylpSryZc88oKyk5Pd0lWwq22VeRa+FHQJbr/uhEly8UCDhxQKTs62bPozcf1nH
 vD49A5KgdfPjBysyPrli232aa3zeQkcXNTYkFQtv3vmKKRqYROl0NdQU2JBxg/TSNg0k
 gLGQ==
X-Gm-Message-State: AOJu0YxfzFFeyAZCv9WitZtG0C4pNUS0KKPbXK+9KoWfNLGsz1ZKECEw
 cwCaedshVUD/f1doADjbfVyZvrnfkYxV+m3XyrtFVbHvgWjpomxf1xpV3ZIoe/sD4maFTRmWZ7b
 hl1ZLwUQVJZcpIuWEDjdMhX2/X2IUBbayA1O8f/FX2Yd0uPQR+6EooKfsdOnmbw==
X-Gm-Gg: ASbGncuSYskbOFID7sWGB1EKj3WNDl/QR0URVUr3BbiV4VL4XTmGI9f+ROWqOoB12xO
 Vs/MUApL/EUmj7wrM8fA6PjlBWiI55Ixsxe8z1NCV8uIH+TT3YtBS1A91nox38JbERj0iHYifAl
 Mp/lZttkm+788Pd7UsaMMhSP780vXXbLTMSU/l3pzuRAf9MKhF6CFcipPNqbMMLWPHQYr/AD9kQ
 iMJKarziEWz4V0xwMh/zhoE4hnoCWh1EQ/Xzx4tgD2H577ac8Zz3hTwoH8ka9/KFH7li3XIgNP2
 9dnw5M8uqGGca2RUdvfNOXHd4eYwLRu0yUPcFU1PkSYconNfMN5xaxPwJoYL2wNh
X-Received: by 2002:a17:90a:d446:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-2febab2e610mr9096330a91.3.1740806931825; 
 Fri, 28 Feb 2025 21:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXErzSCDTbH9da1o5muzHOm1Aa6rzxQlgyxy1a/91Ga3vm+1GoZmYuhk9o0kgkItfHSXH4XQ==
X-Received: by 2002:a17:90a:d446:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-2febab2e610mr9096304a91.3.1740806931457; 
 Fri, 28 Feb 2025 21:28:51 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:28:51 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 01/39] target/hexagon: Implement ciad helper
Date: Fri, 28 Feb 2025 21:28:07 -0800
Message-Id: <20250301052845.1012069-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: wL8W2aFsZrMTAMyH41w9XS42X5Jz5wP8
X-Proofpoint-ORIG-GUID: wL8W2aFsZrMTAMyH41w9XS42X5Jz5wP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=608
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpjaWFkIGlzIHRoZSBjbGVhciBp
bnRlcnJ1cHQgYXV0byBkaXNhYmxlIGluc3RydWN0aW9uLgoKVGhpcyBpbnN0cnVjdGlvbiBpcyBk
ZWZpbmVkIGluIHRoZSBRdWFsY29tbSBIZXhhZ29uIFY3MSBQcm9ncmFtbWVyJ3MgUmVmZXJlbmNl
Ck1hbnVhbCAtCmh0dHBzOi8vZG9jcy5xdWFsY29tbS5jb20vYnVuZGxlL3B1YmxpY3Jlc291cmNl
LzgwLU4yMDQwLTUxX1JFVl9BQl9IZXhhZ29uX1Y3MV9Qcm9ncmFtbWVyU19SZWZlcmVuY2VfTWFu
dWFsLnBkZgpTZWUgwqcxMS45LjIgU1lTVEVNIE1PTklUT1IuCgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYwppbmRleCBmZDljYWFmZWZjLi5iMjhhMThhZGY2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMzQs
NiArMzQsMTEgQEAKICNpbmNsdWRlICJvcF9oZWxwZXIuaCIKICNpbmNsdWRlICJjcHVfaGVscGVy
LmgiCiAjaW5jbHVkZSAidHJhbnNsYXRlLmgiCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyNp
bmNsdWRlICJoZXhfbW11LmgiCisjaW5jbHVkZSAiaHcvaW50Yy9sMnZpYy5oIgorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCisjZW5kaWYKIAogI2RlZmluZSBTRl9CSUFTICAgICAgICAxMjcK
ICNkZWZpbmUgU0ZfTUFOVEJJVFMgICAgMjMKQEAgLTEzMzgsOSArMTM0MywzNiBAQCB2b2lkIEhF
TFBFUih2d2hpc3QxMjhxbSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIGludDMyX3QgdWlWKQogfQog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIGhleGFnb25fc2V0X3ZpZChD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgb2Zmc2V0LCBpbnQgdmFsKQoreworICAgIGdf
YXNzZXJ0KChvZmZzZXQgPT0gTDJWSUNfVklEXzApIHx8IChvZmZzZXQgPT0gTDJWSUNfVklEXzEp
KTsKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgSGV4YWdvbkNQVSAqY3B1
ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIGNvbnN0IGh3YWRkciBwZW5kX21lbSA9IGNwdS0+bDJ2
aWNfYmFzZV9hZGRyICsgb2Zmc2V0OworICAgIGNwdV9waHlzaWNhbF9tZW1vcnlfd3JpdGUocGVu
ZF9tZW0sICZ2YWwsIHNpemVvZih2YWwpKTsKK30KKworc3RhdGljIHZvaWQgaGV4YWdvbl9jbGVh
cl9sYXN0X2lycShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgb2Zmc2V0KQoreworICAg
IC8qCisgICAgICogY3VycmVudGx5IG9ubHkgbDJ2aWMgaXMgdGhlIG9ubHkgYXR0YWNoZWQgaXQg
dXNlcyB2aWQwLCByZW1vdmUKKyAgICAgKiB0aGUgYXNzZXJ0IGJlbG93IGlmIGFudGhlciBpcyBh
ZGRlZAorICAgICAqLworICAgIGhleGFnb25fc2V0X3ZpZChlbnYsIG9mZnNldCwgTDJWSUNfQ0lB
RF9JTlNUUlVDVElPTik7Cit9CisKIHZvaWQgSEVMUEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAg
dWludDMyX3QgaXBlbmRhZDsKKyAgICB1aW50MzJfdCBpYWQ7CisKKyAgICBCUUxfTE9DS19HVUFS
RCgpOworICAgIGlwZW5kYWQgPSBSRUFEX1NSRUcoSEVYX1NSRUdfSVBFTkRBRCk7CisgICAgaWFk
ID0gZkdFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCk7CisgICAgZlNFVF9GSUVMRChpcGVu
ZGFkLCBJUEVOREFEX0lBRCwgaWFkICYgfihtYXNrKSk7CisgICAgYXJjaF9zZXRfc3lzdGVtX3Jl
ZyhlbnYsIEhFWF9TUkVHX0lQRU5EQUQsIGlwZW5kYWQpOworICAgIGhleGFnb25fY2xlYXJfbGFz
dF9pcnEoZW52LCBMMlZJQ19WSURfMCk7CisgICAgaGV4X2ludGVycnVwdF91cGRhdGUoZW52KTsK
IH0KIAogdm9pZCBIRUxQRVIoc2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1h
c2spCkBAIC0xNDE2LDExICsxNDQ4LDYgQEAgc3RhdGljIHZvaWQgbW9kaWZ5X3N5c2NmZyhDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdmFsKQogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVk
KCk7CiB9CiAKLXN0YXRpYyB2b2lkIGhleGFnb25fc2V0X3ZpZChDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdWludDMyX3Qgb2Zmc2V0LCBpbnQgdmFsKQotewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVk
KCk7Ci19Ci0KIHN0YXRpYyB1aW50MzJfdCBoZXhhZ29uX2ZpbmRfbGFzdF9pcnEoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IHZpZCkKIHsKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OwotLSAKMi4zNC4xCgo=

