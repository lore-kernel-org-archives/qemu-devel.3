Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2FE10F9976
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYas-0000ak-5V; Wed, 08 Apr 2026 15:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY8k-0008Vb-Hs
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:00:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKQd-0005jB-0w
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:22:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M4T9Z2861124
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dalz+aimR/zYCYAnc4cJTc09a9iXBszukXk0/4hGSTk=; b=VxrxBHoAseTmI/b0
 IDv5Xfa1NnQk7k2YA+/J5QtQhe/AcjLtrYXbYUEqOy9rr9jyW5WdMDCEJ8X0N74d
 ydXH1zuNG9hgNnnQbO0GY1IUMln4Q7r01MgbkVg/tyYA/601PydOhnoIKy6NHsyo
 iO78Wec+QDOLcrvYNDu5D/4tCLsqSekna3faU+0EKrwxlFjg4jAlDU1DMMZgZKO6
 OEV3SVa37NRiOHPyCSmg8YS+ykhA6GNESIjZ1lrZmkH2w7iunDUQu96ZJwtAQRmn
 /DEkB633DkMDOtQ72y7a7day5BKQX6B9bxy/PcIZh1+LiwnrUj3HPcfkYx5mg0XK
 n6Jwtg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddad8rx0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:22:00 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1279caef718so9083965c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622119; x=1776226919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dalz+aimR/zYCYAnc4cJTc09a9iXBszukXk0/4hGSTk=;
 b=Rnfn7ljpFgncBx4HgxWjgpoXlkyphauZGi5wf22w8feOIdPPTES991T9LnE/TbwMK/
 r6Hr/Jrp49Xm1ZHWaIGaLg+cb47/dQQiNlxNZB/sWvPUPoFZvOiDJzjHmjUf/DXS9LWy
 Vuj/UJQsKIg5I3GK22V1ZTJwNG2kAas1Is1Xep1+O/sU9PwlS+dO9HjQDIw5emftqekZ
 RSNwpYkE4Xf8rW2Vm5ZcY3Cx5lj5IoO++loNI9cNqOodobvojKAGMkLhHHejlrzWFZug
 JWmmYvjqE1jjSLA+aK/n5tjhdbuDocQYwEy2JB3G+aDwKXeVI4XGuxYaCqoPYuV/MWcM
 FNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622119; x=1776226919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dalz+aimR/zYCYAnc4cJTc09a9iXBszukXk0/4hGSTk=;
 b=SMgpOIKS4R0375VDrHyr+iKLaZG4KTULeHEpZjOgo6HAiwwVrcTl1nbMCA26pxDsLi
 KRBFpWxR2QkHjPJsHgh6JYfapaNNDo+A7WKzJar0nJ7Cf9iMqZbDs6+KChV8waDqCVII
 D9+RHs2h3EkqJ9V+HIZELtAAdaljqb8aKhhHHBWpJOr2q+aU85lukaaLL63oCVpOHiH+
 zSKmThE0ZXOtKP279DVww7g+zkGBPaY7R+XRu3MjHsjwiOdKcBso8ghgvwvUDP6KfngF
 DZCk9PH70GWrwB2357GNGKlJQ+dgzJyYg4paWUz6KedrN8CyEeJAwDGdkiSnEyLvYzSg
 6gdA==
X-Gm-Message-State: AOJu0YzI7H8Cx/OYpvWKQKEpjSqNEWU39FGrBmcYihXAkXIjp2lssXLH
 3F+WOZJUE8R9SomRYq+1amah87VUzusQNjY9JZ9P/UKJK3r9k5cuhuBCK9ILbkgOyx//LriFvgf
 9XvoiGVvXB8eQqHd8r1QVZYSLt6o83avTwCAvF5FXY/JBrqfp3G8YxDCWFlHUCzp+Dw==
X-Gm-Gg: AeBDietj70Kbb9Hk04AycNA7bKKyVKaaWyXU57EuH4y8l7XE6yXKA8mYSjUY6i8BoqE
 SkDYLtRPo0k2Acj4OrI7T5VhyjH+figFuteIeEwuLi0yowEotqzk3SiPql2zfsHPe3tatqRhc21
 WSgjFRA5u54OpUtErJCh9O0iA8LGHEMxlk92T84iTuGbSOdiQcXQJGMFCwO9SkEmwF2osXW4jsD
 qcclLjmLRuM48J4EvHSPgm2skDuQUPmsQyfbN1wPYn8qzn3pX6hHhqwoP9s16hQ/y4Y7zpNiGXD
 Osa0yvs3dpkXfp6m9HR1sDMRJ6u6ndHpDwCyBzhAR5jfhX5QlK5DJraPeeHZ3ksRpoAPss4wYUn
 1sulbhZnTQYodF0bdHmqvgtO/g/7HzLG9TMAbf76ps5rg7tO4S5syAkhTPchBwgUPpNeUcw==
X-Received: by 2002:a05:7022:6881:b0:11b:b622:cad9 with SMTP id
 a92af1059eb24-12bfb73e381mr8371137c88.21.1775622118750; 
 Tue, 07 Apr 2026 21:21:58 -0700 (PDT)
X-Received: by 2002:a05:7022:6881:b0:11b:b622:cad9 with SMTP id
 a92af1059eb24-12bfb73e381mr8371117c88.21.1775622118143; 
 Tue, 07 Apr 2026 21:21:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bed93f861sm23474816c88.0.2026.04.07.21.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:21:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 7/9] target/hexagon: add build config for softmmu
Date: Tue,  7 Apr 2026 21:21:46 -0700
Message-Id: <20260408042149.1902796-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: uVA5BWkvoLNIzgreflxZKmSHF_1H1xxa
X-Proofpoint-GUID: uVA5BWkvoLNIzgreflxZKmSHF_1H1xxa
X-Authority-Analysis: v=2.4 cv=EoDiaycA c=1 sm=1 tr=0 ts=69d5d7e8 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Jl0Sl96qzwJOXFZnYegA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX2GKod3+Csv/F
 M6rLhX4ke7eFGbp/6961sPAy/7cMKZ3abeRASbgo9Oj5xJhXh0VDdcu+aCVqZ4juJWkRPoaGNZQ
 6w+iPGZPlrh2XRfV445SGR5SWmG/xI6cucHk5I0IsytJ23erBkMF+mjhnwUGtCIwxb74nkfGfjt
 jJ4d6TDgUu3ctcbbMQXmihor2jKnLTXh9uNvq/8/amfsorCNCKf/o64CZylvRMyQ/fXp9/l1sdm
 LNnlfFJbooWPm1NHz/IXk3m+68tjw+TbDMYBn5d7MlVgqDrVFSaA/DY61xGzjoZ7oc25Hisqx5q
 jEvboGYOLj+VN0/6J04jdOAwh6rq901ghhin2QThfSLZ08PsYRC3scMCVw3f/7reQYNZ9mEnAR4
 7y33It9rUXGGGCEez540ovnjaaqUrRnnvrSySOdR8ze6KSQxnqdAg8im1vcVPP3LMAMTp4gm8kY
 aTf/ac4XNtAreAVkJTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
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

UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogY29u
Zmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hayB8ICA3ICsrKysrKysKIGNv
bmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrICAgICAgICAgfCAgNyArKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgIDcgKy0tLS0tLQog
dGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstLQogdGFy
Z2V0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRhcmdldC9o
ZXhhZ29uL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgfCAgMiArKwogdGFyZ2V0L2hleGFn
b24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICB8IDEzICsrKysrKysrKysrKy0KIDggZmls
ZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFrCiBjcmVh
dGUgbW9kZSAxMDA2NDQgY29uZmlncy90YXJnZXRzL2hleGFnb24tc29mdG1tdS5tYWsKIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9LY29uZmlnCgpkaWZmIC0tZ2l0IGEvTUFJTlRB
SU5FUlMgYi9NQUlOVEFJTkVSUwppbmRleCBiOWE3YzU1M2RmYS4uZWQ2NjFjOWYxMmUgMTAwNjQ0
Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0yNTQsNiArMjU0LDcgQEAg
RjogbGludXgtdXNlci9oZXhhZ29uLwogRjogdGVzdHMvdGNnL2hleGFnb24vCiBGOiBkaXNhcy9o
ZXhhZ29uLmMKIEY6IGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLWxpbnV4LXVzZXIvZGVmYXVsdC5t
YWsKK0Y6IGNvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKIEY6IGRv
Y2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIKIEY6IGdkYnN0dWIv
Z2RiLXhtbC9oZXhhZ29uKi54bWwKIEY6IGRvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdApk
aWZmIC0tZ2l0IGEvY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hayBi
L2NvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjA4ZTcwOWFlYTcyCi0tLSAvZGV2L251bGwKKysr
IGIvY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawpAQCAtMCwwICsx
LDcgQEAKKyMgRGVmYXVsdCBjb25maWd1cmF0aW9uIGZvciBoZXhhZ29uLXNvZnRtbXUKKworIyBV
bmNvbW1lbnQgdGhlIGZvbGxvd2luZyBsaW5lcyB0byBkaXNhYmxlIHRoZXNlIG9wdGlvbmFsIGRl
dmljZXM6CisKKyMgQm9hcmRzIGFyZSBzZWxlY3RlZCBieSBkZWZhdWx0LCB1bmNvbW1lbnQgdG8g
a2VlcCBvdXQgb2YgdGhlIGJ1aWxkLgorIyBDT05GSUdfSEVYX0RTUD15CisjIENPTkZJR19MMlZJ
Qz15CmRpZmYgLS1naXQgYS9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hayBiL2Nv
bmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAwMDAwLi5mZGZhMjliNGYzOQotLS0gL2Rldi9udWxsCisrKyBiL2NvbmZpZ3Mv
dGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCkBAIC0wLDAgKzEsNyBAQAorIyBEZWZhdWx0IGNv
bmZpZ3VyYXRpb24gZm9yIGhleGFnb24tc29mdG1tdQorCitUQVJHRVRfQVJDSD1oZXhhZ29uCitU
QVJHRVRfWE1MX0ZJTEVTPWhleGFnb24tY29yZS54bWwgaGV4YWdvbi1odngueG1sCitUQVJHRVRf
TE9OR19CSVRTPTMyCitUQVJHRVRfTk9UX1VTSU5HX0xFR0FDWV9MRFNUX1BIWVNfQVBJPXkKK1RB
UkdFVF9OT1RfVVNJTkdfTEVHQUNZX05BVElWRV9FTkRJQU5fQVBJPXkKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMDlkNWNhYzRm
ZTUuLjE4ZGNmZGIwYjBhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90
YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMzcsMTIgKzM3LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgSGV4
YWdvbkdsb2JhbFJlZ1N0YXRlIEhleGFnb25HbG9iYWxSZWdTdGF0ZTsKICNpbmNsdWRlICJtbXZl
Yy9tbXZlYy5oIgogI2luY2x1ZGUgImh3L2NvcmUvcmVnaXN0ZXJmaWVsZHMuaCIKIAotI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCi0jZXJyb3IgIkhleGFnb24gZG9lcyBub3Qgc3VwcG9ydCBzeXN0
ZW0gZW11bGF0aW9uIgotI2VuZGlmCi0KLSNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQotI2VuZGlm
CisjaW5jbHVkZSAicmVnX2ZpZWxkcy5oIgogCiAjZGVmaW5lIE5VTV9QUkVHUyA0CiAjZGVmaW5l
IFRPVEFMX1BFUl9USFJFQURfUkVHUyA2NApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA5ODgzYzRkMTY4MS4uMzU1YWJiNGZkMjQg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCkBAIC03MTMsOSArNzEzLDggQEAgc3RhdGljIHZhZGRyIGhleGFnb25fcG9pbnRlcl93cmFw
KENQVVN0YXRlICpjcywgaW50IG1tdV9pZHgsCiAjZW5kaWYKIAogc3RhdGljIGNvbnN0IFRDR0NQ
VU9wcyBoZXhhZ29uX3RjZ19vcHMgPSB7Ci0gICAgLyogTVRUQ0cgbm90IHlldCBzdXBwb3J0ZWQ6
IHJlcXVpcmUgc3RyaWN0IG9yZGVyaW5nICovCiAgICAgLmd1ZXN0X2RlZmF1bHRfbWVtb3J5X29y
ZGVyID0gVENHX01PX0FMTCwKLSAgICAubXR0Y2dfc3VwcG9ydGVkID0gZmFsc2UsCisgICAgLm10
dGNnX3N1cHBvcnRlZCA9IHRydWUsCiAgICAgLmluaXRpYWxpemUgPSBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0LAogICAgIC50cmFuc2xhdGVfY29kZSA9IGhleGFnb25fdHJhbnNsYXRlX2NvZGUsCiAg
ICAgLmdldF90Yl9jcHVfc3RhdGUgPSBoZXhhZ29uX2dldF90Yl9jcHVfc3RhdGUsCmRpZmYgLS1n
aXQgYS90YXJnZXQvS2NvbmZpZyBiL3RhcmdldC9LY29uZmlnCmluZGV4IDNjNzNlM2JhZTAxLi4w
Mjg4YTNmNDE2NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L0tjb25maWcKKysrIGIvdGFyZ2V0L0tjb25m
aWcKQEAgLTE2LDYgKzE2LDcgQEAgc291cmNlIHNoNC9LY29uZmlnCiBzb3VyY2Ugc3BhcmMvS2Nv
bmZpZwogc291cmNlIHRyaWNvcmUvS2NvbmZpZwogc291cmNlIHh0ZW5zYS9LY29uZmlnCitzb3Vy
Y2UgaGV4YWdvbi9LY29uZmlnCiAKIGNvbmZpZyBUQVJHRVRfQklHX0VORElBTgogICAgIGJvb2wK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL0tjb25maWcgYi90YXJnZXQvaGV4YWdvbi9LY29u
ZmlnCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi43ZTU1NmYzNTA2Mwot
LS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL0tjb25maWcKQEAgLTAsMCArMSwyIEBA
Citjb25maWcgSEVYQUdPTgorICAgIGJvb2wKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21l
c29uLmJ1aWxkIGIvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggNTI4YmVjYTNjZDAu
LmJjN2EyOTJlNDdiIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAorKysg
Yi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtMjM1LDYgKzIzNSw3IEBAIGRlY29kZXRy
ZWVfdHJhbnNfZnVuY3NfZ2VuZXJhdGVkID0gY3VzdG9tX3RhcmdldCgKICAgICBjb21tYW5kOiBb
cHl0aG9uLCBmaWxlcygnZ2VuX3RyYW5zX2Z1bmNzLnB5JyksIHNlbWFudGljc19nZW5lcmF0ZWQs
ICdAT1VUUFVUQCddLAogKQogaGV4YWdvbl9zcy5hZGQoZGVjb2RldHJlZV90cmFuc19mdW5jc19n
ZW5lcmF0ZWQpCitoZXhhZ29uX3NvZnRtbXVfc3MgPSBzcy5zb3VyY2Vfc2V0KCkKIAogaGV4YWdv
bl9zcy5hZGQoZmlsZXMoCiAgICAgJ2NwdS5jJywKQEAgLTI1Myw2ICsyNTQsMTQgQEAgaGV4YWdv
bl9zcy5hZGQoZmlsZXMoCiAgICAgJ21tdmVjL3N5c3RlbV9leHRfbW12ZWMuYycsCiApKQogCito
ZXhhZ29uX3NvZnRtbXVfc3MuYWRkKGZpbGVzKAorICAgICdjcHVfaGVscGVyLmMnLAorICAgICdo
ZXhfbW11LmMnLAorICAgICdoZXhfaW50ZXJydXB0cy5jJywKKyAgICAnaGV4c3dpLmMnLAorICAg
ICdtYWNoaW5lLmMnLAorKSkKKwogIwogIyBTdGVwIDQuNQogIyBXZSB1c2UgZmxleC9iaXNvbiBi
YXNlZCBpZGVmLXBhcnNlciB0byBnZW5lcmF0ZSBUQ0cgY29kZSBmb3IgYSBsb3QKQEAgLTI2Miw3
ICsyNzEsOCBAQCBoZXhhZ29uX3NzLmFkZChmaWxlcygKICMgICAgIGlkZWYtZ2VuZXJhdGVkLWVu
YWJsZWQtaW5zdHJ1Y3Rpb25zCiAjCiBpZGVmX3BhcnNlcl9lbmFibGVkID0gZ2V0X29wdGlvbign
aGV4YWdvbl9pZGVmX3BhcnNlcicpCi1pZiBpZGVmX3BhcnNlcl9lbmFibGVkIGFuZCAnaGV4YWdv
bi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycworaWYgaWRlZl9wYXJzZXJfZW5hYmxlZCBhbmQg
KCdoZXhhZ29uLWxpbnV4LXVzZXInIGluIHRhcmdldF9kaXJzIG9yCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJ2hleGFnb24tc29mdG1tdScgaW4gdGFyZ2V0X2RpcnMpCiAgICAgaWRlZl9w
YXJzZXJfaW5wdXRfZ2VuZXJhdGVkID0gY3VzdG9tX3RhcmdldCgKICAgICAgICAgJ2lkZWZfcGFy
c2VyX2lucHV0LmguaW5jJywKICAgICAgICAgb3V0cHV0OiAnaWRlZl9wYXJzZXJfaW5wdXQuaC5p
bmMnLApAQCAtMzkwLDMgKzQwMCw0IEBAIGFuYWx5emVfZnVuY3NfZ2VuZXJhdGVkID0gY3VzdG9t
X3RhcmdldCgKIGhleGFnb25fc3MuYWRkKGFuYWx5emVfZnVuY3NfZ2VuZXJhdGVkKQogCiB0YXJn
ZXRfYXJjaCArPSB7J2hleGFnb24nOiBoZXhhZ29uX3NzfQordGFyZ2V0X3N5c3RlbV9hcmNoICs9
IHsnaGV4YWdvbic6IGhleGFnb25fc29mdG1tdV9zc30KLS0gCjIuMzQuMQoK

