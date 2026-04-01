Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE21D35173
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xUm-00015f-Q9; Wed, 01 Apr 2026 11:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUl-00014S-8A
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUj-00088G-0V
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631FRJ8T1579382
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S5Qs29uBL98ZfxcDzoKCdBQL3DPuT7L6Gb+GAENCPVA=; b=j5/B9Si5bDNyPlgW
 G+ckP2zoAm2c4qsXJUSCpXqbbPXd2qPMUomjE/t9lqPh/qihV1SqKnlgeNXI3DyQ
 5FgK/nYtZPLX3nm/PCVM2hODLu0JUhvm8+AH1jDsTiVhG0r/ChQYG9dAC7LLE5yi
 8kxVz4ErG//6dDKFA9uSxfAaemyFOye0vdEfzpueMx7a7vPOq1YOw0GD3794h9U0
 VE8siOK+VAA2SZJrkrAeMMNII1adeYhpuPVgRGI5W7snTkkjt0cVi1FfZD5pqtGQ
 GSSZFuEx8gYrchghfjyW79SEz9cjeDRPLy0whvKCvXA01jdR94z4lxnJjsrHO7SZ
 euIWUg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2vbmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso695273eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057291; x=1775662091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5Qs29uBL98ZfxcDzoKCdBQL3DPuT7L6Gb+GAENCPVA=;
 b=MwFRc95M1pmCN/931S3HmLmJWe8gG+T3ZV9eZtEfkLuoBSom5JsGb+zeGZBBiNWj6P
 uJ/K39tp2HPlMOmDbWx4DpqWmNtFtHIMtkwrZ3X5seJmg9PECC1h0aE0mBZhw87Jr8Vj
 d2n4ekIArSyqkan7X9lkxkPVczoBlGhoVwXkfBp5+uQDmNdSnazMSfAIkmQcEleVkoax
 o577ETvDXHhIU4apVzvnpRFntDwBNI5ADnIPUkFaAe8xS8G7GVrPr5s/6OsvqebwQ7q3
 pzmsV7bIl+o9YlXLUnkLfk0WqpWb8pxoqqb7j8U8705VrbU3y0njKtlXzHWw9vDCbouu
 psgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057291; x=1775662091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S5Qs29uBL98ZfxcDzoKCdBQL3DPuT7L6Gb+GAENCPVA=;
 b=VwTz9htIfYPbJpY0z4RCCnxSRxqvqSH0mfW5WRXG8l0ZcNxNs4QhwXQyi14bd/KT8Y
 bKgtkiHAyjQ68nKVVbha08UJVSGRYcAzuvT2DSpu4s3D2eTTPH0paXd4M3hL0soAe4+D
 3GWoqz+BgQeqAkO6t1+70KV2vXCUbuX26x005OqCb/+Fc4Vyb4uYc0s0tK3Fu08h42rG
 G9L//uC6sc77LQ3AP8UnwE0S1K+7wdTJQqHD04/Yn1fRFutfRK2+kMTuKRRH0pTKzeJy
 Iv2Hgk+lPScbsnsaxsTNr1DHJjWfFmFA0iCpxUoxCGr7YchSxVv9yZQZBPi/HeJpDFfQ
 OpDg==
X-Gm-Message-State: AOJu0Yw3RSLMECjkVaGCy5DZ0iszOA7cmUciEKqiaXfyZm/MLElwbClF
 4o81Y/PXEPlFkjzUVe8uS8i2WpeII+a6r+zzwr7aJa0bsgL2L3xFitIKE8a1y/fZpumpgAnN4v/
 JDNUEU25R3THfQZ822VpRHwyi3svXfs27msi+rRUIybpAGYcD2cw6AiTZplf2TQmssA==
X-Gm-Gg: ATEYQzxOzT9OaUJ8PAICWcWJLEX2ydy8Kpn3FLCX5rjagOX2CFJQydbW2G22XxiSTaP
 TFot07qyv0XB1kA6xUvdLrEwu7uqDP8Fd0rp/5rhWMwg1GNf5rpBSXJS3rjv8QsrzibVzGfxtiB
 ruHy3CZ6+qJpNJ1sebMjWaQmjmFNUsNqFILZFNG4ScPnU/hRr1JbckkE+ILvPsDJZAOzUp1XNdl
 EH5XJYw2b9/XHT11mSM2CVLdPVG0mRcUBHrpwZjEG5T/QrEIE5HPUaKjs7xMsJDZFgdGO5NAuoy
 Ri4R1fqH7R3H2ZoliV3kWA0p4CqyTo2d4Mnm7ihPllESanKBGzbAb1zr5/rwiH//l0IaHFwVsru
 0fN1b4K5aPr1t49gv0S1l8rFb3y9FzHi8VqeNd+rA2kb7vwllRj2TaRJSTnByVC80K0NjJw==
X-Received: by 2002:a05:7300:a887:b0:2c4:ee64:13c3 with SMTP id
 5a478bee46e88-2c7bcf7060amr3448718eec.17.1775057291444; 
 Wed, 01 Apr 2026 08:28:11 -0700 (PDT)
X-Received: by 2002:a05:7300:a887:b0:2c4:ee64:13c3 with SMTP id
 5a478bee46e88-2c7bcf7060amr3448705eec.17.1775057290932; 
 Wed, 01 Apr 2026 08:28:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 28/37] target/hexagon: Add TCG overrides for rte, nmi
Date: Wed,  1 Apr 2026 08:26:48 -0700
Message-Id: <20260401152657.314902-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69cd3995 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zRxYJKy5J8nCns2dKEsA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wx_q-uh1DInPppGOidqWNN5Xsmw2JFZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX2uOqtLdqMy14
 kivNLhNIlH27Iu59HsWMPQP5sk8/iCztga2XsYP0Phca1C0R0WKNxv2hRD9BbZCViO7PBXIHxGv
 iqJ/gMi4XD7W8sTCSl57DrwfdPZ9BhLrMo/GpkfakwlzcpKcX82id1EE6pFpYG3/9xG3ndXQNiy
 XvjT0gaN6Byuw50FoCt2/zkV3iwRcCSaH3lhWnkcitiu9tRl3Nw+Y7Q5BrPriIoum/q6r+kEehY
 JqxbfPtbkYqBtBvsYo1xe7nzLa1u6bd85tZEfceX54p+cj1B1gmP9k2FH+vlHHOzgV2nVD9WRVc
 qIY62HayUbpjQitdUzy9p6waqlqfvueE5+yVHN+1lUBmRDODBhtD4/5o07NeGpnfVyDU52ggOKT
 AK87ljizAtSvPWnwPKsozvnALLDyymYJQU0oCaMzlW/pHq+zFsvppTRPHYFJm4aPYgqrgTti81r
 98TW4XUeOoCdtyOEZlA==
X-Proofpoint-GUID: wx_q-uh1DInPppGOidqWNN5Xsmw2JFZE
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAxOSArKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9oZWxw
ZXIuaCAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICB8ICA0ICsrKysK
IDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4
IDczOWU5NWVhNjBiLi4wNDQwNmRiNmE0YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZ19zeXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw0ICs4
MCwyMyBAQAogICAgICAgICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxl
ICgwKQogCisvKgorICogcnRlIChyZXR1cm4gZnJvbSBleGNlcHRpb24pCisgKiAgICAgQ2xlYXIg
dGhlIEVYIGJpdCBpbiBTU1IKKyAqICAgICBKdW1wIHRvIEVMUgorICovCisjZGVmaW5lIGZHRU5f
VENHX0oyX3J0ZShTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgVENHdl9pMzIgbmV3
X3NzciA9IHRjZ190ZW1wX25ld19pMzIoKTsgXAorICAgICAgICB0Y2dfZ2VuX2RlcG9zaXRfdGwo
bmV3X3NzciwgaGV4X3Rfc3JlZ1tIRVhfU1JFR19TU1JdLCBcCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICB0Y2dfY29uc3RhbnRfdGwoMCksIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlZ19maWVsZF9pbmZvW1NTUl9FWF0ub2Zmc2V0LCBcCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWdfZmllbGRfaW5mb1tTU1JfRVhdLndpZHRoKTsgXAorICAgICAgICBnZW5fbG9nX3Ny
ZWdfd3JpdGUoY3R4LCBIRVhfU1JFR19TU1IsIG5ld19zc3IpOyBcCisgICAgICAgIGdlbl9qdW1w
cihjdHgsIGhleF90X3NyZWdbSEVYX1NSRUdfRUxSXSk7IFwKKyAgICB9IHdoaWxlICgwKQorCisj
ZGVmaW5lIGZHRU5fVENHX1k0X25taShTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX25taSh0
Y2dfZW52LCBSc1YpCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmggYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCA2ODJmMGM2YzI2ZS4uOWNhODdhY2Zl
NjMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2hlbHBlci5oCkBAIC0xMjcsNCArMTI3LDUgQEAgREVGX0hFTFBFUl8yKHN0YXJ0LCB2b2lk
LCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMShzdG9wLCB2b2lkLCBlbnYpCiBERUZfSEVMUEVSXzIo
d2FpdCwgdm9pZCwgZW52LCBpMzIpCiBERUZfSEVMUEVSXzIocmVzdW1lLCB2b2lkLCBlbnYsIGkz
MikKK0RFRl9IRUxQRVJfMihubWksIHZvaWQsIGVudiwgaTMyKQogI2VuZGlmCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGRhMDBkZmQ2NWMzLi44N2RhMWZlNDMwYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0Nzks
NiArMTQ3OSwxMCBAQCB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgdGhyZWFkLCB1aW50MzJfdCBwcmlvKQogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVk
KCk7CiB9CiAKK3ZvaWQgSEVMUEVSKG5taSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHRocmVhZF9tYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CiAjZW5kaWYK
IAogCi0tIAoyLjM0LjEKCg==

