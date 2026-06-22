Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EC0CDB470
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9d-0003eP-OB; Mon, 22 Jun 2026 18:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9a-0003cM-85
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9Y-0006gQ-H9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZjFV3222608
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=; b=LOaAfj8byInFB3gC
 HoALh+/QnoFOv9I9a+PZpLY69nDilNyiIiKX9qG8/lbv7jTZAWcicp6+aqkYeyZ8
 b+WEa+SqR2R3qJzsGt6uf2pY2A6iSD85Hy40BWwdw1foSpMoUkOruPMRu1qQgb7Y
 7lgs5Txs0dGLnGDq5+ERZoEr2kpAhD/GIFyMGIiPBRMBnQFK5SXACpXUi0ysv8Fa
 BPz8cVpvrNEUiEw8013F8WQsQrGMimK9O2l4HNIg58z3gZ0SSv9ooiC1YVww9jMM
 aDwKG3nhUqQZsHyzYpKXOQiB/h0Mj7kohVHB94M0mVERueiCvMN+z5hw8muD8qsa
 8/VdlQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn1x7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so11726911eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167402; x=1782772202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=CsHIEp/1/3rhbRG0jCAtxtFDd7WxwMvwbur2xVHA7bzzNejhKm9LL7bnwpjuNmUR+3
 uoN8qv60V2BukWOquIkjxZZYv7GNxtg2jNLCLunMbrN101Ja2H8yGjSKQrGwmixnPVo1
 a2M2nRTaTPTEYLGfEDOeBNB9SwgoH4JhCQ4MQxi6XA+VYO5XFam3WobFcmz2p2KlrRLy
 DZn+1LS3muyc0p5A/RUp7/Z/S5LaBpuiX0qD9YpvzLOIfHqYTTC0qKmK36+Q4yvc/Lk6
 Ac5gP4SDlw2UDF8adbwvltWd9oU+O3dW9j34V4JHF+s5hSMRxfeJPRB5hOU1+8dsLR/D
 oIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167402; x=1782772202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=AmuOuHYHLvYCFQyVDnQFDsgzOFxlkn9PRVNDXEEyryGZB58tuBxpZMvKPcDCz69tQS
 SRjcnmCAGWea6F2LOdRm31jy8glaPBPxRcNehj/2SEeWcJfD2VSnEa+JGXh8sWkTg0DW
 zgEllbnjh6o/6XCSTR/Q+r7kqC/HQU+1O81kFGb97YPqrzrcF+ljDhmn6Nec03NKitTq
 xnyY0dxXOAMZn03WDFvKvV+Up37difltuFoLZqjaE0ZjzM2uyopUCnmjvBBopKler5Ds
 WD7Uo20dwtb+QKRhJ4Yp7IjKaR9mVwOonkSg3+NnywFtYxY/M7m10F3UXJAxDv6F5zY7
 jEXA==
X-Gm-Message-State: AOJu0Yw9/FDWYnBRR9SKMYEFVR5SWAgMP4rniHyFcBu6dOEwIFWbGOVs
 uPswBHoNbEnteFXsQZ7cN/Y5fnhyTZ2rVPuR4i2luBjL6fswiI1ZZTd2AUp5kzcD6ARY4VLTywB
 G7dHXFuULAStax7sfNgTgd/8U7g/hg3mp1A6iAT3k7KsNfTNjz2UFycD/s5jijURwiQ==
X-Gm-Gg: AfdE7ckqd5fq9U8ibMoWZefiruMqJ2GBpdFX4Oo7l0T/IGio41Ummox2ly+S7f6WS7N
 1kgkdlxW7fIuYTMMDDUX6Pw749PjCzV92TBU97I/Xjcjq/dWup28/B/eJ/KLsOsQON68Qkw+26S
 H1nB6l3/84zVqpS0DFwLGNuXImvUmcyHpxZKxiXIKBKEm94/20uaN34vfNqOK8LltqKUdnUVR+v
 NgXaIYIo3eMsdhpbPESVAOGHirulAnNUiGYgMLu6fil2/fSU+MbTJJOwR1Zj541cDQwKluFl1pV
 4qcaYGL6BSaoFtEkT1/kcclfm4CG8tKNZw5tuHrpAkyF5XPq5+1YsFxRBJMVVvVG/vvAVHcgtrf
 50bD7Uo163HqEm5Atl42hojdyAa08/ELQLPv1cJ20a0kevcgNo/3PZMLZDHQ=
X-Received: by 2002:a05:7300:6ca7:b0:30b:c502:23e8 with SMTP id
 5a478bee46e88-30c070057dbmr11441288eec.21.1782167402431; 
 Mon, 22 Jun 2026 15:30:02 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca7:b0:30b:c502:23e8 with SMTP id
 5a478bee46e88-30c070057dbmr11441259eec.21.1782167401952; 
 Mon, 22 Jun 2026 15:30:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:30:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 36/75] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Mon, 22 Jun 2026 15:28:25 -0700
Message-Id: <20260622222904.607771-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: GxTBdm_83GaBPsiYolV5G-ASn_a6b1CS
X-Proofpoint-ORIG-GUID: GxTBdm_83GaBPsiYolV5G-ASn_a6b1CS
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a39b76b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX4LAZabxJFycv
 88I7hbul/d3nJX8Yaa6OUUeED0A+gg4OCvnmsWr13HPnuUgDRbRiND/1GLz8mb8DKMTTO63AHKI
 rs3yAlHrjb4wVQCtkHAxS9DPX9DdFls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXxZzJrBIcaXWi
 sqSJ6faXwGfgR5HRxYZHpkozUqAHEVuIzsj1rpk9qSlL8HTbfwuK888E1VQe11YozL9LY3J5ZEb
 KXOAt875Sj/I4w2/eh9AkDvApBQI0o+kIDt3S2Ot3WgPmoHMafdVRHjUqRj74b2D/aAu+IwGdDw
 WgasZWFwii+eSXCyhhFjpQqyWA8zgg3e2edLBYqNtN39qVoJvugo10rVYqiw0Mt9u2bc52e2m9n
 j6QV2MAs4i5alzhP6rEq/2vt0Hod/ZD2DzfbX8rbxLvkvGGUK9XYmH42yCzr2Fb7ffxKaabo0UC
 o6+6exUxkFpRzEepT7oW4aVlBi31IvJG1zuYvlM6Cv3Q/RrSBCCxAQCh6g1Fl9wInvyzF1trYoD
 3hkxXIi9BEwxiqasOKuJXbbATUCWT4ija4EmsesjkSQGPIOQnhNHmHzlwrCPh/yCvZrILKMVbwg
 972/yYqqvfcvz8eLQTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDM4YTQzNjQ3ZGQ5Li4wNDFlNjhhMTUwZSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

