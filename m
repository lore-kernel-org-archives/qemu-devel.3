Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B545AC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNp-0002zC-KB; Sat, 01 Mar 2025 00:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNn-0002yL-OF
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:27 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNm-00088t-B2
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:27 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KHTh007066
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 abWiC3KjUcGLku2Dep6zkJUGgeKS51heT8F2S4omSI8=; b=XrP3bNOhOtlR93cP
 vVFRyYbW5I+rz6Crn+7mjsaZUJTgcYW/FphWHF0FEmdDhAHw/ST2CpbebFGNBJVM
 +61XIU0olpt2j5iYNBOF+PgFpgDIX0zylde0JEquiduw+GbhR/Oxcq+ez42/HdvM
 ZgS5qzWBPxhCDdie73VwtvzjOW/dt5i1cnmC3vADEvf2MnpHlc6rEXgvLZdngZVo
 Wh2l1vHvmmioQ9lWzqXW8SWp0YI9xr0cdQN2wjKN5KNtxZl7vUJTntS4+QbZfZTx
 osPXiFzM0CbEONJh8deISSv6SOwWyPlPP7c+2v1TifjhRVawQOm9afT2Gvz/tBCe
 lO+A+Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r69d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2feda472a38so462098a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806834; x=1741411634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abWiC3KjUcGLku2Dep6zkJUGgeKS51heT8F2S4omSI8=;
 b=ZPZthP9YCETdhCKfYLFgnM1sPT8k02Cs4olWPGQGcL9Ep91u6iYxDjPrAP1ViprXJX
 iT7LL08yKwVXLuOLBOAy8gCpj1MJJUY9Yo3kSZkzJeH0nDmht26fdshK5EXF733cpa/z
 QyL1zklHBTTkWNIaZY7Q2pplndZ/gFwcQQKxo84OxM7TYWHscqfF1TGVfzpjEWuQ0LQt
 otSNNOfW7hHe2lPzBTDKS+b97yLt+4BOaO5JkulN7znUhn7vEn0HLohl9/UdT7mHu6VC
 eHDtyQBH2MJOAFfqWPsvsPLLYsIGnbPL3ebLPyPx9nkbk6bxWvpqYlHEVYcy0/s6AJQQ
 aO5A==
X-Gm-Message-State: AOJu0Yym9H9rQIM3n6J8wJ6W286NVQPXEVwQ+b5l9tlAj4ABTQyBA2Ah
 GLuTuwklfxSqxPEp9rbM/qanOw5MOakQb7pST8s54yj9Os6/g826QEdt3cVK7qk3eZbpP7YDh/A
 +sXusOCfhrn4pQXEHZnLgS6khuajtgYRxMeJpFJkQTIUhbV+8PrOVJT+10mGgMg==
X-Gm-Gg: ASbGncsO1i4fXXOTjnjDka51AISxH6xJ8DwsEAf1q5MwSGdtEfjRdeZzM8rBHkKOKsB
 l5yrudm9NwDqs8bj1zjQfdgf2uQDHrUOcK8U4ELe0nA/QXgLOxJuYM5GlGC0T8hpD9y/lwLzg27
 nmseQd8wb+4/k9BIUI9/E8bTraC1ReikXHwohk0gdJ6/jpbmDGXjDeQ2EIvFOcGP82gzo1vB3ux
 9/qdBz0kcWLP6E85CCkkMJpldqMHAz49JHquoLIHwWyh3Hk3c9Erts/swg5gaOR6ftXwdBrdYuC
 WSjv0nFDsB3B69Z5/VY45t0dsm/dTnrewEcCH1qrbwe9ZD5UKX2V688v8dhphRiM
X-Received: by 2002:a17:90b:38c2:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-2febab78775mr11336857a91.18.1740806833667; 
 Fri, 28 Feb 2025 21:27:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfxPbHm1gzTjRh96TZN9poL6wGCZhnOCiDJN0IqckRtr3z1oaMtx9e10A28PXqHay3wKEPjw==
X-Received: by 2002:a17:90b:38c2:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-2febab78775mr11336829a91.18.1740806833265; 
 Fri, 28 Feb 2025 21:27:13 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:13 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 20/38] target/hexagon: Implement do_raise_exception()
Date: Fri, 28 Feb 2025 21:26:10 -0800
Message-Id: <20250301052628.1011210-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 728urQE7J46jMJ-lC7zdS3A7obCAlBOs
X-Proofpoint-GUID: 728urQE7J46jMJ-lC7zdS3A7obCAlBOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=818 mlxscore=0 clxscore=1015 adultscore=0
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
aW50ZXJuYWwuaCAgfCAgNSArKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCAyMCAr
KysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmgKaW5kZXggOTY1ODE0MTMxNi4uN2NmN2JjYWE2YyAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0z
MSw2ICszMSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwog
CiBleHRlcm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RI
UkVBRF9SRUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhh
Z29uU3RhdGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB0YXJn
ZXRfdWxvbmcgUEMsCisgICAgICAgIHVpbnRwdHJfdCByZXRhZGRyKTsKKwogI2lmbmRlZiBDT05G
SUdfVVNFUl9PTkxZCiBleHRlcm4gY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4
YWdvbl9jcHU7CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
IGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggY2NkODA2ODM2Yy4uMWFhNWIzMmIx
ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTM3LDYgKzM3LDI2IEBACiAjZGVmaW5lIFNGX01BTlRCSVRT
ICAgIDIzCiAKIC8qIEV4Y2VwdGlvbnMgcHJvY2Vzc2luZyBoZWxwZXJzICovCitHX05PUkVUVVJO
Cit2b2lkIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
ZXhjZXB0aW9uLAorICAgICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0X3Vsb25nIFBDLCB1aW50
cHRyX3QgcmV0YWRkcikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisjaWZk
ZWYgQ09ORklHX1VTRVJfT05MWQorICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczog
MHglMDh4XG4iLCBfX2Z1bmNfXywgZXhjZXB0aW9uKTsKKyNlbHNlCisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOHgsIEAgJTA4IiBQUkl4MzIgIlxuIiwKKyAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKworICAgIEFTU0VSVF9ESVJFQ1Rf
VE9fR1VFU1RfVU5TRVQoZW52LCBleGNlcHRpb24pOworI2VuZGlmCisKKyAgICBlbnYtPmdwcltI
RVhfUkVHX1BDXSA9IFBDOworICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBleGNlcHRpb247Cisg
ICAgY3B1X2xvb3BfZXhpdF9yZXN0b3JlKGNzLCByZXRhZGRyKTsKKyAgICBjcy0+aGFsdGVkID0g
ZmFsc2U7Cit9CisKIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIo
Q1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludHB0cl90IHBjKQotLSAKMi4zNC4xCgo=

