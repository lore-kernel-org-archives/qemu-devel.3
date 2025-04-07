Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DFEC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1odE-0004wP-7U; Mon, 07 Apr 2025 11:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odC-0004w2-M1
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odA-0002ek-OT
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378doQm017440
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 15:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=e7i9hb/f4v7weTn85A5K++
 MYAy+jrV9/TsHa/XsCHB0=; b=Uoiz67IsWMD7Zml2lFpuoQB9exFOT70J1k2OyR
 d119GMaD6ov+jsu8hvkBmauv+ViYgRChKbBISOLu6ggi/tOlkF2KrCtTRc9YiLvC
 yINxNGtH9X5LbJA3mUQNU+S6eAQnEjk4ZhgTYgsIxcQe2maEWKdp8ftZ/NTckIAH
 SafzotuuWjttwhLjsKrE7kBMkYUOAzIcV1Ga+Gy7YiASMWOWTsj7M3ZbWX1IPirL
 ph066Tt7SvPsvn5nC7dzAubWAZQhLOE3yg+lPSOd2hPnXaBzFJEx2h3uKcXtbL+L
 Bc6YMHkIGE0LFJiHPLLYddgXcGo4c9l80TzcivCW6W6Dj3sw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3cpjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 15:43:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7394792f83cso3340013b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 08:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744040600; x=1744645400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7i9hb/f4v7weTn85A5K++MYAy+jrV9/TsHa/XsCHB0=;
 b=jkdvQHTVJTpnCf5+3falnDUUMyYxZaIlOVl19jCtozUOd9v3eHFGBj/ISSVppsvIsx
 DqWn7gyqPr2/uJJWE084fbXFEm/ST3FJATBGp7yWIv0S8NvDw6wLyle2KWcNHEJ0+c4I
 mF3iEAH+6Q4BnQCoqJQ64MF/Ru1WpxNCBJYr2Z2xuDjNavDytmIVdJ+egaebEN1KLPSU
 ZRIWORzE3lt6F6/kHi87FDGOWfE802GZCyG2HoYnAcEQ0YrQKPRawpJ794iDDZgCRcOr
 AoyEC6u2sDJvTDhMfBG6PVO1i0O4yyeH7ou7JtxPPBCAXJl70dkXO4KsGv9aL1Nz2HQH
 zi6g==
X-Gm-Message-State: AOJu0YygqusCClQpyAyuKkxaE82UswQDzd5/YTFROG3PoeDE/gmrJtxb
 h+nrvWzD8GiGjAk3qCP8Mi7Ahu9fi+Vhig1JKckztLz0CwjsgKY/M+I7ua9NT0HB65fQBnlGpvf
 aZkLNlmttZ2kH6dCr+baMw/Rvz+idNQALSWk2/CwmEgvP+1ZyyxHppWyzykeSvw==
X-Gm-Gg: ASbGncsLZ+eObQ0x51Vv3+ahipP4Fiq0mezsLgjSVLMEH14+M9rC5YvDeSRNRHxmTKe
 dtEtF0QgNjecwJxnidxL5enqqNjjqSD34emYpJHPLrvwmtuv/SgNQzv1dvlmMNUwUF9aGuv/0cz
 V0Zu6eAxbJO/lHjx089AIgF7wZYbsD4t7NWcRwOG8zvpeSZfwB81YyGeeThh/LdjBNzOXUqe6oU
 CAfW3RFQQcliYde6mR6ETywXCGyfuWdyFqBHVISyaWuEQDmsgrgc1ZKmHLpzSzaz/Fuowaqsy5o
 XeG7BqrDorW3VkOYhCfFSiMbWMNrN+0DHT6K6LCXU8etmJm8nwRP57EYY1ERvUkp
X-Received: by 2002:a05:6a21:32a2:b0:1f5:75a9:5257 with SMTP id
 adf61e73a8af0-20113c57dfcmr12050076637.13.1744040600039; 
 Mon, 07 Apr 2025 08:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxoAzxs8I/CMre1jC2kkJPWr0GJHDIQratRDnV0kWuSKCZ9KEDwyvHTcMzhNl70/PWZ8otXA==
X-Received: by 2002:a05:6a21:32a2:b0:1f5:75a9:5257 with SMTP id
 adf61e73a8af0-20113c57dfcmr12050049637.13.1744040599696; 
 Mon, 07 Apr 2025 08:43:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee3fesm8681651b3a.37.2025.04.07.08.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:43:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: [PATCH v2 0/5] misc hexagon patches
Date: Mon,  7 Apr 2025 08:43:09 -0700
Message-Id: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: y2MShl5mEOPLNqv2ugKt9WhmX_ChPyrO
X-Proofpoint-ORIG-GUID: y2MShl5mEOPLNqv2ugKt9WhmX_ChPyrO
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f3f299 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=7hGgwidC7KyOpMpABxQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=820 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Q2hhbmdlcyBzaW5jZSBwcmV2aW91cyAibWlzYyBoZXhhZ29uIHBhdGNoZXMiIHNlcmllcyAodjEp
OgotIHJlbW92ZWQgbm90LXlldC11c2FibGUvbmVjZXNzYXJ5IGZyb21fc3VidHlwZSgpCi0gY2hh
bmdlZCBhdXRob3IgdG8gbWF0Y2ggTUFJTlRBSU5FUlMKLSBkcm9wcGVkICdBZGQgbWVtb3J5IG9y
ZGVyIGRlZmluaXRpb24nIHBhdGNoLCBub3cgY2FycmllZCBpbiBQaGlsJ3MKaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDQwNTE2MTMyMC43Njg1NC0xLXBoaWxtZEBsaW5h
cm8ub3JnLwoKQnJpYW4gQ2FpbiAoNSk6CiAgdGFyZ2V0L2hleGFnb246IGhhbmRsZSAubmV3IHZh
bHVlcwogIHRhcmdldC9oZXhhZ29uOiBGaXggYmFkdmEgcmVmZXJlbmNlLCBkZWxldGUgQ0FVU0UK
ICB0YXJnZXQvaGV4YWdvbjogQWRkIG1pc3NpbmcgQV9DQUxMIGF0dHIsIGhpbnRqdW1wciB0byBt
dWx0aV9jb2YKICB0YXJnZXQvaGV4YWdvbjogcy9wa3RfaGFzX3N0b3JlL3BrdF9oYXNfc2NhbGFy
X3N0b3JlCiAgdGFyZ2V0L2hleGFnb246IFJlbW92ZSB1bnJlYWNoYWJsZQoKIHRhcmdldC9oZXhh
Z29uL2lkZWYtcGFyc2VyL1JFQURNRS5yc3QgICAgICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24v
aW5zbi5oICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstLQogdGFyZ2V0L2hleGFnb24vbWFj
cm9zLmggICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKy0tLQogdGFyZ2V0L2hleGFnb24vY3B1
LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstLQogdGFyZ2V0L2hleGFnb24vZGVjb2Rl
LmMgICAgICAgICAgICAgICAgICAgICB8IDEwICsrKystLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0
ci5jICAgICAgICAgICAgICAgICAgICAgfCAgMyArKy0KIHRhcmdldC9oZXhhZ29uL2lkZWYtcGFy
c2VyL3BhcnNlci1oZWxwZXJzLmMgfCAgNCArLS0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
ICAgICAgICAgICAgICAgICAgfCAgNCArLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAg
ICAgICAgICAgICAgICAgfCAgOSArKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5faGVscGVyX2Z1
bmNzLnB5ICAgICAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgICAg
ICAgICAgICAgICAgfCAyOSArKysrKysrKysrKysrKysrLS0tLS0KIDExIGZpbGVzIGNoYW5nZWQs
IDQ5IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQoKLS0gCjIuMzQuMQoK

