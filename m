Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1EE606A31F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i2y3SVxk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lx13HeZS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxvs-0004jz-Sq; Fri, 30 Oct 2026 21:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvQ-0004fv-Fg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvO-00034j-NB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CL4i758898
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HB+pnBNZz/e6dfCq3e/qIXFx0t/t8gIGpKRfn3mngVg=; b=i2y3SVxkTnx3pvpN
 wO3L+HQxfEh0mHiNlyUgVL4eueAHzZNTVRnwWRH6zc0ihBtOFXkK6aZZQFrp7cjV
 JtM/sUvgAOdPhjBiDbw4iXRuMFLqWlVLAJri9GNKeByr7RcW8qY9jzJcN2+mE3YX
 5YdMseOicMXVdcDtJn9GqpQaUU6IBUL5ZER91qQYjiWYAIK8Tbsp8P858nHoHXIz
 IOMePq7Crxvwch29YZ6UrjDBmHxQqV0iTtkxESGwnfxzPlWvC9Bt9kCuGerOx7g7
 CzD8jhn6Uu6uwnL1ef89WsdUqvpJXSR2QfILqEpUd3e+vPSZMW52f/h5Y13lfC8p
 I54iFQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkg4bf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2360588eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410225; x=1794015025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HB+pnBNZz/e6dfCq3e/qIXFx0t/t8gIGpKRfn3mngVg=;
 b=Lx13HeZSOqI73UgnoRRA9NucYDyIhXnUxuJYbuD6WLuojrqQCgFwpIsJl7V0s15LRx
 +e3Touip8VX+oUFxpUhaB12F4J8zAuK86t0zJcHBi8JQV6qOIwB/sPiPeUlvKm5bOBDD
 isjeFZV+z0qWax4+tyZDCFD/DLBOtpyU24FVDtJGFDIpP6QNuwfI9Kw2+uFf/6FUdxeg
 ZRrGacA/Ko9zOtchpv0x7X3IbljDhP/UPi+86+ZnTXjz0D3SrXl5HKHPufwZOKtCjp7E
 XoR36FIj40hFxa8j8O9uHo99CZInYiMmTc6z2TaCtAtSfwIArmX38w8az573BUFyMYlX
 JpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410225; x=1794015025;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HB+pnBNZz/e6dfCq3e/qIXFx0t/t8gIGpKRfn3mngVg=;
 b=qJLYymfB1Z8xG330tC8779gATpC55OlVRQUZ31QEUj7WIN+1mLFpqW8l8qivN+YX05
 wvZKNxqBdrISN3GmMQ8LkikVpa8L7j+r96W3+SaxW3FHyup2lnju4/ce/c2kpWIJh631
 X83OWnDr+qdiGonolwSq8AmoZIzXtUTi2mSADxRifZEt+hk7yiPIu0aCtRGmwfN3Rw1y
 bRSgYmHwu22+XD/bIq+4A/SBPSYEHI2gogSSmXOza905tM3uTE25cK5Xy9lC+F+cDhPY
 13imEVEDE+0vh1RPdllr9i93Ln9iCPtDu9gLtaFaLuIZYL6AP8VLiywY87Ogo/89KGWl
 EDHg==
X-Gm-Message-State: AFq9FYKHL/Yaa+nPpXmT9ncflwsfSoYt3i+o7fYs58f5TrQorZgTflWQ
 R9GYFFQVyhPlONUOpNAAGuHO05WkJChzWOMFgevQBiEBgX1Zaa2mQ/IjdVq+jz4SN7Y8WJmABLz
 64Kr+fd3Qos11IvyY9jj7JIZvwi2QEioOOqc1epYmg4VyaUvD4KFEpp62PPeMO1x0hw==
X-Gm-Gg: AYBFou3MBvIZMgIm0PkCdotYyKxn4bYLe4pFxDSAP9PeyWcSCN0nsk1vTKcbIxn/fMQ
 sFUgfbpvBLnxzqZjAp5JD63sygo4pvPjzbY5CrADNutCKrSsmSYA96AcMHbCHNrN3CbX5gROPHq
 /m7Xo2IzbcM4qxxzR/i3VoLxKKSW+gBi3KYNjhxtRJWzGAsk1J8eFlcTufNdfKvS2RyjmkaSJUd
 /TR2F+v5L/yjqh6wvD5J439NaP9drrXd3am+uhNubkLeZ8bUENyegsyX1+eyuJqCc18WYa/REnv
 C5yfOkeVWHbCj2UNYtJjp1dqf/Qk3eMisEbSdIweS6lngJm3Y6DMOCtU8Bg86+LmUkoyQ5hMyQ4
 A3ZqPZ6diaWVSSzBOL121fsx/tNGU8aAjmv7Uk1jalQG4hIgzRvsjerAhTAFS3DZc/TGw519tUY
 GnF7ljUh0Hz5u0qxw8AwK5Dg==
X-Received: by 2002:a05:693c:2512:b0:369:fa7c:aee9 with SMTP id
 5a478bee46e88-36a423f54a1mr5391868eec.19.1793410224429; 
 Fri, 30 Oct 2026 18:30:24 -0700 (PDT)
X-Received: by 2002:a05:693c:2512:b0:369:fa7c:aee9 with SMTP id
 5a478bee46e88-36a423f54a1mr5391837eec.19.1793410223657; 
 Fri, 30 Oct 2026 18:30:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 16/40] target/hexagon: generate the opcode translator table
Date: Fri, 30 Oct 2026 18:29:17 -0700
Message-Id: <20261031012941.339141-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: LMEacO3jmRULDhTHhGAffvNEz_FkVMUZ
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae544b1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=orgLYO_NyN7GZF6j3u0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX5THOxxU3dW6y
 Gg36D3qGkE7BriDxV51V1jaK0zlvLfAwNJuYvflLnHYkh4+JtFf3JWk644UwlLiIK0Tlh1P5n2L
 +05rCQtX5Yl8tdudbULVo+0c1P5F1zs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX8QL/c4iVOzLC
 EMkSRNMwi4wSJyxk1X/JXRHPad8vk74AiPqtbZN2IfFxLchaS3uTzCTI3aP+naX/mM1jvnRtZwY
 GBbJohUbV69XeiWEUAzTnKwepc918J4rkuycvvdfiwKJg3sXtlMs09fr8LgJOktKdaNymfKJCuL
 JlzGkEgdx/s/qxTXPIAGBuqGqdVkGppJRkKFb4SKefgEBg7NJ/YbN7TfTPFUabfY3Zp1vjoLBSI
 5UZhf51AztmdLgReIzd9NMzr/YhjfQGBIws5xywwZh256cx643tzJFYfKjVeZheEVf2OgpkXymR
 x2+NLfVHwpjDdm2SXY36nbcSZGSUZUzuVI9sxkLYiG5Cpwm8dzP2tqNStHRrsSYry3kUP81Jzli
 FmXTZIQbjdH+MaMmS9wI1R7uIIE40K2Bir8zkh6lU2iIjpL8xKR3zqHv+p5aOJVnp508kxuwrNN
 aC+qG0e1ErAwO+ew4cA==
X-Proofpoint-ORIG-GUID: LMEacO3jmRULDhTHhGAffvNEz_FkVMUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310005
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkdlbmVy
YXRlIHRoZSBvcGNvZGUgdHJhbnNsYXRvciB0YWJsZSBpbnN0ZWFkIG9mIGxpc3RpbmcgaXQgaW4g
Z2VucHRyLmMuClNraXAgZW1wdHkgdHJhbnNsYXRvcnMgYW5kIGlubGluZSB0aGUgaGVscGVyIHNs
b3QgdmFsdWUuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3Mu
cXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAgICAgIHwgMTUg
Ky0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY190YWJsZS5weSB8IDI5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVu
Y3MucHkgICAgICB8ICA0IC0tLS0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgICAgICAg
ICB8ICAzICsrLQogdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgIHwgMTEgKysr
KysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25z
KC0pCiBjcmVhdGUgbW9kZSAxMDA3NTUgdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jX3RhYmxl
LnB5CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgYi90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYwppbmRleCAxOTYwZjUxMjc2ZS4uYWZhNWI4NzFlODUgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2dlbnB0ci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCkBAIC03
NTcsMTUgKzc1Nyw2IEBAIHZvaWQgZ2VuX3ZmcmFtZWNoZWNrKERpc2FzQ29udGV4dCAqY3R4LCBU
Q0d2IHZzcCkKICAgICB0Y2dfZ2VuX21vdl90bChoZXhfZ3ByW0hFWF9SRUdfVlNQXSwgdnNwKTsK
IH0KIAotI2lmbmRlZiBDT05GSUdfSEVYQUdPTl9JREVGX1BBUlNFUgotc3RhdGljIFRDR3YgZ2Vu
X3Nsb3R2YWwoRGlzYXNDb250ZXh0ICpjdHgpCi17Ci0gICAgaW50IHNsb3R2YWwgPQotICAgICAg
ICAoY3R4LT5wa3QucGt0X2hhc19zY2FsYXJfc3RvcmVfczEgJiAxKSB8IChjdHgtPmluc24tPnNs
b3QgPDwgMSk7Ci0gICAgcmV0dXJuIHRjZ19jb25zdGFudF90bChzbG90dmFsKTsKLX0KLSNlbmRp
ZgotCiB2b2lkIGdlbl9zdG9yZTMyKFRDR3YgdmFkZHIsIFRDR3Ygc3JjLCB1aW50MzJfdCB3aWR0
aCwgdWludDMyX3Qgc2xvdCkKIHsKICAgICB0Y2dfZ2VuX21vdl90bChoZXhfc3RvcmVfYWRkcltz
bG90XSwgdmFkZHIpOwpAQCAtMTg2MCw4ICsxODUxLDQgQEAgdm9pZCBnZW5fYWRkX3NhdF9pNjQo
RGlzYXNDb250ZXh0ICpjdHgsIFRDR3ZfaTY0IHJldCwgVENHdl9pNjQgYSwgVENHdl9pNjQgYikK
IH0KIAogI2luY2x1ZGUgInRjZ19mdW5jc19nZW5lcmF0ZWQuYy5pbmMiCi1jb25zdCBTZW1hbnRp
Y0luc24gb3Bjb2RlX2dlbnB0cltYWF9MQVNUX09QQ09ERV0gPSB7Ci0jZGVmaW5lIE9QQ09ERShY
KSAgICBbWF0gPSBnZW5lcmF0ZV8jI1gKLSNpbmNsdWRlICJvcGNvZGVzX2RlZl9nZW5lcmF0ZWQu
aC5pbmMiCi0jdW5kZWYgT1BDT0RFCi19OworI2luY2x1ZGUgInRjZ19mdW5jX3RhYmxlX2dlbmVy
YXRlZC5jLmluYyIKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY190YWJs
ZS5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY190YWJsZS5weQpuZXcgZmlsZSBtb2Rl
IDEwMDc1NQppbmRleCAwMDAwMDAwMDAwMC4uYmE1NmVkZTU2ODIKLS0tIC9kZXYvbnVsbAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2Z1bmNfdGFibGUucHkKQEAgLTAsMCArMSwyOSBAQAor
IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMworIworIyBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hu
b2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworaW1wb3J0IGhleF9jb21tb24KKworCitkZWYg
bWFpbigpOgorICAgIGFyZ3MgPSBoZXhfY29tbW9uLnBhcnNlX2NvbW1vbl9hcmdzKAorICAgICAg
ICAiRW1pdCB0aGUgdGFibGUgb2YgaW5zdHJ1Y3Rpb24gdHJhbnNsYXRpb24gZnVuY3Rpb25zIgor
ICAgICkKKworICAgIHdpdGggb3BlbihhcmdzLm91dCwgInciKSBhcyBmOgorICAgICAgICBmLndy
aXRlKCIjaWZuZGVmIEhFWEFHT05fRlVOQ19UQUJMRV9IXG4iKQorICAgICAgICBmLndyaXRlKCIj
ZGVmaW5lIEhFWEFHT05fRlVOQ19UQUJMRV9IXG5cbiIpCisgICAgICAgIGYud3JpdGUoImNvbnN0
IFNlbWFudGljSW5zbiBvcGNvZGVfZ2VucHRyW1hYX0xBU1RfT1BDT0RFXSA9IHtcbiIpCisKKyAg
ICAgICAgZm9yIHRhZyBpbiBoZXhfY29tbW9uLnRhZ3M6CisgICAgICAgICAgICBpZiBoZXhfY29t
bW9uLnRhZ19pZ25vcmUodGFnKToKKyAgICAgICAgICAgICAgICBjb250aW51ZQorICAgICAgICAg
ICAgZi53cml0ZShmIiAgICBbe3RhZ31dID0gZ2VuZXJhdGVfe3RhZ30sXG4iKQorCisgICAgICAg
IGYud3JpdGUoIn07XG5cbiIpCisgICAgICAgIGYud3JpdGUoIiNlbmRpZiAgICAvKiBIRVhBR09O
X0ZVTkNfVEFCTEVfSCAqL1xuIikKKworCitpZiBfX25hbWVfXyA9PSAiX19tYWluX18iOgorICAg
IG1haW4oKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weSBiL3Rh
cmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkKaW5kZXggNjFlZmZhMzhjZmEuLjQzMDVlZGE5
OTZiIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2Z1bmNzLnB5CisrKyBiL3Rh
cmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkKQEAgLTE3MywxMSArMTczLDcgQEAgZGVmIG1h
aW4oKToKIAogICAgICAgICBmb3IgdGFnIGluIGhleF9jb21tb24udGFnczoKICAgICAgICAgICAg
IGlmIGhleF9jb21tb24udGFnX2lnbm9yZSh0YWcpOgotICAgICAgICAgICAgICAgIGYud3JpdGUo
ZiJzdGF0aWMgdm9pZCBnZW5lcmF0ZV97dGFnfSIKLSAgICAgICAgICAgICAgICAgICAgICAgIGYi
KERpc2FzQ29udGV4dCAqY3R4KVxuIikKLSAgICAgICAgICAgICAgICBmLndyaXRlKCJ7XG59XG5c
biIpCiAgICAgICAgICAgICAgICAgY29udGludWUKLQogICAgICAgICAgICAgZ2VuX2RlZl90Y2df
ZnVuYyhmLCB0YWcsIHRhZ3JlZ3MsIHRhZ2ltbXMpCiAKICAgICAgICAgZi53cml0ZSgiI2VuZGlm
ICAgIC8qIEhFWEFHT05fVENHX0ZVTkNTX0ggKi9cbiIpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCAw
Yzc4YjQwNDRlZi4uNDc0OWQzZThhODggMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9j
b21tb24ucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMTUyMCw3ICsx
NTIwLDggQEAgZGVmIGhlbHBlcl9hcmdzKHRhZywgcmVncywgaW1tcyk6CiAgICAgaWYgbmVlZF9z
bG90KHRhZyk6CiAgICAgICAgIGFyZ3MuYXBwZW5kKEhlbHBlckFyZygKICAgICAgICAgICAgICJp
MzIiLAotICAgICAgICAgICAgImdlbl9zbG90dmFsKGN0eCkiLAorICAgICAgICAgICAgInRjZ19j
b25zdGFudF9pMzIoKGN0eC0+cGt0LnBrdF9oYXNfc2NhbGFyX3N0b3JlX3MxICYgMSkgfCAiCisg
ICAgICAgICAgICAiKGN0eC0+aW5zbi0+c2xvdCA8PCAxKSkiLAogICAgICAgICAgICAgInVpbnQz
Ml90IHNsb3R2YWwiCiAgICAgICAgICkpCiAgICAgaWYgbmVlZF9wYXJ0MSh0YWcpOgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5i
dWlsZAppbmRleCAwNjMzODUyMzIxNy4uNDI5MzE3YTY1ODYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC00
MiwxMCArNDIsMjEgQEAgaGV4YWdvbl9zcy5hZGQoc2VtYW50aWNzX2dlbmVyYXRlZCkKICMKICMg
U3RlcCAyCiAjIFdlIHVzZSBQeXRob24gc2NyaXB0cyB0byBnZW5lcmF0ZSB0aGUgZm9sbG93aW5n
IGZpbGVzCisjICAgICB0Y2dfZnVuY190YWJsZV9nZW5lcmF0ZWQuYy5pbmMKICMgICAgIHByaW50
aW5zbl9nZW5lcmF0ZWQuaC5pbmMKICMgICAgIG9wX2F0dHJpYnNfZ2VuZXJhdGVkLmguaW5jCiAj
ICAgICBvcGNvZGVzX2RlZl9nZW5lcmF0ZWQuaC5pbmMKICMKK3RjZ19mdW5jX3RhYmxlX2dlbmVy
YXRlZCA9IGN1c3RvbV90YXJnZXQoCisgICAgJ3RjZ19mdW5jX3RhYmxlX2dlbmVyYXRlZC5jLmlu
YycsCisgICAgb3V0cHV0OiAndGNnX2Z1bmNfdGFibGVfZ2VuZXJhdGVkLmMuaW5jJywKKyAgICBk
ZXBlbmRzOiBbc2VtYW50aWNzX2dlbmVyYXRlZF0sCisgICAgZGVwZW5kX2ZpbGVzOiBbaGV4X2Nv
bW1vbl9weSwgZ2VuX3RjZ19oLCBnZW5fdGNnX2h2eF9oLCBnZW5fdGNnX3N5c19oXSwKKyAgICBj
b21tYW5kOiBbcHl0aG9uLCBmaWxlcygnZ2VuX3RjZ19mdW5jX3RhYmxlLnB5JyksIHNlbWFudGlj
c19nZW5lcmF0ZWQsCisgICAgICAgICAgICAgIGdlbl90Y2dfaCwgZ2VuX3RjZ19odnhfaCwgZ2Vu
X3RjZ19zeXNfaCwgJ0BPVVRQVVRAJ10sCispCitoZXhhZ29uX3NzLmFkZCh0Y2dfZnVuY190YWJs
ZV9nZW5lcmF0ZWQpCisKIHByaW50aW5zbl9nZW5lcmF0ZWQgPSBjdXN0b21fdGFyZ2V0KAogICAg
ICdwcmludGluc25fZ2VuZXJhdGVkLmguaW5jJywKICAgICBvdXRwdXQ6ICdwcmludGluc25fZ2Vu
ZXJhdGVkLmguaW5jJywKLS0gCjIuMzQuMQoK

