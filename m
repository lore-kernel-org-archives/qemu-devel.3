Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A09BF8D77C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTsD-0000AS-5m; Thu, 16 Apr 2026 17:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTs4-0008W9-Tx
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTs2-00010U-Is
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GJj2aq2652259
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dalz+aimR/zYCYAnc4cJTc09a9iXBszukXk0/4hGSTk=; b=VhrGZwof5UixGwuY
 A+5dJKWFf7Fy7GjZ4D+oFssG4HkyW1/O93Dh5FlArMMsE4mC4Hs7X+6g6TrbTQFX
 6oI3s6eMAUjJij6AYyuDIn8w9pPM/xECKppzPRGqkfFdTMklXTard3005INqkJ3G
 GO3a+ZHO+ABo1q0VX7EfnB/Rvs51nGZDJwExFaA24xrtAFF7cgzYonXw82jDRwC0
 XP1z1m/LsDRSKX7ghwRynTIZbHrX9L1EkAN/lOgvIw7Mi9aYLFgmj//+7g5pwEiC
 mPpYNvLMT5SxKtCh8kd9YC/P72Tkr4wwSgu5eZP7V4ztaKhDVrHMG7jTNU/PAS2J
 qM+1Rg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtfuk3a2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c16233ee11so12242628eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776373407; x=1776978207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dalz+aimR/zYCYAnc4cJTc09a9iXBszukXk0/4hGSTk=;
 b=Qg52rtmGWisgO168THXh8BjRbwSqjmX7lhNBlx2690eZSmWJ++vqasoY4BAQ7roOzi
 IOJq56g8zDhxcBwWMW0jL3EeFjWC+kpMBd0mZrDlh636sWhddsoo5Y+K2LFlGZqQuC7P
 gEVXrkATw/tBKdh9K7Mm425+96Z0VxtsnTauBkcBV+M1hPwTMrMBpWg6yEU7OVaraqkK
 MT9mcMp75mwA614tDdVsM1WkRtq1gp5Utrypm+emLJojmuBXZxgrS02ifcHQMkrW3Za/
 wclCVd5UYowhefPH1IJZZ6jNC2Q5ENL+ga9OGCvcZW+GmZz/+DElQmg2MosobTdrr31b
 0Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373407; x=1776978207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dalz+aimR/zYCYAnc4cJTc09a9iXBszukXk0/4hGSTk=;
 b=MJ2yYlL3WoGR85fZfo07IsXkN5k2tcYke4WhDVJWwQBqxvDgibJRekQIqP+6GVpbSK
 qLtbMp9rcor0IIEYDdedlaWuZZm8hTrcOt3KJpDCJf1VS8YtHJ2PmVlXAj2hzRlQJuUO
 nlF1JVLFIoNnZuERkqAp6tU1IGEXwKqwKKigVXuVtCT9Nrgk1uHjmb6brPIdawNanQZN
 zxAIPIXLfI+713A3MoctknmhkTq0LE+9MHF4EarY5L3co2Abvl1sp8XFbU0Ik8L79/9S
 tgHOyaWQ+LnHMkaf0Cwbf+dR3OhZSB+xABdSa8NuCMppzTQtrrdy5vThjJI5miinrxit
 fUBA==
X-Gm-Message-State: AOJu0Yw5CgIIgYirFVl4BDsWZyyURxmWH3PL+dl1DNDfaOAn9yr0lHKp
 6GSp/Rj4NdgoZ3x+qvTaAEMhlVfgWdy/cMmDcc0jX/8wHPo2vsh537pmzZTWljBwdKOmp/qiA9b
 E/iL9z3e0N2uXbb26GD6A/7DgP01DnteDh4GLFmdgBLe8MIlSMuanZKQtW00s4j7gEw==
X-Gm-Gg: AeBDievOPi5J6CjdNMi8qnkOg6LpbJvp3QwgeNgHT4hNy9Srgh9WgiRz1DMGL08ht15
 Il0fXHh3nwTABponsSHyLDTqE52w8gVWaB4rOoLzmxFsM7nkp/dtpcy3B7cEeQPSSLNI+S0kq3F
 W1cxQNtngaJ9NQ9KC5C/ssj4AHydqOkALjQi+CkcbwV5ijgLkf+08lmIReGcDNxAN/95MyzoSJq
 UyEUZL3y00Gbv/gyMI4GCjGd187IuX0Ow5qt+71S3eKCLQPuQzKSIGTvErwypaSj5gOD6aheCz4
 NOzzqqsCDmY/cWabFdRVhHPIeC0VG4pEtd1d1GOvEGcVrcEeFi89vrqL2wQo9CmUZxPVGcOaiva
 dAFVOAWQoZ25RQW5LzmSBjpVwLkgpBfBoA4hQje/yzhPFgfHFG18AmSo1FwJ1s+L0+V5HN0kvLF
 tUMzoq
X-Received: by 2002:a05:693c:2c81:b0:2dd:8a02:e8bb with SMTP id
 5a478bee46e88-2e2e5614fd7mr519958eec.27.1776373406871; 
 Thu, 16 Apr 2026 14:03:26 -0700 (PDT)
X-Received: by 2002:a05:693c:2c81:b0:2dd:8a02:e8bb with SMTP id
 5a478bee46e88-2e2e5614fd7mr519934eec.27.1776373406332; 
 Thu, 16 Apr 2026 14:03:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c90cd7esm11176277eec.13.2026.04.16.14.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 14:03:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 7/9] target/hexagon: add build config for softmmu
Date: Thu, 16 Apr 2026 14:03:03 -0700
Message-Id: <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: MFgjW2Du0PXtQM9-eHCQRAoBX4qaWo81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE5OSBTYWx0ZWRfX6tE5YJpvc7E+
 8OZBDEHT1Qpe9goGiEd8fm6iBNkKS0lYE7kTZEcDFjt4wrRdF5kUn9BFKF1qsqqme98W4olutWZ
 2D366SVDR0l//YwUrhEiQaDXWw/omN9mLRSz9XFje1N81pBTxce0eKlWdiZugsDMbhZCJs+KSAL
 +Fvb4FqwQOv1oPbz3qQENBtkj8eGU3epR0FS3PB99UBGCnCvCSkaE+fdfs4nk8/sBPLnQmA7KP4
 P5EcVo7yt8jdDAwnHLPaa1pJ2V2G4k45SM3k6/si1hzxQ+UgDBVq6zQctQTrL+zwAIi3GM9tI2T
 A44p3dUOq6ltE0rsGXPSiAE24wk/P8y8Ek42FWUYT4DcyG3B0+eEfTZvC7qTt0zPCvCRd5kr2ij
 UkehdtcWSJDBctfYqm/QJmKrdrZH2YmiNvzbH7hTps/leU4W1aPag2Hrcjs/geppqMayiOLp6di
 N5njGD0VV12Px1XXBtw==
X-Proofpoint-GUID: MFgjW2Du0PXtQM9-eHCQRAoBX4qaWo81
X-Authority-Analysis: v=2.4 cv=KrF9H2WN c=1 sm=1 tr=0 ts=69e14ea0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Jl0Sl96qzwJOXFZnYegA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160199
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

