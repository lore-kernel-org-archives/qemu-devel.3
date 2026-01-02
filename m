Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52D9FA3758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 20:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vblVv-0003zr-2i; Fri, 02 Jan 2026 15:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVg-0003se-4p
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVZ-0002TK-Kq
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:28 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6029Wcsg3961604
 for <qemu-devel@nongnu.org>; Fri, 2 Jan 2026 20:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I9XkfUvZANj3OOkBJa6CR24ppjbV4Ihsv1YGGM0MYn8=; b=QYWyY9t2hGoSImHW
 wZ/UgowBtEnCkv45opa0DP0J3U9qorZvzaNG18GUHniNich4Kx2IG3aYLxskDIkI
 v/wqII1iDpMCZjNTCBlzfLPE710E+2imqbap5x7LnowjhcmMjuD87N3sPemzbOKB
 QyfEU9D2B9XlhZDo92iXcRbHTZ/++QNaiQGo2eTHaT3nMofiZ70ZsnegSWRHqYhB
 5NEa3Aj0TKzLkRUJO7hULEAY4cIjR6uutp/gk13kNbiWjmh0tEKz2XgBkB/ElFTv
 0RyZVt0+l5adt5uQ5h72My/kPZe9a97Tb3oNnoQqYNBSE2b6NJ4SuFYy6n1Ja5rd
 dS41zg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd77v49j6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 20:12:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bc240cdb249so11062757a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767384744; x=1767989544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9XkfUvZANj3OOkBJa6CR24ppjbV4Ihsv1YGGM0MYn8=;
 b=H3ybp+0KtFa/h8ag8+a48QPMafZzRh0EUdSJ0XRVFBFL0v05TGZ4S3rWm95bdphYIN
 QU7+0XNnFoEtG9dGn3DlmonPKDFrF7znsTY1PTHll7Cw+VKqmYj674nMs7WKmDVjv0N6
 45ZkReIL6dSx/U/oYL2bHcJ+SeR5P5RokrnDNmzv/NUCfhKrPSAEvn1xchQrizvHD8Jd
 3Yuy08LQ7XpaAsIEv278QjM6NiU404KWruODzLCfep4x2Vzt2jdTPJoaDtGWnKRTQ8Ol
 WhRLpEv7qxNaePnulOk/9jRZelrpQ/ONzIgnU7B5I35cJSERpI3pnBtnYYqk+7sLoC9M
 4gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767384744; x=1767989544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I9XkfUvZANj3OOkBJa6CR24ppjbV4Ihsv1YGGM0MYn8=;
 b=DDQ5EiYrXWEarO8pCM+QpEbcWkXW4yuRbnfQ61CQv5FEGr87KKSbqsQ5ZV+FY8eRHB
 jOmq1qkBydQsAFAw7hwID8cWO/SgZNgtagzvvbGzniHZuMHgFEjqxxyz5FDAPk2BI08S
 hbrQdQalQUp7VuVHGE2C9PxF+iAtwtQzn/NJKC8pMN7SI8pWOzFa/l+VrvqmloqPoNgb
 4zlnQG9UH1FG9P04xhfEg/xUslDLufiqEf1q6rKqXoxv/0FlePqbHR39PwPQjD5lnWNl
 nQbBQ3V82tQxyLA5nyz8b6rPKXlWXFKdfiPzHEVfyo5qpgA3n4Zt4muPmYxFHVUgQuWC
 IKVw==
X-Gm-Message-State: AOJu0Yw6T6JIBUP90W/CKKji6vYzLahTQKBCRBtsX4BvyVA6Y68enPDH
 E79BfdgBm+4Houh6uFcEWeh3LbVkcviTF0dORTRc0yX3UVk8AfB84J2Yo5tjmBoY5rCLFZNWmGK
 9mWHPF8jqKW6ExmvuSsrDvqxMB/lIka/FVaiYz/fPAZOXRXkm3lJ6iwYee2pqmdt1IQ==
X-Gm-Gg: AY/fxX57TqoNTwKW5tpiYaFOSubQZ9XNqPo9eA5x+g2Ui0+KsJ3p6CoqsmR4Jfg1ukW
 WqUkIODbtXpWbXmvmIcKlC5Uk3mQiDjrp75F+vvaPSHmHXqczLzlODlkMy7mpI7chqpC1n6s0cd
 YfKvHUpSDuMrlgXUGtveqyj/HtzSzcMJ66XYltPrpA+h3GOR/GehnUU8OSsCkIM76QywbmrP+pM
 Mnz+5lrw9fLZEU6zMXz8vcNuVX35k9GgO0o0qx1+iajob5Lye2MoK7jBXwQzJuk0o+Ocee1BTQL
 lKCzoVy96b+W6U+RvkntlC4Y3YgZfUhg4aOj0xMhG8YjG4KxLWbFdsO/fA7tjkqmLZGhpSBH3Du
 i0uPkeM1DyByQYB+u4t9kSLTyW5K3lOanyfNzoHUrWqK9OFdKCsqfNEBc5w==
X-Received: by 2002:a05:7301:4206:b0:2b0:4965:8829 with SMTP id
 5a478bee46e88-2b05ec97e9bmr25181372eec.34.1767384743511; 
 Fri, 02 Jan 2026 12:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcfoj4nscuBLIpECi2XJuNTUkFiX3fL151vVwYJ/ZKI6GblEcQiZDMlB1CNLCZmgIY0yDJsQ==
X-Received: by 2002:a05:7301:4206:b0:2b0:4965:8829 with SMTP id
 5a478bee46e88-2b05ec97e9bmr25181361eec.34.1767384742844; 
 Fri, 02 Jan 2026 12:12:22 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b140c42e7esm1794621eec.22.2026.01.02.12.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 12:12:22 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com
Subject: [PULL 5/9] Hexagon (target/hexagon) analyze all reads before writes
Date: Fri,  2 Jan 2026 12:12:01 -0800
Message-Id: <20260102201205.2050363-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
References: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: BWqI3FKiUhwZYkcBmaTgsPnQcuoSLmsW
X-Proofpoint-ORIG-GUID: BWqI3FKiUhwZYkcBmaTgsPnQcuoSLmsW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4MSBTYWx0ZWRfX3nmxNryRVJAe
 f1/RZIq1yK/RBU2aEp9EYacpbFMqhHBabs1dGvkda+oF+jCpD6zrSjFqYW3rFZxn3Cpakn55jYM
 GcxPDWeXDVIGgPjrBM5/w10gm4rfpItVaCy9csci/N7eqie7wcHNFFjBRsPeB5mSFGqGFlcYqVX
 DPrwTlBAX/lOcQsZ2zlg6u4rJES+jTqIaudphqtZNlTDj/UMRV1/0hb/VymwXETkMTcX8F3977r
 Kp4SbpyCx1QPvN6GtGOZnmM+v0vrNkGIpbkU+VrQNTRewyf8/Hiqm4/7Tq1Rd/J7Qxwk1ddTmqi
 CrTiilnVLDvfdZzarQQUr9IjgVSUCk1Rf5MhQCMbzSGOYxWz0BiQKLzv1XtlMXGIbZUOintAeBF
 3z7RD68teEoyZemJGO83GNo8rAK954VNOvOVoyyXxWarrGLZwMO4OVerMn2ezY8pSdPh7Kad/8o
 nDRwdsJ04CZeGtE2e6w==
X-Authority-Analysis: v=2.4 cv=ev7SD4pX c=1 sm=1 tr=0 ts=695826a8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=G0vlGs2hSe-mXG6TUcQA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkkgbm90aWNl
ZCB0aGF0IGFuYWx5emVfcGFja2V0IGlzIG1hcmtpbmcgdGhlIGltcGxpY2l0IHByZWQgcmVhZHMg
YWZ0ZXIKbWFya2luZyBhbGwgdGhlIHdyaXRlcy4gIEhvd2V2ZXIsIHRoZSBzZW1hbnRpY3Mgb2Yg
dGhlIGluc3RydWNpb24gYW5kCnBhY2tldCBhcmUgdG8gZG8gYWxsIHRoZSByZWFkcywgdGhlbiBk
byB0aGUgb3BlcmF0aW9uLCB0aGVuIGRvIGFsbCB0aGUKd3JpdGVzLgoKSGVyZSBpcyB0aGUgb2xk
IGNvZGUKc3RhdGljIHZvaWQgYW5hbHl6ZV9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgpCnsKICAg
IFBhY2tldCAqcGt0ID0gY3R4LT5wa3Q7CiAgICBjdHgtPnJlYWRfYWZ0ZXJfd3JpdGUgPSBmYWxz
ZTsKICAgIGN0eC0+aGFzX2h2eF9vdmVybGFwID0gZmFsc2U7CiAgICBmb3IgKGludCBpID0gMDsg
aSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKICAgICAgICBJbnNuICppbnNuID0gJnBrdC0+aW5z
bltpXTsKICAgICAgICBjdHgtPmluc24gPSBpbnNuOwogICAgICAgIGlmIChvcGNvZGVfYW5hbHl6
ZVtpbnNuLT5vcGNvZGVdKSB7CiAgICAgICAgICAgIG9wY29kZV9hbmFseXplW2luc24tPm9wY29k
ZV0oY3R4KTsKICAgICAgICB9CiAgICAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGVzKGN0eCk7
CiAgICAgICAgbWFya19pbXBsaWNpdF9wcmVkX3dyaXRlcyhjdHgpOwogICAgICAgIG1hcmtfaW1w
bGljaXRfcHJlZF9yZWFkcyhjdHgpOwogICAgfQoKICAgIGN0eC0+bmVlZF9jb21taXQgPSBuZWVk
X2NvbW1pdChjdHgpOwp9CgpSZWNhbGwgdGhhdCBvcGNvZGVfYW5hbHl6ZVtpbnNuLT5vcGNvZGVd
KGN0eCkgd2lsbCBtYXJrIGFsbCB0aGUKZXhwbGljaXQgcmVhZHMgdGhlbiBhbGwgdGhlIGV4cGxp
Y2l0IHdyaXRlcy4KClRvIHByb3Blcmx5IGhhbmRsZSB0aGUgc2VtYW50aWNzLCB3ZSdsbCBjcmVh
dGUgdHdvIG5ldyBmdW5jdGlvbnMKICAgIG1hcmtfaW1wbGljaXRfcmVhZHMKICAgIG1hcmtfaW1w
bGljaXRfd3JpdGVzClRoZW4gd2UgY2hhbmdlIGdlbl9hbmFseXplX2Z1bmNzLnB5IHRvIGFkZCBh
IGNhbGwgdG8gdGhlIGZvcm1lcgphZnRlciBhbGwgdGhlIGV4cGxpY2l0IHJlYWRzIGFuZCBhIGNh
bGwgdG8gdGhlIGxhdHRlciBhZnRlciBhbGwKdGhlIGV4cGxpY2l0X3dyaXRlcy4KClRoZSByZWFz
b24gdGhpcyBpcyBhbiBSRkMgcGF0Y2ggaXMgSSBjYW4ndCBmaW5kIGFueSBpbnN0cnVjdGlvbnMK
d2hlcmUgdGhpcyBkaXN0aW5jdGlvbiBtYWtlcyBhIGRpZmZlcmVuY2UgaW4gY3R4LT5uZWVkX2Nv
bW1pdCB3aGljaApkZXRlcm1pbmVzIGlmIHRoZSBwYWNrZXQgY29tbWl0IGNhbiBiZSBzaG9ydC1j
aXJjdWl0ZWQuICBIb3dldmVyLCB0aGlzCmNvdWxkIGNoYW5nZSBpbiB0aGUgZnV0dXJlIGlmIHRo
ZSBhcmNoaXRlY3R1cmUgaW50cm9kdWNlcyBhbgppbnN0cnVjdGlvbiB3aXRoIGFuIGltcGxpY2l0
IHJlYWQgb2YgYSByZWdpc3RlciB0aGF0IGlzIGFsc28gd3JpdHRlbgooZWl0aGVyIGltcGxpY2l0
IG9yIGV4cGxpY2l0KS4gIFRoZW4sIGFubGF5emVfcGFja2V0IHdvdWxkIGRldGVjdAphIHJlYWQt
YWZ0ZXItd3JpdGUsIGFuZCB0aGUgcGFja2V0IHdvdWxkIG5vdCBzaG9ydC1jaXJjdWl0LiAgVGhl
CmV4ZWN1dGlvbiB3b3VsZCBiZSBjb3JyZWN0LCBidXQgdGhlIHBlcmZvcm1hbmNlIHdvdWxkIG5v
dCBiZSBvcHRpbWFsLgoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KVGVzdGVkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDI1MDMyNTAyMTQ0MC44MTM4Ni0xLWx0YXlsb3JzaW1wc29u
QGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgIHwgMTgg
KysrKysrKysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fYW5hbHl6ZV9mdW5jcy5weSB8
ICA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5jCmluZGV4IGYzMjQwOTUzYjUuLjM3NjJmYWVjNGQgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCkBAIC0zNyw2ICszNywxMCBAQAogI2luY2x1ZGUgImV4ZWMvaGVscGVyLWluZm8uYy5pbmMi
CiAjdW5kZWYgIEhFTFBFUl9ICiAKKy8qIEZvcndhcmQgZGVjbGFyYXRpb25zIHJlZmVyZW5jZWQg
aW4gYW5hbHl6ZV9mdW5jc19nZW5lcmF0ZWQuYy5pbmMgKi8KK3N0YXRpYyB2b2lkIG1hcmtfaW1w
bGljaXRfcmVhZHMoRGlzYXNDb250ZXh0ICpjdHgpOworc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF93cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpOworCiAjaW5jbHVkZSAiYW5hbHl6ZV9mdW5jc19n
ZW5lcmF0ZWQuYy5pbmMiCiAKIHR5cGVkZWYgdm9pZCAoKkFuYWx5emVJbnNuKShEaXNhc0NvbnRl
eHQgKmN0eCk7CkBAIC0zNzcsNiArMzgxLDE3IEBAIHN0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRf
cHJlZF9yZWFkcyhEaXNhc0NvbnRleHQgKmN0eCkKICAgICBtYXJrX2ltcGxpY2l0X3ByZWRfcmVh
ZChjdHgsIEFfSU1QTElDSVRfUkVBRFNfUDMsIDMpOwogfQogCitzdGF0aWMgdm9pZCBtYXJrX2lt
cGxpY2l0X3JlYWRzKERpc2FzQ29udGV4dCAqY3R4KQoreworICAgIG1hcmtfaW1wbGljaXRfcHJl
ZF9yZWFkcyhjdHgpOworfQorCitzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3dyaXRlcyhEaXNh
c0NvbnRleHQgKmN0eCkKK3sKKyAgICBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoY3R4KTsKKyAg
ICBtYXJrX2ltcGxpY2l0X3ByZWRfd3JpdGVzKGN0eCk7Cit9CisKIHN0YXRpYyB2b2lkIGFuYWx5
emVfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogewogICAgIFBhY2tldCAqcGt0ID0gY3R4LT5w
a3Q7CkBAIC0zODgsOSArNDAzLDYgQEAgc3RhdGljIHZvaWQgYW5hbHl6ZV9wYWNrZXQoRGlzYXND
b250ZXh0ICpjdHgpCiAgICAgICAgIGlmIChvcGNvZGVfYW5hbHl6ZVtpbnNuLT5vcGNvZGVdKSB7
CiAgICAgICAgICAgICBvcGNvZGVfYW5hbHl6ZVtpbnNuLT5vcGNvZGVdKGN0eCk7CiAgICAgICAg
IH0KLSAgICAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGVzKGN0eCk7Ci0gICAgICAgIG1hcmtf
aW1wbGljaXRfcHJlZF93cml0ZXMoY3R4KTsKLSAgICAgICAgbWFya19pbXBsaWNpdF9wcmVkX3Jl
YWRzKGN0eCk7CiAgICAgfQogCiAgICAgY3R4LT5uZWVkX2NvbW1pdCA9IG5lZWRfY29tbWl0KGN0
eCk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fYW5hbHl6ZV9mdW5jcy5weSBiL3Rh
cmdldC9oZXhhZ29uL2dlbl9hbmFseXplX2Z1bmNzLnB5CmluZGV4IDNhYzdjYzJjZmUuLmZkZWZk
NWI0YjMgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl9hbmFseXplX2Z1bmNzLnB5Cisr
KyBiL3RhcmdldC9oZXhhZ29uL2dlbl9hbmFseXplX2Z1bmNzLnB5CkBAIC02Nyw2ICs2Nyw4IEBA
IGRlZiBnZW5fYW5hbHl6ZV9mdW5jKGYsIHRhZywgcmVncywgaW1tcyk6CiAgICAgICAgIGlmIHJl
Zy5pc19yZWFkKCk6CiAgICAgICAgICAgICByZWcuYW5hbHl6ZV9yZWFkKGYsIHJlZ25vKQogCisg
ICAgZi53cml0ZSgiICAgIG1hcmtfaW1wbGljaXRfcmVhZHMoY3R4KTtcbiIpCisKICAgICAjIyBB
bmFseXplIHRoZSByZWdpc3RlciB3cml0ZXMKICAgICBmb3IgcmVnbm8sIHJlZ2lzdGVyIGluIGVu
dW1lcmF0ZShyZWdzKToKICAgICAgICAgcmVnX3R5cGUsIHJlZ19pZCA9IHJlZ2lzdGVyCkBAIC03
NCw2ICs3Niw4IEBAIGRlZiBnZW5fYW5hbHl6ZV9mdW5jKGYsIHRhZywgcmVncywgaW1tcyk6CiAg
ICAgICAgIGlmIHJlZy5pc193cml0dGVuKCk6CiAgICAgICAgICAgICByZWcuYW5hbHl6ZV93cml0
ZShmLCB0YWcsIHJlZ25vKQogCisgICAgZi53cml0ZSgiICAgIG1hcmtfaW1wbGljaXRfd3JpdGVz
KGN0eCk7XG4iKQorCiAgICAgZi53cml0ZSgifVxuXG4iKQogCiAKLS0gCjIuMzQuMQoK

