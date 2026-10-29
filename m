Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701B606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pEPAdF/S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PpKSJmEZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZ9U-00021x-Dt; Thu, 29 Oct 2026 19:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9S-00021m-Lk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9Q-0004Cc-H6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLai8e1892544
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=IY0i+A6r8yRHgWl91hf7sC
 TsbMA0dqaOR8TPSYIjTZo=; b=pEPAdF/SNcCFdl+0RajgwI8yMCQefWnli2dQdI
 v5rtUZ24wilHa7OLgDX9voMPcpyjWzDBIjeohZifHe8fHoGwfGjXwCkE3t5szz1C
 xltxlmAjd/nS1dPZb89+bBOgjIAcJC/bMuW5Xoj1L+lS0i+YWPEmcjmAQ7e4iwY3
 Y3N2uxgesRutQj1kMP4XwaBvVzP23nHOMCQhoDntwYPAF7Exvup3ZXMHy9r4KJXB
 13HiTeLvII8E9sKAN5NmI071bjOmgrTjZcIOXW22yqJUEN96EcVmC+TOqXBwWquw
 c3yjLEMZhsQ0sjnb6BSslky0QWBIgNCMZ0MaZwBVJrvbXqTw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qg93x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a26fe9521so1209797eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793314994; x=1793919794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IY0i+A6r8yRHgWl91hf7sCTsbMA0dqaOR8TPSYIjTZo=;
 b=PpKSJmEZ8tDJGrtZlymkvdG7+Mc91V8pP237w02LHopkk3um6tppKb3WgKWnQpSr2r
 Gkf5o88/rmCatPh/7M+DpzxBDG71BIFCs95Qb9d293W22kimYAUKEYZAFm+x4O4D8Chv
 LG7wn1ULlX1DV7j2OivYdC56CJQDBkSqVZ7eRN0aWrvK06gVCUaQzp3Xt2JTjt2v1Uzx
 XTdmmzicf7/qY8JCKNDBusXMSpBOkMJIW94/9KevO0L4IJsjr4LbQKn4yngHlCWcG4zR
 vTncTsQsmUxm9wi+Bhh2ntUVIUN2wjSY+XLcu9w7A+ekTaFGKYdbWuA/5vbTsS3NC3Qn
 S+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793314994; x=1793919794;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IY0i+A6r8yRHgWl91hf7sCTsbMA0dqaOR8TPSYIjTZo=;
 b=o4VQzylEiQtYO8FBEQmgDFlM4PLKJKuj+AvqO7ZdvXJWtFk9ZEg6YSgfL+9zr1iag8
 VLkVJ4kxlUFiELt1YJGowT1/vTdvNYVouiJAAEbLrd5DHY5Qfp40rq3bP4fJqjDDcIja
 CXDCWjK29rgtV2AOXPzhvcat45hUs+eBzbsvXIrQvJZ6hkpk7r6rTLkS5y4tLQm43dry
 EF4z3GEdLeCWFDryPmpohUC2wkNkM+wIcUBYPhV7jq5fmpLMacuqlliKqYRNUkqWwPwn
 /F3tQoXtTfxXshkmPtsPW79XINxp8XFj0EwSoNc76CIP2/E6d92gi0tOWNP/hD57ommi
 yg+g==
X-Gm-Message-State: AFq9FYJ5OjPR+IJHD+gaspqAigw2OKbRArgDNYUNq5SPlvtSzV9q0Lv9
 9tIrDt9xepyX8JYXfZPkoqv3XyzN64Op9OtoBOWpXhfiudLzkr3ry/VquoQLpyp04IuZLWaeUmg
 we2ZvX26S8wgG/Z1fm4S0TJcDzvB3KpP3PQo4YNdrl7wcNFs2drA1zTLQY1Q0cZrRNQ==
X-Gm-Gg: AYBFou1bwyNvbeK3w/GeuhtlMc5dg4/GfCpyby4gRFubd4GCPV89+w4bipJP0P1VpLw
 RoNcjtV8sCjmCijxuAFwh6gVmby51ij6QO3f7JIUGqb0KGPMQgTGHKwYzyTr66F7dXJrQ5AsrtL
 QOeQmRJYx/wvNVSRrqEeaF73jkLZAlSfdlrvkhbU7BO1e/JGrcuhQRzipb13FnQNGIMeZX6IjRo
 fpxfMvKEpqezcU+wk2qYMJ7ELcS6L1d4IZvsn2TwXhHKCpT/Hcw8Ab0tLYtdTYlvV3OXKwe/9S0
 jdHWd02Ms1yKXjA/PUmmiZicy4SoLHjrLyEjqQ+/8ZT23Fv3qs3deQIqHCOK9Df+Crq7WgfpxeC
 GBUGDF8iA/BUjOhoieazJgMNk4qN14Fw65c0aBSMwVNIkN/SHTVZcgKznNppAkDHVb2QIo3eit0
 NeLQthUyAUoEM+byeiCpS2
X-Received: by 2002:a05:7022:628d:b0:184:40db:6bb9 with SMTP id
 a92af1059eb24-1a94876dbd0mr7187741c88.8.1793314993675; 
 Thu, 29 Oct 2026 16:03:13 -0700 (PDT)
X-Received: by 2002:a05:7022:628d:b0:184:40db:6bb9 with SMTP id
 a92af1059eb24-1a94876dbd0mr7187666c88.8.1793314993057; 
 Thu, 29 Oct 2026 16:03:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm2034887c88.11.2026.10.29.16.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 16:03:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 0/8] Hexagon: HMX system
Date: Thu, 29 Oct 2026 16:03:02 -0700
Message-Id: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfX4vMZX0FFMQCt
 HgRK/utsZASbmFexCmjjNcDuZPdRpYkEtbKHc3N1u9iONTQFj4XwxxHH42I6DbR3siqzF4Ke33q
 GP3WUtezMRkkiIE8MzdVagjygC9fZ7nPFAZGjcKaWhgySkiOVg7GdiwgCF5pLlwBwpNozUIt04S
 LFVtdG8AKeteXtidrcYznjjgc+srSZhiXEWJGs01W2/Zo9FgFPksF9d7uoaavh7TVdgSToHbgEP
 GbVpv6BjPz6knceVPQ8W420uoE8t0hJZtCGEakGFRkRF3+PB2v6ss/3OAvesRqGh9MEhufIPExf
 lUaIdoDBlSApiQfppdAz8zVplzTueG3pV9UMmVaheHMp7c5SVKoq7uRwIOKrGDQGPnWUGuBsUrQ
 Fy6Pl38I+SPcau6OjcjmH+Y7NThE8QjjoqA5pUPOU1xNl6zbHlxKyTQFd9W9QiiyG+fWWeTjW45
 bvadB+jkm1QNqq4mCHw==
X-Proofpoint-ORIG-GUID: rT0eAp4X4CV_vlK9PrkBoe6v7MsDAR02
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae3d0b2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=D8_e_0BrTver5Zuwt2cA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfXx8ejbgsXLspP
 QNZ5cA1J45YFDHCcqiMK7gJQVMnVwZlxv/iZ7SxKviG4grJBkXfX7YlUe2PjQ6buQTGNgz3g3XL
 2iGQdzEiGoeHTa0yWwBCqN/r0LVNeZg=
X-Proofpoint-GUID: rT0eAp4X4CV_vlK9PrkBoe6v7MsDAR02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIEhNWCBzeXN0ZW0gZW11bGF0aW9uIGZlYXR1cmVzIGFuZCBsb2cgdGhlIEhNWCBvcGNvZGVz
IGFzICdVTklNUCcgZm9yCm5vdy4KCkJyaWFuIENhaW4gKDgpOgogIHRhcmdldC9oZXhhZ29uOiBh
ZGQgSE1YIGF0dHJzLCBzdGF0ZQogIGh3L2hleGFnb246IGFkZCB0aGUgSE1YIGNvbnRleHQgZGV2
aWNlCiAgdGFyZ2V0L2hleGFnb246IGFkZCBwZXItQ1BVIEhNWCBjb25maWd1cmF0aW9uCiAgdGFy
Z2V0L2hleGFnb246IGltcG9ydCBITVggaW5zdHJ1Y3Rpb24gZGVmaW5pdGlvbnMKICB0YXJnZXQv
aGV4YWdvbjogZ2F0ZSBITVggZXhlYyBvbiBTU1I6WEUyCiAgaHcvaGV4YWdvbjogZGVzY3JpYmUg
SE1YIGluIHRoZSBkZXZpY2UgdHJlZQogIGh3L2hleGFnb246IG1pZ3JhdGUgdGhlIEhNWCBzdGF0
ZQogIHRhcmdldC9oZXhhZ29uOiBpbXBsZW1lbnQgbXhjbHJhY2MKCiBpbmNsdWRlL2h3L2hleGFn
b24vaGV4YWdvbi5oICAgICAgICAgICAgICAgfCAgIDUgKwogaW5jbHVkZS9ody9oZXhhZ29uL2hl
eGFnb25faG14X2NvbnRleHQuaCAgIHwgIDI0ICsrCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDkgKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19obXguaCAg
ICAgICAgICAgICAgIHwgIDEzICsrCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCAgICAgICAgICAg
ICAgICAgICAgfCAgIDIgKwogdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5oICAgICAgICAgICAg
ICAgIHwgIDE3ICsrCiB0YXJnZXQvaGV4YWdvbi9obXhfc3RhdGUuaCAgICAgICAgICAgICAgICAg
fCAgOTIgKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2luc24uaCAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgICAgfCAg
IDIgKwogdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMgICAgICAgICAgIHwgIDEzICsr
CiBody9oZXhhZ29uL2hleC1ib2FyZC5jICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKwogaHcv
aGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICAgICAgICAgICAgICAgIHwgIDIzICsrCiBody9oZXhh
Z29uL2hleGFnb25faG14X2NvbnRleHQuYyAgICAgICAgICAgfCAxNTcgKysrKysrKysrKysrKwog
dGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDI1ICsrKwogdGFy
Z2V0L2hleGFnb24vZGVjb2RlLmMgICAgICAgICAgICAgICAgICAgIHwgICAzICsKIHRhcmdldC9o
ZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdv
bi9obXhfY29uZmlnLmMgICAgICAgICAgICAgICAgfCAgMTUgKysKIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jICAgICAgICAgICAgICAgICB8ICAxMCArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYyAgICAgICAgICAgICAgICAgfCAgMjIgKysKIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5m
by5jLmluYyAgICAgICAgICB8IDI0NyArKysrKysrKysrKysrKysrKysrKysKIGh3L2hleGFnb24v
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5ICAgICAgICAgICAgICAgfCAgIDIgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0
ZWQvYWxsZXh0LmlkZWYgICAgICAgIHwgICA2ICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2Fs
bGV4dGVuYy5kZWYgICAgICB8ICAgNCArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9obXgvZW5j
b2RlX2V4dC5kZWYgfCAxNDkgKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQv
aG14L2V4dC5pZGVmICAgICAgIHwgMTc1ICsrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24v
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgIHwgIDE0ICstCiB0ZXN0cy9mdW5jdGlvbmFsL2hl
eGFnb24vdGVzdF9zeXN0ZXN0cy5weSAgfCAgIDMgKwogMjggZmlsZXMgY2hhbmdlZCwgMTAzNSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
aHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJn
ZXQvaGV4YWdvbi9nZW5fdGNnX2hteC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFn
b24vaG14X2NvbmZpZy5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaG14X3N0
YXRlLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQu
YwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hteF9jb25maWcuYwogY3JlYXRl
IG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2hteC9lbmNvZGVfZXh0LmRlZgog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2hteC9leHQuaWRlZgoK
LS0gCjIuMzQuMQoK

