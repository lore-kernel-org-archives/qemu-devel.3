Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64772C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNn-0002yK-O7; Sat, 01 Mar 2025 00:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNm-0002xe-IZ
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNk-00088j-VY
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:26 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213LK7c008626
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PQk4kSw0FGE+la4vwzvIqV5TUKGVcZEG5Wn8KozgeGU=; b=jrTcsNpB67XhJjCM
 kQeeCeq3sXjS4QgZeYvPSsOamnGXCuA0hU1DQv636QSySuNg0avhffyMtV3JiSkY
 N81hovV9Z05bzbVCdddctSUtSnO7gJk4j/kq4U1p95obxwQ2FGLR6rgakXPC+q59
 tIC8vJSkMGSjMnwZnUNv+wFPRXUeiUaGAf/RFZQUtVvW0aSgsVVxqdO+0VFjfHi5
 WwWdmQ8WtysVJBxqYklTcoho+UDPp93yYmn4jtNgkTnygS2QiIc3lQCW+P0R/EiA
 go4N3qvdFmZF7IFtdpj6JD57KLtSsJbrAJ6Aj4uOYGaCM2zg1ETrdfwUma3fiEWA
 EtVhFg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r69b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2feb4648d4dso6900222a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806832; x=1741411632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQk4kSw0FGE+la4vwzvIqV5TUKGVcZEG5Wn8KozgeGU=;
 b=LJbLIyaiUfRsuJCUHGqS0pQ+L9yKdnNEdepLuBJBHT/xLuR7WrKlZwbYymFs3vOj+7
 +pM5pWb5QFt06LpbEcWVI6i0k85tpQzQV+LUhJhCyRVnlZGTKmHEwjhGosLh1TbNHvOM
 SqLY2CK/uXWJBkPcmfPIUrvz5/XFvQkNQ5JsRCUjBK5i+UAVvRe4f53ZPF5c5OxV1RkV
 t9W6xVhViRZnW0ALNTbcsQVnbK3ZPx3GOzLRoSQ7DQ6vb6hooq68+zp1SK6X83Uo0kBW
 a2HdaWfkQVMKzNH5JYutHvds56GUqT4frI+c0l9g2Yn0uS7Eb0USJgyi3VwZ1Pa+QH2i
 vP0g==
X-Gm-Message-State: AOJu0Yyh9XIGoEq2n2+CbEh3xEUTbNTcPMN/J1Q0/PY0BPobfKuwPKbs
 MfQFOcsPvuzfhxBqTZaNSg0749iYruChOm+3aINqQlSKp2ND1NuzYsppkORqJNCUnbML5S/RPFA
 53KsBB6nXbEQeZsQU/kw8jkSBq5gI/s7slVjq5KmzEM6wPIYtDUprOwwT3t3/4A==
X-Gm-Gg: ASbGncvAyD+1G8fbfZbnymMWS/UOOx/Xg920V7Ludp64s2I0Gk1FLWve2pW/xddDTZE
 RYwb0WQXGfQQB+5fbKNISmp7wvxXV3jvFZwCq68feicsvqNfJC18pAcfHLU/3FATO9dpzU0HnX2
 qIaRs7CJljX65wBeaoLgVWJPg4u8+FvumD+9Tm0Sponk+m3vFa++URFSBXuB/hvup902KNhAm17
 ybaOetDqp3xqJ6sZynBnT6hghte+YsXGguwa4SnIwzFZ3GJQtchdYx4k4gjEM0gwtGwHR60QySf
 JSCXmbXftpApjeSMV9nrUlxOU9i5tQ2/jHbGX9QQZZF2wvPf3oTwGz2pm/YJhU1A
X-Received: by 2002:a17:90b:3ec1:b0:2fe:b8b9:5aa6 with SMTP id
 98e67ed59e1d1-2febabf8b75mr9104647a91.31.1740806832443; 
 Fri, 28 Feb 2025 21:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvnbF08mdfdk2V4Mp//RssUOnk9UXjPjXXomHLMPaOcxouhui3AtyfGVgfDIkXKSXOwEPI4A==
X-Received: by 2002:a17:90b:3ec1:b0:2fe:b8b9:5aa6 with SMTP id
 98e67ed59e1d1-2febabf8b75mr9104625a91.31.1740806832056; 
 Fri, 28 Feb 2025 21:27:12 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:11 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 19/38] target/hexagon: Define register fields for system regs
Date: Fri, 28 Feb 2025 21:26:09 -0800
Message-Id: <20250301052628.1011210-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: sYEqtrg81J_i1S0gNwqSYQGdhp5hWmET
X-Proofpoint-GUID: sYEqtrg81J_i1S0gNwqSYQGdhp5hWmET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=833 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
aW1hc2ssIGlwZW5kYWQuCgpEZWZpbmUgdGhlIGZpZWxkcyBmb3IgVExCIGVudHJpZXMuCgpTaWdu
ZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQog
dGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgfCA5NiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyBiL3RhcmdldC9oZXhhZ29u
L3JlZ19maWVsZHNfZGVmLmguaW5jCmluZGV4IGYyYTU4ZDQ4NmMuLjE1NmEzNTE0ZTcgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0zOSwzICszOSw5OSBAQCBERUZfUkVHX0ZJ
RUxEKFVTUl9GUERCWkUsICAgICAgICAyNiwgMSkKIERFRl9SRUdfRklFTEQoVVNSX0ZQT1ZGRSwg
ICAgICAgIDI3LCAxKQogREVGX1JFR19GSUVMRChVU1JfRlBVTkZFLCAgICAgICAgMjgsIDEpCiBE
RUZfUkVHX0ZJRUxEKFVTUl9GUElOUEUsICAgICAgICAyOSwgMSkKKworREVGX1JFR19GSUVMRChJ
UEVOREFEX0lBRCwgMTYsIDE2KQorREVGX1JFR19GSUVMRChJUEVOREFEX0lQRU5ELCAwLCAxNikK
KworREVGX1JFR19GSUVMRChTQ0hFRENGR19FTiwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU0NIRURD
RkdfSU5UTk8sIDAsIDQpCitERUZfUkVHX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIDAsIDEwKQorCisK
Ky8qIFBURSAoYWthIFRMQiBlbnRyeSkgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKFBURV9QUEQs
IDAsIDI0KQorREVGX1JFR19GSUVMRChQVEVfQywgMjQsIDQpCitERUZfUkVHX0ZJRUxEKFBURV9V
LCAyOCwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX1IsIDI5LCAxKQorREVGX1JFR19GSUVMRChQVEVf
VywgMzAsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9YLCAzMSwgMSkKK0RFRl9SRUdfRklFTEQoUFRF
X1ZQTiwgMzIsIDIwKQorREVGX1JFR19GSUVMRChQVEVfQVNJRCwgNTIsIDcpCitERUZfUkVHX0ZJ
RUxEKFBURV9BVFIwLCA1OSwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX0FUUjEsIDYwLCAxKQorREVG
X1JFR19GSUVMRChQVEVfUEEzNSwgNjEsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9HLCA2MiwgMSkK
K0RFRl9SRUdfRklFTEQoUFRFX1YsIDYzLCAxKQorCisvKiBTWVNDRkcgZmllbGRzICovCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19NTVVFTiwgMCwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0lDRU4s
IDEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19EQ0VOLCAyLCAxKQorREVGX1JFR19GSUVMRChT
WVNDRkdfSVNEQlRSVVNURUQsIDMsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19HSUUsIDQsIDEp
CitERUZfUkVHX0ZJRUxEKFNZU0NGR19JU0RCUkVBRFksIDUsIDEpCitERUZfUkVHX0ZJRUxEKFNZ
U0NGR19QQ1lDTEVFTiwgNiwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX1YyWCwgNywgMSkKK0RF
Rl9SRUdfRklFTEQoU1lTQ0ZHX0lHTk9SRURBQk9SVCwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU1lT
Q0ZHX1BNLCA5LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfVExCTE9DSywgMTEsIDEpCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19LMExPQ0ssIDEyLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfQlEs
IDEzLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfUFJJTywgMTQsIDEpCitERUZfUkVHX0ZJRUxE
KFNZU0NGR19ETVQsIDE1LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJDRkcsIDE2LCAzKQor
REVGX1JFR19GSUVMRChTWVNDRkdfSVRDTSwgMTksIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19M
Mk5XQSwgMjEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMk5SQSwgMjIsIDEpCitERUZfUkVH
X0ZJRUxEKFNZU0NGR19MMldCLCAyMywgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyUCwgMjQs
IDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19TTFZDVEwwLCAyNSwgMikKK0RFRl9SRUdfRklFTEQo
U1lTQ0ZHX1NMVkNUTDEsIDI3LCAyKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJQQVJUU0laRSwg
MjksIDIpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMkdDQSwgMzEsIDEpCisKKy8qIFNTUiBmaWVs
ZHMgKi8KK0RFRl9SRUdfRklFTEQoU1NSX0NBVVNFLCAwLCA4KQorREVGX1JFR19GSUVMRChTU1Jf
QVNJRCwgOCwgNykKK0RFRl9SRUdfRklFTEQoU1NSX1VNLCAxNiwgMSkKK0RFRl9SRUdfRklFTEQo
U1NSX0VYLCAxNywgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0lFLCAxOCwgMSkKK0RFRl9SRUdfRklF
TEQoU1NSX0dNLCAxOSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1YwLCAyMCwgMSkKK0RFRl9SRUdf
RklFTEQoU1NSX1YxLCAyMSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0JWUywgMjIsIDEpCitERUZf
UkVHX0ZJRUxEKFNTUl9DRSwgMjMsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9QRSwgMjQsIDEpCitE
RUZfUkVHX0ZJRUxEKFNTUl9CUCwgMjUsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9YRTIsIDI2LCAx
KQorREVGX1JFR19GSUVMRChTU1JfWEEsIDI3LCAzKQorREVGX1JFR19GSUVMRChTU1JfU1MsIDMw
LCAxKQorREVGX1JFR19GSUVMRChTU1JfWEUsIDMxLCAxKQorCisvKiBtaXNjIHJlZ2lzdGVycyAq
LworREVGX1JFR19GSUVMRChJTUFTS19NQVNLLCAwLCAxNikKKworREVGX1JFR19GSUVMRChTVElE
X1BSSU8sIDE2LCA4KQorREVGX1JFR19GSUVMRChTVElEX1NUSUQsIDAsIDgpCisKKy8qIE1PREVD
VEwgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKE1PREVDVExfRSwgMCwgOCkKK0RFRl9SRUdfRklF
TEQoTU9ERUNUTF9XLCAxNiwgOCkKKworREVGX1JFR19GSUVMRChDQ1JfTDFJQ1AsIDAsIDIpCitE
RUZfUkVHX0ZJRUxEKENDUl9MMURDUCwgMywgMikKK0RFRl9SRUdfRklFTEQoQ0NSX0wyQ1AsIDYs
IDIpCisKK0RFRl9SRUdfRklFTEQoQ0NSX0hGSSwgMTYsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9I
RkQsIDE3LCAxKQorREVGX1JFR19GSUVMRChDQ1JfSEZJTDIsIDE4LCAxKQorREVGX1JFR19GSUVM
RChDQ1JfSEZETDIsIDE5LCAxKQorREVGX1JFR19GSUVMRChDQ1JfU0ZELCAyMCwgMSkKKworREVG
X1JFR19GSUVMRChDQ1JfR0lFLCAyNCwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX0dURSwgMjUsIDEp
CitERUZfUkVHX0ZJRUxEKENDUl9HRUUsIDI2LCAxKQorREVGX1JFR19GSUVMRChDQ1JfR1JFLCAy
NywgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX1ZWMSwgMjksIDEpCitERUZfUkVHX0ZJRUxEKENDUl9W
VjIsIDMwLCAxKQorREVGX1JFR19GSUVMRChDQ1JfVlYzLCAzMSwgMSkKLS0gCjIuMzQuMQoK

