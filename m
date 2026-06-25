Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D965CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktg-0006wR-JR; Thu, 25 Jun 2026 10:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktd-0006vd-BS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktb-0008VR-Et
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jvJt1754173
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=; b=XVbx3yotwXeGgKfu
 kiEDyWBL5+Cj60cpLFRoXRveeYCTmbIPFe2TbSsnOcfZp9D/bhIpmw/N4RGu46XK
 GMaepJFjRfq72w7TMoGJkfRQJ1NDeeFXKKSbgvNqSWsUEa3qYPAyy9IJSmWAXic0
 0kEhTHy3UgG1Yqj2Tge6kSMd7TDN5IQhH8in3j52vz+WADlECOFRTAfpP9ipGE9q
 ZxQMeoj0cJ6l/nyTLMUa96AD0588rCTqIhWAKwU5Cmo3tl4FUzGIo4GAVkv4PUm4
 j9HtdfMHZBAy02EBQkaHCE1ZDQw88iVgzzWuiCGwTOx6zJtiVwE9bpweM0QsiuqU
 6GzU4w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q26vt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c5b9f6a51so648482eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397043; x=1783001843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=;
 b=P7Exet2X3eZlQ+U4JGE31lRs711xx10r5uNWaAKMdkQPFlrVnD8qA2NSoVJQQRYpD3
 1iMgXaTyAG9Qot9jHRasD9raMeBSuTB1l9K6ElqPEzYVdrn2CutD5molrm9VE6hX7qcS
 aV4LBLFV/kghzXyCku61VDyIIWubU8JSSVQv/u/6LfKEYrYZoYk2rLZeYG6JA8Yp8Ebe
 4VpbuCYccYY5KrCs2l3o2c9VU4cngxWFnrrTWy2eGf3SQ45lcNzBoJhDF62XE3PEt+Gs
 HZxGHvMvp7d5HwxoAKyvZfw4+K6nt8QuFt/OfV6mDqIGtQEVwDHmkayZ7lBff2NKxAg1
 8zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397043; x=1783001843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gR7dx5FAHey0hvTHweaG0/Fx4UXE1mDGyZgCKofpSwQ=;
 b=UVUR4Av0Qz4BZu/ZMmGYYphUsCPpeLR1A4mcXqO1zqp5xunbn/HoXtSd3HpltRsx6l
 7qSRSz9BaQrh1TXZM7bOmVCk61iiVdXnzk8HVr45ISLZ3WehsztQCg9oi55Ox1pSFc5f
 NQLCAmGAaFXWQtCS1dJbjH0wxaiAGYlFDsE2f0F8GmDnlk4sKUDhdHutjvMpHxgOV33A
 /Gv6Xk4FAZDipxDkLdjzbvN62SL7l2scNm7tGjuA49q14UFUop0NSTbL+DpJZymMcBuC
 5zm+cdUW8vJBTCCda9JUcp/qUcpCC9GPq7FtNhvFfVx8lz5I9uoH4to23FIGXtDS4zFA
 6/bg==
X-Gm-Message-State: AOJu0YwIN9o4A0fEqOSUdzC6uH5XyjKHnTkQVMywcqD1jTFXTqq5EXyg
 3x5wuaylsbBBLj7pXD0XNj8FB/2j7rVIS5WiofY6njrtLV+EmXnSXV/K8GGewwe6n3l5yimaf7j
 e8hD8+Calt7jOVk2Ul+JxgSBAU9xDWV4lThs0IYQmvBsdeM+wtQRziRmy1jXz2+k1PA==
X-Gm-Gg: AfdE7cm6Y5gJ9RqZdXG0DTPCTkAgMDLiAGi2+YBc7vAVEdkMQ3sPEuhncrU+thoGsoU
 AKLb1T6Wb52oRUBqWpgjTv6TW7GjilE7cRHUbFlZS4uDYgbENDfup8S4BNXQ0t8eXJmU4zgmIdj
 L26GkoLhoG11UWUMmyVdLd1I9ZA337CCesEsBc2SDO6fQo2SD5jynlLqDvaoUC9ts8sNqozmFka
 /iQq0rg0uXB74LlOFZD6RlrR+GHxMruIkvaYKfVOyYGcHrHfLY+hqqm8ao7uLKi25621PiRl4+0
 o4QbKVXG1eWO3VGly4Agxn5CLgal6vZ3xY+aoIozuPO5569mXGky9l2TGoqI5kSwitUJCzLEaLi
 boQxs+5ePmGuXqAnGAVDGtXPFBDwZnP6ueB6FAGRkULtXxOcDQolSTqxXPgc=
X-Received: by 2002:a05:7300:4312:b0:304:bd90:b88f with SMTP id
 5a478bee46e88-30c85a5c6a7mr2775701eec.9.1782397043376; 
 Thu, 25 Jun 2026 07:17:23 -0700 (PDT)
X-Received: by 2002:a05:7300:4312:b0:304:bd90:b88f with SMTP id
 5a478bee46e88-30c85a5c6a7mr2775673eec.9.1782397042663; 
 Thu, 25 Jun 2026 07:17:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 23/76] target/hexagon: Define register fields for system regs
Date: Thu, 25 Jun 2026 07:15:40 -0700
Message-Id: <20260625141633.449487-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: NVrjm5rcU4DiamRwwSFhy6JGsQ44hdz8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX7hA+hcYmi+qw
 JXAcGXu5IQdpC0st0kQIUGp11AfFK3QpEZSPJyUa6N+M6eRsOKxYdnzzRl7DjZJcqzixHNxIcM8
 qbmxy8LAtaQSJ7rkjJbKf4p4p7Sb1ys=
X-Proofpoint-GUID: NVrjm5rcU4DiamRwwSFhy6JGsQ44hdz8
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d3874 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX5I3r1R3pVG1g
 iewUr+H70KvcVHwmjskFh5NIjVhD8HwF6Uxihk4K6QrLL4dra+XB5SyTyJsCGSvUnys49EuRKvJ
 vu8rfqdr69ISMWG6l35IUNYJZBRsey9Q7l9IGVmp8+tyM63A/od06Ema94zJJgbdJCvJmZlEQ9u
 yCKp/tGTHplouZuAhPv6qJ0XWCUU2CQ071n+wxW5vPaXjx6tCAsmuaT9PVO7U/4VEhvrnZ4siGl
 Td51VEmUZaOnDMt13QxRZWtk568sPs83gvU0Tc+2rhKlVOhwgNUDn/vZTvBCvAw0mg8sF3bJnqC
 4CTOvV3WW5Wto81aqCtzsO0npcPX9jok8PmsOIND8LFqR4gUvHJMmTA1ZslWUpbJwJhtqZx6IU+
 mNiBBh+TieBJ3tyY3NtZa0SGXaswhSH7ivN7SR7Uq6CPEeIH6yn+4KAld1ReSbhlIMpK8ig/1WR
 vZrwwvO/CfFKErddA6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

