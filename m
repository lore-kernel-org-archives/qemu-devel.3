Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59774CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndP-000383-Ki; Mon, 22 Jun 2026 19:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndN-00036i-Kd
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndL-0002Vd-GR
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaEU92101424
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=; b=d28ie6Xs1bNqUC5P
 I15ieDmEZ0uMu/X/13XAY5LHOyJH4USTA8OwWt98U4hbPNDiTIwy9UYEe8s0QtZN
 2p88J/2xGmMsSsqJqDrCIGBn/CD1D2W5kdfJ1+WoKJcIfooTL6V81zKaILEI1bLz
 gY3zXDeXoCp/oTGPpldrbBJ9Wmyi512mVaci1DS7RyljtzQK+8L0COGr0sAL4mjn
 VPrextgTL5GpGHa4W+lX2P1d9WxHDyU1BZNqpNWS/ds3n7um3BEgKYkURG7Csd6X
 f74+9QHzOYxrZu7ugw3aYejShlWzmvPnwLBjFgxEIqD8YnsbrYKXWJSopAIqS98/
 n4EJ/w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebah59-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:40 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13980b6561dso11642945c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169240; x=1782774040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=SZHjgBCnZMCYfnIeJX0ppy2cYxMoXN7uHBcAbtksWr48OYqBr3rscuZex6curYskvk
 9Yixfv6bYiZFLWtw/ySKuQPp7TuqnK2KsCMWFFhnDuPsD2KoNBP3YvSgsdu6ykTbgoHF
 zoyzJr3DmFD4GzFhTIIrMk3fJstTh26Qwdb52ageiELRANqDPsMG0a4UM6SWFoAkMpXs
 vKmGfOmhYdqmXcO3YJ7aC9t3mKOdxbhMY2c8hOuEHZNLq4Osx3scwEsnMNsMrDOebTz8
 Lm5ov/pgleXfu23DgH1kyIg8qeUDZsia7284nm+JvFk79aj4d9BNIWQX/IM2EGCq/ESJ
 tHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169240; x=1782774040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=Ux3cUAmyIF3P0/wHnO8zZR9jRLXsrEA4Pfi6yIdx1utEWVNXZJi1esSMEnwfmjSUlY
 dzSyOPNumm1+bb0D7A0kkCZR6+jsHZficj6LMaJKGhNhk+wzDshIrj4xW5T/Tjo8VA58
 6SzJRl83exLtY2ZdVeSaEvnHZfLcrkVpx90OPzTI2fIe6CDhGKG8eYZlqJjtlNmmv2+U
 mzc/bzAz7U0tFLGAdUY6RYlm1Hj508LdXJ6Y0Ft1qXfXOkAq/JleHSwt42xuaO1fQw0N
 v2x1f6/N6xNkKzZg0VTYUB9F2/LZ3vHQXxytxNGZ7UNdf5TIjhnuFyE/3vPkmOgmFQ6n
 0MFg==
X-Gm-Message-State: AOJu0YxcWMO+Rk327MukKTit+ycPufaM/9XbJfM1FM2+dw3DxL++rsuk
 PP2QEEwDkHfvxqmX5xkizlUv9autXmcGWTP/iA+9RIQaqVnKYoD80JInZxDF8rPYE6XO0Xo0B0j
 FVRFXgpOb8EYV7pNL9ZcwklfrI3Qnla8FbKOJv/emKJlN+H7TdmasJRhlSITacJbLlQ==
X-Gm-Gg: AfdE7cmrjVi8UEdECFvn5LqqdW8gG5WWwekYfDLw7ESNj+e7QNQeGLXqdWZ6HwkTeX4
 vAigKDuoGvxVKxYMcLzEwq/cpsS+F320mQl6j8mndnNmDSc9TrxDhbiXdUmkSJ2EW7DfMDXlc0M
 9siu/LtYZR+uX7hetDfocobxEsYUE7Vpd58s57+Turp8FzlspRiF9KIR++0RdRD6TkcqkaiU3fm
 5JuFpirfb4yHDBTudjPXaW7RtNi7MbiIEsWQKGUYEVhbyPnRLbRidQC6IC9aD4mHUkt6ia7tmP+
 Uj36nnTAoEIv3gjnhDcvU5sdxlkBU6y9CmHorIBfXn5JP0J9Qu/6MN9D66V59UVAHcD2I/zioJZ
 Ff5MLa+gPWiBEkwRFpcojF4QbzCLad/pXxL1/aDxM9e/PjU3Rwmz+v/x5sMg=
X-Received: by 2002:a05:7022:1a81:b0:139:9f6f:2eee with SMTP id
 a92af1059eb24-139a369a9dfmr10033098c88.36.1782169238107; 
 Mon, 22 Jun 2026 16:00:38 -0700 (PDT)
X-Received: by 2002:a05:7022:1a81:b0:139:9f6f:2eee with SMTP id
 a92af1059eb24-139a369a9dfmr10033037c88.36.1782169236977; 
 Mon, 22 Jun 2026 16:00:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 60/75] target/hexagon: Define system, guest reg names
Date: Mon, 22 Jun 2026 15:28:49 -0700
Message-Id: <20260622222904.607771-61-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXwd4UU7IFSCOY
 DVcPXkzsfiZ/IKhQ2mtfRTO1DU2Jba+/3u0rzA/jM3ahz4RSMZiRn/NJRhnpSiqQsaoaaY1SOzW
 WhkvRkNU9stG1HCeXbRbPLrBrT8h8M8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXx+9xEmR0T92g
 CrNLCO5R9uz0eMaaBKPapMdeCz9gKs6tyr0l9AewlAeOrreZs8+aNJiOfE7rXtI1pW/wC11M71O
 aY+CC31DtIiQGY84qPRRcax/Ta+Jd4fo+tPrNXZJVW3CgFI1czwfG7vHHnxwb0k7jdy/jkQEki0
 LLHw33unpLgJ2wLyHwU1gqT7AakQIesoAhtXjLojtTAFNUyN9JGNgVV5n0YFnj2zj35IxVWGUM6
 Kf5NOyTrPkC7xFfxdayxXv/3BirCC5soIlibkxHmR5CNpCKFBgAeAGuL/FXpeCuWBdR8bB7wlyo
 i9sAN/0e0CWFD8nancYV/K9rOJLKeK8ERZBJ/+349BkQRCbGlRNpPYWDQJdarA7iNEnxLM7wqeB
 JPNaydwiViIIBPqLVxHGHsaeTFvMPxBh0P4GT518ce7mLmAXWIA8Yx9drXYJMcAe5YxxLhbHwl7
 BN9xXZmfa2kU5Vb7zMw==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a39be98 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y3CEZXcnQwYgoNz55sMA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZFKvS-LadPlVrR3IsvhcL6GODimjlwOc
X-Proofpoint-ORIG-GUID: ZFKvS-LadPlVrR3IsvhcL6GODimjlwOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdv
bi9pbnRlcm5hbC5oCmluZGV4IDQzMzg5MTRlZmI1Li4wMGIzN2FlYTdhZiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CkBAIC0zMCw2ICszMCwxMCBAQCB2b2lkIGhleGFnb25fZGVidWdfcXJlZyhDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50IHJlZ251bSk7CiB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRl
ICplbnYpOwogCiBleHRlcm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9U
QUxfUEVSX1RIUkVBRF9SRUdTXTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNv
bnN0IGNoYXIgKiBjb25zdCBoZXhhZ29uX3NyZWduYW1lc1tdOworZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX2dyZWduYW1lc1tdOworI2VuZGlmCiAKIHZvaWQgR19OT1JFVFVSTiBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgIHVpbnQzMl90
IGV4Y2VwdGlvbiwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hl
eGFnb24vY3B1LmMKaW5kZXggM2FmOTBlMzBiMGYuLmIzNWNhYWVjZmFlIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtODYsNiAr
ODYsMzUgQEAgY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RI
UkVBRF9SRUdTXSA9IHsKICAgImMyNCIsICJjMjUiLCAiYzI2IiwgImMyNyIsICJjMjgiLCAgImMy
OSIsICJjMzAiLCAiYzMxIiwKIH07CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorY29uc3Qg
Y2hhciAqIGNvbnN0IGhleGFnb25fc3JlZ25hbWVzW10gPSB7CisgICAgInNncDAiLCAgICAgICAi
c2dwMSIsICAgICAgICJzdGlkIiwgICAgICAgImVsciIsICAgICAgICAiYmFkdmEwIiwKKyAgICAi
YmFkdmExIiwgICAgICJzc3IiLCAgICAgICAgImNjciIsICAgICAgICAiaHRpZCIsICAgICAgICJi
YWR2YSIsCisgICAgImltYXNrIiwgICAgICAiZ2V2YiIsICAgICAgICJ2d2N0cmwiLCAgICAgInMx
MyIsICAgICAgICAiczE0IiwKKyAgICAiczE1IiwgICAgICAgICJldmIiLCAgICAgICAgIm1vZGVj
dGwiLCAgICAic3lzY2ZnIiwgICAgICJzZWdtZW50IiwKKyAgICAiaXBlbmRhZCIsICAgICJ2aWQi
LCAgICAgICAgInZpZDEiLCAgICAgICAiYmVzdHdhaXQiLCAgICJzMjQiLAorICAgICJzY2hlZGNm
ZyIsICAgInMyNiIsICAgICAgICAiY2ZnYmFzZSIsICAgICJkaWFnIiwgICAgICAgInJldiIsCisg
ICAgInBjeWNsZWxvIiwgICAicGN5Y2xlaGkiLCAgICJpc2Ric3QiLCAgICAgImlzZGJjZmcwIiwg
ICAiaXNkYmNmZzEiLAorICAgICJsaXZlbG9jayIsICAgImJya3B0cGMwIiwgICAiYnJrcHRjZmcw
IiwgICJicmtwdHBjMSIsICAgImJya3B0Y2ZnMSIsCisgICAgImlzZGJtYnhpbiIsICAiaXNkYm1i
eG91dCIsICJpc2RiZW4iLCAgICAgImlzZGJncHIiLCAgICAicG11Y250NCIsCisgICAgInBtdWNu
dDUiLCAgICAicG11Y250NiIsICAgICJwbXVjbnQ3IiwgICAgInBtdWNudDAiLCAgICAicG11Y250
MSIsCisgICAgInBtdWNudDIiLCAgICAicG11Y250MyIsICAgICJwbXVldnRjZmciLCAgInBtdXN0
aWQwIiwgICAicG11ZXZ0Y2ZnMSIsCisgICAgInBtdXN0aWQxIiwgICAidGltZXJsbyIsICAgICJ0
aW1lcmhpIiwgICAgInBtdWNmZyIsICAgICAiczU5IiwKKyAgICAiczYwIiwgICAgICAgICJzNjEi
LCAgICAgICAgInM2MiIsICAgICAgICAiczYzIiwKK307CisKK0dfU1RBVElDX0FTU0VSVChOVU1f
U1JFR1MgPT0gQVJSQVlfU0laRShoZXhhZ29uX3NyZWduYW1lcykpOworCitjb25zdCBjaGFyICog
Y29uc3QgaGV4YWdvbl9ncmVnbmFtZXNbXSA9IHsKKyAgICAiZ2VsciIsICAgICAgICJnc3IiLCAg
ICAgICAiZ29zcCIsICAgICAgImdiYWR2YSIsICAgICJnY29tbWl0MXQiLAorICAgICJnY29tbWl0
MnQiLCAgImdjb21taXQzdCIsICJnY29tbWl0NHQiLCAiZ2NvbW1pdDV0IiwgImdjb21taXQ2dCIs
CisgICAgImdwY3ljbGUxdCIsICAiZ3BjeWNsZTJ0IiwgImdwY3ljbGUzdCIsICJncGN5Y2xlNHQi
LCAiZ3BjeWNsZTV0IiwKKyAgICAiZ3BjeWNsZTZ0IiwgICJncG11Y250NCIsICAiZ3BtdWNudDUi
LCAgImdwbXVjbnQ2IiwgICJncG11Y250NyIsCisgICAgImdjb21taXQ3dCIsICAiZ2NvbW1pdDh0
IiwgImdwY3ljbGU3dCIsICJncGN5Y2xlOHQiLCAiZ3BjeWNsZWxvIiwKKyAgICAiZ3BjeWNsZWhp
IiwgICJncG11Y250MCIsICAiZ3BtdWNudDEiLCAgImdwbXVjbnQyIiwgICJncG11Y250MyIsCisg
ICAgImczMCIsICAgICAgICAiZzMxIiwKK307CisjZW5kaWYKIC8qCiAgKiBPbmUgb2YgdGhlIG1h
aW4gZGVidWdnaW5nIHRlY2huaXF1ZXMgaXMgdG8gdXNlICItZCBjcHUiIGFuZCBjb21wYXJlIGFn
YWluc3QKICAqIExMREIgb3V0cHV0IHdoZW4gc2luZ2xlIHN0ZXBwaW5nLiAgSG93ZXZlciwgdGhl
IHRhcmdldCBhbmQgcWVtdSBwdXQgdGhlCi0tIAoyLjM0LjEKCg==

