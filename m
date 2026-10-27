Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1193C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EzG1baB3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ga6NUtZh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXsr-00029h-03; Mon, 26 Oct 2026 23:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXsk-00027Y-Tm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXsi-0008If-K0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2FHjW818812
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=; b=EzG1baB39t6geu/I
 Z4QjyJzdA5KpHTKp/8UxTuP8OhvwNa1EhoO7Ixxkevejkh5IxTECtjwYwJdXQr1C
 5A9r1ykrfw1ufk1jrfW2yJNifVR3NXMan0CxOql8HtL7HcSxcTtEZr8qGvCdRSkU
 1aIVzffZZzwSKsbw41exWpA9qDxlyPOAQdcZIC7hR0dY/R55uncuDwq91w26A7DW
 FULVzvGq/AYqxwUmFAY2q2+V8OpcGx/y0ld5jp9ugOMvGYLxYkyomOvajYWj8kpI
 EUMsA6V3UJMTslieOE+jmnLETuN+QpD+hUHEBR/a2jEDQ/Dit977PrmEw5rV/Ih2
 1ZUgMA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y3dgq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:47 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso6623837c88.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071787; x=1793676587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=;
 b=ga6NUtZhbJUVI3x8ELyHyQ9H5jhxGFzTKFq96Dw2eTSylHd2El8YP+LLgOP8gtP25c
 uI2xPJDc9HTehvwgEhr1KyC6p18Gf4IijLF/VLgynNc43EYJ4Kg9HIu7ovFJY3d1mQBB
 s34osTkJWhb2nMZ6cFc3+jHORLZSD6ACTRNb8T0wKaVrxszQkgtTd89TkKgcRUp0SdRX
 Xr+mSvA5NdGeLus7xxpnYQMgcmFdYR/PqqVcjZJujYDM0n10swDlAgq+LgsGPo8SP1HZ
 Sqfd3qLDRm2YDLK3XwzkJ+C7k7ibqFbnDzNPtxvxzmsETZpKmIcSkKe4LgzeURh/TZc2
 Oc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071787; x=1793676587;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=;
 b=eAMcrF2HCJ3/hTtW9r2XbaHZ4S5QGJouttQ4M3pZIB87iQca2EGGfpT/qWLmbNzmOM
 VFwKMxGT6bABYcusx0mEx1bKzsS+tTlixe7HO/HcM0V5VTnN+dRCsi6m++Ki9qoDMlkg
 AV1KtjGWj/Pf/QyvKdoEzBrgLOCesHwrPywbSNmoe+ezW+O3YkjYVvf1NGyp95DUuufW
 CjeST1DExRYsi+M3fQYZ+2Mj3EIsWOl83NAiHKsOUZaes77v3JxCsoXUou0/BnqVct8X
 sm/9RKlPUgPhnmByYpiBezI9Sle8TigFJYfQ3Ro8xU7+BWxNexe/dkPlOH7RhMxSGkqJ
 q3oQ==
X-Gm-Message-State: AFq9FYLQRCp2YkfQ3L53VtRTlFwEGnqrBNmeKbJk10vL6RNKICI8xNZx
 fwFggsJA9emAYIesBpji1e9sTbfQM5/5irsgIYYwIPFcVRNApKQmveyYfDSTpEbyhcVi38C+Kcc
 8dFQh/bI71vhCRgrf5KixC3lnLJ9vNCtyaDfC8GjABhpdsHdeJym6WAKmekZP6X5yQw==
X-Gm-Gg: AYBFou1kng+YD9JDxZQCtk6ZmD7bCMTj2PhrnPb//sFmzXjShF31F/r+h7LJcQB1fWK
 tJ8a4zI8F3y5w9KTaqpBr+kvDIG2MMlqlUqNVijT3qb+vsXdA9Vh96xjPl5awVmnFTmUd0B4C9G
 ukbyxcqsH7/AhhdqUKjM3MNrvwLjCmHBpSLzkTLHmRaNDNdHOr82NOGBMutQ5oV0MmF19rBzBSK
 IgsABfI85wpn6mGrVlaqbn2SpM6snsYKTaHfY/dvSncMWcHqYk+jM54M6ROZogfz47EPsJ2XPQe
 G2nkhvazKyRdbQ8Oxg4K+4GkpX4SqG0XVSM6nnpdoGwACd+xKE1fwbnfPvxxF8saBsbxufqDA0N
 26QBK4cWlffOgCmCw8cCTqWjMyM0/pZuXjpXe9YubrFIaiqo=
X-Received: by 2002:a05:7022:2229:b0:149:1feb:6dae with SMTP id
 a92af1059eb24-19937abcc34mr19809979c88.39.1793071786439; 
 Mon, 26 Oct 2026 20:29:46 -0700 (PDT)
X-Received: by 2002:a05:7022:2229:b0:149:1feb:6dae with SMTP id
 a92af1059eb24-19937abcc34mr19809944c88.39.1793071785807; 
 Mon, 26 Oct 2026 20:29:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:29:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v3 05/41] Hexagon: add v85 CPU model
Date: Mon, 26 Oct 2026 20:28:51 -0700
Message-Id: <20261027032927.3055166-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX3P/hac+R2rme
 Ew7xSOIFKqNs4Ho/J9vJoWHAongmlRqyuJgyqt1iSFKsmrwm4L/a/zGrvR4f/OhylodEBPec2YC
 ZEVMXMWtLe+TLbf/jaKHpEM5q4yNfDE=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6ae01aab cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX9Zft2BXZGmi5
 2mLt7OPOa/QzoD1aRgdALxIP0VTRSclZIwUkaQNR5IsJmESIZZeRRy6iT7Oz2uN4SVQ8cqhwv+M
 VwErHH+J4RSGpVaRwcFwZiMMXDHNsmhOkFOkdwONpCP9W//9Gqgyh0XBsZjbVTtEVzQIwHUViQw
 QeG0pM3JICmXnKCWu6jnNoqU126JWFWOx1cV9tFtMIQa0XzP/JwxF1h4cIciguFJMfj4FGch7FB
 wt0fKifL4CGfLywqpOLnmCRbXQ4WXTHHPqeWj2Zmuzp0K1TsjYExeU+9pLuGkV9PY7D2CAtuYKJ
 FiL5/QbM4au3bp3jxV5vqDlQzRiNMGpn9b0raQizjUnQyDew5UKuphYhS4vvG7j9WG2L6Kp8FPD
 r2Z4ZdFAza9D4c21cLQ/6K7xyahDrTqICZnQ5mA2xuKBiK/VT8jIeG0FsJVJGxYI28liGGFwzpO
 DqQqpMfQ/ocHffjQ8MQ==
X-Proofpoint-GUID: 2qv7FitFYdFo2cmFdXjQbYZk-lec8nTc
X-Proofpoint-ORIG-GUID: 2qv7FitFYdFo2cmFdXjQbYZk-lec8nTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgfCAyICstCiB0
YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAgICAgICAgfCA0ICsrKysKIGxpbnV4LXVzZXIvaGV4
YWdvbi9lbGZsb2FkLmMgICAgICB8IDQgKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgIHwgMiArKwogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIv
ZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CmluZGV4IDEyMzg1MzExYWE0Li5mYjU3
Yzc3YWU5MCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cisr
KyBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApAQCAtNiw3ICs2LDcgQEAgSGV4
YWdvbiBDUFUgYXJjaGl0ZWN0dXJlIHN1cHBvcnQKID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09CiAKIFFFTVUncyBUQ0cgZW11bGF0aW9uIGluY2x1ZGVzIHN1cHBvcnQgZm9yIHY2NSwg
djY2LCB2NjcsIHY2OCwgdjY5LCB2NzEsIHY3MywKLXY3NSwgdjc3LCB2NzksIHY4MS4KK3Y3NSwg
djc3LCB2NzksIHY4MSwgdjgzLCB2ODUuCiBJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUgZm9s
bG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgogCiAtIEhWWCAoSGV4YWdvbiBWZWN0b3Ig
ZVh0ZW5zaW9ucykKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS1xb20uaAppbmRleCAyYmZhNGQ1ZDBmYy4uZDRjODQxM2RlZDMgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUt
cW9tLmgKQEAgLTI4LDYgKzI4LDggQEAgdHlwZWRlZiBlbnVtIHsKICAgICBIRVhfVkVSX1Y3NSA9
IDB4NzUsCiAgICAgSEVYX1ZFUl9WNzkgPSAweDc5LAogICAgIEhFWF9WRVJfVjgxID0gMHg4MSwK
KyAgICBIRVhfVkVSX1Y4MyA9IDB4ODMsCisgICAgSEVYX1ZFUl9WODUgPSAweDg1LAogICAgIEhF
WF9WRVJfQU5ZID0gMHhmZiwKIH0gSGV4YWdvblZlcnNpb247CiAKQEAgLTU1LDYgKzU3LDggQEAg
dHlwZWRlZiBzdHJ1Y3QgewogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y3NSBIRVhBR09OX0NQ
VV9UWVBFX05BTUUoInY3NSIpCiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc5IEhFWEFHT05f
Q1BVX1RZUEVfTkFNRSgidjc5IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODEgSEVYQUdP
Tl9DUFVfVFlQRV9OQU1FKCJ2ODEiKQorI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MyBIRVhB
R09OX0NQVV9UWVBFX05BTUUoInY4MyIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjg1IEhF
WEFHT05fQ1BVX1RZUEVfTkFNRSgidjg1IikKIAogT0JKRUNUX0RFQ0xBUkVfQ1BVX1RZUEUoSGV4
YWdvbkNQVSwgSGV4YWdvbkNQVUNsYXNzLCBIRVhBR09OX0NQVSkKIApkaWZmIC0tZ2l0IGEvbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMK
aW5kZXggM2E2YmE0ZTEzMDQuLjlmOThhZDhmYjg2IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hl
eGFnb24vZWxmbG9hZC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKQEAgLTEx
Myw2ICsxMTMsMTAgQEAgY29uc3QgY2hhciAqZ2V0X2VsZl9jcHVfbW9kZWwodWludDMyX3QgZWZs
YWdzKQogICAgICAgICByZXR1cm4gInY3OSI7CiAgICAgY2FzZSAweDgxOgogICAgICAgICByZXR1
cm4gInY4MSI7CisgICAgY2FzZSAweDgzOgorICAgICAgICByZXR1cm4gInY4MyI7CisgICAgY2Fz
ZSAweDg1OgorICAgICAgICByZXR1cm4gInY4NSI7CiAgICAgfQogCiAgICAgZXJyID0gc25wcmlu
dGYoYnVmLCBzaXplb2YoYnVmKSwgInVua25vd24gKDB4JXgpIiwgZWZsYWdzKTsKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZjM4
M2ZmZDg4ZTYuLmU3NzA5N2JlZmM4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtOTc5LDYgKzk3OSw4IEBAIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyBoZXhhZ29uX2NwdV90eXBlX2luZm9zW10gPSB7CiAgICAgREVGSU5FX0NQVShU
WVBFX0hFWEFHT05fQ1BVX1Y3NSwgICAgICAgICAgICAgIEhFWF9WRVJfVjc1KSwKICAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjc5LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzkpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODEsICAgICAgICAgICAgICBIRVhfVkVS
X1Y4MSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MywgICAgICAgICAgICAg
IEhFWF9WRVJfVjgzKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjg1LCAgICAg
ICAgICAgICAgSEVYX1ZFUl9WODUpLAogfTsKIAogREVGSU5FX1RZUEVTKGhleGFnb25fY3B1X3R5
cGVfaW5mb3MpCi0tIAoyLjM0LjEKCg==

