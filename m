Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7E0C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FDu-0000gd-Vc; Mon, 14 Sep 2026 18:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6FDf-0000dW-3t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:32:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6FDc-0006qf-AK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:32:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYOf9771779
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fvdta/9nLk7vH6oi/7z0FBfPJxagNMCdZfN2FbXOnks=; b=oHvUy8myi2hUiXSG
 CRXF5VjwOSosZDYh1pvaoLxGo5YxCUJTNU6AB+bpB4IHowqkvd4aq9tjQzOMMEko
 G80aoLxDvt/Ehe/LlhgGnn+p/y2PVINVvZfPez7G/J5Nr461uL0N3MWDhH0ynvCN
 MebNrGvbAB5o/AX3ao1P5dxIpKlty8AC9YfAumfEkYUL/nU3ZTGiiisp6rvmyCe4
 v8KuMsWpyFdefCAvV30k5G1K7fr7Ocsl/z4H0c9qYQa6vC3SAxKokPXYAp9WwpCk
 J4+/zgUTycM6xfXekJwmBuEMjLgAup1871hqyKvCSK5vcDOAo3s1sXNQcmviDThp
 wdiDlQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg3cb0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:32:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso3629532a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789425126; x=1790029926; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fvdta/9nLk7vH6oi/7z0FBfPJxagNMCdZfN2FbXOnks=;
 b=MF9fgbhO8y4qUgGkxJPnPdAyDsErw/h19IQUGOD7KKPiA4UsQl+E5GzxFiKYUkgapi
 LuhWI5+1oiDUFMdpWPfDokwyuuBRpZ4O7eA1QBHp7Uokjs/jRNOeSYczVLk86ivT33TT
 AaiSz9oXibzZLbT+jCdQ7BD52DGqt3662V1he/bTJ2u+pP85XEXe3IIQ5Npg0TjTA2Aq
 e84n9kl42zpcdEhDS8s42EAxLzWhPt4Nw0Q2sGxr7Cf0jiPeUGW1AjudJjbD7Yq8JKGI
 SR8r2gnAtkRG6jUWOgTTOTfQ1OHdR0JN1SD2LFhtONTBqmXcSfp4xX6qyDl+zNjNOFJF
 zZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789425126; x=1790029926;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fvdta/9nLk7vH6oi/7z0FBfPJxagNMCdZfN2FbXOnks=;
 b=OhAtGNrNZNBUdKBiIpLL9DF4WoXjB7yFCKdZDdSAXkTUi0TP6oodl4eK9R4lsQkaHz
 G6aWp792aCGqjERP0siFazmwb5v0BTyDZFVJVAn1KPbr+kUxKxhjNYcKY03hGj4AkxhR
 /bL6brEEgTwC1irGR4w9NY79LDR8MuguIcTt2VtMuKOyVQsuRRUUVi47+ISPh3W8qVvP
 qlACmzPUnp0OBqaRu1AKv6fWcobcE2/BldLxCj3lD4DfAteLRw6TPDtRTM/1ETvvswn/
 wHRXZ30vU43bWHXcS4XhrbAC5PtZr923WgaODNLOkRjb64ss9GhIQ/ekIjuuV/SjL+Ae
 eT8Q==
X-Gm-Message-State: AFuF++kBOVUEHbnY+ZkoIOV/c9OW+XQ1hUcmYQlPJTjvOBiTbUD00HtI
 Dq7AAtkjT2Hu/5EJrhpPWn7xtCLIQECVGlI3f5ziEjKunoKJGHf+a/G57BETsQ+fXFLLYqzkan7
 fSqmOdIP1j1i3iJpnYV6Vp9rVutNyTfe/UgmR5+KRVvhmuAxIKQMXBnvy8vw4e7OB5g==
X-Gm-Gg: AYBFou2rPPCOErUTpNPplmYq+6btnQ9NzPNe/BRMuo2jRDj3di0rT+8GU1+ku+A1YOc
 vpyUCyvPfZYR6RjW0yJafv4EMURpN/m7JxGniw8B3NbJ5A06Wdh790SN9sy1/1eYa0An2MBVoZj
 Ctcg1HtKizgMcPXDnKucBIP1gtFdHmpkI4PGRtcPyaZz76uNEd/Is5b2TdtSAQUBDwYORhmQYTO
 pRV3xjRC/TSCNEzl6f26gOPDn3prYJsUnh0gbipLGi5kbt/OT9BuGkI7WmT8Sk292CW6U7SH+ZQ
 OTRf49Y8ZzuN6FerNzn6p6yyXV6tCb6YVH312GmUXLz3u+PsIKxvsklVWgiI2ei4CJ0JVXHeqiD
 p+yyJrFiYM5gAZwP3YXnKLBGj0+6ksMXkmdNHITrtmTQXCmYg
X-Received: by 2002:a05:6a20:2446:b0:3d1:af47:5f80 with SMTP id
 adf61e73a8af0-3db404c4127mr9369425637.11.1789425125782; 
 Mon, 14 Sep 2026 15:32:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:2446:b0:3d1:af47:5f80 with SMTP id
 adf61e73a8af0-3db404c4127mr9369387637.11.1789425125407; 
 Mon, 14 Sep 2026 15:32:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm30190753eec.31.2026.09.14.15.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 15:32:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org
Subject: [PATCH v2 3/4] target/hexagon: fix semihosting ACCESS filename
 handling
Date: Mon, 14 Sep 2026 15:31:58 -0700
Message-Id: <20260914223159.2735262-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
References: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa875e6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8vWCUsdaZpTB90jPxDF2sdL0WgCm5r7a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMyMiBTYWx0ZWRfX8S19MAXKB/KL
 fRjkpkKTa+FjGsdVIXT9LXEXOrbe4q8hpxo4lKkU207pHHiny8eAAlScSjY+4HAXWPJoyjvlYMp
 5gbcpTK6JEghOkXjkbksIyD+rdmf++E=
X-Proofpoint-GUID: 8vWCUsdaZpTB90jPxDF2sdL0WgCm5r7a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMyMiBTYWx0ZWRfX/YFQzy9BV/Qw
 4DSqQyqHU1vcy3md1BhLAzq2pSnq1zV6WuwxYZ1b85/62vLMm39yR6TTt0vho0Fm3mWlicZYdJs
 hXoqsFMdQADF/yY/uoN46ybHVuFHOUzKt4fz8jl9lqpgXDNzUd1DKYJgSIjvRF4boL0P152izo/
 cxtV8+8gJNHYy5i/V+f2GNNuYdR9bW4hvgclEKd6JIEePevHgHhHGKNaOtV87uD9V7tUKrJ7C6n
 ITLrhokmDWRzH8MyHUpO1I7748Vb9iDxBYwvPdPA1tZeGQ7O+DpyrvxkzOMTl/2VlRpNf88eNKr
 D3IKSWWNxwuX/PnpGeMlGrXbGrJwlH49K90FNBdtrppCZ0RHcc3o6a46tAY+DamTyqbHvvOXe4L
 mpB93LWmMukJW7RQIRxWyuTfRCD5ya0HkqgJXG0tvD16yzatu/Ri3io11h+5amKiKdNSEE2e6VU
 DKC2//n027YsCDPKJ5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140322
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

SEVYX1NZU19BQ0NFU1Mgd3JvdGUgYSBOVUwgYnl0ZSBwYXN0IGl0cyBmaXhlZC1zaXplIGZpbGVu
YW1lIGJ1ZmZlciB3aGVuCnRoZSBndWVzdCBzdHJpbmcgZmlsbGVkIGl0LiBVc2UgbG9ja191c2Vy
X3N0cmluZygpIHRvIGF2b2lkIHRoZSBvdXQtb2YtYm91bmRzCndyaXRlLgoKRml4ZXM6IDc3MTFm
ZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMgc2VtaWhvc3Rp
bmcgb3BlcmF0aW9ucyIpClJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY4NTk0MgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FGRUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2
aEpiMmVtWVoyYUxTZS10Nml3QG1haWwuZ21haWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRl
bGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5j
IHwgMjEgKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
LmMgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwppbmRleCBkMGJhMTE2MmE1ZC4uZTU2YTYwZjJm
MDYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2hleHN3aS5jCkBAIC02MTAsMjUgKzYxMCwyNCBAQCBzdGF0aWMgdm9pZCBzaW1faGFuZGxl
X3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogCiAgICAgY2FzZSBIRVhfU1lTX0FDQ0VTUzoK
ICAgICB7Ci0gICAgICAgIGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmls
ZW5hbWU7CiAgICAgICAgIHVpbnQzMl90IEZpbGVOYW1lQWRkcjsKICAgICAgICAgdWludDMyX3Qg
QnVmZmVyTW9kZTsKLSAgICAgICAgaW50IHJjOwotCi0gICAgICAgIGludCBpID0gMDsKKyAgICAg
ICAgaW50IHJjLCBlcnI7CiAKICAgICAgICAgaGV4YWdvbl9yZWFkX21lbW9yeShlbnYsIHN3aV9p
bmZvLCA0LCAmRmlsZU5hbWVBZGRyLCByZXRhZGRyKTsKLSAgICAgICAgZG8gewotICAgICAgICAg
ICAgaGV4YWdvbl9yZWFkX21lbW9yeShlbnYsIEZpbGVOYW1lQWRkciArIGksIDEsICZmaWxlbmFt
ZVtpXSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0YWRkcik7Ci0gICAgICAg
ICAgICBpKys7Ci0gICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiAoZmlsZW5hbWVbaSAt
IDFdKSk7Ci0gICAgICAgIGZpbGVuYW1lW2ldID0gMDsKKyAgICAgICAgZmlsZW5hbWUgPSBsb2Nr
X3VzZXJfc3RyaW5nKEZpbGVOYW1lQWRkcik7CisgICAgICAgIGlmICghZmlsZW5hbWUpIHsKKyAg
ICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgYnJlYWs7Cisg
ICAgICAgIH0KIAogICAgICAgICBoZXhhZ29uX3JlYWRfbWVtb3J5KGVudiwgc3dpX2luZm8gKyA0
LCA0LCAmQnVmZmVyTW9kZSwgcmV0YWRkcik7CiAKICAgICAgICAgcmMgPSBhY2Nlc3MoZmlsZW5h
bWUsIEJ1ZmZlck1vZGUpOwotICAgICAgICBzZW1pX2NiKGNzLCByYywgIHJjID09IDAgPyAwIDog
ZXJybm8pOworICAgICAgICBlcnIgPSBlcnJubzsKKyAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5h
bWUsIEZpbGVOYW1lQWRkciwgMCk7CisgICAgICAgIHNlbWlfY2IoY3MsIHJjLCAgcmMgPT0gMCA/
IDAgOiBlcnIpOwogICAgIH0KICAgICBicmVhazsKIAotLSAKMi4zNC4xCgo=

