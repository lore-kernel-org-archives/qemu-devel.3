Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97846C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnd-0004cQ-Bi; Mon, 29 Jun 2026 09:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnb-0004bm-DL
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBna-0003CG-04
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATJaV2656107
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=; b=eyvW7xfXMuuvz3eP
 55rHD9g2Fo14PQh1l/OrjDN5R6jCPIlViE7CqpYfcLGKzw2hvxIOwHNoVFVTb9K7
 Zji4GV2z3YtTIcA/sIFXl6OamK9WySgPK6wUkmJxv2TqZC0NqOs/g/cEG2TtX34v
 vKzJ78vIvenIgLpa2Mpu8osIxuzB5G7lyv0seTrRUP7Sj6+tr/YjTOYlqZEM+c/e
 j3ujmCsbo+SFaKcE3SZ63vlvuHU2VFxVeCXUA1jzDAl7eEwy6UNDx+j3mec5jset
 KMvgmidlfKe21Ymy0HQwGqYK6lqtLGIzzo/yiAdQFy3GLQ80SLrPWIS7G5KCMz0b
 LRGy5A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gxs5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:06 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13980b6561dso9100938c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738786; x=1783343586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=Np92ifm/8hyCJehdOXXM8+yZ1SQUELUyLnBI9N4CMsHAskR1zqVwjWtZgDqis35KEx
 jc5HPWu0RsADV41H4K+7ub/vL3neENKRYnj9adruq1rTQOuJJpbhEV8xkuQcmiHjL9D8
 fTrlXtK145O/l73DaWFIncgLfV5pJtOCYsvrb67LQVkzBBukJNOPtmiofzGQGKHUiF5H
 sR46qVQxY/QeQH+0+tVKxK67guTdAh2fySmEQCBB67Fv4Achl6ZfJwdRGP8MWwFMvLax
 4RmG0LWG15NJoB8yti5kIInDnk5g3yh774jD1/VKI1+CL8Ixy5OO4Xaf+CyUyrFiojkJ
 vDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738786; x=1783343586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=oO6DUQu4g76TlAXDHTPFHWYdgxTFcmGQ/MfKOTCVFylaQLiNLWi7KKV9LrKSuzkSfh
 8b0WC/3/rYiEYE9XVGprejkpO7/ifUEU0V4faMunkxXrg9kwzBhA7+6TKQ+2Ip8V5w1e
 HzAsOBXGtOMxDM4j4/Xi8FMUQKT68uz6ZlQDN7EibHKe9hqmZlKW0wsFVgMFoOAZ0iy2
 HubNXgos3LmyEeMselINHPWgjY6GCNGO+1VFfxGNl6ovgmx9VTFIJV+49Y21y0AaQdTn
 IP3XKdKPo0Xg6C9aSPez18clG7e4+zl4pKc+wadnqOzpQ6SRRscmdfNF+212Plxsw74M
 5Dew==
X-Gm-Message-State: AOJu0YwuYKTURBOGGvSKltBUycGh/Lk6ZLISf2tHBRTG7v3+QDpGJ4RG
 Hla7f+bgkYrZfgPPRcP3WvGTLl6Bo3k1+b7BfdUEXTNv/lX6PTptciLJ6/RzJLJ3u51hkg734zM
 gvwijwQcBRLqDaTfwRvCw2Q9O47EVkJT1ylyWex+kIQp1RTTGm9zBH6jSmju30arlXg==
X-Gm-Gg: AfdE7cloSx2gXWuyic1Bvq1to9196/ZpHDo2XOgDAkrfgT49DiFQZYKJBNJrx6YyqtZ
 A8JaK2aabGfpcDcO0HXGRDIDvXib4mt3gVdG0kTq8qtMIFi1PcpqrlxSA3/ZEUVPrtmWogwTF3n
 V5QJFRy1CiiIM1sdqTIeOOk1ZZDRxH/MDbKlPeYLSqWt+g8jGiswACR8h6Uir2rcR9HX1+KnDXp
 kp4hTIofytSZ/TqJgbpHkJL0TImT44ox3VhndHQ2wwoOACAOj53P+jQ4OeWV3Vyr+WNgHpMuQdE
 dwK++aEY3HDRMwB6PkLG+LvfWLwzv8I0Ky4zmXwi1jA0KIR8l0VlCeC5DkdlubxHse+lj0laGKV
 +lfvgJGYt5seYPf441WADPsgg0e0eVxvqggmDEge4x7S3i0JE1CzH71jYVnc=
X-Received: by 2002:a05:701b:2305:b0:139:ed5d:3a6 with SMTP id
 a92af1059eb24-139ed5d056bmr5081277c88.43.1782738786013; 
 Mon, 29 Jun 2026 06:13:06 -0700 (PDT)
X-Received: by 2002:a05:701b:2305:b0:139:ed5d:3a6 with SMTP id
 a92af1059eb24-139ed5d056bmr5081253c88.43.1782738785460; 
 Mon, 29 Jun 2026 06:13:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 17/77] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Mon, 29 Jun 2026 06:11:32 -0700
Message-Id: <20260629131232.2487780-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXycZoua+uUs7y
 ZZD/6VhicfDZ+P0I9me9GWn+chkuJPce32kxhxJ439QX2MbpCNJ+/5fQCKYCY2eTrlRWEFAqRPa
 QpfHeiuSinDkRnM1EItA7ht9+kHYXAtdOFczJyMh9hf2qcKqfCzt4imEFXz5M5+xnWX0FwVWmXM
 cBYHGmSs5NvbL4VmXZIOksLspWo7kitzMjFg6gyJv3UpI5fMzvZ7Ac1343n4RINrLQLcCMjRdRz
 fGK2mxy9roF2vrNx01FQpgw/Yw/yM4azdszWoJMx7EqiEdPArqwQFN+2V2+9lgxMIwTLE21YLOX
 kJRupIZy/hR8aHFNLudSDhkf5Y/uXKxvyrg74MDlpbhdDQQhWaZ6UGvDamomkoBwAXEE+6S3UTf
 yfm9IfrZbFGProWWHwAGJVnf+mKvn9yvrtbM7Z4bjBwRpZsXIBhdtt/G6OEyGKpw7sP+4kJxRTy
 2l5wC0P0k6LF+n5mmrg==
X-Proofpoint-GUID: -3DykZymnDAf_xfi2-H200AvY1UVxqIn
X-Proofpoint-ORIG-GUID: -3DykZymnDAf_xfi2-H200AvY1UVxqIn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXwbkG5Wg7+B2a
 FnCoUD0csF9ivAPoSxcp0y20lsWnq2BMAZfwOxhlkKaXVWkmvLi3n7j/+2ytcBkfaVBiEbzU6Jr
 yMjKzc24BXLH5n7mXmcS4GEIwIxEXKI=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a426f62 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

