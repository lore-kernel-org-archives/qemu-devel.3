Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9808C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqJ-0002rm-F7; Sat, 05 Sep 2026 14:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqA-0002qj-WD
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq9-0001RB-26
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:10 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HcU8f4117451
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hQAp/rIDMa1sYGRkoRCgkVwiNEWZvL9ZQuXRJCszO/k=; b=dkOJmfRiion3sYwA
 hSnNRcl/wqO48cooGcZwAMAWBcKJl8DyCIVZmrN8akaamie2UhGUZSgGdNv4lr6X
 FzBFFFWPvE7t8MUF5j8AZWpxrN0nRBjIrXOQlxl86ZXEI1Mo1vpmsE9/l1WakSRE
 NGEljMHZwUi/ZDRhj19RqPmA42T0gqdUlX2UXhRq1zP49kh6OKtrIzv94Wk5oj+P
 Sj9qVyIfCGKb5VsPwTJVKfDJEXvoRcgcgb6d4klJaOPOm3Uk2HAAedB0ljCkQhtI
 4D7GRHsUqUq5M2U4ne6Ac3OL8/5wZ3cia2QLfLVJDy7Io7Vyihb3SRN78uq2M2s1
 KbMR6w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8sd2d0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so3517476a12.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631806; x=1789236606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hQAp/rIDMa1sYGRkoRCgkVwiNEWZvL9ZQuXRJCszO/k=;
 b=d98Ef+WCPnF8MMMr0u7dUXthqZv8Oc1MzI+9ErZBK2OL5zaSDwGY3qFyVZ8n1pHNF8
 aBeqyH5UeNyWI3MBJa99wkD1MvV7MC9s/wsuxrKMPuFS5/BJdrRZzHyTOON1UouzjjXf
 OiVnU1EtxQVpeaVl6qyLCubLAsWn/OWGkiV0LEOeFtJHDiWPNr5Kdp2WgfamAMfloQU0
 1t28BOK72VLdhFF2nzKku0vw7vbVNnD3nZ20JnNpdn2520NecQxwx7XAm0piv9YwtDXa
 bSByw2TXB3cYIa0X1DqYXTrSkcJBgcQL/B8j5kyaUygfJjZqRHsNoMOJmNDzY6Fzc/nU
 U3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631806; x=1789236606;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hQAp/rIDMa1sYGRkoRCgkVwiNEWZvL9ZQuXRJCszO/k=;
 b=HXVeViHOVMT0UVhcRFfT/DOXYpRb7nSqFkEx/q7tlkzl7M1dP6JJCVqX8OrC8eZu/I
 HuxGM9C24L9Fim4jxIPyn6XIACw4FSovEbUARzjjGVg3EIYKXw9SWEg73wxcX6DkaiFd
 o/d3D6Tm8eC4n3ru15uiQlExYCkEHBrKT7epMnUic0zZbpiznp+vUrP0iKFh6OBmOxj0
 IqF/qAaN65ZHWW0uIEF5Oee3gYdXvjvwtkWLqXc0csdyuy1LXSc5WTP3+t6veMa399Ax
 4GNgoku6z7yG1EjcuxYFtbHPLrO3XlRXYmtTkX7m7Vxcc6bCCC5r93QhO8Ic7MyAjY/b
 ekcw==
X-Gm-Message-State: AFuF++kCvSJrm8htAVVtgAXV2n3jM6vaL3PxiT0JNA+dB+6CrTo6GO7u
 2N2fcUJzFw5MPGgVyesxoskv5Cv/CmrNRcix2vibFFRuE10HYlMa/7SHRMcRxcjqjs7PEtg23Cq
 0h1z0lK+FRiKsXO+rwACmT75BOMwXMfdDvHl46A2TCSiSVnNFfQzsnzqRvzKCAhibvA==
X-Gm-Gg: AYBFou1YUwCQPZoiyxhK+M2ys413mHTe6sedZwELWcG6UgTRk7jUrLmaGNcELMan2Os
 C9Tpf8HxO5vRYPtkyZFaI77MPjOamjXQ+NHh3C1Jf+Fy89nCq+WHXMoSDyQW28HSkdj4vUuf0Rk
 JneifTCvi8+hnA3jRFa2ZAF0UwySUdV7YGtMvS0yp81FPz/2sBurthD+26xeTzNGgZNH7J6qrqg
 /Wk+Df5jrQN8MJn+2KGYqn7XJr58Q1H6e/NOLovaRWKHL/E6dbuRUE75WJgPp8ls+VIdVZE3g1j
 pMim0yOk8y6MLha/b8/YGAswEKOQnmHrKGutgnG7RsL7m1MZggV7AvGq1Qu5oEo0+/ly0ECp7mX
 GxJ8hMY9ZeOnxWa2yzZjyZQez4Xk3agVJiqWpNw7gtxqrORPJ
X-Received: by 2002:a05:6a21:3995:b0:3d3:adad:f176 with SMTP id
 adf61e73a8af0-3da3a14794emr21012620637.24.1788631805686; 
 Sat, 05 Sep 2026 11:10:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:3995:b0:3d3:adad:f176 with SMTP id
 adf61e73a8af0-3da3a14794emr21012581637.24.1788631805257; 
 Sat, 05 Sep 2026 11:10:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 06/17] tests/tcg/hexagon: add FP classification, conversion,
 and fixup tests
Date: Sat,  5 Sep 2026 11:09:38 -0700
Message-Id: <20260905180949.1852673-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: XDX1DzJxJnU31wTtxD6vf6AFaOlmcpS9
X-Proofpoint-ORIG-GUID: XDX1DzJxJnU31wTtxD6vf6AFaOlmcpS9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX4JEoBFd/Y0uH
 jwLaED2ld4oc44593CuzxeZ4WoYwMA9KrkvDXoxBdoCv5ArPQtyVvPqbyIQUxBX780kB4hN+oRd
 jhpT595thoo8yku6gu7+QVH6C5BLXxg=
X-Authority-Analysis: v=2.4 cv=dfmwG3Xe c=1 sm=1 tr=0 ts=6a9c5afe cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=anSrM8_wVXE1bCkXRQoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXwZC1h7JiJDm2
 C4/T70UiCf77x4BfOCN8dIRInSB0va3eS43eebgOZnflQwJWxWZwawHZtTuKZO16g+sMkd2OOci
 1lZ0yp7/hNS108iLMnja2Sbv0Oykne5t9FlEWY50I4W2goAjUh99RX8kFDJTbCgDvnOC4lVMjr3
 /avKKXd+i0wSF3mYJNgo0OuyMXricCo1Wp0SUBVJjdlXq+T7qmxP193T3lW1qTs3iiF/gmSwODh
 PqFCWBkie44LHnU5Sto8c3HNbFiW4qTmJ/xcNiqissuS0ik2yaxNQlFLI2pR2Pg02xbXOxSJ2J1
 hEL0Rmbc4YkhNWh1XRKLokL5rD1V+WeeAEOCU375eMiHcBwYqnGzzvzf7w/gxZSklz22NhovmNn
 H2djSsIPCgR/V0xEtAL0aOLk6l6H9iTCZalcg042kolDFGau8Rf2+tUSENnoWbTmdbGcaOepWIG
 /18rkqrocg7LRmIxZIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050201
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

QWRkIHNmY2xhc3MvZGZjbGFzcyBGUCBjbGFzc2lmaWNhdGlvbiB0ZXN0cywgdW5zaWduZWQtdG8t
ZG91YmxlCmNvbnZlcnNpb25zLCBhbmQgZGZtcHlmaXggZGVub3JtYWwgZml4dXAgdGVzdHMuCgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIHwgMTc1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIGIvdGVzdHMvdGNnL2hleGFnb24v
ZnBzdHVmZi5jCmluZGV4IDZhYWRhY2NhYmRmLi43NTYxZjMxY2RjMyAxMDA2NDQKLS0tIGEvdGVz
dHMvdGNnL2hleGFnb24vZnBzdHVmZi5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1ZmYu
YwpAQCAtNzExLDYgKzcxMSwxNzYgQEAgc3RhdGljIHZvaWQgY2hlY2tfZGZtcHl4eCh2b2lkKQog
ICAgIGNoZWNrNjQocmVzNjQsIDB4N2ZlZmZmZmZmZmZmZmZmZlVMTCk7CiB9CiAKKy8qCisgKiBz
ZmNsYXNzIG1hc2sgYml0czoKKyAqICAgYml0IDA6IHBvc2l0aXZlL25lZ2F0aXZlIHplcm8KKyAq
ICAgYml0IDE6IHBvc2l0aXZlL25lZ2F0aXZlIG5vcm1hbAorICogICBiaXQgMjogcG9zaXRpdmUv
bmVnYXRpdmUgZGVub3JtYWwKKyAqICAgYml0IDM6IHBvc2l0aXZlL25lZ2F0aXZlIGluZmluaXR5
CisgKiAgIGJpdCA0OiBwb3NpdGl2ZS9uZWdhdGl2ZSBOYU4KKyAqLworI2RlZmluZSBURVNUX1NG
Q0xBU1MoVkFMLCBNQVNLLCBFWFBFQ1QpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgdWludDMyX3Qg
cmVzOyBcCisgICAgICAgIGFzbSgiJVtyZXNdID0gIzBcblx0IiBcCisgICAgICAgICAgICAicDAg
PSBzZmNsYXNzKCVbdmFsXSwgIyIgI01BU0sgIilcblx0IiBcCisgICAgICAgICAgICAiaWYgKHAw
KSAlW3Jlc10gPSAjMVxuXHQiIFwKKyAgICAgICAgICAgIDogW3Jlc10gIj0mciIocmVzKSBcCisg
ICAgICAgICAgICA6IFt2YWxdICJyIihWQUwpIFwKKyAgICAgICAgICAgIDogInAwIik7IFwKKyAg
ICAgICAgY2hlY2szMihyZXMsIEVYUEVDVCk7IFwKKyAgICB9IHdoaWxlICgwKQorCitzdGF0aWMg
dm9pZCBjaGVja19zZmNsYXNzKHZvaWQpCit7CisgICAgLyogWmVybzogbWFzayBiaXQgMCAqLwor
ICAgIFRFU1RfU0ZDTEFTUyhTRl96ZXJvLCAweDAxLCAxKTsKKyAgICBURVNUX1NGQ0xBU1MoU0Zf
emVyb19uZWcsIDB4MDEsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl96ZXJvLCAweDAyLCAwKTsK
KworICAgIC8qIE5vcm1hbDogbWFzayBiaXQgMSAqLworICAgIFRFU1RfU0ZDTEFTUyhTRl9vbmUs
IDB4MDIsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl9vbmUsIDB4MDEsIDApOworCisgICAgLyog
RGVub3JtYWw6IG1hc2sgYml0IDIgKi8KKyAgICBURVNUX1NGQ0xBU1MoU0ZfZGVub3JtLCAweDA0
LCAxKTsKKyAgICBURVNUX1NGQ0xBU1MoU0ZfZGVub3JtLCAweDAxLCAwKTsKKworICAgIC8qIElu
ZmluaXR5OiBtYXNrIGJpdCAzICovCisgICAgVEVTVF9TRkNMQVNTKFNGX0lORiwgMHgwOCwgMSk7
CisgICAgVEVTVF9TRkNMQVNTKFNGX0lORiwgMHgwMSwgMCk7CisKKyAgICAvKiBOYU46IG1hc2sg
Yml0IDQgKi8KKyAgICBURVNUX1NGQ0xBU1MoU0ZfUU5hTiwgMHgxMCwgMSk7CisgICAgVEVTVF9T
RkNMQVNTKFNGX1NOYU4sIDB4MTAsIDEpOworICAgIFRFU1RfU0ZDTEFTUyhTRl9RTmFOLCAweDAx
LCAwKTsKKworICAgIC8qIENvbWJpbmVkOiBhbnkgY2xhc3MgKGFsbCBiaXRzIHNldCkgKi8KKyAg
ICBURVNUX1NGQ0xBU1MoU0Zfb25lLCAweDFmLCAxKTsKK30KKworLyoKKyAqIGRmY2xhc3MgbWFz
ayBiaXRzIGFyZSB0aGUgc2FtZSBhcyBzZmNsYXNzLgorICovCitzdGF0aWMgY29uc3QgdWludDY0
X3QgREZfSU5GID0gMHg3ZmYwMDAwMDAwMDAwMDAwVUxMOworc3RhdGljIGNvbnN0IHVpbnQ2NF90
IERGX2Rlbm9ybSA9IDB4MDAwMDAwMDAwMDAwMDAwMVVMTDsKK3N0YXRpYyBjb25zdCB1aW50NjRf
dCBERl9uZWdfb25lID0gMHhiZmYwMDAwMDAwMDAwMDAwVUxMOworCisjZGVmaW5lIFRFU1RfREZD
TEFTUyhWQUwsIE1BU0ssIEVYUEVDVCkgXAorICAgIGRvIHsgXAorICAgICAgICB1aW50MzJfdCBy
ZXM7IFwKKyAgICAgICAgYXNtKCIlW3Jlc10gPSAjMFxuXHQiIFwKKyAgICAgICAgICAgICJwMCA9
IGRmY2xhc3MoJVt2YWxdLCAjIiAjTUFTSyAiKVxuXHQiIFwKKyAgICAgICAgICAgICJpZiAocDAp
ICVbcmVzXSA9ICMxXG5cdCIgXAorICAgICAgICAgICAgOiBbcmVzXSAiPSZyIihyZXMpIFwKKyAg
ICAgICAgICAgIDogW3ZhbF0gInIiKFZBTCkgXAorICAgICAgICAgICAgOiAicDAiKTsgXAorICAg
ICAgICBjaGVjazMyKHJlcywgRVhQRUNUKTsgXAorICAgIH0gd2hpbGUgKDApCisKK3N0YXRpYyB2
b2lkIGNoZWNrX2RmY2xhc3Modm9pZCkKK3sKKyAgICAvKiBaZXJvOiBtYXNrIGJpdCAwICovCisg
ICAgVEVTVF9ERkNMQVNTKERGX3plcm8sIDB4MDEsIDEpOworICAgIFRFU1RfREZDTEFTUyhERl96
ZXJvX25lZywgMHgwMSwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERGX3plcm8sIDB4MDIsIDApOwor
CisgICAgLyogTm9ybWFsOiBtYXNrIGJpdCAxICovCisgICAgVEVTVF9ERkNMQVNTKERGX29uZSwg
MHgwMiwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERGX25lZ19vbmUsIDB4MDIsIDEpOworICAgIFRF
U1RfREZDTEFTUyhERl9vbmUsIDB4MDEsIDApOworCisgICAgLyogRGVub3JtYWw6IG1hc2sgYml0
IDIgKi8KKyAgICBURVNUX0RGQ0xBU1MoREZfZGVub3JtLCAweDA0LCAxKTsKKyAgICBURVNUX0RG
Q0xBU1MoREZfZGVub3JtLCAweDAxLCAwKTsKKworICAgIC8qIEluZmluaXR5OiBtYXNrIGJpdCAz
ICovCisgICAgVEVTVF9ERkNMQVNTKERGX0lORiwgMHgwOCwgMSk7CisgICAgVEVTVF9ERkNMQVNT
KERGX0lORiwgMHgwMSwgMCk7CisKKyAgICAvKiBOYU46IG1hc2sgYml0IDQgKi8KKyAgICBURVNU
X0RGQ0xBU1MoREZfUU5hTiwgMHgxMCwgMSk7CisgICAgVEVTVF9ERkNMQVNTKERGX1NOYU4sIDB4
MTAsIDEpOworICAgIFRFU1RfREZDTEFTUyhERl9RTmFOLCAweDAxLCAwKTsKK30KKworLyogUmRk
ID0gY29udmVydF91dzJkZihScykgKi8KK3N0YXRpYyB1aW50NjRfdCBjb252X3V3MmRmKHVpbnQz
Ml90IHZhbCkKK3sKKyAgICB1aW50NjRfdCByZXN1bHQ7CisKKyAgICBhc20oIiVbcmVzXSA9IGNv
bnZlcnRfdXcyZGYoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihyZXN1bHQpCisg
ICAgICAgIDogW3ZhbF0gInIiKHZhbCkpOworICAgIHJldHVybiByZXN1bHQ7Cit9CisKK3N0YXRp
YyB2b2lkIGNoZWNrX2NvbnZfdXcyZGYodm9pZCkKK3sKKyAgICBjaGVjazY0KGNvbnZfdXcyZGYo
MCksIERGX3plcm8pOworICAgIGNoZWNrNjQoY29udl91dzJkZigxKSwgREZfb25lKTsKKyAgICAv
KiAxMDAgLT4gMHg0MDU5MDAwMDAwMDAwMDAwICovCisgICAgY2hlY2s2NChjb252X3V3MmRmKDEw
MCksIDB4NDA1OTAwMDAwMDAwMDAwMFVMTCk7CisgICAgLyogMHhGRkZGRkZGRiAtPiA0Mjk0OTY3
Mjk1LjAgPSAweDQxRUZGRkZGRkZFMDAwMDAgKi8KKyAgICBjaGVjazY0KGNvbnZfdXcyZGYoMHhG
RkZGRkZGRiksIDB4NDFFRkZGRkZGRkUwMDAwMFVMTCk7Cit9CisKKy8qIFJkZCA9IGNvbnZlcnRf
dWQyZGYoUnNzKSAqLworc3RhdGljIHVpbnQ2NF90IGNvbnZfdWQyZGYodWludDY0X3QgdmFsKQor
eworICAgIHVpbnQ2NF90IHJlc3VsdDsKKworICAgIGFzbSgiJVtyZXNdID0gY29udmVydF91ZDJk
ZiglW3ZhbF0pXG5cdCIKKyAgICAgICAgOiBbcmVzXSAiPXIiKHJlc3VsdCkKKyAgICAgICAgOiBb
dmFsXSAiciIodmFsKSk7CisgICAgcmV0dXJuIHJlc3VsdDsKK30KKworc3RhdGljIHZvaWQgY2hl
Y2tfY29udl91ZDJkZih2b2lkKQoreworICAgIGNoZWNrNjQoY29udl91ZDJkZigwVUxMKSwgREZf
emVybyk7CisgICAgY2hlY2s2NChjb252X3VkMmRmKDFVTEwpLCBERl9vbmUpOworICAgIC8qIDEw
MDAwMDAgLT4gMHg0MTJFODQ4MDAwMDAwMDAwICovCisgICAgY2hlY2s2NChjb252X3VkMmRmKDEw
MDAwMDBVTEwpLCAweDQxMkU4NDgwMDAwMDAwMDBVTEwpOworfQorCisvKiBSZGQgPSBkZm1weWZp
eChSc3MsUnR0KSAtLSBERiBtdWx0aXBseSBkZW5vcm1hbCBmaXh1cCAqLworc3RhdGljIHVpbnQ2
NF90IGRvX2RmbXB5Zml4KHVpbnQ2NF90IGEsIHVpbnQ2NF90IGIpCit7CisgICAgdWludDY0X3Qg
cmVzdWx0OworCisgICAgYXNtKCIlW3Jlc10gPSBkZm1weWZpeCglW2FdLCAlW2JdKVxuXHQiCisg
ICAgICAgIDogW3Jlc10gIj1yIihyZXN1bHQpCisgICAgICAgIDogW2FdICJyIihhKSwgW2JdICJy
IihiKSk7CisgICAgcmV0dXJuIHJlc3VsdDsKK30KKworc3RhdGljIHZvaWQgY2hlY2tfZGZtcHlm
aXgodm9pZCkKK3sKKyAgICAvKgorICAgICAqIFdpdGggdHdvIG5vcm1hbCB2YWx1ZXMgKG5laXRo
ZXIgZGVub3JtYWwsIGV4cHMgPCA1MTIpLAorICAgICAqIHRoZSByZXN1bHQgc2hvdWxkIGJlIHRo
ZSBmaXJzdCBvcGVyYW5kIHVuY2hhbmdlZC4KKyAgICAgKi8KKyAgICBjaGVjazY0KGRvX2RmbXB5
Zml4KERGX29uZSwgREZfb25lKSwgREZfb25lKTsKKworICAgIC8qCisgICAgICogQ2FzZTogYiBp
cyBkZW5vcm1hbCBBTkQgYSBpcyBub3JtYWwgd2l0aCBleHAgPj0gNTEyLgorICAgICAqIGEgZ2V0
cyBtdWx0aXBsaWVkIGJ5IDJeLTUyICgweDNjYjAwMDAwMDAwMDAwMDApLgorICAgICAqIGEgPSAx
LjAsIHJlc3VsdCA9IDEuMCAqIDJeLTUyID0gMHgzY2IwMDAwMDAwMDAwMDAwCisgICAgICovCisg
ICAgY2hlY2s2NChkb19kZm1weWZpeChERl9vbmUsIERGX2Rlbm9ybSksIDB4M0NCMDAwMDAwMDAw
MDAwMFVMTCk7CisKKyAgICAvKgorICAgICAqIENhc2U6IGEgaXMgZGVub3JtYWwgQU5EIGIgaXMg
bm9ybWFsIHdpdGggZXhwID49IDUxMi4KKyAgICAgKiBhIGdldHMgbXVsdGlwbGllZCBieSAyXjUy
ICgweDQzMzAwMDAwMDAwMDAwMDApLgorICAgICAqIGEgPSBzbWFsbGVzdCBkZW5vcm0gPSAyXi0x
MDc0LCBiID0gMl41MTIgKGJpYXNlZCBleHAgMHg1ZmYpLgorICAgICAqIFJlc3VsdCA9IDJeLTEw
NzQgKiAyXjUyID0gMl4tMTAyMiA9IHNtYWxsZXN0IG5vcm1hbAorICAgICAqICAgICAgICA9IDB4
MDAxMDAwMDAwMDAwMDAwMAorICAgICAqLworICAgIGNoZWNrNjQoZG9fZGZtcHlmaXgoREZfZGVu
b3JtLCAweDVGRjAwMDAwMDAwMDAwMDBVTEwpLAorICAgICAgICAgICAgMHgwMDEwMDAwMDAwMDAw
MDAwVUxMKTsKK30KKwogaW50IG1haW4oKQogewogICAgIGNoZWNrX2NvbXBhcmVfZXhjZXB0aW9u
KCk7CkBAIC03MjUsNiArODk1LDExIEBAIGludCBtYWluKCkKICAgICBjaGVja19mbG9hdDJpbnRf
Y29udnMoKTsKICAgICBjaGVja19mbG9hdF9jb25zdHMoKTsKICAgICBjaGVja19kZm1weXh4KCk7
CisgICAgY2hlY2tfc2ZjbGFzcygpOworICAgIGNoZWNrX2RmY2xhc3MoKTsKKyAgICBjaGVja19j
b252X3V3MmRmKCk7CisgICAgY2hlY2tfY29udl91ZDJkZigpOworICAgIGNoZWNrX2RmbXB5Zml4
KCk7CiAKICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/
IDEgOiAwOwotLSAKMi4zNC4xCgo=

