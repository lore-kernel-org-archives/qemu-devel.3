Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B0ECDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbncv-0002qP-0S; Mon, 22 Jun 2026 19:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncs-0002pF-Fh
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncq-0002Qm-GL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJautD2205265
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=; b=ZeTPaAzT6LcIxxDT
 E9jXuc+op0WMzZl7aF78VtXGG7LbMtCm6uX4m8J1fMhWWYKXsTWsatlKmLRVGp/r
 59XT8/2UH+DJLB+xCXhFZ8vnKy/NDXYClJ7LApnIxwhG+eCQY1XG6dQ7fr3iJeb3
 6PbRehxVIkODxp5Fp03SWrGdggsIIyDK2VROLhA3fQV/P1SU04V7DqWl/J1Gfjkb
 iHu/J934QaIGv7bspDK1Q8sJgzhtckpk5YBhIXLTOAbyJEX+UQeP+CmnWU5goiFK
 hGOYxiG1Gsm4V129bGKdd4r7cILfMQq+g7ZDU9nSzRuEMHdMKfEefr3wO8Guy+H8
 uXPyCw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmsrf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:19 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso5230236c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169218; x=1782774018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=JypoZpjLIWtg3Bw0Bk25vcfR8QyLBWxUtUtolnoCS/roqGQ9DICVrkjL2Qs9EcL9Oj
 nVA4jFjMuAPSFnOIv58jCqg+Oks/RRS2wp4Jid3SLmGx3IQlKnx8bdI2OQlquVigiPp/
 v4CXAca+5WI99SmOk+LO9JiKrsH+KbIg3CjjGW+Td0WlMJXRQq4SYrsRfEnQiWGQ4sLh
 8kpk4sZeS24Q9YE8QVT1YQFHZaH4nB0w2M7DQVmYgrojWzDMJuNv8IHpkS+Lknh0DCUA
 ER8wSZQBbtNsQeEMkX4jQJ1EKXjiGpEtvLAWFEzsDJrmLPZ2gKLiOXJIoP/hnLVraPij
 8PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169218; x=1782774018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=KREA+vOqDQKIXhzQAkdSUXuXH/H/vB+EPKtfC6VWHT7iXHfxVL8Yl6VPbr88L3D/PB
 Sc978TmS7Ks3AYX1Y+5kZd/evQh4HH4wXHQ/h87SwhSQELEUGyHmh6VwTwjXRQUeaz85
 NsLoihi3rFx7ovuNO462PVEOrMxyEGPVhZp+olNENyy32Zj4o54TthneqQ+MUE6SnHC+
 r1KSZ2j1XljAeMbypxNBmxm/dEG0rh+Q6XsJsIH282YDN0pGKOzT7ATCoaXZ2YNdcFVl
 wJNOdp+/syjibhDMpQ8LR/+10TetHybmlqRNye25H0fMjGzlUn7xyxrK4a5ggogWd7Yn
 t7zg==
X-Gm-Message-State: AOJu0Yyi9+QO5pjDeUXhrVuK+sAR9gjFvKDhJoMiDnLJRyucmSSXB551
 6L9tVnrswxxDgX+BirbC+xTEsOhGqrzbdmZ51YN2FqtO3iVCatGajsSRR0hZkBDo5fZLfDDooja
 Pj9ubijqwTmukr7HlEUeyfc4G6kkPKWIdGsW+VqXQq+pdvQ3UnxaEJS9dafiYfqWp3Q==
X-Gm-Gg: AfdE7ckF/Zmwq7Oih0uiPIR/WpuX5cqotaQeBq6mHiEJt2EdFo7b0/UF5PyjwAtWBIP
 tvH8jBkjR7bqIY3/89zWOqx8T3w+VkAXube237+MDKwnSyB2iDCGDmTc6Z2w9BCT7g/PKHyaTyl
 /M+6cAL3aJQK0UXWwz1+UIPG2Ndda0WlGH98gPZftPTWDLesS7pMEnAUeMPFI9ntoM81SyYcMAY
 84+Dhpn5kTVkFAzKcDn9VmJ1FrZUH98klfbZEw9MVOGeSq7ifrHG1G8M13RW24jFKs/q28HzapI
 zDUR7EzIyxGFnl3FVma4+j5WCsFek0ZfhK1db3DfAtxZ+qASlKRZ8W7ArHVyTv9Mz1QbvcPL4Jy
 hTVbr3Ttc7/W5G3q2a0lpWa/pZqtnTffLzodgoBB2wSrlNy8nlyLpyX4RGTA=
X-Received: by 2002:a05:7022:6b86:b0:138:3e8:cee1 with SMTP id
 a92af1059eb24-139a365c7b5mr9268458c88.23.1782169218435; 
 Mon, 22 Jun 2026 16:00:18 -0700 (PDT)
X-Received: by 2002:a05:7022:6b86:b0:138:3e8:cee1 with SMTP id
 a92af1059eb24-139a365c7b5mr9268429c88.23.1782169217713; 
 Mon, 22 Jun 2026 16:00:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 47/75] target/hexagon: Implement exec_interrupt, set_irq
Date: Mon, 22 Jun 2026 15:28:36 -0700
Message-Id: <20260622222904.607771-48-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX2G1YdvVG4a3a
 uThPhd0ryC3Af+2kE9LQV02TEbD2BCHbNf8WWyC9g/oCris25eNDjMwq1n0Umomiq40R9ltnzOU
 SXg/pLyJXvXl8RlWB7r6jsDwJJdV7c0=
X-Proofpoint-GUID: HiMonCZTTEGBirETpsg4ugRINvADCCQb
X-Proofpoint-ORIG-GUID: HiMonCZTTEGBirETpsg4ugRINvADCCQb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX0imGOC3e7C5J
 qji2mG9kmZIFtU/VCcElJiXD6McV6bYcWWDRup6NFvzMa8gX3ZOqREQQGx+7yho8Jl7VvqBnJ35
 eZHK3gyRm1TZeer9Whz5dLkPgv9XzgMY4E/lKhH/orRbBg1IrMlHdbORji3FwnWFloLevM31rQa
 wVQIp+hc7mpKKc+uTajUpsDs7oJdCOkr8uV6D5NrCK4kHATx/yFZOicoTs9FTrDEEpOaPXUOYKh
 RsW7rm0E6b55Gn6Z/ZbvZqVLRk8xk0VwfbE4TNGA7VkclGNUErWICsHAxjmI+RJ5dcoGfY20ZkX
 Bo/IYHMhUI3SRTmuP2flon8K7yugW/Tf+ilJwRRrRxzhSLhKQWkbXg+628zURLT8V8M3sOgGdsX
 h3VY1fqHt5CZrD+r+GjAxpP+NzqcWTxP50+V9NalOZo8d0gSYiZX1TkTU8Hnly+6dYev0rFIwK+
 zOlV0xPLM0zVrDwaxnw==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a39be83 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GA9jbsKyPMLDJDmtv64A:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgODQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBlYzBjYTNlZTY3OC4uMGQ2NTUx
ZGQ1YjYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdS5jCkBAIC0xNiw2ICsxNiw3IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCIKKyNpbmNsdWRlICJxZW11L2xvZy5oIgogI2luY2x1ZGUgInFlbXUvcWVtdS1wcmludC5oIgog
I2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImludGVybmFsLmgiCkBAIC0zMSwxMCArMzIsMTIg
QEAKICNpbmNsdWRlICJoZXhfbW11LmgiCiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2lu
Y2x1ZGUgIm1hY3Jvcy5oIgogI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRlICJhY2Nl
bC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjZW5k
aWYKIAogc3RhdGljIE9iamVjdENsYXNzICpoZXhhZ29uX2NwdV9jbGFzc19ieV9uYW1lKGNvbnN0
IGNoYXIgKmNwdV9tb2RlbCkKQEAgLTMwNCw2ICszMDcsMzYgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfc3luY2hyb25pemVfZnJvbV90YihDUFVTdGF0ZSAqY3MsCiAgICAgY3B1X2Vudihjcykt
PmdwcltIRVhfUkVHX1BDXSA9IHRiLT5wYzsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
Citib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7
CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICB1aW50MzJfdCBt
b2RlY3RsOworICAgIHVpbnQzMl90IHRocmVhZF9lbmFibGVkX21hc2s7CisgICAgYm9vbCBFX2Jp
dDsKKworICAgIGlmICghY3B1LT5nbG9iYWxyZWdzKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKyAgICBtb2RlY3RsID0KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUt
Pmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVM
RChNT0RFQ1RMX0UsIG1vZGVjdGwpOworICAgIEVfYml0ID0gdGhyZWFkX2VuYWJsZWRfbWFzayAm
ICgweDEgPDwgZW52LT50aHJlYWRJZCk7CisKKyAgICByZXR1cm4gRV9iaXQ7Cit9CisKK3N0YXRp
YyBib29sIGhleGFnb25fY3B1X2hhc193b3JrKENQVVN0YXRlICpjcykKK3sKKyAgICBDUFVIZXhh
Z29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisgICAgcmV0dXJuIGhleGFnb25fdGhyZWFk
X2lzX2VuYWJsZWQoZW52KSAmJgorICAgICAgICAoY3MtPmludGVycnVwdF9yZXF1ZXN0ICYgKENQ
VV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJCisgICAgICAgICAgICB8IENQVV9J
TlRFUlJVUFRfSzBfVU5MT0NLIHwgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKSk7Cit9CisjZW5k
aWYKKwogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN0b3JlX3N0YXRlX3RvX29wYyhDUFVTdGF0ZSAq
Y3MsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFRyYW5z
bGF0aW9uQmxvY2sgKnRiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCB1aW50NjRfdCAqZGF0YSkKQEAgLTQxMiwxMCArNDQ1LDU4IEBAIHN0YXRpYyBpbnQg
aGV4YWdvbl9jcHVfbW11X2luZGV4KENQVVN0YXRlICpjcywgYm9vbCBpZmV0Y2gpCiAgICAgcmV0
dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMg
dm9pZCBoZXhhZ29uX2NwdV9zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IGlycSwgaW50IGxldmVs
KQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKG9wYXF1ZSk7CisgICAgQ1BV
U3RhdGUgKmNzID0gQ1BVKGNwdSk7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52
KGNzKTsKKworICAgIHN3aXRjaCAoaXJxKSB7CisgICAgY2FzZSBIRVhBR09OX0NQVV9JUlFfMCAu
Li4gSEVYQUdPTl9DUFVfSVJRXzc6CisgICAgICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQs
ICIlczogaXJxICVkLCBsZXZlbCAlZFxuIiwKKyAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNf
XywgaXJxLCBsZXZlbCk7CisgICAgICAgIGlmIChsZXZlbCkgeworICAgICAgICAgICAgaGV4X3Jh
aXNlX2ludGVycnVwdHMoZW52LCAxIDw8IGlycSwgQ1BVX0lOVEVSUlVQVF9IQVJEKTsKKyAgICAg
ICAgfQorICAgICAgICBicmVhazsKKyAgICBkZWZhdWx0OgorICAgICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9p
bml0KE9iamVjdCAqb2JqKQogeworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgSGV4YWdv
bkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUob2JqKTsKKyAgICBxZGV2X2luaXRfZ3Bpb19pbihERVZJ
Q0UoY3B1KSwgaGV4YWdvbl9jcHVfc2V0X2lycSwgOCk7CisjZW5kaWYKIH0KIAorI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZCisKK3N0YXRpYyBib29sIGhleGFnb25fY3B1X2V4ZWNfaW50ZXJydXB0
KENQVVN0YXRlICpjcywgaW50IGludGVycnVwdF9yZXF1ZXN0KQoreworICAgIENQVUhleGFnb25T
dGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0ICYgQ1BV
X0lOVEVSUlVQVF9UTEJfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKKyAg
ICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKTsK
KyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAgIGlmIChpbnRlcnJ1cHRfcmVxdWVzdCAm
IENQVV9JTlRFUlJVUFRfSzBfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsK
KyAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sp
OworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0
ICYgKENQVV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJKSkgeworICAgICAgICBy
ZXR1cm4gaGV4X2NoZWNrX2ludGVycnVwdHMoZW52KTsKKyAgICB9CisgICAgcmV0dXJuIGZhbHNl
OworfQorCisjZW5kaWYKKwogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29uX3RjZ19vcHMg
PSB7CiAgICAgLyogTVRUQ0cgbm90IHlldCBzdXBwb3J0ZWQ6IHJlcXVpcmUgc3RyaWN0IG9yZGVy
aW5nICovCiAgICAgLmd1ZXN0X2RlZmF1bHRfbWVtb3J5X29yZGVyID0gVENHX01PX0FMTCwKQEAg
LTQyNiw2ICs1MDcsOSBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9
IHsKICAgICAuc3luY2hyb25pemVfZnJvbV90YiA9IGhleGFnb25fY3B1X3N5bmNocm9uaXplX2Zy
b21fdGIsCiAgICAgLnJlc3RvcmVfc3RhdGVfdG9fb3BjID0gaGV4YWdvbl9yZXN0b3JlX3N0YXRl
X3RvX29wYywKICAgICAubW11X2luZGV4ID0gaGV4YWdvbl9jcHVfbW11X2luZGV4LAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLmNwdV9leGVjX2ludGVycnVwdCA9IGhleGFnb25fY3B1
X2V4ZWNfaW50ZXJydXB0LAorI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCiBz
dGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCBjb25zdCB2
b2lkICpkYXRhKQotLSAKMi4zNC4xCgo=

