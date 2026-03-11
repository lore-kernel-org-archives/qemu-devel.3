Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B655CFD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaR-00026Y-FH; Tue, 10 Mar 2026 23:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaO-00022s-R9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaM-0005es-QR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2s8uR248601
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PjPaPqrhLT0yunV9ouaN6H60Rrbm7wBsFlGXscdhFO0=; b=IBggoSxPT/QkRUvM
 tzXU6AqJOrkWIzU11hHEx1Z05crmfwl6P26ElcXf4Z2kSDYYtc8yTsXUL+3Xiil9
 yMVx5quhtt+7g0PvFibwEBsQ1O8d231EndyLAGGd4nI857VMC39IEnb+xE4vW4wV
 rsoCHGYWdl/qqBtyaNSrb76eBHA0WDwbZKCOkVlNgSy1T0duYish4iime32pPSD6
 3a/efk8Iagdob8lo6Dap0m7GULohi7hOdbZPlPrbzfboZT9oeE4rnkrVL9tbG9zq
 asLVt5icuncxs5QD19XxfusOMCUm3rVOq7qj3wlBnwfhn2nQEUR/86BdhxlLEL54
 oDXOQg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11rcj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:03 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d496d080d8so79932771a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773201003; x=1773805803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjPaPqrhLT0yunV9ouaN6H60Rrbm7wBsFlGXscdhFO0=;
 b=JkX6D5KJhj7OQdhVxGztac0YbPHTFI9pu7VHkJhSz41l2hmW0M3R7wmGV/IpVNm0eY
 jdD4m6Bs1rjbjuGebsxZ5X8ZxoVXc/IasUjLVt/D5Sry8DtuFYLmF8UUjduSUwXsmiPd
 +6cTsOZCwiZ08qILS0uxfUBg/UQT7eKNC/62vhOJxmBFSU93s0uTbBJYuCvgsqij78C2
 nLROFNU4mma5XSsyyHZgZEpSNCOw8ZNqo3hX/+wcpcArGDfkFBWU4jvOgsb2978IBLIk
 l8jenvWuCx8vKdr1uPrLwUi8jwNmipkL+r9CVpo+pb4SGxeCVSl2LHmKSN//LYfNnkaF
 67ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773201003; x=1773805803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PjPaPqrhLT0yunV9ouaN6H60Rrbm7wBsFlGXscdhFO0=;
 b=fpYD12L20tIJXtk3zi9td+xHhf+P2SZmhCAqCFy3raG3Y0FxSjTsrtmcMdo6aUozR7
 R7SLXVcWCxW8BohCJCuX3ASA2MgAPv+E1nTZgczQ+p9USxHQxTDOOfKqeUyICJ7GP6a1
 il+ce/QdG/dRBfMoLVObUwjESmoj6TIsXGen2swTV+cr4Q9BSEsSEs+TGWnvLjxexjKW
 xA4IZGKgt1ibGsSoiviBFHP0QwwBfX1IQUjZHANT1/kJ4e9U4H6GBAx8OxWhJSqMDuP0
 +dORYY0KaQ1aEgrHx+GcmoI0O5gflYiI9UwSwj/GRgaVq4Vb+R0y4UPpvAW5ZMnN5jK9
 11zg==
X-Gm-Message-State: AOJu0YyKmycvHu+D3iYVYr+x2Q3MHjWJVm81t8aBbaxnfNfOajcXK2IE
 vU+EXA6xaaAxCcXEQMA6ZYUqpfORMSE5eW1VR86onzEFS0BZOQNxYAtX+RiqjLtYy7k1YCndHBs
 aaG4JFvgGL5Vlnrv0S/KfMys6FCG52gpX0MG041krhAh7z8CsMkk4yum8kfR0Ggtj4g==
X-Gm-Gg: ATEYQzyPAM9cehHJUBoEYAT/rWduPLxueJ3d+ceL+bP0eELxc6ArMj17PygfWpLwDTY
 8sWybKI06OJ2EXt+tJ0MrC7tu62AOA+7klN0qE0kISr2+KTBv9qtL4Nk2GmBoIi9rsrRB58Ixfg
 RaxsCq+8QBfsBriSYug/tuxL0hvlDjEIzZ2+5WiHdDEaJ4GwO8c+Re/sr540jY+Zmq93qiAsV7Z
 y0wWEhdSu/XTs9193Kb4PYBC7ZSaxGQF3v4j3lKWInqk0tLAqgNlaFuTOwBfSuPxfzN5jZ7cBEW
 I/fqBr/O/slRGnwXyUAgWe4dI2UBKKaAbaaNMgzAkkcRL4nntt2GLjnkKKyod3xEEb3WjmTvKX7
 IlamBvb/A8fceZLwkdSU7iKpOFXZQZgEkthlgm8JFrYLpUxWNJzPJEWXtaCAJ1bu3FJFLIA==
X-Received: by 2002:a05:6830:4409:b0:7cf:d119:9953 with SMTP id
 46e09a7af769-7d76a6b5e77mr930014a34.16.1773201002849; 
 Tue, 10 Mar 2026 20:50:02 -0700 (PDT)
X-Received: by 2002:a05:6830:4409:b0:7cf:d119:9953 with SMTP id
 46e09a7af769-7d76a6b5e77mr929989a34.16.1773201002315; 
 Tue, 10 Mar 2026 20:50:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:50:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 28/35] target/hexagon: Add TCG overrides for rte, nmi
Date: Tue, 10 Mar 2026 20:49:16 -0700
Message-Id: <20260311034923.1044737-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX+5NQxP2TlsQz
 Y1R+h87gfJCrvcXyds2OG9Am+nbqRSSOtBqwaeLG2cXxwziSb9IB2BriBmTu0Zn0N8q0ddE6SER
 /68z7ooXZ2YiTPLOJPvXMvmsVMYMGfv9RG2X2238AVWXzyPAFXbRsmPnh7bSjJxM7Y/RSpG9huY
 ousjgOPD+EdFTOpozj5JVSJXqKdTBIQ3KgWZkWOcNV2juWZF8iGuGoR6dCzsups/g121EzeyUf3
 o/h+WCPjP8W9BVeFA5555fC0e4YgQjf5IwEey6L4YyLEWa7KmHlVQ0S+KDEt9YFWsQaZ+n+WsoP
 YH0NzySionKeYraBrNYLnApCSloLMmmP/ORtLM0hMtkqDVffQwE/AwXNu/DeiKcquWZpdN35X3E
 WURBKYsWWLxfaACJBR/+cJTparJC/o7oI/7EVf1q/1tvVLzqGMeBDQ9HwGmtwfAU6JICBL+Bu3s
 C3F6/wiMd0LMLFTIvNQ==
X-Proofpoint-GUID: EMeD5coYO-ZhWsU4KW3yQtiIYIJqHZ1H
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0e66b cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zRxYJKy5J8nCns2dKEsA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EMeD5coYO-ZhWsU4KW3yQtiIYIJqHZ1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
CmluZGV4IGVhYzZhMjJmZDY0Li5hZjkzYmU3YTIzMiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0ODAs
NiArMTQ4MCwxMCBAQCB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgdGhyZWFkLCB1aW50MzJfdCBwcmlvKQogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVk
KCk7CiB9CiAKK3ZvaWQgSEVMUEVSKG5taSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHRocmVhZF9tYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CiAjZW5kaWYK
IAogCi0tIAoyLjM0LjEKCg==

