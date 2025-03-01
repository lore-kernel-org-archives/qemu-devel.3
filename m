Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EBEC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 17:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toQWK-00039I-1a; Sat, 01 Mar 2025 12:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWH-00038l-KG
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:20:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWF-0008QS-Ok
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:20:57 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MEH9026213
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 17:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7WDdMw7b6bXz+vkOUfh5HW
 xkW3Y6G+YNlQtba4fbb4M=; b=ZndEKg2Y0a4hUYVkNomIWjMR5mChOu9WgLJtpJ
 Ne1/laGHPCwbGLBRchpP+7MBQeUjtlx7OG55rV0NHSf4uCgbjsfD9XiAlghsNHf0
 MkbZr49hVBVj2leqzFW94ZyKJWud+sw8rVTJl5jLxKMAg1Uu6qHD5Qe5uC7Twwwg
 0UmCUsEq0dO8lIhyn+ZoCfKQSTT/5ovAR+F28ADl5ClP2x9EJiXTn3Ei8GaxCsVH
 ofVPusTApjgFrFbXHUKkYnWDN9k0b1KaOrpBUdMy1AMjzH092b3gb5DDhLIzPaXf
 eLIUxlVRz2j/Fo/I7e/ujOMY4WsKC+jLTypUvU/OY3JkiD0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95s4ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 17:20:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22380c707d3so11457555ad.1
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 09:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740849652; x=1741454452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7WDdMw7b6bXz+vkOUfh5HWxkW3Y6G+YNlQtba4fbb4M=;
 b=T7PCcHT3s2Moajs07b5rLOjC+XIkvhZjAudsZCtjG31jhcqiZOSAp/X20WzeMr3aXY
 dGEkhfKuWG/jC2hr2SWLZaFEadwSVtns6he+EUwk/92F9R6UPYcx40CxXcNT+kkLJX9S
 k9WZkPDpOqv1BvgzCszIidzsoTCEhEJmelLpHpeKYPDH8a2kNiR/GLIqDV4VByTygarW
 B+IzRud+pqHSEB4OYw8Hvd4SI+TBnV+Jz35lw2eXefl3WtEwLmITX2QA67+jatSdR3Kb
 epboANdAex6QZj879mfQRiXqo8o1F+r39bal1/jWvfKDYKI/IDv8VzhDcsQ3pgL02bVB
 ajOA==
X-Gm-Message-State: AOJu0YxY9BkiQn19EW/tjjJ9hhH91D1ioekj9dC0oQc1fRF6g/IbFTqe
 gMILSDjPCpM4QEBHpisYJRssi9DItoZ5tajTgPFOhBDAlJHiq/yOtwbuaBCc1gZj/beV72HdEKT
 ZusdcdT4/cvIhWFTwpx4ewonwGN1QVH5WzNWEZVhWAQ2n9xvbPJhGRbUryLLXhA==
X-Gm-Gg: ASbGnctuLeNL7tYFd92hdf5oirSArolAmAtRAqaLdqEDxhYVgsej7lePJU2+x3Lz9Vl
 fRYb9LeB6khq8cBekhBCW+Gwd/8AxCf5oCKTEkCa4v6o3T+UHTj75Vv7tphXMZ5UobdYOfZp1BN
 YPVL9YejmmxLRCKwMLeP1/AkxATDQ0QJCmSkA2rPqaaCVp2LFiaQlygaD562cQrK0unPwev6Qst
 XdpHVFw16Rv8plwLSW3N4r6Fu1YFO9D9mWPJNxlOmTCNAZ6thHnLYEL0qzSzbM+amLxp54bosYx
 MLZJnKYDMpqTIFIR19AnUwGaTdMHShOlFtlZFs00UuaQWKi4fnxW1aV35ZVqMkT/
X-Received: by 2002:a17:902:ecd0:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-22368f95a5cmr135754705ad.22.1740849651862; 
 Sat, 01 Mar 2025 09:20:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsWYMaK+zD8IrnsuCCqNYn22UcplbxjlbvO6PzwHKyrXxgEdlMqq83f6t+564616y4DG1jNA==
X-Received: by 2002:a17:902:ecd0:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-22368f95a5cmr135754415ad.22.1740849651385; 
 Sat, 01 Mar 2025 09:20:51 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9dacsm51308275ad.83.2025.03.01.09.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 09:20:51 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH 0/8] hexagon system emu, part 3/3
Date: Sat,  1 Mar 2025 09:20:37 -0800
Message-Id: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: IDzHNg1zFVyYC25q4yB2Fx3w2et9Pzn7
X-Proofpoint-GUID: IDzHNg1zFVyYC25q4yB2Fx3w2et9Pzn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=304 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010140
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

aGV4YWdvbiBhcmNoaXRlY3R1cmUgc3lzdGVtIGVtdWxhdGlvbjogcGFydCAzLzMKClRoaXMgc2Vy
aWVzIGNvbnRhaW5zIHNvbWUgaW5pdGlhbCBtYWNoaW5lIGRlZmluaXRpb25zLCBhbiBpbnRlcnJ1
cHQKY29udHJvbGxlciBkZXZpY2UgYW5kIGEgdGVzdCBjYXNlLiAgSGV4YWdvbiAiU3RhbmRhbG9u
ZSBPUyIgaXMgdXNlZApieSB0aGUgSGV4YWdvbiBTREsgdG8gY3JlYXRlIHNpbXBsZSBiYXJlbWV0
YWwgYm9vdGFibGUgcHJvZ3JhbXMgdGhhdApjYW4gYmUgcnVuIG9uIFFFTVUgb3IgdGhlIGluc3Ry
dWN0aW9uIHNldCBzaW11bGF0b3IgaW5jbHVkZWQgd2l0aAp0aGUgSGV4YWdvbiBTREsuICBUaGVz
ZSBwcm9ncmFtcyBnZW5lcmFsbHkgZGVwZW5kIG9uIHNlbWlob3N0aW5nCnN1cHBvcnQsIHdoaWNo
IHdpbGwgY29tZSBsYXRlci4KCkJyaWFuIENhaW4gKDYpOgogIGh3L2hleGFnb246IEFkZCBtYWNo
aW5lIGNvbmZpZ3MgZm9yIHN5c2VtdQogIGh3L2hleGFnb246IEFkZCB2NjgsIHNhODc3NS1jZHNw
MCBkZWZzCiAgaHcvaGV4YWdvbjogTW9kaWZ5ICJTdGFuZGFsb25lIiBzeW1ib2xzCiAgdGFyZ2V0
L2hleGFnb246IGFkZCBidWlsZCBjb25maWcgZm9yIHNvZnRtbXUKICBody9oZXhhZ29uOiBEZWZp
bmUgaGV4YWdvbiAidmlydCIgbWFjaGluZQogIHRlc3RzL2Z1bmN0aW9uYWw6IEFkZCBhIGhleGFn
b24gbWluaXZtIHRlc3QKClNpZCBNYW5uaW5nICgyKToKICBody9pbnRjOiBBZGQgbDJ2aWMgaW50
ZXJydXB0IGNvbnRyb2xsZXIKICBody9oZXhhZ29uOiBBZGQgc3VwcG9ydCBmb3IgY2ZnYmFzZQoK
IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKwogZG9j
cy9kZXZlbC9oZXhhZ29uLWwydmljLnJzdCAgICAgICAgICAgICAgICB8ICA1OSArKysKIGRvY3Mv
ZGV2ZWwvaW5kZXgtaW50ZXJuYWxzLnJzdCAgICAgICAgICAgICAgfCAgIDEgKwogY29uZmlncy9k
ZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hayB8ICAgOCArCiBjb25maWdzL3Rhcmdl
dHMvaGV4YWdvbi1zb2Z0bW11Lm1hayAgICAgICAgIHwgICA3ICsKIHFhcGkvbWFjaGluZS5qc29u
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KIGluY2x1ZGUvaHcvaGV4YWdvbi9o
ZXhhZ29uLmggICAgICAgICAgICAgICAgfCAxNTEgKysrKysrKwogaW5jbHVkZS9ody9oZXhhZ29u
L3ZpcnQuaCAgICAgICAgICAgICAgICAgICB8ICA0MSArKwogaW5jbHVkZS9ody9pbnRjL2wydmlj
LmggICAgICAgICAgICAgICAgICAgICB8ICAzNyArKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3
NV9jZHNwMC5oLmluYyAgIHwgIDY0ICsrKwogaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjZnXzEw
MjQuaC5pbmMgICAgICB8ICA2NCArKysKIGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0
LmguaW5jICAgICAgfCAgNjUgKysrCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAg
ICAgICAgICAgIHwgMjAyICsrKysrKysrKysKIGh3L2hleGFnb24vdmlydC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAzOTUgKysrKysrKysrKysrKysrKysrCiBody9pbnRjL2wydmljLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNDE3ICsrKysrKysrKysrKysrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstCiB0YXJn
ZXQvaGV4YWdvbi9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICAgIHwgICAxIC0KIGh3L0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogaHcvaGV4YWdvbi9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNCArCiBody9oZXhhZ29uL21lc29u
LmJ1aWxkICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsKIGh3L2ludGMvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwogaHcvaW50Yy9tZXNvbi5idWlsZCAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiBody9pbnRjL3RyYWNlLWV2ZW50cyAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA0ICsKIGh3L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAg
fCAgIDkgKwogdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICB8ICAg
OCArCiB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfaGV4YWdvbl9taW5pdm0ucHkgICAgIHwgIDQyICsr
CiAzMCBmaWxlcyBjaGFuZ2VkLCAxNjIwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9kZXZlbC9oZXhhZ29uLWwydmljLnJzdAogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGNvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hawogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2h3L2hleGFnb24vdmlydC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9ody9pbnRjL2wydmljLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hp
bmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24v
bWFjaGluZV9jZmdfdjY2Z18xMDI0LmguaW5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdv
bi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhh
Z29uL2hleGFnb25fZHNwLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3ZpcnQuYwog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2ludGMvbDJ2aWMuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3
L2hleGFnb24vS2NvbmZpZwogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWVzb24uYnVp
bGQKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9LY29uZmlnCiBjcmVhdGUgbW9k
ZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2hleGFnb25fbWluaXZtLnB5CgotLSAKMi4z
NC4xCgo=

