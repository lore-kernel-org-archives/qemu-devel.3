Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC68AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCHr-0003o0-Q4; Mon, 29 Jun 2026 09:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHG-0003ck-K8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHE-0006Cf-Gw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATTWL2579629
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=; b=n9e75UZZnYQRFDew
 T8PhF4Ag6FOk01KF3RKiOhpZSgpMsvrpR4dGoFRSHrm7o2Zh26JcSJ7YTzIiX62i
 5NVzoFD603wR8rpHSa+SZOWwfolMZwdRfhODGNTbP9X1Szi2K1OP2aYxexS9n6uR
 7LkdfVYyktpzyVjiBQdb4N20RHLCYnjMcQ19o02alHBFpeAG6Yd7EXh6kUaWFJto
 oC9D0nivWhpVfaTD0j6UsS5q5Hz/55pfJmkHfLEaZUVdthQLphdDPGps2rcBPWDL
 nF7/oC/WM3mpzsiLytKXwmOd0hhjyU6TXE0aazWPUOcWUoWqMelnfUXaBVKo5uiT
 WSzX7A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hkrp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c892143db7fso1523018a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740633; x=1783345433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=WzT2t0zk9GoMZk7zZ4F6R5CCHkGWnZQftzQYPY82z/TnipQPQZoTwIfxmnw1GcEjn/
 cHC+WWasNrEJwvwZP6NkxzjVlBQMO/Q+zgdyFJWm8xCFznz5/ZnwyMPEnntmnhIQRI64
 aE4/9YHc+TmgkJmOfgwbHphZabflxXrwxqb1TVLXo2a156XQj0keBMu1iLnNbUOmDtqw
 wjkyNfYINXBqjP+ipl2M4wk11tLI4PFwdqau40fGrxV/ChjiUW5NMiL+SzM3WQjYUCax
 HsjiSF3bRV0oQGsnIZY5BIcAsk1x3T8dRNbDniUMrXpRNUilCAiNpMLj218i9rjRgXRs
 3cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740633; x=1783345433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbuzJ7YCQZGqOoiI5HAt63RuanuV51wqRpzkdURFyKo=;
 b=EXmiXSnNkS5HXsJsqW6Lzamgw2zOXrIyk3m5CKCcAygUkreKuqvx+lc+HVJO7ahg8c
 sZpxtkabp5gnZg1fx3MhGKkytKKD0K+VkdZbQQ7dBArNfPWMspLn7x2jl7tpt9XAe+YP
 g79Cx20OiazefzXRB8c09RdVUfyAHlOVsJfZkhrLqO88Simd4QOt5z1PCXBNAo2aKnep
 MkDrHlP1V8M64C+l//eZGUI59zBvHrn1tHdpC974qYn9fguqd7SPjddioMWoJlfs7VNA
 K7oEmyYeyqoWxgU6jek2i+Q9J67jly0n69B9aeXRWPx36HyIqWrdYvfwWMkii2Q+haaS
 s7+Q==
X-Gm-Message-State: AOJu0Yz1qpGXM2CZlNQ6RZHEBdVH3gZGDaN1B8f57UedZIUqUw5npL4w
 5Y+BANSnAsnLHJIJcKBM6byNcGFcNRpUzTbnWIjNAvQ2b3kAdDkiYjTdojqy3rzxF73anhRt/Qr
 q84gi/T3+B6FtvsXD0QhffrlUysqkS4eS+Z9YUTumpq4h4fzw1vD6zuUXcxyGZvcVBQ==
X-Gm-Gg: AfdE7ckrYpFjNKFOvVA16RT+tL7vLO/RYFtMg+MaZrlkM2tkI57dfomTMICXJoLD8bS
 OOVAYV+W1a8ZHRt0/ymRVMRmUuhr9iUUIi3UPqy92NlzbMwYg7tA5SosATeA+kvyNJAYzMNykje
 6CVCS9YbbGuDIgQcWOzqjtTQQHDUM/DOW3xNH5lybI0gdCVX841ku/uFe5n9edVE6M4s6ny2Gb3
 qlPSKP6XdfGwvsr/JZHgNm3g6UELuJoBhXxIO1i0NscmIRO9DYNVVzc7nMaRKNbWnx8nEiT/Ob/
 oqjtRzPW1KckhXEYN8VPfgRm6XmDxGTw1xC1tNtNHgjxtN1oaUPPTQhvhN/r44T/MeGleKJX2eZ
 b8EGjL9JUw1Q5aSEri7BSjXhCiFegQ/7OP2itqkop1gGI0vBxnvCpCmIDMxM=
X-Received: by 2002:a17:902:f607:b0:2c0:a9b3:bdc6 with SMTP id
 d9443c01a7336-2c7fca37f6fmr156974495ad.30.1782740633138; 
 Mon, 29 Jun 2026 06:43:53 -0700 (PDT)
X-Received: by 2002:a17:902:f607:b0:2c0:a9b3:bdc6 with SMTP id
 d9443c01a7336-2c7fca37f6fmr156974125ad.30.1782740632655; 
 Mon, 29 Jun 2026 06:43:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 46/77] target/hexagon: Implement get_exe_mode()
Date: Mon, 29 Jun 2026 06:12:01 -0700
Message-Id: <20260629131232.2487780-47-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX2oHQu9UPeQUv
 YrpF9ZMT3Hi+i23scon6Bl6/NULfvcqlBPJBN8GyYbn3+b+7c5in6tIJzRjOWZvmYL1cRGWyrD0
 q1rWukbTYfJxTZ6SMba2DYv4jMfsrZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX7OYzDcwi9ndu
 Z4VY0aGSdw3bQjShgwHv+yxN6moMQruo/+DOp2KGO7jgVL+u/jjm20LYuESWet4pNtEVrbZ5XN4
 XbpRa+9np4EdQtGUalantVf5slMA+IovQr6JlsC20qTgOtcQ6zWdXJuO/I7fBKgTFck/N5meEDt
 dWb2fo5iMpjbdGSU+zfVTBV5FVEGfpz8k8p1Z6XCDiuTXq1X1+mCHwSd5bnvIB9AZJeqeZzbBxd
 A19k3+E52kzeb47xUugVT3DZmID6vyvpfMf+Hk4eFd7479++f1gc7pkR7OWhb3YD2vbYIma5QoS
 AUKnZ5liLS1Ye6ULe4jD2KbtM9KzAC4khmX7fH2g+R+VhfouVFc7qXxZ2dAUvRCzAqoeeXi6i//
 xgFfxnw1gL0wSKSM6q+yzZ6vXajZ355FqPa7lorzcg1sB5DkwjgWb8wH05gCQyEZEKGyTRBJQIu
 r7WHldJJueexuNcy2kw==
X-Proofpoint-ORIG-GUID: X-vDdqk-FoqM_iyQtcP4CpN5gyylbBWH
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a427699 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4_WtjC8beq4VSFaiBQMA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: X-vDdqk-FoqM_iyQtcP4CpN5gyylbBWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Jl
Z19maWVsZHNfZGVmLmguaW5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYu
aC5pbmMgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwppbmRleCA5YjExMmNj
ZWM2NC4uZDJjNzA2ZDU2YjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNf
ZGVmLmguaW5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jCkBAIC0x
MzUsMyArMTM1LDE0IEBAIERFRl9SRUdfRklFTEQoQ0NSX0dSRSwgMjcsIDEpCiBERUZfUkVHX0ZJ
RUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYyLCAzMCwgMSkKIERFRl9S
RUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCisKKy8qIElTREIgU1QgZmllbGRzICovCitERUZfUkVH
X0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX09OT0ZG
LCAxNiwgOCkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX0RFQlVHTU9ERSwgOCwgOCkKK0RFRl9SRUdf
RklFTEQoSVNEQlNUX1NUVUZGU1RBVFVTLCA1LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfQ01E
U1RBVFVTLCA0LCAxKQorREVGX1JFR19GSUVMRChJU0RCU1RfUFJPQ01PREUsIDMsIDEpCitERUZf
UkVHX0ZJRUxEKElTREJTVF9NQlhJTlNUQVRVUywgMiwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNU
X01CWE9VVFNUQVRVUywgMSwgMSkKK0RFRl9SRUdfRklFTEQoSVNEQlNUX1JFQURZLCAwLCAxKQot
LSAKMi4zNC4xCgo=

