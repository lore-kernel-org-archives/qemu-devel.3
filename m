Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B58C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNO-0002sU-Fw; Sat, 01 Mar 2025 00:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNM-0002s0-El
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNK-00086d-Mp
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:00 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MEHX026205
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 951esFdYkWu3xZaxeuku6ERRo1DPG++RhZB0SBL6RZc=; b=DOICBWRy32gSbIYp
 XERtU68Eb9hmm6H0O2ePjqWrto69MMEGk6Mp5xsVLjN1PGj2+zf5exK+6E5Fka/B
 tTbGATP/57u/EdrRapzVQeUHwdHPzLb/yjp6fU/KVLFNRn57GxhFeuJzOG4K85Ab
 wSVfKwOiesIy9Y9ZKd2OtqGE5zk5afkUrtD4eqHVwFE09YBcop2zlr6sQfi4aVvr
 XUxkP7dlgExkPKPQ1mlxiSlOsf4w1FmvSMJ+rn68H/yVCAyVQRQ5USvHg9jm6KK5
 /EnM88kRwqzHvzn1lqJd2h3d+XYxnTSt2w0oWOik7C7ieuNpHZ55M3qgFheQXIbJ
 XCiJEg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95r61y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:26:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2feb5cd04a0so3857494a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806816; x=1741411616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=951esFdYkWu3xZaxeuku6ERRo1DPG++RhZB0SBL6RZc=;
 b=v3sWAnjorWfOiyfgbXSk7cd2RVArutxoW1BdqVTWZsbJg3fYOqVRdvFyipH7B30Q1r
 lLXm+mze1RCYqd5qxPVFM/XyuPbvl6cZ24xHnYNACcdOg5DAI8Lp5ZhLRuCJea228S8J
 4t0fEnDtpPNEiCqITBdilS7fEyZWI9FGAhRN3Ohw9HgiRkUv6JIkIvK4xWjzsZg56C5c
 s1OtdrOfeCi2iXuk5UBaJ9G2/nm1i4Eyd/PTw+jf94w2pUY6/Gn+04k1iciguh+hbrVa
 y36SLY24p55El4Q+uSLI30h4OvYumR7dBi/dohzwT8DxnJ/3wZil1y3OLuroH7/zSGVh
 luXA==
X-Gm-Message-State: AOJu0YwCCQudLnw6SIZTXONPXaD5a5XhNG40Y3jCPNQWxApMbjNYChoI
 ljVJDv0j+zM/P34t5ynhet1dNkHr7UZMCt2gjz5goT2LLNIftf1beGgcQFOuq8fv2wAnlDlRV1X
 zQJcQbHNXX0Nod0a45EM3Hx7g2Z6MyYuJx0PTn0d4fZAyZBBEG75WpXQNhFWg/A==
X-Gm-Gg: ASbGnctYWilA0NUn+e61K5SltnkYx2isbJhpZwR4zi1KVmzG16iUwBvysqFGl9WxtLk
 pfr9uGIYoiBdMkS7mFxLATgU/K/a05PTexJzLRLREob63RDOsKOTH8L6Ajw7pVWZgTRXYzrNS3y
 CjS2rQV68niYeEymeTfuljE4B8B5BwJ0LMLWHFIcQfAkW5d8DuKE5oKclk271C/uQF95PHt2lKG
 uJkwJDejllru7vSMD7UqP11PfVj2v674OfOhf29Amx3ElMI5BehI3c8TzyOTrklctIISBlLLy+5
 hK5Cc5ZcYZNBF6gcaXz0fJCYYswuLuMqDnidizoReZXb7U0G/RQbxUoRW/G6S9rq
X-Received: by 2002:a17:90b:17c3:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-2febab78d4cmr10984104a91.18.1740806816082; 
 Fri, 28 Feb 2025 21:26:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqA53srdcIA3Gokpjc89u0RCJXh9U8GkWzH+tRFa7eSVhbFDH/4ozdIdOSfBWjUc3G0coN0Q==
X-Received: by 2002:a17:90b:17c3:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-2febab78d4cmr10984090a91.18.1740806815740; 
 Fri, 28 Feb 2025 21:26:55 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:26:55 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 06/38] target/hexagon: Add privilege check, use tag_ignore()
Date: Fri, 28 Feb 2025 21:25:56 -0800
Message-Id: <20250301052628.1011210-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 2Cj5Xt1KYr59R82UjxC0Wdm4b2nUHxiN
X-Proofpoint-GUID: 2Cj5Xt1KYr59R82UjxC0Wdm4b2nUHxiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1X2JpdHMuaCAgICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2Z1bmNzLnB5
IHwgMzIgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1X2JpdHMuaCBiL3RhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmgKaW5kZXggZmY1OTZl
MmE5NC4uNjU4MmJiNGYxNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCkBAIC0zNyw2ICszNyw4IEBAIGVudW0gaGV4
X2NhdXNlIHsKICAgICBIRVhfQ0FVU0VfUENfTk9UX0FMSUdORUQgPSAgMHgwMWUsCiAgICAgSEVY
X0NBVVNFX1BSSVZfTk9fVVJFQUQgID0gIDB4MDI0LAogICAgIEhFWF9DQVVTRV9QUklWX05PX1VX
UklURSA9ICAweDAyNSwKKyAgICBIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX0dJTlNOID0gMHgwMWEs
CisgICAgSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19TSU5TTiA9IDB4MDFiLAogfTsKIAogI2RlZmlu
ZSBQQUNLRVRfV09SRFNfTUFYICAgICAgICAgNApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Z2VuX3RjZ19mdW5jcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkKaW5kZXgg
YzJiYTkxZGRjMC4uNjViZmEwNDZiOCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Z19mdW5jcy5weQorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2Z1bmNzLnB5CkBAIC0yMSw3
ICsyMSw3IEBACiBpbXBvcnQgcmUKIGltcG9ydCBzdHJpbmcKIGltcG9ydCBoZXhfY29tbW9uCi0K
K2Zyb20gdGV4dHdyYXAgaW1wb3J0IGRlZGVudAogCiAjIwogIyMgR2VuZXJhdGUgdGhlIFRDRyBj
b2RlIHRvIGNhbGwgdGhlIGhlbHBlcgpAQCAtNTAsNiArNTAsMTggQEAgZGVmIGdlbl90Y2dfZnVu
YyhmLCB0YWcsIHJlZ3MsIGltbXMpOgogCiAgICAgZi53cml0ZSgiICAgIEluc24gKmluc24gR19H
TlVDX1VOVVNFRCA9IGN0eC0+aW5zbjtcbiIpCiAKKyAgICBpZiAiQV9QUklWIiBpbiBoZXhfY29t
bW9uLmF0dHJpYmRpY3RbdGFnXToKKyAgICAgICAgZi53cml0ZShkZWRlbnQoIiIiXAorI2lmZGVm
IENPTkZJR19VU0VSX09OTFkKKyAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhf
Q0FVU0VfUFJJVl9VU0VSX05PX1NJTlNOKTsKKyNlbHNlCisiIiIpKQorICAgIGlmICJBX0dVRVNU
IiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKKyAgICAgICAgZi53cml0ZShkZWRlbnQo
IiIiXAorI2lmZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRf
dGIoY3R4LCBIRVhfQ0FVU0VfUFJJVl9VU0VSX05PX0dJTlNOKTsKKyNlbHNlCisiIiIpKQogICAg
IGlmIGhleF9jb21tb24ubmVlZF9lYSh0YWcpOgogICAgICAgICBmLndyaXRlKCIgICAgVENHdiBF
QSBHX0dOVUNfVU5VU0VEID0gdGNnX3RlbXBfbmV3KCk7XG4iKQogCkBAIC05Nyw2ICsxMDksMTEg
QEAgZGVmIGdlbl90Y2dfZnVuYyhmLCB0YWcsIHJlZ3MsIGltbXMpOgogICAgICAgICBpZiByZWcu
aXNfd3JpdHRlbigpOgogICAgICAgICAgICAgcmVnLmxvZ193cml0ZShmLCB0YWcpCiAKKyAgICBp
ZiAoCisgICAgICAgICJBX1BSSVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddCisgICAg
ICAgIG9yICJBX0dVRVNUIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXQorICAgICk6Cisg
ICAgICAgIGYud3JpdGUoIiNlbmRpZiAgIC8qIENPTkZJR19VU0VSX09OTFkgKi9cbiIpCiAgICAg
Zi53cml0ZSgifVxuXG4iKQogCiAKQEAgLTEyMSwxOCArMTM4LDcgQEAgZGVmIG1haW4oKToKICAg
ICAgICAgICAgIGYud3JpdGUoJyNpbmNsdWRlICJpZGVmLWdlbmVyYXRlZC1lbWl0dGVyLmguaW5j
IlxuXG4nKQogCiAgICAgICAgIGZvciB0YWcgaW4gaGV4X2NvbW1vbi50YWdzOgotICAgICAgICAg
ICAgIyMgU2tpcCB0aGUgcHJpdiBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAgIGlmICJBX1BSSVYi
IGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgotICAgICAgICAgICAgICAgIGNvbnRpbnVl
Ci0gICAgICAgICAgICAjIyBTa2lwIHRoZSBndWVzdCBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAg
IGlmICJBX0dVRVNUIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKLSAgICAgICAgICAg
ICAgICBjb250aW51ZQotICAgICAgICAgICAgIyMgU2tpcCB0aGUgZGlhZyBpbnN0cnVjdGlvbnMK
LSAgICAgICAgICAgIGlmIHRhZyA9PSAiWTZfZGlhZyI6Ci0gICAgICAgICAgICAgICAgY29udGlu
dWUKLSAgICAgICAgICAgIGlmIHRhZyA9PSAiWTZfZGlhZzAiOgotICAgICAgICAgICAgICAgIGNv
bnRpbnVlCi0gICAgICAgICAgICBpZiB0YWcgPT0gIlk2X2RpYWcxIjoKKyAgICAgICAgICAgIGlm
IGhleF9jb21tb24udGFnX2lnbm9yZSh0YWcpOgogICAgICAgICAgICAgICAgIGNvbnRpbnVlCiAK
ICAgICAgICAgICAgIGdlbl9kZWZfdGNnX2Z1bmMoZiwgdGFnLCB0YWdyZWdzLCB0YWdpbW1zKQot
LSAKMi4zNC4xCgo=

