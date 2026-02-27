Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6F410398AD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aL-0007Nr-1Y; Fri, 27 Feb 2026 15:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a9-0006wr-JF
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:05 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a7-0006qB-JI
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:05 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RKEuk82595609
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NdOehtuRBcPgvbCc8MTbGPeDzqk+1UZPxnybEHlpT2s=; b=Q+VESUC2Jev7p+Xn
 odL9zAs6nD0BeZ2+RPRgSBLqtHLdl9UQ1FCdGtNs9VLOdeBs+8hWxUvqzC3HMd8m
 x1feqVgYWMLbYM3jpcY/6RUAcTl4ui2Yh3eUpavQttEVCt47GrIoVJapwd0gN+X1
 zYFCDpruE3bwGri5Pre5xlAnjqUvf+bLZ3fIWJQfxfh8QedX83h79yrsIBmE64eQ
 gzW0HHC4b42PbFEA1Ra8N1KoWAPelHHJKnaEGAQpDsyblVibZZh3ZfwnEHAFOdW1
 HzUDyOrOElD3Ke2Vha480+xTnqqlzXH36zSmoxy5SXXMaFu7HyazkWjTz3HcC0sT
 oQfzNw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckj4xg1q1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:52 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-679c5ed0942so38286969eaf.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224611; x=1772829411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdOehtuRBcPgvbCc8MTbGPeDzqk+1UZPxnybEHlpT2s=;
 b=NO4H1v3Jef0Sk82hTUex4PQcJjLvomLpcr3LcvEPuXRkUiHFP9WVp/MSqYjhPA/SD2
 RoXQvKgCzLbgLYDPx0IJQiJblyQaj6Kf1CEvkvTy/CnpJPr/hJg5EoWpiFjv6yiE6Hrh
 xLoaoD/P+wzB77wJ6ofAgoKrWu2u/WaI4wG1Gmh79y/vtIG/SMS0y8ZRMeQaIKnqLOxV
 fqU87P3EoD5uraAl8c0ivNjndStA39uQIbuwrGLQMFwB7ectFkQZ+5XklZ/VbAerMGfo
 Iq7rgiY/GyzUsSdsilVypp6T+ki6RK2kQv9pwVcds6FoqLIs5L8+0VMwBTJ0BuLETder
 Rn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224611; x=1772829411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NdOehtuRBcPgvbCc8MTbGPeDzqk+1UZPxnybEHlpT2s=;
 b=adENaTRK3VCefVzm934zmMrrs6XfeNLGK61U7mhOBhExlDCjy9Frss606mkfKvFloX
 9fAk7qYbgJdpFSNDQXTcmATD0brqC11/rNywlBdKK098ouBKV2QcpR7FpgGbttqoIMx1
 rpBsI3RjTLmzz4V+ikB3Bjo69UPzbbXjGfrbc22rZZwz1ZTXBcYFl9c66rTRrPhooCZp
 d9X82i3IS5ydMQZfWUYPTGpjHPCT+qbXeW0h1ij7kxDJauATWaB2M43gXvM1SNpy4W9d
 BOQVNuANi1ciG1uqGaV1jkAK6I9flcclwPGoL71MHTRWxssGzQG9g1T45qFIdb9FE9tS
 AhMA==
X-Gm-Message-State: AOJu0Yx8oyJWbJVoVZyrszh9LhfGRtz7Nv0GafEwsTd8s8YjrnPBmKqb
 WJ4IvDkfRLm7JK15ACecyk5Bo6PJKUbuSPsOvm1kOhLaU9ab1kml5OLXX4e2LtqtZGF3a6pG1mq
 PSpyn8GQvCv4KAxXxeXLml7XG5LpHUOgb+vU8KRajBOOzwArN/Fd2wMcCsJQMIJ65IA==
X-Gm-Gg: ATEYQzzd9KU2mckVrY/iNgAIc05jpVd/FRwMwMH2jkRuha9t5RBM7Dwehf/BMMK8SMY
 wsSk9CAqduNf0XQrGsn65w6kKDLEFlgpA9/efTN+v8FMa9zv/N5w/TlDieD9JKHZmWUcVDsrsg+
 C8qJduGMgeoLE7Ek7AoOJQMTOq9nH5Hl7+fNxEHRH1M7u8DDIa3TcYpJHkr3f/7bzWcv97+QGd/
 6CeZhpkmG2clkaTIFQ4eUepGHMNEmTsltGhh6+nsNg0yCdSA4LAAEN0I1KDxeSKsMzWCKWyF1FS
 Y/xq3AIH0G6fqFn8m0VgpQmCjmQlCvNVQ8uWBE1kVLgtPqprT3/je2ehBjl9TJhhBvmgbdprVkc
 RI7Z1BlmqHZ9k56RWAg10/ZzXyWjFF9dwnwbogCThNzxSUZdf718DiW/WICuvyM7Vix9gKQ==
X-Received: by 2002:a05:6871:a868:b0:413:9a9f:9714 with SMTP id
 586e51a60fabf-41626e388f6mr2715471fac.23.1772224611394; 
 Fri, 27 Feb 2026 12:36:51 -0800 (PST)
X-Received: by 2002:a05:6871:a868:b0:413:9a9f:9714 with SMTP id
 586e51a60fabf-41626e388f6mr2715452fac.23.1772224610977; 
 Fri, 27 Feb 2026 12:36:50 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:50 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 13/37] target/hexagon: Add guest, system reg number state
Date: Fri, 27 Feb 2026 12:36:03 -0800
Message-Id: <20260227203627.932864-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX5aIyOGgOELzC
 O0ObtuUGK3ORIvvZpyGD63YhO1bN/5wW2na9KzTzJkMyi2lg39u/eKrVND2v23BpgCGhOVafavr
 PnlDI0bumNOK0l0l5Z5JLBAVZicsPAJhyTEaH6MKxPWj6cDOzHPuithYCJbxGBQ5wCPTYAyiasu
 thvCRW1TK8fe0fNCfXk7QmkJf88R8V0QM1e+qUBKioldrnZ2S5AxhnbaRnl1UpvQnQ4HrylSCm6
 le8tiWEvreJ12YThw8/lo0oQ9E1NLyFVsB5xTko+bmrbWM/L1qzqU0uKb2TZ9TMLe0PClr4MTFs
 WA1po3oGfbQ8xnPqU/4rLM5wnUz6i+qCpgkFbGDazmj8YFxqK0LoubKFT2n+vk2iWoLJfF8QI8c
 jkPuKQ9PSqYLzxyUCCxWXnkfBDJFwTh2jYQgxQsx7jPXDjGFBG5m66DsnhEJyjisEUYtS/Y4E/e
 zUt3lfqr1tyMBpcr/lg==
X-Authority-Analysis: v=2.4 cv=QppTHFyd c=1 sm=1 tr=0 ts=69a20064 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XLwm3O5UTDZd0TI6FywA:9
 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lspwOaHU67NCcXOzTtq2Iio8FpfvN16S
X-Proofpoint-GUID: lspwOaHU67NCcXOzTtq2Iio8FpfvN16S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgNyArKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8IDQgKysrKwogMiBmaWxlcyBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1
LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCAzNjE5ZWFhMWE1Mi4uMDU3YTVmMjBhNjcg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2Nw
dS5oCkBAIC05Nyw2ICs5NywxMyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3RhdGUgewogICAg
IHRhcmdldF91bG9uZyBzdGFja19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9jYW5jZWxsZWQ7
CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8qIFNvbWUgc3lzdGVtIHJlZ2lzdGVy
cyBhcmUgcGVyIHRocmVhZCBhbmQgc29tZSBhcmUgZ2xvYmFsLiAqLworICAgIHRhcmdldF91bG9u
ZyB0X3NyZWdbTlVNX1NSRUdTXTsKKworICAgIHRhcmdldF91bG9uZyBncmVnW05VTV9HUkVHU107
CisjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3ZhbHVlX3VzcjsKIAogICAgIE1lbUxvZyBt
ZW1fbG9nX3N0b3Jlc1tTVE9SRVNfTUFYXTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2Nw
dS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggYTM4NTY4YTI4NTcuLmM0ZGY3Y2JlMzBi
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9j
cHUuYwpAQCAtMzA2LDYgKzMwNiwxMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9o
b2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKICAgICBzZXRfZmxvYXRfZGV0ZWN0X3Rp
bmluZXNzKGZsb2F0X3RpbmluZXNzX2JlZm9yZV9yb3VuZGluZywgJmVudi0+ZnBfc3RhdHVzKTsK
ICAgICAvKiBEZWZhdWx0IE5hTiB2YWx1ZTogc2lnbiBiaXQgc2V0LCBhbGwgZnJhYyBiaXRzIHNl
dCAqLwogICAgIHNldF9mbG9hdF9kZWZhdWx0X25hbl9wYXR0ZXJuKDBiMTExMTExMTEsICZlbnYt
PmZwX3N0YXR1cyk7CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBtZW1zZXQoZW52LT50
X3NyZWcsIDAsIHNpemVvZih0YXJnZXRfdWxvbmcpICogTlVNX1NSRUdTKTsKKyAgICBtZW1zZXQo
ZW52LT5ncmVnLCAwLCBzaXplb2YodGFyZ2V0X3Vsb25nKSAqIE5VTV9HUkVHUyk7CisjZW5kaWYK
ICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfRVZFTlRfTk9ORTsKIH0KIAotLSAKMi4zNC4xCgo=

