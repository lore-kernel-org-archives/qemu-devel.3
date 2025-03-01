Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA92AC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 17:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toQWe-0003Ca-6I; Sat, 01 Mar 2025 12:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWO-0003A6-IS
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWM-0008Rl-Ly
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:04 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 521FU2sE019495
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 17:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oowa8xzNbisARaR2AAsHXbMLYCEW7CydVAB/AuyNvzg=; b=RI+8mF4jk2AoTEIH
 KQENK7pS+pINXa94dLA81Ci50KcoPqTkUP+Iw410ce6Le7BTuwAHK7yZMZ8m60tX
 ySo3t1Uk3hEYN+vGvoME9fLSU3EX3IWda9NLcYmrtSm95rObdI0yie1FAmCiiM/u
 EuIV1lZz4N95VLNZn0/q2UrkLusa26GwsWZYMDCS5aodnSDzGz6VpaLJ37zQf2gv
 Sj0hNHz+pOEKvK3GsW5CEIGjgw8gRPswRJfwfC8HCSUb7a/GUNbm9vdd/qXsvce/
 rXbBPCvy+q8gxcqYQxgmric+t/FTgQPssF5YVzNk3/fc2lQPOpA2u8S29ljaovAh
 iSe3cA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k1478-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 17:21:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fecd603bb8so2069930a91.3
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 09:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740849660; x=1741454460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oowa8xzNbisARaR2AAsHXbMLYCEW7CydVAB/AuyNvzg=;
 b=eUW293nIoBLyQWSv43Re8fLB6K2b7MI4HlApnaabiS1BUP2QT7XpH0Od879tJctIi+
 EN42re1wyJfbXGZrMnE4DqOxemQXMWwMAH9+KcktgnO3xCd4Kr6OgQUirRt5qswrim4S
 3whqJBR42HUGefwOrB+r+++Yzq5BDBDkkNEe3Rku0ZhyZlzjS1tUhVrB46R+b1WiBJTc
 qPRoCGmowCmz29ujIEG+M8yq+IaCW4LqrrtOU46uVJ08BtpsOemSXEr/GW8gy/JiZiTp
 GcuPWLr4Sh1Wy4JXjPTD8HSVUG7flftwDYTdbPFcK3lOHOYeZ0/eNDf27Ml7vWIfxK1Q
 2V9w==
X-Gm-Message-State: AOJu0Yz1VAnkHMWSmDkJS1ht+2Ps4ZNWtcgA8093KdDaEoxYBbjmR0sM
 TfIxT+GbK7Qm4S0CSX4SEMnKbg5yfZO8fCzUFtsIHA2L3FUwyzxXTf9ue+jm8i+98dSd7ezRYzh
 wMbXLTkUK32BjXawqwlNrrQO076OIRpPhQH9PVrqmjpL15WKhet9ffe4gPmvYpg==
X-Gm-Gg: ASbGnctsnPetne/mZgrYSDzsySnKT7unN5wA54AsJ/Ab86ouqNy6HqGhhdEwM2qyCsA
 IRbRlDUa9pPOryRrDE0T/1nkAsvkxl2gSu5J1HTOGCFDIJg3VjoaK+WqWDJSdprwwxnWBzjHPqp
 naIqOqCDgn2PrZozRzl4kTsJyvVnej1Wd9O5daLnFWaeEU26O85+p2k8u9x6sXkGwp40dCbzmoR
 5rpV2OkmU8GYyUtKR+XeN3SvyKXp7ekh7TdkdXGb7Om1+Ttt/O2ZcZ2Kvq+p9otwn3eUdLmiqFM
 bscEi/CXCrm6+qOo4UDgwAvAinL50EtpBS8dQcKwsJNP0YrBL148uT/CzIlyL8Be
X-Received: by 2002:a17:90b:4acb:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-2febab2ed94mr13301142a91.7.1740849660122; 
 Sat, 01 Mar 2025 09:21:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsFOQuVIv52osRMr2gU5oL5hhftm62jjmjvQlRBDSHVqzFnRKLU0Q0KvNZpoaKRVWMLqXUkw==
X-Received: by 2002:a17:90b:4acb:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-2febab2ed94mr13301108a91.7.1740849659687; 
 Sat, 01 Mar 2025 09:20:59 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9dacsm51308275ad.83.2025.03.01.09.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 09:20:59 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6/8] target/hexagon: add build config for softmmu
Date: Sat,  1 Mar 2025 09:20:43 -0800
Message-Id: <20250301172045.1295412-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 7REFEGQyfTS8CKpaDqCUe-maZo8gDQZi
X-Proofpoint-ORIG-GUID: 7REFEGQyfTS8CKpaDqCUe-maZo8gDQZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=869 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010139
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxICsKIGNv
bmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsgfCA3ICsrKysrKysKIGNv
bmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrICAgICAgICAgfCA2ICsrKysrKwogdGFy
Z2V0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEgKwogdGFyZ2V0L2hl
eGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8IDIgKysKIHRhcmdldC9oZXhhZ29u
L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgfCA5ICsrKysrKysrKwogNiBmaWxlcyBjaGFu
Z2VkLCAyNiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZmlncy9kZXZpY2Vz
L2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawogY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3Mv
dGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hl
eGFnb24vS2NvbmZpZwoKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5k
ZXggMGZiNTcxMTE4NC4uZGVlYjc4NzhjOCAxMDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIv
TUFJTlRBSU5FUlMKQEAgLTI0MSw2ICsyNDEsNyBAQCBGOiBsaW51eC11c2VyL2hleGFnb24vCiBG
OiB0ZXN0cy90Y2cvaGV4YWdvbi8KIEY6IGRpc2FzL2hleGFnb24uYwogRjogY29uZmlncy90YXJn
ZXRzL2hleGFnb24tbGludXgtdXNlci9kZWZhdWx0Lm1haworRjogY29uZmlncy9kZXZpY2VzL2hl
eGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawogRjogZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1o
ZXhhZ29uLWNyb3NzLmRvY2tlcgogRjogZ2RiLXhtbC9oZXhhZ29uKi54bWwKIEY6IGRvY3Mvc3lz
dGVtL3RhcmdldC1oZXhhZ29uLnJzdApkaWZmIC0tZ2l0IGEvY29uZmlncy9kZXZpY2VzL2hleGFn
b24tc29mdG1tdS9kZWZhdWx0Lm1hayBiL2NvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUv
ZGVmYXVsdC5tYWsKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uMDhlNzA5
YWVhNwotLS0gL2Rldi9udWxsCisrKyBiL2NvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUv
ZGVmYXVsdC5tYWsKQEAgLTAsMCArMSw3IEBACisjIERlZmF1bHQgY29uZmlndXJhdGlvbiBmb3Ig
aGV4YWdvbi1zb2Z0bW11CisKKyMgVW5jb21tZW50IHRoZSBmb2xsb3dpbmcgbGluZXMgdG8gZGlz
YWJsZSB0aGVzZSBvcHRpb25hbCBkZXZpY2VzOgorCisjIEJvYXJkcyBhcmUgc2VsZWN0ZWQgYnkg
ZGVmYXVsdCwgdW5jb21tZW50IHRvIGtlZXAgb3V0IG9mIHRoZSBidWlsZC4KKyMgQ09ORklHX0hF
WF9EU1A9eQorIyBDT05GSUdfTDJWSUM9eQpkaWZmIC0tZ2l0IGEvY29uZmlncy90YXJnZXRzL2hl
eGFnb24tc29mdG1tdS5tYWsgYi9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hawpu
ZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwLi44YzIwOGJmNDY4Ci0tLSAvZGV2
L251bGwKKysrIGIvY29uZmlncy90YXJnZXRzL2hleGFnb24tc29mdG1tdS5tYWsKQEAgLTAsMCAr
MSw2IEBACisjIERlZmF1bHQgY29uZmlndXJhdGlvbiBmb3IgaGV4YWdvbi1zb2Z0bW11CisKK1RB
UkdFVF9BUkNIPWhleGFnb24KK1RBUkdFVF9TVVBQT1JUU19NVFRDRz15CitUQVJHRVRfWE1MX0ZJ
TEVTPWdkYi14bWwvaGV4YWdvbi1jb3JlLnhtbCBnZGIteG1sL2hleGFnb24taHZ4LnhtbCBnZGIt
eG1sL2hleGFnb24tc3lzLnhtbAorVEFSR0VUX0xPTkdfQklUUz0zMgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L0tjb25maWcgYi90YXJnZXQvS2NvbmZpZwppbmRleCBkMGM3YjU5ZDljLi4zNzc4MTE0NmI5
IDEwMDY0NAotLS0gYS90YXJnZXQvS2NvbmZpZworKysgYi90YXJnZXQvS2NvbmZpZwpAQCAtMTYs
NiArMTYsNyBAQCBzb3VyY2Ugc2g0L0tjb25maWcKIHNvdXJjZSBzcGFyYy9LY29uZmlnCiBzb3Vy
Y2UgdHJpY29yZS9LY29uZmlnCiBzb3VyY2UgeHRlbnNhL0tjb25maWcKK3NvdXJjZSBoZXhhZ29u
L0tjb25maWcKIAogY29uZmlnIFRBUkdFVF9CSUdfRU5ESUFOCiAgICAgYm9vbApkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vS2NvbmZpZyBiL3RhcmdldC9oZXhhZ29uL0tjb25maWcKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uN2U1NTZmMzUwNgotLS0gL2Rldi9udWxs
CisrKyBiL3RhcmdldC9oZXhhZ29uL0tjb25maWcKQEAgLTAsMCArMSwyIEBACitjb25maWcgSEVY
QUdPTgorICAgIGJvb2wKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkIGIv
dGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYWE3MjlhMzY4My4uZDJiNTZiOWU2NSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvdGFyZ2V0L2hleGFn
b24vbWVzb24uYnVpbGQKQEAgLTI0NSw2ICsyNDUsNyBAQCBkZWNvZGV0cmVlX3RyYW5zX2Z1bmNz
X2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgY29tbWFuZDogW3B5dGhvbiwgZmlsZXMo
J2dlbl90cmFuc19mdW5jcy5weScpLCBzZW1hbnRpY3NfZ2VuZXJhdGVkLCAnQE9VVFBVVEAnXSwK
ICkKIGhleGFnb25fc3MuYWRkKGRlY29kZXRyZWVfdHJhbnNfZnVuY3NfZ2VuZXJhdGVkKQoraGV4
YWdvbl9zb2Z0bW11X3NzID0gc3Muc291cmNlX3NldCgpCiAKIGhleGFnb25fc3MuYWRkKGZpbGVz
KAogICAgICdjcHUuYycsCkBAIC0yNjQsNiArMjY1LDEzIEBAIGhleGFnb25fc3MuYWRkKGZpbGVz
KAogICAgICdtbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMnLAogKSkKIAoraGV4YWdvbl9zb2Z0bW11
X3NzLmFkZChmaWxlcygKKyAgICAnaGV4X21tdS5jJywKKyAgICAnaGV4X2ludGVycnVwdHMuYycs
CisgICAgJ2hleHN3aS5jJywKKyAgICAnbWFjaGluZS5jJywKKykpCisKICMKICMgU3RlcCA0LjUK
ICMgV2UgdXNlIGZsZXgvYmlzb24gYmFzZWQgaWRlZi1wYXJzZXIgdG8gZ2VuZXJhdGUgVENHIGNv
ZGUgZm9yIGEgbG90CkBAIC00MDEsMyArNDA5LDQgQEAgYW5hbHl6ZV9mdW5jc19nZW5lcmF0ZWQg
PSBjdXN0b21fdGFyZ2V0KAogaGV4YWdvbl9zcy5hZGQoYW5hbHl6ZV9mdW5jc19nZW5lcmF0ZWQp
CiAKIHRhcmdldF9hcmNoICs9IHsnaGV4YWdvbic6IGhleGFnb25fc3N9Cit0YXJnZXRfc3lzdGVt
X2FyY2ggKz0geydoZXhhZ29uJzogaGV4YWdvbl9zb2Z0bW11X3NzfQotLSAKMi4zNC4xCgo=

