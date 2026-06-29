Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnf-0004dr-Nk; Mon, 29 Jun 2026 09:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnd-0004cR-KT
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnb-0003E7-PC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3iZ2646903
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=; b=pZk5bmI+VVWLnshr
 oDlq2EPCxDeiAxEzpFAKcgaTW8peGQqt59TPrI3ZAui3r3gLZCoszHepDn+AI2cB
 5PX4UlIk/wiSWiuJItE34ci92Ap56jbHlrO6PO3bia12OEL+Q9UQnR4f42OPt4Y1
 M/e8uUvC25nqsiFfOQl/6wCf3DF6X2l2gSVHSyR19MOKpqwspSghoW6rpgRYmYzJ
 UM6k0H2vCLHZaBY069IzZZGaI6IY/xiYQRaKDCxtnsXvugPfGX8GHgtEHh78FIa0
 3vrssshsTtVaxdzaVo5Rvj+CEUmkw9H/jZ8P9hCltMZmK4nqGt+0nT5mtan+HgW9
 XUDLLg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tsdm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b70ca7e5so6898456c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738797; x=1783343597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=;
 b=jWV/lohUk6BY+Z+/rVoZGWQq7l30UusxK2iU3x0G2+u/GGnNx6o49TuDNfzPvCfhNe
 ERf4SVInQ/UgdGD8/VjtP8DMe4dEibtD2LnS8yevThqfP/HpsqLmjWtoOixB5p9wALUZ
 iZf9wSrkvNKahlOZPOZBKxfON2avJGcO+e4kOFlRxKWnKdP+ivUUquxyDPq9DFxd4JrY
 7yvBasTcfsqWN+LHpZKUM4ruj90cvyMli7GwdAUdXIt8ATYYtFkd9QtphkchspNYozZw
 DFlhz4UQgzNwQzHng3F1pARCjnOMGpdEuPUqR4+B6mwwecrAFfBTJ4uh4mrMNyqKTK3P
 kSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738797; x=1783343597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=;
 b=Yg/1zVJMgEUE35m04XCje2lvDXt/jRo5JRpxgXSp67H1QOHcQyEJC37r1IQvYEj/RS
 1A2Mq9Di7/l8vCV6SsGM0dLTXv+bOrmRUTS0gTpM/aEF4Y8+xM2SuA6j/+kynpXdajm0
 2zz6GgO8sfFB1Lq1/bFf+f6DLCAM28geovI4MNSipSoCrpT4s0atCHVW/hzLjwIMY3Wy
 oElcgLCQAsKxnVSWejt+IgsC3932ImdxdWi1Gon0FSMImc8QYGErEZErNWtCjokB8Ez8
 WFQNhP9ANgXwNFaKdBueBT1s4olhy4gCFNTY0rosOetzJvTKbrIeU99oGxj2Ac/Ng5EB
 84eQ==
X-Gm-Message-State: AOJu0Yw1RFUGLWomy77DG+QHgPr6/3KZlnWpQVa8ocZLvXd8BX5VQ3hz
 c73RuBr28bT5QPIYz/bjIIqUjXkvbyoWNvmiHiV1mot2YGX1v1+ahhpPNrr+OzC2j9sZ9B1H4xl
 aJAaWXvtHlHL2XSN1j+LQnBk8+zkMLOm1jgX9Opn0yOsrKCDCNZl7s4Y5032nQgI6Ng==
X-Gm-Gg: AfdE7ckM/z5XXxU90C7Z9n6+ebcxOLrLnKrti89kcPx06iMmr44x1dwUSNGrDJIcs0p
 aavJE4XD689gZijHQJILqMKh8XxrIAmzLOxJVv/m8wy4aahKvKgPgE8xnbWd9K2fj6xr7n4wsZ8
 /iee5lHZ+cKp7y2B5aYKN/dYhoFzxhbUBZofendMHnrPRnNmH8lv9RJsZw5z/LFbQpz5TvlVp+U
 kPYj3zNhV4upMVxRUqbkcfQvvJCSEkQ4TVjdwy5OzcIwfuDc0EeKcINJpUe4Op7fjg0kY5nhIyv
 8LDx51RXSYmbQlTj+oK8Er9BtaPPXZBORHVD8Pu6+1aL+/FV9xQKxn04qZxUFZSr4ZoV1IebIbo
 NSu68w+WDLccu8vDhS2g9w7ZwEjhR5bLVZBgkIwZAapIioGm7zc0LuSPCaZ4=
X-Received: by 2002:a05:7022:69e:b0:136:b67e:93e6 with SMTP id
 a92af1059eb24-139dbac9d7amr12990994c88.37.1782738797297; 
 Mon, 29 Jun 2026 06:13:17 -0700 (PDT)
X-Received: by 2002:a05:7022:69e:b0:136:b67e:93e6 with SMTP id
 a92af1059eb24-139dbac9d7amr12990968c88.37.1782738796581; 
 Mon, 29 Jun 2026 06:13:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 24/77] target/hexagon: Define register fields for system regs
Date: Mon, 29 Jun 2026 06:11:39 -0700
Message-Id: <20260629131232.2487780-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX6j2e6Vgs0O2x
 ppi3Rb+a403r17Gtf39goMOy6ddtubBYpgrjiGjF3/cj0XHQ+weZPXLQ5GRXpK6MDJHOTxKtayb
 fFQiUduE03Y1rMB5NKic1g+Z3aCy3JhUy/CIXZeFVEWEEAyhDTqlqm7ld+GUM+Wr3IWuSWYr3S6
 o+dt3QDk8dvnhtxn++M1IHWBpsJxXI3tS8CCoFL3q9pf4SrHqRf3wXEP4oIzPpsgKZ5NObbA3Su
 tfQHIcQwFBbNtxevxT/TWGGFXC8fP+SqZHe7vbvpuszztJGXKab8i44xshSHoIKqvaKpc3Oa+N1
 fv9e/Vnej5sHJfLkYMx3lPARMflXNO0Rufe76qn9VixxtLUPcZnrp9a9IT+VfcZFjUTBop4awvY
 JH9e9gBzv2KkYSDku04BdigQh9n0jHlABuxoFZ1pJphIYw+CANhm0WXDWLInFzgLya4Z1igqcLC
 xky/4R/nkJPrOTtQvow==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a426f6d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX/lVWhsad3JVo
 p0YfqD99usP+X1VEbd6n+ktFcUEg9ikOjxhq5vIH7MCm7h5o6HkqSJmS+8j25rv04Rar67nT04P
 1zY1JT6ft8oAtt21p8jMHwfdlMp/LmI=
X-Proofpoint-ORIG-GUID: XZwpFlNnGmsYZ4F10w2CjIyqfysdvhe0
X-Proofpoint-GUID: XZwpFlNnGmsYZ4F10w2CjIyqfysdvhe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgdGhlIHJlZ2lzdGVy
IGZpZWxkcyBmb3Igc3NyLCBzY2hlZGNmZywgc3RpZCwgYmVzdHdhaXQsIGNjciwKbW9kZWN0bCwg
aW1hc2ssIGlwZW5kYWQuCgpEZWZpbmUgdGhlIGZpZWxkcyBmb3IgVExCIGVudHJpZXMuCgpSZXZp
ZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIHwgOTYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgYi90YXJnZXQvaGV4YWdvbi9y
ZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCBmMmE1OGQ0ODZjNS4uOWIxMTJjY2VjNjQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0zOSwzICszOSw5OSBAQCBERUZfUkVHX0ZJ
RUxEKFVTUl9GUERCWkUsICAgICAgICAyNiwgMSkKIERFRl9SRUdfRklFTEQoVVNSX0ZQT1ZGRSwg
ICAgICAgIDI3LCAxKQogREVGX1JFR19GSUVMRChVU1JfRlBVTkZFLCAgICAgICAgMjgsIDEpCiBE
RUZfUkVHX0ZJRUxEKFVTUl9GUElOUEUsICAgICAgICAyOSwgMSkKKworREVGX1JFR19GSUVMRChJ
UEVOREFEX0lBRCwgMTYsIDE2KQorREVGX1JFR19GSUVMRChJUEVOREFEX0lQRU5ELCAwLCAxNikK
KworREVGX1JFR19GSUVMRChTQ0hFRENGR19FTiwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU0NIRURD
RkdfSU5UTk8sIDAsIDQpCitERUZfUkVHX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIDAsIDkpCisKKwor
LyogUFRFIChha2EgVExCIGVudHJ5KSBmaWVsZHMgKi8KK0RFRl9SRUdfRklFTEQoUFRFX1BQRCwg
MCwgMjQpCitERUZfUkVHX0ZJRUxEKFBURV9DLCAyNCwgNCkKK0RFRl9SRUdfRklFTEQoUFRFX1Us
IDI4LCAxKQorREVGX1JFR19GSUVMRChQVEVfUiwgMjksIDEpCitERUZfUkVHX0ZJRUxEKFBURV9X
LCAzMCwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX1gsIDMxLCAxKQorREVGX1JFR19GSUVMRChQVEVf
VlBOLCAzMiwgMjApCitERUZfUkVHX0ZJRUxEKFBURV9BU0lELCA1MiwgNykKK0RFRl9SRUdfRklF
TEQoUFRFX0FUUjAsIDU5LCAxKQorREVGX1JFR19GSUVMRChQVEVfQVRSMSwgNjAsIDEpCitERUZf
UkVHX0ZJRUxEKFBURV9QQTM1LCA2MSwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX0csIDYyLCAxKQor
REVGX1JFR19GSUVMRChQVEVfViwgNjMsIDEpCisKKy8qIFNZU0NGRyBmaWVsZHMgKi8KK0RFRl9S
RUdfRklFTEQoU1lTQ0ZHX01NVUVOLCAwLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfSUNFTiwg
MSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0RDRU4sIDIsIDEpCitERUZfUkVHX0ZJRUxEKFNZ
U0NGR19JU0RCVFJVU1RFRCwgMywgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0dJRSwgNCwgMSkK
K0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0lTREJSRUFEWSwgNSwgMSkKK0RFRl9SRUdfRklFTEQoU1lT
Q0ZHX1BDWUNMRUVOLCA2LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfVjJYLCA3LCAxKQorREVG
X1JFR19GSUVMRChTWVNDRkdfSUdOT1JFREFCT1JULCA4LCAxKQorREVGX1JFR19GSUVMRChTWVND
RkdfUE0sIDksIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19UTEJMT0NLLCAxMSwgMSkKK0RFRl9S
RUdfRklFTEQoU1lTQ0ZHX0swTE9DSywgMTIsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19CUSwg
MTMsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19QUklPLCAxNCwgMSkKK0RFRl9SRUdfRklFTEQo
U1lTQ0ZHX0RNVCwgMTUsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMkNGRywgMTYsIDMpCitE
RUZfUkVHX0ZJRUxEKFNZU0NGR19JVENNLCAxOSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wy
TldBLCAyMSwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyTlJBLCAyMiwgMSkKK0RFRl9SRUdf
RklFTEQoU1lTQ0ZHX0wyV0IsIDIzLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJQLCAyNCwg
MSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX1NMVkNUTDAsIDI1LCAyKQorREVGX1JFR19GSUVMRChT
WVNDRkdfU0xWQ1RMMSwgMjcsIDIpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMlBBUlRTSVpFLCAy
OSwgMikKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyR0NBLCAzMSwgMSkKKworLyogU1NSIGZpZWxk
cyAqLworREVGX1JFR19GSUVMRChTU1JfQ0FVU0UsIDAsIDgpCitERUZfUkVHX0ZJRUxEKFNTUl9B
U0lELCA4LCA3KQorREVGX1JFR19GSUVMRChTU1JfVU0sIDE2LCAxKQorREVGX1JFR19GSUVMRChT
U1JfRVgsIDE3LCAxKQorREVGX1JFR19GSUVMRChTU1JfSUUsIDE4LCAxKQorREVGX1JFR19GSUVM
RChTU1JfR00sIDE5LCAxKQorREVGX1JFR19GSUVMRChTU1JfVjAsIDIwLCAxKQorREVGX1JFR19G
SUVMRChTU1JfVjEsIDIxLCAxKQorREVGX1JFR19GSUVMRChTU1JfQlZTLCAyMiwgMSkKK0RFRl9S
RUdfRklFTEQoU1NSX0NFLCAyMywgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1BFLCAyNCwgMSkKK0RF
Rl9SRUdfRklFTEQoU1NSX0JQLCAyNSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1hFMiwgMjYsIDEp
CitERUZfUkVHX0ZJRUxEKFNTUl9YQSwgMjcsIDMpCitERUZfUkVHX0ZJRUxEKFNTUl9TUywgMzAs
IDEpCitERUZfUkVHX0ZJRUxEKFNTUl9YRSwgMzEsIDEpCisKKy8qIG1pc2MgcmVnaXN0ZXJzICov
CitERUZfUkVHX0ZJRUxEKElNQVNLX01BU0ssIDAsIDE2KQorCitERUZfUkVHX0ZJRUxEKFNUSURf
UFJJTywgMTYsIDgpCitERUZfUkVHX0ZJRUxEKFNUSURfU1RJRCwgMCwgOCkKKworLyogTU9ERUNU
TCBmaWVsZHMgKi8KK0RFRl9SRUdfRklFTEQoTU9ERUNUTF9FLCAwLCA4KQorREVGX1JFR19GSUVM
RChNT0RFQ1RMX1csIDE2LCA4KQorCitERUZfUkVHX0ZJRUxEKENDUl9MMUlDUCwgMCwgMikKK0RF
Rl9SRUdfRklFTEQoQ0NSX0wxRENQLCAzLCAyKQorREVGX1JFR19GSUVMRChDQ1JfTDJDUCwgNiwg
MikKKworREVGX1JFR19GSUVMRChDQ1JfSEZJLCAxNiwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX0hG
RCwgMTcsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9IRklMMiwgMTgsIDEpCitERUZfUkVHX0ZJRUxE
KENDUl9IRkRMMiwgMTksIDEpCitERUZfUkVHX0ZJRUxEKENDUl9TRkQsIDIwLCAxKQorCitERUZf
UkVHX0ZJRUxEKENDUl9HSUUsIDI0LCAxKQorREVGX1JFR19GSUVMRChDQ1JfR1RFLCAyNSwgMSkK
K0RFRl9SRUdfRklFTEQoQ0NSX0dFRSwgMjYsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9HUkUsIDI3
LCAxKQorREVGX1JFR19GSUVMRChDQ1JfVlYxLCAyOSwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX1ZW
MiwgMzAsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9WVjMsIDMxLCAxKQotLSAKMi4zNC4xCgo=

