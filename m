Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FE710F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV2-0001Ze-ME; Wed, 01 Apr 2026 11:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUk-00013l-4s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUi-000887-4K
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631FRJ8S1579382
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=; b=XcDCgc3+rg05cySV
 LoHByd3vTeCTQaUlSdEZFjdmnGZ/Mf9sk7gNwizKz8WOVTLgXmQmE1oqBR2exC1Q
 4+EUg85XdqsYvn3ffJT/k1BEbGwISJu1Am5VV5fUOPE/jnn/A/RudlnBUDnyN9Ya
 siBGHfAu6SjQlncbdp0s6Uiz9ZZhLz9inUjJsV0Nx2zpuY+UWrPLV+TOCrMUqD+0
 924hRyPTyRGYMVRxcRQKNx+73YmUaAxYvMbkDt+kWOrsEcBO9D7IqHcdOnMn2W2Z
 sXBHOKG9tG8FRA/jZkqinKotfefaSuLHfVFgYyBG/cl075dq/Wb1GJONO+EPmxBc
 Sk43Sw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2vbnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so8888147eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057295; x=1775662095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=RR1piDSOLmfql3FG+ypq0qUQtii/vHQywaUDUm/QLlBTtBhbIL/NFIiwVpOnihnPea
 b6NfI0rL0laW+YOb8SuYTXMtBdm3EVbGvCJzFHZnuRKRVT8b44Q0Z87dQGE0OiZtkGkq
 V0c9FW2/PYe9E+MisgKvAnUuQPf42Ne1PpHT3j5Ia8PBP8C1a7fdz84c8J32J58w5PrW
 FxMFV8tlQXPuoiEKSJrx/P7/E3UyPs4YA3/vnKjYHC8a34rAdQxP3AVVSaa7AcDVzR0p
 itp36KOPxO5KpBpOrPir27TEcQJwidt9DvSHNQ74AamA9JsNHUqhT5flFP4JGhp1B2R4
 RJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057295; x=1775662095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=Y/1VBwDB/ogSQKjbLxqeZGRONJr4bidMy/FuVo6gmqA/cSjPPF4wH2HNKr/Bueg5XG
 iACffEIHVdt6QIUZ+5QCX5Gzk0hP1DHL5Dvc7ZBOcLSx8BpIU5DtstY30QIhq0EUxy1E
 LhtiEzR/AnGDo8+pm9nTUbSwcHoRH96BSFRvUpKQhEvIVspl/hx+ekBqCXGijlnesXmq
 G/klMcd4LMiE3BX8YODo+YarwLyZ8IeTw62fpwMzSuJMHe/GXzIawFJLUia9ygC9eQne
 AZC2DSr327TsfgD5AtwC4A4bGXPJyK7lL8VxhOgcM3XzyoOUXBQJba8cbKYNhkfCSCkj
 bcWg==
X-Gm-Message-State: AOJu0YwksemoQ4oe0gVsOT9BXuz7MlDDvVMQYZbgFd00BOKUxdupXYmJ
 AzLXxmrdd1NBKTkBJD7e07EnXyKF7bpiYI+ThK//ruNbwPAFP1rNclog4p7/yGMw16oS5sVGxka
 MnckuehX3c6lkRSIRCNDUeQ+mcs6N5uQwbRJhWyUbuxX09g1OAoUCTEH/x6Gmpx3jEg==
X-Gm-Gg: ATEYQzzAoq2P74Yu4KES4O3ilo/NRWRcL3AjEUmVRyBiR1/drn8fvIR/rib3RDQvcKj
 Hkeu1sYz6lpFcC3UXgbAoppSZ135KR1JphwD1ueKY6gOEeXpKbHtIgx72KlDkzBFVqn8K/5yhB6
 nN90mt1ErgylEnka1qnejQm9O52/JEUKtOZZb505CYaM1xvwYKWDrJvVuk8s3OOE2FvVOElAyXW
 xt3vPv2U0PF2GynB1qX9cZx0U6efLX0kKxuoOteJ5XB/SLj+qh+kTcknfS4y+UtEY5ujyRRDcV9
 87irQjGIVGxgr36whe+9qruaXq1E6c9zAlNeWsc0b4i0awavIu6RApXqPg2nBaoiHKPyoLXqL+9
 q4TmD+SRIO9SNh6cXDkis7wFj3OqgqQfFH+A0KGT475wDOb6XRzW23+fxw3/qEumyvnM94g==
X-Received: by 2002:a05:7301:3d06:b0:2c4:c8de:cdcc with SMTP id
 5a478bee46e88-2c9326aa24bmr2130485eec.22.1775057294688; 
 Wed, 01 Apr 2026 08:28:14 -0700 (PDT)
X-Received: by 2002:a05:7301:3d06:b0:2c4:c8de:cdcc with SMTP id
 5a478bee46e88-2c9326aa24bmr2130459eec.22.1775057294181; 
 Wed, 01 Apr 2026 08:28:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v6 32/37] target/hexagon: Add pcycle setting functionality
Date: Wed,  1 Apr 2026 08:26:52 -0700
Message-Id: <20260401152657.314902-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69cd3997 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OF6xqQKflNrgTLtdKXcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: olFzK7aPobLLXtV1ybq2TuWIrjmBQPhF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX8yH9nIfxd+wJ
 aBzHyjhty1SPtD1Xd1XRduMFnXTTCMUO+1F+dechC3wIWq6Df1TQTMHo1i39K0sS+8MWE8z01ZX
 s3fPWWP8GZ5FjRnTAufDnX6rhH4Fj15/aDwaOYvmqQtC5SfAJSiiskYcS8qb6BSPc2OQtizBcwU
 unF5v4RqrN/Zng/PWpmSNTTsP3ZXy5gs4g46W20xPV6AdBrvw1/7WePK1WraeKkwEZ7hO+JljpK
 FajAWSnZBUtEJGHv3VkSSMfzKjuV5sCA4iFXOocLsPbLQQpk3fJ8/r1PXKHr02VI+AkBzUhwFbX
 on4wGHETbu4JMybC9XA7NI1JtqJrfpFv9w22T1mZFKid17KsSLXFaOhuVBso2NoL9PzPKgxFIa6
 xTYpPhjYIoR/9r1O7BnCY8l+4PbY4Dj9A5mi1KLw0wT6KeIfuUF/JW9r+TV/fkmCRurHJX3pvbJ
 c2hONRbjun2N+Lv3tNA==
X-Proofpoint-GUID: olFzK7aPobLLXtV1ybq2TuWIrjmBQPhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

UmVwbGFjZSBwY3ljbGUgc2V0IHN0dWJzIHdpdGggcmVhbCBpbXBsZW1lbnRhdGlvbnMgdGhhdApk
aXN0cmlidXRlIGN5Y2xlIGNvdW50IGNoYW5nZXMgYWNyb3NzIGFsbCBhY3RpdmUgdGhyZWFkcy4K
ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGJiOTkxYTY3MWU4Li42NGM1NzQ2YzZkOSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYwpAQCAtNTYsMTcgKzU2LDU0IEBAIHVpbnQzMl90IGhleGFnb25fZ2V0
X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KQogCiB2b2lkIGhleGFn
b25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdmFsKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3Qgb2xk
OworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBvbGQgPSBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgb2xkID0gZGVwb3NpdDY0KG9sZCwgMzIsIDMyLCB2
YWwpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwogfQogCiB2
b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50
NjRfdCBvbGQ7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIG9sZCA9IGhleGFn
b25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAw
LCAzMiwgdmFsKTsKKyAgICBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KGVudiwgb2xkKTsK
IH0KIAogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50NjRfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBD
UFVTdGF0ZSAqY3M7CisgICAgdWludDY0X3QgdG90YWw7CisgICAgaW50IG51bV90aHJlYWRzOwor
ICAgIGludDY0X3QgZGVsdGEsIHBlcl90aHJlYWQsIHJlbWFpbmRlcjsKKworICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CisgICAgdG90YWwgPSBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudik7CisKKyAgICAvKiBDb3VudCBhY3RpdmUgdGhyZWFkcyAqLworICAgIG51bV90aHJlYWRz
ID0gMDsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBudW1fdGhyZWFkcysrOworICAg
IH0KKyAgICBnX2Fzc2VydChudW1fdGhyZWFkcyA+IDApOworCisgICAgLyoKKyAgICAgKiBEaXN0
cmlidXRlIHRoZSBkZWx0YSBldmVubHkgYWNyb3NzIGFsbCB0aHJlYWRzLgorICAgICAqIEFueSBy
ZW1haW5kZXIgZ29lcyB0byB0aGUgY2FsbGluZyB0aHJlYWQuCisgICAgICovCisgICAgZGVsdGEg
PSAoaW50NjRfdCkodmFsIC0gdG90YWwpOworICAgIHBlcl90aHJlYWQgPSBkZWx0YSAvIG51bV90
aHJlYWRzOworICAgIHJlbWFpbmRlciA9IGRlbHRhIC0gcGVyX3RocmVhZCAqIG51bV90aHJlYWRz
OworCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0aHJl
YWRfZW52ID0gY3B1X2Vudihjcyk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfY3ljbGVfY291bnQg
Kz0gcGVyX3RocmVhZDsKKyAgICB9CisgICAgZW52LT50X2N5Y2xlX2NvdW50ICs9IHJlbWFpbmRl
cjsKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52KQotLSAKMi4zNC4xCgo=

