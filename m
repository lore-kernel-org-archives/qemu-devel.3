Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD60DFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsL-0000u0-UF; Wed, 11 Mar 2026 00:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arz-0000mV-Gd
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arx-0008Uh-O2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3VIrr614124
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ujbXerkLwNEJdCn8PiYlDtr9LvPDgVbI85lbUd+ol6A=; b=LAfyY8yNgBz8aydB
 TLMlMnDAyzOkjOVAlgr3QbzC9k3eKOhF9CbOLBV6paVSKksjrupgUzYjmKoJYHHe
 XB+vV9HpbiNphafbtI0UEesrYLbg2bEGqsQNeHDaueIjwHC/FutYwzVJhlae5iRv
 SBlTLbl4DEPAbGm1qKbRzE1l5Gle8X60gEpwMEYPnFZvd1dRL9kv/h9VBY0NwIjq
 sIwfWb3j9QzgFmxjlak549Hp7ozmIbX0lfgrCcdlQyrxL1nvosHNz3SdpovvFV/f
 rz70ML4dJICIXTdM5xrd+LWPAGfp1KfDaQQSOIfRSBTeEnlYIrJmA4ap/Ezs4RJT
 /iGBdg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf03ad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:24 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-40f192cf4b6so31273204fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202103; x=1773806903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujbXerkLwNEJdCn8PiYlDtr9LvPDgVbI85lbUd+ol6A=;
 b=Xy4o/DdobXO6C+9ZDyWl2iQot02rv30xddbgKLT96/euJR6GzXnaELqlyrulVYPw0+
 MylRMHun/Mbp5xdTk8jwP717p3l4yOGkabE6ogN3wqK86xX/s5TkztmhSXEO0GyyxdCX
 SGeAlQo9kZ0vdR9Dl1tRM8k+CC6wltyn0nlKDVqataesfI/VOfXWootVPb2AhDz4OjNt
 slAeXnjSN422G+0zFVr55I598V2TAPOIFF33XEPEtwD0IiWR38kxH7accWikKg6FavC3
 OJ5uRzEEG4keSLnOnxfjxk0PR70LF/CKghbpSvnF0KPJr7E9sDUvGYnLKb1/lI4UUN7a
 bqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202103; x=1773806903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ujbXerkLwNEJdCn8PiYlDtr9LvPDgVbI85lbUd+ol6A=;
 b=uf6DAcpY2VgqAwZMAJgLAiHc1zQdLfGG6Eav4l2bs/xBXqf95jja782mvS6vtT3CTq
 rSWAMXitqpLjf5hUYxflpcTm71rpgCbprG984x2lcAfq/gD+8/5kYDnEeQfWBfR4dVqo
 yFH8Btgx1qjSALgqVmZh40Qi1mTwBmOJbjC9FVMetkPbZpohJ22Q+498HzddL0XVf5IO
 bf9ncTJCy1FTYJPPxsjvUnmrhbDvaBRxetm9a6UiUnE+kC3KkvMIZpnFBIyfOQzLo21D
 tFiA521vSpdFckYkvUUPMvQvUi8faYHpQBtCOG+OCocDfVHX438zIPmxEDqYPkbVNaWw
 D1/g==
X-Gm-Message-State: AOJu0YwOCgAmac91R0yo+4H2xDDND0LpEwvNetz5CoWwAWZw5VV61s/n
 5qGRa5zlXjBBNoktTt7YHjOdg7hbesMhT1x8hblTHIZRP5k2rfEsFFUfjk8jsXMTSKqYQIpv+Iw
 ljs/gLpp1k4uozj6NDfbeFhVkygboVp6P0AjV8+9UsyjwgfpQtuyU9rqGjIDKSnSxyQ==
X-Gm-Gg: ATEYQzyc3VA+Hw0Q6kpz23EdYK84yqUzW23b06saGNwKgV/XvA13+ShgaXYi0jJ8Fjl
 lZPAjef3RRYHWE/egp9GHD0YGk08hb0a1oaSKGif1yJo5iZ+E+COFUMsGRDrwNX8Bl5QTVgzV4A
 1EmLOXUsDLSXgHbhTb0uJKPEGXM2RaHnJoU5l4hPBVQQ5N7IFU0cxlPghIYuX/5X1C5stZEkGS3
 XD/9f9GNUA/L5eT198BCI0KwlHefynglJjTxQuM2DoMcz37qsLfzcWl3Q6q2HhCG1mHxA8wxyLb
 5N0RARoU1OHhGh0MwjjBohT4lXr8k2yvXUk3Aj7lnAGcj8YcoldH3D8ibA0KhBN4Af2rJiamEVo
 zvN6DZR6hdHiNfdimJ5OMmzrOIzoe9uZ0kzPiSNb/+EAxXdmptH0Snbdd0ZKLrARMUgTpJQ==
X-Received: by 2002:a05:6870:40c1:b0:404:3cff:5158 with SMTP id
 586e51a60fabf-4177c641969mr755503fac.16.1773202103400; 
 Tue, 10 Mar 2026 21:08:23 -0700 (PDT)
X-Received: by 2002:a05:6870:40c1:b0:404:3cff:5158 with SMTP id
 586e51a60fabf-4177c641969mr755486fac.16.1773202102804; 
 Tue, 10 Mar 2026 21:08:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 12/32] target/hexagon: Implement stack overflow exception
Date: Tue, 10 Mar 2026 21:07:38 -0700
Message-Id: <20260311040758.1068731-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 4bqROYhlaCF6OIGvTuIdPFw1QC0w4pKM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfXw4DmqwKBy3xl
 MtSJVz+1qhR676W8B7EY9N5yNMnzD6He/K3qVepYB5Qel9ax1Tec/sBIf3o1zlJap83fH3YFm9Q
 3ZpiWzPs+LU+oDQtzUcqpgpD+VqUkbrgofKMiF/mzBb0W0L1u0mJjgJe5WaeeTCVo4FJHMzBv7/
 0pHLEPNQMJLvo/FbppMnZZywAIpS555MMW71tf6oj7zOx5rWDy+ORKfaR6wQ1FelcqVQer4T2Fd
 FelSWeSYRdeFvhQ5MOJBwDREi+6nlM2hYmTLzJNN9BG7RJQL0Z8bF2KIyalvZXy9sP5gK/lxMbH
 iaFiTSAwEgKLrnVsy70s1zPRfI/VVnRs0yP+UmG2PiiaPeBhV7lhMNscJOpprimYshXT3E6Zyv2
 g7dHsSzE+uhFmbqvODCBzg/McH/acVa03CpF0z8i8b1eeu+Oi4+U3R4aageJi9Y8mZtcTVO6rLN
 uw1HH7vnESxiidcX7IA==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b0eab8 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pfDKOobNdc7td_IuCocA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: 4bqROYhlaCF6OIGvTuIdPFw1QC0w4pKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

SW1wbGVtZW50IHRoZSBmcmFtZSBsaW1pdCBjaGVjayBmb3Igc3lzdGVtIGVtdWxhdGlvbiBtb2Rl
LiAgV2hlbgphbGxvY2ZyYW1lIGNvbXB1dGVzIGEgbmV3IHN0YWNrIHBvaW50ZXIgYmVsb3cgRlJB
TUVMSU1JVCwgcmFpc2UgYQpwcmVjaXNlIGV4Y2VwdGlvbiAoSEVYX0NBVVNFX1NUQUNLX0xJTUlU
KS4gIFRoZSBjaGVjayBpcyBza2lwcGVkIGluCm1vbml0b3IgbW9kZS4KClNpZ25lZC1vZmYtYnk6
IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaCAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgfCAg
MyAtLS0KIHRhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCB8ICA0ICsrKysKIHRhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5oICB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgfCAx
OCArKysrKysrKysrKy0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICB8IDM0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDYgZmlsZXMgY2hhbmdlZCwgNTIgaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
aGVscGVyLmggYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCA5Y2E4N2FjZmU2My4uZWJj
ZDQ3MWVjMGEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hlbHBlci5oCkBAIC0xMDksNiArMTA5LDcgQEAgREVGX0hFTFBFUl8yKHByb2Jl
X2h2eF9zdG9yZXMsIHZvaWQsIGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2Fs
YXJfaHZ4X3N0b3Jlcywgdm9pZCwgZW52LCBpbnQpCiAKICNpZiAhZGVmaW5lZChDT05GSUdfVVNF
Ul9PTkxZKQorREVGX0hFTFBFUl8zKHJhaXNlX3N0YWNrX292ZXJmbG93LCB2b2lkLCBlbnYsIGkz
MiwgaTMyKQogREVGX0hFTFBFUl8yKHN3aSwgdm9pZCwgZW52LCBpMzIpCiBERUZfSEVMUEVSXzIo
Y3N3aSwgdm9pZCwgZW52LCBpMzIpCiBERUZfSEVMUEVSXzIoY2lhZCwgdm9pZCwgZW52LCBpMzIp
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDI2ZDNmN2Q4YTRiLi5kM2YyMTA1YzkzMiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTUzOCw5
ICs1MzgsNiBAQCBzdGF0aWMgaW5saW5lIFRDR3YgZ2VuX3JlYWRfaXJlZyhUQ0d2IHJlc3VsdCwg
VENHdiB2YWwsIGludCBzaGlmdCkKIAogI2lmZGVmIENPTkZJR19VU0VSX09OTFkKICNkZWZpbmUg
ZkZSQU1FQ0hFQ0soQUREUiwgRUEpIGRvIHsgfSB3aGlsZSAoMCkgLyogTm90IG1vZGVsbGVkIGlu
IGxpbnV4LXVzZXIgKi8KLSNlbHNlCi0vKiBTeXN0ZW0gbW9kZSBub3QgaW1wbGVtZW50ZWQgeWV0
ICovCi0jZGVmaW5lIGZGUkFNRUNIRUNLKEFERFIsIEVBKSAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKICNlbmRpZgogCiAjaWZkZWYgUUVNVV9HRU5FUkFURQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vc3lzX21hY3Jvcy5oIGIvdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oCmluZGV4IDM2
NGZjZGU3MzgzLi5jYmM4NTdmYTJmNSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vc3lzX21h
Y3Jvcy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaApAQCAtOTUsNiArOTUsMTAg
QEAKICNkZWZpbmUgZlRSQVAoVFJBUFRZUEUsIElNTSkgXAogICAgIHJlZ2lzdGVyX3RyYXBfZXhj
ZXB0aW9uKGVudiwgVFJBUFRZUEUsIElNTSwgUEMpCiAKKyNpZmRlZiBRRU1VX0dFTkVSQVRFCisj
ZGVmaW5lIGZGUkFNRUNIRUNLKEFERFIsIEVBKSBnZW5fZnJhbWVjaGVjayhjdHgsIEFERFIsIEVB
KQorI2VuZGlmCisKICNkZWZpbmUgZlZJUlRJTlNOX1NQU1dBUChJTU0sIFJFRykKICNkZWZpbmUg
ZlZJUlRJTlNOX0dFVElFKElNTSwgUkVHKSB7IFJFRyA9IDB4ZGVhZmJlZWY7IH0KICNkZWZpbmUg
ZlZJUlRJTlNOX1NFVElFKElNTSwgUkVHKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBlN2FjYmFlOWZmYS4u
ODJiMzI3MzEyZWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBi
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0zMzksNCArMzM5LDYgQEAgRklFTEQoUFJP
QkVfUEtUX1NDQUxBUl9IVlhfU1RPUkVTLCBTMF9JU19QUkVELCAgICAgMywgMSkKIEZJRUxEKFBS
T0JFX1BLVF9TQ0FMQVJfSFZYX1NUT1JFUywgUzFfSVNfUFJFRCwgICAgIDQsIDEpCiBGSUVMRChQ
Uk9CRV9QS1RfU0NBTEFSX0hWWF9TVE9SRVMsIE1NVV9JRFgsICAgICAgICA1LCAyKQogCit2b2lk
IGdlbl9mcmFtZWNoZWNrKERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2X2kzMiBhZGRyLCBUQ0d2X2kz
MiBlYSk7CisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgYi90
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwppbmRleCBiYWM2M2E0MmRlZi4uZjMyODkwZjg1YzcgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2dl
bnB0ci5jCkBAIC04OTcsMjYgKzg5NywzMCBAQCBzdGF0aWMgdm9pZCBnZW5fbG9hZF9mcmFtZShE
aXNhc0NvbnRleHQgKmN0eCwgVENHdl9pNjQgZnJhbWUsIFRDR3YgRUEpCiAgICAgdGNnX2dlbl9x
ZW11X2xkX2k2NChmcmFtZSwgRUEsIGN0eC0+bWVtX2lkeCwgTU9fTEUgfCBNT19VUSk7CiB9CiAK
LSNpZm5kZWYgQ09ORklHX0hFWEFHT05fSURFRl9QQVJTRVIKIC8qIFN0YWNrIG92ZXJmbG93IGNo
ZWNrICovCi1zdGF0aWMgdm9pZCBnZW5fZnJhbWVjaGVjayhUQ0d2IEVBLCBpbnQgZnJhbWVzaXpl
KQordm9pZCBnZW5fZnJhbWVjaGVjayhEaXNhc0NvbnRleHQgKmN0eCwgVENHdl9pMzIgYWRkciwg
VENHdl9pMzIgZWEpCiB7Ci0gICAgLyogTm90IG1vZGVsbGVkIGluIGxpbnV4LXVzZXIgbW9kZSAq
LwotICAgIC8qIFBsYWNlaG9sZGVyIGZvciBzeXN0ZW0gbW9kZSAqLwogI2lmbmRlZiBDT05GSUdf
VVNFUl9PTkxZCi0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBUQ0dMYWJlbCAqb2sg
PSBnZW5fbmV3X2xhYmVsKCk7CisgICAgdGNnX2dlbl9icmNvbmRfaTMyKFRDR19DT05EX0dFVSwg
YWRkciwgaGV4X2dwcltIRVhfUkVHX0ZSQU1FTElNSVRdLCBvayk7CisgICAgZ2VuX2hlbHBlcl9y
YWlzZV9zdGFja19vdmVyZmxvdyh0Y2dfZW52LAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB0Y2dfY29uc3RhbnRfaTMyKGN0eC0+aW5zbi0+c2xvdCksIGVhKTsKKyAgICBnZW5f
c2V0X2xhYmVsKG9rKTsKICNlbmRpZgogfQogCisjaWZuZGVmIENPTkZJR19IRVhBR09OX0lERUZf
UEFSU0VSCiBzdGF0aWMgdm9pZCBnZW5fYWxsb2NmcmFtZShEaXNhc0NvbnRleHQgKmN0eCwgVENH
diByMjksIGludCBmcmFtZXNpemUpCiB7CiAgICAgVENHdiByMzAgPSBnZXRfcmVzdWx0X2dwcihj
dHgsIEhFWF9SRUdfRlApOworICAgIFRDR3ZfaTMyIG5ld19yMjkgPSB0Y2dfdGVtcF9uZXdfaTMy
KCk7CiAgICAgVENHdl9pNjQgZnJhbWU7CiAgICAgdGNnX2dlbl9hZGRpX3RsKHIzMCwgcjI5LCAt
OCk7CiAgICAgZnJhbWUgPSBnZW5fZnJhbWVfc2NyYW1ibGUoKTsKICAgICBnZW5fc3RvcmU4KHRj
Z19lbnYsIHIzMCwgZnJhbWUsIGN0eC0+aW5zbi0+c2xvdCk7Ci0gICAgZ2VuX2ZyYW1lY2hlY2so
cjMwLCBmcmFtZXNpemUpOwotICAgIHRjZ19nZW5fc3ViaV90bChyMjksIHIzMCwgZnJhbWVzaXpl
KTsKKyAgICB0Y2dfZ2VuX3N1YmlfdGwobmV3X3IyOSwgcjMwLCBmcmFtZXNpemUpOworICAgIGdl
bl9mcmFtZWNoZWNrKGN0eCwgbmV3X3IyOSwgaGV4X2dwcltIRVhfUkVHX1BDXSk7CisgICAgdGNn
X2dlbl9tb3ZfdGwocjI5LCBuZXdfcjI5KTsKIH0KIAogc3RhdGljIHZvaWQgZ2VuX2RlYWxsb2Nm
cmFtZShEaXNhc0NvbnRleHQgKmN0eCwgVENHdl9pNjQgcjMxXzMwLCBUQ0d2IHIzMCkKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKaW5kZXggNmRmYzEyNjk4MDkuLmM1YzYzOGMxMzJlIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTM5Miw2ICsxMzkyLDQwIEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50MzJfdCB1aVYpCiB9CiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQordm9p
ZCBIRUxQRVIocmFpc2Vfc3RhY2tfb3ZlcmZsb3cpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50
MzJfdCBzbG90LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGJh
ZHZhKQoreworICAgIC8qCisgICAgICogUGVyIHNlY3Rpb24gNy4zLjEgb2YgdGhlIFY2NyBQcm9n
cmFtbWVyJ3MgUmVmZXJlbmNlLAorICAgICAqIHN0YWNrIGxpbWl0IGV4Y2VwdGlvbiBpc24ndCBy
YWlzZWQgaW4gbW9uaXRvciBtb2RlLgorICAgICAqLworICAgIHVpbnQzMl90IHNzciA9IGVudi0+
dF9zcmVnW0hFWF9TUkVHX1NTUl07CisgICAgaWYgKEdFVF9TU1JfRklFTEQoU1NSX0VYLCBzc3Ip
IHx8CisgICAgICAgICFHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgc3NyKSkgeworICAgICAgICByZXR1
cm47CisgICAgfQorCisgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOworICAgIGNzLT5l
eGNlcHRpb25faW5kZXggPSBIRVhfRVZFTlRfUFJFQ0lTRTsKKyAgICBlbnYtPmNhdXNlX2NvZGUg
PSBIRVhfQ0FVU0VfU1RBQ0tfTElNSVQ7CisgICAgQVNTRVJUX0RJUkVDVF9UT19HVUVTVF9VTlNF
VChlbnYsIGNzLT5leGNlcHRpb25faW5kZXgpOworCisgICAgaWYgKHNsb3QgPT0gMCkgeworICAg
ICAgICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19CQURWQTBdID0gYmFkdmE7CisgICAgICAgIFNFVF9T
U1JfRklFTEQoZW52LCBTU1JfVjAsIDEpOworICAgICAgICBTRVRfU1NSX0ZJRUxEKGVudiwgU1NS
X1YxLCAwKTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChlbnYsIFNTUl9CVlMsIDApOworICAgIH0g
ZWxzZSBpZiAoc2xvdCA9PSAxKSB7CisgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0JBRFZB
MV0gPSBiYWR2YTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChlbnYsIFNTUl9WMCwgMCk7CisgICAg
ICAgIFNFVF9TU1JfRklFTEQoZW52LCBTU1JfVjEsIDEpOworICAgICAgICBTRVRfU1NSX0ZJRUxE
KGVudiwgU1NSX0JWUywgMSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgZ19hc3NlcnRfbm90X3Jl
YWNoZWQoKTsKKyAgICB9CisgICAgY3B1X2xvb3BfZXhpdF9yZXN0b3JlKGNzLCAwKTsKK30KKwog
dm9pZCBIRUxQRVIoY2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiB7
CiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKLS0gCjIuMzQuMQoK

