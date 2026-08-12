Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CF2C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2UY-0007ny-Tt; Wed, 12 Aug 2026 02:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2UT-0007PL-Br
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:31:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2UQ-0003tT-Jc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:31:04 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62f1V2190469
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=6JZfcYgiHkLJYfajT4dIecVjGyRwLhk+lobOnrbE4ow=; b=T+
 iP72UcFd3d6IzD4AQN2eN1Zu5oqs4s5/X7VUNOwVUoVcaPZT3vsr0jSyfQUVgieb
 xrGp7ZoNLlyZ4JDB0k/58y9XZT4x19vaAmSwKyNFeNbeIO0eO1Gvs+LqY/qWUOoD
 PdM4lqfRcqMnphc4iyOjw37ON1EAf3bc4rLRoaAsSV2xqOS2w03QR9SGQ3heX2UR
 l5LaZCm14QVwhx+ry+Xpql74KfX5+ADqUBci4ZLd2QaKkLep9R4BoevBku5a/yGN
 jukndhrbEIBWADdiFpGPLs9iF/pYIZwlPzZcBTLtgFEn93wQ/ddZ24ewCZ1agfZ5
 3uqA0RVBBWxL4HlTIqqw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049g3t5c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e667368f0so1009178a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516250; x=1787121050; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6JZfcYgiHkLJYfajT4dIecVjGyRwLhk+lobOnrbE4ow=;
 b=SVehH05Ht1F8Z5iS8cf62pCs5h2T1Tv36t+d+769li91oq8DD/lB7ir4HxY6yUIK6I
 9tbGyu9a0vgbKAEVArLblXEQRiT0AXlr7/q27MIWDH9jTdreLhGfeNUgKpyJhOs07OFV
 pjUmx0HnrPRaU+HCQ/Clc00U3IklNX5m7ja+Fxa1BmeeTuIvjmpzzRuTc9NfD+zzuts3
 Vc68THPrjTh1Km6iYZcCuK149/lOzO7KqDAommF5SiqX4hR/uttpFnEN8UXaxXXBCbGK
 S5XdYAcQNHra39OJC4rYUlii626SMLYS+U3krrB+j73zAow5whYtsiG8gT93kw0YJm/p
 GMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516250; x=1787121050;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6JZfcYgiHkLJYfajT4dIecVjGyRwLhk+lobOnrbE4ow=;
 b=pumf6EHjRGfX5FzTSfci3ux9dnvaurDYqUKo2FaRB5+gdSxrx7/wiXN2gSAMwH1Hy3
 mYyXnMEwTcoUglMonpBZBSSlZ9K9E+1qz2EfnaAkF3REZfYx8Hoq3ebugT0ZTNBw5iX4
 wffmpijeWnRKcAj7poNylNArHz/+EMxf2bv/V8OEIdcWI61IwyISFOYGIGQBEsB7LEIW
 jKDQsF99emlJgqNfdQMk8CxeyUdjAMpsnm/7f7JRCcjzprXvTFIbl0cuBvRmcubuAMEi
 0KMnG1Nj5ILWzIra/mxaxZd7THt/QJNZxvFIFOfYWGxQSEr6n76soTBJilOdO35YWmcd
 YSpw==
X-Gm-Message-State: AOJu0YwIuHsjWdhKcW8bg7bBMxXUo/+L5uoN37GmHO4xBimYwBlsnvkW
 8k1X3beggJ63kRShwmH+wDgX88QstRpQ9wc9XbYSCdogA7XhDOxst5KNdz496CLaA6dbOs2BbdD
 5KOViy3CqkmlH/C9Cmj8q3VME7Ey5/kA1eFD7XftwmjT5j4yAVkRGkID3CK0d7cEOuw==
X-Gm-Gg: AR+sD12h6IPXPE7aramqNlNyWCLqgowEAYSczBItu0a7MkJyZ9g481iyK7zZg7c2QwE
 mVRG/T8j9uBuHtwWg2sWyW1asrYNZW2fa+rq4XAi/CXAuE0yLbubmNmRtPh0dPDGL8EU/pXPb90
 XlnrEOxUl9NUJ2pYRBgsh0nWHUHuTKElE2yKpMyAKXYJpZnQganNH07p/ueUq+nt8i575GYKzXt
 dabB9L70I/vTVmCUdFXyWaO9qk4bRVnOWox/6Xm56SlSUrDdXjizLu0RaS16FIqwb5tRYUVvCX3
 O+yrXxhO1m2Ojuyy5C6rgmVyHOhBlumMIrWuQ/Qc3aezBCVTIcTNh+pG9EzzJF7+w75zEAMrnGy
 ew1QO8TZu8xN/wWhbvdZ0DWhJoBRpewQFx1iABP3d93RTpA8f
X-Received: by 2002:a17:90b:4a83:b0:381:bc4c:da56 with SMTP id
 98e67ed59e1d1-393017cf516mr2650202a91.19.1786516250268; 
 Tue, 11 Aug 2026 23:30:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4a83:b0:381:bc4c:da56 with SMTP id
 98e67ed59e1d1-393017cf516mr2650166a91.19.1786516249742; 
 Tue, 11 Aug 2026 23:30:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 29/41] hexagon: group cpu configurations in their own struct
Date: Tue, 11 Aug 2026 23:29:20 -0700
Message-Id: <20260812062932.543840-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: kF3Lq2xDko4OnlEtCZGk9PVdtzxBRel-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX0V3QNxQMTdUY
 2okFI1m4f212BNRm1T2HOPQUgbQTQCPoH3BaTaJZW0svAOeoihLdZvZna7AV7DC7T8E1/joejsR
 ezJQcwYUZTMT7sRGpQ7jMePALJhWVxM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX1DzbynOLnR8r
 oTiuNQjCNNX5uLHclaeWmS7f5xqwLRjxRJdzfah9bL1gLycNqEaPmrnNqxWYk8Mgz7l3VJnCAbd
 xxMDrF2BrXiJh2kucUQSW5CA2UtLDaK13m7BXdzQlIroUWM4qfK9F53/6SeHY3HBBzgVQ/hQIQV
 SZ94ZWg4uJfLx0Gveq/Nt6m85JTqSJ417XoKE1dzLPdjeos6eoOnusw3kVs/s+Uylc73caiGbV9
 NUnZPUF+6bobJG2ZWsW1cnWmM5SsfuuDWUTASG6rx6c7HMKLJf4AB+6P/8pqmBL631flnLaCJty
 SxNZBsSYkDiwSaWfarCML4wbtGaUYkfhYDUEwKVxTXb6ujdZb4iawvrZzQNZEB01b2vcrGtUZXs
 BNiqecN4SJQx3mVikpHVrX0tMbMeBxc66mgnGPtoGX26fKZUctqs609f6P/pVSFlUn5xKY72vcd
 Czp2nlnxg3vv3YL1ZBw==
X-Proofpoint-ORIG-GUID: kF3Lq2xDko4OnlEtCZGk9PVdtzxBRel-
X-Authority-Analysis: v=2.4 cv=LIRWhpW9 c=1 sm=1 tr=0 ts=6a7c131b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=Cawoy3z-aL3jkQ-xqsQA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKVGhpcyB3aWxsIGJlIHVzZWQgaW4gYSBmb2xsb3cgdXAgY29tbWl0LgoK
UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNp
Z25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRp
bm9Ab3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC84ZjlhMmUyY2NmZDJlZWRhNzNhNjNkMWE2YWJiZmQ2ZTU0NThiNDRjLjE3NzYzMzk0NTEuZ2l0
Lm1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuaCAgICAgICB8IDEwICsrKy0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggIHwg
IDcgKysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgfCAxNCArKysrKysrLS0tLS0t
LQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAgNiArKystLS0KIDQgZmlsZXMgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA1MDJmMjc5ODNiZS4u
YjBkNzI2YmYwMjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCkBAIC0xODYsMTUgKzE4NiwxMyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhh
Z29uQ1BVQ2xhc3MgewogICAgIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWY7CiB9IEhleGFn
b25DUFVDbGFzczsKIAorI2luY2x1ZGUgImNwdV9iaXRzLmgiCisKIHN0cnVjdCBBcmNoQ1BVIHsK
ICAgICBDUFVTdGF0ZSBwYXJlbnRfb2JqOwogCiAgICAgQ1BVSGV4YWdvblN0YXRlIGVudjsKLQot
ICAgIGJvb2wgbGxkYl9jb21wYXQ7Ci0gICAgdGFyZ2V0X3Vsb25nIGxsZGJfc3RhY2tfYWRqdXN0
OwotICAgIGJvb2wgc2hvcnRfY2lyY3VpdDsKLSAgICBib29sIGllZWVfZnBfZXh0ZW5zaW9uOwor
ICAgIEhleGFnb25DUFVDb25maWcgY2ZnOwogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCiAgICAg
SGV4YWdvblRMQlN0YXRlICp0bGI7CiAgICAgdWludDMyX3QgYm9vdF9hZGRyOwpAQCAtMjA0LDgg
KzIwMiw2IEBAIHN0cnVjdCBBcmNoQ1BVIHsKICNlbmRpZgogfTsKIAotI2luY2x1ZGUgImNwdV9i
aXRzLmgiCi0KIEZJRUxEKFRCX0ZMQUdTLCBJU19USUdIVF9MT09QLCAwLCAxKQogRklFTEQoVEJf
RkxBR1MsIE1NVV9JTkRFWCwgMSwgMykKIEZJRUxEKFRCX0ZMQUdTLCBQQ1lDTEVfRU5BQkxFRCwg
NCwgMSkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggYi90YXJnZXQvaGV4
YWdvbi9jcHVfYml0cy5oCmluZGV4IDE2NGU3NGM3ODJiLi43OTdlY2FiY2E5MiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHVfYml0
cy5oCkBAIC0yMSw2ICsyMSwxMyBAQAogI2luY2x1ZGUgInFlbXUvYml0b3BzLmgiCiAjaW5jbHVk
ZSAiY3B1LXFvbS5oIgogCit0eXBlZGVmIHN0cnVjdCBIZXhhZ29uQ1BVQ29uZmlnIHsKKyAgICBi
b29sIGxsZGJfY29tcGF0OworICAgIHVpbnQzMl90IGxsZGJfc3RhY2tfYWRqdXN0OworICAgIGJv
b2wgc2hvcnRfY2lyY3VpdDsKKyAgICBib29sIGllZWVfZnBfZXh0ZW5zaW9uOworfSBIZXhhZ29u
Q1BVQ29uZmlnOworCiAjZGVmaW5lIFBDQUxJR04gNAogI2RlZmluZSBQQ0FMSUdOX01BU0sgKFBD
QUxJR04gLSAxKQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IGYyNTg3OGNkNjcwLi4zYmMyYTJlZmE5NyAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTcxLDEx
ICs3MSwxMSBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgaGV4YWdvbl9jcHVfcHJvcGVydGllc1td
ID0gewogICAgICAgICBUWVBFX0hFWEFHT05fR0xPQkFMUkVHLCBIZXhhZ29uR2xvYmFsUmVnU3Rh
dGUgKiksCiAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJodGlkIiwgSGV4YWdvbkNQVSwgaHRpZCwg
MCksCiAjZW5kaWYKLSAgICBERUZJTkVfUFJPUF9CT09MKCJsbGRiLWNvbXBhdCIsIEhleGFnb25D
UFUsIGxsZGJfY29tcGF0LCBmYWxzZSksCi0gICAgREVGSU5FX1BST1BfVU5TSUdORUQoImxsZGIt
c3RhY2stYWRqdXN0IiwgSGV4YWdvbkNQVSwgbGxkYl9zdGFja19hZGp1c3QsIDAsCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgcWRldl9wcm9wX3VpbnQzMiwgdGFyZ2V0X3Vsb25nKSwKLSAgICBE
RUZJTkVfUFJPUF9CT09MKCJzaG9ydC1jaXJjdWl0IiwgSGV4YWdvbkNQVSwgc2hvcnRfY2lyY3Vp
dCwgdHJ1ZSksCi0gICAgREVGSU5FX1BST1BfQk9PTCgiaWVlZS1mcCIsIEhleGFnb25DUFUsIGll
ZWVfZnBfZXh0ZW5zaW9uLCB0cnVlKSwKKyAgICBERUZJTkVfUFJPUF9CT09MKCJsbGRiLWNvbXBh
dCIsIEhleGFnb25DUFUsIGNmZy5sbGRiX2NvbXBhdCwgZmFsc2UpLAorICAgIERFRklORV9QUk9Q
X1VOU0lHTkVEKCJsbGRiLXN0YWNrLWFkanVzdCIsIEhleGFnb25DUFUsIGNmZy5sbGRiX3N0YWNr
X2FkanVzdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAwLCBxZGV2X3Byb3BfdWludDMyLCB0
YXJnZXRfdWxvbmcpLAorICAgIERFRklORV9QUk9QX0JPT0woInNob3J0LWNpcmN1aXQiLCBIZXhh
Z29uQ1BVLCBjZmcuc2hvcnRfY2lyY3VpdCwgdHJ1ZSksCisgICAgREVGSU5FX1BST1BfQk9PTCgi
aWVlZS1mcCIsIEhleGFnb25DUFUsIGNmZy5pZWVlX2ZwX2V4dGVuc2lvbiwgdHJ1ZSksCiB9Owog
CiBjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9yZWduYW1lc1tUT1RBTF9QRVJfVEhSRUFEX1JF
R1NdID0gewpAQCAtMTI3LDcgKzEyNyw3IEBAIGNvbnN0IGNoYXIgKiBjb25zdCBoZXhhZ29uX2dy
ZWduYW1lc1tdID0gewogc3RhdGljIHRhcmdldF91bG9uZyBhZGp1c3Rfc3RhY2tfcHRycyhDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIGFkZHIpCiB7CiAgICAgSGV4YWdvbkNQVSAq
Y3B1ID0gZW52X2FyY2hjcHUoZW52KTsKLSAgICB0YXJnZXRfdWxvbmcgc3RhY2tfYWRqdXN0ID0g
Y3B1LT5sbGRiX3N0YWNrX2FkanVzdDsKKyAgICB0YXJnZXRfdWxvbmcgc3RhY2tfYWRqdXN0ID0g
Y3B1LT5jZmcubGxkYl9zdGFja19hZGp1c3Q7CiAgICAgdGFyZ2V0X3Vsb25nIHN0YWNrX3N0YXJ0
ID0gZW52LT5zdGFja19zdGFydDsKICAgICB0YXJnZXRfdWxvbmcgc3RhY2tfc2l6ZSA9IDB4MTAw
MDA7CiAKQEAgLTIzOSw3ICsyMzksNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2R1bXAoQ1BVSGV4
YWdvblN0YXRlICplbnYsIEZJTEUgKmYsIGludCBmbGFncykKIHsKICAgICBIZXhhZ29uQ1BVICpj
cHUgPSBlbnZfYXJjaGNwdShlbnYpOwogCi0gICAgaWYgKGNwdS0+bGxkYl9jb21wYXQpIHsKKyAg
ICBpZiAoY3B1LT5jZmcubGxkYl9jb21wYXQpIHsKICAgICAgICAgLyoKICAgICAgICAgICogV2hl
biBjb21wYXJpbmcgd2l0aCBMTERCLCBpdCBkb2Vzbid0IHN0ZXAgdGhyb3VnaCBzaW5nbGUtY3lj
bGUKICAgICAgICAgICogaGFyZHdhcmUgbG9vcHMgdGhlIHNhbWUgd2F5LiAgU28sIHdlIGp1c3Qg
c2tpcCB0aGVtIGhlcmUKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIv
dGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggNThjODRkZjY2ZWMuLjA2YTgxNTlkMjgz
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYwpAQCAtMTIwOSw5ICsxMjA5LDkgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl90cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlzYXNDb250ZXh0QmFzZSAqZGNiYXNlLAogICAgIGN0
eC0+bnVtX2h2eF9pbnNucyA9IDA7CiAgICAgY3R4LT5icmFuY2hfY29uZCA9IFRDR19DT05EX05F
VkVSOwogICAgIGN0eC0+aXNfdGlnaHRfbG9vcCA9IEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9G
TEFHUywgSVNfVElHSFRfTE9PUCk7Ci0gICAgY3R4LT5zaG9ydF9jaXJjdWl0ID0gaGV4X2NwdS0+
c2hvcnRfY2lyY3VpdDsKKyAgICBjdHgtPnNob3J0X2NpcmN1aXQgPSBoZXhfY3B1LT5jZmcuc2hv
cnRfY2lyY3VpdDsKICAgICBjdHgtPmhleF9kZWYgPSBIRVhBR09OX0NQVV9HRVRfQ0xBU1MoaGV4
X2NwdSktPmhleF9kZWY7Ci0gICAgY3R4LT5pZWVlX2ZwX2V4dGVuc2lvbiA9IGhleF9jcHUtPmll
ZWVfZnBfZXh0ZW5zaW9uOworICAgIGN0eC0+aWVlZV9mcF9leHRlbnNpb24gPSBoZXhfY3B1LT5j
ZmcuaWVlZV9mcF9leHRlbnNpb247CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBjdHgt
Pm51bV9jeWNsZXMgPSAwOwogICAgIGN0eC0+cGN5Y2xlX2VuYWJsZWQgPSBGSUVMRF9FWDMyKGhl
eF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9FTkFCTEVEKTsKQEAgLTEyNjgsNyArMTI2OCw3IEBA
IHN0YXRpYyB2b2lkIGhleGFnb25fdHJfdHJhbnNsYXRlX3BhY2tldChEaXNhc0NvbnRleHRCYXNl
ICpkY2Jhc2UsIENQVVN0YXRlICpjcHUpCiAgICAgICAgICAqIHNvIGVuZCB0aGUgVExCIGFmdGVy
IGV2ZXJ5IHBhY2tldC4KICAgICAgICAgICovCiAgICAgICAgIEhleGFnb25DUFUgKmhleF9jcHUg
PSBlbnZfYXJjaGNwdShlbnYpOwotICAgICAgICBpZiAoaGV4X2NwdS0+bGxkYl9jb21wYXQgJiYg
cWVtdV9sb2dsZXZlbF9tYXNrKENQVV9MT0dfVEJfQ1BVKSkgeworICAgICAgICBpZiAoaGV4X2Nw
dS0+Y2ZnLmxsZGJfY29tcGF0ICYmIHFlbXVfbG9nbGV2ZWxfbWFzayhDUFVfTE9HX1RCX0NQVSkp
IHsKICAgICAgICAgICAgIGN0eC0+YmFzZS5pc19qbXAgPSBESVNBU19UT09fTUFOWTsKICAgICAg
ICAgfQogICAgIH0KLS0gCjIuMzQuMQoK

