Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC708606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n8Amt1Ev;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fdwihENr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZ9Z-00023U-Dg; Thu, 29 Oct 2026 19:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9X-000238-KV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9V-0004D2-OA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLZciQ1348869
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kyu8gMfAJ25U5v/Hx8y5wqo2Q3wLMF9g9UnpxSEpbNg=; b=n8Amt1EvAVmP1Ra2
 d12NiPvx20lnFIeg3Pn88ypkyW3+RsqtN615aReF7eil03DmzgLV2IfM0K4Ygw5h
 tjoOkUl7zgjQ5Qo8Vt25tpp6C4VW12gya+ZJvIOnNWJdwFTRk5oDvPTD0YcPt49n
 7RxrUyzWe15RvVo4FizXi4l26o9ZWjbU8cULjnX6aawKzLXTwm+ShXb0XlnLGEzp
 DmGZUGYObQBkJ/LDajFKG9Mhd6F4A3LADnsVKKXlDW7XeaS2yBUCDJxvxnpz7r33
 00mMy9fkveW4OB+JVNuJtutphxMu0KAZEszWovzZQNOUBjfV15b7NxUXei7gHDiF
 MYjKWQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qg8ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:20 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so170001c88.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793315000; x=1793919800; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kyu8gMfAJ25U5v/Hx8y5wqo2Q3wLMF9g9UnpxSEpbNg=;
 b=fdwihENrzowCDIH35YVFt3oKnMqNlK0bwnr/Un0uCRT855u2lM67NC4Qp1gQujY45x
 Klti5gVV8VP345Gho1oJim107SLgugLo79TRbUcQHDYIogSBpvVy5fVl1xaZJu8jNO5d
 Cz08DFQjYlTw7tGTC1gcgP+ouMaD07V7HsuekuvOpgffnTkrjUpHQTZeRyK2NnGLrdJu
 otMiAceiYHz49kfSFiU6Wo3AT3kmLvRLbQzvibjb78c5EkQYbujfzMUOLWmurNgbEz2w
 Yx1sEjDbEmjzAZNyb16fTml6d6AOsOkWVPKFYhN0cdZHtI0qwIJqWPVZbR7CmNNp3FiE
 m0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793315000; x=1793919800;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kyu8gMfAJ25U5v/Hx8y5wqo2Q3wLMF9g9UnpxSEpbNg=;
 b=kO///Z6cPWquepI3TqdIgEk14FFIVsOtKdYiOiF3pQ4w/S0BhXjel5QbTpSJMHtrUw
 GmVZgiJaNgn/dYEkTJlcJfHkxKhHc3O7oWIPow+EfxENs+zQNJvxiV7hX4mTQwPhZwtL
 Si2LgnsVLXye6JnSwXWiDf8LXadiAy/2PsKBEo3SPnaX6ceWhlDzYsWas8xv5+4YhyMU
 /hd588sLonNBWYgQ0S6mVe7V8YpgEziAzidyl3CENKkH2D4JGSqBvHxWqOikE4HSAHM1
 P+FG0Mh9kazmn+zOZX1tSK1s3w5o3NxQXIGcxx0h1xna0cEZjwo3rVGqMJeR92ARSKrq
 gFIQ==
X-Gm-Message-State: AFq9FYK1iyQ+5GUeEIAd2NKN1PBPLxsOVWz7KRB2gVk/4yphYyRZoJaJ
 XmTrIWYSV59wIg/kBeUDfd0+WQEkwWO+BFGeOvyjHAPn12cqv95b+45q9LNR4F41bSBdPvU/aSo
 b+Kh7RDRrIcIuYyWzL+/nyOqdXlWqle7SpV5DUhHHDP+Cf+hIFCL9MO892Cckh9yftw==
X-Gm-Gg: AYBFou0vyXVsUL+6lh9cypaGGDl9vIwkwy97VMIEcDUDEWheOYZ+RHypxu44xaYvQaX
 pkhv0jTV3+SM2cyVnKvS87X/OvaL4b3vtrFLVrtRLpWRjsQBg0w0GfHsRQCC7r1vUxOE1RrNWdJ
 p/Cm6xrsJxJcPjGR9H0vBi1ek6PEdG87dmddeNBosSdqGcmjiP8DA+dC3scZNFlLpASiBB7NY80
 lPC3UOuW4rFqKMuE8MIlZB+BIpvGHLZTXI7jvEL49R/9IRn03vVDhlmJeOOeSSCio4SRQSsnJD+
 UcQQj9zrVmArbROMDmuL+ZV6GzTuh+QZDW2OZVbazpJHiAew9XFLUtzMsKN2m+iTjtUsshdi2dr
 pz5KV4X+pLhVSGxsyY+cmzkE+9AjosXuBBcfEOJERqTtPV3Zn5r/UiYklOWBU+e/AMbo53wqnHA
 F1v30Gru7KmbZkCidzY5gj
X-Received: by 2002:a05:701b:42d1:10b0:13d:974:a2c6 with SMTP id
 a92af1059eb24-1ac5b028978mr697736c88.7.1793314999381; 
 Thu, 29 Oct 2026 16:03:19 -0700 (PDT)
X-Received: by 2002:a05:701b:42d1:10b0:13d:974:a2c6 with SMTP id
 a92af1059eb24-1ac5b028978mr697667c88.7.1793314998589; 
 Thu, 29 Oct 2026 16:03:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm2034887c88.11.2026.10.29.16.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 16:03:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 3/8] target/hexagon: add per-CPU HMX configuration
Date: Thu, 29 Oct 2026 16:03:05 -0700
Message-Id: <20261029230310.1632334-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: K7dbNlyWfIKrwOr2BeVW0UV4bgJ6dIG7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfXxyzhg+EjjsE6
 Yn0uyuTRFzhav7or/Fgmka6FiNW7Af+wqyxE3QdwEZfcLKu7TjC1868eB2eMJt4rNLWASnFLqzE
 xAe2vycjR11DseUynvDfrh77+DpOQ+o=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae3d0b8 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yL6o_P92Z4u-jk1Vq6wA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: K7dbNlyWfIKrwOr2BeVW0UV4bgJ6dIG7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfXwi1lwonu4zn6
 L1wH5OzxpLxVvvbXFCAgFNQ93yFSkmAPI2/NthFI6iHtyna3UckDjg5ovLufqQ8BjQGnLwjb5Ra
 hmqO97tHabApbyCERVTWkr1hRZ/6hs/po0l2nY8jhAjGvqQ/+C3F/f4+TeF6DAFVe+RQqMMIBza
 3ADvOWfNGTYJ5BS4mZE3wFv40B2n//iadNXJjlZSs3tm9fp1k1MojGEto/YEbTFg9LOsT0OQ506
 J9zwjJGtmCL+lOSmpehkzPddIpP5W1QqWKuPclabfmfWXH+ITbPyiO3hRTW5z793AE7a1gAiWwg
 3umcN1e4LEN06eVydMnbWazuKD72JopbsvDKTdAYpx1/2CnkY2XCh/UCyQe8YhFzyyROI/RK1Ad
 6cepa1uAMj3BZOTVqE0ppJEgHPEWEpTUrXfkAKf55NAvAF/+OgYO/gvYT5mQyk3bxet5JSBZp8Y
 wVkSq+n4L6ZvPIBTJEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

QWRkIEhteENvbmZpZyBhbmQgaG14X2luaXRfY29uZmlnKCksIHdoaWNoIGRlcml2ZSB0aGUgSE1Y
IGNvbmZpZ3VyYXRpb24KZnJvbSB0aGUgQ1BVIHJldmlzaW9uLgoKU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L2NwdS5oICAgICAgICB8ICA4ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9obXhfY29uZmlnLmgg
fCAxNyArKysrKysrKysrKysrKysrKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgIHwgIDcg
KysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgIHwgMjMgKysrKysrKysrKysrKysr
KysrKysrKysKIHRhcmdldC9oZXhhZ29uL2hteF9jb25maWcuYyB8IDE1ICsrKysrKysrKysrKysr
KwogdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgIHwgIDEgKwogNiBmaWxlcyBjaGFuZ2VkLCA3
MSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaG14X2Nv
bmZpZy5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5jCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaApp
bmRleCBmZWI4MDM2ODIzOC4uMjJhYTE2MzA3NjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0zMCwxMiArMzAsMTUgQEAKIHR5
cGVkZWYgc3RydWN0IEhleGFnb25UTEJTdGF0ZSBIZXhhZ29uVExCU3RhdGU7CiB0eXBlZGVmIHN0
cnVjdCBIZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogdHlwZWRl
ZiBzdHJ1Y3QgSGV4YWdvbkhWWENvbnRleHRTdGF0ZSBIZXhhZ29uSFZYQ29udGV4dFN0YXRlOwor
dHlwZWRlZiBzdHJ1Y3QgSGV4YWdvbkhNWENvbnRleHRTdGF0ZSBIZXhhZ29uSE1YQ29udGV4dFN0
YXRlOwogCiAjaW5jbHVkZSAiY3B1LXFvbS5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWNvbW1vbi5o
IgogI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X2xvbmcuaCIKICNpbmNsdWRlICJoZXhfcmVncy5oIgog
I2luY2x1ZGUgIm1tdmVjL21tdmVjLmgiCisjaW5jbHVkZSAiaG14X2NvbmZpZy5oIgorI2luY2x1
ZGUgImhteF9zdGF0ZS5oIgogI2luY2x1ZGUgImh3L2NvcmUvcmVnaXN0ZXJmaWVsZHMuaCIKICNp
bmNsdWRlICJxZW11L2JpdG1hcC5oIgogCkBAIC0xOTcsNiArMjAwLDggQEAgdHlwZWRlZiBzdHJ1
Y3QgQ1BVQXJjaFN0YXRlIHsKICAgICB0YXJnZXRfdWxvbmcgdnN0b3JlX3BlbmRpbmdbVlNUT1JF
U19NQVhdOwogICAgIGJvb2wgdnRjbV9wZW5kaW5nOwogICAgIFZUQ01TdG9yZUxvZyB2dGNtX2xv
ZzsKKworICAgIEhteFN0YXRlICpobXhfc3RhdGU7CiB9IENQVUhleGFnb25TdGF0ZTsKIAogdHlw
ZWRlZiBzdHJ1Y3QgSGV4YWdvbkNQVUNsYXNzIHsKQEAgLTIxNywxMiArMjIyLDE1IEBAIHN0cnVj
dCBBcmNoQ1BVIHsKICAgICBIZXhhZ29uQ1BVQ29uZmlnIGNmZzsKICNpZm5kZWYgQ09ORklHX1VT
RVJfT05MWQogICAgIEhleGFnb25IVlhDb250ZXh0U3RhdGUgKmh2eF9jdHhbSFZYX0NPTlRFWFRT
X01BWF07CisgICAgSGV4YWdvbkhNWENvbnRleHRTdGF0ZSAqaG14X2N0eDsKICAgICBIZXhhZ29u
VExCU3RhdGUgKnRsYjsKICAgICB1aW50MzJfdCBib290X2FkZHI7CiAgICAgSGV4YWdvbkdsb2Jh
bFJlZ1N0YXRlICpnbG9iYWxyZWdzOwogICAgIHVpbnQzMl90IGh0aWQ7CiAgICAgSGV4TDJWaWNJ
bnRlcmZhY2UgKmwydmljOwogI2VuZGlmCisgICAgSG14U3RhdGUgKmhteDsKKyAgICBIbXhDb25m
aWcgaG14X2NmZzsKIH07CiAKIHN0YXRpYyBpbmxpbmUgSGV4YWdvbkhWWENvbnRleHQgKmhleF9o
dngoQ1BVSGV4YWdvblN0YXRlICplbnYpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9obXhf
Y29uZmlnLmggYi90YXJnZXQvaGV4YWdvbi9obXhfY29uZmlnLmgKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMDAuLmNiMTQzM2Y1NGI4Ci0tLSAvZGV2L251bGwKKysrIGIvdGFy
Z2V0L2hleGFnb24vaG14X2NvbmZpZy5oCkBAIC0wLDAgKzEsMTcgQEAKKy8qCisgKiBDb3B5cmln
aHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmll
cy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKwor
I2lmbmRlZiBIRVhBR09OX0hNWF9DT05GSUdfSAorI2RlZmluZSBIRVhBR09OX0hNWF9DT05GSUdf
SAorCisjaW5jbHVkZSAiY3B1LXFvbS5oIgorCit0eXBlZGVmIHN0cnVjdCBIbXhDb25maWcgewor
ICAgIGJvb2wgaG14X3ByZXNlbnQ7Cit9IEhteENvbmZpZzsKKwordm9pZCBobXhfaW5pdF9jb25m
aWcoSGV4YWdvbkNQVSAqY3B1KTsKKworI2VuZGlmIC8qIEhFWEFHT05fSE1YX0NPTkZJR19IICov
CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYyBiL2h3L2hleGFnb24vaGV4LXN1
YnN5cy5jCmluZGV4IDRkOWE3OWNmZjc0Li41ZDIyN2MwZGIyYiAxMDA2NDQKLS0tIGEvaHcvaGV4
YWdvbi9oZXgtc3Vic3lzLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKQEAgLTE4Nyw2
ICsxODcsOCBAQCB2b2lkIGhleF9zdWJzeXNfY3JlYXRlKEhleGFnb25Db21tb25NYWNoaW5lU3Rh
dGUgKmhtcywKIAogdm9pZCBoZXhfc3Vic3lzX2FkZF9jcHUoSGV4YWdvbkNvbW1vbk1hY2hpbmVT
dGF0ZSAqaG1zLCBEZXZpY2VTdGF0ZSAqY3B1KQogeworICAgIE9iamVjdCAqaG14OworCiAgICAg
b2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChPQkpFQ1QoaG1zLT5jbHVzdGVyKSwgImNwdVsqXSIs
IE9CSkVDVChjcHUpKTsKICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNUKGNwdSks
ICJnbG9iYWwtcmVncyIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVChobXMt
Pmdsb2JfcmVncyksICZlcnJvcl9mYXRhbCk7CkBAIC0yMDAsNiArMjAyLDExIEBAIHZvaWQgaGV4
X3N1YnN5c19hZGRfY3B1KEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgKmhtcywgRGV2aWNlU3Rh
dGUgKmNwdSkKIAogICAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNUKGNwdSks
IG5hbWUsIGN0eCwgJmVycm9yX2ZhdGFsKTsKICAgICB9CisgICAgaG14ID0gb2JqZWN0X3Jlc29s
dmVfcGF0aF9jb21wb25lbnQoT0JKRUNUKGhtcyksICJobXgtY29udGV4dCIpOworICAgIGlmICho
bXgpIHsKKyAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChjcHUpLCAiaG14
LWNvbnRleHQiLCBobXgsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3Jf
ZmF0YWwpOworICAgIH0KIH0KIAogdm9pZCBoZXhfc3Vic3lzX3JlYWxpemVfY2x1c3RlcihIZXhh
Z29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDI4MWQyMDEyNTBiLi44M2UyMzc3NWVh
MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTQ1LDYgKzQ1LDcgQEAKICNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCiAj
aW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5oIgogI2luY2x1ZGUgImh3L2hl
eGFnb24vaGV4YWdvbl9odnhfY29udGV4dC5oIgorI2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdv
bl9obXhfY29udGV4dC5oIgogI2VuZGlmCiAKIHN0YXRpYyBPYmplY3RDbGFzcyAqaGV4YWdvbl9j
cHVfY2xhc3NfYnlfbmFtZShjb25zdCBjaGFyICpjcHVfbW9kZWwpCkBAIC01MzksNiArNTQwLDI0
IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJy
b3IgKiplcnJwKQogCiAgICAgY3B1LT5jZmcuaGV4X2RlZiA9IG1jYy0+aGV4X2RlZjsKIAorICAg
IGhteF9pbml0X2NvbmZpZyhjcHUpOworI2lmZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICAvKiBB
bGwgdGhyZWFkcyBvZiB0aGUgcHJvY2VzcyBzaGFyZSBvbmUgSE1YIHVuaXQgKi8KKyAgICBzdGF0
aWMgSG14U3RhdGUgKnVzZXJfaG14OworCisgICAgaWYgKGNwdS0+aG14X2NmZy5obXhfcHJlc2Vu
dCkgeworICAgICAgICBpZiAoIXVzZXJfaG14KSB7CisgICAgICAgICAgICB1c2VyX2hteCA9IGdf
bmV3MChIbXhTdGF0ZSwgMSk7CisgICAgICAgIH0KKyAgICAgICAgY3B1LT5obXggPSB1c2VyX2ht
eDsKKyAgICB9CisjZWxzZQorICAgIGlmIChjcHUtPmhteF9jdHggJiYgY3B1LT5obXhfY2ZnLmht
eF9wcmVzZW50KSB7CisgICAgICAgIGNwdS0+aG14ID0gJmNwdS0+aG14X2N0eC0+cmVnczsKKyAg
ICB9CisjZW5kaWYKKyAgICBjcHVfZW52KGNzKS0+aG14X3N0YXRlID0gY3B1LT5obXg7CisKICAg
ICBnZGJfcmVnaXN0ZXJfY29wcm9jZXNzb3IoY3MsIGhleGFnb25faHZ4X2dkYl9yZWFkX3JlZ2lz
dGVyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZXhhZ29uX2h2eF9nZGJfd3JpdGVf
cmVnaXN0ZXIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdkYl9maW5kX3N0YXRpY19m
ZWF0dXJlKCJoZXhhZ29uLWh2eC54bWwiKSk7CkBAIC02MjksNiArNjQ4LDEwIEBAIHN0YXRpYyB2
b2lkIGhleGFnb25fY3B1X2luaXQoT2JqZWN0ICpvYmopCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBxZGV2X3Byb3BfYWxsb3dfc2V0X2xpbmtfYmVmb3JlX3JlYWxpemUsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpfUFJPUF9MSU5LX1NUUk9ORyk7CiAgICAg
fQorICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfbGluayhvYmosICJobXgtY29udGV4dCIsIFRZUEVf
SEVYQUdPTl9ITVhfQ09OVEVYVCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKE9iamVj
dCAqKikmY3B1LT5obXhfY3R4LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxZGV2X3By
b3BfYWxsb3dfc2V0X2xpbmtfYmVmb3JlX3JlYWxpemUsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE9CSl9QUk9QX0xJTktfU1RST05HKTsKICNlbmRpZgogfQogCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9obXhfY29uZmlnLmMgYi90YXJnZXQvaGV4YWdvbi9obXhfY29uZmlnLmMK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjExYjNhYmFkZmJjCi0tLSAv
ZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5jCkBAIC0wLDAgKzEsMTUg
QEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQv
b3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJjcHUu
aCIKKyNpbmNsdWRlICJobXhfY29uZmlnLmgiCisKK3ZvaWQgaG14X2luaXRfY29uZmlnKEhleGFn
b25DUFUgKmNwdSkKK3sKKyAgICBIZXhhZ29uVmVyc2lvbiB2ZXIgPSBjcHUtPmNmZy5oZXhfZGVm
LT5oZXhfdmVyc2lvbjsKKworICAgIGNwdS0+aG14X2NmZy5obXhfcHJlc2VudCA9IHZlciA+PSBI
RVhfVkVSX1Y3NTsKK30KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkIGIv
dGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggMDYzMzg1MjMyMTcuLmZlMzIwNmVmOGI4
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAorKysgYi90YXJnZXQvaGV4
YWdvbi9tZXNvbi5idWlsZApAQCAtMjU0LDYgKzI1NCw3IEBAIGhleGFnb25fc3MuYWRkKGZpbGVz
KAogICAgICdtbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMnLAogICAgICdtbXZlYy9odnhfaWVlZV9m
cC5jJywKICAgICAnbW12ZWMvaHZ4X3FmbG9hdC5jJywKKyAgICAnaG14X2NvbmZpZy5jJywKICkp
CiAKIGhleGFnb25fc29mdG1tdV9zcy5hZGQoZmlsZXMoCi0tIAoyLjM0LjEKCg==

