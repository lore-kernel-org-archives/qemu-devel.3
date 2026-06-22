Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB3CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9c-0003di-L0; Mon, 22 Jun 2026 18:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9b-0003dC-R4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9a-0006bQ-DS
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:07 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJavOI2205274
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=; b=aIZa5ggKN2Oj6VBV
 KKcxjW3sdhNKm9TUVcn21351PNyxpyeevrE/xH3psw0j5qqbTiTmCCJnFV1jnFN2
 EYtsVYv+3hanU9UgK1TBl78470LZkEuN3Hk78PpnUwZJUC64E1lVpj3LCc1DD3Qc
 xeZHCRoQHUAE10gX6ZQsgiv+i6VciFlbrWuIq+5slelYfdt6t1eaeRKbKwEyAffv
 1mPbDCoUhH82iBFc+PUqhg77SUJawEyliNOjD+F+N9T9d8MhE81UkguQPw80MSk9
 yFm2Lda++NkrvSLRjNJA+nNdFVbJlxcIWzL1XIFWRl1Vu/L9AKPWJYF84eC3W5rg
 xpDngQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmsp46-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bef75a41eso5571284eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167394; x=1782772194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=bUdK8+6/p44D2LEOG3IY7G/vDDrqSjIsyhEqbjlc2Fc3I9vzZrYLH1p+DL6wP/7WlI
 s68BlJ8a2dqe3+WBayb0mhwURNpQWrq86uQWgu1h/ntD4l4qy7H13VbwzENjErh0KqWi
 OEZU6FEDT3Nrr+F4iItXzDrCG8ekXhmqVhhY3/pELbqXL1y8U1+tcb9uI33JxX1Drton
 CShqz1K8j/9VbYRN/yY5DpWJP615y84sMsoA6RUpPvLaICDJT+av7pcB797UVMvnC3PD
 mjg+ThfwcQ/YbHPryXyPD5Jp+hlj5C2hwvjcnEIMI7kGruQXa5cWUij/UCcMXABeuEvM
 WddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167394; x=1782772194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=dbTTyMYTmHXDlXh5yaflkzp7QvBarmle4/8M69SCdKwynzpWc9ANT/chOdQAisSzpR
 CjrcYYvG8Oh2/4ztV5kAmmb6cUjylG/QIsNNYOasN1+DXviIZZXqZWAFhd+wLYnk/J6T
 YpZa1RUeOuF33fCbv0thGcDINgFuKvRTNcHpCasIMp2jVY5H0DX3v2AmsFB3mqafXL1H
 n0B+QxaLyYxQFT0lChzfx7AK+vWfc9fETSyhbK2rDJpopapmuVDWqedNYwOuRE6UTrRH
 rgswxQOuSlNgubgWY069zE2F504SuARPEUecRZ4R4EA9C8voYl74Agg8WIl54tjrow4/
 aaGw==
X-Gm-Message-State: AOJu0YxqFgrPcc95LnX/UMaDtoDlSlcLdyZez5MQloVwyH+iBgNo38Eo
 ByB/A+MvmpsKcqIxqHP0AIx07ew5yIoTf/Pe6hOsnUMvG+Hl6MwwWO2mdqDChjVdlz40uCxX9HH
 cGg6Kh8NHbwKbjS65fsQMjxw4Xx/Asfh6K7VwVnQrwkW/0zo3qkbMD4h2CZGvmiAZyA==
X-Gm-Gg: AfdE7clGfSoQoK5tC9VJrjQPoYpix1MNZd6lljFEDrbalPASNyfcNm4pQgoZ4ucwC+I
 jWpBOzmb1pcRD9UBI2Kh8fnugMLUXLgQJ8sTY1vZOWi7PhGVT1C3ZETnSXemx1E0XeqgO7hjLY4
 u8Acfdi29T8iVY9xksJH/5wfQ9MLScPe46BxihX2xfmIVyMP730cFEkasSBzxncroFbl+rf35aY
 Pom16DNXWRX6lJvogZagR+3csgvJyczlgFnOtH1ARIwRMyPT2mwHdrTN0/JK6HSOz+2anoO2fsc
 3NkZznExSBn2gTcIaAeX8FS6+ACEVglc+RuJIPp/WEGzRUzchOETsIRLKlxXKTnCfm+aI+j4Scu
 jEc495NI1KyrBaGpGJZPkEOWecSqzNqOSUZTnG4ffnYhed6NmOMZ+Aan2qCc=
X-Received: by 2002:a05:7300:ed0e:b0:30b:dd58:e134 with SMTP id
 5a478bee46e88-30c1dbd387cmr8386668eec.21.1782167393974; 
 Mon, 22 Jun 2026 15:29:53 -0700 (PDT)
X-Received: by 2002:a05:7300:ed0e:b0:30b:dd58:e134 with SMTP id
 5a478bee46e88-30c1dbd387cmr8386646eec.21.1782167393488; 
 Mon, 22 Jun 2026 15:29:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 30/75] target/hexagon: Add representation to count cycles
Date: Mon, 22 Jun 2026 15:28:19 -0700
Message-Id: <20260622222904.607771-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX5c1BBDRkTGTY
 X0ibdACqaCZ+xu3oQ84cFq07l8EgATDP62f/qIdjxpmRRBLi7RFEVkn2+PspOBHkJdPZQ5bPI8v
 TO0byyP0XL7SIBvDX7NC1T2NSlb2u1w=
X-Proofpoint-GUID: FLT28lE173maT6ckPYUN1ABwPlwh2E-z
X-Proofpoint-ORIG-GUID: FLT28lE173maT6ckPYUN1ABwPlwh2E-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX47ILIVS+us4X
 Rd4IYUdDikraOLj72sEkfFk7VsfQF/PnlSlKz/K/on8VAxoLCiUbnvc86nfov4NVOT2Cz2Hx03v
 PmWw1u95UT6xfqLbz088V57uo1gTIKBU7ErQPKALWpCmhblY1aMY6/0CHjrvg7S5+NVwFu6oAty
 bvNnVH1LTtYgZT3V8Co2H6ntCvn16avtop+wpOUQluL0EF89IzGbcdE6mUhQdwcKRc+LdAx/xXz
 yBaqvF9go43FwAc1padSwthLbgRAowFiCs1erhv7Ak8OyD4eHWCKoLMrxoAro5svzjcVItXx2eG
 8QOZIuYkTrNGwpqNHLNUvUEmN3uXhsjM3bLT0ux7WXnR/35B8QdF3Bfz5eKF/YQVEnqc42m5Rcj
 lu3bcpGigj/+SWpu8T78lGRHBm2rlfJe7+tZV6bkzsuDnf0hGvVCVe34Nf7k5SuZTv2JOrE0wZk
 3oApJje3jK2UPVE/Sdw==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a39b762 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gmA5YO3DfmenxuRff1QA:9
 a=tsLLKIjAKpJP5df9:21 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

QWRkIHRfY3ljbGVfY291bnQgdG8gQ1BVQXJjaFN0YXRlIGZvciB0cmFja2luZyBwcm9jZXNzb3IK
Y3ljbGUgY291bnRzIGluIHN5c3RlbSBlbXVsYXRpb24uCgpSZXZpZXdlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5o
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRiZWE5NTNhYzcz
Li4yNTQwNDU4YjM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTExMCw2ICsxMTAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5kZXggaXMg
dXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRocmVhZElkOworICAg
IHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3Zh
bHVlX3VzcjsKIAotLSAKMi4zNC4xCgo=

