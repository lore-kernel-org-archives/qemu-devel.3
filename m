Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3342910F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYJP-000865-1W; Wed, 08 Apr 2026 15:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAYGp-0004eV-I8
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:09:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP5-0005c3-NY
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637JlmBI1314466
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +EdGi7Fu6AmMC65dcl8sIuPhUI2yMUMp7pW7BZLEnZ8=; b=hy2WOYZvKlCKIKBT
 jH9ZyNUHknuMbEnJOm6NHOnYqTxw4zm5+stF0/ioyUbHtKCrtWtQ0tW9ERMDmi0F
 tlE6zaiTO0PZc4rMC4sqDWaivij+ytxjmMm1kN01gtFQmnrVWPjxjzoS0z9phnWv
 eszVYkAOv+RVTLAcF0/taU81PvXDUt9h/J2PMAOSGDKnwBjqCt1oK+gamowAtvCb
 Q1Xpn6RDBgmM4A3kdY1I2oJrP+wg1E5VkfVurJXPo0yxmUj+DUyr+AxSqLI2a9g9
 fZBPVGPMKmgCCXoG556iktKUoqNgv7vNLvBKhDK8SnOPUWjKIvS024BwPw1m8Zrp
 j7UiVg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8d6ha7x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:33 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c20a91932so4012357c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622033; x=1776226833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EdGi7Fu6AmMC65dcl8sIuPhUI2yMUMp7pW7BZLEnZ8=;
 b=Yc24aCPld+yHvk/evbQwnVsf1/swrnKgXKVnna/GoXveiSMeaVWqy7XrxxotVud7eo
 cR5rzBnkcb5dtPXxGXgwI0ruXMME/gulGEIu6vVTOZQm/M6D9eDbRLh11nBzB4udBWl+
 rvD31mAhQCquvBHoNN+TrAsSELxHB4Yfnij/U9JKXUPMprkmrPj9rTYU47o0dEw35VJJ
 IjojVMU/tFXKYJU73ggRmd7H+J8uI59ObwKng+M9elOP0qL8NReZJdJOFcs8TcumGypo
 WsiuvLC+nG19zLFQwS7PFvOg6u+/1rnKaTzgVR/X3+S1WYYUhHCpFlJvwIPEi6SKfjP7
 mHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622033; x=1776226833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+EdGi7Fu6AmMC65dcl8sIuPhUI2yMUMp7pW7BZLEnZ8=;
 b=LhxlA1+T+R+HabqErw2JVHYspHSNnxcrwbyOYWaAIzsjx2PyayhwzpLoAxNWpa+ppo
 +FP+0AVy1lR+KLAkEsS3eA5k/zq/3J1K9JsNbCciPV9MRfM97VvqKC7uGZpk6IgW3NUG
 ul4sJ+OItXh8EWB9uNGe9gDRZhgDl2aOWuiJcqEsrBbwU62LWgyFU8kvw6lmx1+wzL1m
 tkUEHTZILe9WRl8Km+SUxMeHQMv1owqNkSLqj+rbzUSVjduOvFADPsVlHZvbJPDv7Z1n
 WMh0CV2PQ47aJ61cdo8QAWFA8TU1Hb2oWXCKFge5gzMH3rD+GNFz2Iq5/H9D2O7ppH3q
 JBYA==
X-Gm-Message-State: AOJu0Yx/uat6UkfJEWmavtanpdwVKHd1ztMoSuJhiCpnZqo+yY4ou6qr
 +Wf7HJKjDULrmri7RmTWBovndYO8pHzvp+J6dvnpliONiFrdMzyD/7+U0aElZYapJeUB8rUjwYZ
 Utgg2CwWrY3ZFqvFDv+Kt9SGmb3tM0GlKXJbTRxyA/KPe5LWFpFvpg/TwJhppE9pBGg==
X-Gm-Gg: AeBDievwKM3C1mc1wqN0rtXBxsN3yvSnSbtR38ey93QGNTdQhXYjrRVSfy01LJRsV/P
 KzjHE+biPjX6Ai6n0upPtbqFKyWolD/aoAoWfmViJuhQtq6Wbw9wgZ55h0cJlIwtHUAndP9n39X
 M1AN7IAc/5uL/titZ+1Dg/GA17l5A5jUH0MHpWPPDjYFdOVB9gjcaRK/yfTKsNHGgIzUXipOxNV
 i/u29RcDioQBdGqmlyq4ZM03xiLeKPayc3DnbcMpaw8Dju9FVxvXLKAiKdsspbXYgiZW2jzbLk4
 0tky9EQfvPukQr86gvbq3Y02F6iF0S1pQG7idnlrHTYc2YQRVBoxzgSWJ0mvHNTOwVWtPPdIJyK
 y+bLl7QTHtIg27WGhG87D6RH/h0cX7jwmOiKv5vxieWOrOVxyb/gSk1qndYG+GeQv4Ubxow==
X-Received: by 2002:a05:7022:388a:b0:123:348d:8576 with SMTP id
 a92af1059eb24-12bfb6ec50bmr11023285c88.6.1775622032782; 
 Tue, 07 Apr 2026 21:20:32 -0700 (PDT)
X-Received: by 2002:a05:7022:388a:b0:123:348d:8576 with SMTP id
 a92af1059eb24-12bfb6ec50bmr11023265c88.6.1775622032206; 
 Tue, 07 Apr 2026 21:20:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 23/28] target/hexagon: Define system, guest reg names
Date: Tue,  7 Apr 2026 21:19:48 -0700
Message-Id: <20260408041953.1899532-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: oILiyoxW-faUtFuygZXijyOFBAQtw8tH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX+loxDIB5wbdj
 7NgILnb63qLZL2agSKcz3WXNJPo21plLqNHU0IIGOvwQsUdOFOLhytw2cJ/MzDwle6aJwhPHpgS
 RRLjAjdsG5/vP05LNpti5JqCbfaICP+ZQI5nopel5aQuO97eDLQejcI9nqFDCCM7w75daBwYXfh
 AmCkSB73svcFym0b7iMVdAqdxAI86TjUMVjAFda4YuoXG/0e/GRgT2jkdiTcCMlxKf5ZUf9peLA
 Cqh0Hg5z1k2dbNED7lVw8stfk87o8xmAEHmkIxbIrErDO1LKbzEDVTr09oMMAtFofGrvlwnD2Tc
 69d/hppw8Nndao+3lXjcamkLkz83m4PBWDrzLfv1oBUiOkTyQnxGjCy4LFIKj7NdXWfneooZ6dD
 ph5rV+gx3wdl4MOrjcLAs2XgB9UMejPU49HyhGid1+F3ZM+amQtZyXf3tqWZM3QlyVtZZfxgHv2
 vJ7Z0gmGbDXGNp1JRPQ==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69d5d791 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y3CEZXcnQwYgoNz55sMA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: oILiyoxW-faUtFuygZXijyOFBAQtw8tH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
eGFnb24vY3B1LmMKaW5kZXggODliNDFmYjc4NTEuLmE0OGQ2MTc4ZTA2IDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtOTAsNiAr
OTAsMzUgQEAgY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RI
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

