Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE46C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPx-0002F3-F8; Sat, 01 Mar 2025 00:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPl-00013S-1I
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:29 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPh-0008PX-Du
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:28 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214o36a023030
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cro+9dSEynAsUdlc2d1xxFC9RibUn7LDydh+snlHwEU=; b=pc71sBrXnxhqMJpD
 VRjYrXUcBVNLHg+szKiaHUoLjVC7XmbED1CuLWme1TqPB8a9vM5GJqkyBQq6i1zA
 rP4JLrOHAAof4fb0BzxKZFgNfCGkGd42m5R6sJoNC8WkaSh5chTQImYpTNZVgtUI
 b3uQ4xaGV1TOBNie6UJBBRgZwswsi9cCm9w+/IgwVPFVtn3uOom1K7hHl7eI4AOl
 LUCBvfMdbVoMWI3lA0/qF0amDJawCUBsnQJ/FAtlyRm/c5PgglQuLOmHlLhPx8MO
 zZxnDXGi3jaSS0RydH2VbTqwU1SnDB9hrxw0ri+qJsTfEPxmGCkfdbetJHZqnjJJ
 gcFdkA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh701xx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fec3e38c2dso3566442a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806953; x=1741411753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cro+9dSEynAsUdlc2d1xxFC9RibUn7LDydh+snlHwEU=;
 b=PZbaPHlGX9ic+3sAClrK0Cgk2FceT3lB84VnDvSn8YwKfAiOjuuOLvbYbqx1KHT9as
 yWYtFxaHoW6ZMzBfniZVD04ZY6UgjqOMhzVr/4ea2ESnKimGcWpq2YLDmOXvujBWxtVu
 uCHSm0Q9I2d4Cj5+e0ziX0Zegax+PsEwz42i03dySNik93wUdmdqArZpxoBGklZ5UnHf
 29URCf4J7Ap0dv/Z3MHFuDWRzgQjBLypkZGuOWZ1jySyUnTb08mmWpsJzJPvRwDgrbor
 nIPB86C3/ORmFZ9jLWh0rPA5U+8S1eNuB7whAFRQZL+X4mB7GPpwL7t3iyCImWsMkBNV
 xtQg==
X-Gm-Message-State: AOJu0YymmbGk8rCqw0DCot5Ht6kYh/n5SZ6QI6qMykRqDY5VjBy3lNB7
 98YY/W5/DIpKjcYYjkHtRZCQBbpoxUA++Mw599rvXiy2UNFt5oObfeA3WwHB9LgCPiW1cj0rcvU
 n1jMp47oOv+lOJppQ5iN0iJ8iCgHseyO3y8Azq1KIWEn/UO7b9BpbAJQcNwkgKg==
X-Gm-Gg: ASbGnctbm9J3ZNYIJsfAUk5bgevH5jQBQXjRCc8WxxpvdfQIM5IxjWz3qPqxMyMkdR4
 5HZExi7IdhV2jBizQ6v4v2gTDpeXw5GvAdPrtSf0IDh/XTTdhdKQYoT+2ZVA6yBup9B5FGOWNgn
 PM+EG4lkfSZHJUV+w4oZscekDvvdp/8+k1iZsX50fdnhbmSeIx9fM+9LFvJZoY8RpZxEPzMfhvn
 c8pSGi2lnJJKDPXWAGrrPUHWuXP/TQVLS/lJF3fKTt9BQ1R7kQMMm9eKsp0hWB/j7VKXXnRbZQG
 Twqi0VCq9dkOsT4YwzO+T7MVmdit3Q3epLr3KK1p1e93Qj/PGKaSjdsMyzdnUtcw
X-Received: by 2002:a17:90b:4c11:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-2febab2eed3mr9322542a91.1.1740806953079; 
 Fri, 28 Feb 2025 21:29:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeXbLV6sIZSMrvpiaStPg77h1Wefhvrh/Vnvz6lEyY90/Pziy7XdXXlS5GzckNJtlh3S7TwQ==
X-Received: by 2002:a17:90b:4c11:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-2febab2eed3mr9322516a91.1.1740806952707; 
 Fri, 28 Feb 2025 21:29:12 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:12 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 18/39] target/hexagon: Implement exec_interrupt, set_irq
Date: Fri, 28 Feb 2025 21:28:24 -0800
Message-Id: <20250301052845.1012069-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: v8IhRoPzkKyXxSbjeCqQ1tB2teQDxivj
X-Proofpoint-ORIG-GUID: v8IhRoPzkKyXxSbjeCqQ1tB2teQDxivj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=934 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmggfCAgNSArKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgNzMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmgKaW5kZXggMDQ1NTgxZDdiZS4uZDI4YzEyNDlmMyAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTIwNyw2ICsyMDcs
MTEgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhh
Z29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludHB0cl90IHBjKTsKIAogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisvKgorICogQHJl
dHVybiB0cnVlIGlmIHRoZSBAYSB0aHJlYWRfZW52IGhhcmR3YXJlIHRocmVhZCBpcworICogbm90
IHN0b3BwZWQuCisgKi8KK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChDUFVIZXhhZ29u
U3RhdGUgKnRocmVhZF9lbnYpOwogdWludDMyX3QgaGV4YWdvbl9ncmVnX3JlYWQoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IHJlZyk7CiB1aW50MzJfdCBoZXhhZ29uX3NyZWdfcmVhZChD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKTsKIHZvaWQgaGV4YWdvbl9nZGJfc3Jl
Z193cml0ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwp
OwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUu
YwppbmRleCA4NDNiZTgyMjFmLi5lOWYyNDU4MWE2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMzEsNiArMzEsNyBAQAogI2lu
Y2x1ZGUgImhleF9tbXUuaCIKIAogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisjaW5jbHVkZSAi
bWFjcm9zLmgiCiAjaW5jbHVkZSAic3lzX21hY3Jvcy5oIgogI2luY2x1ZGUgInFlbXUvbWFpbi1s
b29wLmgiCiAjaW5jbHVkZSAiaGV4X2ludGVycnVwdHMuaCIKQEAgLTI3OCw5ICsyNzksMjggQEAg
c3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfc3luY2hyb25pemVfZnJvbV90YihDUFVTdGF0ZSAqY3Ms
CiAgICAgY3B1X2VudihjcyktPmdwcltIRVhfUkVHX1BDXSA9IHRiLT5wYzsKIH0KIAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCitib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4
YWdvblN0YXRlICplbnYpCit7CisgICAgdGFyZ2V0X3Vsb25nIG1vZGVjdGwgPSBhcmNoX2dldF9z
eXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdfTU9ERUNUTCk7CisgICAgdWludDMyX3QgdGhyZWFkX2Vu
YWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVjdGwpOworICAgIGJvb2wgRV9i
aXQgPSB0aHJlYWRfZW5hYmxlZF9tYXNrICYgKDB4MSA8PCBlbnYtPnRocmVhZElkKTsKKworICAg
IHJldHVybiBFX2JpdDsKK30KKyNlbmRpZgorCiBzdGF0aWMgYm9vbCBoZXhhZ29uX2NwdV9oYXNf
d29yayhDUFVTdGF0ZSAqY3MpCiB7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBDUFVI
ZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisgICAgcmV0dXJuIGhleGFnb25fdGhy
ZWFkX2lzX2VuYWJsZWQoZW52KSAmJgorICAgICAgICAoY3MtPmludGVycnVwdF9yZXF1ZXN0ICYg
KENQVV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJCisgICAgICAgICAgICB8IENQ
VV9JTlRFUlJVUFRfSzBfVU5MT0NLIHwgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKSk7CisjZWxz
ZQogICAgIHJldHVybiB0cnVlOworI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lkIGhleGFnb25fcmVz
dG9yZV9zdGF0ZV90b19vcGMoQ1BVU3RhdGUgKmNzLApAQCAtNDExLDE5ICs0MzEsNzIgQEAgc3Rh
dGljIHZvaWQgaGV4YWdvbl9jcHVfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVy
cnApCiAgICAgbWNjLT5wYXJlbnRfcmVhbGl6ZShkZXYsIGVycnApOwogfQogCisjaWYgIWRlZmlu
ZWQoQ09ORklHX1VTRVJfT05MWSkKK3N0YXRpYyB2b2lkIGhleGFnb25fY3B1X3NldF9pcnEodm9p
ZCAqb3BhcXVlLCBpbnQgaXJxLCBpbnQgbGV2ZWwpCit7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0g
SEVYQUdPTl9DUFUob3BhcXVlKTsKKyAgICBDUFVTdGF0ZSAqY3MgPSBDUFUoY3B1KTsKKyAgICBD
UFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisgICAgc3dpdGNoIChpcnEpIHsK
KyAgICBjYXNlIEhFWEFHT05fQ1BVX0lSUV8wIC4uLiBIRVhBR09OX0NQVV9JUlFfNzoKKyAgICAg
ICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiBpcnEgJWQsIGxldmVsICVkXG4iLAor
ICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpcnEsIGxldmVsKTsKKyAgICAgICAgaWYg
KGxldmVsKSB7CisgICAgICAgICAgICBoZXhfcmFpc2VfaW50ZXJydXB0cyhlbnYsIDEgPDwgaXJx
LCBDUFVfSU5URVJSVVBUX0hBUkQpOworICAgICAgICB9CisgICAgICAgIGJyZWFrOworICAgIGRl
ZmF1bHQ6CisgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgfQorfQorI2VuZGlm
CisKKwogc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfaW5pdChPYmplY3QgKm9iaikKIHsKKyNpZiAh
ZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05f
Q1BVKG9iaik7CisgICAgcWRldl9pbml0X2dwaW9faW4oREVWSUNFKGNwdSksIGhleGFnb25fY3B1
X3NldF9pcnEsIDgpOworI2VuZGlmCiB9CiAKICNpbmNsdWRlICJody9jb3JlL3RjZy1jcHUtb3Bz
LmgiCiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorCitzdGF0aWMgYm9vbCBoZXhhZ29uX2Nw
dV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1cHRfcmVxdWVzdCkKK3sK
KyAgICBDUFVIZXhhZ29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworICAgIGlmIChpbnRlcnJ1
cHRfcmVxdWVzdCAmIENQVV9JTlRFUlJVUFRfVExCX1VOTE9DSykgeworICAgICAgICBjcy0+aGFs
dGVkID0gZmFsc2U7CisgICAgICAgIGNwdV9yZXNldF9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJV
UFRfVExCX1VOTE9DSyk7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICBpZiAoaW50
ZXJydXB0X3JlcXVlc3QgJiBDUFVfSU5URVJSVVBUX0swX1VOTE9DSykgeworICAgICAgICBjcy0+
aGFsdGVkID0gZmFsc2U7CisgICAgICAgIGNwdV9yZXNldF9pbnRlcnJ1cHQoY3MsIENQVV9JTlRF
UlJVUFRfSzBfVU5MT0NLKTsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAgIGlmIChp
bnRlcnJ1cHRfcmVxdWVzdCAmIChDUFVfSU5URVJSVVBUX0hBUkQgfCBDUFVfSU5URVJSVVBUX1NX
SSkpIHsKKyAgICAgICAgcmV0dXJuIGhleF9jaGVja19pbnRlcnJ1cHRzKGVudik7CisgICAgfQor
ICAgIHJldHVybiBmYWxzZTsKK30KKworI2VuZGlmCisKIHN0YXRpYyBjb25zdCBUQ0dDUFVPcHMg
aGV4YWdvbl90Y2dfb3BzID0gewogICAgIC5pbml0aWFsaXplID0gaGV4YWdvbl90cmFuc2xhdGVf
aW5pdCwKICAgICAudHJhbnNsYXRlX2NvZGUgPSBoZXhhZ29uX3RyYW5zbGF0ZV9jb2RlLAogICAg
IC5zeW5jaHJvbml6ZV9mcm9tX3RiID0gaGV4YWdvbl9jcHVfc3luY2hyb25pemVfZnJvbV90YiwK
ICAgICAucmVzdG9yZV9zdGF0ZV90b19vcGMgPSBoZXhhZ29uX3Jlc3RvcmVfc3RhdGVfdG9fb3Bj
LAorI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCisgICAgLmNwdV9leGVjX2ludGVycnVw
dCA9IGhleGFnb25fY3B1X2V4ZWNfaW50ZXJydXB0LAorI2VuZGlmIC8qICFDT05GSUdfVVNFUl9P
TkxZICovCiB9OwogCisKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNzX2luaXQoT2JqZWN0
Q2xhc3MgKmMsIHZvaWQgKmRhdGEpCiB7CiAgICAgSGV4YWdvbkNQVUNsYXNzICptY2MgPSBIRVhB
R09OX0NQVV9DTEFTUyhjKTsKLS0gCjIuMzQuMQoK

